//%attributes = {}
  // MÉTODO: AL_MostrarApdo
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 28/02/12, 12:14:46
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // AL_MostrarApdo()
  // ----------------------------------------------------
C_BOOLEAN:C305($b_enModoEscritura)
C_LONGINT:C283($l_BWR_BrowsingMethod;$l_recNumFamilia;$l_recordNumberAlumno;$l_resultado)
C_POINTER:C301($y_BWR_currentTable;$y_BWR_CustomArrayPointer;$y_BWR_CustonFieldRefPointer)
  // Modificado por: Saúl Ponce (04-07-2017) Ticket 184651, variable temporal para los valores de los AreaList
C_LONGINT:C283($xALP_transacciones;$xALP_Documentos;$xALP_Pagos;$xALP_DesglosePago;$xALP_Observaciones;$ALP_CargosXPagar)


  // CODIGO PRINCIPAL
  //conservamos el metodo y parametros de navegación actuales (Explorador SchoolTrack)
If (Undefined:C82(vyBWR_CustonFieldRefPointer))
	vyBWR_CustonFieldRefPointer:=->[Personas:7]No:1
End if 
If (Undefined:C82(vyBWR_CustomArrayPointer))
	vyBWR_CustomArrayPointer:=->aPersID
End if 

$l_BWR_BrowsingMethod:=vlBWR_BrowsingMethod
$y_BWR_currentTable:=yBWR_currentTable
$y_BWR_CustonFieldRefPointer:=vyBWR_CustonFieldRefPointer
$y_BWR_CustomArrayPointer:=vyBWR_CustomArrayPointer

  //cambiamos el metodo de navegación para que esta se haga sobre la base de los arreglos del area
yBWR_currentTable:=->[Personas:7]
vyBWR_CustomArrayPointer:=->aPersID
vyBWR_CustonFieldRefPointer:=->[Personas:7]No:1
vlBWR_BrowsingMethod:=BWR Array Browsing

If (Table:C252($y_BWR_currentTable)=Table:C252(->[Alumnos:2]))
	$l_resultado:=AL_fSave 
	$l_recordNumberAlumno:=Record number:C243([Alumnos:2])
	KRL_ReloadAsReadOnly (->[Alumnos:2])
Else 
	If (Table:C252($y_BWR_currentTable)=Table:C252(->[ACT_CuentasCorrientes:175]))
		$l_resultado:=ACTcc_fSave 
	End if 
End if 

If ($l_resultado>=0)
	
	If (aPersID{aPersID}>0)
		QUERY:C277([Personas:7];[Personas:7]No:1=aPersID{aPersID})
	End if 
	
	Case of 
		: (vsBWR_CurrentModule="AccountTrack")
			
			  // Modificado por: Saúl Ponce (04-07-2017) Ticket 184651, asignación de los valores Area List en variables locales
			$xALP_transacciones:=xALP_Transacciones
			$xALP_Documentos:=xALP_Documentos
			$xALP_Pagos:=xALP_Pagos
			$xALP_DesglosePago:=xALP_DesglosePago
			$xALP_Observaciones:=xALP_Observaciones
			$ALP_CargosXPagar:=ALP_CargosXPagar
			
			WDW_OpenFormWindow (->[Personas:7];"Input_ACT";2;4;XSvs_nombreTablaLocal_puntero (yBWR_currentTable))
			KRL_ModifyRecord (->[Personas:7];"Input_ACT")
			CLOSE WINDOW:C154
			
			  // Modificado por: Saúl Ponce (04-07-2017) Ticket 184651, recupera los valores de los Area List desde las variables locales
			xALP_Transacciones:=$xALP_transacciones
			xALP_Documentos:=$xALP_Documentos
			xALP_Pagos:=$xALP_Pagos
			xALP_DesglosePago:=$xALP_DesglosePago
			xALP_Observaciones:=$xALP_Observaciones
			ALP_CargosXPagar:=$ALP_CargosXPagar
			
		: (vsBWR_CurrentModule="SchoolTrack")
			$l_recNumFamilia:=Record number:C243([Familia:78])
			vb_inBrowsingMode:=False:C215
			If (Table:C252($y_BWR_currentTable)=Table:C252(->[Alumnos:2]))
				$l_recordNumberAlumno:=Record number:C243([Alumnos:2])
				$b_enModoEscritura:=(Read only state:C362([Alumnos:2])=False:C215)
				KRL_ReloadAsReadOnly (->[Alumnos:2])
			End if 
			WDW_OpenFormWindow (->[Personas:7];"Input";2;4;XSvs_nombreTablaLocal_puntero (yBWR_currentTable))
			KRL_ModifyRecord (->[Personas:7];"Input")
			CLOSE WINDOW:C154
			If (Table:C252($y_BWR_currentTable)=Table:C252(->[Alumnos:2]))
				KRL_GotoRecord (->[Alumnos:2];$l_recordNumberAlumno;$b_enModoEscritura)
			End if 
			If ($l_recNumFamilia>=0)
				READ WRITE:C146([Familia:78])
				GOTO RECORD:C242([Familia:78];$l_recNumFamilia)
			End if 
	End case 
End if 

  //reestablecemos el metodo de navegación previo
vlBWR_BrowsingMethod:=$l_BWR_BrowsingMethod
yBWR_currentTable:=$y_BWR_currentTable
vyBWR_CustonFieldRefPointer:=$y_BWR_CustonFieldRefPointer
vyBWR_CustomArrayPointer:=$y_BWR_CustomArrayPointer
