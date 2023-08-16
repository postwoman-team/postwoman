require 'spec_helper'

describe 'New command' do
  it 'creates new loader with template and opens on default editor when loader does not already exist', :file_mocking do
    template = <<~TEXT
      module Loaders
        class Testing < Base
          private

          def http_method = :GET

          def url = ''

          def params = {}

          def headers = json_headers
        end
      end
    TEXT
    ENV['EDITOR'] = 'emacs'
    command = Commands::New.new(ArgsHandler.parse('new testing'))
    pretend_file_doesnt_exist('loaders/testing.rb')

    expect(command).to receive(:system).with('emacs loaders/testing.rb')
    expect_to_write('loaders/testing.rb', template)
    expect(unstyled_stdout_from { command.execute }).to eq(
      <<~TEXT
        ┌────────────────────────┐
        │ Creating new loader... │
        └────────────────────────┘
      TEXT
    )
  end

  it 'edits existing loader on default editor when loader already exists', :file_mocking do
    ENV['EDITOR'] = 'emacs'
    command = Commands::New.new(ArgsHandler.parse('new testing'))
    pretend_file_exists('loaders/testing.rb')

    expect(command).to receive(:system).with('emacs loaders/testing.rb')
    expect(File).to_not receive(:open).with('loaders/testing.rb')
    expect(File).to_not receive(:write).with('loaders/testing.rb')
    expect(unstyled_stdout_from { command.execute }).to eq(
      <<~TEXT
        ┌───────────────────┐
        │ Editing loader... │
        └───────────────────┘
      TEXT
    )
  end

  it 'outputs error message when loader name is not provided' do
    expect(unstyled_stdout_from { attempt_command('new') }).to eq(
      <<~TEXT
        Missing #1 positional argument: 'name'
      TEXT
    )
  end

  it 'treats loader name to be downcased', :file_mocking do
    ENV['EDITOR'] = 'emacs'
    command = Commands::New.new(ArgsHandler.parse('new Testing2'))
    pretend_file_exists('loaders/testing2.rb')

    expect(command).to receive(:system).with('emacs loaders/testing2.rb')
    command.execute
  end

  context 'outputs error message when loader name is not valid because' do
    it 'uses kebab case' do
      expect(unstyled_stdout_from { attempt_command('new im-bad-kebab-case') }).to eq(
        <<~TEXT
          Invalid loader name 'im-bad-kebab-case'
        TEXT
      )
    end

    it 'starts terms with numbers' do
      expect(unstyled_stdout_from { attempt_command('new wrong_1') }).to eq(
        <<~TEXT
          Invalid loader name 'wrong_1'
        TEXT
      )
    end

    it 'has invalid characters' do
      expect(unstyled_stdout_from { attempt_command('new wrong!') }).to eq(
        <<~TEXT
          Invalid loader name 'wrong!'
        TEXT
      )
    end
  end

  context 'when default editor is not set' do
    it 'outputs message after loader creation' do
      ENV['EDITOR'] = nil
      command = Commands::New.new(ArgsHandler.parse('new testing'))
      pretend_file_doesnt_exist('loaders/testing.rb')

      expect_to_write('loaders/testing.rb')
      expect(unstyled_stdout_from { command.execute }).to eq(
        <<~TEXT
          ┌────────────────────────┐
          │ Creating new loader... │
          └────────────────────────┘
          The environment variable 'EDITOR' has not been set to open the target file
        TEXT
      )
    end

    it 'outputs message after trying to edit loader' do
      ENV['EDITOR'] = nil
      command = Commands::New.new(ArgsHandler.parse('new testing'))
      pretend_file_exists('loaders/testing.rb')

      expect(command).to_not receive(:system)
      expect(unstyled_stdout_from { command.execute }).to eq(
        <<~TEXT
          ┌───────────────────┐
          │ Editing loader... │
          └───────────────────┘
          The environment variable 'EDITOR' has not been set to open the target file
        TEXT
      )
    end
  end
end
