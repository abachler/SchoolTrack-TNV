//%attributes = {}
  //SR_FormatoRUT2

C_TEXT:C284($texto;$var;$1;$0)
C_LONGINT:C283($largo;$i;$largo1;$puntos;$p)
C_BOOLEAN:C305($vb_formatear)
$texto:=$1
Case of 
		  //: (<>vtXS_CountryCode="cl")
	: ((<>vtXS_CountryCode="cl") | (<>vtXS_CountryCode="uy"))  //20171005 RCH
		If ($texto#"")
			$texto:=Replace string:C233(Replace string:C233(Replace string:C233($texto;".";"");",";"");"-";"")  //20100727 RCH se reemplaza posible formato que pueda venir
			$largo1:=Length:C16($texto)
			$puntos:=Int:C8((($largo1-1)/3)+0.5)
			$largo:=Length:C16($texto)+$puntos+1
			$p:=4
			For ($i;$largo;$puntos+2;-1)
				If ($i=($largo-1))
					$var:="-"+$var
				End if 
				If ($i=($largo-$p))
					$var:="."+$var
					$p:=$p+3
				End if 
				$var:=Substring:C12($texto;($i-($puntos+1));1)+$var
			End for 
			$0:=$var
		End if 
	: (<>vtXS_CountryCode="ar")  // MOD Ticket N° 209157 Patricio Aliaga 20180608
		$vb_formatear:=True:C214  // en caso de existir letras en el texto, se devuelve el mismo texto.
		$puntos:=0
		For ($i;1;Length:C16($texto))
			If ((Character code:C91($texto[[$i]])<48) | (Character code:C91($texto[[$i]])>57))
				$vb_formatear:=False:C215
				$i:=Length:C16($texto)+1
			End if 
		End for 
		If ($vb_formatear)
			For ($i;Length:C16($texto);2;-1)
				$puntos:=$puntos+1
				If ($puntos=3)
					$texto:=Substring:C12($texto;1;$i-1)+"."+Substring:C12($texto;$i;Length:C16($texto)-($i-1))
					$puntos:=0
				End if 
			End for 
		End if 
		$0:=$texto
	Else 
		$0:=$texto
End case 