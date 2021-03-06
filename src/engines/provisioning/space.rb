module Provisioning
  class Space < ::Spaces::Space

    class << self
      def default_model_class
        Provisions
      end
    end

    delegate([:arenas, :resolutions] => :universe)

    def identifiers(arena_identifier: '*', resolution_identifier: '*')
      path.glob("#{arena_identifier}/#{resolution_identifier}").map do |p|
        p.relative_path_from(path)
      end
    end

    def by(identifier, klass = default_model_class)
      super
    rescue Errno::ENOENT => e
      # warn(error: e, identifier: identifier, klass: klass)
      just_print_the_error(__FILE__, __LINE__, e)
      klass.new(identifier: identifier).tap do |m|
        save(m)
      end
    end

    def reading_name_for(identifier, _, ext = nil)
      add_ext(path.join(identifier, PN(identifier).basename), ext)
    end


    def save(model)
      anchor_provisionings_for(model).each { |p| save(p) }
      arenas.save_provisions(model) if model.has?(:containers)
      super
    end

    def anchor_provisionings_for(model)
      anchor_resolutions_for(model.resolution).map do |r|
        default_model_class.new(resolution: r, arena: model.arena)
      end
    end

    def anchor_resolutions_for(resolution)
      unique_anchor_resolutions_for(resolution).map { |d| resolutions.by(d.identifier) }
    end

    def unique_anchor_resolutions_for(resolution)
      resolution.connecting_descriptors&.uniq(&:uniqueness) || []
    end

  end
end
