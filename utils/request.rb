class Request
  attr_reader :response, :pretty_body, :parsed_body

  def initialize(faraday_args = {})
    @faraday_args = faraday_args
    @response = faraday_call
    parse_body unless failed?
  end

  def payload
    @faraday_args
  end

  def failed?
    response.nil?
  end

  def http_method
    @faraday_args[:http_method]
  end

  def url
    @faraday_args[:url]
  end

  def content_type
    response.headers['content-type']
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
      @parsed_body = JSON.parse(body)
      @pretty_body = JSON.pretty_generate(@parsed_body)
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
    status = "#{response.status} #{response.reason_phrase}"
    response.success? ? status.green : status.red
  end

  def params
    value = @faraday_args[:params]
    return value if value.instance_of?(String)

    JSON.generate(value)
  end

  private

  def faraday_call
    Faraday.run_request(http_method.downcase, url, params, @faraday_args[:headers])
  rescue
    puts 'Faraday requisition failed'.red
  end
end
