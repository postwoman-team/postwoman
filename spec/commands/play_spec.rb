require 'spec_helper'

describe 'Play command' do
  context 'when script exists' do
    it 'runs successfully' do
      File.write('scripts/testing.rb', "puts 'hello world'")

      expect(unstyled_stdout_from { attempt_command('play testing') }).to eq(
        <<~TEXT
          hello world
        TEXT
      )
    end

    it 'outputs error message if script is broken' do
      File.write('scripts/testing.rb', "puts 'hello world")

      expect(unstyled_stdout_from { attempt_command('play testing') }).to include(
        <<~TEXT
          ┌─────────────┐
          │ SyntaxError │
          └─────────────┘
        TEXT
      )
    end
  end

  it 'outputs error if script does not exist' do
    expect(unstyled_stdout_from { attempt_command('p whatever') }).to eq(
      <<~TEXT
        No script found: 'whatever'
      TEXT
    )
  end
end
