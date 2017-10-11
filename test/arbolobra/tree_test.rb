#!/usr/bin/ruby -w
# -*- ruby -*-

require 'test/unit'
require 'arbolobra/tree'
require 'pp'
require 'paramesan'

Logue::Log.level = Logue::Log::DEBUG

class TreeTest < Test::Unit::TestCase
  include Logue::Loggable
  include Paramesan

  def self.newnode value, *children
    Arbolobra::Node.new value, children
  end

  def self.build_params
    Array.new.tap do |params|
      lines = Array.new
      lines << "abc"
      root = newnode nil, [ newnode("abc") ]
      
      params << [ newnode(nil,
                          newnode("abc")),
                  lines ]

      lines = Array.new
      lines << "abc"
      lines << "def"

      params << [ newnode(nil,
                          newnode("abc"),
                          newnode("def")),
                  lines ]

      lines = Array.new
      lines << "abc/def/ghi"
      lines << "abc/def/jkl"
      lines << "abc/ghi"
      lines << "def/ghi"
      lines << "def/ghi/2"
      lines << "def/ghi/3"
      lines << "abc/mno"

      root = newnode(nil,
                     newnode("abc",
                             newnode("def",
                                     newnode("ghi"), newnode("jkl")),
                             newnode("ghi")),
                     
                     newnode("def",
                             newnode("ghi",
                                     newnode("2"),
                                     newnode("3"))),

                     newnode("abc",
                             newnode("mno")))

      params << [ root, lines ]
      
    end
  end

  param_test build_params do |exp, lines|
    # exp.write
    
    tree = Arbolobra::Tree.new lines: lines, separator: "/"
    root = tree.root
    
    # root.write

    assert_equal exp, root, "lines: #{lines}"
  end
end
