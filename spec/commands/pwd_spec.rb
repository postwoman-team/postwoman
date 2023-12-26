require 'spec_helper'

describe 'Pwd command' do
  it 'retrieves current directory' do
    expect(unstyled_stdout_from { attempt_command('pwd') }.chomp).to eq(Dir.pwd)
  end
end
