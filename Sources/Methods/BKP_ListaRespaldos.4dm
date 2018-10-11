//%attributes = {}
  //BKP_ListaRespaldos
C_TEXT:C284($0;$t_rutaCarpetaRespaldos;$json)
C_TEXT:C284($t_principal;$node)

ARRAY TEXT:C222($at_nombreArchivos;0)
ARRAY TEXT:C222($at_fechamodificado;0)

C_LONGINT:C283($i)
C_BOOLEAN:C305($b_bloqueado;$b_invisible)
C_DATE:C307($d_creado;$d_modificado)
C_TIME:C306($h_creado;$h_modificado)

MESSAGES OFF:C175

BKP_EscribeLog (Current method name:C684)

BKP_LeeItemPlanBackup ("BKP_rutaCarpetaRespaldos";->$t_rutaCarpetaRespaldos)
If (Test path name:C476($t_rutaCarpetaRespaldos)#Is a folder:K24:2)
	$json:=BKPwa_GeneraRespuesta (-3)  //no se encuentra ruta a carpeta respaldos.
Else 
	DOCUMENT LIST:C474($t_rutaCarpetaRespaldos;$at_nombreArchivos)
	For ($i;Size of array:C274($at_nombreArchivos);1;-1)
		If (Position:C15(".4BK";$at_nombreArchivos{$i})=0)
			AT_Delete ($i;1;->$at_nombreArchivos)
		End if 
	End for 
	
	For ($i;1;Size of array:C274($at_nombreArchivos))
		GET DOCUMENT PROPERTIES:C477($t_rutaCarpetaRespaldos+$at_nombreArchivos{$i};$b_bloqueado;$b_invisible;$d_creado;$h_creado;$d_modificado;$h_modificado)
		APPEND TO ARRAY:C911($at_fechamodificado;DTS_MakeFromDateTime ($d_modificado;$h_modificado))
	End for 
	SORT ARRAY:C229($at_fechamodificado;$at_nombreArchivos;>)
	
	
	  // Modificado por: Alexis Bustamante (10-06-2017)
	  //Ticket 179869
	
	C_OBJECT:C1216($ob_raiz)
	
	C_LONGINT:C283($vl_error)
	C_TEXT:C284($vt_mensaje)
	
	$ob_raiz:=OB_Create 
	$vl_error:=0
	$vt_mensaje:="ok"
	
	OB_SET ($ob_raiz;->$vl_error;"error")
	OB_SET ($ob_raiz;->$vt_mensaje;"mensaje")
	OB_SET ($ob_raiz;->$at_nombreArchivos;"documentos")
	OB_SET ($ob_raiz;->$at_fechamodificado;"dts")
	$json:=OB_Object2Json ($ob_raiz)
	
End if 
BKP_EscribeLog ($json)
$0:=$json