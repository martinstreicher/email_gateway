# frozen_string_literal: true

module IncomingEmailInteractors
  class ParseText
    include Interactor

    delegate :keywords, :text, :user, to: :context

    def call
      context.parsed_text = TextParser.new(text, keywords: Array(keywords)).parse
    end
  end
end
