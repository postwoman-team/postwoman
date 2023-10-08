cell = "qualquer coisa \e[38;2;249;38;114mabobrinha!\e[m isso123456"
# cell = ["qualqu", "er coi", "sa \e[38;2;249;38;114mabo\e[m", "\e[38;2;249;38;114mbrinha\e[m", "\e[38;2;249;38;114m!\e[m"]

# cell = "qualq;uer c;oisa ;\e[38;2;249;38;114mabobrinha\e[m"
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
    "content: #{content} - ansi_codes: #{ansi_codes.map { |ac| ac.to_s }} "
  end

  def apply
    content_result = content
    ansi_codes.each do |ansi_code|
      content_result.insert(ansi_code.start_index)
    end
  end
end

width = 6
buckets = []
current_bucket = Bucket.new
current_ansi = AnsiCode.new
inside_ansi = false
ansi_code_end = "\e[m"

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
  puts current_bucket
  buckets << current_bucket
  current_bucket = Bucket.new
  current_bucket.ansi_codes = buckets.last.ansi_successors
end

# buckets.each do |bucket|
#   if bucket[:ansi_index]
#     bucket[:content].insert(bucket[:ansi_index], "\e[38;2;249;38;114m")
#     bucket[:content] << "\e[m"
#   end
# end



# ["qualqu", "er coi", "sa ", "\e[38;2;249;38;114mabobri\e[m", "\e[38;2;249;38;114mnha\e[m"]

# ["qualqu", "er coi", "sa \e[38;2;249;38;114mab\e[m", "obri", "\e[38;2;249;38;114mnha\e[m"]
