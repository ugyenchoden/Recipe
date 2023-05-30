# frozen_string_literal: true

class ContentDeliveryMailer < ApplicationMailer
  def notify_sync_failure(status, message)
    @status = status
    @message = message

    mail(
      to: ENV.fetch('MAINTENANCE_EMAIL', nil),
      subject: I18n.t('mailers.content_delivery.subject')
    )
  end
end
