require 'test/unit'
require 'rubygems'
require 'fake_web'
require File.dirname(__FILE__) + '/../lib/mirrored'

class << Test::Unit::TestCase
  def test(name, &block)
    test_name = :"test_#{name.gsub(' ','_')}"
    raise ArgumentError, "#{test_name} is already defined" if self.instance_methods.include? test_name.to_s
    define_method test_name, &block
  end
end