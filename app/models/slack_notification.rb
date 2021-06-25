class SlackNotification

  WEBHOOK_URL = ENV['SLACK_WEBHOOK_URL']

  def send(msg)
    Slack::Notifier.new(WEBHOOK_URL).ping(msg)
  end
end