module Rdepend
  class Event
    class Return
      def initialize(event)
        @event = event
        State.instance.pop
      end

      def event_type
        @event.event
      end
    end
  end
end
