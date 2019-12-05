# frozen_string_literal: true

body = <<~_END_OF_TEXT_
  Aliqua graviterque singulis export aliquip, duis pariatur ab aliqua tamen,
  senserit nulla aliqua non elit, aut velit ne fugiat, mandaremus quis nam aliquip
  transferrem ad excepteur ex culpa eiusmod a illum illustriora officia quae
  eiusmod, dolor fidelissimae admodum malis voluptate.

  Brokerage
  Marx Brothers

  First name: Jane
  Last name: Doe
  Email address: janedoe@doe.com

  Birthday:
  June 1, 1964

  Favorite food:
  Pizza

  I want:  Excepteur in aliqua laborum. Nostrud de quis. Ita aliqua ea irure est ex aute cernantur
  sempiternum. Fabulas hic nisi expetendis, proident concursionibus o appellat ubi
  multos possumus consectetur qui fugiat appellat id expetendis.

  Comment:
  Ab laborum voluptatibus iis an malis fabulas familiaritatem aut dolore
  exercitation officia illum mandaremus, legam ad iudicem. Nam aliqua eram qui
  offendit nam dolore voluptate ita tractavissent sed nam iudicem arbitrantur sed
  nulla senserit ex distinguantur.
_END_OF_TEXT_

html = <<~_END_OF_HTML_
  <body aria-readonly="false" style="font-family:Arial, Helvetica, sans-serif;font-size: 12px">
  <a href="http://www.yahoo.com">Yahoo</a>

  <table border="1" cellpadding="1" cellspacing="1" style="width:500px;">
      <tbody>
          <tr>
              <td>
              <table border="1" cellpadding="1" cellspacing="1" style="width:500px;">
                  <tbody>
                      <tr>
                          <td>First Name</td>

                          <td>Mark</td>
                      </tr>
                      <tr>
                          <td>Last Name</td>
                          <td>Stepp</td>
                      </tr>
                      <tr>
                          <td>Address</td>
                          <td>123 S Main Street,<br />

                          Bolivar, MO 65613</td>
                      </tr>
                      <tr>
                          <td>Mobile Phone</td>
                          <td>(417) 298-1173</td>
                      </tr>
                      <tr>
                        <td>Email:  mark@realvolve.com <mailto:mark@realvolve.com></td>
                      </tr>
                      <tr>
                          <td>Email Address</td>
                          <td>mark@realvolve.com</td>
                      </tr>
                      <tr>
                          <td>Buy/Sell</td>
                          <td>Both</td>
                      </tr>
                      <tr>
                          <td>Price Range</td>
                          <td>240000-260000</td>
                      </tr>
                      <tr>
                          <td>Notes</td>
                          <td>This is just a sample set of fields that could come in via an HTML body which needs to be parsed and could have lots of information in a table.</td>
                      </tr>
                  </tbody>
              </table>
              <p>&nbsp;</p>
              </td>
          </tr>
      </tbody>
  </table>
  <p>&nbsp;</p>
  </body>
_END_OF_HTML_

class TextParser
  include ActionView::Helpers::SanitizeHelper

  COLON_REGEX = %r{(?<!http):(?!//)}

  def initialize(*text, keywords: [])
    @keywords = Array(keywords)

    @text =
      Array(text)
      .flat_map { |line| line.split("\n") }
      .map { |line| sanitize(line, tags: []) }
  end

  def parse
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

words = [
  'address',
  'buy/sell',
  'email address',
  'first name',
  'last name',
  'price range',
  'notes',
  'mobile phone'
]

ap TextParser.new(html, keywords: words).parse
