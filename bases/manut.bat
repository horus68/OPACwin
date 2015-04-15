@echo off
@cls
echo ========================================================================== >> manutencao.txt
echo INICIO: - %date% - %time%
echo ==========================================================================
echo Este procedimento, dependendo do tamanho das suas bases de dados, pode
echo demorar alguns minutos. Seja paciente. Aguarde que o processo termine!
echo ==========================================================================
echo INICIO: - %date% - %time% >> manutencao.txt
          retag _cnf unlock
          mx _cnf copy=_cnf "proc='d101d102','a101#S#','a102#Em manutenção!#" -all now
echo 1 - Base de dados do calendario                                (cal)
echo ========================================================================== >> manutencao.txt
          mx cal +control now >> manutencao.txt
          retag cal unlock >> manutencao.txt
          mxcp cal create=xcal clean mintag=1 maxtag=999 >> manutencao.txt
          mx xcal create=cal -all now >> manutencao.txt
          del xcal.* >> manutencao.txt
          mx cal fst=@ uctab=isisuc.tab fullinv=cal -all now >> manutencao.txt
          mx cal +control now >> manutencao.txt

echo 2 - Base de dados de reservas                                  (reservas)
echo ========================================================================== >> manutencao.txt
          mx reservas +control now >> manutencao.txt
          retag reservas unlock >> manutencao.txt
          mxcp reservas create=xreservas clean mintag=1 maxtag=999 >> manutencao.txt
          mx xreservas create=reservas -all now >> manutencao.txt
          del xreservas.* >> manutencao.txt
          mx reservas fst=@ uctab=isisuc.tab fullinv=reservas -all now >> manutencao.txt
          mx reservas +control now >> manutencao.txt

echo 3 - Base de dados de utilizadores institucionais               (users)
echo ========================================================================== >> manutencao.txt
          mx users +control now >> manutencao.txt
          retag users unlock >> manutencao.txt
          mxcp users create=xusers clean mintag=1 maxtag=999 >> manutencao.txt
          mx xusers create=users -all now >> manutencao.txt
          del xusers.* >> manutencao.txt
          mx users fst=@ uctab=isisuc.tab  fullinv=users -all now >> manutencao.txt
          mx users +control now >> manutencao.txt

echo 4 - Base de dados de utilizadores individuais                  (leitor)
echo ========================================================================== >> manutencao.txt
          mx leitor +control now >> manutencao.txt
          retag leitor unlock >> manutencao.txt
          mxcp leitor create=xleitor clean mintag=1 maxtag=999 >> manutencao.txt
          mx xleitor create=leitor -all now >> manutencao.txt
          del xleitor.* >> manutencao.txt
          mx leitor fst=@ uctab=isisuc.tab  fullinv=leitor -all now >> manutencao.txt
          mx leitor +control now >> manutencao.txt


echo 5 - Base de dados de senhas                                    (niplt)
echo ========================================================================== >> manutencao.txt
          mx niplt +control now >> manutencao.txt
          retag niplt unlock >> manutencao.txt
          mxcp niplt create=xniplt clean mintag=600 maxtag=999 >> manutencao.txt
          mx xniplt create=niplt -all now >> manutencao.txt
          del xniplt.* >> manutencao.txt
          mx niplt fst=@ uctab=isisuc.tab fullinv=niplt -all now >> manutencao.txt
          mx niplt +control now >> manutencao.txt

echo 6 - Base de dados de permissões                                (prmusr)
echo ========================================================================== >> manutencao.txt
          mx prmusr +control now >> manutencao.txt
          retag prmusr unlock >> manutencao.txt
          mxcp prmusr create=xprmusr clean mintag=600 maxtag=999 >> manutencao.txt
          mx xprmusr create=prmusr -all now >> manutencao.txt
          del xprmusr.* >> manutencao.txt
          mx prmusr fst=@ uctab=isisuc.tab fullinv=prmusr -all now >> manutencao.txt
          mx prmusr +control now >> manutencao.txt

echo 7 - Base de dados de parametros                                (param)
echo ========================================================================== >> manutencao.txt
          mx param +control now >> manutencao.txt
          retag param unlock >> manutencao.txt
          mxcp param create=xparam clean mintag=600 maxtag=999 >> manutencao.txt
          mx xparam create=param -all now >> manutencao.txt
          del xparam.* >> manutencao.txt
          mx param fst=@ uctab=isisuc.tab fullinv=param -all now >> manutencao.txt
          mx param +control now >> manutencao.txt

echo 8 - Base de dados de vouchers                                  (vouchers)
echo ========================================================================== >> manutencao.txt
          mx vouchers +control now >> manutencao.txt
          retag vouchers unlock >> manutencao.txt
          mxcp vouchers create=xvouchers clean mintag=600 maxtag=999 >> manutencao.txt
          mx xvouchers create=vouchers -all now >> manutencao.txt
          del xvouchers.* >> manutencao.txt
          mx vouchers fst=@ uctab=isisuc.tab fullinv=vouchers -all now >> manutencao.txt
          mx vouchers +control now >> manutencao.txt

echo ==========================================================================
          mx _cnf copy=_cnf "proc='d101d102','a201#N#'" -all now

echo FIM: - %date% - %time%
echo ==========================================================================
echo FIM: - %date% - %time% >> manutencao.txt