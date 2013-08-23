require 'test/unit'
require File.dirname(__FILE__) + '/../lib/bounce_studio_ffi'
if ENV['BS_LICENSE']
  BS_LICENSE = ENV['BS_LICENSE']
else
  puts "Set the environment variable BS_LICENSE with your BoogieTools license code to avoid tarpit"
  BS_LICENSE = "nolicense"
end

