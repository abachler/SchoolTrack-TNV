$line:=AL_GetLine (xALP_Centros)
If ($line#0)
	$vt_ok:=ACTcfg_OpcionesContabilidad ("ValidaELiminacionCentroCostos";-><>alACT_idCentro{$line})
	If ($vt_ok="1")
		$r:=CD_Dlog (0;__ ("Los ítems de cargo o formas de pago que tengan asignado este centro de costos lo conservarán. ¿Desea eliminarlo?");__ ("");__ ("No");__ ("Si"))
		If ($r=2)
			AL_UpdateArrays (xALP_Centros;0)
			  //AT_Delete ($line;1;-><>asACT_Centro)
			ACTcfg_OpcionesContabilidad ("EliminaArreglosCentrosCosto";-><>alACT_idCentro{$line})
			
			AL_UpdateArrays (xALP_Centros;-2)
			  //20121105 RCH
			  //AL_SetEnterable (xALP_CtasEspeciales;3;2;<>asACT_Centro)
			IT_SetButtonState ((Size of array:C274(<>asACT_Centro)>0);Self:C308)
		End if 
	Else 
		CD_Dlog (0;__ ("El centro de costo que intenta eliminar está actualmente asignado a otro registro (forma de pago, estado de forma de pago).")+" "+__ ("No es posible eliminar el registro seleccionado."))
	End if 
End if 