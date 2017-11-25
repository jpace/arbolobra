#!/usr/bin/ruby -w
# -*- ruby -*-

module Arbolobra
end

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

# this is the "intro" (i) and the "lead" (l):
# <iiiiii><ll>
# x   |   +---node_test.rb
# x   |   \---tree_test.rb

# +---abc
# |yyy+---def
# |yyy|yyy+---ghi
# |yyy|yyy\---jkl
# |yyy\---ghi
# +---def
# |yyy\---ghi
# |yyyxyyy+---2
# |yyyxyyy\---3
# \---abc
# xyyy\---mno

# in intro:
# | - down to next
# x - down from last (default is space, not x)
# y - gap to child (default is space, not y)

# in lead:
# + - marker to child
# \ - marker to last
# - - over to child

class Arbolobra::CharList
  def initialize chars, width: 4
    @chars = chars
    @width = width
  end

  def expand is_last
    leftchr   = @chars[is_last ? 0 : 1]
    repeatchr = @chars[2]
    leftchr + repeatchr * (@width - 1)
  end

  DEFAULT_INTRO = new [ ' ',  '|', ' ' ]
  DEFAULT_LEAD  = new [ '\\', '+', '-' ]
end

class Arbolobra::CharSet
  attr_reader :intro
  attr_reader :lead
  
  def initialize intro, lead
    @intro = intro
    @lead  = lead
  end

  DEFAULT = new Arbolobra::CharList::DEFAULT_INTRO, Arbolobra::CharList::DEFAULT_LEAD
end
