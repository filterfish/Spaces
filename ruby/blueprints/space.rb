require_relative '../universal/space'
require_relative '../git/space'
require_relative 'blueprint'

module Blueprints
  class Space < Git::Space

    class << self
      def default_model_class
        Blueprint
      end
    end

    def import(descriptor)
      super
      by_json(descriptor).tap do |m|
        m.struct.descriptor = descriptor.struct
        save(m)
        import_anchors_for(m)
      end
    end

    def import_anchors_for(model)
      unimported_anchors_for(model).each { |d| import(d) }
    end

    def unimported_anchors_for(model)
      model.anchor_descriptors&.reject { |d| imported?(d) } || []
    end

    def ensure_space_for(descriptor)
      FileUtils.mkdir_p(path_for(descriptor))
    end

    def imported?(descriptor)
      Dir.exist?(path_for(descriptor))
    end

    def delete(descriptor)
      FileUtils.rm_rf(path_for(descriptor))
    end

    def create(descriptor)
      save(default_model_class.new(descriptor: descriptor))
    end
  end
end