FILE_PATH = 'students.txt'
BUFFER = 'buffer.txt'
RESULT = 'results.txt'

def index(file)
  file_data = File.read(file)
  puts file_data
end

def delete(lines, _file, _buffer)
  File.open(BUFFER, 'w') do |buffer_line|
    File.foreach(FILE_PATH) do |line|
      buffer_line.puts line.chomp unless lines.include?(line.chomp)
    end
  end

  File.write(FILE_PATH, File.read(BUFFER))
  File.delete(BUFFER) if File.exist?(BUFFER)
end

def find(file, pattern, _result)
  matched_lines = []
  File.open(RESULT, 'a') do |result_line|
    File.foreach(file) do |line|
      if line.include?(pattern.to_s)
        matched_lines.push(line.chomp)
        result_line.puts line.chomp
      end
    end
  end
  delete(matched_lines, FILE_PATH, BUFFER)
end

loop do
  file = File.open(FILE_PATH)
  if file.read.empty?
    puts "Все студенты записаны в #{RESULT}"
    index(RESULT)
    break
  end
  puts 'Введите возраст студента или -1 чтобы выйти: '
  students_age = gets.chomp.to_i
  if students_age == -1
    index(RESULT)
    break
  else
    find(FILE_PATH, students_age, RESULT)
  end
end
