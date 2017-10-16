#!/usr/bin/ruby -w
# -*- ruby -*-

module Arbolobra
end

class Arbolobra::Chars
  attr_reader :down_from_last
  attr_reader :down_to_next
  attr_reader :marker_to_last
  attr_reader :marker_to_child
  attr_reader :over_to_child
  attr_reader :width

  # this looks like:

  # |   +---packed-refs
  # |   \---refs
  # |       +---heads
  # |       |   +---add-node
  # |       |   \---master
  # |       +---remotes
  # |       |   \---origin
  # |       |       +---HEAD
  # |       |       \---master
  # |       \---tags

  # \---test
  # x   +---arbolobra
  # x   |   +---chars_test.rb
  # x   |   +---node_test.rb
  # x   |   \---tree_test.rb
  # x   +---arbolobra_test.rb
  # x   \---test_helper.rb
  
  # + - marker to child
  # \ - marker to last
  # - - over to child
  # | - down to next
  # x - down from last (usually space, not x)
  
  def initialize down_from_last: ' ', down_to_next: '|', marker_to_last: '\\', marker_to_child: '+', over_to_child: '-', width: 4
    @down_from_last = down_from_last
    @down_to_next = down_to_next
    @marker_to_last = marker_to_last
    @marker_to_child = marker_to_child
    @over_to_child = over_to_child
    @width = width
  end

  def format str, indent: 0, is_last: false
    leading = "-" * (indent * @width - 1)
    downchar = is_last ? marker_to_last : marker_to_child
    sprintf "%s%s%s", downchar, leading, str
  end

  def expand leftchr, repeatchr
    leftchr + repeatchr * (@width - 1)
  end
end
