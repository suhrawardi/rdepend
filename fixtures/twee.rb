class Twee
  def initialize
  end

  def self.twee
    new.drie
  end

  def drie
    Drie.new
  end
end
