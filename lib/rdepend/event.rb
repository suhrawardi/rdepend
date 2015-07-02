module Rdepend
  class Event

    def initialize(event)
      case event.event
      when :call
        Rdepend::Event::Call.new(event)
      when :return
        Rdepend::Event::Return.new(event)
      end
    end
  end
end
