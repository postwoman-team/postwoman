module Commands
  class Play < Base
    ALIASES = %w[p].freeze
    DESCRIPTION = 'Plays a script'.freeze
    ARGS = {
      name: "Wanted script's name."
    }.freeze

    def execute
      name = positional_arg(0) || return
      path = "scripts/#{name}.rb"
      return puts Views::Commands::Play.script_not_found(name) unless File.exist?(path)

      eval(File.read(path), binding, path, 1) # rubocop:disable Security/Eval
    rescue Exception => e # rubocop:disable Lint/RescueException
      puts Views::Error.show(e)
    end
  end
end
