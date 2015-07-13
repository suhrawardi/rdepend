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

      def root?
        false
      end

      def ==(other_event)
        return false if other_event.root?  or other_event.nil?
        true
      end

      protected

      def instance?
        !klass?
      end

      def klass?
        @event.defined_class.to_s =~ /^#<(Module|Class):\w*.*>$/
      end

      def initialize_event_name(event)
        if instance?
          Rdepend::Event::InstanceName.new(event)
        else
          Rdepend::Event::KlassName.new(event)
        end
      end
    end
  end
end
