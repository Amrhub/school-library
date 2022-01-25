class Student < Person
  def initialize(class_room, age, name = 'Unknown', parent_permission: true)
    super(age, name, parent_permission: parent_permission)
    @class_room = class_room
  end

  def play_hooky
    '¯\\(ツ)/¯'
  end
end
