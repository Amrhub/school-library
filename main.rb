require_relative 'person'

person = Person.new(23, 'Amr', false)
puts person.can_use_services?

require 'student'
