require_relative '../tensors/collaborator'

module Domains
  class Domain < ::Tensors::Collaborator

    Dir["#{__dir__}/steps/*"].each { |f| require f }

    class << self
      def step_precedence
        @@domain_step_precedence ||= { anywhere: [:variables] }
      end
    end

    def fqdn
      "#{host}.#{name}"
    end

    def host
      identifier
    end

    def name
      'current.engines.org'
    end

    def default
      @default ||= OpenStruct.new(fqdn: fqdn, host: host, name: name)
    end

  end
end
