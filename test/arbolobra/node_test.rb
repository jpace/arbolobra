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

                  Hash.new,
                  
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
                  
                  Hash.new,
                  
                  Array.new.tap do |a|
                    a << ''
                    a << '+---abc'
                    a << '\---def'
                  end
                ]
      
      params << [ nn(nil,
                     nn('abc',
                        nn('ghi'))),
                  
                  Hash.new,
                  
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
                  
                  Hash.new,
                  
                  Array.new.tap do |a|
                    a << ''
                    a << '+---abc'
                    a << '|   \---ghi'
                    a << '\---def'
                  end
                ]

      introchars = Arbolobra::CharList.new [ '#', '@', '!' ]
      leadchars = Arbolobra::CharList.new [ '&', '$', '=' ]
      
      params << [ nn(nil,
                     nn('abc',
                        nn('ghi')),
                     nn('def')),
                  
                  { chars: Arbolobra::CharSet.new(introchars, leadchars) },
                  
                  Array.new.tap do |a|
                    a << ''
                    a << '$===abc'
                    a << '@!!!&===ghi'
                    a << '&===def'
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

                  Hash.new,
                  
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

  param_test build_params do |node, args, wrlines|
    strio     = StringIO.new
    printargs = args.merge({ output: strio })
    node.print printargs
    assert_equal wrlines.join("\n") + "\n", strio.string
  end
end
