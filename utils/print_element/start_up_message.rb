module PrintElement
  module_function

  def start_up_message
    logo = <<~TEXT
       _  _  __|_  _ _  _ _  _  _
      |_)(_)_\\ |\\/\\/(_)| | |(_|| |
      |
    TEXT

    random_sentence = [
      'A 100% CLI API platform.',
      'Pull requests are always welcome!',
      'DEPLOY ON FRIDAYS',
      "I'm a teapot",
      '...but it was me, Dio!',
      'git push origin main -f'
    ].sample

    puts "#{logo.chomp} #{random_sentence}".magenta
    puts("Type 'help' for more information")
  end
end
