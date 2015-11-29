module Rdepend
  class Trace
    def self.exec(&block)
      self.init
      yield
      self.stop
    end

    def self.init
      RubyProf.start
    end

    def self.stop
      result = RubyProf.stop
      result.eliminate_methods!([/Integer#times/, /Class#new/])
      puts "Writing Ꝛdepend graph to rdepend/#{$0}.dot.svg"
      File.mkdir('rdepend') unless File.exist?('rdepend')
      Rdepend::Printer.new(result).print("rdepend/#{$0}.dot")
    end

    def self.halt_with_message
      puts "⏳  Exiting, but writing an Ꝛdepend graph first, so please wait!"
      self.stop
    end
  end
end

at_exit do
  Rdepend::Trace.halt_with_message
end
