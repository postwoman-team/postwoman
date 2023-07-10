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
      default_headers
    end
  end
end
