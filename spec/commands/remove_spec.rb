require 'spec_helper'

describe 'Remove command' do
  context 'when file exists' do
    it 'deletes loader' do
      File.write('loaders/testing.rb', 'does not matter')

      expect(unstyled_stdout_from { attempt_command('rm l testing') }).to eq(
        <<~TEXT
          Successfully removed loader testing
        TEXT
      )
      expect(File).not_to exist('loaders/testing.rb')
    end

    it 'deletes script' do
      File.write('scripts/testing.rb', 'does not matter')

      expect(unstyled_stdout_from { attempt_command('rm s testing') }).to eq(
        <<~TEXT
          Successfully removed script testing
        TEXT
      )
      expect(File).not_to exist('scripts/testing.rb')
    end
  end

  context 'when file does not exist' do
    it 'output error message for loader' do
      expect(unstyled_stdout_from { attempt_command('rm l testing') }).to eq(
        <<~TEXT
          Could not find loader testing
        TEXT
      )
    end

    it 'output error message for script' do
      expect(unstyled_stdout_from { attempt_command('rm s testing') }).to eq(
        <<~TEXT
          Could not find script testing
        TEXT
      )
    end
  end

  it 'outputs error messages for missing arguments' do
    expect(unstyled_stdout_from { attempt_command('rm') }).to eq(
      <<~TEXT
        Missing #1 positional argument: 'category'
        Missing #2 positional argument: 'name'
      TEXT
    )
  end

  it 'outputs error messages for invalid category' do
    expect(unstyled_stdout_from { attempt_command('rm idk testing') }).to eq(
      <<~TEXT
        Invalid category 'idk'. Use 'l' or 's'
      TEXT
    )
  end

  it 'does not let user delete base' do
    expect(unstyled_stdout_from { attempt_command('rm l base') }).to eq(
      <<~TEXT
        Please don't delete base.
      TEXT
    )
  end
end
