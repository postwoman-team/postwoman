require 'spec_helper'

describe Style do
  context :table do
    it 'works' do
      allow(Readline).to receive(:get_screen_size) { [59, 200] }
      puts Style.table([['a'* 500, 'b', 'c'],['d', 'f', 'gaa'],["awddddd\nddddddd",'awddddddddd','aaaaaa']])
    end
  end
end
