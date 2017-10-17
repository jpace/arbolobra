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

  def print intro: "", lead: "", output: $stdout, chars: Arbolobra::CharSet::DEFAULT
    output.print lead, @value.to_s, "\n"
    childargs = { intro: intro, output: output, chars: chars }
    @children.each_with_index do |child, idx|
      print_child child, childargs.merge({ is_last: idx == @children.size - 1 })
    end
  end

  def print_child child, intro: "", is_last: false, output: $stdout, chars: Arbolobra::CharSet::DEFAULT
    nextintro = intro + chars.intro.expand(is_last)
    nextlead  = intro + chars.lead.expand(is_last)
    child.print intro: nextintro, lead: nextlead, output: output, chars: chars
  end

  def to_s
    @value
  end

  def <=> other
    value <=> other.value && children <=> other.children
  end
end
