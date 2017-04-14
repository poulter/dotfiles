try
   :PlugUpdate
   :q
   :q
   let succeeded=1
finally
   if !exists('succeeded')
      echo "An error occurred.  Execution should be stopped . . ."
   endif
endtry
