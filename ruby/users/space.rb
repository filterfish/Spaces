require_relative 'user'
require_relative '../spaces/space'

module Users
  class Space < ::Spaces::Space

    def save_yaml(model)
      model.struct.identifier ||= Time.now.to_i
      f = File.open("#{file_name_for(model.identifier)}.yaml", 'w')
      begin
        f.write(model.to_yaml)
      ensure
        f.close
      end
    end

    def file_name_for(identifier)
      ensure_space
      "#{path}/#{identifier}"
    end

    def model_class
      User
    end
  end
end