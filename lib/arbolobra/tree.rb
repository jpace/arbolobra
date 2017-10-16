#!/usr/bin/ruby -w
# -*- ruby -*-

require 'arbolobra/node'

module Arbolobra
end

class Arbolobra::Tree
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
