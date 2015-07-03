module Rdepend
  class Event
    def initialize(event)
      "Rdepend::Event::#{event.event.to_s.classify}".constantize.new(event)
    end
  end
end
