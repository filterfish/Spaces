require_relative '../../releases/stanza'

module Provisioning
  module Stanzas
    class Containers < ::Releases::Stanza

      def declaratives
        context.containers.map(&:stanzas).flatten.map(&:declaratives).join("\n")
      end

    end
  end
end
