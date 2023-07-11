class Autocompletion
  def self.generate_proc
    proc do |str|
      loader_names = fetch_loader_names.map do |name|
        snakecase(name.to_s)
      end

      completions = []
      loader_names.each do |name|
        next if name == str

        completions << name if name.start_with?(str)
      end
      completions.sort
    end
  end
end
