# frozen_string_literal: true

class TextParser
  include ActionView::Helpers::SanitizeHelper

  COLON_REGEX = %r{(?<!http):(?!//)}.freeze

  def initialize(*text, keywords: [])
    @keywords = Array(keywords)

    @text =
      Array(text)
      .flat_map { |line| line.split("\n") }
      .map { |line| sanitize(line, tags: []) }
  end

  def parse # rubocop:disable Metrics/AbcSize
    modified_key = nil

    parsed =
      text.reject(&:blank?).each_with_object({}) do |line, paragraphs|
        results = match(line)

        if results.presence
          (key, contents) = results
          modified_key = key.strip
          paragraphs[modified_key] ||= []
          paragraphs[modified_key].push(contents.strip) if contents.present?
          next
        end

        next unless modified_key

        paragraphs[modified_key].push line.strip
      end

    parsed.each_with_object({}) do |(keyword, lines), result|
      result[keyword] = lines.reject(&:blank?)
    end
  end

  private

  def match(line)
    return line.split(/:\s*/) if line.match?(COLON_REGEX)

    regexen =
      keywords
      .map { |keyword| keyword.gsub('/', '\/') }
      .map { |keyword| keyword.gsub(' ', '\\s+') }
      .map { |keyword| "\\A\\s*#{keyword}" }

    regex =
      regexen.detect do |pattern|
        line.match?(/#{pattern}/i)
      end

    regex ? line.split(regex) : nil
  end

  attr_reader :keywords, :text
end
