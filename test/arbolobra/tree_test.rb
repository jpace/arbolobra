#!/usr/bin/ruby -w
# -*- ruby -*-

require 'arbolobra/tree'
require 'test/unit'
require 'paramesan'

class TreeTest < Test::Unit::TestCase
  include Paramesan

  def self.nn value, *children
    Arbolobra::Node.new value, children
  end

  def self.build_params
    Array.new.tap do |params|
      params << [ nn(nil,
                     nn("abc")),

                  Array.new.tap do |a|
                    a << "abc"
                  end
                ]
      
      params << [ nn(nil,
                     nn("abc"),
                     nn("def")),

                  Array.new.tap do |a|
                    a << "abc"
                    a << "def"
                  end
                ]

      params << [ nn(nil,
                     nn("abc",
                        nn("def",
                           nn("ghi"), nn("jkl")),
                        nn("ghi")),
                     
                     nn("def",
                        nn("ghi",
                           nn("2"),
                           nn("3"))),

                     nn("abc",
                        nn("mno"))),

                  Array.new.tap do |a|
                    a << "abc/def/ghi"
                    a << "abc/def/jkl"
                    a << "abc/ghi"
                    a << "def/ghi"
                    a << "def/ghi/2"
                    a << "def/ghi/3"
                    a << "abc/mno"
                  end
                ]
    end
  end

  param_test build_params do |exp, lines|
    tree = Arbolobra::Tree.new lines
    root = tree.root
    assert_equal exp, root, "lines: #{lines}"
  end
end
