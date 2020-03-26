require_relative '../../texts/one_time_script'

module Bindings
  module Scripts
    class PersistentDirectories < Texts::OneTimeScript
      def body
        #Notes for future improvements
        #Most can be dynamically generated from persistent dirs in bp.
        #/home/fs/vol_dir_maps and /home/volumes/$volume are also used by fsconfigurator (static scripts in a static image)
        %Q(
        setup_persistent_dir()
        {
            if ! test -d `dirname $destination`
             then
              echo "creating Destination $destination"
              mkdir -p `dirname $destination`
             fi

             if ! test -d $dir_abs_path
              then
               echo "Creating Resolved path $dir_abs_path"
               mkdir -p $dir_abs_path
             fi

             echo "cp -rnp $dir_abs_path $destination "
            cp -rnp $dir_abs_path  $destination
            rm -rf $dir_abs_path
            echo "ln -s $ln_destination $dir_abs_path"
            ln -s $ln_destination $dir_abs_path
        }

        if test -d /home/volumes/
                then
                 for dir  in `cat /home/fs/vol_dir_maps | awk '{ print $1}'`
                  do
                   volume=`grep "$dir " /home/fs/vol_dir_maps| awk '{print $2}'`
                   dest_path=`cat /home/volumes/$volume`
                   echo Dest Path $dest_path
                   ln_destination=$dest_path/$dir
                   destination=/home/fs/$dir

                   echo $volume maps to $dest_path, for persistent dir $dir
                   dir_abs_path=resolve_abs_dir($dir)
                   setup_persistent_dir
          done
         fi

        )
      end
      def resolve_abs_dir(d)
        #         echo "Resolve path $dir_abs_path "
#                    echo $dir_abs_path/ | grep -e '^#{home_app_path}/'
#                     if test $? -ne 0
#                      then
#                       echo $dir_abs_path/ | grep ^/home/home_dir/
#                        if test $? -ne 0
#                        then
#                        echo $dir_abs_path/ | grep ^/usr/local/
#                          if test $? -ne 0
#                             then
#                               dir_abs_path=/home/$dir
#                            fi
#                       fi
#                    fi
#                    echo "Resolved path $dir_abs_path"
      end
    end
  end
end