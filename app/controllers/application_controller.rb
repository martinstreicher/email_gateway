# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Memery

  protect_from_forgery with: :null_session
end
