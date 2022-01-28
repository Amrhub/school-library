require_relative 'teacher'
require_relative 'person'
require_relative 'student'
require_relative 'book'
require_relative 'rental'
require 'colorize'

def general_person_inputs
  print 'Age: '.cyan
  age = gets.chomp.to_i
  print 'Name: '.cyan
  name = gets.chomp
  { age: age, name: name }
end

def create_student
  age, name = general_person_inputs.values_at(:age, :name)
  print 'Parent permission (y/n): '.cyan
  parent_permission = gets.chomp.downcase == 'y'
  Student.new(age, name, parent_permission: parent_permission)
end

def create_teacher
  age, name = general_person_inputs.values_at(:age, :name)
  print "What is the teacher's specialization? ".cyan
  specialization = gets.chomp
  Teacher.new(specialization, age, name)
end

class App
  def initialize
    @people = []
    @books = []
    @rentals = []
  end

  def create_person
    print 'Would you like to create a student or teacher? (s/t): '.cyan
    type = gets.chomp.downcase
    case type
    when 's'
      @people << create_student
      puts "Student \"#{@people.last.name}\" has been created successfully!".green
    when 't'
      @people << create_teacher
      puts "Teacher \"#{@people.last.name}\" has been created successfully!".green

    else
      puts "Invalid input \"#{type}\", Please enter valid input (s/t).".red
      create_person
    end
  end

  def create_book
    print 'Title: '.cyan
    title = gets.chomp
    print 'Author: '.cyan
    author = gets.chomp
    @books << Book.new(title, author)
    puts "Book #{title} has been created successfully!".green
  end

  def list_books(print_index: false)
    if @books.empty?
      puts 'No books have been created yet.'.blue
      @books.empty?
    end

    @books.each_with_index do |book, index|
      print "#{index}) ".blue if print_index
      puts "Title: #{book.title}, Author: #{book.author}"
    end
  end

  def list_people(print_index: false)
    if @people.empty?
      puts 'No people have been created yet.'.blue
      return
    end

    @people.each_with_index do |val, index|
      print "#{index}) ".blue if print_index
      if val.is_a?(Student)
        print '[Student]'
      else
        print '[Teacher]'
      end

      puts " ID: #{val.id}, Name: #{val.name}, Age: #{val.age}"
    end
  end

  def ask_for_book_index
    puts 'Please choose a book from this list by number: '.cyan
    list_books(print_index: true)
    return if @books.empty?

    gets.chomp.to_i
  end

  def ask_for_person_index
    puts 'Please choose a person from this list by number (not ID): '.cyan
    list_people(print_index: true)
    return if @people.empty?

    gets.chomp.to_i
  end

  def create_rental
    person_index = ask_for_person_index
    return if @people.empty?

    if person_index.between?(0, @people.size - 1)
      person = @people[person_index]
    else # invalid index
      puts "Invalid index #{person_index}".red
      return
    end
    book_index = ask_for_book_index
    return if @books.empty?

    if book_index.between?(0, @books.size - 1)
      book = @books[book_index]
    else # invalid index
      puts "Invalid index #{book_index}".red
      return
    end
    puts 'Please enter the rental date (dd/mm/yyyy): '.cyan
    date = gets.chomp
    @rentals << Rental.new(date, book, person)
    puts "#{person.name} has rented #{book.title} on #{date}.".green
  end

  def list_rentals
    print 'Person\'s id (enter Q to return to main menu): '.cyan
    input = gets.chomp.upcase
    return if input == 'Q'

    person_id = input.to_i
    person = @people.select { |p| p.id == person_id }.first
    if person.nil?
      puts 'No person with this ID has been found.'.red
      list_rentals
    else
      person_rentals = person.rentals

      if person_rentals.empty?
        puts "No rentals found for #{person.name}.".red
      else
        puts "#{person.name} has rented the following books:".blue
        person_rentals.each do |rental|
          puts "Title: #{rental.book.title}, Author: #{rental.book.author}, Date: #{rental.date}"
        end
      end
    end
  end

  def quit_program
    puts "\nThank you for using the Library App. Goodbye!".green
    exit
  end

  def display_main_menu
    main_menu = ["\nWelcome to the Library!".blue, "\nPlease select an option:".red, '1. Create a person'.green,
                 '2. Create a book'.green, '3. Create a rental'.green, '4. List all books'.green,
                 '5. List all people'.green, '6. List all rentals for a given person id'.green, '7. Quit'.green]
    puts main_menu
  end

  def selection_action(selection)
    case selection
    when 1
      create_person
    when 2
      create_book
    when 3
      create_rental
    when 4
      list_books
    when 5
      list_people
    when 6
      list_rentals
    else
      puts 'Invalid selection. Please try again.'
      input = gets.chomp.to_i
      run(input)
    end
  end

  def run(input = nil)
    display_main_menu if input.nil?
    selection = gets.chomp.to_i if input.nil?
    quit_program if input == 7 || selection == 7
    selection_action(selection || input)
  end
end

def main
  app = App.new

  loop do
    app.run
  end
end

main
