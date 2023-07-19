module StartUp
  def self.execute
    setup_autocompletion
    load_saved_history
    print_initialization_message
  end

  def self.setup_autocompletion
    Readline.completion_append_character = ' '
    Readline.completion_proc = Autocompletion.generate_proc
  end

  def self.load_saved_history
    history = File.open('.postwoman_history', 'a+').readlines.map(&:chomp)
    Readline::HISTORY.push(*history)
  end

  def self.print_initialization_message
    logo = <<~TEXT
       _  _  __|_  _ _  _ _  _  _
      |_)(_)_\\ |\\/\\/(_)| | |(_|| |
      |
    TEXT

    puts "#{logo.chomp} #{random_ai_sentence}".magenta
    puts("Type 'help' for more information")
  end

  def self.random_ai_sentence
    [
      "A 100% CLI API platform.",
      "Pull requests are always welcome!",
      "DEPLOY ON FRIDAYS",
      "I'm a teapot",
      "...but it was me, Dio!",
    ].sample
  end
end
