class Corrector
  def correct_name(name)
    name = name.downcase.capitalize
    name[0..9]
  end
end
