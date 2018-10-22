database -open -shm -into timer.shm waves -default -event 
probe -create -shm -all -tasks -functions -variables -depth 4
probe -create d_ip_timer -depth all -database waves -memories -all
run
exit
