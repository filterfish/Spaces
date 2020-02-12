require_relative '../products/product'
require_relative '../docker/files/collaboration'
require_relative 'package'

module Packages
  class Packages < ::Products::Product
    include Docker::Files::Collaboration

    Dir["#{__dir__}/steps/*"].each { |f| require f }

    class << self
      def step_precedence
        @@packages_step_precedence ||= { late: [:run_scripts] }
      end
    end

    def all
      @all ||= tensor.struct.packages&.map { |s| package_class.new(struct: s, context: self) } || []
    end

    def scripts
      all.map { |s| s.scripts }
    end

    def build_script_path
      "#{super}/packages"
    end

    def package_class
      Package
    end

  end
end
