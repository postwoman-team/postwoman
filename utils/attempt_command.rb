def attempt_command(line)
  args = ArgsHandler.parse(line)

  return unless args.command?

  command_names = fetch_command_names
  command_klass = args.command_klass
  return puts "#{args.raw_command}: not found" unless command_klass

  command_klass.new(args).execute
end
