# frozen_string_literal: true

require 'rails_helper'

module IncomingEmailInteractors
  RSpec.describe ParseText do
    def read(filename)
      path = Rails.root.join(*(%w[spec support files] + [filename]))
      File.readlines(path).join
    end

    subject(:context) { described_class.call(keywords: keywords, text: text) }

    context 'when the sample file is HTML' do
      let(:keywords) do
        [
          'address',
          'buy/sell',
          'email',
          'email address',
          'first name',
          'last name',
          'mobile phone',
          'notes',
          'price range'
        ]
      end

      let(:text) { read 'html_sample.txt' }

      it 'returns a hash { keyword: [lines] }' do
        expect(context.parsed_text.keys.map(&:downcase)).to match_array(keywords)
      end
    end

    context 'when the sample file is text' do
      let(:keywords) do
        [
          'birthday',
          'comment',
          'email address',
          'favorite food',
          'first name',
          'i want',
          'last name'
        ]
      end

      let(:text) { read 'text_sample.txt' }

      it 'returns a hash { keyword: [lines] }' do
        expect(context.parsed_text.keys.map(&:downcase)).to match_array(keywords)
      end
    end
  end
end
