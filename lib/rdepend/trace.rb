# encoding: utf-8

module RubyProf
  class Profile
    def eliminate_methods!(paths = [Dir.pwd])
      eliminated = []
      threads.each do |thread|
        eliminated.concat(eliminate_methods(thread.methods, paths))
      end
      eliminated
    end

    def eliminate_methods(methods, paths = [Dir.pwd])
      eliminated = []
      i = 0
      while i < methods.size
        method_info = methods[i]
        source = method_info.source_file
        match = paths.any? { |path| source.start_with?(path) }
        if match || method_info.root?
          i += 1
        else
          eliminated << methods.delete_at(i)
          method_info.eliminate!
        end
      end
      eliminated
    end
  end
end

module Rdepend
  class Trace
    def self.exec(&block)
      self.init
      yield
      self.stop
    end

    def self.init(paths = [Dir.pwd])
      @paths = paths
      RubyProf.start
    end

    def self.stop
      result = RubyProf.stop
      result.eliminate_methods!(@paths)
      puts "Writing Ꝛdepend graph to rdepend/#{$0}.dot.svg"
      Dir.mkdir('rdepend') unless Dir.exist?('rdepend')
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
