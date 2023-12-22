module Views
  module Loaders
    module_function

    def missing_method(name)
      str =  '<warning>'
      str << I18n.t('loaders.missing_method', name: name)
      str << '</warning>'

      Style.apply(str)
    end
  end
end
