at_exit do
  Rdepend::Trace.halt_with_message
end

module Rdepend
  class Trace
    def self.exec(&block)
      self.start
      yield
      self.stop
    end

    def self.init
      RubyProf.start
    end

    def self.stop
      result = RubyProf.stop
      result.eliminate_methods!([/Integer#times/])
      printer = Rdepend::Printer.new(result)
      puts "Writing Ꝛdepend graph to #{$0}.dot.svg"
      printer.print("#{$0}.dot")
    end

    def self.halt_with_message
      puts "⏳  Exiting, but writing an Ꝛdepend graph first, so please wait!"
      self.stop
    end
  end
end
