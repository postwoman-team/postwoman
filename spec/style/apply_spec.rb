require 'spec_helper'

describe Style do
  context :apply do
    it 'works successfully for wrapping tags' do
      expect { puts 'a' } .to stdout_colored('a')
      expect(Style.apply('<h1>some text I have</h1>')).to eq("\e[38;2;249;38;114msome text I have\e[m")
    end

    it 'works successfully for standalone tags' do
      expect(Style.apply('Some text I have<br>')).to eq("Some text I have\n")
    end

    it 'works successfully for nested tags' do
      expect(Style.apply('<h1>Some text <highlight>I</highlight> have<br></h1>')).to eq("\e[38;2;249;38;114mSome text \e[38;2;174;129;255mI\e[m have\n\e[m")
    end

    it 'unescapes & character succesfully' do
      expect(Style.apply('Something && thing')).to eq('Something & thing')
    end

    it 'unescapes < character succesfully' do
      expect(Style.apply('Look! XML: &a>&a/>')).to eq('Look! XML: <a><a/>')
    end

    it 'auto-wraps received string in a <body>' do
      allow(Env).to receive(:config).and_return({'theme' => {'tags' => {'body' => ['[', ']']}}})
      expect(Style.apply('some text I have')).to eq('[some text I have]')
    end
  end
end
