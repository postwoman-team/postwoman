module Loaders
  class Average < Loaders::Builtin::Base
    private

    def http_method = :POST

    def url = 'https://www.mysite.com/'

    def params = {
      my_param: true,
      array: [
        {
          something: true
        }
      ]
    }

    def headers = {
      token: 'ANfikwnfkwnsiWIkfnwi2',
      auth: 'Basic somethingsomethingimatoken'
    }
  end
end
