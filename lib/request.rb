class Request
  attr_reader :response, :pretty_body, :parsed_body

  def initialize(faraday_args = {})
    @faraday_args = faraday_args
    @failed = false
  end

  def execute
    @response = faraday_call
    parse_body unless failed?
  end

  def payload
    @faraday_args
  end

  def failed?
    @failed
  end

  def http_method
    @faraday_args[:http_method]
  end

  def url
    @faraday_args[:url]
  end

  def content_type
    @content_type ||= response.headers.find do |k, _v|
      k.downcase == 'content-type'
    end&.[](1)
  end

  def response_query(selector, query)
    if %w[css xpath].include?(selector)
      return unless response_actual_xml? || response_actual_html?

      results = selector == 'css' ? parsed_body.css(query) : parsed_body.xpath(query)

      return if results.empty?

      return results[0].text
    end

    if selector == 'jsonpath'
      return unless response_actual_json?

      json_path = JsonPath.new(query)
      results = json_path.on(parsed_body)

      return if results.empty?

      return results[0]
    end

    puts 'ai n'
  end

  def response_actual_json?
    parsed_body.is_a?(Hash)
  end

  def response_actual_html?
    parsed_body.is_a?(Nokogiri::HTML::Document)
  end

  def response_actual_xml?
    parsed_body.is_a?(Nokogiri::XML::Document)
  end

  def response_json?
    content_type.downcase.include?('json')
  end

  def response_html?
    content_type.downcase.include?('html')
  end

  def response_xml?
    content_type.downcase.include?('xml')
  end

  def parse_body
    @parsed_body = body
    @pretty_body = body

    if response_json?
      @parsed_body = JSON.parse(body.empty? ? '{}' : body) rescue JSON::ParserError # rubocop:disable Style/RescueModifier
      @pretty_body = JSON.pretty_generate(@parsed_body) unless @parsed_body.empty?
    elsif response_html?
      @parsed_body = Nokogiri::HTML(body)
      @pretty_body = @parsed_body.to_html(encoding: 'utf-8') unless @parsed_body.errors.any?
    elsif response_xml?
      @parsed_body = Nokogiri::XML(body)
      @pretty_body = @parsed_body.to_xml(encoding: 'utf-8') unless @parsed_body.errors.any?
    end
  end

  def headers
    response.headers
  end

  def body
    response.body
  end

  def pretty_status
    "#{response.status} #{response.reason_phrase}"
  end

  def params
    @faraday_args[:params]
  end

  private

  def faraday_call
    Faraday.run_request(http_method.downcase, url, params, @faraday_args[:headers])
  rescue Exception => e
    puts 'Faraday requisition failed:'.red
    puts Views::Error.show(e)
    @failed = true
  end
end
