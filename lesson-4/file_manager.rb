# frozen_string_literal: true

FILE_PATH = 'file_manager.txt'
BUFFER_PATH = 'buffer.txt'

def index(file)
  file_data = File.read(file)
  puts file_data
end

index(FILE_PATH)

def find(id, file)
  file_data = File.readlines(file).map(&:chomp)
  puts file_data[id]
end

find(0, FILE_PATH)

def where(pattern, file)
  matched_lines = []
  file.each_line do |line|
    matched_lines.push(line.chomp) if line.include?(pattern)
  end
  puts matched_lines
end

where('ruby', FILE_PATH)

def update(id, text, file)
  File.open(BUFFER_PATH, 'w') do |buffer_file|
    File.foreach(file).with_index do |line, index|
      if id == index
        buffer_file.puts(text)
      else
        buffer_file.puts(line)
      end
    end
  end

  File.open(file, 'w') do |orig_file|
    File.foreach(BUFFER_PATH) do |line|
      orig_file.puts(line)
    end
  end
end

update(0, 'ruby', FILE_PATH)

def delete(id, file)
  File.open(BUFFER_PATH, 'w') do |buffer_file|
    File.foreach(file).with_index do |line, index|
      buffer_file.puts(line) unless id == index
    end
  end

  File.open(file, 'w') do |orig_file|
    File.foreach(BUFFER_PATH) do |line|
      orig_file.puts(line)
    end
  end
end

def create(text, file)
  File.open(file, 'a') do |f|
    f.puts(text)
  end
end
