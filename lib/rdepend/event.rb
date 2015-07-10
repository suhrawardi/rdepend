module Rdepend
  class Event

    def initialize(event)
      @event = initialize_event_struct(event)
      @event.event_class.new(@event)
    end

    private

    def initialize_event_struct(event)
      Rdepend::TraceEvent.new(event.event, event.defined_class, event.method_id)
    end
  end
end
