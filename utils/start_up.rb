module StartUp
  def self.execute
    setup_autocompletion
    load_saved_history
    PrintElement.start_up_message
  end

  def self.setup_autocompletion
    Readline.completion_append_character = ' '
    Readline.completion_proc = Autocompletion.generate_proc
  end

  def self.load_saved_history
    history = File.open('.postwoman_history', 'a+').readlines.map(&:chomp)
    Readline::HISTORY.push(*history)
  end
end
