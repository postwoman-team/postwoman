module Loaders
  class CompleteLoaderBase < Loaders::Builtin::Base
    trait :default,
          parent_default_will_change_on_pair: '[parent_default]>[pair]',
          parent_default_will_change_on_workbench: '[parent_default]>[workbench]',
          parent_default_will_change_on_child_trait: '[parent_default]>[child_trait]',
          parent_default_will_change_on_parent_trait: '[parent_default]>[parent_trait]',
          parent_default_will_change_on_child_default: '[parent_default]>[child_default]',

          parent_trait_will_change_on_pair: '[parent_trait]>[pair]overwrite fail',
          child_default_will_change_on_pair: '[child_default]>[pair]overwrite fail',
          child_trait_will_change_on_pair: '[child_default]>[pair]overwrite fail',
          workbench_will_change_on_pair: '[child_default]>[pair]overwrite fail',

          child_default_will_change_on_workbench: '[child_default]>[workbench]overwrite fail',
          child_trait_will_change_on_workbench: '[child_default]>[workbench]overwrite fail',

          child_trait_will_change_on_child_trait: '[child_trait]>[child_trait] overwrite fail',

          parent_default_will_change_on_parent_default: '[parent_default]>[parent_default] REACHED'

    trait :my_trait,
          parent_trait_will_change_on_pair: '[parent_trait]>[pair]',
          parent_trait_will_change_on_workbench: '[parent_trait]>[workbench]',
          parent_trait_will_change_on_child_trait: '[parent_trait]>[child_trait]',

          parent_default_will_change_on_parent_trait: '[parent_default]>[parent_trait] REACHED',
          child_default_will_change_on_parent_trait: '[child_default]>[parent_trait] REACHED',
          parent_trait_will_change_on_parent_trait: '[parent_trait]>[parent_trait] REACHED',

          parent_default_will_change_on_pair: '[parent_default]>[pair]overwrite fail',

          parent_default_will_change_on_workbench: '[parent_default]>[workbench]overwrite fail',
          child_default_will_change_on_workbench: '[child_default]>[workbench]overwrite fail',

          parent_default_will_change_on_child_trait: '[parent_default]>[child_trait] overwrite fail',
          child_trait_will_change_on_child_trait: '[child_trait]>[child_trait] overwrite fail'
  end

  class CompleteLoader < Loaders::CompleteLoaderBase
    trait :default,
          child_default_will_change_on_pair: '[child_default]>[pair]',
          child_default_will_change_on_workbench: '[child_default]>[workbench]',
          child_default_will_change_on_child_trait: '[child_default]>[child_trait]',
          child_default_will_change_on_parent_trait: '[child_default]>[parent_trait]',

          parent_default_will_change_on_child_default: '[parent_default]>[child_default] REACHED',
          child_default_will_change_on_child_default: '[child_default]>[child_default] REACHED',

          parent_default_will_change_on_pair: '[parent_default]>[pair]overwrite fail',
          parent_trait_will_change_on_pair: '[parent_trait]>[pair]overwrite fail',
          child_trait_will_change_on_pair: '[child_default]>[pair]overwrite fail',
          workbench_will_change_on_pair: '[child_default]>[pair]overwrite fail',

          parent_default_will_change_on_workbench: '[parent_default]>[workbench]overwrite fail',
          parent_trait_will_change_on_workbench: '[parent_trait]>[workbench]overwrite fail',
          child_trait_will_change_on_workbench: '[child_default]>[workbench]overwrite fail',

          parent_default_will_change_on_child_trait: '[parent_default]>[child_trait] overwrite fail',
          parent_trait_will_change_on_child_trait: '[parent_trait]>[child_trait] overwrite fail',
          child_trait_will_change_on_child_trait: '[child_trait]>[child_trait] overwrite fail'

    trait :my_trait,
          child_trait_will_change_on_pair: '[child_trait]>[pair]',
          child_trait_will_change_on_workbench: '[child_trait]>[workbench]',

          parent_default_will_change_on_child_trait: '[parent_default]>[child_trait] REACHED',
          parent_trait_will_change_on_child_trait: '[parent_trait]>[child_trait] REACHED',
          child_default_will_change_on_child_trait: '[child_default]>[child_trait] REACHED',
          child_trait_will_change_on_child_trait: '[child_trait]>[child_trait] REACHED',

          parent_default_will_change_on_pair: '[parent_default]>[pair]overwrite fail',
          parent_trait_will_change_on_pair: '[parent_trait]>[pair]overwrite fail',
          child_default_will_change_on_pair: '[child_default]>[pair]overwrite fail',
          workbench_will_change_on_pair: '[child_default]>[pair]overwrite fail',

          parent_default_will_change_on_workbench: '[parent_default]>[workbench]overwrite fail',
          parent_trait_will_change_on_workbench: '[parent_trait]>[workbench]overwrite fail',
          child_default_will_change_on_workbench: '[child_default]>[workbench]overwrite fail'

    private

    def http_method
      :POST
    end

    def url
      'https://www.mysite.com/'
    end

    # rubocop:disable Metrics/MethodLength
    def params
      {
        trait_params: {
          parent_default_will_change_on_pair:,
          parent_trait_will_change_on_pair:,
          child_default_will_change_on_pair:,
          child_trait_will_change_on_pair:,
          workbench_will_change_on_pair:,
          pair_will_change_on_pair:,
          parent_default_will_change_on_workbench:,
          parent_trait_will_change_on_workbench:,
          child_default_will_change_on_workbench:,
          child_trait_will_change_on_workbench:,
          workbench_will_change_on_workbench:,
          parent_default_will_change_on_child_trait:,
          parent_trait_will_change_on_child_trait:,
          child_default_will_change_on_child_trait:,
          child_trait_will_change_on_child_trait:,
          parent_default_will_change_on_child_default:,
          child_default_will_change_on_child_default:,
          child_default_will_change_on_parent_trait:,
          parent_default_will_change_on_parent_trait:,
          parent_trait_will_change_on_parent_trait:,
          parent_default_will_change_on_parent_default:
        }
      }
    end
    # rubocop:enable Metrics/MethodLength

    def headers
      {
        token: 'ANfikwnfkwnsiWIkfnwi2',
        auth: 'Basic somethingsomethingimatoken'
      }
    end
  end
end
