require_relative 'division'

module Emissions
  class Divisible < Division

    class << self
      def subdivision_class
        Module.const_get(name.singularize)
      end

      def default_struct; [] ;end
    end

    delegate(subdivision_class: :klass)

    def related_divisions
      @related_divisions ||= emission.divisions
    end

    def arena_stanzas; all.map(&:arena_stanzas) ;end
    def provisioning_stanzas; all.map(&:provisioning_stanzas) ;end

    def embed!(other)
      tap { self.struct = struct_with(other) }
    end

    def struct_with(other); [struct, other.struct].flatten.uniq ;end

    def all
      @all ||= struct&.map { |s| subdivision_for(s) }&.compact || []
    end

    def subdivision_for(struct)
      subdivision_class.new(struct: struct, division: self)
    rescue NameError => _
      struct
    rescue ArgumentError => e
      # warn(error: e, klass: self.class, blueprint: context_identifier, content: struct.to_h_deep)
      just_print_the_error(__FILE__, __LINE__, e)
      nil
    end

    def emit; all&.map(&:emit) || super ;end

    def initialize(struct: nil, emission: nil, label: nil)
      check_subdivision_class
      super
    end

    def check_subdivision_class
      subdivision_class
    rescue NameError => e
      # warn(error: e, klass: klass.name.singularize, verbosity: [:silence])
      just_print_the_error(__FILE__, __LINE__, e)
    end

  end
end
