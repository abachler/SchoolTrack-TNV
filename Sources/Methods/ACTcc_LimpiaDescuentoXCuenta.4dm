//%attributes = {}
  //ACTcc_LimpiaDescuentoXCuenta

  //cuando se pasa el primer parámetro en true no testea privilegios (se llama desde ACTcae_DoSettings)
ARRAY TEXT:C222(atACT_NombreMonedaEm;0)
ARRAY DATE:C224(adACT_fechasEm;0)
C_BOOLEAN:C305($vb_continuar)
ARRAY LONGINT:C221($aCtas;0)
READ WRITE:C146([ACT_CuentasCorrientes:175])
If (Count parameters:C259=0)
	$vb_continuar:=USR_GetMethodAcces (Current method name:C684)
	If ($vb_continuar)
		
		ARRAY TEXT:C222(atACT_Periodos;0)
		READ ONLY:C145([ACT_DctosIndividuales_Cuentas:228])
		ALL RECORDS:C47([ACT_DctosIndividuales_Cuentas:228])
		DISTINCT VALUES:C339([ACT_DctosIndividuales_Cuentas:228]Periodo:9;atACT_Periodos)
		
		If (Size of array:C274(atACT_Periodos)>0)
			If (Size of array:C274(atACT_Periodos)>1)
				ARRAY POINTER:C280(<>aChoicePtrs;0)
				APPEND TO ARRAY:C911(<>aChoicePtrs;->atACT_Periodos)
				TBL_ShowChoiceList (1;"Seleccione el período...";-MAXINT:K35:1)
				If (ok=1)
					$t_periodo:=atACT_Periodos{choiceidx}
				Else 
					$t_periodo:=""
				End if 
			Else 
				$t_periodo:=atACT_Periodos{1}
			End if 
			If ($t_periodo#"")
				$r:=CD_Dlog (0;__ ("Todos los descuentos individuales, asignados a las cuentas corrientes, para el período "+ST_Qte ($t_periodo)+" serán Inactivados/Eliminados.\r¿Qué desea hacer?");__ ("");__ ("Cancelar");__ ("Eliminar");__ ("Inactivar"))
				If ($r=1)
					$vb_continuar:=False:C215
				End if 
			End if 
		Else 
			CD_Dlog (0;__ ("No se encuentran registros en la tabla."))
			$vb_continuar:=False:C215
		End if 
	End if 
Else 
	If (Not:C34($1))
		$vb_continuar:=USR_GetMethodAcces (Current method name:C684)
		If ($vb_continuar)
			$r:=CD_Dlog (0;__ ("Todos los descuentos por cuenta asignados serán eliminados.\r¿Desea continuar?");__ ("");__ ("Cancelar");__ ("No");__ ("Si"))
			If ($r#3)
				$vb_continuar:=False:C215
			End if 
		End if 
	Else 
		$vb_continuar:=True:C214
	End if 
End if 
If ($vb_continuar)
	Case of 
		: (Count parameters:C259<=1)
			READ ONLY:C145([ACT_DctosIndividuales_Cuentas:228])
			If ($t_periodo#"")
				QUERY:C277([ACT_DctosIndividuales_Cuentas:228];[ACT_DctosIndividuales_Cuentas:228]Periodo:9=$t_periodo)
			Else 
				ALL RECORDS:C47([ACT_DctosIndividuales_Cuentas:228])
			End if 
			KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_DctosIndividuales_Cuentas:228]ID_CuentaCorriente:6;"")
			
		: (Count parameters:C259=2)
			CREATE SELECTION FROM ARRAY:C640([ACT_CuentasCorrientes:175];$2->)
	End case 
	
	C_TEXT:C284($t_tipoDctoLog;$t_evento)
	LONGINT ARRAY FROM SELECTION:C647([ACT_CuentasCorrientes:175];$aCtas;"")
	
	ACTinit_LoadPrefs 
	ARRAY LONGINT:C221($aRecNumDocsCta;0)
	ARRAY LONGINT:C221($aRecNumsCargos;0)
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Inicializando Descuento a 0..."))
	For ($i;1;Size of array:C274($aCtas))
		READ WRITE:C146([ACT_CuentasCorrientes:175])
		GOTO RECORD:C242([ACT_CuentasCorrientes:175];$aCtas{$i})
		
		READ WRITE:C146([ACT_DctosIndividuales_Cuentas:228])
		QUERY:C277([ACT_DctosIndividuales_Cuentas:228];[ACT_DctosIndividuales_Cuentas:228]ID_CuentaCorriente:6=[ACT_CuentasCorrientes:175]ID:1)
		If ($t_periodo#"")
			QUERY SELECTION:C341([ACT_DctosIndividuales_Cuentas:228];[ACT_DctosIndividuales_Cuentas:228]Periodo:9=$t_periodo)
		End if 
		If (Records in selection:C76([ACT_DctosIndividuales_Cuentas:228])>0)
			While (Not:C34(End selection:C36([ACT_DctosIndividuales_Cuentas:228])))
				$t_tipoDcto:=KRL_GetTextFieldData (->[ACT_CFG_DctosIndividuales:229]ID:1;->[ACT_DctosIndividuales_Cuentas:228]ID_Descuento:5;->[ACT_CFG_DctosIndividuales:229]Nombre:5)
				If ($r=3)
					[ACT_DctosIndividuales_Cuentas:228]Inactivo:10:=True:C214
					$t_evento:="Descuento: "+ST_Qte ($t_tipoDcto)+", id "+String:C10([ACT_DctosIndividuales_Cuentas:228]ID:1)+" inactivado para el período "+ST_Qte ([ACT_DctosIndividuales_Cuentas:228]Periodo:9)+"."
				Else 
					$t_evento:="Descuento: "+ST_Qte ($t_tipoDcto)+", id "+String:C10([ACT_DctosIndividuales_Cuentas:228]ID:1)+" eliminado para el período "+ST_Qte ([ACT_DctosIndividuales_Cuentas:228]Periodo:9)+"."
					DELETE RECORD:C58([ACT_DctosIndividuales_Cuentas:228])
				End if 
				SAVE RECORD:C53([ACT_DctosIndividuales_Cuentas:228])
				$t_evento:=$t_evento+" Alumno: "+KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3;->[Alumnos:2]apellidos_y_nombres:40)+"."
				NEXT RECORD:C51([ACT_DctosIndividuales_Cuentas:228])
				$t_tipoDctoLog:=$t_tipoDctoLog+Choose:C955($t_tipoDctoLog="";"";"; ")+$t_evento
			End while 
		End if 
		KRL_UnloadReadOnly (->[ACT_DctosIndividuales_Cuentas:228])
		[ACT_CuentasCorrientes:175]Descuento:23:=0
		SAVE RECORD:C53([ACT_CuentasCorrientes:175])
		
		QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1;*)
		QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22=!00-00-00!;*)
		QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]ID_CargoRelacionado:47=0)
		$idmatriz:=[ACT_CuentasCorrientes:175]ID_Matriz:7
		UNLOAD RECORD:C212([ACT_CuentasCorrientes:175])
		KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->[ACT_Cargos:173]ID_Documento_de_Cargo:3;"")
		SELECTION TO ARRAY:C260([ACT_Documentos_de_Cargo:174];$aRecNumDocsCta)
		SELECTION TO ARRAY:C260([ACT_Cargos:173];$aRecNumsCargos)
		For ($i_Cargos;1;Size of array:C274($aRecNumsCargos))
			GOTO RECORD:C242([ACT_Cargos:173];$aRecNumsCargos{$i_Cargos})
			QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]ID_Documento:1=[ACT_Cargos:173]ID_Documento_de_Cargo:3)
			QUERY:C277([xxACT_ItemsMatriz:180];[xxACT_ItemsMatriz:180]ID_Matriz:1=$idmatriz;*)
			QUERY:C277([xxACT_ItemsMatriz:180]; & ;[xxACT_ItemsMatriz:180]ID_Item:2=[ACT_Cargos:173]Ref_Item:16)
			UNLOAD RECORD:C212([ACT_Cargos:173])
			If (Records in selection:C76([xxACT_ItemsMatriz:180])>0)
				$itemnomatriz:=False:C215
			Else 
				$itemnomatriz:=True:C214
			End if 
			READ WRITE:C146([ACT_Cargos:173])
			ACTcc_CalculaMontoItem ($aRecNumsCargos{$i_Cargos};$idmatriz;$itemnomatriz)
			KRL_UnloadReadOnly (->[ACT_Cargos:173])
		End for 
		
		For ($Docs;1;Size of array:C274($aRecNumDocsCta))
			ACTcc_CalculaDocumentoCargo ($aRecNumDocsCta{$Docs})
		End for 
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($aCtas))
	End for 
	
	If ($t_tipoDctoLog#"")
		LOG_RegisterEvt ("Modificación de descuentos individuales. Detalle: "+$t_tipoDctoLog)
	End if 
	
	KRL_UnloadReadOnly (->[ACT_CuentasCorrientes:175])
	KRL_UnloadReadOnly (->[ACT_Documentos_de_Cargo:174])
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	LOG_RegisterEvt ("Proceso de eliminación de descuentos por cuenta ejecutado.")
End if 