module Rdepend
  class Event
    class Root < Rdepend::Event::Abstract
      def initialize(event)
        @event = event
#        update_state
        update_graph
      end

#      def name
#        "#{@event.defined_class}_#{method}"
#      end

#      def method
#        @event.method_id.to_s
#      end

#      def root?
#        true
#      end

      private

#      def update_state
#        State.instance.push(self)
#      end

      def update_graph
        Graph::Creator.instance.add_node(@event)
      end
    end
  end
end
