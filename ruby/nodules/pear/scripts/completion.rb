require_relative 'requires'

module Nodules
  class Pear
    class Completion < Spaces::Script

      def body
        %Q(
        cd /tmp
        rm go-pear.phar
        )
      end

    end
  end
end