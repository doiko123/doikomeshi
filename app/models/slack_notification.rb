class SlackNotification

  WEBHOOK_URL = ENV['SLACK_WEBHOOK_URL']

  def send(message)
    Slack::Notifier.new(WEBHOOK_URL).ping(message)
  end
end