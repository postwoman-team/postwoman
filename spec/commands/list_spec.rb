require 'spec_helper'

describe 'List command' do
  it 'retrieves all loader names' do
    expect(unstyled_stdout_from { attempt_command('ls') }).to eq(
      <<~TEXT
        ┌─────────────────────────────┐
        │ base missing_method average │
        └─────────────────────────────┘
      TEXT
    )
  end
end
