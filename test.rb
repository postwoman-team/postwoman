cell = "qualquer coisa \e[38;2;249;38;114mabobrinhaaaaaaaaaaaaaa\e[38;2;38;249;114ma\e[maaaaaaaaaaaaaaaaaaaaa!\e[m isso123456"
puts cell
width = 6
ansi_code_end = "\e[m"

class AnsiCode
  attr_accessor :content, :start_index, :end_index

  def initialize
    self.content = ''
    self.start_index = 0
    self.end_index = -1
  end

  def successor
    ansi = AnsiCode.new
    ansi.content = content
    ansi
  end

  def to_s
    "#{content} FROM #{start_index} TO #{end_index} "
  end

  def to_str
    "#{content} FROM #{start_index} TO #{end_index} "
  end
end

class Bucket
  attr_accessor :content, :ansi_codes

  def initialize
    self.content = ''
    self.ansi_codes = []
  end

  def new_ansi(ansi_code)
    ansi_codes << ansi_code
  end

  def last_ansi
    ansi_codes.last
  end

  def has_ansi?
    ansi_codes.any?
  end

  def ansi_successors
    not_finished = ansi_codes.select { |ac| ac.end_index == -1 }
    not_finished.map { |ac| ac.successor }
  end

  def to_s
    apply
  end

  def apply
    ansi_code_end = "\e[m"
    content_result = content

    ansi_codes.sort_by { |ac| ac.end_index == -1 ? Float::INFINITY : ac.end_index }.reverse.each do |ansi_code|
      content_result.insert(ansi_code.end_index, ansi_code_end)
    end

    ansi_codes.sort_by { |ac| ac.start_index }.reverse.each do |ansi_code|
      content_result.insert(ansi_code.start_index, ansi_code.content)
    end

    content_result
  end
end

buckets = []
current_bucket = Bucket.new
current_ansi = AnsiCode.new
inside_ansi = false

cell.chars.each_with_index do |char, i|
  if (char == "\e") || inside_ansi
    current_ansi.start_index = current_bucket.content.length
    current_ansi.content << char

    if char == 'm'
      if current_ansi.content == ansi_code_end
        current_bucket.last_ansi.end_index = current_bucket.content.length
      else
        current_bucket.new_ansi(current_ansi)
      end
      current_ansi = AnsiCode.new
      inside_ansi = false
    else
      inside_ansi = true
    end

    next
  end

  current_bucket.content << char
  next if current_bucket.content.length < width
  buckets << current_bucket
  current_bucket = Bucket.new
  current_bucket.ansi_codes = buckets.last.ansi_successors
end
buckets << current_bucket if current_bucket.content != ''


buckets.each do |bucket|
  p bucket
end
buckets.each do |bucket|
  puts bucket.to_s
end


# ["qualqu", "er coi", "sa ", "\e[38;2;249;38;114mabobri\e[m", "\e[38;2;249;38;114mnha\e[m"]

# ["qualqu", "er coi", "sa \e[38;2;249;38;114mab\e[m", "obri", "\e[38;2;249;38;114mnha\e[m"]
