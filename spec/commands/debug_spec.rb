require 'spec_helper'

describe 'Debug command' do
  it 'calls binding.pry if debugger is binding.pry' do
    allow(Env.config).to receive(:[]).with(:debugger).and_return('pry')
    command_obj = Commands::Debug.new(ArgsHandler.parse('debug'))
    command_binding = double('binding', pry: nil)
    allow(command_obj).to receive(:binding) { command_binding }

    command_obj.execute

    expect(command_binding).to have_received(:pry)
  end

  it 'calls debug if debugger is debug' do
    allow(Env.config).to receive(:[]).with(:debugger).and_return('debug')
    command_obj = Commands::Debug.new(ArgsHandler.parse('debug'))
    command_binding = double('binding', break: nil)
    allow(command_obj).to receive(:binding) { command_binding }

    command_obj.execute

    expect(command_binding).to have_received(:break)
  end
end
