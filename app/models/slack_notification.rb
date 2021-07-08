class SlackNotification

  WEBHOOK_URL = ENV['SLACK_WEBHOOK_URL']
  ERROR_CHANNEL = "#doikomeshi-errors"

  def send(msg)
    notification = Slack::Notifier.new(WEBHOOK_URL)
    attachments = {
      text: msg,
      color: "good"
    }
    notification.post text: "😊どいこメシに課金されました", attachments: [attachments]
  end

  def send_error(msg)
    notification = Slack::Notifier.new(WEBHOOK_URL, channel: ERROR_CHANNEL)
    error_attachments = {
      text: msg,
      color: "bad"
    }
    notification.post text: "😂エラーが発生しました", attachments: [error_attachments]
  end
end