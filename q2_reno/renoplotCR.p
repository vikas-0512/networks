set terminal postscript;
set output 'renoplotCR.ps' ;

set autoscale
set xtic auto
set ytic auto

set title "Congestion Rate vs Simulation time"
set xlabel "Time (secs)"
set ylabel "Congestion Rate"

plot "CR" u 1:2 title 'Congestion' w l 
 
