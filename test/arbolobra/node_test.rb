#!/usr/bin/ruby -w
# -*- ruby -*-

require 'arbolobra/node'
require 'arbolobra/tc'

module Arbolobra
  class NodeTest < TestCase
    param_test [
      [ [ Node.new("a") ], Node.new("b", Node.new("a")) ]
    ] do |expected, node|
      result = node.children
      assert_equal expected, result
    end
  end
end
