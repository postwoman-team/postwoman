module Loaders
  class DefaultTraitChildBaseLoader < Loaders::Builtin::Base
    trait :default,
          my_param: 'default value'
  end

  class DefaultTraitLoaderChild < Loaders::DefaultTraitChildBaseLoader
    trait :default,
          my_param: 'default value child'

    private

    def http_method
      :POST
    end

    def url
      'https://www.mysite.com/'
    end

    def params
      {
        my_param: true,
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
