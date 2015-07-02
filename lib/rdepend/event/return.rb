module Rdepend
  class Event::Return

    def initialize(event)
      State.instance.pop
    end
  end
end
