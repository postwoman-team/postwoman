require 'spec_helper'

describe 'List command' do
  it 'retrieves all loader and script names' do
    Dir.mkdir('scripts')
    File.write('scripts/test.rb', '')

    expect(unstyled_stdout_from { attempt_command('ls') }).to eq(
      <<~TEXT
        ┌─────────────────────────────┐
        │ Loaders                     │
        │ base average missing_method │
        │                             │
        │ Scripts                     │
        │ test                        │
        └─────────────────────────────┘
      TEXT
    )

    File.delete('scripts/test.rb')
  end

  it 'works when no script is found' do
    expect(unstyled_stdout_from { attempt_command('ls') }).to eq(
      <<~TEXT
        ┌─────────────────────────────┐
        │ Loaders                     │
        │ base average missing_method │
        │                             │
        │ Scripts                     │
        │ (Empty)                     │
        └─────────────────────────────┘
      TEXT
    )
  end
end
