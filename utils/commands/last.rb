module Commands
  class Last < Base
    ALIASES = %w[l]
    DESCRIPTION = 'Displays the last request made.'
    ARGS=[
      ['index', 'Index of the wanted request(1 for last, 2 for second last, etc.).']
    ]

    def execute
      index = (args[0]&.to_i || 1) * -1
      return puts 'Indexes start on #1 ;)'.yellow if index.zero?
      return puts 'No requests made at the moment.'.yellow if Env.requests.empty?
      return puts "Request number ##{index * -1} is out of range.".yellow if index * -1 > Env.requests.length

      display_request(Env.requests[index])
    end
  end
end
