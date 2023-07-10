module Loaders
  class Base < Builtin::Base
    trait :default,
    default_headers: { 'content-type': 'application/json' }
  end
end
