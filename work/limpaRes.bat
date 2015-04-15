echo off
cd utils
mx ..\..\bases\reservas +control now >> manutencao.txt
retag ..\..\bases\reservas unlock >> manutencao.txt
mxcp ..\..\bases\reservas create=xreservas clean mintag=1 maxtag=999 >> manutencao.txt
mx xreservas iso=reservas.iso -all now >> manutencao.txt
del xreservas.* >> manutencao.txt
mx iso=reservas.iso create=..\..\bases\reservas now -all
mx ..\..\bases\reservas fst=@.\..\..\bases\reservas.fst stw=@geral.stw uctab=isisuc.tab fullinv=..\..\bases\reservas -all now >> manutencao.txt
mx ..\..\bases\reservas +control now >> manutencao.txt 
cd ..