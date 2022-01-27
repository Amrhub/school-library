class ClassRoom
  attr_accessor :label

  def initialize(label)
    @label = label
    @students = []
  end

  def add_student(student)
    @students ||= []
    @students << student
    student.class_room = self unless student.class_room == self
  end
end
