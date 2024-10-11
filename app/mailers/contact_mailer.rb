class ContactMailer < ApplicationMailer
  def send_mail(contact)
    @contact = contact
    mail to:   ENV.fetch('EMAIL_ADDRESS', nil), subject: '【お問い合わせ】'
  end
end
