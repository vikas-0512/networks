set ns [new Simulator]

#getting input value for N
puts "Give Traffic percentage N"
gets stdin N

set ptf [open ptfout.dat w]
$ns trace-all $ptf

set nf [open nfout.nam w]
$ns namtrace-all $nf

set cwnd [open cwnd.dat w]

#puts $N

#Creating N nodes
set n(0) [$ns node]
$n(0) color white 

for {set i 1} {$i <= 50} {incr i} {
#puts $i
set n($i) [$ns node]
$n($i) shape box
$n($i) color green
}

#connecting all the nodes to get mesh topology
set K [expr (($N * 50)/100) ]
#puts $K
for {set i 1} {$i < 50} {incr i} {
		set j [expr $i+1]
		$ns duplex-link $n($i) $n($j) 5Mb 10ms DropTail
		$ns duplex-link-op $n($i) $n($j) color "blue"
		$ns queue-limit $n($i) $n($j) 6

	if {$i <= 12} {
 $ns duplex-link-op $n($i) $n($j) orient right
} elseif {$i <= 24} {
	$ns duplex-link-op $n($i) $n($j) orient down
} elseif {$i <= 36} {
	$ns duplex-link-op $n($i) $n($j) orient left
} else {
$ns duplex-link-op $n($i) $n($j) orient up
}   

}

for {set i 1} {$i <= $K} {incr i} {
#puts $i
	set j [expr $i + 1]
		#creating an udp agent
#puts "$i-$j"
		set tcp($i,$j) [new Agent/TCP/Reno]
		$ns attach-agent $n($i) $tcp($i,$j)
		#ceating a null agent
		set sink($i,$j) [new Agent/TCPSink]
		$ns attach-agent $n($j) $sink($i,$j)
		$ns connect $tcp($i,$j) $sink($i,$j)
		#creating cbr traffic application
		set ftp($i,$j) [new Application/FTP]
		$ftp($i,$j) attach-agent $tcp($i,$j)
		
		$ns at 0.0 "$ftp($i,$j) start"
		$ns at 50.0 "$ftp($i,$j) stop"

}

proc recWin {tcpSender f} {
	global ns
	set time 0.1
	set cTime [$ns now]
	set wnd [$tcpSender set cwnd_]
	puts $f "$cTime $wnd"
	$ns at [expr $cTime + $time] "recWin $tcpSender $f"
}
$ns at 0.1 "recWin $tcp(1,2) $cwnd"
$ns at 50.0 "finish"
proc finish {} {
	global ns nf ptf 
	$ns flush-trace 
	close $nf 
	close $ptf
	exec nam nfout.nam &
	exit 0 
}

$ns run
