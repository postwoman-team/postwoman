module StdoutHelper
  def unstyled_stdout_from(&block)
    original_stdout = $stdout
    $stdout = StringIO.new
    block.call
    $stdout.string.gsub(/\e\[([;\d]+)?m/, '')
  ensure
    $stdout = original_stdout
  end
end
