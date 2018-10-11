//%attributes = {}
  // Método: BKP_SubeRespaldo
  //
  // 
  // creado por Alberto Bachler Klein
  // el 10/08/18, 17:01:43
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––


  // Método: BKP_SubeRespaldo
  // código original de: ?
  // modificado por Alberto Bachler Klein el 10/02/18, 15:30:32
  // - normalización, simplificación y limpieza, declaración de variables
  // - reemplazo de comandos objeto del componente xShell por uso de notación objeto o comandos nativos 4D
  // - reemplazo del método de validación Valida_Json por OB_ParseJson
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
C_TEXT:C284($0)
C_TEXT:C284($1)

C_LONGINT:C283($l_nuevoProceso)
C_TEXT:C284($t_json;$t_nombreProc;$t_rutaRespaldo)


If (False:C215)
	C_TEXT:C284(BKP_SubeRespaldo ;$0)
	C_TEXT:C284(BKP_SubeRespaldo ;$1)
End if 

C_BOOLEAN:C305(<>bXS_esServidorOficial)

If (Count parameters:C259=1)
	$t_rutaRespaldo:=$1
End if 

Case of 
	: (Not:C34(<>bXS_esServidorOficial))
		$t_json:=BKPwa_GeneraRespuesta (-8)
		
	: (Test path name:C476($t_rutaRespaldo)=Is a document:K24:1)
		
	Else 
		$t_rutaRespaldo:=BKP_UltimoRespaldoDisponible 
End case 

If (Test path name:C476($t_rutaRespaldo)=Is a document:K24:1)
	$t_nombreProc:="Envio backup al FTP"
	$l_nuevoProceso:=Process number:C372($t_nombreProc)
	If ($l_nuevoProceso#0)
		$t_json:=BKPwa_GeneraRespuesta (0;"Envío en proceso. Proceso id: "+String:C10($l_nuevoProceso))
	Else 
		CIM_FTP_ConnectionData 
		$l_nuevoProceso:=New process:C317("FTP_Upload";0;$t_nombreProc;0;"/";$t_rutaRespaldo;vtFTP_Url;vtWS_ftpLoginName;vtWS_ftppassword;"Client";<>RegisteredName;False:C215;True:C214)
		$t_json:=BKPwa_GeneraRespuesta (0;"Envío lanzado. Proceso id: "+String:C10($l_nuevoProceso)+".")
	End if 
End if 


$0:=$t_json




