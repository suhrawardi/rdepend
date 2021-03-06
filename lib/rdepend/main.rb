module Rdepend
  def self.with_trace(&block)
    Rdepend::Trace.exec(&block)
  end

  def self.trace
    Rdepend::Trace.init
  end

  def self.stop
    Rdepend::Trace.stop
  end
end
