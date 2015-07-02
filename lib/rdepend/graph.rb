module Rdepend
  class Graph
    include Singleton

    def initialize
      @name = 'no name'
    end

    def graph
      @graph ||= GraphViz.new(@name, type: :digraph)
    end

    def print
      graph.output(svg: "#{@name}.svg")
    end

    def clear
      @graph = nil
    end
  end
end
