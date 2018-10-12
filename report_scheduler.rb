require 'sidekiq'
require 'sidekiq-scheduler'

class ReportScheduler
  include Sidekiq::Worker

  def perform
    notifier = RocketChat::Notifier.new(webhook_url, channel: channel, username: username)
    # notifier.ping('Отправить отчёт', icon_emoji: ':ghost:')
    notifier.ping('тест', icon_emoji: ':ghost:')
  end

  private

  def webhook_url
    'https://rocket.etpgpb.ru/hooks/oNapfJ8NEogaiwMsB/jXbapvmhz8YjzBaJi3GASnb5cvpTC3CmFheEPw5HkWi2ugwE'
  end

  def channel
    'finsup_notifications_test'
  end

  def username
    'scheduler'
  end
end
