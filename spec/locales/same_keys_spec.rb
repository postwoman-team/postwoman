require 'spec_helper'

def nullified(hash)
  hash.transform_values do |value|
    value.is_a?(Hash) ? nullified(value) : nil
  end
end

describe I18n do
  it 'has same keys on all locales' do
    key_groups = {}
    I18n.available_locales.each do |locale|
      key_groups[locale] = JSON.pretty_generate(nullified(I18n.t('.', locale: locale)))
    end

    last_key_group = key_groups.values.first
    last_locale = key_groups.keys.first

    key_groups.each do |locale, key_group|
      expect(key_group).to eq(last_key_group), "[#{key_group.length < last_key_group.length ? locale : last_locale}] locale has diff"

      last_key_group = key_group
    end
  end
end
