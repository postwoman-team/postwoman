require 'spec_helper'

describe 'List command' do
  it 'retrieves all loader names' do
    # TIRAR LINHA DE BAIXO
    allow(Loaders).to receive(:constants).and_return(%i[Builtin Utils Base MyLoader MyOtherLoader ThisIsAValidLoader])
    expect(unstyled_stdout_from { attempt_command('ls') }).to eq(
      <<~TEXT
        ┌───────────────────────────────────────────────────────┐
        │ base my_loader my_other_loader this_is_a_valid_loader │
        └───────────────────────────────────────────────────────┘
      TEXT
    )
  end
end
