#!/usr/bin/ruby -w
# -*- ruby -*-

require 'arbolobra/chars'
require 'test/unit'
require 'paramesan'
require 'stringio'

class CharListTest < Test::Unit::TestCase
  include Paramesan

  def self.update_array ary, idx, value
    ary.dup.tap do |a|
      a[idx] = value
    end
  end

  def self.build_expand_params
    defvalues = [ ' ', '|', '\\', '+', '-', 4 ]
    
    Array.new.tap do |params|
      params << [
        '|   ',
        false,
        Arbolobra::CharList::DEFAULT_INTRO
      ]

      params << [
        '    ',
        true,
        Arbolobra::CharList::DEFAULT_INTRO
      ]
      
      params << [
        '+---',
        false,
        Arbolobra::CharList::DEFAULT_LEAD
      ]

      params << [
        '\---',
        true,
        Arbolobra::CharList::DEFAULT_LEAD
      ]
      
    end
  end

  param_test build_expand_params do |exp, is_last, chars|
    result = chars.expand is_last
    assert_equal exp, result
  end
end
