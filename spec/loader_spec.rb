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
        payload = Loaders::DefaultTraitLoaderChild.new(ArgsHandler.parse('c default_trait_child_loader')).load

        expect(payload[:params][:my_param]).to eq('default value child')
      end
    end

    context 'when applying desired trait' do
      it 'priorities goes as following: parents default, childs default, parents trait, childs trait, workbench, pairs' do
        Env.workbench[:my_trait] = nil

        Env.workbench[:workbench_will_change_on_pair] = '[workbench]>[pair]'
        Env.workbench[:parent_default_will_change_on_pair] = '[parent_default]>[pair]overwrite fail'
        Env.workbench[:parent_trait_will_change_on_pair] = '[parent_trait]>[pair]overwrite fail'
        Env.workbench[:child_default_will_change_on_pair] = '[child_default]>[pair]overwrite fail'

        Env.workbench[:parent_default_will_change_on_workbench] = '[parent_default]>[workbench] REACHED'
        Env.workbench[:parent_trait_will_change_on_workbench] = '[parent_trait]>[workbench] REACHED'
        Env.workbench[:child_default_will_change_on_workbench] = '[child_default]>[workbench] REACHED'
        Env.workbench[:child_trait_will_change_on_workbench] = '[child_trait]>[workbench] REACHED'
        Env.workbench[:workbench_will_change_on_workbench] = '[workbench]>[workbench] REACHED'

        payload = Loaders::CompleteLoader.new(ArgsHandler.parse('c complete_loader parent_default_will_change_on_pair:"[parent_default]>[pair] REACHED" parent_trait_will_change_on_pair:"[parent_trait]>[pair] REACHED" child_default_will_change_on_pair:"[child_default]>[pair] REACHED" child_trait_will_change_on_pair:"[child_trait]>[pair] REACHED" workbench_will_change_on_pair:"[workbench]>[pair] REACHED" pair_will_change_on_pair:"[pair]>[pair] REACHED" -wb')).load
        trait_params = payload[:params][:trait_params]

        # pairs
        expect(trait_params[:parent_default_will_change_on_pair]).to eq('[parent_default]>[pair] REACHED')
        expect(trait_params[:parent_trait_will_change_on_pair]).to eq('[parent_trait]>[pair] REACHED')
        expect(trait_params[:child_default_will_change_on_pair]).to eq('[child_default]>[pair] REACHED')
        expect(trait_params[:child_trait_will_change_on_pair]).to eq('[child_trait]>[pair] REACHED')
        expect(trait_params[:workbench_will_change_on_pair]).to eq('[workbench]>[pair] REACHED')
        expect(trait_params[:pair_will_change_on_pair]).to eq('[pair]>[pair] REACHED')

        # workbench
        expect(trait_params[:parent_default_will_change_on_workbench]).to eq('[parent_default]>[workbench] REACHED')
        expect(trait_params[:parent_trait_will_change_on_workbench]).to eq('[parent_trait]>[workbench] REACHED')
        expect(trait_params[:child_default_will_change_on_workbench]).to eq('[child_default]>[workbench] REACHED')
        expect(trait_params[:child_trait_will_change_on_workbench]).to eq('[child_trait]>[workbench] REACHED')
        expect(trait_params[:workbench_will_change_on_workbench]).to eq('[workbench]>[workbench] REACHED')

        # child_trait
        expect(trait_params[:parent_default_will_change_on_child_trait]).to eq('[parent_default]>[child_trait] REACHED')
        expect(trait_params[:parent_trait_will_change_on_child_trait]).to eq('[parent_trait]>[child_trait] REACHED')
        expect(trait_params[:child_default_will_change_on_child_trait]).to eq('[child_default]>[child_trait] REACHED')
        expect(trait_params[:child_trait_will_change_on_child_trait]).to eq('[child_trait]>[child_trait] REACHED')

        # parent_trait
        expect(trait_params[:parent_default_will_change_on_parent_trait]).to eq('[parent_default]>[parent_trait] REACHED')
        expect(trait_params[:parent_trait_will_change_on_parent_trait]).to eq('[parent_trait]>[parent_trait] REACHED')
        expect(trait_params[:child_default_will_change_on_parent_trait]).to eq('[child_default]>[parent_trait] REACHED')

        # child_default
        expect(trait_params[:parent_default_will_change_on_child_default]).to eq('[parent_default]>[child_default] REACHED')
        expect(trait_params[:child_default_will_change_on_child_default]).to eq('[child_default]>[child_default] REACHED')

        # parent_default
        expect(trait_params[:parent_default_will_change_on_parent_default]).to eq('[parent_default]>[parent_default] REACHED')
      end
    end
  end
end
