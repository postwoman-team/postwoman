require 'spec_helper'

describe Style do
  context :protect do
    it 'escapes & character' do
      expect(Style.protect('Something & thing')).to eq('Something && thing')
    end

    it 'escapes < character' do
      expect(Style.protect('my xml is <this></this>')).to eq("my xml is &this>&/this>")
    end

    it 'works on any object, but runs #to_s on it first' do
      expect(Style.protect({a: 2})).to eq("{:a=>2}")
    end
  end
end
