//%attributes = {}
  // VC4D_SaveMethod()
  //
  //
  // creado por: Alberto Bachler Klein: 28-01-16, 16:06:08
  // -----------------------------------------------------------
C_TEXT:C284($1)

C_BOOLEAN:C305($b_obsoleto)
C_DATE:C307($d_fecha)
C_LONGINT:C283($i;$l_errCodeSQL;$l_nativeErrSQL;$l_numeroTabla;$l_resultado;$l_tipoObjeto)
C_TIME:C306($h_hora)
C_POINTER:C301($y_tabla)
C_TEXT:C284($t_autouuid;$t_code;$t_comentarios;$t_dts;$t_dts2;$t_errODBC;$t_errTextSQL;$t_nombreObjeto;$t_nombreObjetoFormulario;$t_nombreTabla)
C_TEXT:C284($t_onErrMethod;$t_ruta;$t_rutaCarpeta;$t_rutaVC4D;$t_text;$t_usuario)
C_OBJECT:C1216($ob_atributos)

ARRAY LONGINT:C221($al_errCodes;0)
ARRAY TEXT:C222($at_errorText;0)
ARRAY TEXT:C222($at_internalComponent;0)
ARRAY TEXT:C222($at_lineas;0)


If (False:C215)
	C_TEXT:C284(VC4D_SaveMethod ;$1)
End if 

C_TEXT:C284(<>tUSR_CurrentUser)

$t_ruta:=$1
If (<>tUSR_CurrentUser#"")
	$t_usuario:=<>tUSR_CurrentUser
Else 
	$t_usuario:=Current system user:C484+" (machine owner)"
End if 

GET MACRO PARAMETER:C997(Full method text:K5:17;$t_code)
$t_errorData:=VC4D_SaveMethod_onServer ($t_ruta;$t_code;$t_usuario)

If ($t_errorData#"")
	ALERT:C41($t_errorData)
End if 


