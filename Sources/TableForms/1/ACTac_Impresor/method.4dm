C_LONGINT:C283($table)

Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		ACTinit_LoadPrefs 
		ACTcfg_LoadPrinters 
		_O_DISABLE BUTTON:C193(bPrev)
		  //If (Num(ACTcfg_OpcionesTextoMail ("ValidaRBD"))=1)
		  //OBJECT SET VISIBLE(*;"grange@";False)
		  //End if 
		
		vi_PageNumber:=1
		vi_step:=1
		
		  // defectos pagina 2 (emision/impresión)
		b1:=1
		b2:=0
		OBJECT SET TITLE:C194(bEmitir;__ ("Imprimir avisos"))
		  //$mailLic:=DL_IsModuleLicensed (1;CommTrack Light) & (b2=1)
		
		OBJECT SET ENABLED:C1123(bPDF2Mail;True:C214)
		
		  // defectos pagina 3 (periodos y modelo de impresión)
		ACTac_OpcionesGenerales ("CargaModelosDeInforme")
		
		xALSet_ACT_ModelosEmision 
		AL_SetLine (xALP_SelModeloAviso;0)
		
		OBJECT SET VISIBLE:C603(*;"print@";(b1=1))
		OBJECT SET VISIBLE:C603(*;"mail@";(b2=1))
		
		  // defectos página 4 (seleccion del universo)
		
		ACTac_ImpresorUniverso 
		
		Case of 
			: (Table:C252(yBWR_currentTable)#Table:C252(->[ACT_Avisos_de_Cobranza:124]))
				f1:=0
				f2:=0
				f3:=1
				_O_DISABLE BUTTON:C193(f1)
				_O_DISABLE BUTTON:C193(f2)
				CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"Selection")
				viACT_avisos3:=Records in selection:C76([ACT_Avisos_de_Cobranza:124])
			: (Size of array:C274(aBrSelect)>0)
				f1:=1
				f2:=0
				f3:=0
				$set:="$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable))
				USE SET:C118($set)
				BWR_SearchRecords 
				CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"Selection")
				viACT_avisos1:=Records in selection:C76([ACT_Avisos_de_Cobranza:124])
			: (Records in set:C195("$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable)))>0)
				f1:=0
				f2:=1
				f3:=0
				$set:="$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable))
				USE SET:C118($set)
				CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"Selection")
				viACT_avisos2:=Records in selection:C76([ACT_Avisos_de_Cobranza:124])
			Else 
				f1:=0
				f2:=0
				f3:=1
				_O_DISABLE BUTTON:C193(f1)
				_O_DISABLE BUTTON:C193(f2)
				CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"Selection")
				viACT_avisos3:=Records in table:C83([ACT_Avisos_de_Cobranza:124])
		End case 
		
		Case of 
			: (f1=1)
				viACT_avisos:=viACT_avisos1
			: (f2=1)
				viACT_avisos:=viACT_avisos2
			: (f3=1)
				viACT_avisos:=viACT_avisos3
		End case 
		
		C_REAL:C285(r_opMail1_AC;r_opMail2_AA;r_opMail3_Ambos)
		r_opMail1_AC:=Num:C11(PREF_fGet (0;"ACT_EnvioPDFAC_AC";"1"))
		r_opMail2_AA:=Num:C11(PREF_fGet (0;"ACT_EnvioPDFAC_AA";"0"))
		r_opMail3_Ambos:=Num:C11(PREF_fGet (0;"ACT_EnvioPDFAC_Ambos";"0"))
		
		  //para mostrar opciones de responsable
		C_REAL:C285(cs_opMail1_AC;cs_opMail2_AA;cs_opMail3Responsable)
		cs_opMail1_AC:=Num:C11(((r_opMail1_AC=1) | (r_opMail3_Ambos=1)))
		cs_opMail2_AA:=Num:C11(((r_opMail2_AA=1) | (r_opMail3_Ambos=1)))
		cs_opMail1_AC:=Num:C11(PREF_fGet (0;"ACT_EnvioPDFAC_AC_Casilla";String:C10(cs_opMail1_AC)))
		cs_opMail2_AA:=Num:C11(PREF_fGet (0;"ACT_EnvioPDFAC_AA_Casilla";String:C10(cs_opMail2_AA)))
		cs_opMail3Responsable:=Num:C11(PREF_fGet (0;"ACT_EnvioPDFAC_AResponsable";"0"))
		
		
		OBJECT SET VISIBLE:C603(*;"r_opMail@";cb_SepararCargosXPct=0)
		OBJECT SET VISIBLE:C603(*;"cs_opMail@";cb_SepararCargosXPct=1)
		
		OBJECT SET ENABLED:C1123(*;"r_opMail@";(bPDF2Mail=1))
		OBJECT SET ENABLED:C1123(*;"cs_opMail@";(bPDF2Mail=1))
		
	: ((Form event:C388=On Clicked:K2:4) | (Form event:C388=On Data Change:K2:15))
		  //If (b2=0)
		  //bOnlyPDF:=0
		  //DISABLE BUTTON(bOnlyPDF)
		  //Else 
		  //ENABLE BUTTON(bOnlyPDF)
		  //End if 
		C_LONGINT:C283($l_page)
		$l_page:=FORM Get current page:C276
		Case of 
			: ($l_page=2)
				
				OBJECT SET ENABLED:C1123(*;"r_opMail@";(bPDF2Mail=1))
				OBJECT SET ENABLED:C1123(*;"cs_opMail@";(bPDF2Mail=1))
				
				If (bPDF2Mail=1)
					If ((r_opMail1_AC=0) & (r_opMail2_AA=0) & (r_opMail3_Ambos=0))
						r_opMail1_AC:=1
					End if 
					
					If ((cs_opMail1_AC=0) & (cs_opMail2_AA=0) & (cs_opMail3Responsable=0))
						cs_opMail1_AC:=1
					End if 
				End if 
				
				PREF_Set (0;"ACT_EnvioPDFAC_AC";String:C10(r_opMail1_AC))
				PREF_Set (0;"ACT_EnvioPDFAC_AA";String:C10(r_opMail2_AA))
				PREF_Set (0;"ACT_EnvioPDFAC_Ambos";String:C10(r_opMail3_Ambos))
				
				PREF_Set (0;"ACT_EnvioPDFAC_AC_Casilla";String:C10(cs_opMail1_AC))
				PREF_Set (0;"ACT_EnvioPDFAC_AA_Casilla";String:C10(cs_opMail2_AA))
				PREF_Set (0;"ACT_EnvioPDFAC_AResponsable";String:C10(cs_opMail3Responsable))
				
		End case 
		
	: (Form event:C388=On Unload:K2:2)
		
	: ((vi_PageNumber=4) & (viACT_avisos=0))
		_O_DISABLE BUTTON:C193(bNext)
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event:C388=On Outside Call:K2:11)
		XS_SetInterface 
		ALP_SetInterface (xALP_SelModeloAviso)
		
End case 
