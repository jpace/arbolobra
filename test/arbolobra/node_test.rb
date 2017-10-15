#!/usr/bin/ruby -w
# -*- ruby -*-

require 'arbolobra/node'
require 'test/unit'
require 'paramesan'
require 'stringio'

class NodeTest < Test::Unit::TestCase
  include Paramesan

  def self.nn value, *children
    Arbolobra::Node.new value, children
  end

  def self.build_params
    Array.new.tap do |params|
      params << [ nn(nil,
                     nn("abc")),
                  
                  Array.new.tap do |a|
                    a << ""
                    a << "  abc"
                  end,

                  Array.new.tap do |a|
                    a << "abc"
                  end
                ]
      
      params << [ nn(nil,
                     nn("abc"),
                     nn("def")),
                  
                  Array.new.tap do |a|
                    a << ""
                    a << "  abc"
                    a << "  def"
                  end,

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
                    a << ""
                    a << "  abc"
                    a << "    def"
                    a << "      ghi"
                    a << "      jkl"
                    a << "    ghi"
                    a << "  def"
                    a << "    ghi"
                    a << "      2"
                    a << "      3"
                    a << "  abc"
                    a << "    mno"
                  end,

                  Array.new.tap do |a|
                    a << "abc"
                    a << "  def"
                    a << "    ghi"
                    a << "    jkl"
                    a << "  ghi"
                    a << "def"
                    a << "  ghi"
                    a << "    2"
                    a << "    3"
                    a << "abc"
                    a << "  mno"
                  end
                ]      
    end
  end

  param_test build_params do |node, wrlines, x|
    strio = StringIO.new
    node.write indent: 0, chars: nil, output: strio
    assert_equal wrlines.join("\n") + "\n", strio.string
  end

  param_test build_params do |node, x, wrchlines|
    strio = StringIO.new
    node.write_children indent: 0, chars: nil, output: strio
    assert_equal wrchlines.join("\n") + "\n", strio.string
  end
end
