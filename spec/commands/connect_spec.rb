require 'spec_helper'

describe 'Connect command' do
  context 'with valid arguments' do
    it 'saves request to requests list' do
      response_headers = { 'Content-Type' => 'text/html', 'Content-Length' => '349', 'Date' => 'Tue, 31 Oct 2023 16:38:41 GMT', 'Server' => 'ECSF (agb/A439)' }
      response_body = <<~JSON
        {
          "title": "foo",
          "body": "bar",
          "userId": 1,
          "id": 101
        }
      JSON
      response = double(
        :response,
        status: 200,
        reason_phrase: 'OK',
        body: response_body,
        headers: response_headers,
        success?: true
      )

      faraday_args = [:get, 'http://example.org/', {}, {}]
      allow(Faraday).to receive(:run_request).with(*faraday_args).and_return(response)
      attempt_command('connect base')
      expect(Env.requests.count).to eq(1)
      expect(Env.requests.last.payload).to eq(
        {
          headers: {},
          http_method: :get,
          params: {},
          url: 'http://example.org/'
        }
      )
    end

    it 'display all info' do
      response_headers = { 'Content-Type' => 'application/json;', 'Content-Length' => '349', 'Date' => 'Tue, 31 Oct 2023 16:38:41 GMT', 'Server' => 'ECSF (agb/A439)' }
      response_body = <<~JSON
        {
          "title": "foo",
          "body": "bar",
          "userId": 1,
          "id": 101
        }
      JSON
      response = double(:response,
                        status: 200,
                        reason_phrase: 'OK',
                        body: response_body,
                        headers: response_headers,
                        success?: true)

      faraday_args = [:get, 'http://example.org/', {}, {}]
      allow(Faraday).to receive(:run_request).with(*faraday_args).and_return(response)
      expect(unstyled_stdout_from { attempt_command('connect base') }).to eq(
        <<~TEXT
          ┌──────────────────┐
          │ Loader Arguments │
          └──────────────────┘
          ┌─────────────────────────────────┐
          │ {                               │
          │   "http_method": "get",         │
          │   "url": "http://example.org/", │
          │   "params": {                   │
          │   },                            │
          │   "headers": {                  │
          │   }                             │
          │ }                               │
          │                                 │
          └─────────────────────────────────┘
          ┌─────────┐
          │ Headers │
          └─────────┘
          ┌────────────────┬───────────────────────────────┐
          │ Content-Type   │ application/json;             │
          │ Content-Length │ 349                           │
          │ Date           │ Tue, 31 Oct 2023 16:38:41 GMT │
          │ Server         │ ECSF (agb/A439)               │
          └────────────────┴───────────────────────────────┘
          ┌──────────────────────────┐
          │ Body - application/json; │
          └──────────────────────────┘
          ┌───────────────────┐
          │ {                 │
          │   "title": "foo", │
          │   "body": "bar",  │
          │   "userId": 1,    │
          │   "id": 101       │
          │ }                 │
          │                   │
          └───────────────────┘
          ┌────────────────┬─────────────────────┐
          │ Status: 200 OK │ http://example.org/ │
          └────────────────┴─────────────────────┘
        TEXT
      )
    end

    context 'does not break on empty bodies' do
      it 'has no content type' do
        response_headers = { 'Content-Length' => '349', 'Date' => 'Tue, 31 Oct 2023 16:38:41 GMT', 'Server' => 'ECSF (agb/A439)' }
        response_body = ''

        response = double(
          :response,
          status: 200,
          reason_phrase: 'OK',
          body: response_body,
          headers: response_headers,
          success?: true
        )

        faraday_args = [:get, 'http://example.org/', {}, {}]
        allow(Faraday).to receive(:run_request).with(*faraday_args).and_return(response)
        expect(unstyled_stdout_from { attempt_command('connect base -nh -nl') }).to eq(
          <<~TEXT
            ┌──────────────────┐
            │ Headers (Hidden) │
            └──────────────────┘
            ┌──────────────┐
            │ Body - Empty │
            └──────────────┘
            ┌────────────────┬─────────────────────┐
            │ Status: 200 OK │ http://example.org/ │
            └────────────────┴─────────────────────┘
          TEXT
        )
      end

      it 'has content type json' do
        response_headers = { 'Content-Type' => 'application/json;', 'Content-Length' => '349', 'Date' => 'Tue, 31 Oct 2023 16:38:41 GMT', 'Server' => 'ECSF (agb/A439)' }
        response_body = ''

        response = double(
          :response,
          status: 200,
          reason_phrase: 'OK',
          body: response_body,
          headers: response_headers,
          success?: true
        )

        faraday_args = [:get, 'http://example.org/', {}, {}]
        allow(Faraday).to receive(:run_request).with(*faraday_args).and_return(response)

        expect(unstyled_stdout_from { attempt_command('connect base -nh -nl') }).to eq(
          <<~TEXT
            ┌──────────────────┐
            │ Headers (Hidden) │
            └──────────────────┘
            ┌──────────────────────────────────┐
            │ Body - Empty - application/json; │
            └──────────────────────────────────┘
            ┌────────────────┬─────────────────────┐
            │ Status: 200 OK │ http://example.org/ │
            └────────────────┴─────────────────────┘
          TEXT
        )
      end

      it 'has content type xml' do
        response_headers = { 'Content-Type' => 'application/xml; charset=utf-8', 'Content-Length' => '349', 'Date' => 'Tue, 31 Oct 2023 16:38:41 GMT', 'Server' => 'ECSF (agb/A439)' }
        response_body = ''
        response = double(
          :response,
          status: 200,
          reason_phrase: 'OK',
          body: response_body,
          headers: response_headers,
          success?: true
        )

        faraday_args = [:get, 'http://example.org/', {}, {}]
        allow(Faraday).to receive(:run_request).with(*faraday_args).and_return(response)

        expect(unstyled_stdout_from { attempt_command('connect base -nh -nl') }).to eq(
          <<~TEXT
            ┌──────────────────┐
            │ Headers (Hidden) │
            └──────────────────┘
            ┌───────────────────────────────────────────────┐
            │ Body - Empty - application/xml; charset=utf-8 │
            └───────────────────────────────────────────────┘
            ┌────────────────┬─────────────────────┐
            │ Status: 200 OK │ http://example.org/ │
            └────────────────┴─────────────────────┘
          TEXT
        )
      end

      it 'doesnt have supported content type' do
        response_headers = { 'Content-Type' => 'unhingedcontenttype; charset=utf-8', 'Content-Length' => '349', 'Date' => 'Tue, 31 Oct 2023 16:38:41 GMT', 'Server' => 'ECSF (agb/A439)' }
        response_body = ''
        response = double(
          :response,
          status: 200,
          reason_phrase: 'OK',
          body: response_body,
          headers: response_headers,
          success?: true
        )

        faraday_args = [:get, 'http://example.org/', {}, {}]
        allow(Faraday).to receive(:run_request).with(*faraday_args).and_return(response)

        expect(unstyled_stdout_from { attempt_command('connect base -nh -nl') }).to eq(
          <<~TEXT
            ┌──────────────────┐
            │ Headers (Hidden) │
            └──────────────────┘
            ┌───────────────────────────────────────────────────┐
            │ Body - Empty - unhingedcontenttype; charset=utf-8 │
            └───────────────────────────────────────────────────┘
            ┌────────────────┬─────────────────────┐
            │ Status: 200 OK │ http://example.org/ │
            └────────────────┴─────────────────────┘
          TEXT
        )
      end
    end

    context 'when using flags' do
      it 'hides almost everything with -nl -nh -nb' do
        response_headers = { 'Content-Type' => 'application/json; charset=utf-8', 'Content-Length' => '349', 'Date' => 'Tue, 31 Oct 2023 16:38:41 GMT', 'Server' => 'ECSF (agb/A439)' }
        response_body = <<~JSON
          {
            "title": "foo",
            "body": "bar",
            "userId": 1,
            "id": 101
          }
        JSON
        response = double(:response,
                          status: 200,
                          reason_phrase: 'OK',
                          body: response_body,
                          headers: response_headers,
                          success?: true)

        faraday_args = [:get, 'http://example.org/', {}, {}]
        allow(Faraday).to receive(:run_request).with(*faraday_args).and_return(response)
        expect(unstyled_stdout_from { attempt_command('connect base -nb -nh -nl') }).to eq(
          <<~TEXT
            ┌──────────────────┐
            │ Headers (Hidden) │
            └──────────────────┘
            ┌─────────────────────────────────────────────────┐
            │ Body - application/json; charset=utf-8 (Hidden) │
            └─────────────────────────────────────────────────┘
            ┌────────────────┬─────────────────────┐
            │ Status: 200 OK │ http://example.org/ │
            └────────────────┴─────────────────────┘
          TEXT
        )
      end

      it 'hides loaders arguments with -nl' do
        response_headers = { 'Content-Type' => 'application/json;', 'Content-Length' => '349', 'Date' => 'Tue, 31 Oct 2023 16:38:41 GMT', 'Server' => 'ECSF (agb/A439)' }
        response_body = <<~JSON
          {
            "title": "foo",
            "body": "bar",
            "userId": 1,
            "id": 101
          }
        JSON
        response = double(:response,
                          status: 200,
                          reason_phrase: 'OK',
                          body: response_body,
                          headers: response_headers,
                          success?: true)

        faraday_args = [:get, 'http://example.org/', {}, {}]
        allow(Faraday).to receive(:run_request).with(*faraday_args).and_return(response)
        expect(unstyled_stdout_from { attempt_command('connect base -nl') }).to eq(
          <<~TEXT
            ┌─────────┐
            │ Headers │
            └─────────┘
            ┌────────────────┬───────────────────────────────┐
            │ Content-Type   │ application/json;             │
            │ Content-Length │ 349                           │
            │ Date           │ Tue, 31 Oct 2023 16:38:41 GMT │
            │ Server         │ ECSF (agb/A439)               │
            └────────────────┴───────────────────────────────┘
            ┌──────────────────────────┐
            │ Body - application/json; │
            └──────────────────────────┘
            ┌───────────────────┐
            │ {                 │
            │   "title": "foo", │
            │   "body": "bar",  │
            │   "userId": 1,    │
            │   "id": 101       │
            │ }                 │
            │                   │
            └───────────────────┘
            ┌────────────────┬─────────────────────┐
            │ Status: 200 OK │ http://example.org/ │
            └────────────────┴─────────────────────┘
          TEXT
        )
      end

      it 'hides headers with -nh' do
        response_headers = { 'Content-Type' => 'application/json;', 'Content-Length' => '349', 'Date' => 'Tue, 31 Oct 2023 16:38:41 GMT', 'Server' => 'ECSF (agb/A439)' }
        response_body = <<~JSON
          {
            "title": "foo",
            "body": "bar",
            "userId": 1,
            "id": 101
          }
        JSON
        response = double(:response,
                          status: 200,
                          reason_phrase: 'OK',
                          body: response_body,
                          headers: response_headers,
                          success?: true)

        faraday_args = [:get, 'http://example.org/', {}, {}]
        allow(Faraday).to receive(:run_request).with(*faraday_args).and_return(response)
        expect(unstyled_stdout_from { attempt_command('connect base -nh') }).to eq(
          <<~TEXT
            ┌──────────────────┐
            │ Loader Arguments │
            └──────────────────┘
            ┌─────────────────────────────────┐
            │ {                               │
            │   "http_method": "get",         │
            │   "url": "http://example.org/", │
            │   "params": {                   │
            │   },                            │
            │   "headers": {                  │
            │   }                             │
            │ }                               │
            │                                 │
            └─────────────────────────────────┘
            ┌──────────────────┐
            │ Headers (Hidden) │
            └──────────────────┘
            ┌──────────────────────────┐
            │ Body - application/json; │
            └──────────────────────────┘
            ┌───────────────────┐
            │ {                 │
            │   "title": "foo", │
            │   "body": "bar",  │
            │   "userId": 1,    │
            │   "id": 101       │
            │ }                 │
            │                   │
            └───────────────────┘
            ┌────────────────┬─────────────────────┐
            │ Status: 200 OK │ http://example.org/ │
            └────────────────┴─────────────────────┘
          TEXT
        )
      end

      it 'hides body with -nb' do
        response_headers = { 'Content-Type' => 'application/json;', 'Content-Length' => '349', 'Date' => 'Tue, 31 Oct 2023 16:38:41 GMT', 'Server' => 'ECSF (agb/A439)' }
        response_body = <<~JSON
          {
            "title": "foo",
            "body": "bar",
            "userId": 1,
            "id": 101
          }
        JSON
        response = double(:response,
                          status: 200,
                          reason_phrase: 'OK',
                          body: response_body,
                          headers: response_headers,
                          success?: true)

        faraday_args = [:get, 'http://example.org/', {}, {}]
        allow(Faraday).to receive(:run_request).with(*faraday_args).and_return(response)
        expect(unstyled_stdout_from { attempt_command('connect base -nb') }).to eq(
          <<~TEXT
            ┌──────────────────┐
            │ Loader Arguments │
            └──────────────────┘
            ┌─────────────────────────────────┐
            │ {                               │
            │   "http_method": "get",         │
            │   "url": "http://example.org/", │
            │   "params": {                   │
            │   },                            │
            │   "headers": {                  │
            │   }                             │
            │ }                               │
            │                                 │
            └─────────────────────────────────┘
            ┌─────────┐
            │ Headers │
            └─────────┘
            ┌────────────────┬───────────────────────────────┐
            │ Content-Type   │ application/json;             │
            │ Content-Length │ 349                           │
            │ Date           │ Tue, 31 Oct 2023 16:38:41 GMT │
            │ Server         │ ECSF (agb/A439)               │
            └────────────────┴───────────────────────────────┘
            ┌───────────────────────────────────┐
            │ Body - application/json; (Hidden) │
            └───────────────────────────────────┘
            ┌────────────────┬─────────────────────┐
            │ Status: 200 OK │ http://example.org/ │
            └────────────────┴─────────────────────┘
          TEXT
        )
      end
    end
  end

  context 'prints out error when' do
    it 'tries to run non-existent loader' do
      expect(unstyled_stdout_from { attempt_command('connect my_loader') }).to eq(
        <<~TEXT
          No loader found: 'MyLoader'
        TEXT
      )
    end

    it 'doesnt receive name' do
      expect(unstyled_stdout_from { attempt_command('connect') }).to eq(
        <<~TEXT
          Missing #1 positional argument: 'loader_name'
        TEXT
      )
    end

    it 'tries to run loader but raise error' do
      MockLoader = Class.new

      allow(Loaders).to receive(:class_eval).with('MockLoader').and_return(MockLoader)

      output = unstyled_stdout_from { attempt_command('connect mock_loader') }
      expect(output).to include("Your loader 'MockLoader' raised an exception:")
      expect(output).to include('wrong number of arguments (given 1, expected 0)')
    end

    it 'tries to run loader but faraday raises error' do
      faraday_args = [:get, 'http://example.org/', {}, {}]
      allow(Faraday).to receive(:run_request).with(*faraday_args).and_raise(Exception)

      output = unstyled_stdout_from { attempt_command('connect base') }

      expect(output).to include('Faraday requisition failed:')
      expect(output).to include('Exception')

      expect(Env.requests.count).to eq(0)
    end
  end
end
