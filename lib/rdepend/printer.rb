# encoding: utf-8
require 'set'

module Rdepend
  class Printer < RubyProf::AbstractPrinter
    EDGE_COLOR  = '"#666666"'

    attr_reader :color

    def initialize(result)
      reset_color
      super(result)
      @seen_methods = Set.new
    end

    def print(output, options = {})
      setup_options(options)
      add('digraph "Profile" {')
      add('ratio="2.0";', 'labelloc=t;', 'labeljust=l;')
      print_threads
      add('}')
      File.open(output, 'w') { |file| file.write(@contents.join("\n")) }
      %w(png svg).each { |ext| `dot -T#{ext} #{output} > #{output}.#{ext}` }
    end

    private

    def reset_color
      color = (0...6).map { |_| '1234567890ABCDEF'.split(//).sample }.join
      @color = "\"##{color}\""
    end

    def print_threads
      @result.threads.each do |thread|
        add("subgraph \"Thread #{thread.id}\" {")
        print_thread(thread)
        add('}')
        print_classes(thread)
      end
    end

    def print_thread(thread)
      thread.methods.sort_by(&sort_method).reverse_each do |method|
        name = method_name(method).split('#').last
        reset_color
        colors = "color=#{color}; fontcolor=#{color}; fontsize=10"
        add("#{method.object_id} [label=\"#{name}\"; #{colors}];")
        @seen_methods << method
        print_edges(method)
      end
    end

    def grouped_methods(thread)
      thread.methods.inject({}) { |m, method|
        m[method.klass_name] = (m[method.klass_name] || []) << method; m
      }
    end

    def print_classes(thread)
      grouped_methods(thread).each do |cls, methods|
        print_methods(cls, methods.select { |m| @seen_methods.include?(m) })
      end
    end

    def print_methods(cls, methods)
      return if methods.empty?
      reset_color
      add("subgraph cluster_#{cls.object_id} {")
      add("label=\"#{cls.gsub(/\(.*\)/, '')}\";", "fontcolor=#{color};")
      add('fontsize=12;', "color=#{color}; shape=box; style=\"rounded\";")
      methods.each { |m| add("#{m.object_id};") }
      add('}')
    end

    def print_edges(method)
      method.aggregate_children.each do |child|
        label = "label=\"#{child.called}\/#{child.target.called}\";"
        label = "#{label} fontsize=8; color=#{color}; fontcolor=#{EDGE_COLOR};"
        add("#{method.object_id} -> #{child.target.object_id} [#{label}];")
      end
    end

    def add(*args)
      @contents = (@contents || []) + [args].flatten
    end
  end
end
