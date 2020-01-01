#!/usr/bin/ruby -w
# -*- ruby -*-

require 'arbolobra/chars'
require 'test/unit'
require 'paramesan'

class CharListTest < Test::Unit::TestCase
  include Paramesan

  param_test [
      [ '|   ', false, Arbolobra::CharList::DEFAULT_INTRO ], 
      [ '    ', true,  Arbolobra::CharList::DEFAULT_INTRO ], 
      [ '+---', false, Arbolobra::CharList::DEFAULT_LEAD  ],  
      [ '\---', true,  Arbolobra::CharList::DEFAULT_LEAD  ],  
  ] do |exp, is_last, chars|
    result = chars.expand is_last
    assert_equal exp, result
  end
end
