require 'spec_helper'

describe 'Loaders' do
  it 'returns url, params, and headers properly without extra args' do
    payload = Loaders::Average.new(ArgsHandler.parse('c average')).load
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

  context 'payload can change because of' do
    it 'payload being overwritten by parent loader "default" trait' do
      ParentLoader = Class.new(Loaders::Average)
      ParentLoader.trait(:default, my_param: 'parent trait value')

      Loader = Class.new(ParentLoader)

      payload = Loader.new(ArgsHandler.parse('c loader')).load

      expect(payload[:params][:my_param]).to eq('parent trait value')
    end

    it 'parent loader "default" trait being overwritten by loader "default" trait' do
      ParentLoader = Class.new(Loaders::Average)
      ParentLoader.trait(:default, my_param: 'parent trait value')

      Loader = Class.new(ParentLoader)
      Loader.trait(:default, my_param: 'trait value')

      payload = Loader.new(ArgsHandler.parse('c loader')).load

      expect(payload[:params][:my_param]).to eq('trait value')
    end

    it 'loader "default" trait being overwritten by parent loader custom trait' do
      ParentLoader = Class.new(Loaders::Average)
      ParentLoader.trait(:my_trait, my_param: 'parent trait value')

      Loader = Class.new(ParentLoader)
      Loader.trait(:default, my_param: 'trait value')

      payload = Loader.new(ArgsHandler.parse('c loader my_trait:')).load

      expect(payload[:params][:my_param]).to eq('parent trait value')
    end

    it 'parent loader custom trait being overwritten by loader custom trait' do
      ParentLoader = Class.new(Loaders::Average)
      ParentLoader.trait(:my_trait, my_param: 'parent trait value')

      Loader = Class.new(ParentLoader)
      Loader.trait(:my_trait, my_param: 'trait value')

      payload = Loader.new(ArgsHandler.parse('c loader my_trait:')).load

      expect(payload[:params][:my_param]).to eq('trait value')
    end

    it 'loader custom trait being overwritten by workbench' do
      Loader = Class.new(Loaders::Average)
      Loader.trait(:my_trait, my_param: 'trait value')
      Env.workbench[:my_param] = 'workbench value'

      payload = Loader.new(ArgsHandler.parse('c loader my_trait: -wb')).load

      expect(payload[:params][:my_param]).to eq('workbench value')
    end

    it 'workbench being overwritten by pairs' do
      Env.workbench[:my_param] = 'workbench value'

      payload = Loaders::Average.new(ArgsHandler.parse('c average my_param:"pair value" -wb')).load

      expect(payload[:params][:my_param]).to eq('pair value')
    end
  end

  context 'will rise warnings if a non-defined method is called and its not in the loaders env' do
    it 'successfully' do
      payload = nil
      expected_output = <<~TEXT
        #{"Tried to find 'not_a_value' but failed.".yellow}
      TEXT

      output = capture_stdout_from do
        payload = Loaders::MissingMethod.new(ArgsHandler.parse('c missing_method_loader')).load
      end

      expect(payload[:params][:my_param]).to be_nil
      expect(output).to eq(expected_output)
    end

    it 'unless the method has the same name as a given pair' do
      payload = nil

      output = capture_stdout_from do
        payload = Loaders::MissingMethod.new(ArgsHandler.parse('c missing_method_loader not_a_value:"actual value"')).load
      end

      expect(payload[:params][:my_param]).to eq('actual value')
      expect(output).to be_empty
    end
  end

  context 'traits merging' do
    it 'merges its "default" trait with its parents "default" trait, giving priority to elements defined on the child loader' do
      ParentLoader = Class.new(Loaders::Average)
      ParentLoader.trait(:default, my_param: 'parent trait value', array: [{something: 'parent trait value for something'}])

      Loader = Class.new(ParentLoader)
      Loader.trait(:default, my_param: 'trait value')

      payload = Loader.new(ArgsHandler.parse('c default_trait_child_loader')).load

      expect(payload[:params]).to eq({
        array: [
          {
            something: 'parent trait value for something'
          }
        ],
        my_param: 'trait value'
      })
    end

    it 'merges its custom trait with its parents custom trait, giving priority to elements defined on the child loader' do
      ParentLoader = Class.new(Loaders::Average)
      ParentLoader.trait(:my_trait, my_param: 'parent trait value', array: [{something: 'parent trait value for something'}])

      Loader = Class.new(ParentLoader)
      Loader.trait(:my_trait, my_param: 'trait value')

      payload = Loader.new(ArgsHandler.parse('c default_trait_child_loader my_trait:')).load

      expect(payload[:params]).to eq({
        array: [
          {
            something: 'parent trait value for something'
          }
        ],
        my_param: 'trait value'
      })
    end
  end
end
