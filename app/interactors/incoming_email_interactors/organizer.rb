# frozen_string_literal: true

module IncomingEmailInteractors
  class Organizer
    include Interactor::Organizer

    context.user = 'Joe'
    organize ParseText, ConvertToJSON, Transmit
  end
end
