module Rdepend
  class Event
    class Call
      class Name
        def initialize(event)
          @event = event
        end

        def name
          [klass, method].join
        end
      end

      class InstanceName < Name
        def klass
          @event.defined_class
        end

        def method
          ".#{@event.method_id}"
        end
      end

      class KlassName < Name
        def klass
          @event.defined_class.match(/^#<(Module|Class):(\w*).*>$/).to_a[2]
        end

        def method
          "##{@event.method_id}"
        end
      end

      extend Forwardable
      def_delegators :@name, :name, :klass, :method

      def initialize(event)
        @event = event
        @name = initialize_event_name(event)
        update_state
        update_graph
      end

      def called_from
        Rdepend::State.instance.previous
      end

      def event_type
        @event.event
      end

      private

      def initialize_event_name(event)
        instance? ? InstanceName.new(event) : KlassName.new(event)
      end

      def instance?
        !klass?
      end

      def klass?
        @event.defined_class =~ /^#<(Module|Class):\w*.*>$/
      end

      def update_graph
      end

      def update_state
        State.instance.push(self)
      end
    end
  end
end
