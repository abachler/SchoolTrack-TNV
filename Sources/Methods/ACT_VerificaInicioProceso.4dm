//%attributes = {}
  //ACT_VerificaInicioProceso 

C_BOOLEAN:C305($b_continuar;$0)
C_TEXT:C284($1;$t_texto;$t_msj)
C_LONGINT:C283($l_resp)

$t_texto:=$1
If ((Not:C34(<>bXS_esServidorOficial)) | (USR_GetUserID <0))
	$t_msj:=__ ("Al parecer usted no está trabajando en un servidor oficial y/o está trabajando con super usuario.")+"\r\r"
	$t_msj:=$t_msj+$t_texto+"\r\r"
	$t_msj:=$t_msj+__ ("¿Desea continuar?")
	$l_resp:=CD_Dlog (0;$t_msj;"";__ ("Si");__ ("No"))
	If ($l_resp=1)
		$b_continuar:=True:C214
	End if 
Else 
	$b_continuar:=True:C214
End if 

$0:=$b_continuar