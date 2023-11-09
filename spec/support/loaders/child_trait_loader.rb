module Loaders
  class ChildTraitLoader < Loaders::Builtin::Base
    trait :default,
          child_default_only: '[child default]>[nowhere] REACHED',
          child_default_will_change_on_child_my_trait: '[child default]>[child my_trait]',
          parent_default_will_change_on_child_default: '[parent default]>[child default] REACHED',
          parent_my_trait_will_change_on_child_my_trait: '[parent my_trait]>[child my_trait] NOT YET',
          parent_default_will_change_on_child_default: '[parent default]>[child my_trait]NOT YET'

    trait :my_trait,
          child_my_trait_only: '[child default]>[nowhere] REACHED',
          child_default_will_change_on_child_my_trait: '[child default]>[child my_trait] REACHED',
          parent_my_trait_will_change_on_child_my_trait: '[parent my_trait]>[child my_trait] REACHED',
          parent_default_will_change_on_child_default: '[parent default]>[child my_trait] REACHED'

    trait :dont_use_this2,
          this_value_cant_appear_nowhere: 'not expected to change or to be used at all'

    private

    def http_method
      :POST
    end

    def url
      'https://www.mysite.com/'
    end

    def params
      {
        overwrite: 'not overwritten',
        potatos: 'this wasnt overwritten at all',
        something_else: 'not overwritten'
      }
    end

    def headers
      {}
    end
  end
end
