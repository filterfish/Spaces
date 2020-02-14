require_relative '../framework'

module Frameworks
  module Python37
    class Python37 < Framework

      Dir["#{__dir__}/scripts/*"].each { |f| require f }
      Dir["#{__dir__}/steps/*"].each { |f| require f }

      class << self
        def identifier
          'python37'
        end

        def cont_user
          'python'
        end
        
        def script_precedence
          @@apache_php_script_precedence ||= [:configuration, :installation, :finalisation]
        end

        def step_precedence
          @@apache_php_step_precedence ||= {
            first: [:from_image],
            anywhere: [:variables],
            last: [:configure]
          }
        end
      end

    end
  end
end