module StartUp
  module_function

  def execute
    needed_file('loaders/base.rb', 'templates/loader_base.rb')

    Faraday.default_adapter = :typhoeus

    Readline.completion_append_character = ' '
    Readline.completion_proc = Autocompletion.generate_proc

    history = File.open('.postwoman_history', 'a+').readlines.map(&:chomp)
    Readline::HISTORY.push(*history)

    I18n.locale = Env.config[:language]

    puts Views.start_up_message
  end

  def needed_file(path, template_path)
    return if File.exist?(path)

    File.open(path, 'w') do |f|
      f.write(File.read(Env.src_dir(template_path)))
    end
  end
end
