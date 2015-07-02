module Rdepend
  class State
    include Singleton
    extend Forwardable
    def_delegators :@state, :push, :pop, :clear, :size

    def initialize
      @state = []
    end

    def previous
      @state[-2]
    end
  end
end
