Rdepend::TraceEvent = Struct.new(:event_type, :defined_class,
                                 :method_id, :path, :lineno) do
  def event_class
    "Rdepend::Event::#{event_type.to_s.classify}".constantize
  end

  def key
    "#{path}:#{method_id}"
  end

  def root?
    method_id == '<main>'
  end

  def defined_class
    self[:defined_class].to_s
  end

  def instance?
    !klass?
  end

  def klass?
    defined_class =~ /^#<(Module|Class):\w*.*>$/
  end

  def klass
    name.klass
  end

  def method
    name.method
  end

  def label
    if root?
      'main'
    else
      method_id
    end
  end

  private

  def name
    if root?
      Rdepend::Event::RootName.new(self)
    elsif instance?
      Rdepend::Event::InstanceName.new(self)
    else
      Rdepend::Event::KlassName.new(self)
    end
  end
end
