//%attributes = {}
  //ACTwiz_ImportDatosPagoApdos

If (USR_GetMethodAcces (Current method name:C684))
	WDW_OpenFormWindow (->[xxSTR_Constants:1];"ACTwiz_ImportDatosPagoApdos";0;4;__ ("Importación de Información para Pagos de Apoderados"))
	DIALOG:C40([xxSTR_Constants:1];"ACTwiz_ImportDatosPagoApdos")
	CLOSE WINDOW:C154
	If (ok=1)
		Case of 
			: (r1=1)
				USE CHARACTER SET:C205("MacRoman";1)
			: (r2=1)
				USE CHARACTER SET:C205("windows-1252";1)
			: (r3=1)
				USE CHARACTER SET:C205("UTF-8";1)
		End case 
		
		C_TEXT:C284($t_emailDTE)
		C_LONGINT:C283($l_id;$l_pos)
		
		ARRAY TEXT:C222(aRUTRechazoImpPP;0)
		ARRAY TEXT:C222(aRechazosImpPP;0)
		ARRAY TEXT:C222(atACT_Modo_de_Pago;0)
		COPY ARRAY:C226(<>atACT_ModosdePago;atACT_Modo_de_Pago)
		ACTcfg_LoadBancos 
		$delimiter:=ACTabc_DetectDelimiter (vt_g1)
		$ref:=Open document:C264(vt_g1;Read mode:K24:5)
		If (ok=1)
			$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Importando datos..."))
			If (cb_TieneEncabezado=1)
				RECEIVE PACKET:C104($ref;$text;$delimiter)
			End if 
			RECEIVE PACKET:C104($ref;$text;$delimiter)
			If (r2=1)
				$text:=_O_Win to Mac:C464($text)
			End if 
			While ($text#"")
				$identificador:=ST_GetWord ($text;1;"\t")
				READ WRITE:C146([Personas:7])
				QUERY:C277([Personas:7];aIDFieldPointers{aIdentificadores}->;=;$identificador)
				If (Records in selection:C76([Personas:7])=1)
					If ([Personas:7]ES_Apoderado_de_Cuentas:42)
						$afecto:=ST_GetWord ($text;2;"\t")
						$modo:=ST_GetWord ($text;3;"\t")
						$dia:=Num:C11(ST_GetWord ($text;4;"\t"))
						$codPAC:=ST_GetWord ($text;5;"\t")
						$idBancoCta:=ST_GetWord ($text;6;"\t")
						$NombreCta:=ST_GetWord ($text;7;"\t")
						$ApPaternoCta:=ST_GetWord ($text;8;"\t")
						$ApMaternoCta:=ST_GetWord ($text;9;"\t")
						$IDTitCta:=ST_GetWord ($text;10;"\t")
						$numCta:=ST_GetWord ($text;11;"\t")
						$codPAT:=ST_GetWord ($text;12;"\t")
						$idBancoTj:=ST_GetWord ($text;13;"\t")
						$tipoTj:=ST_GetWord ($text;14;"\t")
						$NombreTj:=ST_GetWord ($text;15;"\t")
						$ApPaternoTj:=ST_GetWord ($text;16;"\t")
						$ApMaternoTj:=ST_GetWord ($text;17;"\t")
						$IDTitTj:=ST_GetWord ($text;18;"\t")
						$numTj:=ST_GetWord ($text;19;"\t")
						$mesVenTj:=ST_GetWord ($text;20;"\t")
						$añoVenTj:=ST_GetWord ($text;21;"\t")
						$esInternacionalTj:=ST_GetWord ($text;22;"\t")
						$dirEC:=ST_GetWord ($text;23;"\t")
						$comEC:=ST_GetWord ($text;24;"\t")
						$CodPosEC:=ST_GetWord ($text;25;"\t")
						$ciuEC:=ST_GetWord ($text;26;"\t")
						$t_emailDTE:=ST_GetWord ($text;27;"\t")  //20170719 RCH
						
						If ($afecto#"")
							If ($afecto="SI")
								[Personas:7]ACT_AfectoIntereses:64:=True:C214
							Else 
								If ($afecto="NO")
									READ WRITE:C146([ACT_CuentasCorrientes:175])
									QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Apoderado:9=[Personas:7]No:1)
									CREATE SET:C116([ACT_CuentasCorrientes:175];"apdoNormal")
									READ ONLY:C145([ACT_Apoderados_de_Cuenta:107])
									QUERY:C277([ACT_Apoderados_de_Cuenta:107];[ACT_Apoderados_de_Cuenta:107]ID_Apoderado:1=[Personas:7]No:1)
									KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Apoderados_de_Cuenta:107]ID_CtaCte:2)
									CREATE SET:C116([ACT_CuentasCorrientes:175];"exApdos")
									UNION:C120("apdoNormal";"exApdos";"apdoNormal")
									USE SET:C118("apdoNormal")
									SET_ClearSets ("apdoNormal";"exApdos")
									APPLY TO SELECTION:C70([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]AfectoIntereses:28:=False:C215)
									KRL_UnloadReadOnly (->[ACT_CuentasCorrientes:175])
								Else 
									AT_Insert (0;1;->aRUTRechazoImpPP;->aRechazosImpPP)
									aRUTRechazoImpPP{Size of array:C274(aRUTRechazoImpPP)}:=$identificador
									aRechazosImpPP{Size of array:C274(aRechazosImpPP)}:="Indicador no válido de afectación a intereses."
								End if 
							End if 
						End if 
						  //If ($modo#"")
						  //Case of 
						  //: ($modo="Colegio")
						  //[Personas]ACT_Modo_de_pago:=atACT_Modo_de_Pago{1}
						  //[Personas]ACT_id_modo_de_pago:=-2
						  //: ($modo="PAC")
						  //[Personas]ACT_Modo_de_pago:=atACT_Modo_de_Pago{2}
						  //[Personas]ACT_id_modo_de_pago:=-10
						  //: ($modo="PAT")
						  //[Personas]ACT_Modo_de_pago:=atACT_Modo_de_Pago{3}
						  //[Personas]ACT_id_modo_de_pago:=-9
						  //: ($modo="CUP")
						  //[Personas]ACT_Modo_de_pago:=atACT_Modo_de_Pago{4}
						  //[Personas]ACT_id_modo_de_pago:=-11
						  //Else 
						  //AT_Insert (0;1;->aRUTRechazoImpPP;->aRechazosImpPP)
						  //aRUTRechazoImpPP{Size of array(aRUTRechazoImpPP)}:=$identificador
						  //aRechazosImpPP{Size of array(aRechazosImpPP)}:="Indicador no válido para modo de pago."
						  //End case 
						  //[Personas]ACT_modo_de_pago_new:=<>atACT_FormasDePago2D{3}{Find in array(<>atACT_FormasDePago2D{1};String([Personas]ACT_id_modo_de_pago))
						  //End if 
						  //20171206 185750 ABC RCH, se busca la forma de pago en el arreglo de modo y el ID en vidimension,
						If ($modo#"")
							$l_pos:=Find in array:C230(<>atACT_FormasDePago2D{2};$modo)
							If ($l_pos>0)
								  // Modificado por: Saúl Ponce (21/12/2017) Ticket 185750, el primer array es el que tiene los número correspondiente a la forma de pago y el segundo la posición en el array
								  // $l_id:=Num(<>atACT_FormasDePago2D{$l_pos}{1})
								$l_id:=Num:C11(<>atACT_FormasDePago2D{1}{$l_pos})
								[Personas:7]ACT_Modo_de_pago:39:=atACT_Modo_de_Pago{$l_pos}
								[Personas:7]ACT_id_modo_de_pago:94:=$l_id
							End if 
							[Personas:7]ACT_modo_de_pago_new:95:=<>atACT_FormasDePago2D{3}{Find in array:C230(<>atACT_FormasDePago2D{1};String:C10([Personas:7]ACT_id_modo_de_pago:94))}
						Else 
							AT_Insert (0;1;->aRUTRechazoImpPP;->aRechazosImpPP)
							aRUTRechazoImpPP{Size of array:C274(aRUTRechazoImpPP)}:=$identificador
							aRechazosImpPP{Size of array:C274(aRechazosImpPP)}:="Indicador no válido para modo de pago."
						End if 
						
						If ($dia>0)
							If (($dia>=1) & ($dia<=31))
								[Personas:7]ACT_DiaCargo:61:=$dia
							Else 
								AT_Insert (0;1;->aRUTRechazoImpPP;->aRechazosImpPP)
								aRUTRechazoImpPP{Size of array:C274(aRUTRechazoImpPP)}:=$identificador
								aRechazosImpPP{Size of array:C274(aRechazosImpPP)}:="Día de cargo fuera de rango permitido (1 a 31)."
							End if 
						End if 
						If ($codPAC#"")
							[Personas:7]ACT_CodMandatoPAC:62:=Substring:C12($codPAC;1;80)
						End if 
						If ($idBancoCta#"")
							[Personas:7]ACT_ID_Banco_Cta:48:=Substring:C12($idBancoCta;1;5)
							$page:=Find in array:C230(atACT_BankID;[Personas:7]ACT_ID_Banco_Cta:48)
							If ($page#-1)
								[Personas:7]ACT_Banco_Cta:47:=atACT_BankName{$page}
							Else 
								[Personas:7]ACT_ID_Banco_Cta:48:=""
								AT_Insert (0;1;->aRUTRechazoImpPP;->aRechazosImpPP)
								aRUTRechazoImpPP{Size of array:C274(aRUTRechazoImpPP)}:=$identificador
								aRechazosImpPP{Size of array:C274(aRechazosImpPP)}:="Código de banco de cuenta corriente no válido."
							End if 
						End if 
						If ($NombreCta#"")
							[Personas:7]ACT_Nombres_Cta:76:=Substring:C12($NombreCta;1;80)
						End if 
						If ($ApPaternoCta#"")
							[Personas:7]ACT_Apellido_Paterno_Cta:74:=Substring:C12($ApPaternoCta;1;80)
						End if 
						If ($ApMaternoCta#"")
							[Personas:7]ACT_Apellido_Materno_Cta:75:=Substring:C12($ApMaternoCta;1;80)
						End if 
						If (($NombreCta#"") | ($ApPaternoCta#"") | ($ApMaternoCta#""))
							[Personas:7]ACT_Titular_Cta:49:=Replace string:C233([Personas:7]ACT_Apellido_Paterno_Cta:74+" "+[Personas:7]ACT_Apellido_Materno_Cta:75+" "+[Personas:7]ACT_Nombres_Cta:76;"  ";" ")
						End if 
						If ($IDTitCta#"")
							[Personas:7]ACT_RUTTitutal_Cta:50:=Substring:C12($IDTitCta;1;20)
						End if 
						If ($numCta#"")
							[Personas:7]ACT_Numero_Cta:51:=$numCta
						End if 
						If ($codPAT#"")
							[Personas:7]ACT_CodMandatoPAT:63:=Substring:C12($codPAT;1;80)
						End if 
						If ($idBancoTj#"")
							$page:=Find in array:C230(atACT_BankID;$idBancoTj)
							If ($page#-1)
								[Personas:7]ACT_Banco_TC:53:=atACT_BankName{$page}
							Else 
								AT_Insert (0;1;->aRUTRechazoImpPP;->aRechazosImpPP)
								aRUTRechazoImpPP{Size of array:C274(aRUTRechazoImpPP)}:=$identificador
								aRechazosImpPP{Size of array:C274(aRechazosImpPP)}:="Código de banco de tarjeta de crédito no válido."
							End if 
						End if 
						If ($tipoTj#"")
							$page:=Find in array:C230(<>atACT_TarjetasCredito;$tipoTj)
							If ($page#-1)
								[Personas:7]ACT_Tipo_TC:52:=$tipoTj
							Else 
								AT_Insert (0;1;->aRUTRechazoImpPP;->aRechazosImpPP)
								aRUTRechazoImpPP{Size of array:C274(aRUTRechazoImpPP)}:=$identificador
								aRechazosImpPP{Size of array:C274(aRechazosImpPP)}:="Tipo de tarjeta inexistente."
							End if 
						End if 
						If ($NombreTj#"")
							[Personas:7]ACT_Nombres_TC:73:=Substring:C12($NombreTj;1;80)
						End if 
						If ($ApPaternoTj#"")
							[Personas:7]ACT_Apellido_Paterno_TC:71:=Substring:C12($ApPaternoTj;1;80)
						End if 
						If ($ApMaternoTj#"")
							[Personas:7]ACT_Apellido_Materno_TC:72:=Substring:C12($ApMaternoTj;1;80)
						End if 
						If (($NombreTj#"") | ($ApPaternoTj#"") | ($ApMaternoTj#""))
							[Personas:7]ACT_Titular_TC:55:=Replace string:C233([Personas:7]ACT_Apellido_Paterno_TC:71+" "+[Personas:7]ACT_Apellido_Materno_TC:72+" "+[Personas:7]ACT_Nombres_TC:73;"  ";" ")
						End if 
						If ($IDTitTj#"")
							[Personas:7]ACT_RUTTitular_TC:56:=Substring:C12($IDTitTj;1;20)
						End if 
						If ($numTj#"")
							$numTj:=Substring:C12($numTj;1;16)
							[Personas:7]ACT_Numero_TC:54:=ACTpp_CRYPTTC ("xxACT_SetCryptTC";->$numTj;->[Personas:7]ACT_xPass:91)
						End if 
						If ($mesVenTj#"")
							$mesVenTjnum:=Num:C11($mesVenTj)
							If (($mesVenTjnum>=1) & ($mesVenTjnum<=12))
								[Personas:7]ACT_MesVenc_TC:57:=Substring:C12(String:C10($mesVenTjnum;"00");1;2)
							Else 
								AT_Insert (0;1;->aRUTRechazoImpPP;->aRechazosImpPP)
								aRUTRechazoImpPP{Size of array:C274(aRUTRechazoImpPP)}:=$identificador
								aRechazosImpPP{Size of array:C274(aRechazosImpPP)}:="Mes de vencimiento de tarjeta de crédito fuera del rango permitido (1 a 12)."
							End if 
						End if 
						If ($añoVenTj#"")
							[Personas:7]ACT_AñoVenc_TC:58:=Substring:C12(String:C10(Num:C11($añoVenTj);"0000");1;4)
						End if 
						If ($esInternacionalTj#"")
							Case of 
								: ($esInternacionalTj="SI")
									[Personas:7]ACT_TCEsInternacional:86:=True:C214
								: ($esInternacionalTj="NO")
									[Personas:7]ACT_TCEsInternacional:86:=False:C215
							End case 
						End if 
						If ($dirEC#"")
							[Personas:7]ACT_DireccionEC:67:=$dirEC
						End if 
						If ($comEC#"")
							$page:=Find in array:C230(<>aComuna;$comEC)
							If ($page#-1)
								[Personas:7]ACT_ComunaEC:68:=$comEC
							Else 
								AT_Insert (0;1;->aRUTRechazoImpPP;->aRechazosImpPP)
								aRUTRechazoImpPP{Size of array:C274(aRUTRechazoImpPP)}:=$identificador
								aRechazosImpPP{Size of array:C274(aRechazosImpPP)}:="Comuna de envío de correspondencia inexistente."
							End if 
						End if 
						If ($CodPosEC#"")
							[Personas:7]ACT_CodPostalEC:70:=$CodPosEC
						End if 
						If ($ciuEC#"")
							[Personas:7]ACT_CiudadEC:69:=$ciuEC
						End if 
						
						If ($t_emailDTE#"")
							$t_correoValidado:=ACTdte_VerificaEmail ($t_emailDTE;False:C215)  //20170719 RCH
							If ($t_correoValidado#"")
								[Personas:7]ACT_DTE_Enviar_Mail_Cuenta:111:=$t_correoValidado
								[Personas:7]ACT_DTE_Enviar_Mail:110:=True:C214
							Else 
								AT_Insert (0;1;->aRUTRechazoImpPP;->aRechazosImpPP)
								aRUTRechazoImpPP{Size of array:C274(aRUTRechazoImpPP)}:=$identificador
								aRechazosImpPP{Size of array:C274(aRechazosImpPP)}:="Correo "+ST_Qte ($t_emailDTE)+" no válido."
							End if 
						End if 
						
					Else 
						AT_Insert (0;1;->aRUTRechazoImpPP;->aRechazosImpPP)
						aRUTRechazoImpPP{Size of array:C274(aRUTRechazoImpPP)}:=$identificador
						aRechazosImpPP{Size of array:C274(aRechazosImpPP)}:="Apoderado no es apoderado de cuentas."
					End if 
				Else 
					If (Records in selection:C76([Personas:7])=0)
						AT_Insert (0;1;->aRUTRechazoImpPP;->aRechazosImpPP)
						aRUTRechazoImpPP{Size of array:C274(aRUTRechazoImpPP)}:=$identificador
						aRechazosImpPP{Size of array:C274(aRechazosImpPP)}:="Apoderado inexistente."
					Else 
						AT_Insert (0;1;->aRUTRechazoImpPP;->aRechazosImpPP)
						aRUTRechazoImpPP{Size of array:C274(aRUTRechazoImpPP)}:=$identificador
						aRechazosImpPP{Size of array:C274(aRechazosImpPP)}:="Hay más de un apoderado con el mismo identificador."
					End if 
				End if 
				SAVE RECORD:C53([Personas:7])
				If (Locked:C147([Personas:7]))
					AT_Insert (0;1;->aRUTRechazoImpPP;->aRechazosImpPP)
					aRUTRechazoImpPP{Size of array:C274(aRUTRechazoImpPP)}:=$identificador
					aRechazosImpPP{Size of array:C274(aRechazosImpPP)}:="Registro en uso por otro usuario o proceso."
				End if 
				RECEIVE PACKET:C104($ref;$text;$delimiter)
				If (r2=1)
					$text:=_O_Win to Mac:C464($text)
				End if 
				$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;Get document position:C481($ref)/Get document size:C479(vt_g1))
			End while 
			$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
			CLOSE DOCUMENT:C267($ref)
			KRL_UnloadReadOnly (->[Personas:7])
			If (Size of array:C274(aRUTRechazoImpPP)>0)
				$path:=SYS_GetParentNme (vt_g1)
				$filePath:=$path+"Resultado Importacion.txt"
				CD_Dlog (0;__ ("Se han producido errores en la importación. Para ver el detalle de los errores vea el archivo\r")+$filePath)
				If (SYS_TestPathName ($filePath)=Is a document:K24:1)
					DELETE DOCUMENT:C159($filePath)
				End if 
				$ref:=Create document:C266($filePath)
				IO_SendPacket ($ref;"Importación del archivo "+vt_g1+"\r"+String:C10(Current date:C33(*);7)+"\t"+String:C10(Current time:C178(*);HH MM:K7:2)+"\r"+"Importación realizada por "+<>tUSR_CurrentUserName+"\r\r")
				IO_SendPacket ($ref;"Identificador"+"\t"+"Error"+"\r")
				For ($i;1;Size of array:C274(aRUTRechazoImpPP))
					$text:=aRUTRechazoImpPP{$i}+"\t"+aRechazosImpPP{$i}+"\r"
					IO_SendPacket ($ref;$text)
				End for 
				CLOSE DOCUMENT:C267($ref)
				AT_Initialize (->aRUTRechazoImpPP;->aRechazosImpPP)
			End if 
			LOG_RegisterEvt ("Importación de datos de información para pagos realizada.")
			USE CHARACTER SET:C205(*;1)
		Else 
			CD_Dlog (0;__ ("Error al intentar leer desde ")+vt_g1)
		End if 
	End if 
End if 