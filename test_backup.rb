cell = "qualquer coisa \e[38;2;249;38;114mabobrinha!\e[m12345"
# cell = "qualq;uer c;oisa ;\e[38;2;249;38;114mabobrinha\e[m"

class Bucket
  attr_accessor :content, :ansi_start_index, :ansi_end_index, :ansi_codes

  def initialize
    self.content = ''
    self.ansi_codes = []
  end
end

byebug
width = 6
split_cell = cell.scan(/.{1,#{width}}/)
buckets = []
current_bucket = {content: '', ansi_start_index: nil, ansi_end_index: nil, ansi_codes: []}
inside_escape = false
current_ansi = ''
ansi_code_end = "\e[m"

cell.chars.each_with_index do |char, i|
  if (char == "\e") || inside_escape
    current_bucket[:ansi_start_index] = current_bucket[:content].length
    current_ansi << char

    if char == 'm'
      if current_ansi == ansi_code_end
        current_bucket[:ansi_end_index] = current_bucket[:content].length
      else
        current_bucket[:ansi_codes] << current_ansi
      end
      inside_escape = false
      current_ansi = ''
    else
      inside_escape = true
    end

    next
  end

  current_bucket[:content] << char

  next if current_bucket[:content].length < width

  current_bucket[:ansi_end_index] = -1 if !current_bucket[:ansi_end_index] && current_bucket[:ansi_start_index]
  buckets << current_bucket
  current_bucket = {content: '', ansi_start_index: nil, ansi_end_index: nil, ansi_codes: []}
  if cell.chars[i + 1] == "\e" || buckets.last[:ansi_start_index]
    current_bucket[:ansi_start_index] = 0
    current_bucket[:ansi_codes] = buckets.last[:ansi_codes]
  end
end

# buckets.each do |bucket|
#   if bucket[:ansi_index]
#     bucket[:content].insert(bucket[:ansi_index], "\e[38;2;249;38;114m")
#     bucket[:content] << "\e[m"
#   end
# end

puts buckets


# ["qualqu", "er coi", "sa ", "\e[38;2;249;38;114mabobri\e[m", "\e[38;2;249;38;114mnha\e[m"]

# ["qualqu", "er coi", "sa \e[38;2;249;38;114mab\e[m", "obri", "\e[38;2;249;38;114mnha\e[m"]
