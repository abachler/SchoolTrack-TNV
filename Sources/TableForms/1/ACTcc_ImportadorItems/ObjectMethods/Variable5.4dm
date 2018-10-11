
If (vi_PageNumber=2)
	If (vt_g1#"")
		AL_UpdateArrays (xALP_PreImportItem;0)
		ACTimp_ItemsArrayDelarations 
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
			RECEIVE PACKET:C104($ref;$text;$delimiter)
			
			If ($text="Definiciones de Items de Cargo a@")
				RECEIVE PACKET:C104($ref;$text;$delimiter)
				RECEIVE PACKET:C104($ref;$text;$delimiter)
				RECEIVE PACKET:C104($ref;$text;$delimiter)
			End if 
			
			While ($text#"")
				AT_Insert (0;1;->at_glosa;->at_moneda;->at_monto;->at_EsRelativo;->at_AfectoIva;->at_EnDocTributarios;->at_EsDcto;->at_AfectoDcto;->at_DctoxCta;->at_ItemGlobal;->at_ImputacionUnica;->at_Pcuenta;->at_glosaCta)
				AT_Insert (0;1;->at_Cauxiliar;->at_Ccosto;->at_CPcuenta;->at_glosaCCta;->at_CCauxiliar;->at_CCcosto;->at_AfectoInteres;->at_TipoInteres;->at_TasaMensual;->at_Observacion;->at_VentaDirecta;->at_afectoRecargosAut;->at_MesesActivos)
				AT_Insert (0;1;->at_Dctoxhijo;->at_Dctoxcargastotales;->at_RazonSocial)
				
				at_glosa{Size of array:C274(at_glosa)}:=ST_GetWord ($text;2;"\t")
				at_moneda{Size of array:C274(at_moneda)}:=ST_GetWord ($text;3;"\t")
				at_monto{Size of array:C274(at_monto)}:=ST_GetWord ($text;4;"\t")
				at_EsRelativo{Size of array:C274(at_EsRelativo)}:=ST_GetWord ($text;5;"\t")
				at_AfectoIva{Size of array:C274(at_AfectoIva)}:=ST_GetWord ($text;6;"\t")
				at_EnDocTributarios{Size of array:C274(at_EnDocTributarios)}:=ST_GetWord ($text;7;"\t")
				at_EsDcto{Size of array:C274(at_EsDcto)}:=ST_GetWord ($text;8;"\t")
				at_AfectoDcto{Size of array:C274(at_AfectoDcto)}:=ST_GetWord ($text;9;"\t")
				at_DctoxCta{Size of array:C274(at_DctoxCta)}:=ST_GetWord ($text;10;"\t")
				at_ItemGlobal{Size of array:C274(at_ItemGlobal)}:=ST_GetWord ($text;11;"\t")
				at_ImputacionUnica{Size of array:C274(at_ImputacionUnica)}:=ST_GetWord ($text;12;"\t")
				at_Pcuenta{Size of array:C274(at_Pcuenta)}:=ST_GetWord ($text;13;"\t")
				at_glosaCta{Size of array:C274(at_glosaCta)}:=ST_GetWord ($text;14;"\t")
				at_Cauxiliar{Size of array:C274(at_Cauxiliar)}:=ST_GetWord ($text;15;"\t")
				at_Ccosto{Size of array:C274(at_Ccosto)}:=ST_GetWord ($text;16;"\t")
				at_CPcuenta{Size of array:C274(at_CPcuenta)}:=ST_GetWord ($text;17;"\t")
				at_glosaCCta{Size of array:C274(at_glosaCCta)}:=ST_GetWord ($text;18;"\t")
				at_CCauxiliar{Size of array:C274(at_CCauxiliar)}:=ST_GetWord ($text;19;"\t")
				at_CCcosto{Size of array:C274(at_CCcosto)}:=ST_GetWord ($text;20;"\t")
				at_AfectoInteres{Size of array:C274(at_AfectoInteres)}:=ST_GetWord ($text;21;"\t")
				at_TipoInteres{Size of array:C274(at_TipoInteres)}:=ST_GetWord ($text;22;"\t")
				at_TasaMensual{Size of array:C274(at_TasaMensual)}:=ST_GetWord ($text;23;"\t")
				at_Observacion{Size of array:C274(at_Observacion)}:=ST_GetWord ($text;24;"\t")
				at_VentaDirecta{Size of array:C274(at_VentaDirecta)}:=Replace string:C233(ST_GetWord ($text;25;"\t");"\r";"(salto)")
				at_afectoRecargosAut{Size of array:C274(at_afectoRecargosAut)}:=ST_GetWord ($text;26;"\t")
				at_MesesActivos{Size of array:C274(at_MesesActivos)}:=ST_GetWord ($text;27;"\t")
				at_Dctoxhijo{Size of array:C274(at_Dctoxhijo)}:=ST_GetWord ($text;28;"\t")
				at_Dctoxcargastotales{Size of array:C274(at_Dctoxcargastotales)}:=ST_GetWord ($text;29;"\t")
				at_RazonSocial{Size of array:C274(at_RazonSocial)}:=ST_GetWord ($text;30;"\t")
				
				AT_Insert (0;1;->at_periodoItems)
				AT_Insert (0;1;->at_cccN1;->at_cccN2;->at_cccN3;->at_cccN4;->at_cccN5;->at_cccN6;->at_cccN7;->at_cccN8;->at_cccN9;->at_cccN10;->at_cccN11;->at_cccN12;->at_cccN13;->at_cccN14;->at_cccN15)
				AT_Insert (0;1;->at_ccccN1;->at_ccccN2;->at_ccccN3;->at_ccccN4;->at_ccccN5;->at_ccccN6;->at_ccccN7;->at_ccccN8;->at_ccccN9;->at_ccccN10;->at_ccccN11;->at_ccccN12;->at_ccccN13;->at_ccccN14;->at_ccccN15)
				
				at_periodoItems{Size of array:C274(at_periodoItems)}:=ST_GetWord ($text;31;"\t")  //Periodo
				
				AT_Inc (0)
				AT_Inc (31)
				at_cccN1{Size of array:C274(at_cccN1)}:=ST_GetWord ($text;AT_Inc ;"\t")  //-3 ccc
				at_cccN2{Size of array:C274(at_cccN2)}:=ST_GetWord ($text;AT_Inc ;"\t")  //-2 ccc
				at_cccN3{Size of array:C274(at_cccN3)}:=ST_GetWord ($text;AT_Inc ;"\t")  //-1 ccc
				at_cccN4{Size of array:C274(at_cccN4)}:=ST_GetWord ($text;AT_Inc ;"\t")  //1 ccc
				at_cccN5{Size of array:C274(at_cccN5)}:=ST_GetWord ($text;AT_Inc ;"\t")  //2 ccc
				at_cccN6{Size of array:C274(at_cccN6)}:=ST_GetWord ($text;AT_Inc ;"\t")  //3 ccc
				at_cccN7{Size of array:C274(at_cccN7)}:=ST_GetWord ($text;AT_Inc ;"\t")  //4 ccc
				at_cccN8{Size of array:C274(at_cccN8)}:=ST_GetWord ($text;AT_Inc ;"\t")  //5 ccc
				at_cccN9{Size of array:C274(at_cccN9)}:=ST_GetWord ($text;AT_Inc ;"\t")  //6 ccc
				at_cccN10{Size of array:C274(at_cccN10)}:=ST_GetWord ($text;AT_Inc ;"\t")  //7 ccc
				at_cccN11{Size of array:C274(at_cccN11)}:=ST_GetWord ($text;AT_Inc ;"\t")  //8 ccc
				at_cccN12{Size of array:C274(at_cccN12)}:=ST_GetWord ($text;AT_Inc ;"\t")  //9 ccc
				at_cccN13{Size of array:C274(at_cccN13)}:=ST_GetWord ($text;AT_Inc ;"\t")  //10 ccc
				at_cccN14{Size of array:C274(at_cccN14)}:=ST_GetWord ($text;AT_Inc ;"\t")  //11 ccc
				at_cccN15{Size of array:C274(at_cccN15)}:=ST_GetWord ($text;AT_Inc ;"\t")  //12 ccc
				
				at_ccccN1{Size of array:C274(at_cccN1)}:=ST_GetWord ($text;AT_Inc ;"\t")  //-3 cccc
				at_ccccN2{Size of array:C274(at_cccN2)}:=ST_GetWord ($text;AT_Inc ;"\t")  //-2 cccc
				at_ccccN3{Size of array:C274(at_cccN3)}:=ST_GetWord ($text;AT_Inc ;"\t")  //-1 cccc
				at_ccccN4{Size of array:C274(at_cccN4)}:=ST_GetWord ($text;AT_Inc ;"\t")  //1 cccc
				at_ccccN5{Size of array:C274(at_cccN5)}:=ST_GetWord ($text;AT_Inc ;"\t")  //2 cccc
				at_ccccN6{Size of array:C274(at_cccN6)}:=ST_GetWord ($text;AT_Inc ;"\t")  //3 cccc
				at_ccccN7{Size of array:C274(at_cccN7)}:=ST_GetWord ($text;AT_Inc ;"\t")  //4 cccc
				at_ccccN8{Size of array:C274(at_cccN8)}:=ST_GetWord ($text;AT_Inc ;"\t")  //5 cccc
				at_ccccN9{Size of array:C274(at_cccN9)}:=ST_GetWord ($text;AT_Inc ;"\t")  //6 cccc
				at_ccccN10{Size of array:C274(at_cccN10)}:=ST_GetWord ($text;AT_Inc ;"\t")  //7 cccc
				at_ccccN11{Size of array:C274(at_cccN11)}:=ST_GetWord ($text;AT_Inc ;"\t")  //8 cccc
				at_ccccN12{Size of array:C274(at_cccN12)}:=ST_GetWord ($text;AT_Inc ;"\t")  //9 cccc
				at_ccccN13{Size of array:C274(at_cccN13)}:=ST_GetWord ($text;AT_Inc ;"\t")  //10 cccc
				at_ccccN14{Size of array:C274(at_cccN14)}:=ST_GetWord ($text;AT_Inc ;"\t")  //11 cccc
				at_ccccN15{Size of array:C274(at_cccN15)}:=ST_GetWord ($text;AT_Inc ;"\t")  //12 cccc
				
				RECEIVE PACKET:C104($ref;$text;$delimiter)
				$text:=Replace string:C233($text;Char:C90(10);"")
				$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;Get document position:C481($ref)/Get document size:C479(vt_g1))
			End while 
			
			$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
			CLOSE DOCUMENT:C267($ref)
			AL_UpdateArrays (xALP_PreImportItem;-2)
			
			For ($i;1;Size of array:C274(at_glosa))
				If (at_glosa{$i}#"")
					AL_SetRowStyle (xALP_PreImportItem;$i;0;"")
					AL_SetRowColor (xALP_PreImportItem;$i;"Black";0;"";0)
				Else 
					AL_SetRowStyle (xALP_PreImportItem;$i;1;"")
					AL_SetRowColor (xALP_PreImportItem;$i;"Red";0;"";0)
				End if 
				
				ARRAY INTEGER:C220($aInteger2D;2;0)
				If (at_glosa{$i}#"")
					AL_SetCellEnter (xALP_PreImportItem;19;$i;39;$i;$aInteger2D;0)
				Else 
					AL_SetCellEnter (xALP_PreImportItem;19;$i;39;$i;$aInteger2D;1)
				End if 
			End for 
			
			vi_PageNumber:=3
			vi_Step:=3
			FORM GOTO PAGE:C247(vi_PageNumber)
			
		Else 
			CD_Dlog (0;__ ("Imposible abrir el archivo para importar."))
		End if 
		USE CHARACTER SET:C205(*;1)
		
	Else 
		If (vb_manual)
			vi_PageNumber:=3
			FORM GOTO PAGE:C247(vi_PageNumber)
		Else 
			CD_Dlog (0;__ ("No ha indicado la ruta del archivo a importar."))
		End if 
	End if 
Else 
	vi_PageNumber:=2
	vi_Step:=2
	FORM GOTO PAGE:C247(vi_PageNumber)
End if 
REDRAW WINDOW:C456
