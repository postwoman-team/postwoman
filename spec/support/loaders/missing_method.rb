module Loaders
  class MissingMethod < PostwomanLoader
    private

    def http_method
      :POST
    end

    def url
      'https://www.mysite.com/'
    end

    def params
      {
        my_param: not_a_value,
        array: [
          {
            something: true
          }
        ]
      }
    end

    def headers
      {
        token: 'ANfikwnfkwnsiWIkfnwi2',
        auth: 'Basic somethingsomethingimatoken'
      }
    end
  end
end
