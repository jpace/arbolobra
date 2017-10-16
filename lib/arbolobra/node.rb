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

  def write indent: 0, chars: Arbolobra::Chars.new, output: nil, is_last: false, intro: "", lead: ""
    if indent == 0
      output.puts @value.to_s
    else
      str = chars.format @value.to_s, is_last: is_last, indent: indent
      puts "str: #{str}"
      output.print lead, @value.to_s, "\n"
      # output.printf "%*s%s\n", indent * 2, indent == 0 ? "" : chars.space, @value
    end
    write_children indent: indent + 1, chars: chars, output: output, intro: intro
  end

  def write_children indent: 0, chars: Arbolobra::Chars.new, output: $stdout, intro: ""
    @children.each_with_index do |child, idx|
      is_last = idx == @children.size - 1
      introchr = is_last ? chars.down_from_last : chars.down_to_next
      nextintro = intro + chars.expand(introchr, ' ')
      leadchr = is_last ? chars.marker_to_last : chars.marker_to_child
      nextlead = intro + chars.expand(leadchr, '-')
      child.write indent: indent, chars: chars, output: output, intro: nextintro, lead: nextlead
    end
  end

  def to_s
    @value
  end

  def <=> other
    value <=> other.value && children <=> other.children
  end
end
