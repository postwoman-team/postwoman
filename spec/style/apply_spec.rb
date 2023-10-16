require 'spec_helper'

describe Style do
  context :apply do
    it 'works successfully for wrapping tags' do
      expect(Style.apply('<h1>some text I have</h1>')).to eq("\e[38;2;227;64;107m\e[1msome text I have\e[m")
    end

    it 'works successfully for standalone tags' do
      expect(Style.apply('Some text I have<br>')).to eq("Some text I have\n")
    end

    it 'unescapes & character succesfully' do
      expect(Style.apply('Something && thing')).to eq('Something & thing')
    end

    it 'unescapes < character succesfully' do
      expect(Style.apply('Look! XML: &a>&a/>')).to eq('Look! XML: <a><a/>')
    end
  end
end
