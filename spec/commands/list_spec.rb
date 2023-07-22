require 'spec_helper'

describe 'List command' do
  it 'retrieves all loader names' do
    allow(Loaders).to receive(:constants).and_return(%i[Builtin Utils Base MyLoader MyOtherLoader ThisIsAValidLoader])
    expected_output = "#{'base'.yellow} my_loader my_other_loader this_is_a_valid_loader\n"
    output = capture_stdout_from { attempt_command('ls') }
    expect(output).to eq(expected_output)
  end
end
