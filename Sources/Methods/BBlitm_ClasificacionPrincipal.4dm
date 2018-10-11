//%attributes = {}
  // BBlitm_ClasificacionPrincipal()
  // Por: Alberto Bachler: 17/09/13, 13:22:09
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_extraerClasificacionPrincipal)
_O_C_INTEGER:C282($i)
C_TEXT:C284($t_principal)

If ([BBL_Items:61]Clasificacion:2="")
	[BBL_Items:61]Clasificacion_principal:45:=""
Else 
	If ([BBL_Items:61]Clasificacion:2#Old:C35([BBL_Items:61]Clasificacion:2))
		If ((Character code:C91([BBL_Items:61]Clasificacion:2[[1]])>=48) & (Character code:C91([BBL_Items:61]Clasificacion:2[[1]])<=57))
			$t_principal:=[BBL_Items:61]Clasificacion:2
			For ($i;1;Length:C16([BBL_Items:61]Clasificacion:2))
				If (([BBL_Items:61]Clasificacion:2[[$i]]=".") | ([BBL_Items:61]Clasificacion:2[[$i]]=" ") | ([BBL_Items:61]Clasificacion:2[[$i]]="/"))
					$t_principal:=Substring:C12([BBL_Items:61]Clasificacion:2;1;$i-1)
					$i:=Length:C16([BBL_Items:61]Clasificacion:2)+1
				End if 
			End for 
			[BBL_Items:61]Clasificacion_principal:45:=$t_principal
		Else 
			If ((Position:C15(".";[BBL_Items:61]Clasificacion:2)=0) & (Position:C15(" ";[BBL_Items:61]Clasificacion:2)=0) & (Position:C15("/";[BBL_Items:61]Clasificacion:2)=0))
				[BBL_Items:61]Clasificacion_principal:45:=[BBL_Items:61]Clasificacion:2
			Else 
				$b_extraerClasificacionPrincipal:=False:C215
				$t_principal:=[BBL_Items:61]Clasificacion:2
				For ($i;1;Length:C16([BBL_Items:61]Clasificacion:2)-2)
					If ((Character code:C91([BBL_Items:61]Clasificacion:2[[$i]])>=48) & (Character code:C91([BBL_Items:61]Clasificacion:2[[$i]])<=57) & ($b_extraerClasificacionPrincipal=False:C215))
						$b_extraerClasificacionPrincipal:=True:C214
					Else 
						If (($b_extraerClasificacionPrincipal) & (([BBL_Items:61]Clasificacion:2[[$i]]=".") | ([BBL_Items:61]Clasificacion:2[[$i]]=" ") | ([BBL_Items:61]Clasificacion:2[[$i]]="/")))
							$t_principal:=Substring:C12([BBL_Items:61]Clasificacion:2;1;$i-1)
							$i:=Length:C16([BBL_Items:61]Clasificacion:2)+1
						End if 
					End if 
				End for 
				If ($b_extraerClasificacionPrincipal)
					[BBL_Items:61]Clasificacion_principal:45:=$t_principal
				Else 
					$t_principal:=[BBL_Items:61]Clasificacion:2
					For ($i;1;Length:C16([BBL_Items:61]Clasificacion:2)-2)
						If (([BBL_Items:61]Clasificacion:2[[$i]]=".") | ([BBL_Items:61]Clasificacion:2[[$i]]=" ") | ([BBL_Items:61]Clasificacion:2[[$i]]="/"))
							$t_principal:=Substring:C12([BBL_Items:61]Clasificacion:2;1;$i-1)
							$i:=Length:C16([BBL_Items:61]Clasificacion:2)+1
						End if 
					End for 
					[BBL_Items:61]Clasificacion_principal:45:=$t_principal
				End if 
			End if 
		End if 
		
		If ([BBL_Items:61]Clasificacion_principal:45#"")
			QUERY:C277([BBL_Index:70];[BBL_Index:70]Code:1=[BBL_Items:61]Clasificacion_principal:45)
			If (Records in selection:C76([BBL_Index:70])=0)
				CREATE RECORD:C68([BBL_Index:70])
				[BBL_Index:70]Code:1:=[BBL_Items:61]Clasificacion_principal:45
				SAVE RECORD:C53([BBL_Index:70])
			End if 
		End if 
	End if 
End if 