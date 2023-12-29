module Views
  module Argument
    module_function

    def invalid_subcommand(name)
      str =  '<warning>'
      str << I18n.t('argument.invalid_subcommand', name: name)
      str << '</warning>'

      Style.apply(str)
    end

    def subcommand_needs_positionals
      str =  '<fail>'
      str << I18n.t('argument.subcommand_needs_positionals')
      str << '</fail>'

      Style.apply(str)
    end

    def missing_positional_argument(index, name)
      str =  '<fail>'
      str << I18n.t('argument.missing_positional_argument', index: index, name: name)
      str << '</fail>'

      Style.apply(str)
    end

    def invalid_category(name)
      str =  '<fail>'
      str << I18n.t('argument.invalid_category', name: name)
      str << '</fail>'

      Style.apply(str)
    end
  end
end
