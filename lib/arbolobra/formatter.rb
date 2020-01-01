#!/usr/bin/ruby -w
# -*- ruby -*-

require 'arbolobra/chars'

module Arbolobra
end

class Arbolobra::Formatter
  def initialize charset: Arbolobra::CharSet::DEFAULT, output: $stdout
    @charset = charset
    @output = output
  end
  
  def print node, intro = "", lead = ""
    @output.print lead, node.value.to_s, "\n"
    children = node.children
    children.each_with_index do |child, idx|
      print_child child, intro, idx == children.size - 1
    end
  end

  def print_child child, intro, is_last
    nextintro = intro + @charset.intro.expand(is_last)
    nextlead  = intro + @charset.lead.expand(is_last)
    print child, nextintro, nextlead
  end
end
