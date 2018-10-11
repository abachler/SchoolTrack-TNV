//%attributes = {}
C_TEXT:C284($t_uuids;$1;$0;$t_principal;$t_err;$node;$json)
C_TEXT:C284($t_principal)
C_DATE:C307($d_fecha)
C_BOOLEAN:C305($vb_saldo)
C_LONGINT:C283($l_indice)
ARRAY TEXT:C222($atACT_UUIDSAlumnos;0)
ARRAY OBJECT:C1221($ao_uuid;0)
READ ONLY:C145([Alumnos:2])
READ ONLY:C145([ACT_CuentasCorrientes:175])
READ ONLY:C145([ACT_Cargos:173])

$t_uuids:=$1
If (Count parameters:C259>=2)
	$d_fecha:=$2
End if 


  // Modificado por: Alexis Bustamante (12-06-2017)
  //TICKET 179869

  //PASO UUIDS A ARREGLO
AT_Text2Array (->$atACT_UUIDSAlumnos;$t_uuids;",")

  //creo json
  //$t_principal:=JSON New 
For ($l_indice;1;Size of array:C274($atACT_UUIDSAlumnos))
	  //$t_err:=JSON Append node ($t_principal;"estado")
	  //$node:=JSON Append text ($t_err;"uuid";$atACT_UUIDSAlumnos{$l_indice})
	$ob_temp:=OB_Create 
	OB_SET ($ob_temp;->$atACT_UUIDSAlumnos{$l_indice};"uuid")
	
	KRL_FindAndLoadRecordByIndex (->[Alumnos:2]auto_uuid:72;->$atACT_UUIDSAlumnos{$l_indice})
	If (Records in selection:C76([Alumnos:2])>0)
		KRL_FindAndLoadRecordByIndex (->[ACT_CuentasCorrientes:175]ID_Alumno:3;->[Alumnos:2]numero:1)
		If (Records in selection:C76([Alumnos:2])>0)
			QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1;*)
			If ($d_fecha#!00-00-00!)
				QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Fecha_de_Vencimiento:7<=$d_fecha;*)
				QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Fecha_de_Vencimiento:7#!00-00-00!;*)  //20151118 RCH Para asegurarnos de quitar los proyectados, aunque los proyectados tiene saldo 0.
			End if 
			QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Saldo:23#0)
			  //$node:=JSON Append bool ($t_err;"moroso";Num(Sum([ACT_Cargos]Saldo)<0))
			$vb_saldo:=Choose:C955(Num:C11(Sum:C1([ACT_Cargos:173]Saldo:23)<0)=1;True:C214;False:C215)
			OB_SET ($ob_temp;->$vb_saldo;"moroso")
		Else 
			$vt_no:="NO"
			OB_SET ($ob_temp;->$vt_no;"existe")
			  //$node:=JSON Append text ($t_err;"existe";"NO")
		End if 
	Else 
		$vt_no:="NO"
		OB_SET ($ob_temp;->$vt_no;"existe")
		  //$node:=JSON Append text ($t_err;"existe";"NO")
	End if 
	  //JSON SET TYPE ($t_principal;JSON_ARRAY)
	
	APPEND TO ARRAY:C911($ao_uuid;$ob_temp)
	CLEAR VARIABLE:C89($ob_temp)
End for 
  //$json:=JSON Export to text ($t_principal;JSON_WITHOUT_WHITE_SPACE)
  //JSON CLOSE ($t_principal)
$json:=JSON Stringify array:C1228($ao_uuid)
$0:=$json
