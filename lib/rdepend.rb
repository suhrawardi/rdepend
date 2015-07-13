require 'singleton'
require 'active_support/inflector'
require 'ruby-graphviz'

require_relative 'rdepend/version'
require_relative 'rdepend/state'
require_relative 'rdepend/event'
require_relative 'rdepend/event/name'
require_relative 'rdepend/event/instance_name'
require_relative 'rdepend/event/klass_name'
require_relative 'rdepend/event/abstract'
require_relative 'rdepend/event/root'
require_relative 'rdepend/event/call'
require_relative 'rdepend/event/return'
require_relative 'rdepend/graph/creator'
require_relative 'rdepend/graph/edge'
require_relative 'rdepend/graph/root'
require_relative 'rdepend/graph/sub'
require_relative 'rdepend/graph/node'
require_relative 'rdepend/trace'
require_relative 'rdepend/trace_event'
require_relative 'rdepend/main'
