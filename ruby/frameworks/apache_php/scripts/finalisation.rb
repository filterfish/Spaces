require_relative '../../../products/script'

module Frameworks
  module ApachePHP
    module Scripts
      class Finalisation < Products::Script

        def body
          %Q(
          mkdir  -p /var/log/apache2/
          chown www-data /var/log/apache2/
          mkdir  -p /run/apache2/
          chown www-data /run/apache2/
          )
        end

        def identifier
          'finalisation'
        end

      end
    end
  end
end
