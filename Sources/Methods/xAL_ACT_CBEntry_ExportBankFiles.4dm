//%attributes = {}
  //xAL_ACT_CBEntry_ExportBankFiles

C_LONGINT:C283($1;$2;$3)
C_LONGINT:C283($col;$line)
  //alProEvt:=AL_GetLine ($1)
AL_GetCurrCell ($1;$col;$line)
REDRAW WINDOW:C456
AT_Initialize (->atACT_FormatExp)
Case of 
	: (xALP_ExportBankFiles=$1)  //registrosdel cuerpo
		If (PWTrf_Ptb1=1)  //archivo bancarios
			Case of 
				: ($col=3)
					IT_SetButtonState (False:C215;->bSubirLineaExp;->bBajarLineaExp;->bDeleteLine;->bInsertLine)
				: ($col=4)
					IT_SetButtonState (False:C215;->bSubirLineaExp;->bBajarLineaExp;->bDeleteLine;->bInsertLine)
				: ($col=5)
					IT_SetButtonState (False:C215;->bSubirLineaExp;->bBajarLineaExp;->bDeleteLine;->bInsertLine)
				: ($col=6)
					C_POINTER:C301($ptrCampo)
					C_LONGINT:C283($vl_recordTablePointersExpTemp)
					C_LONGINT:C283($vl_recordFieldPointersExpTemp)
					If (at_Descripcion{$line}#"")
						$index:=Find in array:C230(at_DescripcionExp;at_Descripcion{$line})
						If ($index>0)
							If (vlACT_id_modo_pago=-9)  //PAT
								$l_indice:=3
							Else 
								$l_indice:=2
							End if 
							If ($index<=$l_indice)  //para valores calculados TEXTO FIJO
								If ($index=2)
									APPEND TO ARRAY:C911(atACT_FormatExp;"Día Juliano a fecha de Generación del archivo")
									APPEND TO ARRAY:C911(atACT_FormatExp;"Día Juliano a fecha de Emisión del aviso")
									APPEND TO ARRAY:C911(atACT_FormatExp;"Día Juliano a fecha de Vencimiento del aviso")
								End if 
							Else 
								$vl_recordTablePointersExpTemp:=Table:C252(aRecordFieldPointersExp{$index})
								$vl_recordFieldPointersExpTemp:=Field:C253(aRecordFieldPointersExp{$index})
								$ptrCampo:=Field:C253($vl_recordTablePointersExpTemp;$vl_recordFieldPointersExpTemp)
								Case of 
									: (Type:C295($ptrCampo->)=4)  //campos fecha
										  //AT_Insert (1;8;->atACT_FormatExp)
										APPEND TO ARRAY:C911(atACT_FormatExp;"ddmmaaaa")
										APPEND TO ARRAY:C911(atACT_FormatExp;"ddmmaa")
										APPEND TO ARRAY:C911(atACT_FormatExp;"aaaammdd")
										APPEND TO ARRAY:C911(atACT_FormatExp;"aammdd")
										APPEND TO ARRAY:C911(atACT_FormatExp;"mmddaa")
										APPEND TO ARRAY:C911(atACT_FormatExp;"mmddaaaa")
										APPEND TO ARRAY:C911(atACT_FormatExp;"ddmmaaaa Local")
										APPEND TO ARRAY:C911(atACT_FormatExp;"ddmmaa Local")
										APPEND TO ARRAY:C911(atACT_FormatExp;"aaaammdd Local")
										APPEND TO ARRAY:C911(atACT_FormatExp;"aammdd Local")
										APPEND TO ARRAY:C911(atACT_FormatExp;"mmddaa Local")
										APPEND TO ARRAY:C911(atACT_FormatExp;"mmddaaaa Local")
										APPEND TO ARRAY:C911(atACT_FormatExp;"día")
										APPEND TO ARRAY:C911(atACT_FormatExp;"mes")
										APPEND TO ARRAY:C911(atACT_FormatExp;"año")
									: ((Type:C295($ptrCampo->)=24) | (Type:C295($ptrCampo->)=2) | (Type:C295($ptrCampo->)=0))  //campos texto
										If (((Table:C252($ptrCampo)=Table:C252(->[Personas:7]RUT:6)) & (Field:C253($ptrCampo)=Field:C253(->[Personas:7]RUT:6))) | ((Table:C252($ptrCampo)=Table:C252(->[Personas:7]ACT_RUTTitular_TC:56)) & (Field:C253($ptrCampo)=Field:C253(->[Personas:7]ACT_RUTTitular_TC:56))) | ((Table:C252($ptrCampo)=Table:C252(->[Personas:7]ACT_RUTTitutal_Cta:50)) & (Field:C253($ptrCampo)=Field:C253(->[Personas:7]ACT_RUTTitutal_Cta:50))))
											AT_Insert (1;13;->atACT_FormatExp)
											atACT_FormatExp{1}:="Sin formato"
											atACT_FormatExp{2}:="Rut con guión"
											atACT_FormatExp{3}:="Rut sin Guión"
											atACT_FormatExp{4}:="Reemplazar guión por espacio"
											atACT_FormatExp{5}:="Sólo dígito Verificador"
											atACT_FormatExp{6}:="Rut sin dígito verificador"
											atACT_FormatExp{7}:="Rut con formato"
											atACT_FormatExp{8}:="Entre comillas rut con guión"
											atACT_FormatExp{9}:="Entre comillas rut sin guión"
											atACT_FormatExp{10}:="Entre comillas reemplazar guión por espacio"
											atACT_FormatExp{11}:="Entre comillas sólo dígito verificador"
											atACT_FormatExp{12}:="Entre comillas rut sin dígito verificador"
											atACT_FormatExp{13}:="Entre comillas rut con formato"
										Else 
											If (((Table:C252($ptrCampo)=Table:C252(->[Personas:7]ACT_AñoVenc_TC:58)) & (Field:C253($ptrCampo)=Field:C253(->[Personas:7]ACT_AñoVenc_TC:58))) | ((Table:C252($ptrCampo)=Table:C252(->[Personas:7]ACT_MesVenc_TC:57)) & (Field:C253($ptrCampo)=Field:C253(->[Personas:7]ACT_MesVenc_TC:57))))
												AT_Insert (1;10;->atACT_FormatExp)
												atACT_FormatExp{1}:="mm+slash+aa"
												atACT_FormatExp{2}:="mm+slash+aaaa"
												atACT_FormatExp{3}:="aa+slash+mm"
												atACT_FormatExp{4}:="aaaa+slash+mm"
												atACT_FormatExp{5}:="mm+guión+aa"
												atACT_FormatExp{6}:="mm+guión+aaaa"
												atACT_FormatExp{7}:="aa+guión+mm"
												atACT_FormatExp{8}:="aaaa+guión+mm"
												atACT_FormatExp{9}:="aamm"
												atACT_FormatExp{10}:="mmaa"
											Else 
												AT_Insert (1;6;->atACT_FormatExp)
												atACT_FormatExp{1}:="Sin formato"
												atACT_FormatExp{2}:="Texto entre comillas"  //9
												atACT_FormatExp{3}:="Texto sin puntos ni guiones"  //10
												atACT_FormatExp{4}:="Entre comillas texto sin puntos ni guiones"  //10
												atACT_FormatExp{5}:="Texto sin puntos, comas ni guiones"
												atACT_FormatExp{6}:="Entre comillas texto sin puntos, comas ni guiones"
												APPEND TO ARRAY:C911(atACT_FormatExp;"Texto en mayúsculas")
											End if 
										End if 
									: ((Type:C295($ptrCampo->)=1) | (Type:C295($ptrCampo->)=8) | (Type:C295($ptrCampo->)=9))  //campos montos
										If (((Table:C252($ptrCampo)=Table:C252(->[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14)) & (Field:C253($ptrCampo)=Field:C253(->[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14))) | ((Table:C252($ptrCampo)=Table:C252(->[ACT_Avisos_de_Cobranza:124]Monto_Neto:11)) & (Field:C253($ptrCampo)=Field:C253(->[ACT_Avisos_de_Cobranza:124]Monto_Neto:11))))
											Case of 
												: (viTypeFile="CUP")
													AT_Insert (1;10;->atACT_FormatExp)
													atACT_FormatExp{1}:="Sin formato"
													atACT_FormatExp{2}:="Monto con 2 decimales"
													atACT_FormatExp{3}:="Monto con 4 decimales"
													atACT_FormatExp{4}:="Monto con 2 decimales con separador"
													atACT_FormatExp{5}:="Monto con 4 decimales con separador"
													atACT_FormatExp{6}:="Monto total"
													atACT_FormatExp{7}:="Monto total con 2 decimales"
													atACT_FormatExp{8}:="Monto total con 4 decimales"
													atACT_FormatExp{9}:="Monto total con 2 decimales con separador"
													atACT_FormatExp{10}:="Monto total con 4 decimales con separador"
													
												Else 
													AT_Insert (1;5;->atACT_FormatExp)
													atACT_FormatExp{1}:="Sin formato"
													atACT_FormatExp{2}:="Monto con 2 decimales"
													atACT_FormatExp{3}:="Monto con 4 decimales"
													atACT_FormatExp{4}:="Monto con 2 decimales con separador"
													atACT_FormatExp{5}:="Monto con 4 decimales con separador"
											End case 
										Else 
											If ((Table:C252($ptrCampo)=Table:C252(->[Personas:7]ACT_DiaCargo:61)) & (Field:C253($ptrCampo)=Field:C253(->[Personas:7]ACT_DiaCargo:61)))
												APPEND TO ARRAY:C911(atACT_FormatExp;"dd")
												APPEND TO ARRAY:C911(atACT_FormatExp;"ddmm")
												APPEND TO ARRAY:C911(atACT_FormatExp;"mmdd")
												APPEND TO ARRAY:C911(atACT_FormatExp;"ddmmaaaa")
												APPEND TO ARRAY:C911(atACT_FormatExp;"ddmmaa")
												APPEND TO ARRAY:C911(atACT_FormatExp;"aaaammdd")
												APPEND TO ARRAY:C911(atACT_FormatExp;"aammdd")
												APPEND TO ARRAY:C911(atACT_FormatExp;"mmddaa")
												APPEND TO ARRAY:C911(atACT_FormatExp;"mmddaaaa")
												APPEND TO ARRAY:C911(atACT_FormatExp;"ddmmaaaa Local")
												APPEND TO ARRAY:C911(atACT_FormatExp;"ddmmaa Local")
												APPEND TO ARRAY:C911(atACT_FormatExp;"aaaammdd Local")
												APPEND TO ARRAY:C911(atACT_FormatExp;"aammdd Local")
												APPEND TO ARRAY:C911(atACT_FormatExp;"mmddaa Local")
												APPEND TO ARRAY:C911(atACT_FormatExp;"mmddaaaa Local")
											End if 
										End if 
								End case 
							End if 
						End if 
					End if 
					
					AL_SetEnterable (xALP_ExportBankFiles;6;2;atACT_FormatExp)  //6 FORMATO
					AL_UpdateArrays (xALP_ExportBankFiles;-2)
				: ($col=9)
					IT_SetButtonState (False:C215;->bSubirLineaExp;->bBajarLineaExp;->bDeleteLine;->bInsertLine)
			End case 
		Else   //contabilidad
			Case of 
				: ($col=6)
					C_POINTER:C301($ptrCampo)
					C_LONGINT:C283($vl_recordTablePointersExpTemp)
					C_LONGINT:C283($vl_recordFieldPointersExpTemp)
					If (at_Descripcion{$line}#"")
						$index:=Find in array:C230(at_DescripcionExp;at_Descripcion{$line})
						If ($index>0)
							ARRAY TEXT:C222(atACTtrf_DescripcionExp;0)
							ACTtrf_Master (7;"atACTtrf_DescripcionExp")
							If ($index<=Size of array:C274(atACTtrf_DescripcionExp))  //para valores calculados' REVISAR BOTÖN GUIARDAR DE WizardO, línea 7
								Case of 
									: ((at_Descripcion{$line}="Fecha actual") | (at_Descripcion{$line}="Fecha referencia documento") | (at_Descripcion{$line}="Fecha vencimiento documento"))  //encabezado
										APPEND TO ARRAY:C911(atACT_FormatExp;"ddmmaaaa")  //1
										APPEND TO ARRAY:C911(atACT_FormatExp;"ddmmaa")  //2
										APPEND TO ARRAY:C911(atACT_FormatExp;"ddmmaaaa Local")
										APPEND TO ARRAY:C911(atACT_FormatExp;"ddmmaa Local")
										APPEND TO ARRAY:C911(atACT_FormatExp;"aaaammdd")  //3
										APPEND TO ARRAY:C911(atACT_FormatExp;"aammdd")  //4
										APPEND TO ARRAY:C911(atACT_FormatExp;"aaaammdd Local")
										APPEND TO ARRAY:C911(atACT_FormatExp;"aammdd Local")
										APPEND TO ARRAY:C911(atACT_FormatExp;"mmddaa")
										APPEND TO ARRAY:C911(atACT_FormatExp;"mmddaaaa")
										APPEND TO ARRAY:C911(atACT_FormatExp;"mmddaa Local")
										APPEND TO ARRAY:C911(atACT_FormatExp;"mmddaaaa Local")
									Else 
										AT_Insert (1;6;->atACT_FormatExp)
										atACT_FormatExp{1}:="Sin formato"
										atACT_FormatExp{2}:="Texto entre comillas"
										atACT_FormatExp{3}:="Texto sin puntos ni guiones"
										atACT_FormatExp{4}:="Entre comillas texto sin puntos ni guiones"
										atACT_FormatExp{5}:="Texto sin puntos, comas ni guiones"
										atACT_FormatExp{6}:="Entre comillas texto sin puntos, comas ni guiones"
										APPEND TO ARRAY:C911(atACT_FormatExp;"Texto en mayúsculas")
								End case 
							Else 
								$vl_recordTablePointersExpTemp:=Table:C252(aRecordFieldPointersExp{$index})
								$vl_recordFieldPointersExpTemp:=Field:C253(aRecordFieldPointersExp{$index})
								$ptrCampo:=Field:C253($vl_recordTablePointersExpTemp;$vl_recordFieldPointersExpTemp)
								Case of 
									: (Type:C295($ptrCampo->)=4)  //campos fecha
										APPEND TO ARRAY:C911(atACT_FormatExp;"ddmmaaaa")  //1
										APPEND TO ARRAY:C911(atACT_FormatExp;"ddmmaa")  //2
										APPEND TO ARRAY:C911(atACT_FormatExp;"ddmmaaaa Local")
										APPEND TO ARRAY:C911(atACT_FormatExp;"ddmmaa Local")
										APPEND TO ARRAY:C911(atACT_FormatExp;"aaaammdd")  //3
										APPEND TO ARRAY:C911(atACT_FormatExp;"aammdd")  //4
										APPEND TO ARRAY:C911(atACT_FormatExp;"aaaammdd Local")
										APPEND TO ARRAY:C911(atACT_FormatExp;"aammdd Local")
										APPEND TO ARRAY:C911(atACT_FormatExp;"DM")
										APPEND TO ARRAY:C911(atACT_FormatExp;"mmddaa")
										APPEND TO ARRAY:C911(atACT_FormatExp;"mmddaaaa")
										APPEND TO ARRAY:C911(atACT_FormatExp;"mmddaa Local")
										APPEND TO ARRAY:C911(atACT_FormatExp;"mmddaaaa Local")
										APPEND TO ARRAY:C911(atACT_FormatExp;"día")
										APPEND TO ARRAY:C911(atACT_FormatExp;"mes")
										APPEND TO ARRAY:C911(atACT_FormatExp;"año")
										
									: (((Table:C252($ptrCampo)=Table:C252(->[Personas:7]ACT_RUTTitutal_Cta:50)) & (Field:C253($ptrCampo)=Field:C253(->[Personas:7]ACT_RUTTitutal_Cta:50))) | ((Table:C252($ptrCampo)=Table:C252(->[Personas:7]ACT_RUTTitular_TC:56)) & (Field:C253($ptrCampo)=Field:C253(->[Personas:7]ACT_RUTTitular_TC:56))) | ((Table:C252($ptrCampo)=Table:C252(->[Personas:7]RUT:6)) & (Field:C253($ptrCampo)=Field:C253(->[Personas:7]RUT:6))))
										AT_Insert (1;13;->atACT_FormatExp)
										atACT_FormatExp{1}:="Sin formato"
										atACT_FormatExp{2}:="Rut con guión"
										atACT_FormatExp{3}:="Rut sin Guión"
										atACT_FormatExp{4}:="Reemplazar guión por espacio"
										atACT_FormatExp{5}:="Sólo dígito Verificador"
										atACT_FormatExp{6}:="Rut sin dígito verificador"
										atACT_FormatExp{7}:="Rut con formato"
										atACT_FormatExp{8}:="Entre comillas rut con guión"
										atACT_FormatExp{9}:="Entre comillas rut sin guión"
										atACT_FormatExp{10}:="Entre comillas reemplazar guión por espacio"
										atACT_FormatExp{11}:="Entre comillas sólo dígito verificador"
										atACT_FormatExp{12}:="Entre comillas rut sin dígito verificador"
										atACT_FormatExp{13}:="Entre comillas rut con formato"
									Else 
										AT_Insert (1;6;->atACT_FormatExp)
										atACT_FormatExp{1}:="Sin formato"
										atACT_FormatExp{2}:="Texto entre comillas"  //9
										atACT_FormatExp{3}:="Texto sin puntos ni guiones"  //10
										atACT_FormatExp{4}:="Entre comillas texto sin puntos ni guiones"  //10
										atACT_FormatExp{5}:="Texto sin puntos, comas ni guiones"
										atACT_FormatExp{6}:="Entre comillas texto sin puntos, comas ni guiones"
										APPEND TO ARRAY:C911(atACT_FormatExp;"Texto en mayúsculas")
										  //AL_SetEnterable (xALP_ExportBankFiles;6;2;atACT_FormatExp)  `6 FORMATO
								End case 
							End if 
							AL_SetEnterable (xALP_ExportBankFiles;6;2;atACT_FormatExp)  //6 FORMATO
						End if 
					End if 
			End case 
		End if 
		AL_UpdateArrays (xALP_ExportBankFiles;-2)
	: (xALP_ExportBankFilesH=$1)  //registros del header
		Case of 
			: ($col=3)
				IT_SetButtonState (False:C215;->bSubirLineaExp;->bBajarLineaExp;->bDeleteLine;->bInsertLine)
			: ($col=4)
				IT_SetButtonState (False:C215;->bSubirLineaExp;->bBajarLineaExp;->bDeleteLine;->bInsertLine)
			: ($col=5)
				IT_SetButtonState (False:C215;->bSubirLineaExp;->bBajarLineaExp;->bDeleteLine;->bInsertLine)
			: ($col=9)
				IT_SetButtonState (False:C215;->bSubirLineaExp;->bBajarLineaExp;->bDeleteLine;->bInsertLine)
		End case 
		Case of 
			: ((at_DescripcionHe{$line}="Fecha actual") | (at_DescripcionHe{$line}="Fecha de información -sólo PAC-") | (at_DescripcionHe{$line}="Fecha vencimiento primer aviso de cobranza"))  //encabezado
				APPEND TO ARRAY:C911(atACT_FormatExp;"ddmmaaaa")  //1
				APPEND TO ARRAY:C911(atACT_FormatExp;"ddmmaa")  //2
				APPEND TO ARRAY:C911(atACT_FormatExp;"ddmmaaaa Local")
				APPEND TO ARRAY:C911(atACT_FormatExp;"ddmmaa Local")
				APPEND TO ARRAY:C911(atACT_FormatExp;"aaaammdd")  //3
				APPEND TO ARRAY:C911(atACT_FormatExp;"aammdd")  //4
				APPEND TO ARRAY:C911(atACT_FormatExp;"aaaammdd Local")
				APPEND TO ARRAY:C911(atACT_FormatExp;"aammdd Local")
				APPEND TO ARRAY:C911(atACT_FormatExp;"mmddaa")
				APPEND TO ARRAY:C911(atACT_FormatExp;"mmddaaaa")
				APPEND TO ARRAY:C911(atACT_FormatExp;"mmddaa Local")
				APPEND TO ARRAY:C911(atACT_FormatExp;"mmddaaaa Local")
			: (at_DescripcionHe{$line}="Suma total de las trasacciones")
				AT_Insert (1;5;->atACT_FormatExp)
				atACT_FormatExp{1}:="Sin formato"
				atACT_FormatExp{2}:="Monto con 2 decimales"
				atACT_FormatExp{3}:="Monto con 4 decimales"
				atACT_FormatExp{4}:="Monto con 2 decimales con separador"
				atACT_FormatExp{5}:="Monto con 4 decimales con separador"
				
			: (at_DescripcionHe{$line}="Día Juliano")
				APPEND TO ARRAY:C911(atACT_FormatExp;"Día Juliano a fecha de Generación del archivo")
				
			: (at_DescripcionHe{$line}#"Texto Fijo")
				AT_Insert (1;6;->atACT_FormatExp)
				atACT_FormatExp{1}:="Sin formato"
				atACT_FormatExp{2}:="Texto entre comillas"  //9
				atACT_FormatExp{3}:="Texto sin puntos ni guiones"  //10
				atACT_FormatExp{4}:="Entre comillas texto sin puntos ni guiones"  //10
				atACT_FormatExp{5}:="Texto sin puntos, comas ni guiones"
				atACT_FormatExp{6}:="Entre comillas texto sin puntos, comas ni guiones"
				APPEND TO ARRAY:C911(atACT_FormatExp;"Texto en mayúsculas")
			Else 
		End case 
		AL_SetEnterable (xALP_ExportBankFilesH;6;2;atACT_FormatExp)  //6 FORMATO
		AL_UpdateArrays (xALP_ExportBankFilesH;-2)
	: (xALP_ExportBankFilesF=$1)  //registros del footer
		Case of 
			: ($col=3)
				IT_SetButtonState (False:C215;->bSubirLineaExp;->bBajarLineaExp;->bDeleteLine;->bInsertLine)
			: ($col=4)
				IT_SetButtonState (False:C215;->bSubirLineaExp;->bBajarLineaExp;->bDeleteLine;->bInsertLine)
			: ($col=5)
				IT_SetButtonState (False:C215;->bSubirLineaExp;->bBajarLineaExp;->bDeleteLine;->bInsertLine)
			: ($col=9)
				IT_SetButtonState (False:C215;->bSubirLineaExp;->bBajarLineaExp;->bDeleteLine;->bInsertLine)
		End case 
		Case of 
			: ((at_DescripcionFo{$line}="Fecha actual") | (at_DescripcionFo{$line}="Fecha de información -sólo PAC-"))
				APPEND TO ARRAY:C911(atACT_FormatExp;"ddmmaaaa")  //1
				APPEND TO ARRAY:C911(atACT_FormatExp;"ddmmaa")  //2
				APPEND TO ARRAY:C911(atACT_FormatExp;"ddmmaaaa Local")
				APPEND TO ARRAY:C911(atACT_FormatExp;"ddmmaa Local")
				APPEND TO ARRAY:C911(atACT_FormatExp;"aaaammdd")  //3
				APPEND TO ARRAY:C911(atACT_FormatExp;"aammdd")  //4
				APPEND TO ARRAY:C911(atACT_FormatExp;"aaaammdd Local")
				APPEND TO ARRAY:C911(atACT_FormatExp;"aammdd Local")
				APPEND TO ARRAY:C911(atACT_FormatExp;"mmddaa")
				APPEND TO ARRAY:C911(atACT_FormatExp;"mmddaaaa")
				APPEND TO ARRAY:C911(atACT_FormatExp;"mmddaa Local")
				APPEND TO ARRAY:C911(atACT_FormatExp;"mmddaaaa Local")
			: (at_DescripcionFo{$line}="Suma total de las trasacciones")
				AT_Insert (1;5;->atACT_FormatExp)
				atACT_FormatExp{1}:="Sin formato"
				atACT_FormatExp{2}:="Monto con 2 decimales"
				atACT_FormatExp{3}:="Monto con 4 decimales"
				atACT_FormatExp{4}:="Monto con 2 decimales con separador"
				atACT_FormatExp{5}:="Monto con 4 decimales con separador"
			: (at_DescripcionFo{$line}="Día Juliano")
				APPEND TO ARRAY:C911(atACT_FormatExp;"Día Juliano a fecha de Generación del archivo")
			: (at_DescripcionFo{$line}#"Texto Fijo")
				AT_Insert (1;6;->atACT_FormatExp)
				atACT_FormatExp{1}:="Sin formato"
				atACT_FormatExp{2}:="Texto entre comillas"  //9
				atACT_FormatExp{3}:="Texto sin puntos ni guiones"  //10
				atACT_FormatExp{4}:="Entre comillas texto sin puntos ni guiones"  //10
				atACT_FormatExp{5}:="Texto sin puntos, comas ni guiones"
				atACT_FormatExp{6}:="Entre comillas texto sin puntos, comas ni guiones"
				APPEND TO ARRAY:C911(atACT_FormatExp;"Texto en mayúsculas")
				
			Else 
		End case 
		AL_SetEnterable (xALP_ExportBankFilesF;6;2;atACT_FormatExp)  //6 FORMATO
		AL_UpdateArrays (xALP_ExportBankFilesF;-2)
End case 