# frozen_string_literal: true

FILE_PATH = 'file_manager.txt'
BUFFER_PATH = 'buffer.txt'

def valid_id?(id, lines)
  if id > 0 && id <= lines.length
    true
  else
    puts "Строка с индексом #{id} не найдена!"
    false
  end
end

def read_file
  File.readlines(FILE_PATH).map(&:chomp)
end

def write_to_buffer(lines)
  File.open(BUFFER_PATH, 'w') do |buffer_file|
    lines.each do |line|
      buffer_file.puts(line)
    end
  end
end

def overwrite_original_file
  File.open(FILE_PATH, 'w') do |orig_file|
    File.foreach(BUFFER_PATH) do |line|
      orig_file.puts(line.chomp)
    end
  end
end

def index
  file_data = File.read(FILE_PATH)
  puts file_data
end

def find(id)
  lines = read_file
  if valid_id?(id, lines)
    puts lines[id - 1]
  end
end

def where(pattern)
  matched_lines = []
  File.foreach(FILE_PATH) do |line|
    matched_lines << line.chomp if line.include?(pattern)
  end
  puts matched_lines.join("\n") unless matched_lines.empty?
  puts "Шаблон '#{pattern}' не найден." if matched_lines.empty?
end

def update(id, text)
  lines = read_file
  if valid_id?(id, lines)
    lines[id - 1] = text
    write_to_buffer(lines)
    overwrite_original_file
  end
end

def delete(id)
  lines = read_file
  if valid_id?(id, lines)
    lines.delete_at(id - 1)
    write_to_buffer(lines)
    overwrite_original_file
  end
end

def create(text)
  File.open(FILE_PATH, 'a') { |f| f.puts(text) }
end
