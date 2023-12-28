require 'spec_helper'

describe 'New command' do
  context 'when creating loaders' do
    it 'creates new loader with template and opens on default editor when loader does not already exist' do
      template = <<~TEXT
        module Loaders
          class Testing < Base
            private

            def http_method
              :GET
            end

            def url
              ''
            end

            def params
              {}
            end

            def headers
              default_headers
            end
          end
        end
      TEXT

      Dir.mkdir(File.join(Dir.home, '.postwoman'))
      File.write(File.join(Dir.home, '.postwoman/config.yml'), YAML.dump({ editor: 'emacs' }))
      Env.refresh_config

      expect(Editor).to receive(:system).with('emacs loaders/testing.rb')
      expect(unstyled_stdout_from { attempt_command('new l testing') }).to eq(
        <<~TEXT
          ┌────────────────────────┐
          │ Creating new loader... │
          └────────────────────────┘
        TEXT
      )
      expect(File).to exist('loaders/testing.rb')
      expect(File.read('loaders/testing.rb')).to eq(template)
    end

    it 'edits existing loader on default editor when loader already exists' do
      Dir.mkdir(File.join(Dir.home, '.postwoman'))
      File.write(File.join(Dir.home, '.postwoman/config.yml'), YAML.dump({ editor: 'emacs' }))
      Env.refresh_config

      File.write('loaders/testing.rb', 'does not matter')

      expect(Editor).to receive(:system).with('emacs loaders/testing.rb')
      expect(File).to_not receive(:open).with('loaders/testing.rb')
      expect(File).to_not receive(:write).with('loaders/testing.rb')
      expect(unstyled_stdout_from { attempt_command('new l testing') }).to eq(
        <<~TEXT
          ┌───────────────────┐
          │ Editing loader... │
          └───────────────────┘
        TEXT
      )
    end

    it 'outputs error message when loader name is not provided' do
      expect(unstyled_stdout_from { attempt_command('new l') }).to eq(
        <<~TEXT
          Missing #2 positional argument: 'name'
        TEXT
      )
    end

    it 'treats loader name to be downcased' do
      Dir.mkdir(File.join(Dir.home, '.postwoman'))
      File.write(File.join(Dir.home, '.postwoman/config.yml'), YAML.dump({ editor: 'emacs' }))
      Env.refresh_config

      File.write('loaders/testing2.rb', 'does not matter')

      expect(Editor).to receive(:system).with('emacs loaders/testing2.rb')
      attempt_command('new l Testing2')
    end

    context 'outputs error message when loader name is not valid because' do
      it 'uses kebab case' do
        expect(unstyled_stdout_from { attempt_command('new l im-bad-kebab-case') }).to eq(
          <<~TEXT
            Invalid loader name 'im-bad-kebab-case'
          TEXT
        )
      end

      it 'starts terms with numbers' do
        expect(unstyled_stdout_from { attempt_command('new l wrong_1') }).to eq(
          <<~TEXT
            Invalid loader name 'wrong_1'
          TEXT
        )
      end

      it 'has invalid characters' do
        expect(unstyled_stdout_from { attempt_command('new l wrong!') }).to eq(
          <<~TEXT
            Invalid loader name 'wrong!'
          TEXT
        )
      end
    end

    context 'when default editor is not set' do
      it 'outputs message after loader creation' do
        Dir.mkdir(File.join(Dir.home, '.postwoman'))
        File.write(File.join(Dir.home, '.postwoman/config.yml'), YAML.dump({ editor: nil }))
        Env.refresh_config

        expect(unstyled_stdout_from { attempt_command('new l testing') }).to eq(
          <<~TEXT
            ┌────────────────────────┐
            │ Creating new loader... │
            └────────────────────────┘
            The setting 'editor' has not been set to open the target file
          TEXT
        )
        expect(File).to exist('loaders/testing.rb')
      end

      it 'outputs message after trying to edit loader' do
        Dir.mkdir(File.join(Dir.home, '.postwoman'))
        File.write(File.join(Dir.home, '.postwoman/config.yml'), YAML.dump({ editor: nil }))
        Env.refresh_config

        File.write('loaders/testing.rb', 'does not matter')

        expect(Editor).to_not receive(:system)
        expect(unstyled_stdout_from { attempt_command('new l testing') }).to eq(
          <<~TEXT
            ┌───────────────────┐
            │ Editing loader... │
            └───────────────────┘
            The setting 'editor' has not been set to open the target file
          TEXT
        )
      end
    end
  end
end
