require 'spec_helper'

describe Style do
  context :apply do
    it 'works successfully for wrapping tags' do
      expect(Style.apply('<h1>some text I have</h1>')).to eq("\e[38;2;227;64;107m\e[1msome text I have\e[m")
    end

    it 'works successfully for boxes' do
      expect(Style.apply('<box><h1>some text I have<h1></box>')).to eq(
        <<~TEXT
          ┌──────────────────┐
          │ \e[38;2;227;64;107m\e[1msome text I have\e[m\e[m │
          └──────────────────┘
        TEXT
      )
    end

    it 'works successfully for standalone tags' do
      expect(Style.apply('Some text I have<br>')).to eq("Some text I have\n")
    end

    it 'unescapes "&" character succesfully' do
      expect(Style.apply('<box>Something && thing</box>')).to eq(
        <<~TEXT
          ┌───────────────────┐
          │ Something & thing │
          └───────────────────┘
        TEXT
      )
    end

    it 'unescapes "<" character succesfully' do
      expect(Style.apply('Look!<br><box>XML: &h1>title&/h1></box>&h2>Outside the box&/h2>')).to eq(
        <<~TEXT
          Look!
          ┌─────────────────────┐
          │ XML: <h1>title</h1> │
          └─────────────────────┘
          <h2>Outside the box</h2>
        TEXT
        .chomp
      )
    end
  end
end
