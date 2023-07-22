require 'spec_helper'

describe 'Workbenchpush command' do 
  context 'sets a key from the last request on workbench' do
    it 'when the given key exists on a simple hash' do 
      fake_request = double(
        'Request::000000', 
        parsed_body: { "id" => "1", "foo" => "bar" }
      )
      Env.requests.append(fake_request)
      allow(fake_request).to receive(:response_json?).and_return(true)
  
      expected_output = <<~TEXT 
      #{'Pulled "foo" :>'.green}
      ┌─────┬───────┐
      │ foo │ "#{'bar'.yellow}" │
      └─────┴───────┘
      TEXT
  
      output = capture_stdout_from { attempt_command('wbp foo') }
      expect(output).to eq expected_output
    end

    it 'when the given key exists on a nested hash' do 
      fake_request = double(
        'Request::000000', 
        parsed_body: { "id" => "1", "ziggs" => { "foo" => "bar" } }
      )
      Env.requests.append(fake_request)
      allow(fake_request).to receive(:response_json?).and_return(true)
  
      expected_output = <<~TEXT 
      #{'Pulled "foo" :>'.green}
      ┌─────┬───────┐
      │ foo │ "#{'bar'.yellow}" │
      └─────┴───────┘
      TEXT
  
      output = capture_stdout_from { attempt_command('wbp foo') }
      expect(output).to eq expected_output
    end

    it 'when the given key exists on an array' do 
      fake_request = double(
        'Request::000000', 
        parsed_body: { "id" => "1", "ziggs" => [{ "foo" => "bar" }] }
      )
      Env.requests.append(fake_request)
      allow(fake_request).to receive(:response_json?).and_return(true)
  
      expected_output = <<~TEXT 
      #{'Pulled "foo" :>'.green}
      ┌─────┬───────┐
      │ foo │ "#{'bar'.yellow}" │
      └─────┴───────┘
      TEXT
  
      output = capture_stdout_from { attempt_command('wbp foo') }
      expect(output).to eq expected_output
    end
  end
end