require_relative 'person'
require_relative 'student'

person = Person.new(23, 'Amr', false)
puts person.can_use_services?

student = Student.new(5, 23, 'Samaa', false)
puts student.play_hooky
