//%attributes = {}
  // CDOC_MostrarHistorial()
  // Por: Alberto Bachler: 15/04/13, 17:43:28
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($1)
C_BLOB:C604($2)


If (False:C215)
	C_TEXT:C284(CDOC_MostrarHistorial ;$1)
	C_BLOB:C604(CDOC_MostrarHistorial ;$2)
End if 

C_LONGINT:C283($l_estadoProceso;$l_IdProcesoSoporte;$l_NumeroProceso;$l_refVentana)
C_TEXT:C284($t_textoError;$t_tituloVentana)

C_BLOB:C604(vx_blobHistorial)
C_TEXT:C284(vt_nombreMetodo)




GET MACRO PARAMETER:C997(Highlighted method text:K5:18;vt_nombreMetodo)

If (vt_nombreMetodo="")
	$t_tituloVentana:=Get window title:C450(Frontmost window:C447)
	vt_nombreMetodo:=ST_GetCleanString (ST_GetWord ($t_tituloVentana;2;": "))
End if 

WEB SERVICE SET PARAMETER:C777("nombreMetodo";vt_nombreMetodo)
$t_textoError:=WS_CallIntranetWebService ("WScdoc_EnviaHistorial")
SET BLOB SIZE:C606(vx_blobHistorial;0)
If ($t_textoError="")
	WEB SERVICE GET RESULT:C779(vx_blobHistorial;"blobModificaciones";*)
	If (BLOB size:C605(vx_blobHistorial)>0)
		
		$l_NumeroProceso:=Process number:C372("$"+Current method name:C684)
		$l_estadoProceso:=Process state:C330($l_NumeroProceso)
		
		Case of 
			: ($l_estadoProceso<0)
				$l_IdProcesoSoporte:=New process:C317(Current method name:C684;128000;"$"+Current method name:C684;vt_nombreMetodo;vx_blobHistorial)
				
			: ($l_estadoProceso#0)
				RESUME PROCESS:C320($l_NumeroProceso)
				SET PROCESS VARIABLE:C370($l_NumeroProceso;vt_nombreMetodo;vt_nombreMetodo;vx_blobHistorial;vx_blobHistorial)
				BRING TO FRONT:C326($l_NumeroProceso)
				POST OUTSIDE CALL:C329($l_NumeroProceso)
				SET WINDOW TITLE:C213(vt_nombreMetodo+": Historial de modificaciones")
				
			Else 
				vt_nombreMetodo:=$1
				vx_blobHistorial:=$2
				$l_refVentana:=Open form window:C675("CDOC_HistorialMetodo";Plain form window:K39:10+_o_Compositing mode form window:K39:13;On the right:K39:3;At the top:K39:5)
				SET WINDOW TITLE:C213(vt_nombreMetodo+": Historial de modificaciones")
				DIALOG:C40("CDOC_HistorialMetodo")
				CLOSE WINDOW:C154
				
		End case 
	Else 
		ALERT:C41("No existe información sobre el método "+vt_nombreMetodo+" en el repositorio.")
	End if 
Else 
	ALERT:C41("Error de interacción con web service:\r"+$t_textoError)
End if 

