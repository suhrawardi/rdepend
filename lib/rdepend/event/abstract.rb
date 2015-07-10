module Rdepend
  class Event
    class Abstract
      def initialize
        raise NoMethodError, 'trying to initialize an abstract class'
      end

      def called_from
        nil
      end

      def klass
        ''
      end

      def method
        ''
      end

      def name
        ''
      end

      def event_type
        self.class.name.split('::').last.underscore.to_sym
      end
    end
  end
end
