//%attributes = {}
  //xALP_CB_ACT_ContableExtras

C_BOOLEAN:C305($0)
C_LONGINT:C283($1;$2;$3)

If ($2=8)
	$0:=False:C215
Else 
	$0:=True:C214
	AL_GetCurrCell (xALP_Glosas;$col;$row)
	If (AL_GetCellMod (xALP_Glosas)=1)
		Case of 
			: ($col=1)
				If ((atACT_GlosasExtraGlosa{$row}#atACT_GlosasExtraGlosa{0}) | (Macintosh command down:C546 | Windows Ctrl down:C562))
					vbACT_ModGlosasExtra:=True:C214
					vtMsg:="Usted modificó una glosa."+"\r"+"Si lo desea puede aplicar la nueva glosa a los cargos ya generados o bien utiliz"+"ar esta nueva glosa sólo para los cargos que se generen de ahora en adelante."
					vtDesc1:="La glosa es modificada, pero sólo será aplicada a los nuevos "+"cargos que se generen."
					vtDesc2:="Se asigna la nueva glosa a los cargos ya generados."
					vtBtn1:="Sólo para los nuevos cargos"
					vtBtn2:="Aplicar también a los cargos ya generados"
					WDW_OpenDialogInDrawer (->[xxACT_GlosasExtraordinarias:5];"ACT_DLG_ModGExtras")
					If (ok=1)
						If (r2=1)
							$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Actualizando glosas en cargos..."))
							QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]Glosa:12=atACT_GlosasExtraGlosa{0};*)
							QUERY:C277([ACT_Cargos:173]; | ;[ACT_Cargos:173]Glosa:12=atACT_GlosasExtraGlosa{0}+" (des@")
							ARRAY LONGINT:C221($aRNCargos;0)
							LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];$aRNCargos;"")
							READ WRITE:C146([ACT_Cargos:173])
							For ($j;1;Size of array:C274($aRNCargos))
								GOTO RECORD:C242([ACT_Cargos:173];$aRNCargos{$j})
								If (Position:C15(" (des";[ACT_Cargos:173]Glosa:12)#0)
									$descto:=Substring:C12([ACT_Cargos:173]Glosa:12;Position:C15(" (des";[ACT_Cargos:173]Glosa:12))
								Else 
									$descto:=""
								End if 
								[ACT_Cargos:173]Glosa:12:=atACT_GlosasExtraGlosa{$row}+$descto
								SAVE RECORD:C53([ACT_Cargos:173])
								$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$j/Size of array:C274($aRNCargos);__ ("Actualizando glosas en cargos..."))
							End for 
							UNLOAD RECORD:C212([ACT_Cargos:173])
							READ ONLY:C145([ACT_Cargos:173])
							$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
						End if 
					Else 
						atACT_GlosasExtraGlosa{$row}:=atACT_GlosasExtraGlosa{0}
					End if 
				End if 
			: ($col=2)
				$existe:=Find in array:C230(<>asACT_CuentaCta;atACT_GlosasExtraCta{$row})
				If ($existe#-1)
					If ((atACT_GlosasExtraCta{$row}#atACT_GlosasExtraCta{0}) | (Macintosh command down:C546 | Windows Ctrl down:C562))
						vbACT_ModGlosasExtra:=True:C214
						vtMsg:="Usted modificó el código de plan de cuentas para este cargo."+"\r"+"Si lo desea puede aplicar el nuevo código a los cargos ya generados o bien utiliz"+"ar este nuevo código sólo para los cargos que se generen de ahora en adelante."
						vtDesc1:="El código de plan de cuentas es modificado, pero sólo será aplicado a los nuevos "+"cargos que se generen."
						vtDesc2:="Se asigna el nuevo código a los cargos ya generados."
						vtBtn1:="Sólo para los nuevos cargos"
						vtBtn2:="Aplicar también a los cargos ya generados"
						WDW_OpenDialogInDrawer (->[xxACT_GlosasExtraordinarias:5];"ACT_DLG_ModGExtras")
						If (ok=1)
							If (r2=1)
								$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Actualizando información contable en cargos..."))
								QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]Glosa:12=atACT_GlosasExtraGlosa{$row};*)
								QUERY:C277([ACT_Cargos:173]; | ;[ACT_Cargos:173]Glosa:12=atACT_GlosasExtraGlosa{$row}+" (des@")
								ARRAY LONGINT:C221($aRNCargos;0)
								LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];$aRNCargos;"")
								READ WRITE:C146([ACT_Cargos:173])
								For ($j;1;Size of array:C274($aRNCargos))
									GOTO RECORD:C242([ACT_Cargos:173];$aRNCargos{$j})
									[ACT_Cargos:173]No_de_Cuenta_contable:17:=atACT_GlosasExtraCta{$row}
									SAVE RECORD:C53([ACT_Cargos:173])
									$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$j/Size of array:C274($aRNCargos);__ ("Actualizando información contable en cargos..."))
								End for 
								UNLOAD RECORD:C212([ACT_Cargos:173])
								READ ONLY:C145([ACT_Cargos:173])
								$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
							End if 
						Else 
							atACT_GlosasExtraCta{$row}:=atACT_GlosasExtraCta{0}
						End if 
					End if 
				Else 
					CD_Dlog (0;__ ("Este código de plan de cuentas no está definido."))
					atACT_GlosasExtraCta{$row}:=atACT_GlosasExtraCta{0}
				End if 
			: ($col=3)
				$existe:=Find in array:C230(<>asACT_Centro;atACT_GlosasExtraCentro{$row})
				If ($existe#-1)
					If ((atACT_GlosasExtraCentro{$row}#atACT_GlosasExtraCentro{0}) | (Macintosh command down:C546 | Windows Ctrl down:C562))
						vbACT_ModGlosasExtra:=True:C214
						vtMsg:="Usted modificó el código de centro de costo para este cargo."+"\r"+"Si lo desea puede aplicar el nuevo código a los cargos ya generados o bien utiliz"+"ar este nuevo código sólo para los cargos que se generen de ahora en adelante."
						vtDesc1:="El código de centro de costos es modificado, pero sólo será aplicado a los nuevos"+" "+"cargos que se generen."
						vtDesc2:="Se asigna el nuevo código a los cargos ya generados."
						vtBtn1:="Sólo para los nuevos cargos"
						vtBtn2:="Aplicar también a los cargos ya generados"
						WDW_OpenDialogInDrawer (->[xxACT_GlosasExtraordinarias:5];"ACT_DLG_ModGExtras")
						If (ok=1)
							If (r2=1)
								$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Actualizando información contable en cargos..."))
								QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]Glosa:12=atACT_GlosasExtraGlosa{$row};*)
								QUERY:C277([ACT_Cargos:173]; | ;[ACT_Cargos:173]Glosa:12=atACT_GlosasExtraGlosa{$row}+" (des@")
								ARRAY LONGINT:C221($aRNCargos;0)
								LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];$aRNCargos;"")
								READ WRITE:C146([ACT_Cargos:173])
								For ($j;1;Size of array:C274($aRNCargos))
									GOTO RECORD:C242([ACT_Cargos:173];$aRNCargos{$j})
									[ACT_Cargos:173]Centro_de_costos:15:=atACT_GlosasExtraCentro{$row}
									SAVE RECORD:C53([ACT_Cargos:173])
									$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$j/Size of array:C274($aRNCargos);__ ("Actualizando información contable en cargos..."))
								End for 
								UNLOAD RECORD:C212([ACT_Cargos:173])
								READ ONLY:C145([ACT_Cargos:173])
								$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
							End if 
						Else 
							atACT_GlosasExtraCentro{$row}:=atACT_GlosasExtraCentro{0}
						End if 
					End if 
				Else 
					CD_Dlog (0;__ ("Este código de centro de costos no está definido."))
					atACT_GlosasExtraCentro{$row}:=atACT_GlosasExtraCentro{0}
				End if 
			: ($col=4)
				$existe:=Find in array:C230(<>asACT_CuentaCta;atACT_GlosasExtraCCta{$row})
				If ($existe#-1)
					If ((atACT_GlosasExtraCCta{$row}#atACT_GlosasExtraCCta{0}) | (Macintosh command down:C546 | Windows Ctrl down:C562))
						vbACT_ModGlosasExtra:=True:C214
						vtMsg:="Usted modificó el código de plan de cuentas de contra cuenta para este cargo."+"\r"+"Si lo desea puede aplicar el nuevo código a los cargos ya generados o bien utiliz"+"ar este nuevo código sólo para los cargos que se generen de ahora en adelante."
						vtDesc1:="El código de plan de cuentas de contra cuenta es modificado, pero sólo será aplic"+"ado a los nuevos "+"cargos que se generen."
						vtDesc2:="Se asigna el nuevo código a los cargos ya generados."
						vtBtn1:="Sólo para los nuevos cargos"
						vtBtn2:="Aplicar también a los cargos ya generados"
						WDW_OpenDialogInDrawer (->[xxACT_GlosasExtraordinarias:5];"ACT_DLG_ModGExtras")
						If (ok=1)
							If (r2=1)
								$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Actualizando información contable en cargos..."))
								QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]Glosa:12=atACT_GlosasExtraGlosa{$row};*)
								QUERY:C277([ACT_Cargos:173]; | ;[ACT_Cargos:173]Glosa:12=atACT_GlosasExtraGlosa{$row}+" (des@")
								ARRAY LONGINT:C221($aRNCargos;0)
								LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];$aRNCargos;"")
								READ WRITE:C146([ACT_Cargos:173])
								For ($j;1;Size of array:C274($aRNCargos))
									GOTO RECORD:C242([ACT_Cargos:173];$aRNCargos{$j})
									[ACT_Cargos:173]No_CCta_contable:39:=atACT_GlosasExtraCCta{$row}
									SAVE RECORD:C53([ACT_Cargos:173])
									$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$j/Size of array:C274($aRNCargos);__ ("Actualizando información contable en cargos..."))
								End for 
								UNLOAD RECORD:C212([ACT_Cargos:173])
								READ ONLY:C145([ACT_Cargos:173])
								$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
							End if 
						Else 
							atACT_GlosasExtraCCta{$row}:=atACT_GlosasExtraCCta{0}
						End if 
					End if 
				Else 
					CD_Dlog (0;__ ("Este código de plan de cuentas no está definido."))
					atACT_GlosasExtraCCta{$row}:=atACT_GlosasExtraCCta{0}
				End if 
			: ($col=5)
				$existe:=Find in array:C230(<>asACT_Centro;atACT_GlosasExtraCCentro{$row})
				If ($existe#-1)
					If ((atACT_GlosasExtraCCentro{$row}#atACT_GlosasExtraCCentro{0}) | (Macintosh command down:C546 | Windows Ctrl down:C562))
						vbACT_ModGlosasExtra:=True:C214
						vtMsg:="Usted modificó el código de centro de costo de contra cuenta para este cargo."+"\r"+"Si lo desea puede aplicar el nuevo código a los cargos ya generados o bien utiliz"+"ar este nuevo código sólo para los cargos que se generen de ahora en adelante."
						vtDesc1:="El código de centro de costos de contra cuenta es modificado, pero sólo será apli"+"cado a los nuevos"+" "+"cargos que se generen."
						vtDesc2:="Se asigna el nuevo código a los cargos ya generados."
						vtBtn1:="Sólo para los nuevos cargos"
						vtBtn2:="Aplicar también a los cargos ya generados"
						WDW_OpenDialogInDrawer (->[xxACT_GlosasExtraordinarias:5];"ACT_DLG_ModGExtras")
						If (ok=1)
							If (r2=1)
								$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Actualizando información contable en cargos..."))
								QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]Glosa:12=atACT_GlosasExtraGlosa{$row};*)
								QUERY:C277([ACT_Cargos:173]; | ;[ACT_Cargos:173]Glosa:12=atACT_GlosasExtraGlosa{$row}+" (des@")
								ARRAY LONGINT:C221($aRNCargos;0)
								LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];$aRNCargos;"")
								READ WRITE:C146([ACT_Cargos:173])
								For ($j;1;Size of array:C274($aRNCargos))
									GOTO RECORD:C242([ACT_Cargos:173];$aRNCargos{$j})
									[ACT_Cargos:173]CCentro_de_costos:40:=atACT_GlosasExtraCCentro{$row}
									SAVE RECORD:C53([ACT_Cargos:173])
									$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$j/Size of array:C274($aRNCargos);__ ("Actualizando información contable en cargos..."))
								End for 
								UNLOAD RECORD:C212([ACT_Cargos:173])
								READ ONLY:C145([ACT_Cargos:173])
								$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
							End if 
						Else 
							atACT_GlosasExtraCCentro{$row}:=atACT_GlosasExtraCCentro{0}
						End if 
					End if 
				Else 
					CD_Dlog (0;__ ("Este código de centro de costos no está definido."))
					atACT_GlosasExtraCCentro{$row}:=atACT_GlosasExtraCCentro{0}
				End if 
		End case 
	End if 
End if 