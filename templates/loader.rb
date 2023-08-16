module Loaders
  class DoNotChangeThisClassName < Base
    private

    def http_method
      :GET
    end

    def url
      ''
    end

    def params
      {}
    end

    def headers
      json_headers
    end
  end
end
