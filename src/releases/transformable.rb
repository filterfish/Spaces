require_relative '../spaces/model'
require_relative 'stanzas'

module Releases
  class Transformable < ::Spaces::Model
    include Stanzas

    class << self
      def stanza_lot
        files_in(:stanzas).map { |f| ::File.basename(f, '.rb') }
      end

      def inheritance_paths; __dir__ ;end
    end

    require_files_in :stanzas

    def declaratives
      stanzas.map(&:declaratives)
    end

  end
end