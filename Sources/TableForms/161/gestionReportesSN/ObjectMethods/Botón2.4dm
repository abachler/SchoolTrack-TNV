C_TEXT:C284($res)
C_LONGINT:C283($resultado)
ARRAY LONGINT:C221($aids;0)
For ($i;1;Size of array:C274(lbRegistros))
	If (lbRegistros{$i})
		APPEND TO ARRAY:C911($aids;alQR_SNEnviosIDRegistros{$i})
	End if 
End for 
$selectedIndexEvento:=Find in array:C230(lbEventos;True:C214)
If (Size of array:C274($aids)>0)
	If (Size of array:C274($aids)=1)
		$errMsg:=__ ("No fue posible eliminar el informe.")
		$r:=CD_Dlog (0;__ ("¿Está seguro de querer eliminar el informe para este alumno?");"";__ ("No");__ ("Si"))
	Else 
		$errMsg:=__ ("No fue posible eliminar los informes.")
		$r:=CD_Dlog (0;__ ("¿Está seguro de querer eliminar el informe para estos alumnos?");"";__ ("No");__ ("Si"))
	End if 
	If ($r=2)
		
		  // Modificado por: Alexis Bustamante (10-06-2017)
		  //TICKET Ticket 179869
		C_OBJECT:C1216($ob_raiz)
		$p:=IT_UThermometer (1;0;__ ("Eliminando informes en SchoolNet…");-1)
		$idevento:=atQR_SNEnviosIDEvento{$selectedIndexEvento}
		$ob_raiz:=OB_Create 
		OB_SET ($ob_raiz;->$aids;"ids")
		  //$json:=JSON New 
		  //$node:=JSON Append long array ($json;"ids";$aids)
		  //$idalumnos:=JSON Export to text ($json;JSON_WITHOUT_WHITE_SPACE)
		  //JSON CLOSE ($json)  //20150421 RCH Se agrega cierre
		
		$idalumnos:=OB_Object2Json ($ob_raiz)
		
		WEB SERVICE SET PARAMETER:C777("rolbd";<>gRolBD)
		WEB SERVICE SET PARAMETER:C777("codpais";<>vtXS_CountryCode)
		WEB SERVICE SET PARAMETER:C777("idevento";$idevento)
		WEB SERVICE SET PARAMETER:C777("idalumno";$idalumnos)
		$err:=SN3_CallWebService ("sn3ws_Informes_proceso.elimina_informe")
		IT_UThermometer (-2;$p)
		If ($err="")
			WEB SERVICE GET RESULT:C779($res;"resultado";*)
			$resultado:=Num:C11($res)
			If ($resultado>-1)
				If ($resultado=0)  //no quedan informes en el evento, sacar evento de la lista de eventos y limpiar lista de registros
					LISTBOX SELECT ROW:C912(lbEventos;0;lk remove from selection:K53:3)
					AT_Delete ($selectedIndexEvento;1;->atQR_SNEnviosIDEvento;->adQR_SNEnviosFecha;->alQR_SNEnviosHora;->atQR_SNEnviosNombre;->adQR_SNEnviosDisponibleDesde)
					LISTBOX DELETE COLUMN:C830(lbRegistros;2)
					ARRAY TEXT:C222(atQR_SNEnviosRegistros;0)
					ARRAY TEXT:C222(atQR_SNEnviosCursos;0)
					ARRAY LONGINT:C221(alQR_SNEnviosIDRegistros;0)
					ARRAY TEXT:C222(atQR_SNEnviosLinkDownload;0)
					OBJECT SET ENABLED:C1123(Self:C308->;False:C215)
					OBJECT SET ENABLED:C1123(bEliminarEvento;False:C215)
					OBJECT SET ENABLED:C1123(bDownload;False:C215)
				Else 
					  //sacar solo los registros borrados
					For ($i;1;Size of array:C274($aids))
						$el:=Find in array:C230(alQR_SNEnviosIDRegistros;$aids{$i})
						If ($el>-1)
							AT_Delete ($el;1;->atQR_SNEnviosRegistros;->atQR_SNEnviosCursos;->alQR_SNEnviosIDRegistros;->atQR_SNEnviosLinkDownload)
						End if 
					End for 
					LISTBOX SELECT ROW:C912(lbRegistros;0;lk remove from selection:K53:3)
					OBJECT SET ENABLED:C1123(Self:C308->;False:C215)
					OBJECT SET ENABLED:C1123(bDownload;False:C215)
				End if 
			Else 
				CD_Dlog (0;$errMsg)
			End if 
		Else 
			CD_Dlog (0;$errMsg+"\r"+$err)
		End if 
	End if 
End if 