# encoding: utf-8
require 'set'

module Rdepend
  class Printer < RubyProf::AbstractPrinter
    CLASS_COLOR = '"#666666"'
    EDGE_COLOR  = '"#666666"'

    def initialize(result)
      super(result)
      @seen_methods = Set.new
    end

    def print(output, options = {})
      setup_options(options)
      add('digraph "Profile" {', 'labelloc=t;', 'labeljust=l;')
      print_threads
      add('}')
      File.open(output, 'w') { |file| file.write(@contents.join("\n")) }
      `dot -Tsvg #{output} > #{output}.svg`
    end

    private

    def print_threads
      @result.threads.each do |thread|
        add("subgraph \"Thread #{thread.id}\" {")
        print_thread(thread)
        add("}")
        print_classes(thread)
      end
    end

    def print_thread(thread)
      thread.methods.sort_by(&sort_method).reverse_each do |method|
        name = method_name(method).split("#").last
        add("#{method.object_id} [label=\"#{name}\"];")
        @seen_methods << method
        print_edges(method)
      end
    end

    def print_classes(thread)
      grouped = {}
      thread.methods.each{|m| grouped[m.klass_name] ||= []; grouped[m.klass_name] << m}
      grouped.each do |cls, methods2|
        big_methods = methods2.select { |m| @seen_methods.include?(m) }
        if !big_methods.empty?
          add("subgraph cluster_#{cls.object_id} {")
          add("label = \"#{cls}\";", "fontcolor = #{CLASS_COLOR};")
          add("fontsize = 16;", "color = #{CLASS_COLOR};")
          big_methods.each { |m| add("#{m.object_id};") }
          add("}")
        end
      end
    end

    def print_edges(method)
      method.aggregate_children.each do |child|
        label = "#{child.called}/#{child.target.called}"
        label = "label=\"#{label}\" fontsize=10 fontcolor=#{EDGE_COLOR}"
        add("#{method.object_id} -> #{child.target.object_id} [#{label}];")
      end
    end

    def add(*args)
      @contents = (@contents || []) + [args].flatten
    end
  end
end
