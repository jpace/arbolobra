#!/usr/bin/ruby -w
# -*- ruby -*-

require 'arbolobra/node'
require 'test/unit'
require 'paramesan'

module Arbolobra
  class TestCase < Test::Unit::TestCase
    include Paramesan

    def self.nn value, *children
      Arbolobra::Node.new value, children
    end

    def nn value, *children
      self.class.nn value, *children
    end
  end
end
