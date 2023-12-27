require 'spec_helper'

describe 'Postwoman' do
  it 'boots up succesfully in sandbox mode' do
    PTY.spawn('postwoman') do |stdout, _, _|
      output = stdout.read_all
      expect(unstyled_stdout_from { print output }).to include("Type 'help' for more information")
      expect(unstyled_stdout_from { print output }).to include('sandbox> ')
    end
  end
end
