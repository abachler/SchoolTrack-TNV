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
READ ONLY:C145([xxACT_Items:179])

$t_uuids:=$1
If (Count parameters:C259>=2)
	$d_fecha:=$2
End if 

ARRAY LONGINT:C221($alACT_CIDCtaCte;0)
ARRAY DATE:C224($adACT_CFechaVencimiento;0)
ARRAY TEXT:C222($atACT_CGlosa;0)
ARRAY REAL:C219($arACT_CMontoNeto;0)
ARRAY REAL:C219($arACT_CSaldo;0)

AT_Text2Array (->$atACT_UUIDSAlumnos;$t_uuids;",")
C_LONGINT:C283($l_idApdoCargado)
For ($l_indice;1;Size of array:C274($atACT_UUIDSAlumnos))
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
			$vb_saldo:=Choose:C955(Num:C11(Sum:C1([ACT_Cargos:173]Saldo:23)<0)=1;True:C214;False:C215)
			OB_SET ($ob_temp;->$vb_saldo;"moroso")
			If (($l_idApdoCargado#[ACT_CuentasCorrientes:175]ID_Apoderado:9) & ([ACT_CuentasCorrientes:175]ID_Apoderado:9#0))
				$l_idApdoCargado:=[ACT_CuentasCorrientes:175]ID_Apoderado:9
				C_OBJECT:C1216($ob_deuda)
				$ob_deuda:=OB_Create 
				ACTwa_ObtieneDeudaApdo ($ob_deuda;[ACT_CuentasCorrientes:175]ID_Apoderado:9;$d_fecha)
				TRACE:C157
				OB GET ARRAY:C1229($ob_deuda;"idcuenta";$alACT_CIDCtaCte)
				OB GET ARRAY:C1229($ob_deuda;"vencimiento";$adACT_CFechaVencimiento)
				OB GET ARRAY:C1229($ob_deuda;"glosa";$atACT_CGlosa)
				OB GET ARRAY:C1229($ob_deuda;"neto";$arACT_CMontoNeto)
				OB GET ARRAY:C1229($ob_deuda;"saldo";$arACT_CSaldo)
			End if 
			
			ARRAY DATE:C224($adACT_CFechaVencimiento2;0)
			ARRAY TEXT:C222($atACT_CGlosa2;0)
			ARRAY REAL:C219($arACT_CMontoNeto2;0)
			ARRAY REAL:C219($arACT_CSaldo2;0)
			ARRAY LONGINT:C221($al_cuentas;0)
			ARRAY OBJECT:C1221($ao_objetos;0)
			C_OBJECT:C1216($ob_org;$ob_copy)
			
			$alACT_CIDCtaCte{0}:=[ACT_CuentasCorrientes:175]ID:1
			AT_SearchArray (->$alACT_CIDCtaCte;"=";->$al_cuentas)
			For ($l_indiceCtas;1;Size of array:C274($al_cuentas))
				If ($adACT_CFechaVencimiento{$al_cuentas{$l_indiceCtas}}<$d_fecha)
					OB SET:C1220($ob_org;"vencimiento";$adACT_CFechaVencimiento{$al_cuentas{$l_indiceCtas}})
					OB SET:C1220($ob_org;"glosa";$atACT_CGlosa{$al_cuentas{$l_indiceCtas}})
					OB SET:C1220($ob_org;"neto";$arACT_CMontoNeto{$al_cuentas{$l_indiceCtas}})
					OB SET:C1220($ob_org;"saldo";$arACT_CSaldo{$al_cuentas{$l_indiceCtas}})
					$ob_copy:=OB Copy:C1225($ob_org)
					APPEND TO ARRAY:C911($ao_objetos;$ob_copy)
				End if 
			End for 
			OB SET ARRAY:C1227($ob_temp;"deuda";$ao_objetos)
		Else 
			$vt_no:="NO"
			OB_SET ($ob_temp;->$vt_no;"existe")
		End if 
	Else 
		$vt_no:="NO"
		OB_SET ($ob_temp;->$vt_no;"existe")
	End if 
	
	APPEND TO ARRAY:C911($ao_uuid;$ob_temp)
	CLEAR VARIABLE:C89($ob_temp)
End for 
$json:=JSON Stringify array:C1228($ao_uuid)
$0:=$json
