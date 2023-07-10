def attempt_command(args)
  return unless args.command?

  command_names = (Commands.constants - [:Base]).map(&:to_s)
  command = args.command
  command[0] = command[0].upcase

  if command_names.include?(command)
    Commands.class_eval(command).new(args).execute
  else
    puts "#{args.raw_command}: not found"
  end
end
