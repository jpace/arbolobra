#!/usr/bin/ruby -w
# -*- ruby -*-

require 'arbolobra/chars'

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

  def print intro: "", lead: "", output: $stdout
    output.print lead, @value.to_s, "\n"
    @children.each_with_index do |child, idx|
      print_child child, is_last: idx == @children.size - 1, intro: intro, output: output
    end
  end

  def print_child child, intro: "", is_last: false, output: $stdout
    introchars = [ ' ',  '|', ' ' ]
    leadchars  = [ '\\', '+', '-' ]

    idx = is_last ? 0 : 1
    
    nextintro = intro + expand(introchars[idx], introchars[2])
    nextlead  = intro + expand(leadchars[idx], leadchars[2])
    child.print intro: nextintro, lead: nextlead, output: output
  end

  def expand leftchr, repeatchr
    @width ||= 4
    leftchr + repeatchr * (@width - 1)
  end
  
  def to_s
    @value
  end

  def <=> other
    value <=> other.value && children <=> other.children
  end
end
