require 'ostruct'
require File.expand_path(File.dirname(__FILE__) + '/lib/rdepend.rb')
require File.expand_path(File.dirname(__FILE__) + '/fixtures/een.rb')
require File.expand_path(File.dirname(__FILE__) + '/fixtures/twee.rb')
require File.expand_path(File.dirname(__FILE__) + '/fixtures/drie.rb')

=begin
Rdepend.with_trace do
  @een = Een.new
  @een.start
end
=end

Rdepend.trace
@een = Een.new
@een.start
