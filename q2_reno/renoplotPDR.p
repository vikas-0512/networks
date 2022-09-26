set terminal postscript;
set output 'renoplotPDR.ps' ;

set autoscale
set xtic auto
set ytic auto

set title "Packet Delivary Rate vs Simulation time"
set xlabel "Time (secs)"
set ylabel "PDR"

plot "PDR" u 1:2 title 'Packet Delivary' w l 
 
