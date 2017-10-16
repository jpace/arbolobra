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
                     nn('abc')),
                  
                  Array.new.tap do |a|
                    a << ''
                    a << '\\---abc'
                  end,

                  Array.new.tap do |a|
                    a << 'abc'
                  end
                ]
      
      params << [ nn(nil,
                     nn('abc'),
                     nn('def')),
                  
                  Array.new.tap do |a|
                    a << ''
                    a << '+---abc'
                    a << '\---def'
                  end
                ]
      
      params << [ nn(nil,
                     nn('abc',
                        nn('ghi'))),
                  
                  Array.new.tap do |a|
                    a << ''
                    a << '\---abc'
                    a << '    \---ghi'
                  end
                ]
      
      params << [ nn(nil,
                     nn('abc',
                        nn('ghi')),
                     nn('def')),
                  
                  Array.new.tap do |a|
                    a << ''
                    a << '+---abc'
                    a << '|   \---ghi'
                    a << '\---def'
                  end
                ]

      params << [ nn(nil,
                     nn('abc',
                        nn('def',
                           nn('ghi'), nn('jkl')),
                        nn('ghi')),
                     
                     nn('def',
                        nn('ghi',
                           nn('2'),
                           nn('3'))),

                     nn('abc',
                        nn('mno'))),

                  Array.new.tap do |a|
                    a << ''
                    a << '+---abc'
                    a << '|   +---def'
                    a << '|   |   +---ghi'
                    a << '|   |   \---jkl'
                    a << '|   \---ghi'
                    a << '+---def'
                    a << '|   \---ghi'
                    a << '|       +---2'
                    a << '|       \---3'
                    a << '\---abc'
                    a << '    \---mno'
                  end
                ]      
    end
  end

  param_test build_params do |node, wrlines|
    strio = StringIO.new
    node.print output: strio
    # puts strio.string
    assert_equal wrlines.join("\n") + "\n", strio.string
  end
end
