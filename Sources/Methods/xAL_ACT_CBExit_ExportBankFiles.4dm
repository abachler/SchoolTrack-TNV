//%attributes = {}
  //xAL_ACT_CBExit_ExportBankFiles

C_LONGINT:C283($1;$2;$3)
C_LONGINT:C283($col;$line)
C_BOOLEAN:C305($0)
alProEvt:=AL_GetLine ($1)
AL_GetCurrCell ($1;$col;$line)
If ($2=8)  //soft deselect
	$0:=False:C215
Else 
	$0:=True:C214
	$change:=AL_GetCellMod ($1)
	If ($change=1)
		If (bto_Exportacion=1)
			Case of 
				: (xALP_ExportBankFiles=$1)
					Case of 
						: ($col=2)
							If (at_Descripcion{$line}#"Texto Fijo")
								at_TextoFijo{$line}:=""
							End if 
						: (($col=4) | ($col=8))  //Largo
							If (al_PosIni{1}#1)  //Para asegurar que ella fila 1 siempre parta en 1
								al_PosIni{1}:=1
								al_PosFinal{1}:=al_PosIni{1}+(al_Largo{1}-1)  //test
							Else 
								If (($line>1) & (al_PosIni{$line}<al_PosFinal{$line-1}))  //esto era para cuando se podía 
									al_PosIni{$line}:=al_PosFinal{$line-1}+1
								End if 
								If ((al_PosIni{$line})#(al_PosFinal{$line-1}+1))  //esto era para cuando se podía ingresar en $col 3
									al_PosIni{$line}:=al_PosFinal{$line-1}+1
								End if 
							End if 
							If ($col=4)
								If (at_Relleno{$line}="Ajustado a contenido")
									al_Largo{$line}:=1
								End if 
								If ((at_Descripcion{$line}="Texto Fijo") & (at_TextoFijo{$line}#""))  //Para campo Texto fijo"
									If ((al_Largo{$line}<Length:C16(at_TextoFijo{$line})) & (at_Relleno{$line}#"Ajustado a contenido"))
										at_TextoFijo{$line}:=""
									End if 
								End if 
							Else 
								If ($col=8)
									If ((at_Descripcion{$line}="Texto Fijo") & (al_Largo{$line}<Length:C16(at_TextoFijo{$line})) & (at_Relleno{$line}#"Ajustado a contenido"))
										at_TextoFijo{$line}:=""
										CD_Dlog (0;__ ("El largo del texto ingresado excede el largo del registro configurado"))
									End if 
									If (at_Relleno{$line}="Ajustado a contenido")
										al_Largo{$line}:=1
									End if 
								End if 
							End if 
							
							If ((al_PosIni{$line}>=al_PosFinal{$line}) & ($line>1))  //
								al_PosFinal{$line}:=(al_PosIni{$line}+al_Largo{$line})-1
							Else 
								If ((al_Numero{$line}>0) & (al_PosIni{$line}>0) & (al_Largo{$line}>0))  //esto era para cuando se podía ingresar en $col 3 y para actualizar
									al_PosFinal{$line}:=(al_PosIni{$line}+al_Largo{$line})-1
								End if 
							End if 
							If (al_Largo{$line}=0)  //Para que no asignen largo 0
								al_Largo{$line}:=al_PosFinal{$line}-al_PosIni{$line}
							End if 
							C_BOOLEAN:C305($entrar)
							If ($line=1)
								$entrar:=False:C215
								$line:=0
							Else 
								$entrar:=True:C214
							End if 
							If (Size of array:C274(al_Numero)>1)  //para recorrer los arreglos y modificar la posición inicial y final. El largo se mantiene
								For ($i;1;Size of array:C274(al_Numero)-$line)
									If ($entrar)
										al_PosIni{$line+1}:=al_PosFinal{$line}+1
										al_PosFinal{$line+1}:=(al_PosIni{$line+1}+al_Largo{$line+1})-1
										$line:=$line+1
									End if 
									If (Not:C34($entrar))
										$entrar:=True:C214
										$line:=$line+1
									End if 
								End for 
							End if 
						: ($col=6)
						: ($col=9)
							If (at_Descripcion{$line}#"Texto Fijo")
								at_TextoFijo{$line}:=""
								CD_Dlog (0;__ ("Sólo puede ingresar texto después de seleccionar Texto Fijo"))
							End if 
							If ((at_Descripcion{$line}="Texto Fijo") & (at_TextoFijo{$line}#""))
								If ((al_Largo{$line}<Length:C16(at_TextoFijo{$line})) & (at_Relleno{$line}#"Ajustado a contenido"))
									at_TextoFijo{$line}:=""
									CD_Dlog (0;__ ("El largo del texto ingresado excede el largo del registro configurado"))
								End if 
							End if 
					End case 
					AL_UpdateArrays (xALP_ExportBankFiles;-2)
					  //End if 
				: (xALP_ExportBankFilesH=$1)
					Case of 
						: ($col=2)
							If (at_DescripcionHe{$line}#"Texto Fijo")
								at_TextoFijoHe{$line}:=""
							End if 
							If (at_DescripcionHe{$line}#at_DescripcionHe{0})
								at_FormatoHe{$line}:=""
							End if 
						: (($col=4) | ($col=8))  //Largo
							If (al_PosIniHe{1}#1)  //Para asegurar que ella fila 1 siempre parta en 1
								al_PosIniHe{1}:=1
								al_PosFinalHe{1}:=al_PosIniHe{1}+(al_LargoHe{1}-1)  //test
							Else 
								If (($line>1) & (al_PosIniHe{$line}<al_PosFinalHe{$line-1}))  //esto era para cuando se podía 
									al_PosIniHe{$line}:=al_PosFinalHe{$line-1}+1
								End if 
								If ((al_PosIniHe{$line})#(al_PosFinalHe{$line-1}+1))  //esto era para cuando se podía ingresar en $col 3
									al_PosIniHe{$line}:=al_PosFinalHe{$line-1}+1
								End if 
							End if 
							If ($col=4)
								If (at_RellenoHe{$line}="Ajustado a contenido")
									al_LargoHe{$line}:=1
								End if 
								If ((at_DescripcionHe{$line}="Texto Fijo") & (at_TextoFijoHe{$line}#""))  //Para campo Texto fijo"
									If ((al_LargoHe{$line}<Length:C16(at_TextoFijoHe{$line})) & (at_RellenoHe{$line}#"Ajustado a contenido"))
										at_TextoFijoHe{$line}:=""
									End if 
								End if 
							Else 
								If ($col=8)
									If ((at_DescripcionHe{$line}="Texto Fijo") & (al_LargoHe{$line}<Length:C16(at_TextoFijoHe{$line})) & (at_RellenoHe{$line}#"Ajustado a contenido"))
										at_TextoFijoHe{$line}:=""
										CD_Dlog (0;__ ("El largo del texto ingresado excede el largo del registro configurado"))
									End if 
									If (at_RellenoHe{$line}="Ajustado a contenido")
										al_LargoHe{$line}:=1
									End if 
								End if 
							End if 
						: ($col=9)
							If (at_DescripcionHe{$line}#"Texto Fijo")
								at_TextoFijoHe{$line}:=""
								CD_Dlog (0;__ ("Sólo puede ingresar texto después de seleccionar Texto Fijo"))
							End if 
							If ((at_DescripcionHe{$line}="Texto Fijo") & (at_TextoFijoHe{$line}#""))
								If ((al_LargoHe{$line}<Length:C16(at_TextoFijoHe{$line})) & (at_RellenoHe{$line}#"Ajustado a contenido"))
									at_TextoFijoHe{$line}:=""
									CD_Dlog (0;__ ("El largo del texto ingresado excede el largo del registro configurado"))
								End if 
							End if 
					End case 
					If ((al_PosIniHe{$line}>=al_PosFinalHe{$line}) & ($line>1))  //
						al_PosFinalHe{$line}:=(al_PosIniHe{$line}+al_LargoHe{$line})-1
					Else 
						If ((al_NumeroHe{$line}>0) & (al_PosIniHe{$line}>0) & (al_LargoHe{$line}>0))  //esto era para cuando se podía ingresar en $col 3 y para actualizar
							al_PosFinalHe{$line}:=(al_PosIniHe{$line}+al_LargoHe{$line})-1
						End if 
					End if 
					If (al_LargoHe{$line}=0)  //Para que no asignen largo 0
						al_LargoHe{$line}:=al_PosFinalHe{$line}-al_PosIniHe{$line}
					End if 
					C_BOOLEAN:C305($entrar)
					If ($line=1)
						$entrar:=False:C215
						$line:=0
					Else 
						$entrar:=True:C214
					End if 
					If (Size of array:C274(al_NumeroHe)>1)  //para recorrer los arreglos y modificar la posición inicial y final. El largo se mantiene
						For ($i;1;Size of array:C274(al_NumeroHe)-$line)
							If ($entrar)
								al_PosIniHe{$line+1}:=al_PosFinalHe{$line}+1
								al_PosFinalHe{$line+1}:=(al_PosIniHe{$line+1}+al_LargoHe{$line+1})-1
								$line:=$line+1
							End if 
							If (Not:C34($entrar))
								$entrar:=True:C214
								$line:=$line+1
							End if 
						End for 
					End if 
					
					$line:=AL_GetLine (xALP_ExportBankFilesH)
					If (($line=0) | ($line=1))
						_O_DISABLE BUTTON:C193(bSubirLineaExp)
					Else 
						_O_ENABLE BUTTON:C192(bSubirLineaExp)
					End if 
					
					If (($line=0) | ($line=Size of array:C274(al_NumeroHe)))
						_O_DISABLE BUTTON:C193(bBajarLineaExp)
					Else 
						_O_ENABLE BUTTON:C192(bBajarLineaExp)
					End if 
					If ($line>0)
						_O_ENABLE BUTTON:C192(bDeleteLine)
					Else 
						_O_DISABLE BUTTON:C193(bDeleteLine)
					End if 
					_O_ENABLE BUTTON:C192(bInsertLine)
					AL_UpdateArrays (xALP_ExportBankFilesH;-2)
				: (xALP_ExportBankFilesF=$1)
					Case of 
						: ($col=2)
							If (at_DescripcionFo{$line}#"Texto Fijo")
								at_TextoFijoFo{$line}:=""
							End if 
							If (at_DescripcionFo{$line}#at_DescripcionFo{0})
								at_FormatoFo{$line}:=""
							End if 
						: (($col=4) | ($col=8))  //Largo
							If (al_PosIniFo{1}#1)  //Para asegurar que ella fila 1 siempre parta en 1
								al_PosIniFo{1}:=1
								al_PosFinalFo{1}:=al_PosIniFo{1}+(al_LargoFo{1}-1)  //test
							Else 
								If (($line>1) & (al_PosIniFo{$line}<al_PosFinalFo{$line-1}))  //esto era para cuando se podía 
									al_PosIniFo{$line}:=al_PosFinalFo{$line-1}+1
								End if 
								If ((al_PosIniFo{$line})#(al_PosFinalFo{$line-1}+1))  //esto era para cuando se podía ingresar en $col 3
									al_PosIniFo{$line}:=al_PosFinalFo{$line-1}+1
								End if 
							End if 
							If ($col=4)
								If (at_RellenoFo{$line}="Ajustado a contenido")
									al_LargoFo{$line}:=1
								End if 
								If ((at_DescripcionFo{$line}="Texto Fijo") & (at_TextoFijoFo{$line}#""))  //Para campo Texto fijo"
									If ((al_LargoFo{$line}<Length:C16(at_TextoFijoFo{$line})) & (at_RellenoFo{$line}#"Ajustado a contenido"))
										at_TextoFijoFo{$line}:=""
									End if 
								End if 
							Else 
								If ($col=8)
									If ((at_DescripcionFo{$line}="Texto Fijo") & (al_LargoFo{$line}<Length:C16(at_TextoFijoFo{$line})) & (at_RellenoFo{$line}#"Ajustado a contenido"))
										at_TextoFijoFo{$line}:=""
										CD_Dlog (0;__ ("El largo del texto ingresado excede el largo del registro configurado"))
									End if 
									If (at_RellenoFo{$line}="Ajustado a contenido")
										al_LargoFo{$line}:=1
									End if 
								End if 
							End if 
						: ($col=9)
							If (at_DescripcionFo{$line}#"Texto Fijo")
								at_TextoFijoFo{$line}:=""
								CD_Dlog (0;__ ("Sólo puede ingresar texto después de seleccionar Texto Fijo"))
							End if 
							If ((at_DescripcionFo{$line}="Texto Fijo") & (at_TextoFijoFo{$line}#""))
								If ((al_LargoFo{$line}<Length:C16(at_TextoFijoFo{$line})) & (at_RellenoFo{$line}#"Ajustado a contenido"))
									at_TextoFijoFo{$line}:=""
									CD_Dlog (0;__ ("El largo del texto ingresado excede el largo del registro configurado"))
								End if 
							End if 
					End case 
					If ((al_PosIniFo{$line}>=al_PosFinalFo{$line}) & ($line>1))  //
						al_PosFinalFo{$line}:=(al_PosIniFo{$line}+al_LargoFo{$line})-1
					Else 
						If ((al_NumeroFo{$line}>0) & (al_PosIniFo{$line}>0) & (al_LargoFo{$line}>0))  //esto era para cuando se podía ingresar en $col 3 y para actualizar
							al_PosFinalFo{$line}:=(al_PosIniFo{$line}+al_LargoFo{$line})-1
						End if 
					End if 
					If (al_LargoFo{$line}=0)  //Para que no asignen largo 0
						al_LargoFo{$line}:=al_PosFinalFo{$line}-al_PosIniFo{$line}
					End if 
					C_BOOLEAN:C305($entrar)
					If ($line=1)
						$entrar:=False:C215
						$line:=0
					Else 
						$entrar:=True:C214
					End if 
					If (Size of array:C274(al_NumeroFo)>1)  //para recorrer los arreglos y modificar la posición inicial y final. El largo se mantiene
						For ($i;1;Size of array:C274(al_NumeroFo)-$line)
							If ($entrar)
								al_PosIniFo{$line+1}:=al_PosFinalFo{$line}+1
								al_PosFinalFo{$line+1}:=(al_PosIniFo{$line+1}+al_LargoFo{$line+1})-1
								$line:=$line+1
							End if 
							If (Not:C34($entrar))
								$entrar:=True:C214
								$line:=$line+1
							End if 
						End for 
					End if 
					
					$line:=AL_GetLine (xALP_ExportBankFilesF)
					If (($line=0) | ($line=1))
						_O_DISABLE BUTTON:C193(bSubirLineaExp)
					Else 
						_O_ENABLE BUTTON:C192(bSubirLineaExp)
					End if 
					
					If (($line=0) | ($line=Size of array:C274(al_NumeroFo)))
						_O_DISABLE BUTTON:C193(bBajarLineaExp)
					Else 
						_O_ENABLE BUTTON:C192(bBajarLineaExp)
					End if 
					If ($line>0)
						_O_ENABLE BUTTON:C192(bDeleteLine)
					Else 
						_O_DISABLE BUTTON:C193(bDeleteLine)
					End if 
					_O_ENABLE BUTTON:C192(bInsertLine)
					AL_UpdateArrays (xALP_ExportBankFilesF;-2)
			End case 
		Else   //importación
			vb_testImport:=False:C215
			IT_SetButtonState (vb_testImport;->bTestImport)
			Case of 
				: (PWTrf_h2=1)  //ancho fijo
					Case of 
						: (($col=2) | ($col=3))
							For ($j;1;Size of array:C274(at_Descripcion))
								For ($i;1;Size of array:C274(at_Descripcion))
									If ((al_PosIni{$i}>0) & (al_Largo{$i}>0))
										$largo:=al_PosIni{$i}+al_Largo{$i}
										If ((al_PosIni{$j}<$largo) & (al_PosIni{$j}>=al_PosIni{$i}) & ($j#$i))
											CD_Dlog (0;__ ("No puede especificar 2 campos dentro del mismo rango. Revise los campos ")+at_Descripcion{$i}+__ (" y ")+at_Descripcion{$j})
											$i:=Size of array:C274(at_Descripcion)
											$j:=Size of array:C274(at_Descripcion)
										End if 
									End if 
								End for 
							End for 
						: ($col=6)
							  //If (at_Descripcion{$line}#"Monto")
							If (((at_idsTextos{$line}#"1") & (at_idsTextos{$line}#"15") & (at_idsTextos{$line}#"16") & (at_idsTextos{$line}#"20")) | (al_Decimales{$line}>al_Largo{$line}))
								al_Decimales{$line}:=0
							End if 
					End case 
					
				: (PWTrf_h1=1)  //delimitado
					Case of 
						: ($col=5)
							  //If (at_Descripcion{$line}#"Monto")
							If ((at_idsTextos{$line}#"1") & (at_idsTextos{$line}#"15") & (at_idsTextos{$line}#"16") & (at_idsTextos{$line}#"20"))
								al_Decimales{$line}:=0
							End if 
						: ($col=1)
							al_Numero{0}:=al_Numero{$line}
							ARRAY LONGINT:C221($DA_Return;0)
							AT_SearchArray (->al_Numero;"=";->$DA_Return)
							If (Size of array:C274($DA_Return)>1)
								$resp:=CD_Dlog (0;__ ("Especificó más de 1 campo con el mismo número de posición. ¿Desea mantener el número de posición?");__ ("");__ ("Si");__ ("No"))
								If ($resp=2)
									al_Numero{$line}:=0
								End if 
							End if 
					End case 
			End case 
			REDRAW WINDOW:C456  //test RCH
		End if 
	End if 
End if 