require_relative 'person'
require_relative 'student'
require_relative 'teacher'

person = Person.new(17, 'Amr', parent_permission: false)
puts person.can_use_services?

student = Student.new(5, 23, 'SaMaa')
puts student.name
puts student.validate_name

teacher = Teacher.new('Physics', 40, 'Taher')
puts teacher.can_use_services?
