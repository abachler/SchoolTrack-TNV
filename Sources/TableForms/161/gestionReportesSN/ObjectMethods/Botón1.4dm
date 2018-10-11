$selectedIndex:=Find in array:C230(lbEventos;True:C214)
If ($selectedIndex>0)
	$r:=CD_Dlog (0;__ ("¿Está seguro de querer eliminar este evento?");"";__ ("No");__ ("Si"))
	If ($r=2)
		$p:=IT_UThermometer (1;0;__ ("Eliminando evento en SchoolNet…");-1)
		$idevento:=atQR_SNEnviosIDEvento{$selectedIndex}
		WEB SERVICE SET PARAMETER:C777("rolbd";<>gRolBD)
		WEB SERVICE SET PARAMETER:C777("codpais";<>vtXS_CountryCode)
		WEB SERVICE SET PARAMETER:C777("idevento";$idevento)
		$err:=SN3_CallWebService ("sn3ws_Informes_proceso.elimina_evento")
		IT_UThermometer (-2;$p)
		If ($err="")
			WEB SERVICE GET RESULT:C779($resultado;"resultado";*)
			If ($resultado="0")
				LISTBOX SELECT ROW:C912(lbEventos;0;lk remove from selection:K53:3)
				AT_Delete ($selectedIndex;1;->atQR_SNEnviosIDEvento;->adQR_SNEnviosFecha;->alQR_SNEnviosHora;->atQR_SNEnviosNombre;->adQR_SNEnviosDisponibleDesde)
				LISTBOX DELETE COLUMN:C830(lbRegistros;2)
				ARRAY TEXT:C222(atQR_SNEnviosRegistros;0)
				ARRAY TEXT:C222(atQR_SNEnviosCursos;0)
				ARRAY LONGINT:C221(alQR_SNEnviosIDRegistros;0)
				ARRAY TEXT:C222(atQR_SNEnviosLinkDownload;0)
				OBJECT SET ENABLED:C1123(Self:C308->;False:C215)
				OBJECT SET ENABLED:C1123(bDownload;False:C215)
				OBJECT SET ENABLED:C1123(bEliminarRegistros;False:C215)
			Else 
				CD_Dlog (0;__ ("No fue posible eliminar el evento."))
			End if 
		Else 
			CD_Dlog (0;__ ("No fue posible eliminar el evento.")+"\r"+$err)
		End if 
	End if 
End if 