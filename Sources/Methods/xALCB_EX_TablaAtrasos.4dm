//%attributes = {}
  //xALCB_EX_TablaAtrasos

C_LONGINT:C283($1;$2;$3)
C_BOOLEAN:C305($0)
C_LONGINT:C283($Column;$line;$configuracion)

If ($2=8)
	$0:=False:C215
Else 
	$0:=True:C214
	AL_GetCurrCell (xALP_TablaFaltasMin;$Column;$line)
	If (AL_GetCellMod (xALP_TablaFaltasMin)=1)
		$configuracion:=Num:C11(PREF_fGet (0;"ConfiguracionTablaPrimaria";"1"))
		
		If ($configuracion=1)
			Case of 
				: ($line=1)
					Case of 
						: ($Column=2)
							If (ATSTRAL_FALTAMINUTOSHASTA{$line}#0)
								If (ATSTRAL_FALTAMINUTOSDESDE{$line}>ATSTRAL_FALTAMINUTOSHASTA{$line})
									CD_Dlog (0;__ ("El límite inferior del rango no puede ser mayor al límite superior"))
									ATSTRAL_FALTAMINUTOSDESDE{$line}:=ATSTRAL_FALTAMINUTOSHASTA{$line}
								End if 
							Else 
								ATSTRAL_FALTAMINUTOSHASTA{$line}:=ATSTRAL_FALTAMINUTOSDESDE{$line}
							End if 
						: ($Column=3)
							If (ATSTRAL_FALTAMINUTOSDESDE{$line}#0)
								If (ATSTRAL_FALTAMINUTOSHASTA{$line}<ATSTRAL_FALTAMINUTOSDESDE{$line})
									CD_Dlog (0;__ ("El límite superior del rango no puede ser menor al límite inferior"))
									ATSTRAL_FALTAMINUTOSHASTA{$line}:=ATSTRAL_FALTAMINUTOSDESDE{$line}
								End if 
							End if 
						: ($Column=4)
							If (((ATSTRAL_FALTACONV{$line})<(ATSTRAL_FALTAMINUTOSDESDE{$line})) | ((ATSTRAL_FALTACONV{$line})>(ATSTRAL_FALTAMINUTOSHASTA{$line})))
								CD_Dlog (0;__ ("El valor ingresado está fuera del rango"))
							End if 
					End case 
				: (($line=2) | ($line=3) | ($line=4))
					Case of 
						: ($Column=2)
							If (ATSTRAL_FALTAMINUTOSHASTA{$line}#0)
								If (ATSTRAL_FALTAMINUTOSDESDE{$line}>ATSTRAL_FALTAMINUTOSHASTA{$line})
									CD_Dlog (0;__ ("El límite inferior del rango no puede ser mayor al límite superior"))
									ATSTRAL_FALTAMINUTOSDESDE{$line}:=ATSTRAL_FALTAMINUTOSHASTA{$line}
								End if 
							End if 
							If (ATSTRAL_FALTAMINUTOSHASTA{$line-1}>=(ATSTRAL_FALTAMINUTOSDESDE{$line}))
								CD_Dlog (0;__ ("El número ingresado no puede ser inferior o igual al límite del rango anterior"))
								ATSTRAL_FALTAMINUTOSDESDE{$line}:=ATSTRAL_FALTAMINUTOSHASTA{$line-1}+1
							End if 
						: ($Column=3)
							If (ATSTRAL_FALTAMINUTOSDESDE{$line}#0)
								If ($line#4)
									If (ATSTRAL_FALTAMINUTOSHASTA{$line}<ATSTRAL_FALTAMINUTOSDESDE{$line})
										CD_Dlog (0;__ ("El límite superior del rango no puede ser menor al límite inferior"))
										ATSTRAL_FALTAMINUTOSHASTA{$line}:=ATSTRAL_FALTAMINUTOSDESDE{$line}
									End if 
								End if 
							End if 
						: ($Column=4)
							If (((ATSTRAL_FALTACONV{$line})<(ATSTRAL_FALTAMINUTOSDESDE{$line})) | ((ATSTRAL_FALTACONV{$line})>(ATSTRAL_FALTAMINUTOSHASTA{$line})))
								CD_Dlog (0;__ ("El valor ingresado está fuera del rango"))
							End if 
					End case 
			End case 
			$contador:=$line
			For ($i;$contador;4)
				If ($contador=1)
					If (ATSTRAL_FALTAMINUTOSDESDE{$contador}>ATSTRAL_FALTAMINUTOSHASTA{$contador})
						ATSTRAL_FALTAMINUTOSDESDE{$contador}:=ATSTRAL_FALTAMINUTOSHASTA{$contador}
					End if 
					If (ATSTRAL_FALTAMINUTOSDESDE{$contador}>ATSTRAL_FALTAMINUTOSHASTA{$contador})
						ATSTRAL_FALTAMINUTOSHASTA{$contador}:=ATSTRAL_FALTAMINUTOSDESDE{$contador}+1
					End if 
				Else 
					If (ATSTRAL_FALTAMINUTOSDESDE{$contador}#(ATSTRAL_FALTAMINUTOSHASTA{$contador-1}+1))
						$diferencia:=ATSTRAL_FALTAMINUTOSHASTA{$contador}-ATSTRAL_FALTAMINUTOSDESDE{$contador}
						ATSTRAL_FALTAMINUTOSDESDE{$contador}:=ATSTRAL_FALTAMINUTOSHASTA{$contador-1}+1
						ATSTRAL_FALTAMINUTOSHASTA{$contador}:=ATSTRAL_FALTAMINUTOSDESDE{$contador}+$diferencia
					End if 
					If (ATSTRAL_FALTAMINUTOSDESDE{$contador}>ATSTRAL_FALTAMINUTOSHASTA{$contador})
						ATSTRAL_FALTAMINUTOSHASTA{$contador}:=ATSTRAL_FALTAMINUTOSDESDE{$contador}+1
					End if 
				End if 
				$contador:=$contador+1
			End for 
			Case of 
				: (DConv1=1)
					ARRAY LONGINT:C221(ATSTRAL_FALTACONV;4)
					For ($i;1;4)
						ATSTRAL_FALTACONV{$i}:=ATSTRAL_FALTAMINUTOSHASTA{$i}
					End for 
				: (DConv2=1)
					ARRAY LONGINT:C221(ATSTRAL_FALTACONV;4)
					For ($i;1;4)
						$valor:=ATSTRAL_FALTAMINUTOSDESDE{$i}+(Round:C94((ATSTRAL_FALTAMINUTOSHASTA{$i}-ATSTRAL_FALTAMINUTOSDESDE{$i})/2;0))
						ATSTRAL_FALTACONV{$i}:=$valor
					End for 
				: (DConv3=1)
					ARRAY LONGINT:C221(ATSTRAL_FALTACONV;4)
					For ($i;1;4)
						ATSTRAL_FALTACONV{$i}:=ATSTRAL_FALTAMINUTOSDESDE{$i}
					End for 
			End case 
		Else 
			Case of 
				: ($line=1)
					Case of 
						: ($Column=2)
							If (ATSTRAL_FALTAMINUTOSHASTA{$line}#0)
								If (ATSTRAL_FALTAMINUTOSDESDE{$line}>ATSTRAL_FALTAMINUTOSHASTA{$line})
									CD_Dlog (0;__ ("El límite inferior del rango no puede ser mayor al límite superior"))
									ATSTRAL_FALTAMINUTOSDESDE{$line}:=ATSTRAL_FALTAMINUTOSHASTA{$line}
								End if 
							Else 
								ATSTRAL_FALTAMINUTOSHASTA{$line}:=ATSTRAL_FALTAMINUTOSDESDE{$line}
							End if 
						: ($Column=3)
							If (ATSTRAL_FALTAMINUTOSDESDE{$line}#0)
								If (ATSTRAL_FALTAMINUTOSHASTA{$line}<ATSTRAL_FALTAMINUTOSDESDE{$line})
									CD_Dlog (0;__ ("El límite superior del rango no puede ser menor al límite inferior"))
									ATSTRAL_FALTAMINUTOSHASTA{$line}:=ATSTRAL_FALTAMINUTOSDESDE{$line}
								End if 
							End if 
						: ($Column=4)
							If (((ATSTRAL_FALTACONV{$line})<(ATSTRAL_FALTAMINUTOSDESDE{$line})) | ((ATSTRAL_FALTACONV{$line})>(ATSTRAL_FALTAMINUTOSHASTA{$line})))
								CD_Dlog (0;__ ("El valor ingresado está fuera del rango"))
							End if 
							
					End case 
				: (($line=2) | ($line=3) | ($line=4) | ($line=5) | ($line=6))
					Case of 
						: ($Column=2)
							If (ATSTRAL_FALTAMINUTOSHASTA{$line}#0)
								If (ATSTRAL_FALTAMINUTOSDESDE{$line}>ATSTRAL_FALTAMINUTOSHASTA{$line})
									CD_Dlog (0;__ ("El límite inferior del rango no puede ser mayor al límite superior"))
									ATSTRAL_FALTAMINUTOSDESDE{$line}:=ATSTRAL_FALTAMINUTOSHASTA{$line}
								End if 
							End if 
							If (ATSTRAL_FALTAMINUTOSHASTA{$line-1}>=(ATSTRAL_FALTAMINUTOSDESDE{$line}))
								CD_Dlog (0;__ ("El número ingresado no puede ser inferior o igual al límite del rango anterior"))
								ATSTRAL_FALTAMINUTOSDESDE{$line}:=ATSTRAL_FALTAMINUTOSHASTA{$line-1}+1
							End if 
						: ($Column=3)
							If (ATSTRAL_FALTAMINUTOSDESDE{$line}#0)
								If ($line#6)
									If (ATSTRAL_FALTAMINUTOSHASTA{$line}<ATSTRAL_FALTAMINUTOSDESDE{$line})
										CD_Dlog (0;__ ("El límite superior del rango no puede ser menor al límite inferior"))
										ATSTRAL_FALTAMINUTOSHASTA{$line}:=ATSTRAL_FALTAMINUTOSDESDE{$line}
									End if 
								End if 
							End if 
						: ($Column=4)
							If (((ATSTRAL_FALTACONV{$line})<(ATSTRAL_FALTAMINUTOSDESDE{$line})) | ((ATSTRAL_FALTACONV{$line})>(ATSTRAL_FALTAMINUTOSHASTA{$line})))
								CD_Dlog (0;__ ("El valor ingresado está fuera del rango"))
							End if 
					End case 
			End case 
			$contador:=$line
			For ($i;$contador;6)
				If ($contador=1)
					If (ATSTRAL_FALTAMINUTOSDESDE{$contador}>ATSTRAL_FALTAMINUTOSHASTA{$contador})
						ATSTRAL_FALTAMINUTOSDESDE{$contador}:=ATSTRAL_FALTAMINUTOSHASTA{$contador}
					End if 
					If (ATSTRAL_FALTAMINUTOSDESDE{$contador}>ATSTRAL_FALTAMINUTOSHASTA{$contador})
						ATSTRAL_FALTAMINUTOSHASTA{$contador}:=ATSTRAL_FALTAMINUTOSDESDE{$contador}+1
					End if 
				Else 
					If (ATSTRAL_FALTAMINUTOSDESDE{$contador}#(ATSTRAL_FALTAMINUTOSHASTA{$contador-1}+1))
						$diferencia:=ATSTRAL_FALTAMINUTOSHASTA{$contador}-ATSTRAL_FALTAMINUTOSDESDE{$contador}
						ATSTRAL_FALTAMINUTOSDESDE{$contador}:=ATSTRAL_FALTAMINUTOSHASTA{$contador-1}+1
						ATSTRAL_FALTAMINUTOSHASTA{$contador}:=ATSTRAL_FALTAMINUTOSDESDE{$contador}+$diferencia
					End if 
					If (ATSTRAL_FALTAMINUTOSDESDE{$contador}>ATSTRAL_FALTAMINUTOSHASTA{$contador})
						ATSTRAL_FALTAMINUTOSHASTA{$contador}:=ATSTRAL_FALTAMINUTOSDESDE{$contador}+1
					End if 
				End if 
				$contador:=$contador+1
			End for 
			Case of 
				: (DConv1=1)
					ARRAY LONGINT:C221(ATSTRAL_FALTACONV;6)
					For ($i;1;6)
						ATSTRAL_FALTACONV{$i}:=ATSTRAL_FALTAMINUTOSHASTA{$i}
					End for 
				: (DConv2=1)
					ARRAY LONGINT:C221(ATSTRAL_FALTACONV;6)
					For ($i;1;6)
						$valor:=ATSTRAL_FALTAMINUTOSDESDE{$i}+(Round:C94((ATSTRAL_FALTAMINUTOSHASTA{$i}-ATSTRAL_FALTAMINUTOSDESDE{$i})/2;0))
						ATSTRAL_FALTACONV{$i}:=$valor
					End for 
				: (DConv3=1)
					ARRAY LONGINT:C221(ATSTRAL_FALTACONV;6)
					For ($i;1;6)
						ATSTRAL_FALTACONV{$i}:=ATSTRAL_FALTAMINUTOSDESDE{$i}
					End for 
			End case 
		End if 
		
		
	End if 
End if 