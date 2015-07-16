module Rdepend
  class Event
    class KlassName < Name
      def klass
        @event.defined_class.match(/^#<(Module|Class):(\w*).*>$/).to_a[2]
      end

      def method
        "##{@event.method_id}"
      end
    end
  end
end
