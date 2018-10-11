//%attributes = {}
  //dhNTA_GetBonPerProm

$0:=0

  //Case of 
  //: (◊gRolBD="87653")  `salecianos alameda
  //If (([Asignaturas]Numero_del_Nivel>11) & ([Asignaturas]Numero_del_Nivel<=12) & ([Asignaturas]Consolida_en="") & (rGradesFrom=1) & (rGradesTo=7))
  //ARRAY REAL($aNotas;0)
  //ARRAY REAL($aBonificacion;0)
  //
  //For ($i;10;70)
  //Insert in Array($aNotas;Size of array($aNotas)+1;1)
  //Insert in Array($aBonificacion;Size of array($aBonificacion)+1;1)
  //$aNotas{Size of array($aNotas)}:=$i/10
  //$aBonificacion{Size of array($aBonificacion)}:=0
  //End for 
  //$index:=Find in array($aNotas;5)
  //$aBonificacion{$index}:=0,2
  //$index:=Find in array($aNotas;5,1)
  //$aBonificacion{$index}:=0,2
  //$index:=Find in array($aNotas;5,2)
  //$aBonificacion{$index}:=0,2
  //$index:=Find in array($aNotas;5,3)
  //$aBonificacion{$index}:=0,2
  //$index:=Find in array($aNotas;5,4)
  //$aBonificacion{$index}:=0,2
  //$index:=Find in array($aNotas;5,5)
  //$aBonificacion{$index}:=0,3
  //$index:=Find in array($aNotas;5,6)
  //$aBonificacion{$index}:=0,3
  //$index:=Find in array($aNotas;5,7)
  //$aBonificacion{$index}:=0,3
  //$index:=Find in array($aNotas;5,8)
  //$aBonificacion{$index}:=0,3
  //$index:=Find in array($aNotas;5,9)
  //$aBonificacion{$index}:=0,3
  //$index:=Find in array($aNotas;6)
  //$aBonificacion{$index}:=0,4
  //$index:=Find in array($aNotas;6,1)
  //$aBonificacion{$index}:=0,4
  //$index:=Find in array($aNotas;6,2)
  //$aBonificacion{$index}:=0,4
  //$index:=Find in array($aNotas;6,3)
  //$aBonificacion{$index}:=0,4
  //$index:=Find in array($aNotas;6,4)
  //$aBonificacion{$index}:=0,4
  //$index:=Find in array($aNotas;6,5)
  //$aBonificacion{$index}:=0,5
  //$index:=Find in array($aNotas;6,6)
  //$aBonificacion{$index}:=0,4
  //$index:=Find in array($aNotas;6,7)
  //$aBonificacion{$index}:=0,3
  //$index:=Find in array($aNotas;6,8)
  //$aBonificacion{$index}:=0,2
  //$index:=Find in array($aNotas;6,9)
  //$aBonificacion{$index}:=0,1
  //$notaAbonificar:=$1
  //$index:=Find in array($aNotas;$notaAbonificar)
  //If ($index#-1)
  //$0:=$aBonificacion{$index}
  //Else 
  //$0:=0
  //End if 
  //Else 
  //$0:=0
  //End if 
  //Else 
  //$0:=0
  //End case 