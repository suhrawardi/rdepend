module Rdepend
  class Event
    class RootName < Name
      def klass
        ''
      end

      def method
        @event.method_id
      end
    end
  end
end
