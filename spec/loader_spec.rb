require 'spec_helper'

describe 'Loaders' do
  it 'returns url, params, and headers properly without extra args' do
    payload = Loaders::AverageLoader.new(ArgsHandler.parse('c average_loader')).load
    expect(payload).to eq(
      headers: {
        auth: 'Basic somethingsomethingimatoken',
        token: 'ANfikwnfkwnsiWIkfnwi2'
      },
      http_method: :POST,
      params: {
        array: [
          {
            something: true
          }
        ],
        my_param: true
      },
      url: 'https://www.mysite.com/'
    )
  end

  it 'uses pairs and workbench to overwrite payload, giving priority to pairs' do
    Env.workbench[:my_param] = 'workbench value'

    payload = Loaders::AverageLoader.new(ArgsHandler.parse('c average_loader my_param:"pair value" -wb')).load

    expect(payload[:params][:my_param]).to eq('pair value')
  end

  context 'will rise warnings if a non-defined method is called and its not in the loaders env' do
    it 'successfully' do
      payload = nil
      expected_output = <<~TEXT
        #{"Tried to find 'not_a_value' but failed.".yellow}
      TEXT

      output = capture_stdout_from do
        payload = Loaders::MissingMethodLoader.new(ArgsHandler.parse('c missing_method_loader')).load
      end

      expect(payload[:params][:my_param]).to be_nil
      expect(output).to eq(expected_output)
    end

    it 'unless the method has the same name as a given pair' do
      payload = nil

      output = capture_stdout_from do
        payload = Loaders::MissingMethodLoader.new(ArgsHandler.parse('c missing_method_loader not_a_value:"actual value"')).load
      end

      expect(payload[:params][:my_param]).to eq('actual value')
      expect(output).to be_empty
    end
  end

  context 'with traits' do
    context 'when only "default" trait is available' do
      it 'uses "default" trait' do
        payload = Loaders::DefaultTraitLoader.new(ArgsHandler.parse('c default_trait_loader')).load

        expect(payload[:params][:my_param]).to eq('default value')
      end

      it 'merges its "default" trait with its parents "default" trait, giving priority to elements defined on the child loader' do

      end
    end

    context 'when applying desired trait' do
      it 'works if desired trait name was given by workbench' do
      end

      it 'works even if its the only trait defined on loader' do
      end

      it 'merges with "default" trait, but its elements have priority over existing ones' do
      end

      it 'merges its trait with its parents trait, giving priority to elements defined on the child loader' do
      end

      it 'overwrites existing traits with pairs and workbench' do
      end
    end
  end
end
