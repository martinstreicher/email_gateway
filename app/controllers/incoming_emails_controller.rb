# frozen_string_literal: true

class IncomingEmailsController < ApplicationController
  protect_from_forgery with: :null_session

  before_action :authenticate_cloudmailin, only: [:create]

  def create
    head :ok
  end

  protected

  def authenticate_cloudmailin
    auth =
      authenticate_with_http_basic do |username, password|
        username == 'cloudmailin' && password == (ENV['password'] || 'password')
      end

    return true if auth

    render plain: 'Invalid Cloudmailing credentials', status: :unauthorized
  end
end
