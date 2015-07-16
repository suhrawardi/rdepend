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
      @trace = TracePoint.new(:call) do |tp|
        #Rdepend::Event.new(tp, caller_locations(2,1).first)
        Rdepend::Event.new(tp, caller_locations(2,9))
      end
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
      [nil, '<main>', $0]
    end

    def self.output_file
      "./rdepend/#{File.basename($0, '.rb')}.svg"
    end

    def self.halt_with_message
      puts "\t⏳   Exiting, but writing an Ꝛdepend graph first, so please wait!"
      self.stop
      puts "\t⭕   Finished writing Ꝛdepend graph to #{self.output_file}"
    end
  end
end
