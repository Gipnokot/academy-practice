# frozen_string_literal: true
FILE_PATH = 'students.txt'
BUFFER_PATH = 'buffer.txt'
RESULT_PATH = 'results.txt'

def index
  file_data = File.read(FILE_PATH)
  if file_data.strip.empty?
    puts "Файл пуст."
  else
    puts file_data
  end
end

def delete(lines)
  File.open(BUFFER_PATH, 'w') do |buffer_file|
    File.foreach(FILE_PATH) do |line|
      buffer_file.puts(line.chomp) unless lines.include?(line.chomp)
    end
  end
  File.write(FILE_PATH, File.read(BUFFER_PATH))
  File.delete(BUFFER_PATH) if File.exist?(BUFFER_PATH)
end

def find(pattern)
  matched_lines = []
  File.open(RESULT_PATH, 'a') do |result_file|
    File.foreach(FILE_PATH) do |line|
      if line.include?(pattern.to_s)
        matched_lines.push(line.chomp)
        result_file.puts(line.chomp)
      end
    end
  end
  delete(matched_lines)
end

loop do
  if File.read(FILE_PATH).strip.empty?
    puts "Все студенты записаны в #{RESULT_PATH}"
    index(RESULT_PATH)
    break
  end
  puts 'Введите возраст студента или -1 чтобы выйти: '
  students_age = gets.chomp.to_i
  if students_age == -1
    index(RESULT_PATH)
    break
  else
    find(students_age)
  end
end
