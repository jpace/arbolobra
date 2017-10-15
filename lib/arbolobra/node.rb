#!/usr/bin/ruby -w
# -*- ruby -*-

module Arbolobra
end

class Arbolobra::Node
  include Comparable
  
  attr_reader :value
  attr_reader :children
  
  def initialize value, children = Array.new
    @value = value
    @children = children
  end

  def write indent: 0, chars: nil, output: nil
    output.printf "%*s%s\n", indent * 2, "", @value
    write_children indent: indent + 1, chars: chars, output: output
  end

  def write_children indent: 0, chars: nil, output: $stdout
    @children.each do |child|
      child.write indent: indent, chars: chars, output: output
    end
  end

  def to_s
    @value
  end

  def <=> other
    value <=> other.value && children <=> other.children
  end
end
