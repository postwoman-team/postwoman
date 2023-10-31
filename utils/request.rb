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
    @content_type ||= response.headers.find do |k, v|
      k.downcase == 'content-type'
    end&.[](1)
  end

  def response_json?
    content_type =~ /json/
  end

  def response_xml?
    content_type =~ /html|xml/
  end

  def parse_body
    case content_type
    when /html|xml/
      @parsed_body = Nokogiri::XML(body, &:noblanks)
      @pretty_body = @parsed_body.to_xhtml(encoding: 'utf-8')
    when /json/
      @parsed_body = JSON.parse(body.empty? ? '{}' : body)
      @pretty_body = @parsed_body.empty? ? '' : JSON.pretty_generate(@parsed_body)
    else
      @parsed_body = body
      @pretty_body = body
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
    value = @faraday_args[:params]
    return value if value.instance_of?(String)

    JSON.generate(value)
  end

  private

  def faraday_call
    Faraday.run_request(http_method.downcase, url, params, @faraday_args[:headers])
  rescue Exception => e
    puts 'Faraday requisition failed:'.red
    puts e.full_message
    @failed = true
  end
end
