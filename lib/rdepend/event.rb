module Rdepend
  class Event

    def initialize(event, calling_from)
      return if ignore?(event.defined_class)
      return if event.is_a?(Rdepend::TraceEvent)
      to_event = initialize_to_event(event)
      calling_from = calling_from.compact.map { |ev| initialize_from_event(ev) }
      calling_from[1..-1].inject(to_event) do |to, from|
        to.event_class.new(to, from); from
      end
    end

    private

    def ignore?(defined_class)
      mod = 'Rdepend'
      defined_class.to_s =~ /^(#<Class|#<Module)?:#{mod}/
    end

    def initialize_from_event(event)
      args = [nil, nil, event.base_label, event.path, event.lineno]
      Rdepend::TraceEvent.new(*args)
    end

    def initialize_to_event(event)
      args = [event.event, event.defined_class,
              event.method_id, event.path, event.lineno]
      Rdepend::TraceEvent.new(*args)
    end
  end
end
