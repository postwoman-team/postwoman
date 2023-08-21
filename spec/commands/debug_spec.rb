require 'spec_helper'

describe 'Debug command' do
  it 'Calls binding.pry if debugger is binding.pry' do
    ENV['DEBUGGER'] = 'pry'
    command_obj = Commands::Debug.new(ArgsHandler.parse('debug'))
    command_binding = double('binding', pry: nil)
    allow(command_obj).to receive(:binding) { command_binding }
    command_obj.execute
    expect(command_binding).to have_received(:pry)
  end

  it 'Calls byebug if debugger is byebug' do
    ENV['DEBUGGER'] = 'byebug'
    allow(Byebug).to receive(:attach)
    attempt_command('debug')

    expect(Byebug).to have_received(:attach)
  end

  it 'Calls debug if debugger is debug' do
    ENV['DEBUGGER'] = 'debug'
    command_obj = Commands::Debug.new(ArgsHandler.parse('debug'))
    command_binding = double('binding', break: nil)
    allow(command_obj).to receive(:binding) { command_binding }
    command_obj.execute
    expect(command_binding).to have_received(:break)
  end
end
