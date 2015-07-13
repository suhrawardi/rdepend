module Rdepend
  class Event

    def initialize(event)
      return if ignore?(event.defined_class)
      @event = initialize_event_struct(event)
      @event.event_class.new(@event)
    end

    private

    def ignore?(defined_class)
      mod = 'Rdepend'
      defined_class.to_s =~ /^(#<Class|#<Module)?:#{mod}/
    end

    def initialize_event_struct(event)
      Rdepend::TraceEvent.new(event.event, event.defined_class, event.method_id)
    end
  end
end
