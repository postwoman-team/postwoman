module Views
  module_function

  def request(args, request)
    str = ''

    unless args.flag?(:no_loader_payload)
      str << '<box><h2>'
      str << I18n.t('request.loader_arguments')
      str << '</h2></box>'
      str << '<box>'
      str << Style.protect(JSON.pretty_generate(request.payload))
      str << '</box>'
      return if request.failed?
    end

    if args.flag?(:no_headers)
      str << '<box><disabled>'
      str << I18n.t('request.headers')
      str << " (#{I18n.t('common.hidden')})"
      str << '</disabled></box>'
    else
      str << '<box><h2>'
      str << I18n.t('request.headers')
      str << '</h2></box>'
      str << Style.table(request.headers)
    end

    if args.flag?(:no_body)
      str << '<box><disabled>'
      str << I18n.t('request.body')
      str << " - #{request.content_type}" if request.content_type
      str << " (#{I18n.t('common.hidden')})"
      str << '</disabled></box>'
    else
      str << '<box><h2>'
      str << I18n.t('request.body')
      str << " - <highlight>#{request.content_type}</highlight>" if request.content_type
      str << '</h2></box>'
      str << '↓Empty<br>' if request.pretty_body.empty?
      str << '<box>'
      str << Style.protect(request.pretty_body)
      str << '</box>'
    end

    status_tag = request.response.success? ? 'success' : 'fail'
    status = Style.apply("<#{status_tag}>Status: #{request.pretty_status}</#{status_tag}>")

    str << Style.table([[status, request.url.to_s]])
    Style.apply(str)
  end
end
