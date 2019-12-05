# frozen_string_literal: true

module IncomingEmailInteractors
  class Transmit
    include Interactor

    delegate :json, :user, to: :context

    def call; end
  end
end
