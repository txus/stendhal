class Object
  include Stendhal::Mocks::Mockable
  include Stendhal::Mocks::Stubbable
  def true?
    self == true
  end
  def false?
    self == false
  end
end
