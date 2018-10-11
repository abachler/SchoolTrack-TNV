If (Modified:C32(Self:C308->))
	If (USR_GetMethodAcces ("ACTcc_HabilitarDescuentosCC"))
		If ((Self:C308-><0) | (Self:C308->>100))
			Self:C308->:=Old:C35(Self:C308->)
			CD_Dlog (0;__ ("El porcentaje de descuento debe estar entre 0 y 100%."))
		Else 
			
			  //20150507 RCH
			C_LONGINT:C283($r_valorAnterior)
			$r_valorAnterior:=Old:C35([ACT_CuentasCorrientes:175]Descuento:23)
			
			
			ACTinit_LoadPrefs 
			If (cbConsiderarDctoMaximo=1)
				If (vr_descuentoMaximo#0)
					If (Self:C308->>vr_descuentoMaximo)
						$vt_text:="El descuento ingresado es superior al descuento máximo ingresado en la configurac"+"ión."+"\r\r"+"Para que el descuento por "+String:C10(Self:C308->)+"% sea aplicado recuerde "
						$vt_text:=$vt_text+ST_Boolean2Str (([ACT_CuentasCorrientes:175]NoAplicaMaxDcto:30);"mantener marcada ";"marcar ")
						$vt_text:=$vt_text+"la opción "+ST_Qte ("No aplica máximo de descuento"+".")
						CD_Dlog (0;$vt_text)
					End if 
				End if 
			End if 
			ARRAY TEXT:C222(atACT_NombreMonedaEm;0)
			$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Recalculando cargos..."))
			SAVE RECORD:C53([ACT_CuentasCorrientes:175])
			$RNCta:=Record number:C243([ACT_CuentasCorrientes:175])
			QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1;*)
			QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22=!00-00-00!;*)
			QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]ID_CargoRelacionado:47=0)
			$idmatriz:=[ACT_CuentasCorrientes:175]ID_Matriz:7
			UNLOAD RECORD:C212([ACT_CuentasCorrientes:175])
			KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->[ACT_Cargos:173]ID_Documento_de_Cargo:3;"")
			SELECTION TO ARRAY:C260([ACT_Documentos_de_Cargo:174];$aRecNumDocsCta)
			SELECTION TO ARRAY:C260([ACT_Cargos:173];$aRecNumsCargos)
			$iterations:=Size of array:C274($aRecNumsCargos)+Size of array:C274($aRecNumDocsCta)
			$currentiteration:=0
			  //ACTinit_LoadPrefs 
			For ($i_Cargos;1;Size of array:C274($aRecNumsCargos))
				$currentiteration:=$i_Cargos
				GOTO RECORD:C242([ACT_Cargos:173];$aRecNumsCargos{$i_Cargos})
				QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]ID_Documento:1=[ACT_Cargos:173]ID_Documento_de_Cargo:3)
				QUERY:C277([xxACT_ItemsMatriz:180];[xxACT_ItemsMatriz:180]ID_Matriz:1=$idmatriz;*)
				QUERY:C277([xxACT_ItemsMatriz:180]; & ;[xxACT_ItemsMatriz:180]ID_Item:2=[ACT_Cargos:173]Ref_Item:16)
				UNLOAD RECORD:C212([ACT_Cargos:173])
				If (Records in selection:C76([xxACT_ItemsMatriz:180])>0)
					$itemnomatriz:=False:C215
				Else 
					$itemnomatriz:=True:C214
				End if 
				READ WRITE:C146([ACT_Cargos:173])
				ACTcc_CalculaMontoItem ($aRecNumsCargos{$i_Cargos};$idmatriz;$itemnomatriz)
				UNLOAD RECORD:C212([ACT_Cargos:173])
				READ ONLY:C145([ACT_Cargos:173])
				$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$currentiteration/$iterations;__ ("Recalculando cargos..."))
			End for 
			
			For ($Docs;1;Size of array:C274($aRecNumDocsCta))
				$currentiteration:=$currentiteration+1
				ACTcc_CalculaDocumentoCargo ($aRecNumDocsCta{$Docs})
				$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$currentiteration/$iterations;__ ("Recalculando documentos de cargo..."))
			End for 
			READ WRITE:C146([ACT_CuentasCorrientes:175])
			GOTO RECORD:C242([ACT_CuentasCorrientes:175];$RNCta)
			$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
			
			LOG_RegisterEvt ("Edición de porcentaje de descuento en ficha de la cuenta corriente. Alumno: "+KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3;->[Alumnos:2]apellidos_y_nombres:40)+". Valor anterior: "+String:C10($r_valorAnterior)+". Valor actual: "+String:C10(Self:C308->)+".")
			
		End if 
	Else 
		Self:C308->:=Old:C35(Self:C308->)
	End if 
End if 