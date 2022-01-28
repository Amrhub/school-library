class Rental
  attr_accessor :date, :book, :person

  def initialize(date, book, person)
    @date = date

    @book = book
    @book.add_rental(self) unless @book.rentals.include?(self)

    @person = person
    person.add_rental(self) unless person.rentals.include?(self)
  end
end
