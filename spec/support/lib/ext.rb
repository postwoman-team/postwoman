require 'timeout'

class IO
  def read_all
    read_until('> ')
  end

  def read_until(string)
    result = ''

    i = 0
    stop_reading = lambda do |char|
      match = string[i] == char

      next true if i == 0 && !match

      i += 1

      match && i == string.length - 1
    end

    loop do
      result_char = read_nonblock(1)
      result << result_char

      return result unless stop_reading.call(result_char)

    rescue IO::WaitReadable
      IO.select([self])
      retry
    end
  end
end
