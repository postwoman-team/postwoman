require 'spec_helper'

describe 'Loaders' do
  it 'succesfully returns url, params, and headers' do
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

  context 'payload can change because' do
    it 'has payload being overwritten by parent loader "default" trait' do
      ParentLoader = Class.new(Loaders::Average)
      ParentLoader.trait(:default, my_param: 'parent trait value')

      Loader = Class.new(ParentLoader)

      payload = Loader.new(ArgsHandler.parse('c loader')).load

      expect(payload[:params][:my_param]).to eq('parent trait value')
    end

    it 'has parent loader "default" trait being overwritten by loader "default" trait' do
      ParentLoader2 = Class.new(Loaders::Average)
      ParentLoader2.trait(:default, my_param: 'parent trait value')

      Loader2 = Class.new(ParentLoader2)
      Loader2.trait(:default, my_param: 'trait value')

      payload = Loader2.new(ArgsHandler.parse('c loader')).load

      expect(payload[:params][:my_param]).to eq('trait value')
    end

    it 'has loader "default" trait being overwritten by parent loader custom trait' do
      ParentLoader3 = Class.new(Loaders::Average)
      ParentLoader3.trait(:my_trait, my_param: 'parent trait value')

      Loader3 = Class.new(ParentLoader3)
      Loader3.trait(:default, my_param: 'trait value')

      payload = Loader3.new(ArgsHandler.parse('c loader my_trait:')).load

      expect(payload[:params][:my_param]).to eq('parent trait value')
    end

    it 'has parent loader custom trait being overwritten by loader custom trait' do
      ParentLoader4 = Class.new(Loaders::Average)
      ParentLoader4.trait(:my_trait, my_param: 'parent trait value')

      Loader4 = Class.new(ParentLoader4)
      Loader4.trait(:my_trait, my_param: 'trait value')

      payload = Loader4.new(ArgsHandler.parse('c loader my_trait:')).load

      expect(payload[:params][:my_param]).to eq('trait value')
    end

    it 'has loader custom trait being overwritten by workbench' do
      Loader5 = Class.new(Loaders::Average)
      Loader5.trait(:my_trait, my_param: 'trait value')
      Env.workbench[:my_param] = 'workbench value'

      payload = Loader5.new(ArgsHandler.parse('c loader my_trait: -wb')).load

      expect(payload[:params][:my_param]).to eq('workbench value')
    end

    it 'has workbench being overwritten by pairs' do
      Env.workbench[:my_param] = 'workbench value'

      payload = Loaders::Average.new(ArgsHandler.parse('c average my_param:"pair value" -wb')).load

      expect(payload[:params][:my_param]).to eq('pair value')
    end
  end

  context 'when a non-defined method is called and its not in the loaders env' do
    it 'will rise warnings' do
      payload = nil
      expected_output = "Tried to find 'not_a_value' but failed."

      output = unstyled_stdout_from do
        payload = Loaders::MissingMethod.new(ArgsHandler.parse('c missing_method_loader')).load
      end.chomp

      expect(payload[:params][:my_param]).to be_nil
      expect(output).to eq(expected_output)
    end

    it 'wont rise warning when the method has the same name as a input pair' do
      payload = nil

      output = unstyled_stdout_from do
        payload = Loaders::MissingMethod.new(ArgsHandler.parse('c missing_method_loader not_a_value:"actual value"')).load
      end

      expect(payload[:params][:my_param]).to eq('actual value')
      expect(output).to be_empty
    end
  end

  context 'when trait merging' do
    it 'merges its "default" trait with its parents "default" trait, giving priority to elements defined on the child loader' do
      ParentLoader6 = Class.new(Loaders::Average)
      ParentLoader6.trait(:default, my_param: 'parent trait value', array: [{something: 'parent trait value for something'}])

      Loader6 = Class.new(ParentLoader6)
      Loader6.trait(:default, my_param: 'trait value')

      payload = Loader6.new(ArgsHandler.parse('c default_trait_child_loader')).load

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
      ParentLoader7 = Class.new(Loaders::Average)
      ParentLoader7.trait(:my_trait, my_param: 'parent trait value', array: [{something: 'parent trait value for something'}])

      Loader7 = Class.new(ParentLoader7)
      Loader7.trait(:my_trait, my_param: 'trait value')

      payload = Loader7.new(ArgsHandler.parse('c default_trait_child_loader my_trait:')).load

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
