require 'spec_helper'

describe 'New command' do
  it 'creates new loader with template and opens on default editor unless loader already exists' do
    template = <<~TEXT
      module Loaders
        class Testing < Base
          private

          def http_method
            :GET
          end

          def url
            ''
          end

          def params
            {}
          end

          def headers
            default_headers
          end
        end
      end
    TEXT

    ENV['EDITOR'] = 'emacs'
    file_obj = double('file_obj')
    command = 'new testing'
    command_obj = Commands::New.new(ArgsHandler.parse(command))

    allow(File).to receive(:exist?)
    allow(File).to receive(:open).and_call_original
    expect(Commands::New).to receive(:new).and_return(command_obj)
    expect(command_obj).to receive(:system).with('emacs loaders/testing.rb')
    expect(File).to receive(:exist?).with('loaders/testing.rb').and_return(false)
    expect(File).to receive(:open).with('loaders/testing.rb', 'w').and_yield(file_obj)
    expect(file_obj).to receive(:write).with(template).once

    expected_output = <<~TEXT
      Creating #{'new'.green} loader
    TEXT

    output = capture_stdout_from { attempt_command(command) }
    expect(output).to eq(expected_output)
  end

  it 'edits existing loader on default editor if loader already exists' do
    ENV['EDITOR'] = 'emacs'
    command = 'new testing'
    command_obj = Commands::New.new(ArgsHandler.parse(command))

    allow(File).to receive(:exist?)
    allow(File).to receive(:open).and_call_original
    expect(Commands::New).to receive(:new).and_return(command_obj)
    expect(command_obj).to receive(:system).with('emacs loaders/testing.rb')
    expect(File).to receive(:exist?).with('loaders/testing.rb').and_return(true)
    expect(File).to_not receive(:open).with('loaders/testing.rb')
    expect(File).to_not receive(:write).with('loaders/testing.rb')

    expected_output = <<~TEXT
      Editing loader
    TEXT

    output = capture_stdout_from { attempt_command(command) }
    expect(output).to eq(expected_output)
  end

  it 'outputs error message if loader name is not provided' do
    expected_output = <<~TEXT
      #{"Missing #1 positional argument: 'name'".red}
    TEXT

    output = capture_stdout_from { attempt_command('new') }
    expect(output).to eq(expected_output)
  end

  it 'treats loader name to be downcased' do
    ENV['EDITOR'] = 'emacs'
    loader_path = 'loaders/testing2.rb'
    command = 'new Testing2'
    command_obj = Commands::New.new(ArgsHandler.parse(command))

    expect(Commands::New).to receive(:new).and_return(command_obj)
    expect(command_obj).to receive(:system).with('emacs loaders/testing2.rb')
    allow(File).to receive(:exist?)
    allow(File).to receive(:open).and_call_original
    allow(File).to receive(:exist?).with(loader_path).and_return(true)

    expect(File).to_not receive(:open).with(loader_path)
    expect(File).to_not receive(:write).with(loader_path)

    expected_output = <<~TEXT
      Editing loader
    TEXT

    output = capture_stdout_from { attempt_command(command) }

    expect(output).to eq(expected_output)
  end

  context 'outputs error message if loader name is not valid because' do
    it 'uses kebab case' do
      expected_output = <<~TEXT
        #{"Invalid loader name 'im-bad-kebab-case'.".red}
      TEXT

      output = capture_stdout_from { attempt_command('new im-bad-kebab-case') }

      expect(output).to eq(expected_output)
    end

    it 'starts terms with numbers' do
      expected_output = <<~TEXT
        #{"Invalid loader name 'wrong_1'.".red}
      TEXT

      output = capture_stdout_from { attempt_command('new wrong_1') }

      expect(output).to eq(expected_output)
    end

    it 'has invalid characters' do
      expected_output = <<~TEXT
        #{"Invalid loader name 'wrong!'.".red}
      TEXT

      output = capture_stdout_from { attempt_command('new wrong!') }

      expect(output).to eq(expected_output)
    end
  end

  it 'outputs warning message if default editor is not set' do
    ENV['EDITOR'] = nil
    command = 'new testing'
    command_obj = Commands::New.new(ArgsHandler.parse(command))

    expect(Commands::New).to receive(:new).and_return(command_obj)
    expect(command_obj).to_not receive(:system)
    expect(File).to receive(:exist?).with('loaders/testing.rb').and_return(true)

    expected_output = <<~TEXT
      Editing loader
      #{"Could not open loader because default editor isn't set.".yellow}
    TEXT

    output = capture_stdout_from { attempt_command(command) }

    expect(output).to eq(expected_output)
  end
end
