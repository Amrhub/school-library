require_relative 'corrector'

class Person
  attr_reader :id, :rentals
  attr_accessor :age, :name

  def initialize(age, name = 'Unknown', parent_permission: true)
    @id = Random.rand(1..99_999)
    @age = age
    @name = name
    @parent_permission = parent_permission
    @corrector = Corrector.new
    @rentals = []
  end

  def validate_name(name = @name)
    @name = @corrector.correct_name(name)
  end

  def can_use_services?
    (of_age? || @parent_permission)
  end

  def add_rental(rental)
    @rentals << rental
    rental.person = self unless rental.person == self
  end

  private

  def of_age?
    @age >= 18
  end
end
