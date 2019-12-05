# frozen_string_literal: true

module IncomingEmailInteractors
  class ConvertToJSON
    include Interactor

    delegate :text, to: :context

    def call
      cleaned_text =
        context.parsed_text.each_with_object({}) do |(keyword, text), hash|
          hash[keyword] = join text
        end

      context.json = cleaned_text.to_json
    end

    private

    def join(text)
      text.join(', ').gsub(/,{2,}/, ',')
    end
  end
end
