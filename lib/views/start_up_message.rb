module Views
  module_function

  def start_up_message
    random_sentence = [
      'A 100% CLI API platform.',
      'Pull requests are always welcome!',
      'DEPLOY ON FRIDAYS',
      "I'm a teapot",
      '...but it was me, Dio!',
      'git push origin main -f'
    ].sample

    str = '<h1>'
    str << <<~TEXT
       _  _  __|_  _ _  _ _  _  _
      |_)(_)_\\ |\\/\\/(_)| | |(_|| |
      | #{random_sentence}
    TEXT
    str << '</h1>'
    str << "Type 'help' for more information"
    Style.apply(str)
  end
end
