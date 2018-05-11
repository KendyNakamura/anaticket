class NotificationMailer < ApplicationMailer
  default from: 'hogehoge@example.com'

  def send_confirm_to_user(event)
    @event = event
    mail(
      subject: 'イベント登録が完了しました。',
      to: @event.user.email, &:html
    )
  end
end
