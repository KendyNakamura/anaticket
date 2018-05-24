class NotificationMailer < ApplicationMailer
  default from: 'hogehoge@example.com'

  def send_confirm_to_user(event)
    @event = event
    mail(
      subject: 'イベント登録が完了しました。',
      to: @event.user.email, &:html
    )
  end

  def send_confirm_to_bank(user)
    @user = user
    mail(
      subject: '振り込み依頼が完了しました。',
      to: @user.email, &:html
    )
  end

  def send_receive_to_bank(user)
    @user = user
    mail(
      subject: '振り込み依頼です。',
      to: 'kenji.nkmr.1117@gmail.com', &:html
    )
  end

  def send_test
    mail(
      subject: 'テストメール。',
      to: 'kenji.nkmr.1117@gmail.com', &:html
    )
  end
end
