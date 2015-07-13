module Rdepend
  class State
    include Singleton
    extend Forwardable
    def_delegators :@state, :last, :push, :pop, :clear, :size

    def initialize
      @state = []
    end

    def pop_if_similar_to(new_event)
      pop until last == new_event
    end

    def previous
      @state[-2]
    end

    def inspect
      "#<Rdepend::State: #{@state.map(&:name)}>"
    end
  end
end
