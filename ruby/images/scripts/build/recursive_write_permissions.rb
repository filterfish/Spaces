require_relative '../../../collaborators/script'

module Images
  module Scripts
    class RecursiveWritePermissions < Collaborators::Script
      def body
        #Notes for future improvements
        #for each directory to permission #remove ^../ and /../ from string
        #also strip any proceeding #{home_app_path} and remove any trailing /    
        # then for each directory_to_permission
        #directory=directory_to_permission
        #set_write_permissions        
        %Q(           
        . #{framework_build_script_path}/build_functions.sh
        
        for directory in $*
         do
           set_recursive_write_permissions
        done              
        )
      end

      def identifier
        'recursive_write_permissions'
      end
    end
  end
end