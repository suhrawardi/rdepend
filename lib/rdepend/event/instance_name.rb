module Rdepend
  class Event
    class InstanceName < Name
      def klass
        defined_class
      end

      def method
        ".#{@event.method_id}"
      end
    end
  end
end
