//%attributes = {}
  //ACTpgs_LimpiaVarsInterfaz

C_TEXT:C284($vt_accion;$1)
C_POINTER:C301(${2})
C_POINTER:C301($ptr1;$ptr2;$ptr3;$ptr4)

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
If (Count parameters:C259>=5)
	$ptr4:=$5
End if 

Case of 
	: ($vt_accion="UpdateAreas")
		AL_UpdateArrays (ALP_AvisosXPagar;$ptr1->)
		AL_UpdateArrays (ALP_ItemsXPagar;$ptr1->)
		AL_UpdateArrays (ALP_AlumnosXPagar;$ptr1->)
		AL_UpdateArrays (ALP_AvisosAgrupadosXPagar;$ptr1->)
		
	: ($vt_accion="UpdateAreas0")
		$vl_accion:=0
		ACTpgs_LimpiaVarsInterfaz ("UpdateAreas";->$vl_accion)
		
	: ($vt_accion="UpdateAreas2")
		$vl_accion:=-2
		ACTpgs_LimpiaVarsInterfaz ("UpdateAreas";->$vl_accion)
		
	: ($vt_accion="ClearVars_Arrays")
		If ($ptr1->)
			ACTpgs_LimpiaVarsInterfaz ("UpdateAreas0")
		End if 
		IT_SetEnterable (False:C215;0;->vrACT_MontoDesctoAfecto;->vrACT_MontoDesctoExento)
		ACTpgs_ClearDlogVars 
		ACTpgs_DeclareArraysInterfaz 
		If ($ptr1->)
			ACTpgs_LimpiaVarsInterfaz ("UpdateAreas2")
		End if 
		  //20130131 RCH Para limpiar los RN
		ACTpgs_LimpiaVarsInterfaz ("InitVarsApdoCtaTer")
		
	: ($vt_accion="InitVarsApdoCtaTer")
		RNApdo:=-1
		RNCta:=-1
		RNTercero:=-1
		
	: ($vt_accion="SeteaObjetos")
		If (btn_apdo=1)
			OBJECT SET VISIBLE:C603(*;"labelTer@";False:C215)
			OBJECT SET VISIBLE:C603(*;"labelApdo@";True:C214)
			If (cb_PermitePorCta=1)
				OBJECT SET VISIBLE:C603(*;"cta@";True:C214)
			Else 
				OBJECT SET VISIBLE:C603(*;"cta@";False:C215)
			End if 
		Else 
			OBJECT SET VISIBLE:C603(*;"labelTer@";True:C214)
			OBJECT SET VISIBLE:C603(*;"labelApdo@";False:C215)
			OBJECT SET VISIBLE:C603(*;"cta@";False:C215)
		End if 
		
	: ($vt_accion="SeteaObjetosYSelPage")
		C_LONGINT:C283($page)
		If (btn_apdo=1)
			$page:=1
		Else 
			$page:=4
		End if 
		ACTpgs_LimpiaVarsInterfaz ("SeteaObjetos")
		FORM GOTO PAGE:C247($page)
		SELECT LIST ITEMS BY POSITION:C381(hlACT_IngresoPagos;$page)
		If (Not:C34(Is nil pointer:C315($ptr1)))
			$ptr1->:=$page
		End if 
		
	: ($vt_accion="CargaDatos")
		Case of 
			: (vbACT_PagoXApdo)
				ACTpgs_CargaDatosPagoApdo (True:C214;vdACT_FechaPago)
			: (vbACT_PagoXCuenta)
				ACTpgs_CargaDatosPagoCta (True:C214;vdACT_FechaPago)
				
			: (vbACTpgs_PagoXTercero)
				ACTpgs_CargaDatosPagoTercero (True:C214;vdACT_FechaPago)
				
		End case 
		
	: ($vt_accion="RecargaDatos3")
		ACTpgs_LimpiaVarsInterfaz ("CapturaRecNumsRegistros")
		ACTpgs_LimpiaVarsInterfaz ("Recarga")
		ACTpgs_LimpiaVarsInterfaz ("CargaDatos")
		ACTpgs_LimpiaVarsInterfaz ("SeleccionaTodosCargosAPagar")
		
	: ($vt_accion="RecargaDatos2")
		ACTpgs_LimpiaVarsInterfaz ("CapturaRecNumsRegistros")
		ACTpgs_LimpiaVarsInterfaz ("RecargaDatos")
		
	: ($vt_accion="Recarga")
		LOAD RECORD:C52([Personas:7])
		ACTpgs_LimpiaVarsInterfaz ("CapturaRecNumsRegistros")
		Case of 
			: (vbACT_PagoXApdo)
				KRL_GotoRecord (->[Personas:7];vlACTpgs_recNumApdo)
				  //GOTO RECORD([Personas];vlACTpgs_recNumApdo)
			: (vbACT_PagoXCuenta)
				  //GOTO RECORD([Alumnos];vlACTpgs_recNumAlumno)
				KRL_GotoRecord (->[ACT_CuentasCorrientes:175];vlACTpgs_recNumCtaCte)
				  //GOTO RECORD([ACT_CuentasCorrientes];vlACTpgs_recNumCtaCte)
				KRL_FindAndLoadRecordByIndex (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3)
				  //GOTO RECORD([Personas];vlACTpgs_recNumApdo)
				KRL_GotoRecord (->[Personas:7];vlACTpgs_recNumApdo)
			: (vbACTpgs_PagoXTercero)
				  //GOTO RECORD([ACT_Terceros];vlACTpgs_recNumTercero)
				KRL_GotoRecord (->[ACT_Terceros:138];vlACTpgs_recNumTercero)
		End case 
		
	: ($vt_accion="RecargaDatos")
		ACTpgs_LimpiaVarsInterfaz ("UpdateAreas0")
		ACTpgs_LimpiaVarsInterfaz ("Recarga")
		ACTpgs_LimpiaVarsInterfaz ("CargaDatos")
		ACTpgs_LimpiaVarsInterfaz ("InitRecNumsRegistros")
		ACTpgs_LimpiaVarsInterfaz ("UpdateAreas2")
		ACTpgs_LimpiaVarsInterfaz ("SeteaTodasFlechas")
		
	: ($vt_accion="CapturaRecNumsRegistros")
		
		  //ASM 20140226 Ticket 129604 , se descargaba el registro de cuentas corrientes.
		LOAD RECORD:C52([Alumnos:2])
		LOAD RECORD:C52([ACT_CuentasCorrientes:175])
		LOAD RECORD:C52([Personas:7])
		LOAD RECORD:C52([ACT_Terceros:138])
		
		vlACTpgs_recNumAlumno:=Record number:C243([Alumnos:2])
		vlACTpgs_recNumCtaCte:=Record number:C243([ACT_CuentasCorrientes:175])
		vlACTpgs_recNumApdo:=Record number:C243([Personas:7])
		vlACTpgs_recNumTercero:=Record number:C243([ACT_Terceros:138])
		
	: ($vt_accion="InitRecNumsRegistros")
		vlACTpgs_recNumAlumno:=-1
		vlACTpgs_recNumCtaCte:=-1
		vlACTpgs_recNumApdo:=-1
		vlACTpgs_recNumTercero:=-1
		
	: ($vt_accion="SeteaTodasFlechas")
		ACTpgs_LimpiaVarsInterfaz ("SeteaFlechas1")
		ACTpgs_LimpiaVarsInterfaz ("SeteaFlechas2")
		ACTpgs_LimpiaVarsInterfaz ("SeteaFlechas3")
		ACTpgs_LimpiaVarsInterfaz ("SeteaFlechas4")
		
	: ($vt_accion="SeteaFlechas1")
		$line:=AL_GetLine (ALP_AvisosXPagar)
		If (($line=0) | ($line=1))
			_O_DISABLE BUTTON:C193(bSubirAviso)
		Else 
			_O_ENABLE BUTTON:C192(bSubirAviso)
		End if 
		
		If (($line=0) | ($line=Size of array:C274(alACT_AIDAviso)))
			_O_DISABLE BUTTON:C193(bBajarAviso)
		Else 
			_O_ENABLE BUTTON:C192(bBajarAviso)
		End if 
		
	: ($vt_accion="SeteaFlechas2")
		$line:=AL_GetLine (ALP_ItemsXPagar)
		If (($line=0) | ($line=1))
			_O_DISABLE BUTTON:C193(bSubirItem)
		Else 
			_O_ENABLE BUTTON:C192(bSubirItem)
		End if 
		
		If (($line=0) | ($line=Size of array:C274(alACT_RefItem)))
			_O_DISABLE BUTTON:C193(bBajarItem)
		Else 
			_O_ENABLE BUTTON:C192(bBajarItem)
		End if 
	: ($vt_accion="SeteaFlechas3")
		$line:=AL_GetLine (ALP_AlumnosXPagar)
		If (($line=0) | ($line=1))
			_O_DISABLE BUTTON:C193(bSubirCuenta)
		Else 
			_O_ENABLE BUTTON:C192(bSubirCuenta)
		End if 
		
		If (($line=0) | ($line=Size of array:C274(alACT_AIdsCtas)))
			_O_DISABLE BUTTON:C193(bBajarCuenta)
		Else 
			_O_ENABLE BUTTON:C192(bBajarCuenta)
		End if 
		
	: ($vt_accion="SeteaFlechas4")
		$line:=AL_GetLine (ALP_AvisosAgrupadosXPagar)
		If (($line=0) | ($line=1))
			_O_DISABLE BUTTON:C193(bSubirDocumento)
		Else 
			_O_ENABLE BUTTON:C192(bSubirDocumento)
		End if 
		
		If (($line=0) | ($line=Size of array:C274(abACT_ASelectedAgrupado)))
			_O_DISABLE BUTTON:C193(bBajarDocumento)
		Else 
			_O_ENABLE BUTTON:C192(bBajarDocumento)
		End if 
		
	: ($vt_accion="SeleccionaTodosCargosAPagar")
		If (btn_apdo=1)
			$page:=FORM Get current page:C276  //para seleccionar todos los cargos y avisos
		Else 
			$page:=4
		End if 
		$vb_bool:=True:C214
		ACTpgs_MarkNotMark ("InitArrays";->$page;->$vb_bool)
		ACTpgs_RecalculaDeuda ("recalculoSeleccionado";vdACT_FechaPago)
		
	: ($vt_accion="SetVarsIngresoPago")
		C_BOOLEAN:C305(vbACT_PagoXApdo;vbACT_PagoXCuenta;vbACTpgs_PagoXTercero)
		vbACT_PagoXApdo:=False:C215
		vbACT_PagoXCuenta:=False:C215
		vbACTpgs_PagoXTercero:=False:C215
		Case of 
			: (RNApdo>-1)
				vbACT_PagoXApdo:=True:C214
			: (RNCta>-1)
				vbACT_PagoXCuenta:=True:C214
			: (RNTercero>-1)
				vbACTpgs_PagoXTercero:=True:C214
		End case 
		
	: ($vt_accion="VarsFiltroCargos")
		C_BOOLEAN:C305(vbACT_CargosDesdeAviso;vbACT_CargosDesdeItems;vbACT_CargosDesdeAlumnos;vbACT_CargosDesdeAgrupado)
		vbACT_CargosDesdeAviso:=False:C215
		vbACT_CargosDesdeItems:=False:C215
		vbACT_CargosDesdeAlumnos:=False:C215
		vbACT_CargosDesdeAgrupado:=False:C215
		
End case 
