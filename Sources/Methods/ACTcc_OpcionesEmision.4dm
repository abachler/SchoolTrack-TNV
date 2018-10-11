//%attributes = {}
  //ACTcc_OpcionesEmision

C_TEXT:C284($vt_accion;$1)
$vt_accion:=$1

If (Count parameters:C259>=2)
	$ptr1:=$2
End if 
If (Count parameters:C259>=3)
	$ptr2:=$3
End if 

Case of 
	: ($vt_accion="EnviaMail")
		ACTcfg_LeeBlob ("ACTcfg_AlertasYOtros")
		If (cbAlertaEmisionAvisos=1)
			ACTcc_OpcionesAlertas ("LlenaDatosEnvio")
			If (ACT_VerificaInicioProceso (__ ("El sistema tiene configurada una alerta automática para avisar si el proceso de emisión de Avisos de Cobranza tiene algun problema. Si continúa con el proceso se enviará un email a la cuenta "+ST_Qte (vtACT_To)+" con el resultado de los errores durante la emisión de Avisos de Cobranzas.")))  //20160822 RCH
				ACTcc_OpcionesAlertas ("LlenaAsuntoYCuerpo")
				vbACT_NoMostrarThermo:=True:C214
				ACTcc_OpcionesAlertas ("LlenaDatosEnvio")
				ACTcc_OpcionesAlertas ("EnviaMail")
				ACTcc_OpcionesAlertas ("InitVars")
			End if 
		End if 
	: ($vt_accion="LlenaArreglosAMostrar")
		ARRAY TEXT:C222(aDeletedNames;0)
		ARRAY TEXT:C222(aMotivo;0)
		READ ONLY:C145([ACT_CuentasCorrientes:175])
		READ ONLY:C145([Alumnos:2])
		For ($i;1;Size of array:C274($ptr1->))
			GOTO RECORD:C242([ACT_CuentasCorrientes:175];$ptr1->{$i})
			AT_Insert (1;1;->aDeletedNames;->aMotivo)
			QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
			aMotivo{1}:="La cuenta corriente estaba siendo utilizada por otro proceso."
			aDeletedNames{1}:=[Alumnos:2]apellidos_y_nombres:40
		End for 
		SORT ARRAY:C229(aDeletedNames;aMotivo;>)
		
	: ($vt_accion="verifcaCuentasAEmitir")
		ARRAY TEXT:C222(aDeletedNames;0)
		ARRAY TEXT:C222(aMotivo;0)
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Verificando cuentas corrientes para emitir..."))
		For ($r;1;Size of array:C274($ptr1->))
			GOTO RECORD:C242([ACT_CuentasCorrientes:175];$ptr1->{$r})
			If ([ACT_CuentasCorrientes:175]ID_Apoderado:9=0)
				DELETE FROM ARRAY:C228($ptr2->;Find in array:C230($ptr2->;$ptr1->{$r});1)
				AT_Insert (1;1;->aDeletedNames;->aMotivo)
				QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
				aMotivo{1}:="La cuenta corriente no tiene asignado un apoderado de cuentas."
				aDeletedNames{1}:=[Alumnos:2]apellidos_y_nombres:40
			End if 
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$r/Size of array:C274($ptr1->))
		End for 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		SORT ARRAY:C229(aDeletedNames;aMotivo;>)
End case 