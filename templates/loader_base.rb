module Loaders
  class Base < Builtin::Base
    trait :default,
          json_headers: { 'content-type': 'application/json' }
  end
end
