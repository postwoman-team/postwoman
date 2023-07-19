require 'spec_helper'

describe 'Workbench command' do
  it 'sets pairs as workbench key-values' do
    expected_output = <<~TEXT
      ┌────────┬─────────────┐
      │ int    │ 2           │
      │ string │ "#{'my string'.yellow}" │
      │ bool   │ true        │
      └────────┴─────────────┘
    TEXT

    expect { attempt_command("workbench int:2 string:'my string' bool:true") }.to output(expected_output).to_stdout
    expect(Env.workbench[:int]).to eq(2)
    expect(Env.workbench[:string]).to eq('my string')
    expect(Env.workbench[:bool]).to eq(true)
  end

  it 'shows workbench if no subcommand is passed' do
    expected_output = <<~TEXT
      ┌─────────────────┐
      │ Currently empty │
      └─────────────────┘
    TEXT
    expect { attempt_command('workbench') }.to output(expected_output).to_stdout
  end

  it 'prints out warning if unknown subcommand is passed' do
    expected_output = <<~TEXT
      #{"Invalid subcommand: 'unknown'".yellow}
      ┌─────────────────┐
      │ Currently empty │
      └─────────────────┘
    TEXT
    expect { attempt_command('workbench unknown') }.to output(expected_output).to_stdout
  end

  context 'delete subcommand' do
    it 'removes multiple keys from workbench' do
      Env.workbench[:int] = 3
      Env.workbench[:my_nil_value] = nil
      Env.workbench[:other_int] = 4

      expected_output = <<~TEXT
        ┌──────────────┬──────┐
        │ my_nil_value │ null │
        └──────────────┴──────┘
      TEXT

      expect { attempt_command('workbench d other_int int') }.to output(expected_output).to_stdout
      expect(Env.workbench[:int]).to eq(nil)
      expect(Env.workbench[:nil]).to eq(nil)
      expect(Env.workbench[:other_int]).to eq(nil)
    end

    it 'prints out warning if the key does not exist' do
      Env.workbench[:a] = 3
      Env.workbench[:b] = 8
      Env.workbench[:c] = 4
      Env.workbench[:d] = 4

      expected_output = <<~TEXT
        #{'Key idontexist not found on workbench'.yellow}
        ┌───┬───┐
        │ a │ 3 │
        │ c │ 4 │
        │ d │ 4 │
        └───┴───┘
      TEXT

      expect { attempt_command('workbench d b idontexist') }.to output(expected_output).to_stdout
      expect(Env.workbench[:a]).to eq(3)
      expect(Env.workbench[:c]).to eq(4)
      expect(Env.workbench[:d]).to eq(4)
    end

    it 'prints out error if no key was passed' do
      Env.workbench[:a] = 3
      Env.workbench[:b] = 8
      Env.workbench[:c] = 4
      Env.workbench[:d] = 4

      expected_output = <<~TEXT
        #{'This subcommand should be called with positionals'.yellow}
        ┌───┬───┐
        │ a │ 3 │
        │ b │ 8 │
        │ c │ 4 │
        │ d │ 4 │
        └───┴───┘
      TEXT

      expect { attempt_command('workbench d') }.to output(expected_output).to_stdout
      expect(Env.workbench[:a]).to eq(3)
      expect(Env.workbench[:b]).to eq(8)
      expect(Env.workbench[:c]).to eq(4)
      expect(Env.workbench[:d]).to eq(4)
    end
  end

  context 'copy subcommand' do
    it 'copies target keys value to a new key' do
      Env.workbench[:a] = 3
      Env.workbench[:b] = 8
      Env.workbench[:c] = 4
      Env.workbench[:d] = 4

      expected_output = <<~TEXT
        ┌───┬───┐
        │ a │ 3 │
        │ b │ 8 │
        │ c │ 4 │
        │ d │ 4 │
        │ e │ 3 │
        └───┴───┘
      TEXT

      expect { attempt_command('workbench cp a e') }.to output(expected_output).to_stdout
      expect(Env.workbench[:a]).to eq(3)
      expect(Env.workbench[:b]).to eq(8)
      expect(Env.workbench[:c]).to eq(4)
      expect(Env.workbench[:d]).to eq(4)
      expect(Env.workbench[:e]).to eq(3)
    end

    it 'copies target keys value to another existing key' do
      Env.workbench[:a] = 3
      Env.workbench[:b] = 8
      Env.workbench[:c] = 4
      Env.workbench[:d] = 4

      expected_output = <<~TEXT
        ┌───┬───┐
        │ a │ 3 │
        │ b │ 8 │
        │ c │ 3 │
        │ d │ 4 │
        └───┴───┘
      TEXT

      expect { attempt_command('workbench cp a c') }.to output(expected_output).to_stdout
      expect(Env.workbench[:a]).to eq(3)
      expect(Env.workbench[:b]).to eq(8)
      expect(Env.workbench[:c]).to eq(3)
      expect(Env.workbench[:d]).to eq(4)
    end

    it 'prints out error if result key was not passed' do
      Env.workbench[:a] = 3
      Env.workbench[:b] = 8
      Env.workbench[:c] = 4
      Env.workbench[:d] = 4

      expected_output = <<~TEXT
        #{"Missing #3 positional argument: 'resulting key'".red}
        ┌───┬───┐
        │ a │ 3 │
        │ b │ 8 │
        │ c │ 4 │
        │ d │ 4 │
        └───┴───┘
      TEXT

      expect { attempt_command('workbench cp a') }.to output(expected_output).to_stdout
      expect(Env.workbench[:a]).to eq(3)
      expect(Env.workbench[:b]).to eq(8)
      expect(Env.workbench[:c]).to eq(4)
      expect(Env.workbench[:d]).to eq(4)
    end

    it 'prints out errors if result key and key to copy were not passed' do
      Env.workbench[:a] = 3
      Env.workbench[:b] = 8
      Env.workbench[:c] = 4
      Env.workbench[:d] = 4

      expected_output = <<~TEXT
        #{"Missing #2 positional argument: 'key to copy'".red}
        #{"Missing #3 positional argument: 'resulting key'".red}
        ┌───┬───┐
        │ a │ 3 │
        │ b │ 8 │
        │ c │ 4 │
        │ d │ 4 │
        └───┴───┘
      TEXT

      expect { attempt_command('workbench cp') }.to output(expected_output).to_stdout
      expect(Env.workbench[:a]).to eq(3)
      expect(Env.workbench[:b]).to eq(8)
      expect(Env.workbench[:c]).to eq(4)
      expect(Env.workbench[:d]).to eq(4)
    end

    it 'prints out errors if key to copy does not exist' do
      Env.workbench[:a] = 3
      Env.workbench[:b] = 8
      Env.workbench[:c] = 4
      Env.workbench[:d] = 4

      expected_output = <<~TEXT
        #{"Key 'inexistent' does not exist on workbench".red}
        ┌───┬───┐
        │ a │ 3 │
        │ b │ 8 │
        │ c │ 4 │
        │ d │ 4 │
        └───┴───┘
      TEXT

      expect { attempt_command('workbench cp inexistent a') }.to output(expected_output).to_stdout
      expect(Env.workbench[:a]).to eq(3)
      expect(Env.workbench[:b]).to eq(8)
      expect(Env.workbench[:c]).to eq(4)
      expect(Env.workbench[:d]).to eq(4)
    end
  end

  context 'rename subcommand' do
    it 'renames target key' do
      Env.workbench[:a] = 3
      Env.workbench[:b] = 8
      Env.workbench[:c] = 4
      Env.workbench[:d] = 4

      expected_output = <<~TEXT
        ┌─────────┬───┐
        │ b       │ 8 │
        │ c       │ 4 │
        │ d       │ 4 │
        │ new_key │ 3 │
        └─────────┴───┘
      TEXT

      expect { attempt_command('workbench rn a new_key') }.to output(expected_output).to_stdout
      expect(Env.workbench[:new_key]).to eq(3)
      expect(Env.workbench[:b]).to eq(8)
      expect(Env.workbench[:c]).to eq(4)
      expect(Env.workbench[:d]).to eq(4)
      expect(Env.workbench[:a]).to eq(nil)
    end

    it 'prints out error if trying to rename to already existing key' do
      Env.workbench[:a] = 3
      Env.workbench[:b] = 8
      Env.workbench[:c] = 4
      Env.workbench[:d] = 4

      expected_output = <<~TEXT
        #{"Key 'b' already exists on workbench".red}
        ┌───┬───┐
        │ a │ 3 │
        │ b │ 8 │
        │ c │ 4 │
        │ d │ 4 │
        └───┴───┘
      TEXT

      expect { attempt_command('workbench rn a b') }.to output(expected_output).to_stdout
      expect(Env.workbench[:a]).to eq(3)
      expect(Env.workbench[:b]).to eq(8)
      expect(Env.workbench[:c]).to eq(4)
      expect(Env.workbench[:d]).to eq(4)
    end

    it 'prints out error if new name was not passed' do
      Env.workbench[:a] = 3
      Env.workbench[:b] = 8
      Env.workbench[:c] = 4
      Env.workbench[:d] = 4

      expected_output = <<~TEXT
        #{"Missing #3 positional argument: 'new name'".red}
        ┌───┬───┐
        │ a │ 3 │
        │ b │ 8 │
        │ c │ 4 │
        │ d │ 4 │
        └───┴───┘
      TEXT

      expect { attempt_command('workbench rn a') }.to output(expected_output).to_stdout
      expect(Env.workbench[:a]).to eq(3)
      expect(Env.workbench[:b]).to eq(8)
      expect(Env.workbench[:c]).to eq(4)
      expect(Env.workbench[:d]).to eq(4)
    end

    it 'prints out errors if key to rename and new name were not passed' do
      Env.workbench[:a] = 3
      Env.workbench[:b] = 8
      Env.workbench[:c] = 4
      Env.workbench[:d] = 4

      expected_output = <<~TEXT
        #{"Missing #2 positional argument: 'key to rename'".red}
        #{"Missing #3 positional argument: 'new name'".red}
        ┌───┬───┐
        │ a │ 3 │
        │ b │ 8 │
        │ c │ 4 │
        │ d │ 4 │
        └───┴───┘
      TEXT

      expect { attempt_command('workbench rn') }.to output(expected_output).to_stdout
      expect(Env.workbench[:a]).to eq(3)
      expect(Env.workbench[:b]).to eq(8)
      expect(Env.workbench[:c]).to eq(4)
      expect(Env.workbench[:d]).to eq(4)
    end

    it 'prints out errors if key to rename does not exist' do
      Env.workbench[:a] = 3
      Env.workbench[:b] = 8
      Env.workbench[:c] = 4
      Env.workbench[:d] = 4

      expected_output = <<~TEXT
        #{"Key 'inexistent' does not exist on workbench".red}
        ┌───┬───┐
        │ a │ 3 │
        │ b │ 8 │
        │ c │ 4 │
        │ d │ 4 │
        └───┴───┘
      TEXT

      expect { attempt_command('workbench rn inexistent e') }.to output(expected_output).to_stdout
      expect(Env.workbench[:a]).to eq(3)
      expect(Env.workbench[:b]).to eq(8)
      expect(Env.workbench[:c]).to eq(4)
      expect(Env.workbench[:d]).to eq(4)
    end
  end
end
