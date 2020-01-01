#!/usr/bin/ruby -w
# -*- ruby -*-

require 'arbolobra/tree'
require 'arbolobra/tc'

module Arbolobra
  class TreeTest < TestCase
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

    param_test build_params do |expected, lines|
      tree = Tree.new lines
      root = tree.root
      assert_equal expected, root
    end
  end
end
