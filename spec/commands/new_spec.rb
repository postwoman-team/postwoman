require 'spec_helper'


describe 'New command' do
  it 'creates new loader with template and opens on default editor unless loader already exists' do
    template = <<-TEXT
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

    allow(File).to receive(:exist?).with('loaders/testing.rb').and_return(false)
    allow_any_instance_of(Commands::New).to receive(:system).with('emacs loaders/testing.rb')
    allow(File).to receive(:open).with('loaders/testing.rb', 'w').and_yield(file_obj)
    expect(file_obj).to receive(:write).with(template).once

    expected_output = "Creating #{'new'.green} loader\n"
    expect { attempt_command('new testing') }.to output(expected_output).to_stdout
  end

  it 'edits existing loader on default editor if loader already exists' do
    ENV['EDITOR'] = 'emacs'

    allow(File).to receive(:exist?).with('loaders/testing.rb').and_return(true)
    allow_any_instance_of(Commands::New).to receive(:system).with('emacs loaders/testing.rb')
    expect(File).to_not receive(:open)
    expect(File).to_not receive(:write)

    expected_output = "Editing loader\n"
    expect { attempt_command('new testing') }.to output(expected_output).to_stdout
  end

  it 'outputs error message if loader name is not provided' do
    expected_output = "Missing #1 positional argument: name".red + "\n"
    expect { attempt_command('new') }.to output(expected_output).to_stdout
  end

  it 'outputs warning message if default editor is not set' do
    ENV['EDITOR'] = nil
    allow(File).to receive(:exist?).with('loaders/testing.rb').and_return(true)
    expect_any_instance_of(Commands::New).to_not receive(:system)

    expected_output = "Editing loader\n#{"Could not open loader because default editor isn't set.".yellow}\n"
    expect { attempt_command('new testing') }.to output(expected_output).to_stdout
  end
end
