require_relative 'division'

module Divisions
  class Subdivision < Division

    class << self
      def prototype(type:, struct:, division:)
        constant_for(type || struct.type).new(struct: struct, division: division)
      end

      def constant_for(type)
        if type
          return Module.const_get("::Providers::#{type.camelize}")
        else
          return Module.const_get("::Divisions::#{qualifier.camelize}")
        end
      end
    end

    relation_accessor :division

    delegate([:emission, :context_identifier] => :division)

    def inflated
      duplicate(self).tap { |s| s.struct = s.struct.merge(inflatables) }
    end

    def empty; self.class.new(division: division) ;end

    def initialize(division:, struct: nil)
      self.division = division
      self.struct = struct || OpenStruct.new
    end

  end
end