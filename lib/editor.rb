module Editor
  module_function

  def create_and_open(path, default_content, category)
    if !File.exist?(path)
      puts Views::Editor.creating(category)
      File.write(path, default_content)
    else
      puts Views::Editor.editing(category)
    end

    return puts Views::Editor.editor_not_found_warning if Env.config[:editor].nil?

    system("#{Env.config[:editor]} #{path}")
  end
end
