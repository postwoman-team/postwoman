module Views
  module Package
    module_function

    def invalid(path)
      str = '<fail>'
      str << I18n.t('package.invalid.invalid_directory', path: path)
      str << '</fail><br>'
      str << I18n.t('package.invalid.help', new_command: '<hl>postwoman -n my_path</hl>', interact_command: '<hl>postwoman my_path</hl>')

      Style.apply(str)
    end

    def creating_missing_file(path)
      str =  I18n.t('package.creating_missing_file')
      str << '<warning>'
      str << path
      str << '</warning>'
      Style.apply(str)
    end

    def creating_new(path)
      str =  I18n.t('package.creating_new')
      str << '<hl>'
      str << path
      str << '</hl>'
      Style.apply(str)
    end

    def already_exists(path)
      str =  I18n.t('package.already_exists')
      str << '<hl>'
      str << path
      str << '</hl>'
      Style.apply(str)
    end
  end
end
