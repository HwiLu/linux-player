 sync;
 sleep 6;
 echo 3 >/proc/sys/vm/drop_caches
 
 # that is "sync data from cache to disk before drop."
