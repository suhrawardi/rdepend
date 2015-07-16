module Rdepend
  class Event
    class InstanceName < Name
      def klass
        @event.defined_class
      end

      def method
        ".#{@event.method_id}"
      end
    end
  end
end
