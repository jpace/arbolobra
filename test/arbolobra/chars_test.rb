#!/usr/bin/ruby -w
# -*- ruby -*-

require 'arbolobra/chars'
require 'test/unit'
require 'paramesan'
require 'stringio'

class CharsTest < Test::Unit::TestCase
  include Paramesan

  def self.update_array ary, idx, value
    ary.dup.tap do |a|
      a[idx] = value
    end
  end

  def self.build_init_params
    defvalues = [ ' ', '|', '\\', '+', '-', 4 ]
    
    Array.new.tap do |params|
      params << [
        defvalues,
        Arbolobra::Chars.new
      ]

      params << [
        update_array(defvalues, 0, '_'),
        Arbolobra::Chars.new(down_from_last: '_')
      ]
      
      params << [
        update_array(defvalues, 1, '*'),
        Arbolobra::Chars.new(down_to_next: '*')
      ]
      
      params << [
        update_array(defvalues, 2, '#'),
        Arbolobra::Chars.new(marker_to_last: '#')
      ]
      
      params << [
        update_array(defvalues, 3, 'X'),
        Arbolobra::Chars.new(marker_to_child: 'X')
      ]

      params << [
        update_array(defvalues, 4, '.'),
        Arbolobra::Chars.new(over_to_child: '.')
      ]

      params << [
        update_array(defvalues, 5, 3),
        Arbolobra::Chars.new(width: 3)
      ]
    end
  end

  param_test build_init_params do |exp, chars|
    assert_equal exp[0], chars.down_from_last
    assert_equal exp[1], chars.down_to_next
    assert_equal exp[2], chars.marker_to_last
    assert_equal exp[3], chars.marker_to_child
    assert_equal exp[4], chars.over_to_child
    assert_equal exp[5], chars.width
  end

  def self.build_format_params
    Array.new.tap do |params|
      params << [
        "+---abc",
        "abc",
        { indent: 1 },
        Arbolobra::Chars.new
      ]

      params << [
        "+-------abc",
        "abc",
        { indent: 2 },
        Arbolobra::Chars.new
      ]

      params << [
        "+-abc",
        "abc",
        { indent: 1 },
        Arbolobra::Chars.new(width: 2)
      ]

      params << [
        "+-abc",
        "abc",
        { indent: 1 },
        Arbolobra::Chars.new(width: 2)
      ]

      params << [
        "\\---abc",
        "abc",
        { indent: 1, is_last: true },
        Arbolobra::Chars.new
      ]
    end
  end

  param_test build_format_params do |exp, str, args, chars|
    result = chars.format str, args
    assert_equal exp, result, "args: #{args}"
  end


  def self.build_expand_params
    Array.new.tap do |params|
      params << [
        "abbb",
        "a", "b",
        Arbolobra::Chars.new
      ]

      params << [
        "cddd",
        "c", "d",
        Arbolobra::Chars.new
      ]

      params << [
        "ab",
        "a", "b",
        Arbolobra::Chars.new(width: 2)
      ]
    end
  end

  param_test build_expand_params do |exp, leftch, repeatchr, chars|
    result = chars.expand leftch, repeatchr
    assert_equal exp, result, "leftch: #{leftch}; repeatchr: #{repeatchr}"
  end
end
