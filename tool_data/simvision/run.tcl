database -open -shm -into timer.shm waves -default -event 
probe -create -shm -all -tasks -functions -variables -depth 4
run
exit
