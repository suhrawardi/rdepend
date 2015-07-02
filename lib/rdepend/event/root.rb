module Rdepend
  class Event::Root

    def initialize(name)
      @name = name
      update_state
      update_graph
    end

    def name
      @name
    end

    def called_from
      nil
    end

    private

    def update_state
      State.instance.push(self)
    end

    def update_graph
    end
  end
end
