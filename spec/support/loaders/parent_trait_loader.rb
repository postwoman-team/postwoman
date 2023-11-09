module Loaders
  class ParentTraitLoader < Loaders::Builtin::Base
    trait :default,
          parent_default_only: '[parent default]>[parent default] REACHED',
          parent_default_will_change_on_parent_my_trait: '[parent default]>[parent my_trait]',
          parent_default_will_change_on_child_default: '[parent default]>[child default]',
          parent_default_will_change_on_child_default: '[parent default]>[child my_trait]'

    trait :my_trait,
          parent_my_trait_only: '[parent my_trait]>[parent my_trait] REACHED',
          parent_my_trait_will_change_on_child_my_trait: '[parent my_trait]>[child my_trait]',
          parent_default_will_change_on_parent_my_trait: '[parent default]>[parent my_trait] REACHED',
          parent_default_will_change_on_child_default: '[parent default]>[child my_trait] NOT YET'

    trait :dont_use_this,
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
