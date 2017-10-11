#!/usr/bin/ruby -w
# -*- ruby -*-

require 'logue/loggable'

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

  def write indent = 0, chars = nil
    printf "%*s%s\n", indent * 2, "", @value
    @children.each do |child|
      child.write indent + 1
    end
  end

  def to_s
    @value
  end

  def <=> other
    value <=> other.value && children <=> other.children
  end
end

class Arbolobra::Tree
  include Logue::Loggable

  attr_reader :root
  attr_reader :nodes
  
  def initialize lines: nil, separator: nil
    if lines
      raise "lines argument requires a separator" unless separator
      @root = Arbolobra::Node.new nil
      
      lines.each do |line|
        elements = line.split separator
        create_nodes elements
      end
    end
  end

  def create_nodes elements
    node = @root
    elements.each do |elmt|
      subnode = node.children[-1]
      if subnode && subnode.value == elmt
        node = subnode
      else
        newnode = Arbolobra::Node.new elmt
        node.children << newnode
        node = newnode
      end
    end
  end
end
