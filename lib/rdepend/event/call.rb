module Rdepend
  class Event::Call

    def initialize(event)
      @event = event
      update_state
      update_graph
    end

    def name
      [klass_name, method_name].join
    end

    def called_from
      Rdepend::State.instance.previous
    end

    private

    def klass_name
      if match = @event.defined_class.match(/^#<(Module|Class):(\w*).*>$/)
        return "#{match.to_a[2]}#"
      end
      "#{@event.defined_class}."
    end

    def method_name
      @event.method_id
    end

    def update_graph
    end

    def update_state
      State.instance.push(self)
    end
  end
end
