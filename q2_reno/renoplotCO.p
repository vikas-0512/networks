set terminal postscript;
set output 'renoplotCO.ps' ;

set autoscale
set xtic auto
set ytic auto

set title "Congestion Rate vs Simulation time"
set xlabel "Time (secs)"
set ylabel "Control Overhead"

plot "CO" u 1:2 title 'Control Overhead' w l 
 
