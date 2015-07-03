module Rdepend
  class Event
    class Root
      attr_reader :name

      def initialize(name)
        @name = name
        update_state
        update_graph
      end

      def called_from
        nil
      end

      def event_type
        :root
      end

      private

      def update_state
        State.instance.push(self)
      end

      def update_graph
      end
    end
  end
end
