//%attributes = {}
  //ACTmnu_CambiarTipoDctoTrib
$found:=BWR_SearchRecords 
If ($found#-1)
	
	C_BOOLEAN:C305(vbACT_CTDdesdeTerceros;$vb_continuar)
	
	READ ONLY:C145([Personas:7])
	READ ONLY:C145([ACT_Terceros:138])
	
	vbACT_CTDdesdeTerceros:=False:C215
	Case of 
		: (Table:C252(yBWR_currentTable)=Table:C252(->[ACT_Terceros:138]))
			vbACT_CTDdesdeTerceros:=True:C214
			
		: (Table:C252(yBWR_currentTable)=Table:C252(->[Personas:7]))
			vbACT_CTDdesdeTerceros:=False:C215
			
	End case 
	
	$vb_continuar:=False:C215
	If (vbACT_CTDdesdeTerceros)
		If (Records in selection:C76([ACT_Terceros:138])>0)
			If (USR_checkRights ("M";->[ACT_Terceros:138]))
				$vb_continuar:=True:C214
			Else 
				USR_ALERT_UserHasNoRights (3)
			End if 
		Else 
			CD_Dlog (0;__ ("No hay Terceros seleccionados."))
		End if 
	Else 
		If (Records in selection:C76([Personas:7])>0)
			If (USR_checkRights ("M";->[Personas:7]))
				$vb_continuar:=True:C214
			Else 
				USR_ALERT_UserHasNoRights (3)
			End if 
		Else 
			CD_Dlog (0;__ ("No hay Apoderados seleccionados."))
		End if 
	End if 
	
	
	If ($vb_continuar)
		  //If (USR_checkRights ("M";->[ACT_Pagos]))
		WDW_OpenFormWindow (->[Personas:7];"ACT_CambioTipoDocumento";-1;4;"Cambio de tipo de documento")
		DIALOG:C40([Personas:7];"ACT_CambioTipoDocumento")
		CLOSE WINDOW:C154
		
		If (ok=1)
			
			ARRAY LONGINT:C221($alACT_recNum;0)
			If (vbACT_CTDdesdeTerceros)
				LONGINT ARRAY FROM SELECTION:C647([ACT_Terceros:138];$alACT_recNum;"")
			Else 
				LONGINT ARRAY FROM SELECTION:C647([Personas:7];$alACT_recNum;"")
			End if 
			
			C_BOOLEAN:C305($b_mostrarMsj;$b_hecho)
			
			If (Size of array:C274($alACT_recNum)>0)
				$r:=CD_Dlog (0;__ ("¿Desea realmente modificar el tipo de documento de "+String:C10(Size of array:C274($alACT_recNum))+" registro(s) seleccionado(s)?");__ ("");__ ("No");__ ("Si"))
				If ($r=2)
					$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Cambiando tipo de documento..."))
					For ($i;1;Size of array:C274($alACT_recNum))
						$b_hecho:=ACTpp_OpcionesCambioTipoDoc ("AsignaNuevoEstado";->$alACT_recNum{$i})
						If (Not:C34($b_hecho))
							$b_mostrarMsj:=True:C214
						End if 
						$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($alACT_recNum))
					End for 
					$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
					
					If ($b_mostrarMsj)
						CD_Dlog (0;__ ("Algunos registros no pudieron ser modificados debido a que estaban en uso."))
					End if 
					<>vb_Refresh:=True:C214
				End if 
			Else 
				CD_Dlog (0;__ ("No hay registros que cumplan con el criterio de búsqueda."))
			End if 
		End if 
		ACTpp_OpcionesCambioTipoDoc ("InicializaVars")
		
	Else 
		
	End if 
Else 
	
	CD_Dlog (0;__ ("Seleccione previamente los registros que desea modificar."))
	USE SET:C118("$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable)))
	BWR_SelectTableData 
End if 