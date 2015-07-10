Rdepend::TraceEvent = Struct.new(:event_type, :defined_class, :method_id) do
  def event_class
    "Rdepend::Event::#{event_type.to_s.classify}".constantize
  end
end
