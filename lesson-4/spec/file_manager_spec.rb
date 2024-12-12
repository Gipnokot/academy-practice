# frozen_string_literal: true

require_relative '../file_manager'

describe 'File Manager' do
  let(:test_file) { 'test_file.txt' }
  let(:buffer_file) { 'buffer.txt' }

  before(:each) do
    File.write(test_file, "line 1\nline 2 ruby\nline 3\nline 4 ruby\n")
  end

  after(:each) do
    File.delete(test_file) if File.exist?(test_file)
    File.delete(buffer_file) if File.exist?(buffer_file)
  end

  describe '#index' do
    it '#prints the contents of a file' do
      expect { index(test_file) }.to output("line 1\nline 2 ruby\nline 3\nline 4 ruby\n").to_stdout
    end
  end

  describe '#find' do
    it '#prints a string by index' do
      expect { find(1, test_file) }.to output("line 2 ruby\n").to_stdout
    end

    it '#prints nil if the index is invalid' do
      expect { find(10, test_file) }.to output(nil).to_stdout
    end
  end

  describe '#where' do
    it '#prints an array of strings containing the specified pattern' do
      expect { where('ruby', test_file) }.to output(["line 2 ruby", "line 4 ruby"].to_s + "\n").to_stdout
    end

    it '#returns an empty array if the pattern is not found' do
      expect { where('nonexistent', test_file) }.to output([].to_s + "\n").to_stdout
    end
  end

  describe '#update' do
    it '#updates a line in a file by index' do
      update(0, 'new line 1', test_file)
      expect(File.read(test_file)).to eq("new line 1\nline 2 ruby\nline 3\nline 4 ruby\n")
    end

    it '#does not change the file if the index does not exist' do
      update(10, 'new line', test_file)
       expect(File.read(test_file)).to eq("line 1\nline 2 ruby\nline 3\nline 4 ruby\n")
    end
  end

  describe '#delete' do
    it '#deletes a line from a file by index' do
      delete(1, test_file)
      expect(File.read(test_file)).to eq("line 1\nline 3\nline 4 ruby\n")
    end

     it '#does not change the file if the index does not exist' do
      delete(10, test_file)
       expect(File.read(test_file)).to eq("line 1\nline 2 ruby\nline 3\nline 4 ruby\n")
    end
  end

  describe '#create' do
    it '#appends a line to the end of the file' do
      create('new line', test_file)
      expect(File.read(test_file)).to eq("line 1\nline 2 ruby\nline 3\nline 4 ruby\nnew line\n")
    end
  end
end