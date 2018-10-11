If (vi_PageNumber=2)
	If (vt_g1#"")
		
		vt_id:=aIdentificadores{aIdentificadores}
		  //If ((vt_g1#vt_g1Temp) | (IT_AltKeyIsDown ))
		If ((vt_g1#vt_g1Temp) | (IT_AltKeyIsDown ) | (vt_id#vt_idTemp))
			vt_g1Temp:=vt_g1
			vt_idTemp:=vt_id
			AL_UpdateArrays (xALP_PreImport;0)
			ACTimp_ArrayDeclarations 
			READ ONLY:C145([ACT_Cargos:173])
			$delimiter:=ACTabc_DetectDelimiter (vt_g1)
			
			Case of 
				: (r1=1)
					USE CHARACTER SET:C205("MacRoman";1)
				: (r2=1)
					USE CHARACTER SET:C205("windows-1252";1)
			End case 
			
			$ref:=Open document:C264(vt_g1;"";Read mode:K24:5)
			If (ok=1)
				$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Pre importando archivo..."))
				If (cb_TieneEncabezado=1)
					RECEIVE PACKET:C104($ref;$text;$delimiter)
				End if 
				RECEIVE PACKET:C104($ref;$text;$delimiter)
				  //If (r2=1)
				  //$text:=Win to Mac($text)
				  //End if 
				While ($text#"")
					AT_Inc (0)
					AT_Insert (0;1;->aPareo;->aIDItem;->aGlosa;->aMoneda;->aMontotxt;->aAfectoIVA;->aMesDesde;->aAño2;->aMesHasta;->aAño;->aCargoDescto;->aCtaContable;->aCodAux;->aCentro;->aCCtaContable;->aCCodAux;->aCCentro;->aNoDocTribs)
					AT_Insert (0;1;->aAprobado;->aMotivo;->aIDCta)
					AT_Insert (0;1;->aAfectoaDxCta;->aAfectoaDesctos;->aPctInteres;->aTipoInteres;->aImpUnica;->aDesctoH2;->aDesctoH3;->aDesctoH4;->aDesctoH5;->aDesctoH6;->aDesctoH7;->aDesctoH8;->aDesctoH9;->aDesctoH10;->aDesctoH11;->aDesctoH12;->aDesctoH13;->aDesctoH14;->aDesctoH15;->aDesctoH16;->aDesctoH17)
					  //AT_Insert (0;1;->aBloqueadas)
					AT_Insert (0;1;->aBloqueadas;->aCodigo_interno)  //Ticket 165024 ASM no se insertaban elementos al arreglo aCodigo_interno (problema de integración anterior )
					aPareo{Size of array:C274(aPareo)}:=Replace string:C233(Replace string:C233(Replace string:C233(ST_GetCleanString (ST_GetWord ($text;AT_Inc ;"\t"));".";"");"-";"");" ";"")
					aIDItem{Size of array:C274(aIDItem)}:=String:C10(Num:C11(ST_GetCleanString (ST_GetWord ($text;AT_Inc ;"\t"))))
					aGlosa{Size of array:C274(aGlosa)}:=ST_GetCleanString (ST_GetWord ($text;AT_Inc ;"\t"))
					aMoneda{Size of array:C274(aMoneda)}:=ST_GetCleanString (ST_GetWord ($text;AT_Inc ;"\t"))
					aMontotxt{Size of array:C274(aMontotxt)}:=ST_GetCleanString (ST_GetWord ($text;AT_Inc ;"\t"))
					aAfectoIVA{Size of array:C274(aAfectoIVA)}:=ST_GetCleanString (ST_GetWord ($text;AT_Inc ;"\t"))
					aMesDesde{Size of array:C274(aMesDesde)}:=String:C10(Num:C11(ST_GetCleanString (ST_GetWord ($text;AT_Inc ;"\t"))))
					aAño{Size of array:C274(aAño)}:=String:C10(Num:C11(ST_GetCleanString (ST_GetWord ($text;AT_Inc ;"\t"))))
					aMesHasta{Size of array:C274(aMesHasta)}:=String:C10(Num:C11(ST_GetCleanString (ST_GetWord ($text;AT_Inc ;"\t"))))
					aAño2{Size of array:C274(aAño2)}:=String:C10(Num:C11(ST_GetCleanString (ST_GetWord ($text;AT_Inc ;"\t"))))
					aCtaContable{Size of array:C274(aCtaContable)}:=ST_GetCleanString (ST_GetWord ($text;AT_Inc ;"\t"))
					aCodAux{Size of array:C274(aCodAux)}:=ST_GetCleanString (ST_GetWord ($text;AT_Inc ;"\t"))
					aCentro{Size of array:C274(aCentro)}:=ST_GetCleanString (ST_GetWord ($text;AT_Inc ;"\t"))
					aCCtaContable{Size of array:C274(aCCtaContable)}:=ST_GetCleanString (ST_GetWord ($text;AT_Inc ;"\t"))
					aCCodAux{Size of array:C274(aCCodAux)}:=ST_GetCleanString (ST_GetWord ($text;AT_Inc ;"\t"))
					aCCentro{Size of array:C274(aCCentro)}:=ST_GetCleanString (ST_GetWord ($text;AT_Inc ;"\t"))
					aNoDocTribs{Size of array:C274(aNoDocTribs)}:=ST_GetCleanString (ST_GetWord ($text;AT_Inc ;"\t"))
					aAfectoaDxCta{Size of array:C274(aAfectoaDxCta)}:=ST_GetCleanString (ST_GetWord ($text;AT_Inc ;"\t"))
					aAfectoaDesctos{Size of array:C274(aAfectoaDesctos)}:=ST_GetCleanString (ST_GetWord ($text;AT_Inc ;"\t"))
					aPctInteres{Size of array:C274(aPctInteres)}:=ST_GetCleanString (ST_GetWord ($text;AT_Inc ;"\t"))
					aTipoInteres{Size of array:C274(aTipoInteres)}:=ST_GetCleanString (ST_GetWord ($text;AT_Inc ;"\t"))
					aImpUnica{Size of array:C274(aImpUnica)}:=ST_GetCleanString (ST_GetWord ($text;AT_Inc ;"\t"))
					aDesctoH2{Size of array:C274(aDesctoH2)}:=ST_GetCleanString (ST_GetWord ($text;AT_Inc ;"\t"))
					aDesctoH3{Size of array:C274(aDesctoH3)}:=ST_GetCleanString (ST_GetWord ($text;AT_Inc ;"\t"))
					aDesctoH4{Size of array:C274(aDesctoH4)}:=ST_GetCleanString (ST_GetWord ($text;AT_Inc ;"\t"))
					aDesctoH5{Size of array:C274(aDesctoH5)}:=ST_GetCleanString (ST_GetWord ($text;AT_Inc ;"\t"))
					aDesctoH6{Size of array:C274(aDesctoH6)}:=ST_GetCleanString (ST_GetWord ($text;AT_Inc ;"\t"))
					aDesctoH7{Size of array:C274(aDesctoH7)}:=ST_GetCleanString (ST_GetWord ($text;AT_Inc ;"\t"))
					aDesctoH8{Size of array:C274(aDesctoH8)}:=ST_GetCleanString (ST_GetWord ($text;AT_Inc ;"\t"))
					aDesctoH9{Size of array:C274(aDesctoH9)}:=ST_GetCleanString (ST_GetWord ($text;AT_Inc ;"\t"))
					aDesctoH10{Size of array:C274(aDesctoH10)}:=ST_GetCleanString (ST_GetWord ($text;AT_Inc ;"\t"))
					aDesctoH11{Size of array:C274(aDesctoH11)}:=ST_GetCleanString (ST_GetWord ($text;AT_Inc ;"\t"))
					aDesctoH12{Size of array:C274(aDesctoH12)}:=ST_GetCleanString (ST_GetWord ($text;AT_Inc ;"\t"))
					aDesctoH13{Size of array:C274(aDesctoH13)}:=ST_GetCleanString (ST_GetWord ($text;AT_Inc ;"\t"))
					aDesctoH14{Size of array:C274(aDesctoH14)}:=ST_GetCleanString (ST_GetWord ($text;AT_Inc ;"\t"))
					aDesctoH15{Size of array:C274(aDesctoH15)}:=ST_GetCleanString (ST_GetWord ($text;AT_Inc ;"\t"))
					aDesctoH16{Size of array:C274(aDesctoH16)}:=ST_GetCleanString (ST_GetWord ($text;AT_Inc ;"\t"))
					aDesctoH17{Size of array:C274(aDesctoH17)}:=ST_GetCleanString (ST_GetWord ($text;AT_Inc ;"\t"))
					aCodigo_interno{Size of array:C274(aCodigo_interno)}:=ST_GetCleanString (ST_GetWord ($text;AT_Inc ;"\t"))
					aBloqueadas{Size of array:C274(aBloqueadas)}:=False:C215
					RECEIVE PACKET:C104($ref;$text;$delimiter)
					  //If (r2=1)
					  //$text:=Win to Mac($text)
					  //End if 
					$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;Get document position:C481($ref)/Get document size:C479(vt_g1))
				End while 
				$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
				CLOSE DOCUMENT:C267($ref)
				$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Analizando datos..."))
				For ($i;1;Size of array:C274(aPareo))
					ACTimp_AnalizeData ($i)
					$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aPareo))
				End for 
				$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
				AL_UpdateArrays (xALP_PreImport;-2)
				ACTimp_UpdateInterface 
				vi_PageNumber:=3
				FORM GOTO PAGE:C247(vi_PageNumber)
				POST KEY:C465(Character code:C91("+");256)
			Else 
				CD_Dlog (0;__ ("Imposible abrir el archivo para importar."))
			End if 
			USE CHARACTER SET:C205(*;1)
		Else 
			If (vt_g1=vt_g1Temp)
				vi_PageNumber:=3
				FORM GOTO PAGE:C247(vi_PageNumber)
				POST KEY:C465(Character code:C91("+");256)
			End if 
		End if 
	Else 
		CD_Dlog (0;__ ("No ha indicado la ruta del archivo a importar."))
	End if 
Else 
	vi_PageNumber:=2
	FORM GOTO PAGE:C247(vi_PageNumber)
	POST KEY:C465(Character code:C91("+");256)
End if 