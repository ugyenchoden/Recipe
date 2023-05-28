# frozen_string_literal: true

class ApplicationService
  def client
    @_client ||= ContentDelivery::ApiClient.default
  end
end
