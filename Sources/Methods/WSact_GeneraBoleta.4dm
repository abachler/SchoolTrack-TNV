//%attributes = {}
  //WSact_GeneraBoleta

C_TEXT:C284($1)
C_TEXT:C284($2)
C_TEXT:C284($3)
C_LONGINT:C283($0)
C_LONGINT:C283(vlWS_estado;vlWS_tipoDTE;vlWS_folioDTE)
C_TEXT:C284(vtWS_glosa)
C_LONGINT:C283($l_intentos;$l_intentosMaximo)

vlWS_estado:=0
vtWS_glosa:=""
vlWS_tipoDTE:=0
vlWS_folioDTE:=0

  //20151001 Se re intentará cuando no se logre emitir el documento.
$l_intentos:=1
$l_intentosMaximo:=8
While ($l_intentos<=$l_intentosMaximo)
	
	WEB SERVICE SET PARAMETER:C777("rutEmisor";$1)
	WEB SERVICE SET PARAMETER:C777("codigoSucursal";$2)
	WEB SERVICE SET PARAMETER:C777("txt";$3)
	
	WSact_DTECallWebService ("doGeneracionBoleta")
	
	If (OK=1)
		WEB SERVICE GET RESULT:C779(vlWS_estado;"estado")
		If (vlWS_estado=1)
			WEB SERVICE GET RESULT:C779(vtWS_glosa;"glosa")
			WEB SERVICE GET RESULT:C779(vlWS_tipoDTE;"tipoDTE")
			WEB SERVICE GET RESULT:C779(vlWS_folioDTE;"folioDTE";*)
		Else 
			WEB SERVICE GET RESULT:C779(vtWS_glosa;"glosa";*)
		End if 
		If (vlWS_estado=0)
			If (($l_intentos=$l_intentosMaximo) | (vtWS_glosa#""))
				CD_Dlog (0;vtWS_glosa)
				$l_intentos:=$l_intentosMaximo+1
			Else 
				DELAY PROCESS:C323(Current process:C322;15)
			End if 
			$l_intentos:=$l_intentos+1
		Else 
			$l_intentos:=$l_intentosMaximo+1
		End if 
		
	Else 
		
		If ($l_intentos<$l_intentosMaximo)
			DELAY PROCESS:C323(Current process:C322;15)
		End if 
		$l_intentos:=$l_intentos+1
		
	End if 
End while 


$0:=vlWS_estado