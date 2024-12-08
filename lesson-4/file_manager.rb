# frozen_string_literal: true

FILE_PATH = 'file_manager.txt'
File.open(FILE_PATH)
BUFFER_PATH = 'buffer.txt'
File.read(BUFFER_PATH)

def index(file)
  file_data = File.read(file)
  puts file_data
end

def find(id, file)
  file_data = File.readlines(file).map(&:chomp)
  puts file_data[id]
end

def where(pattern, file)
  matched_lines = []
  file.each_line do |line|
    matched_lines.push(line.chomp) if line.include?(pattern)
  end
  puts matched_lines
end

def update(id, text, file, _buffer)
  File.open(BUFFER_PATH, 'w') do |buffer_file|
    File.foreach(file).with_index do |line, index|
      if id == index
        buffer_file.puts(text)
      else
        buffer_file.puts(line)
      end
    end
  end

  File.write(file, File.read(BUFFER_PATH))
end

def delete(id, file, _buffer_file)
  File.open(buffer_path, 'w')
  File.foreach(file_path).with_index do |line, index|
    file.puts(line) unless id == index
  end
  file.close
  File.write(file_path, File.read(buffer_path))
end

def create(text, _file_)
  file = File.open(file_path, 'a')
  file.puts(text)
  file.close
end
