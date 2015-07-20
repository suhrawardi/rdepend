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
      set_trace_func proc { |event, file, line, id, binding, classname|
        if event == 'call' && file =~ /workspace/
          printf("A)\t%8s %s:%-2d %10s %8s\n", event, file, line, id, classname)
          tp = OpenStruct.new(event: event, path: file, lineno: line, method_id: id, defined_class: classname)
          Rdepend::Event.new(tp, caller_locations(2,9))
        end
      }
#      @trace = TracePoint.new(:call) do |tp|
#        printf("B)\t%8s %s:%-2d %10s %8s\n", tp.event, tp.path, tp.lineno, tp.method_id, tp.defined_class)
#        #Rdepend::Event.new(tp, caller_locations(2,9))
#      end
#      @trace.enable
    end

    def self.stop
#      @trace.disable
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
