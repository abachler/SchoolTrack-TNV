//%attributes = {}
  //_ACTObtenerNoTC

  //método para ser llamado desde los informes. 
  //Recibe en el parámetro 1 el número de tarjeta encriptado.
C_TEXT:C284($1;$0;$vt_tarjeta)
C_BOOLEAN:C305($2;$vb_mostrarNumCompleto;$vb_tercero)
$vt_tarjeta:=$1
$vb_mostrarNumCompleto:=False:C215
If (Count parameters:C259>=2)
	$vb_mostrarNumCompleto:=$2
End if 
If (Count parameters:C259>=3)
	$vb_tercero:=$3
End if 
If ($vb_tercero)
	$0:=ACTpp_CRYPTTC ("TCFromReport";->[ACT_Terceros:138]PAT_NumTC:36;->$vb_mostrarNumCompleto)
Else 
	$0:=ACTpp_CRYPTTC ("TCFromReport";->[Personas:7]ACT_Numero_TC:54;->$vb_mostrarNumCompleto)
End if 
  //_ACTObtenerNoTC([Personas]ACT_Numero_TC;true) `apdo
  //_ACTObtenerNoTC([ACT_Terceros]PAT_NumTC;true;true) `tercero