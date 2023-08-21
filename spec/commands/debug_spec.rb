require 'spec_helper'

describe 'Debug command' do
  xit 'Calls binding.pry if debugger is binding.pry' do
    ENV['DEBUGGER'] = 'bindingpry'
    command_obj = Commands::New.new(ArgsHandler.parse('debug'))
    allow(command_obj).to receive(:byebug) { true }
    command_obj.execute
    expect(Pry).to have_received(:byebug)
  end

  it 'Calls byebug if debugger is byebug' do
    ENV['DEBUGGER'] = 'byebug'
    command_obj = Commands::New.new(ArgsHandler.parse('debug'))
    allow(command_obj).to receive(:byebug) { true }
    command_obj.execute
    attempt_command('debug')

    expect(command_obj).to have_received(:byebug)
  end

  xit 'Calls byebug if debugger is debug' do
    ENV['DEBUGGER'] = 'debug'
    command_obj = Commands::New.new(ArgsHandler.parse('debug'))
    allow(command_obj).to receive(:debug) { true }
    command_obj.execute
    attempt_command('debug')

    expect(Kernel).to have_received(:byebug)
  end
end
