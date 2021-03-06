class SlackNotification

  WEBHOOK_URL = ENV['SLACK_WEBHOOK_URL']
  ERROR_CHANNEL = "#doikomeshi-errors"

  def send(msg)
    notification = Slack::Notifier.new(WEBHOOK_URL)
    attachments = {
      text: msg,
      color: "good"
    }
    notification.post text: "πγ©γγγ‘γ·γ«θͺ²ιγγγΎγγ", attachments: [attachments]
  end

  def send_error(msg)
    notification = Slack::Notifier.new(WEBHOOK_URL, channel: ERROR_CHANNEL)
    error_attachments = {
      text: msg,
      color: "bad"
    }
    notification.post text: "πγ¨γ©γΌγηΊηγγΎγγ", attachments: [error_attachments]
  end
end