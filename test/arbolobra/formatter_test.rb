#!/usr/bin/ruby -w
# -*- ruby -*-

require 'arbolobra/node'
require 'arbolobra/formatter'
require 'arbolobra/tc'
require 'stringio'

module Arbolobra
  class FormatterTest < TestCase
    include Paramesan

    def self.build_params
      Array.new.tap do |params|
        params << [ Array.new.tap do |a|
                      a << ''
                      a << '\\---abc'
                    end,
                    
                    nn(nil,
                       nn('abc'))
                  ]
        
        params << [ Array.new.tap do |a|
                      a << ''
                      a << '+---abc'
                      a << '\---def'
                    end,
                    
                    nn(nil,
                       nn('abc'),
                       nn('def'))
                  ]
        
        params << [ Array.new.tap do |a|
                      a << ''
                      a << '\---abc'
                      a << '    \---ghi'
                    end,
                    
                    nn(nil,
                       nn('abc',
                          nn('ghi')))
                  ]
        
        params << [ Array.new.tap do |a|
                      a << ''
                      a << '+---abc'
                      a << '|   \---ghi'
                      a << '\---def'
                    end,

                    nn(nil,
                       nn('abc',
                          nn('ghi')),
                       nn('def'))
                  ]

        introchars = Arbolobra::CharList.new [ '#', '@', '!' ]
        leadchars = Arbolobra::CharList.new [ '&', '$', '=' ]
        
        params << [ Array.new.tap do |a|
                      a << ''
                      a << '$===abc'
                      a << '@!!!&===ghi'
                      a << '&===def'
                    end,

                    nn(nil,
                       nn('abc',
                          nn('ghi')),
                       nn('def')),
                    
                    charset: Arbolobra::CharSet.new(introchars, leadchars)
                  ]
        
        params << [ Array.new.tap do |a|
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
                    end,

                    nn(nil,
                       nn('abc',
                          nn('def',
                             nn('ghi'), nn('jkl')),
                          nn('ghi')),
                       
                       nn('def',
                          nn('ghi',
                             nn('2'),
                             nn('3'))),

                       nn('abc',
                          nn('mno')))
                  ]      
      end
    end

    param_test build_params do |expected, node, args = Hash.new|
      strio = StringIO.new
      fmt = Formatter.new args.merge({ output: strio })
      fmt.print node
      assert_equal to_lines(expected).join, strio.string
    end

    def to_lines ary
      ary.collect { |line| line.chomp + "\n" }
    end
  end
end
