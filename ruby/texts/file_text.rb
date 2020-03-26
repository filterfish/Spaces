require_relative 'text'

module Texts
  class FileText < Text

    attr_accessor :source_file_name,
      :directory
      :source

    def source
      @source ||=
      begin
        f = File.open(source_file_name, 'r')
        f.read
      ensure
        f.close
      end
    end

    def path
      source_file_name
    end

    def file_path
      "#{subspace_path}/#{file_name}"
    end

    def file_name
      source_file_name.split('/').last
    end

    def subspace_path
      "#{context.subspace_path}/home/engines/#{short_path}"
    end

    def short_path
      source_file_name[break_point .. -1].split('/')[0 .. -2].join('/')
    end

    def break_point
      source_file_name.index(directory)
    end

    def initialize(source_file_name:, directory:, context:)
      self.context = context
      self.source_file_name = source_file_name
      self.directory = directory
    end

  end
end