require 'rspec'
require 'rspec/its'
require 'simplecov'

SimpleCov.start do
  add_filter '/spec'
end

require File.expand_path(File.dirname(__FILE__) + '/../lib/rdepend.rb')
