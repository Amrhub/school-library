class Student < Person
  def initialize(age, name = 'Unknown', parent_permission: true, class_room: 'Unknown')
    super(age, name, parent_permission: parent_permission)
    @class_room = class_room
    @class_room&.add_student(self) if (@class_room != 'Unknown') && !@class_room&.students&.include?(self)
  end

  def play_hooky
    '¯\\(ツ)/¯'
  end
end
