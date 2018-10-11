//%attributes = {}
  // ALP_SetInterface()
  // Por: Alberto Bachler: 22/03/13, 16:15:53
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($1)

C_LONGINT:C283($l_clickDelay;$l_controlEntradaFechaHora;$l_usarfilasParciales;$l_ignorarMetacaracteres;$l_indicadorOrdenamiento;$l_referenciaAreaList;$l_usarElipsis;$l_usarPopupViejo)


If (False:C215)
	C_LONGINT:C283(ALP_SetInterface ;$1)
End if 


$l_referenciaAreaList:=$1
$l_indicadorOrdenamiento:=1
$l_usarElipsis:=1
$l_ignorarMetacaracteres:=0
$l_clickDelay:=60
$l_usarfilasParciales:=1
$l_usarPopupViejo:=0
$l_controlEntradaFechaHora:=0
If (SYS_IsWindows )
	$l_usarPopupViejo:=1
End if 
AL_SetInterface ($l_referenciaAreaList;AL Force OSX Interface;$l_indicadorOrdenamiento;$l_usarElipsis;$l_ignorarMetacaracteres;$l_clickDelay;$l_usarfilasParciales;$l_usarPopupViejo;$l_controlEntradaFechaHora)
ALP_SetAlternateLigneColor ($l_referenciaAreaList)

