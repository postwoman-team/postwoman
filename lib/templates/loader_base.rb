module Loaders
  class Base < PostwomanLoader
    trait :default,
          default_headers: { 'content-type': 'application/json' }
  end
end
