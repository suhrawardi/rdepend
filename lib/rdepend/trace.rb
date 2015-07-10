module Rdepend
  class Trace
    def self.exec(&block)
      self.start
      yield
      self.stop
    end

    def self.init
      self.start
      at_exit { self.halt_with_message }
    end

    private

    def self.start
      Rdepend::Event::Root.new(root_event)
      @trace = TracePoint.new(:call, :return) { |tp| Rdepend::Event.new(tp) }
      @trace.enable
    end

    def self.stop
      @trace.disable
      Rdepend::Graph::Creator.instance.print
    end

    def self.root_event
      Rdepend::TraceEvent.new(:root, *self.root_params)
    end

    def self.root_params
      [File.basename($0, '.rb'), :main]
    end

    def self.halt_with_message
      path = "./rdepend/#{self.root_params.join('_')}.svg"
      puts "\t⏳   Exiting, but writing an Ꝛdepend graph first, so please wait!"
      self.stop
      puts "\t⭕   Finished writing Ꝛdepend graph to #{path}"
    end
  end
end
