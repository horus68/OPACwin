@echo off
@cls
echo ========================================================================== >> reset.txt
echo INICIO: - %date% - %time%
echo ==========================================================================
echo Este procedimento, dependendo do tamanho das suas bases de dados, pode
echo demorar alguns minutos. Seja paciente. Aguarde que o processo termine!
echo ==========================================================================
cd utils
set BASESPATH=..\..\bases\
echo 1 - Base de dados de reservas                                  (reservas)
echo ========================================================================== >> reset.txt
          mx %BASESPATH%reservas +control now >> reset.txt
          retag %BASESPATH%reservas unlock >> reset.txt
          mx %BASESPATH%reservas "proc='D.'" copy=%BASESPATH%reservas now -all >> reset.txt
          mx %BASESPATH%reservas iso=%BASESPATH%reservas.iso now -all 
	  mx iso=%BASESPATH%reservas.iso  create=%BASESPATH%reservas  now -all 
	  del %BASESPATH%reservas.iso
          mx %BASESPATH%reservas fst=@ uctab=isisuc.tab  fullinv=%BASESPATH%reservas -all now >> reset.txt
          mx %BASESPATH%reservas +control now >> reset.txt

		  
echo 2 - Base de dados de senhas                                    (niplt)
echo ========================================================================== >> reset.txt
          mx %BASESPATH%niplt +control now >> reset.txt
          retag %BASESPATH%niplt unlock >> reset.txt
          mx %BASESPATH%niplt "proc='D.'" from=3 copy=%BASESPATH%niplt now -all >> reset.txt
	  mx %BASESPATH%niplt iso=%BASESPATH%niplt.iso now -all 
	  mx iso=%BASESPATH%niplt.iso  create=%BASESPATH%niplt  now -all 
	  del %BASESPATH%niplt.iso >> reset.txt
          mx %BASESPATH%niplt fst=@ uctab=isisuc.tab  fullinv=%BASESPATH%niplt -all now >> reset.txt
          mx %BASESPATH%niplt +control now >> reset.txt

		  
echo 3 - Base de dados de permissões                                (prmusr)
echo ========================================================================== >> reset.txt
          mx %BASESPATH%prmusr +control now >> reset.txt
          retag %BASESPATH%prmusr unlock >> reset.txt
          mx %BASESPATH%prmusr "proc='D.'" from=2 copy=%BASESPATH%prmusr now -all >> reset.txt
	  mx %BASESPATH%prmusr iso=%BASESPATH%prmusr.iso now -all 
	  mx iso=%BASESPATH%prmusr.iso  create=%BASESPATH%niplt  now -all 
	  del %BASESPATH%prmusr.iso >> reset.txt
          mx %BASESPATH%prmusr fst=@ uctab=isisuc.tab fullinv=%BASESPATH%prmusr -all now >> reset.txt
          mx %BASESPATH%prmusr +control now >> reset.txt

		  
echo 4 - Base de dados de vouchers                                  (vouchers)
echo ========================================================================== >> reset.txt
          mx %BASESPATH%vouchers +control now >> reset.txt
          retag %BASESPATH%vouchers unlock >> reset.txt
          mx %BASESPATH%vouchers "proc='D.'" copy=%BASESPATH%vouchers now -all >> reset.txt
	  mx %BASESPATH%vouchers iso=%BASESPATH%vouchers.iso now -all 
	  mx iso=%BASESPATH%vouchers.iso  create=%BASESPATH%vouchers  now -all 
	  del %BASESPATH%vouchers.iso >> reset.txt
          mx %BASESPATH%vouchers fst=@ uctab=isisuc.tab fullinv=%BASESPATH%vouchers -all now >> reset.txt
          mx %BASESPATH%vouchers +control now >> reset.txt

		  
echo 5 - Base de dados de comentarios                               (comments)
echo ========================================================================== >> reset.txt
          mx %BASESPATH%comments +control now >> reset.txt
          retag %BASESPATH%comments unlock >> reset.txt
          mx %BASESPATH%comments "proc='D.'" copy=%BASESPATH%comments now -all >> reset.txt
	  mx %BASESPATH%comments iso=%BASESPATH%comments.iso now -all 
	  mx iso=%BASESPATH%comments.iso  create=%BASESPATH%comments  now -all 
	  del %BASESPATH%comments.iso >> reset.txt
          mx %BASESPATH%comments fst=@ uctab=isisuc.tab fullinv=%BASESPATH%comments -all now >> reset.txt
          mx %BASESPATH%comments +control now >> reset.txt

		  
echo 6 - Base de dados de tags                                      (tags)
echo ========================================================================== >> reset.txt
          mx %BASESPATH%tags +control now >> reset.txt
          retag %BASESPATH%tags unlock >> reset.txt
          mx %BASESPATH%tags "proc='D.'" copy=%BASESPATH%tags now -all >> reset.txt
	  mx %BASESPATH%tags iso=%BASESPATH%tags.iso now -all 
	  mx iso=%BASESPATH%tags.iso  create=%BASESPATH%tags  now -all 
	  del %BASESPATH%tags.iso >> reset.txt
          mx %BASESPATH%tags fst=@ uctab=isisuc.tab  fullinv=%BASESPATH%tags -all now >> reset.txt
          mx %BASESPATH%tags +control now >> reset.txt

		  
echo 7 - Base de dados de votos                                    (votos)
echo ========================================================================== >> reset.txt
          mx %BASESPATH%votos +control now >> reset.txt
          retag %BASESPATH%votos unlock >> reset.txt
          mx %BASESPATH%votos "proc='D.'" copy=%BASESPATH%votos now -all >> reset.txt
	  mx %BASESPATH%votos iso=%BASESPATH%votos.iso now -all 
	  mx iso=%BASESPATH%votos.iso  create=%BASESPATH%votos  now -all 
	  del %BASESPATH%votos.iso >> reset.txt
          mx %BASESPATH%votos fst=@ uctab=isisuc.tab fullinv=%BASESPATH%votos -all now >> reset.txt
          mx %BASESPATH%votos +control now >> reset.txt

echo 8 - Base de dados de top reservas                              (sumres)
echo ========================================================================== >> reset.txt
          mx %BASESPATH%sumres +control now >> reset.txt
          retag %BASESPATH%sumres unlock >> reset.txt
          mx %BASESPATH%sumres "proc='D.'" copy=%BASESPATH%sumres now -all >> reset.txt
	  mx %BASESPATH%votos iso=%BASESPATH%votos.iso now -all 
	  mx iso=%BASESPATH%votos.iso  create=%BASESPATH%votos  now -all 
	  del %BASESPATH%votos.iso >> reset.txt
          mx %BASESPATH%sumres fst=@ uctab=isisuc.tab fullinv=%BASESPATH%sumres -all now >> reset.txt
          mx %BASESPATH%sumres +control now >> reset.txt		  
echo FIM: - %date% - %time%
echo ==========================================================================
echo FIM: - %date% - %time% >> reset.txt