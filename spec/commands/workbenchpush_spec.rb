require 'spec_helper'

describe 'Workbenchpush command' do 
  context 'When the user executes the command' do 
    context 'sets a key from the last request on workbench' do
      it 'when the given key exists on a simple hash' do 
        fake_request = double(
          'Request::000000', 
          parsed_body: { "id" => "1", "foo" => "bar" }
        )
        Env.requests.append(fake_request)
        allow(fake_request).to receive(:body_as_hash).and_return(fake_request.parsed_body)
    
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
        allow(fake_request).to receive(:body_as_hash).and_return(fake_request.parsed_body)
    
        expected_output = <<~TEXT 
        #{'Pulled "foo" :>'.green}
        ┌─────┬───────┐
        │ foo │ "#{'bar'.yellow}" │
        └─────┴───────┘
        TEXT
    
        output = capture_stdout_from { attempt_command('wbp foo') }
        expect(output).to eq expected_output
      end
  
      it 'when the given key exists on a two-level nested hash' do 
        fake_request = double(
          'Request::000000', 
          parsed_body: { "id" => "1", "ziggs" => { "bra" => { "foo" => "bar" } } }
        )
        Env.requests.append(fake_request)
        allow(fake_request).to receive(:body_as_hash).and_return(fake_request.parsed_body)
    
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
        allow(fake_request).to receive(:body_as_hash).and_return(fake_request.parsed_body)
    
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

    context 'and there are no requests' do 
      it 'returns an error message to stdout' do 
        expected_output = <<~TEXT
        #{'Cant pull desired values because no requests were made at the moment.'.yellow}
        ┌─────────────────┐
        │ Currently empty │
        └─────────────────┘
        TEXT

        output = capture_stdout_from { attempt_command('wbp foo') }
        expect(output).to eq expected_output
      end
    end

    context 'and the user gives an inexistent key' do 
      it 'returns an error message to the stdout' do 
        fake_request = double(
          'Request::000000', 
          parsed_body: { "id" => "1", "foo" => "bar" }
        )
        Env.requests.append(fake_request)
        allow(fake_request).to receive(:body_as_hash).and_return(fake_request.parsed_body)
    
        expected_output = <<~TEXT
        #{'Couldnt pull "orange" :<'.yellow}
        ┌─────────────────┐
        │ Currently empty │
        └─────────────────┘
        TEXT
    
        output = capture_stdout_from { attempt_command('wbp orange') }
        expect(output).to eq expected_output
      end
    end

    context 'and the user doesnt give a key as a positional' do 
      it 'returns the current items from workbench to stdout' do 
        expected_output = <<~TEXT
        ┌─────────────────┐
        │ Currently empty │
        └─────────────────┘
        TEXT
  
        output = capture_stdout_from { attempt_command('wbp') }
        expect(output).to eq expected_output
      end
    end
  end
end