require 'spec_helper'

describe Style do
  context :apply do
    it 'works successfully for wrapping tags' do
      allow(Env).to receive(:config).and_return(
        {
          theme: {
            tags: {
              h1: ["\e[38;2;227;64;107m\e[1m", "\e[m"]
            }
          }
        }
      )
      expect(Style.apply('<h1>some text I have</h1>')).to eq("\e[38;2;227;64;107m\e[1msome text I have\e[m")
    end

    it 'works successfully for boxes' do
      allow(Env).to receive(:config).and_return(
        {
          theme: {
            tags: {
              h1: ["\e[38;2;227;64;107m\e[1m", "\e[m"]
            },
            tables: {
              space_linebroken: true,
              padding: 1,
              corners: {
                top_right: '┌',
                top_left: '┐',
                bottom_right: '└',
                bottom_left: '┘'
              },
              straight: {
                vertical: '│',
                horizontal: '─'
              },
              junctions: {
                top: '┬',
                middle: '┼',
                bottom: '┴'
              }
            }
          },
        }
      )
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
