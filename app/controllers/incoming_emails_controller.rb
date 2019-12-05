# frozen_string_literal: true

class IncomingEmailsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]
  before_action :authenticate_cloudmailin_request, only: [:create]

  def create
    result =
      IncomingEmailInteractors::Organizer.call(
        text: text,
        user: user
      )

    head(result.success? ? :ok : :unprocessable_entity)
  end

  protected

  def authenticate_cloudmailin_request
    return true if basic_auth_valid?

    render plain: 'Invalid Cloudmailing credentials', status: :unauthorized
  end

  def basic_auth_valid?
    authenticate_with_http_basic do |username, password|
      username == 'cloudmailin' && password == (ENV['password'] || 'password')
    end
  end
end
