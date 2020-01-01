#!/usr/bin/ruby -w
# -*- ruby -*-

require 'arbolobra/chars'
require 'arbolobra/formatter'

module Arbolobra
  class Node
    include Comparable
    
    attr_reader :value
    attr_reader :children
    
    def initialize value, *children
      @value = value
      @children = children
    end

    def print intro: "", lead: "", output: $stdout, charset: Arbolobra::CharSet::DEFAULT
      fmt = Formatter.new charset: charset, output: output
      fmt.print self, intro, lead
    end

    def to_s
      @value
    end

    def <=> other
      value <=> other.value && children <=> other.children
    end
  end
end
