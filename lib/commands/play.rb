module Commands
  class Play < Base
    ALIASES = %w[p].freeze
    DESCRIPTION = 'Plays a script'.freeze
    ARGS = {
      name: "Wanted script's name."
    }.freeze

    def execute
      name = positional_arg(0) || return
      eval(File.read("scripts/#{name}.rb"), eval_binding, __FILE__, __LINE__) # rubocop:disable Security/Eval
    rescue Exception => e # rubocop:disable Lint/RescueException
      puts Views::Error.tracing(e)
    end

    def eval_binding
      binding
    end
  end
end
