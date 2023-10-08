class StringDaBoa
  attr_reader :start_index, :end_index, :start_ansi, :end_ansi

  def initialize(start_ansi, str, end_ansi, start_index, end_index)
    @start_ansi = start_ansi
    @str = str
    @end_ansi = end_ansi
    @start_index = start_index
    @end_index = end_index
  end

  def split(n)
    split_str = @str.chars.each_slice(n).to_a.map(&:join)

    split_str.map { |w| self.start_ansi + w + self.end_ansi }
  end
end

cell = "qualquer coisa \e[38;2;249;38;114mabobrinha\e[m"

re = /(\e\[38;2;249;38;114m)(.*?)(\e\[m)/

pos = cell.enum_for(:scan, re).map do
  StringDaBoa.new(Regexp.last_match[1], Regexp.last_match[2], Regexp.last_match[3], Regexp.last_match.begin(0), Regexp.last_match.end(0))
end

buckets = []
current_bucket = ""
counter = 0
num_char = 0
split_n = 7

until counter == cell.length
  if (str = pos.find { |p| counter >= p.start_index && counter <= p.end_index })
    buckets << str.split(split_n)
    counter = str.end_index
  else
    if num_char < split_n - 1
      current_bucket << cell[counter]
      num_char += 1
    else
      current_bucket << cell[counter]
      buckets << current_bucket
      current_bucket = ""
      num_char = 0
    end

    counter += 1
  end
end

p buckets.flatten
