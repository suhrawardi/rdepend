module Rdepend
  class Event
    class Return < Rdepend::Event::Abstract
      extend Forwardable
      def_delegators :@name, :name, :klass, :method

      def initialize(event)
        @event = event
        @name = initialize_event_name(event)
        State.instance.pop_if_similar_to(self)
      end
    end
  end
end
