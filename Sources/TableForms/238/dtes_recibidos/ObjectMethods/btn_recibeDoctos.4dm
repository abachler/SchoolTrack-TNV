C_BOOLEAN:C305($b_ejecutado)
C_LONGINT:C283($l_proc)
ARRAY LONGINT:C221($alACT_idsDTEsRecibidos1;0)
ARRAY LONGINT:C221($alACT_idsDTEsRecibidos2;0)
ARRAY LONGINT:C221($alACT_idsDTEsRecibidos3;0)
C_LONGINT:C283($l_idRS)

READ ONLY:C145([ACT_DTEs_Recibidos:238])
ALL RECORDS:C47([ACT_DTEs_Recibidos:238])
SELECTION TO ARRAY:C260([ACT_DTEs_Recibidos:238]id:1;$alACT_idsDTEsRecibidos1)

$l_idRS:=[ACT_RazonesSociales:279]id:1

$l_proc:=IT_UThermometer (1;0;"Recibiendo documentos...")
$b_ejecutado:=ACTdte_DocumentosRecibidos 

vlACT_RSSel:=$l_idRS
ACTcfg_OpcionesRazonesSociales ("CargaByID";->vlACT_RSSel)

If ($b_ejecutado)
	
	ACTdteRec_Generales ("SetFechaHora")
	
	ACTdteRec_Generales ("InicializaOpcionesBusqueda")
	
	READ ONLY:C145([ACT_DTEs_Recibidos:238])
	ALL RECORDS:C47([ACT_DTEs_Recibidos:238])
	SELECTION TO ARRAY:C260([ACT_DTEs_Recibidos:238]id:1;$alACT_idsDTEsRecibidos2)
	
	AT_Difference (->$alACT_idsDTEsRecibidos2;->$alACT_idsDTEsRecibidos1;->$alACT_idsDTEsRecibidos3)
	
	ACTdteRec_LlenaArreglos (vlACT_RSSel;"";"";0;!00-00-00!;!00-00-00!;"";"";->$alACT_idsDTEsRecibidos3)
	
	ACTdteRec_CreaArreglosBusqueda 
	
Else 
	CD_Dlog (0;__ ("No fue posible recibir los documentos en este minuto. Intente más tarde."))
End if 

IT_UThermometer (-2;$l_proc)