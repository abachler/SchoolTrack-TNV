//%attributes = {}
  //ACTabc_ExportCUPStMargarets

C_TEXT:C284($2;$3)  //No incluir en archivo de exportacion!!!

vFechaCUP:=String:C10(Current date:C33(*);7)
vtotalCUP:=""
vnumTransCUP:=""

ACTabc_SelectionItem2Export 
If (vb_continuarExport)
	vVerifier:="ColegiumTransferFile"
	vType:="exporter"
	ARRAY INTEGER:C220(aInt1;0)
	C_LONGINT:C283($j;$max)
	C_LONGINT:C283($el)
	C_TEXT:C284($fileName;$text;$fecha1;$fecha;$fecha2;$vt_comuna)
	C_LONGINT:C283($i;vl_idUt)
	C_REAL:C285($MontoApo;$MontoCta;$numCuota)
	C_TIME:C306($ref)
	C_POINTER:C301($FieldPtr)
	C_LONGINT:C283($vnumTipo1)
	C_TEXT:C284($vt_montoSTR;$vt_entero;$vt_decimal;$vt_entero2;$vt_decimal2;$vt_entero3;$vt_decimal3;$vt_entero4;$vt_decimal4)
	
	READ ONLY:C145([Personas:7])
	READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
	
	$fileName:=$1
	$FieldPtr:=Field:C253(Num:C11($2);Num:C11($3))
	
	$ref:=ACTabc_CreaDocumento ("Archivos Bancarios"+Folder separator:K24:12+"Cuponera";$fileName)
	If ($ref#?00:00:00?)
		ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;>;[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2;>;[ACT_Avisos_de_Cobranza:124]Agno:7;>;[ACT_Avisos_de_Cobranza:124]Mes:6;>)
		CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"AvisosTodos")
		$text:=""
		
		vl_idUt:=IT_UThermometer (1;0;"Exportando archivo cuponera. Un momento por favor...")
		While (Not:C34(End selection:C36([ACT_Avisos_de_Cobranza:124])))
			USE SET:C118("AvisosTodos")
			If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])>0)
				$vnumTipo1:=$vnumTipo1+1
				QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3=[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
				ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;>;[ACT_Avisos_de_Cobranza:124]Agno:7;>;[ACT_Avisos_de_Cobranza:124]Mes:6;>)
				CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"selectionCta")
				DIFFERENCE:C122("AvisosTodos";"selectionCta";"AvisosTodos")
				ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2;>;[ACT_Avisos_de_Cobranza:124]Agno:7;>;[ACT_Avisos_de_Cobranza:124]Mes:6;>)
				QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
				FIRST RECORD:C50([ACT_Avisos_de_Cobranza:124])
				CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"avisosDeCta")
				$MontoApo:=0
				$MontoApo:=ACTabc_SelectionItem2Export (2;"avisosDeCta")  //Sum($FieldPtr->)
				If ($MontoApo>0)
					vtotalCUP:=String:C10(Num:C11(vtotalCUP)+ACTabc_SelectionItem2Export (3;"avisosDeCta");"|Despliegue_ACT")
					$vt_comuna:=ST_Boolean2Str ([Personas:7]ACT_ComunaEC:68="";"NO INFORMA";[Personas:7]ACT_ComunaEC:68)
					$numCuota:=0
					For ($i;1;10)
						vnumTransCUP:=String:C10(Num:C11(vnumTransCUP)+1)
						USE SET:C118("avisosDeCta")
						If ($i=1)
							DISTINCT VALUES:C339([ACT_Avisos_de_Cobranza:124]Mes:6;aInt1)
							ARRAY LONGINT:C221(alPosiciones;0)
							APPEND TO ARRAY:C911(alPosiciones;Find in array:C230(aInt1;1))
							APPEND TO ARRAY:C911(alPosiciones;Find in array:C230(aInt1;2))
							APPEND TO ARRAY:C911(alPosiciones;Find in array:C230(aInt1;3))
							SORT ARRAY:C229(alPosiciones;<)
							$max:=alPosiciones{1}
							SORT ARRAY:C229(alPosiciones;>)
							For ($j;Size of array:C274(alPosiciones);1;-1)
								If (alPosiciones{$j}>0)
									DELETE FROM ARRAY:C228(aInt1;alPosiciones{$j};1)
								End if 
							End for 
							If ($max>0)
								INSERT IN ARRAY:C227(aInt1;1;1)
								aInt1{1}:=3
							End if 
							QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Mes:6<=$i+2)
						Else 
							QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Mes:6=$i+2)
						End if 
						CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"avisosCtaMes")
						$MontoCta:=ACTabc_SelectionItem2Export (2;"avisosCtaMes")  //Sum($FieldPtr->)
						If ($MontoCta>0)
							$numCuota:=$numCuota+1
							$vt_montoSTR:=Replace string:C233(String:C10($MontoCta);".";",")
							If (Position:C15(",";$vt_montoSTR)>0)
								$vt_entero:=Substring:C12($vt_montoSTR;1;Position:C15(",";$vt_montoSTR)-1)
								$vt_decimal:=Substring:C12($vt_montoSTR;Position:C15(",";$vt_montoSTR)+1)
							Else 
								$vt_entero:=$vt_montoSTR
								$vt_decimal:="00"
							End if 
							If (Length:C16($vt_decimal)>2)
								$MontoCta:=Round:C94($MontoCta;2)
								$vt_montoSTR:=Replace string:C233(String:C10($MontoCta);".";",")
								If (Position:C15(",";$vt_montoSTR)>0)
									$vt_entero:=Substring:C12($vt_montoSTR;1;Position:C15(",";$vt_montoSTR)-1)
									$vt_decimal:=Substring:C12($vt_montoSTR;Position:C15(",";$vt_montoSTR)+1)
								Else 
									$vt_entero:=$vt_montoSTR
									$vt_decimal:="00"
								End if 
							End if 
							  //$vt_montoSTR:=Replace string(String($MontoCta+0,1);".";",")
							$vt_montoSTR:=Replace string:C233(String:C10($MontoCta+Num:C11("0"+<>tXS_RS_DecimalSeparator+"1"));".";",")
							If (Position:C15(",";$vt_montoSTR)>0)
								$vt_entero2:=Substring:C12($vt_montoSTR;1;Position:C15(",";$vt_montoSTR)-1)
								$vt_decimal2:=Substring:C12($vt_montoSTR;Position:C15(",";$vt_montoSTR)+1)
							Else 
								$vt_entero2:=$vt_montoSTR
								$vt_decimal2:="00"
							End if 
							  //$vt_montoSTR:=Replace string(String($MontoCta+0,3);".";",")
							$vt_montoSTR:=Replace string:C233(String:C10($MontoCta+Num:C11("0"+<>tXS_RS_DecimalSeparator+"3"));".";",")
							If (Position:C15(",";$vt_montoSTR)>0)
								$vt_entero3:=Substring:C12($vt_montoSTR;1;Position:C15(",";$vt_montoSTR)-1)
								$vt_decimal3:=Substring:C12($vt_montoSTR;Position:C15(",";$vt_montoSTR)+1)
							Else 
								$vt_entero3:=$vt_montoSTR
								$vt_decimal3:="00"
							End if 
							  //$vt_montoSTR:=Replace string(String($MontoCta+0,4);".";",")
							$vt_montoSTR:=Replace string:C233(String:C10($MontoCta+Num:C11("0"+<>tXS_RS_DecimalSeparator+"4"));".";",")
							If (Position:C15(",";$vt_montoSTR)>0)
								$vt_entero4:=Substring:C12($vt_montoSTR;1;Position:C15(",";$vt_montoSTR)-1)
								$vt_decimal4:=Substring:C12($vt_montoSTR;Position:C15(",";$vt_montoSTR)+1)
							Else 
								$vt_entero4:=$vt_montoSTR
								$vt_decimal4:="00"
							End if 
							ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Mes:6;>)
							$fecha:=String:C10(Day of:C23([ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5);"00")+"/"+String:C10(Month of:C24([ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5);"00")+"/"+String:C10(Year of:C25([ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5);"0000")
							
							C_TEXT:C284($vt_convenio;$vt_rut;$vt_cuota;$vt_noCupta;$vt_fVenc;$vt_moneda;$vt_transTX;$vt_nombreConvenio;$vt_suscriptor;$vt_valor1;$vt_valor2;$vt_valor3;$vt_valor4)
							
							$vt_convenio:="0010602459"
							$vt_rut:=ST_RigthChars ((" "*12)+SR_FormatoRUT2 ([Personas:7]RUT:6);12)
							$vt_cuota:=ST_RigthChars ("000"+String:C10($numCuota);3)+"/"+ST_RigthChars ("000"+String:C10(Size of array:C274(aInt1));3)
							$vt_noCupta:=ST_RigthChars ("000"+String:C10($numCuota);3)
							$vt_fVenc:=ST_LeftChars (Substring:C12($fecha;4)+(" "*10);10)
							$vt_moneda:=ST_LeftChars ("UF"+(" "*5);5)
							$vt_transTX:="8030"
							$vt_nombreConvenio:=ST_LeftChars ("Colegio Saint Margaret`s"+(" "*30);30)
							$vt_suscriptor:=ST_LeftChars ([Personas:7]Apellidos_y_nombres:30+(" "*30);30)
							$vt_valor1:=ST_RigthChars (("0"*14)+$vt_entero+","+ST_LeftChars ($vt_decimal+"00";2);14)
							$vt_valor2:=ST_RigthChars (("0"*14)+$vt_entero2+","+ST_LeftChars ($vt_decimal2+"00";2);14)
							$vt_valor3:=ST_RigthChars (("0"*14)+$vt_entero3+","+ST_LeftChars ($vt_decimal3+"00";2);14)
							$vt_valor4:=ST_RigthChars (("0"*14);14)
							
							$text:=$vt_convenio+"\t"+"\t"+$vt_rut+"\t"+$vt_cuota+"\t"+$vt_noCupta+"\t"+$vt_fVenc+"\t"+$vt_moneda+"\t"+$vt_transTX+"\t"+$vt_nombreConvenio+"\t"+$vt_suscriptor+"\t"+$vt_valor1+"\t"+$vt_valor2+"\t"+$vt_valor3+"\t"+$vt_valor4+"\r"
							  //$text:=$vt_convenio+$vt_rut+$vt_cuota+$vt_noCupta+$fecha+$vt_moneda+$vt_transTX+$vt_nombreConvenio+$vt_suscriptor+$vt_valor1+$vt_valor2+$vt_valor3+$vt_valor4+(" "*20)+(" "*20)+(" "*20)+(" "*20)+(" "*111)+(" "*40)+(" "*40)+(" "*40)+(" "*63)+"\r"
							IO_SendPacket ($ref;$text)
						End if 
						CLEAR SET:C117("avisosCtaMes")
					End for 
				End if 
				CLEAR SET:C117("avisosDeCta")
				USE SET:C118("AvisosTodos")
			End if 
			USE SET:C118("AvisosTodos")
		End while 
		$text:="9"+ST_RigthChars (("0"*10)+vnumTransCUP;10)+"\r"
		IO_SendPacket ($ref;$text)
		CLOSE DOCUMENT:C267($ref)
		CLEAR SET:C117("AvisosTodos")
		CLEAR SET:C117("selectionCta")
		IT_UThermometer (-2;vl_idUt)
		
		ARRAY INTEGER:C220(aInt1;0)
		ARRAY LONGINT:C221(alPosiciones;0)
	Else 
		vb_detenerImp:=True:C214
	End if 
Else 
	vb_detenerImp:=True:C214
End if 