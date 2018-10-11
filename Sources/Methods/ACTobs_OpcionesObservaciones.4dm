//%attributes = {}
  // Método: ACTobs_OpcionesObservaciones
  //----------------------------------------------
  // Usuario (OS): roberto
  // Fecha: 11-09-10, 15:26:21
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal

  //ACTobs_OpcionesObservaciones

C_TEXT:C284($1;$vt_accion;$0;$vt_retorno;$vt_obs)
C_LONGINT:C283($vl_numTabla;$vl_idObs;$vl_recNum;$vl_num_tabla;$vl_id_registro)
C_BOOLEAN:C305($locked)
C_POINTER:C301($ptr1;$ptr2;$ptr3)
C_POINTER:C301(${2})
C_DATE:C307($vd_fecha)

$vt_accion:=$1
If (Count parameters:C259>=2)
	$ptr1:=$2
End if 
If (Count parameters:C259>=3)
	$ptr2:=$3
End if 
If (Count parameters:C259>=4)
	$ptr3:=$4
End if 

Case of 
	: ($vt_accion="Elimina")
		$vl_idObs:=$ptr1->
		
		$vt_retorno:="1"  //registro no existe
		$vl_recNum:=Find in field:C653([ACT_Cuentas_Observaciones:102]ID:1;$vl_idObs)
		If ($vl_recNum#-1)
			READ WRITE:C146([ACT_Cuentas_Observaciones:102])
			GOTO RECORD:C242([ACT_Cuentas_Observaciones:102];$vl_recNum)
			$locked:=Locked:C147([ACT_Cuentas_Observaciones:102])
			If (Not:C34($locked))
				$vt_retorno:="0"
				DELETE RECORD:C58([ACT_Cuentas_Observaciones:102])
			End if 
		End if 
		
	: ($vt_accion="Actualiza")
		$vl_idObs:=$ptr1->
		$vt_obs:=$ptr2->
		$vd_fecha:=$ptr3->
		
		$obs:=Find in field:C653([ACT_Cuentas_Observaciones:102]ID:1;$vl_idObs)
		If ($obs#-1)
			READ WRITE:C146([ACT_Cuentas_Observaciones:102])
			GOTO RECORD:C242([ACT_Cuentas_Observaciones:102];$obs)
			[ACT_Cuentas_Observaciones:102]Observacion:4:=$vt_obs
			[ACT_Cuentas_Observaciones:102]Fecha:3:=$vd_fecha
			SAVE RECORD:C53([ACT_Cuentas_Observaciones:102])
			KRL_UnloadReadOnly (->[ACT_Cuentas_Observaciones:102])
		End if 
		
	: ($vt_accion="CargaRegistros")
		$vl_num_tabla:=$ptr1->
		$vl_id_registro:=$ptr2->
		
		READ ONLY:C145([ACT_Cuentas_Observaciones:102])
		QUERY:C277([ACT_Cuentas_Observaciones:102];[ACT_Cuentas_Observaciones:102]ID_Registro:2=$vl_id_registro;*)
		QUERY:C277([ACT_Cuentas_Observaciones:102]; & ;[ACT_Cuentas_Observaciones:102]Numero_Tabla_Asoc:10=$vl_num_tabla)
		
End case 

$0:=$vt_retorno


