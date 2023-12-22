module Views
  module_function

  def invalid_package(path)
    str = '<fail>'
    str << I18n.t('invalid_package.invalid_directory', path: path)
    str << '</fail><br>'
    str << I18n.t('invalid_package.help', new_command: '<hl>postwoman -n my_path</hl>', interact_command: '<hl>postwoman my_path</hl>')

    Style.apply(str)
  end
end
