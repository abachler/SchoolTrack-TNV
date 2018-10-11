//%attributes = {}
  //ACTwiz_GeneraArchContable

vTitulo:=$1
$msg:=$2
$fileName:=$3
$folder:=$4

If (al_idsArchivosContables{vl_indiceTrf}=0)
	WDW_OpenFormWindow (->[xxSTR_Constants:1];"ACTcbl_ContraCuentas";0;4;__ ("Ingreso de Contra Cuentas"))
	DIALOG:C40([xxSTR_Constants:1];"ACTcbl_ContraCuentas")
	CLOSE WINDOW:C154
Else 
	WDW_OpenFormWindow (->[xxSTR_Constants:1];"ACTcbl_ContraCuentas2";0;4;__ ("Ingreso de Contra Cuentas"))
	DIALOG:C40([xxSTR_Constants:1];"ACTcbl_ContraCuentas2")
	CLOSE WINDOW:C154
End if 
If (ok=1)
	
	If (al_idsArchivosContables{vl_indiceTrf}=0)  //para la contabilidad generada con archivo estandar softland
		If (td2=1)
			  //` agrego notas de crédito y descuentos por item
			  //***** DESDE ACA *****
			USE SET:C118("boletasNC")
			ARRAY LONGINT:C221($alACT_recNums;0)
			LONGINT ARRAY FROM SELECTION:C647([ACT_Boletas:181];$alACT_recNums;"")
			
			If (Size of array:C274($alACT_recNums)>0)
				If (cbResumidoF=0)
					For ($i;1;Size of array:C274($alACT_recNums))
						GOTO RECORD:C242([ACT_Boletas:181];$alACT_recNums{$i})
						  //AT_Insert (0;1;->acampo1;->acampo2;->acampo3;->acampo4;->acampo5;->acampo6;->acampo7;->acampo8;->acampo9;->acampo10;->acampo11;->acampo12;->acampo13;->acampo14;->acampo15;->acampo16;->acampo17;->acampo18;->acampo19;->acampo20;->acampo21;->acampo22;->acampo23;->acampo24;->acampo25;->acampo26;->acampo27;->acampo28;->acampo29;->acampo30;->acampo31;->acampo32;->acampo33;->acampo34;->acampo35;->acampo36;->acampo37;->acampo38;->acampo39;->aenccuenta;->aID)
						AT_Insert (0;1;->acampocc1;->acampocc2;->acampocc3;->acampocc4;->acampocc5;->acampocc6;->acampocc7;->acampocc8;->acampocc9;->acampocc10;->acampocc11;->acampocc12;->acampocc13;->acampocc14;->acampocc15;->acampocc16;->acampocc17;->acampocc18;->acampocc19;->acampocc20;->acampocc21;->acampocc22;->acampocc23;->acampocc24;->acampocc25;->acampocc26;->acampocc27;->acampocc28;->acampocc29;->acampocc30;->acampocc31;->acampocc32;->acampocc33;->acampocc34;->acampocc35;->acampocc36;->acampocc37;->acampocc38;->acampocc39;->aCCID)
						acampocc3{Size of array:C274(acampocc3)}:=[ACT_Boletas:181]Monto_Total:6
						acampocc4{Size of array:C274(acampocc4)}:=[ACT_Boletas:181]TipoDocumento:7
					End for 
				Else 
					  //AT_Insert (0;1;->acampo1;->acampo2;->acampo3;->acampo4;->acampo5;->acampo6;->acampo7;->acampo8;->acampo9;->acampo10;->acampo11;->acampo12;->acampo13;->acampo14;->acampo15;->acampo16;->acampo17;->acampo18;->acampo19;->acampo20;->acampo21;->acampo22;->acampo23;->acampo24;->acampo25;->acampo26;->acampo27;->acampo28;->acampo29;->acampo30;->acampo31;->acampo32;->acampo33;->acampo34;->acampo35;->acampo36;->acampo37;->acampo38;->acampo39;->aenccuenta;->aID)
					AT_Insert (0;1;->acampocc1;->acampocc2;->acampocc3;->acampocc4;->acampocc5;->acampocc6;->acampocc7;->acampocc8;->acampocc9;->acampocc10;->acampocc11;->acampocc12;->acampocc13;->acampocc14;->acampocc15;->acampocc16;->acampocc17;->acampocc18;->acampocc19;->acampocc20;->acampocc21;->acampocc22;->acampocc23;->acampocc24;->acampocc25;->acampocc26;->acampocc27;->acampocc28;->acampocc29;->acampocc30;->acampocc31;->acampocc32;->acampocc33;->acampocc34;->acampocc35;->acampocc36;->acampocc37;->acampocc38;->acampocc39;->aCCID)
					acampocc3{Size of array:C274(acampocc3)}:=Sum:C1([ACT_Boletas:181]Monto_Total:6)
					GOTO RECORD:C242([ACT_Boletas:181];$alACT_recNums{1})
					acampocc4{Size of array:C274(acampocc4)}:=[ACT_Boletas:181]TipoDocumento:7
				End if 
			End if 
			
			If (Size of array:C274(alACT_idsCarRebajas)>0)
				If (cbResumidoF=0)
					For ($i;1;Size of array:C274(alACT_idsCarRebajas))
						QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID:1=alACT_idsCarRebajas{$i})
						  //AT_Insert (0;1;->acampo1;->acampo2;->acampo3;->acampo4;->acampo5;->acampo6;->acampo7;->acampo8;->acampo9;->acampo10;->acampo11;->acampo12;->acampo13;->acampo14;->acampo15;->acampo16;->acampo17;->acampo18;->acampo19;->acampo20;->acampo21;->acampo22;->acampo23;->acampo24;->acampo25;->acampo26;->acampo27;->acampo28;->acampo29;->acampo30;->acampo31;->acampo32;->acampo33;->acampo34;->acampo35;->acampo36;->acampo37;->acampo38;->acampo39;->aenccuenta;->aID)
						AT_Insert (0;1;->acampocc1;->acampocc2;->acampocc3;->acampocc4;->acampocc5;->acampocc6;->acampocc7;->acampocc8;->acampocc9;->acampocc10;->acampocc11;->acampocc12;->acampocc13;->acampocc14;->acampocc15;->acampocc16;->acampocc17;->acampocc18;->acampocc19;->acampocc20;->acampocc21;->acampocc22;->acampocc23;->acampocc24;->acampocc25;->acampocc26;->acampocc27;->acampocc28;->acampocc29;->acampocc30;->acampocc31;->acampocc32;->acampocc33;->acampocc34;->acampocc35;->acampocc36;->acampocc37;->acampocc38;->acampocc39;->aCCID)
						acampocc3{Size of array:C274(acampocc3)}:=arACT_Rebajas{$i}
						acampocc4{Size of array:C274(acampocc4)}:=[ACT_Cargos:173]Glosa:12
						acampocc1{Size of array:C274(acampocc1)}:=[ACT_Cargos:173]No_de_Cuenta_contable:17
						acampocc16{Size of array:C274(acampocc16)}:=[ACT_Cargos:173]Centro_de_costos:15
					End for 
				Else 
					QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID:1=alACT_idsCarRebajas{1})
					  //AT_Insert (0;1;->acampo1;->acampo2;->acampo3;->acampo4;->acampo5;->acampo6;->acampo7;->acampo8;->acampo9;->acampo10;->acampo11;->acampo12;->acampo13;->acampo14;->acampo15;->acampo16;->acampo17;->acampo18;->acampo19;->acampo20;->acampo21;->acampo22;->acampo23;->acampo24;->acampo25;->acampo26;->acampo27;->acampo28;->acampo29;->acampo30;->acampo31;->acampo32;->acampo33;->acampo34;->acampo35;->acampo36;->acampo37;->acampo38;->acampo39;->aenccuenta;->aID)
					AT_Insert (0;1;->acampocc1;->acampocc2;->acampocc3;->acampocc4;->acampocc5;->acampocc6;->acampocc7;->acampocc8;->acampocc9;->acampocc10;->acampocc11;->acampocc12;->acampocc13;->acampocc14;->acampocc15;->acampocc16;->acampocc17;->acampocc18;->acampocc19;->acampocc20;->acampocc21;->acampocc22;->acampocc23;->acampocc24;->acampocc25;->acampocc26;->acampocc27;->acampocc28;->acampocc29;->acampocc30;->acampocc31;->acampocc32;->acampocc33;->acampocc34;->acampocc35;->acampocc36;->acampocc37;->acampocc38;->acampocc39;->aCCID)
					acampocc3{Size of array:C274(acampocc3)}:=AT_GetSumArray (->arACT_Rebajas)
					acampocc4{Size of array:C274(acampocc4)}:=[ACT_Cargos:173]Glosa:12
					acampocc1{Size of array:C274(acampocc1)}:=[ACT_Cargos:173]No_de_Cuenta_contable:17
					acampocc16{Size of array:C274(acampocc16)}:=[ACT_Cargos:173]Centro_de_costos:15
				End if 
			End if 
			SET_ClearSets ("boletasNC")
			  //***** HASTA ACA *****
		End if 
	End if 
	
	USE CHARACTER SET:C205("windows-1252";0)
	
	$ref:=ACTabc_CreaDocumento ("Archivos Contables"+Folder separator:K24:12+$folder;$fileName)
	
	If (ok=1)
		If (al_idsArchivosContables{vl_indiceTrf}=0)
			$coma:=","
			$iterations:=Size of array:C274(acampo1)+Size of array:C274(acampocc1)
			$currentiteration:=0
			$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;$msg)
			For ($i;1;Size of array:C274(acampo1))
				$currentiteration:=$currentiteration+1
				$line:=""
				For ($j;1;39)
					$array:=Get pointer:C304("acampo"+String:C10($j))
					$type:=Type:C295($array->)
					Case of 
						: ($type=Real array:K8:17)
							$line:=$line+String:C10($array->{$i})+$coma
						: (($type=String array:K8:15) | ($type=Text array:K8:16))
							$line:=$line+ST_Qte ($array->{$i})+$coma
					End case 
				End for 
				$line:=Substring:C12($line;1;Length:C16($line)-1)+"\r\n"
				IO_SendPacket ($ref;$line)
				$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$currentiteration/$iterations;$msg)
			End for 
			For ($i;1;Size of array:C274(acampocc1))
				$currentiteration:=$currentiteration+1
				$line:=""
				For ($j;1;39)
					$array:=Get pointer:C304("acampocc"+String:C10($j))
					$type:=Type:C295($array->)
					Case of 
						: ($type=Real array:K8:17)
							$line:=$line+String:C10($array->{$i})+$coma
						: (($type=String array:K8:15) | ($type=Text array:K8:16))
							$line:=$line+ST_Qte ($array->{$i})+$coma
					End case 
				End for 
				$line:=Substring:C12($line;1;Length:C16($line)-1)+"\r\n"
				IO_SendPacket ($ref;$line)
				$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$currentiteration/$iterations;"Generando archivo de recaudación...")
			End for 
			$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		Else 
			ARRAY TEXT:C222(at_textosFinales;0)
			ARRAY TEXT:C222(at_Textos;0)
			_O_ARRAY STRING:C218(1;as1_Pad;0)  //espacio o 0
			ARRAY LONGINT:C221(al1_Largo;0)
			_O_ARRAY STRING:C218(1;as1_Posicion;0)  //d o l
			ARRAY TEXT:C222(as1_Delimiter;0)
			$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;$msg)
			For ($i;1;Size of array:C274(at_contabilidadTrf1))  //encabezado
				AT_Initialize (->at_textos;->as1_Pad;->al1_Largo;->as1_Posicion;->as1_Delimiter)
				For ($r;1;Size of array:C274(al_Numero))
					AT_Insert (0;1;->at_textos;->as1_Pad;->al1_Largo;->as1_Posicion;->as1_Delimiter)
					$ptr:=Get pointer:C304("at_contabilidadTrf"+String:C10($r))
					
					  //at_textos{Size of array(at_textos)}:=ACTtrf_Master (5;at_formato{$r};$ptr->{$i})  `formatos
					at_textos{Size of array:C274(at_textos)}:=$ptr->{$i}  //ya viene con formato
					
					al1_Largo{Size of array:C274(al1_Largo)}:=al_Largo{$r}  //largo
					If (at_Relleno{$r}="Espacio")  //relleno
						as1_Pad{Size of array:C274(as1_Pad)}:=" "
					Else 
						If (at_Relleno{$r}="Cero")
							as1_Pad{Size of array:C274(as1_Pad)}:="0"
						Else 
							If (at_Relleno{$r}="Ajustado a contenido")
								as1_Pad{Size of array:C274(as1_Pad)}:=" "
								al1_Largo{Size of array:C274(al1_Largo)}:=Length:C16(at_textos{Size of array:C274(at_textos)})
							Else 
								as1_Pad{Size of array:C274(as1_Pad)}:=" "
							End if 
						End if 
					End if 
					If (at_Alineado{$r}="Der")  //posicion del relleno
						as1_Posicion{Size of array:C274(as1_Posicion)}:="I"
					Else 
						If (at_Alineado{$r}="Izq")
							as1_Posicion{Size of array:C274(as1_Posicion)}:="D"
						Else 
							as1_Posicion{Size of array:C274(as1_Posicion)}:="I"
						End if 
					End if 
					If (PWTrf_h2=1)  //archivo plano
						as1_Delimiter{Size of array:C274(as1_Delimiter)}:=""
					Else 
						If (PWTrf_h1=1)
							If (WTrf_s1=1)  //tab
								as1_Delimiter{Size of array:C274(as1_Delimiter)}:="\t"
							Else 
								If (WTrf_s2=1)  //Punto y coma
									as1_Delimiter{Size of array:C274(as1_Delimiter)}:=";"
								Else 
									If (WTrf_s3=1)  //coma
										as1_Delimiter{Size of array:C274(as1_Delimiter)}:=","
									Else 
										If (WTrf_s4=1)
											as1_Delimiter{Size of array:C274(as1_Delimiter)}:=WTrf_s4_CaracterOtro
										End if 
									End if 
								End if 
							End if 
						End if 
					End if 
				End for 
				If (Size of array:C274(at_textos)>0)
					AT_Insert (0;1;->at_textosFinales)
					at_textosFinales{Size of array:C274(at_textosFinales)}:=ST_ConcatenatePaddedStrings (->at_textos;->as1_Pad;->al1_Largo;->as1_Posicion;->as1_Delimiter)
				End if 
				$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(at_contabilidadTrf1);"Preparando información del cuerpo para exportar a texto...")
			End for 
			$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
			
			$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Preparando registros de contracuentas...")
			For ($i;1;Size of array:C274(at_contabilidadTrfCC1))
				AT_Initialize (->at_textos;->as1_Pad;->al1_Largo;->as1_Posicion;->as1_Delimiter)
				For ($r;1;Size of array:C274(al_Numero))
					AT_Insert (0;1;->at_textos;->as1_Pad;->al1_Largo;->as1_Posicion;->as1_Delimiter)
					$ptr:=Get pointer:C304("at_contabilidadTrfCC"+String:C10($r))
					at_textos{Size of array:C274(at_textos)}:=ACTtrf_Master (5;at_formato{$r};$ptr->{$i})  //formatos
					
					al1_Largo{Size of array:C274(al1_Largo)}:=al_Largo{$r}  //largo
					If (at_Relleno{$r}="Espacio")  //relleno
						as1_Pad{Size of array:C274(as1_Pad)}:=" "
					Else 
						If (at_Relleno{$r}="Cero")
							as1_Pad{Size of array:C274(as1_Pad)}:="0"
						Else 
							If (at_Relleno{$r}="Ajustado a contenido")
								as1_Pad{Size of array:C274(as1_Pad)}:=" "
								al1_Largo{Size of array:C274(al1_Largo)}:=Length:C16(at_textos{Size of array:C274(at_textos)})
							Else 
								as1_Pad{Size of array:C274(as1_Pad)}:=" "
							End if 
						End if 
					End if 
					If (at_Alineado{$r}="Der")  //posicion del relleno
						as1_Posicion{Size of array:C274(as1_Posicion)}:="I"
					Else 
						If (at_Alineado{$r}="Izq")
							as1_Posicion{Size of array:C274(as1_Posicion)}:="D"
						Else 
							as1_Posicion{Size of array:C274(as1_Posicion)}:="I"
						End if 
					End if 
					If (PWTrf_h2=1)  //archivo plano
						as1_Delimiter{Size of array:C274(as1_Delimiter)}:=""
					Else 
						If (PWTrf_h1=1)
							If (WTrf_s1=1)  //tab
								as1_Delimiter{Size of array:C274(as1_Delimiter)}:="\t"
							Else 
								If (WTrf_s2=1)  //Punto y coma
									as1_Delimiter{Size of array:C274(as1_Delimiter)}:=";"
								Else 
									If (WTrf_s3=1)  //coma
										as1_Delimiter{Size of array:C274(as1_Delimiter)}:=","
									Else 
										If (WTrf_s4=1)
											as1_Delimiter{Size of array:C274(as1_Delimiter)}:=WTrf_s4_CaracterOtro
										End if 
									End if 
								End if 
							End if 
						End if 
					End if 
				End for 
				If (Size of array:C274(at_textos)>0)
					AT_Insert (0;1;->at_textosFinales)
					at_textosFinales{Size of array:C274(at_textosFinales)}:=ST_ConcatenatePaddedStrings (->at_textos;->as1_Pad;->al1_Largo;->as1_Posicion;->as1_Delimiter)
				End if 
				$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(at_contabilidadTrfCC1);"Preparando registros de contracuentas...")
			End for 
			$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
			
			C_REAL:C285($debecc;$habercc;$monto1;$monto2)
			$debe:=AT_GetSumArray (->acampocc2)+AT_GetSumArray (->acampo2)
			$haber:=AT_GetSumArray (->acampocc3)+AT_GetSumArray (->acampo3)
			$el:=Find in array:C230(at_Descripcion;"Monto al haber moneda Base")
			$el2:=Find in array:C230(at_Descripcion;"Monto del concepto")
			If (($el>0) | ($el2>0))
				$monto1:=$haber
			End if 
			$el:=Find in array:C230(at_Descripcion;"Monto al debe moneda Base")
			If (($el>0) | ($el2>0))
				$monto2:=$debe
			End if 
			
			If (cs_encabezado=1)  //registro de encabezado
				$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Preparando registros de encabezados...")
				AT_Initialize (->at_textos;->as1_Pad;->al1_Largo;->as1_Posicion;->as1_Delimiter)
				ARRAY TEXT:C222($at_headerTrf;0)
				For ($r;1;Size of array:C274(al_NumeroHe))  //encabezado
					AT_Insert (0;1;->at_textos;->as1_Pad;->al1_Largo;->as1_Posicion;->as1_Delimiter)
					Case of 
						: (at_DescripcionHe{$r}="Texto fijo")
							at_textos{Size of array:C274(at_textos)}:=at_TextoFijoHe{$r}
						: (at_DescripcionHe{$r}="Número total de transacciones")
							at_textos{Size of array:C274(at_textos)}:=String:C10(Size of array:C274(at_textosFinales))
						: (at_DescripcionHe{$r}="Suma total de cargos")
							at_textos{Size of array:C274(at_textos)}:=String:C10($monto1)
						: (at_DescripcionHe{$r}="Suma total de abonos")
							at_textos{Size of array:C274(at_textos)}:=String:C10($monto2)
						Else 
							at_textos{Size of array:C274(at_textos)}:=ACTtrf_Master (6;at_DescripcionHe{$r};at_TextoFijoHe{$r})  //descripciones
					End case 
					at_textos{Size of array:C274(at_textos)}:=ACTtrf_Master (5;at_formatoHe{$r};at_textos{Size of array:C274(at_textos)})  //formatos
					
					al1_Largo{Size of array:C274(al1_Largo)}:=al_LargoHe{$r}  //largo
					If (at_RellenoHe{$r}="Espacio")  //relleno
						as1_Pad{Size of array:C274(as1_Pad)}:=" "
					Else 
						If (at_RellenoHe{$r}="Cero")
							as1_Pad{Size of array:C274(as1_Pad)}:="0"
						Else 
							If (at_RellenoHe{$r}="Ajustado a contenido")
								as1_Pad{Size of array:C274(as1_Pad)}:=" "
								al1_Largo{Size of array:C274(al1_Largo)}:=Length:C16(at_textos{Size of array:C274(at_textos)})
							Else 
								as1_Pad{Size of array:C274(as1_Pad)}:=" "
							End if 
						End if 
					End if 
					If (at_AlineadoHe{$r}="Der")  //posicion del relleno
						as1_Posicion{Size of array:C274(as1_Posicion)}:="I"
					Else 
						If (at_AlineadoHe{$r}="Izq")
							as1_Posicion{Size of array:C274(as1_Posicion)}:="D"
						Else 
							as1_Posicion{Size of array:C274(as1_Posicion)}:="I"
						End if 
					End if 
					If (PWTrf_h2=1)  //archivo plano
						as1_Delimiter{Size of array:C274(as1_Delimiter)}:=""
					Else 
						If (PWTrf_h1=1)
							If (WTrf_s1=1)  //tab
								as1_Delimiter{Size of array:C274(as1_Delimiter)}:="\t"
							Else 
								If (WTrf_s2=1)  //Punto y coma
									as1_Delimiter{Size of array:C274(as1_Delimiter)}:=";"
								Else 
									If (WTrf_s3=1)  //coma
										as1_Delimiter{Size of array:C274(as1_Delimiter)}:=","
									Else 
										If (WTrf_s4=1)
											as1_Delimiter{Size of array:C274(as1_Delimiter)}:=WTrf_s4_CaracterOtro
										End if 
									End if 
								End if 
							End if 
						End if 
					End if 
					$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(al_NumeroHe);"Preparando registros de encabezados...")
				End for 
				$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
				
				$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Exportando encabezado...")
				If (Size of array:C274(at_textos)>0)
					INSERT IN ARRAY:C227($at_headerTrf;1;1)
					$at_headerTrf{1}:=ST_ConcatenatePaddedStrings (->at_textos;->as1_Pad;->al1_Largo;->as1_Posicion;->as1_Delimiter)
					$at_headerTrf{1}:=$at_headerTrf{1}+"\r\n"
					IO_SendPacket ($ref;$at_headerTrf{1})
				End if 
				$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
			End if 
			
			$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Exportando registros del cuerpo...")
			For ($i;1;Size of array:C274(at_textosFinales))  //cuerpo
				at_textosFinales{$i}:=at_textosFinales{$i}+"\r\n"
				IO_SendPacket ($ref;at_textosFinales{$i})
				$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(at_textosFinales);"Preparando registro de control...")
			End for 
			$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
			
			If (cs_registroControl=1)  //registro de control
				$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Preparando registros de control...")
				AT_Initialize (->at_textos;->as1_Pad;->al1_Largo;->as1_Posicion;->as1_Delimiter)
				ARRAY TEXT:C222($at_footerTrf;0)
				For ($r;1;Size of array:C274(al_NumeroFo))
					AT_Insert (0;1;->at_textos;->as1_Pad;->al1_Largo;->as1_Posicion;->as1_Delimiter)
					Case of 
						: (at_DescripcionFo{$r}="Texto fijo")
							at_textos{Size of array:C274(at_textos)}:=at_TextoFijoFo{$r}
						: (at_DescripcionFo{$r}="Número total de transacciones")
							at_textos{Size of array:C274(at_textos)}:=String:C10(Size of array:C274(at_textosFinales))
						: (at_DescripcionFo{$r}="Suma total de cargos")
							at_textos{Size of array:C274(at_textos)}:=String:C10($monto1)
						: (at_DescripcionFo{$r}="Suma total de abonos")
							at_textos{Size of array:C274(at_textos)}:=String:C10($monto2)
						Else 
							at_textos{Size of array:C274(at_textos)}:=ACTtrf_Master (6;at_DescripcionFo{$r};at_TextoFijoFo{$r})
					End case 
					at_textos{Size of array:C274(at_textos)}:=ACTtrf_Master (5;at_formatoFo{$r};at_textos{Size of array:C274(at_textos)})  //formatos
					
					al1_Largo{Size of array:C274(al1_Largo)}:=al_LargoFo{$r}  //largo
					If (at_RellenoFo{$r}="Espacio")  //relleno
						as1_Pad{Size of array:C274(as1_Pad)}:=" "
					Else 
						If (at_RellenoFo{$r}="Cero")
							as1_Pad{Size of array:C274(as1_Pad)}:="0"
						Else 
							If (at_RellenoFo{$r}="Ajustado a contenido")
								as1_Pad{Size of array:C274(as1_Pad)}:=" "
								al1_Largo{Size of array:C274(al1_Largo)}:=Length:C16(at_textos{Size of array:C274(at_textos)})
							Else 
								as1_Pad{Size of array:C274(as1_Pad)}:=" "
							End if 
						End if 
					End if 
					If (at_AlineadoFo{$r}="Der")  //posicion del relleno
						as1_Posicion{Size of array:C274(as1_Posicion)}:="I"
					Else 
						If (at_AlineadoFo{$r}="Izq")
							as1_Posicion{Size of array:C274(as1_Posicion)}:="D"
						Else 
							as1_Posicion{Size of array:C274(as1_Posicion)}:="I"
						End if 
					End if 
					If (PWTrf_h2=1)  //archivo plano
						as1_Delimiter{Size of array:C274(as1_Delimiter)}:=""
					Else 
						If (PWTrf_h1=1)
							If (WTrf_s1=1)  //tab
								as1_Delimiter{Size of array:C274(as1_Delimiter)}:="\t"
							Else 
								If (WTrf_s2=1)  //Punto y coma
									as1_Delimiter{Size of array:C274(as1_Delimiter)}:=";"
								Else 
									If (WTrf_s3=1)  //coma
										as1_Delimiter{Size of array:C274(as1_Delimiter)}:=","
									Else 
										If (WTrf_s4=1)
											as1_Delimiter{Size of array:C274(as1_Delimiter)}:=WTrf_s4_CaracterOtro
										End if 
									End if 
								End if 
							End if 
						End if 
					End if 
					$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$r/Size of array:C274(al_NumeroFo);"Preparando registro de control...")
				End for 
				$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
				
				$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Exportando registro de control...")
				If (Size of array:C274(at_textos)>0)
					INSERT IN ARRAY:C227($at_footerTrf;1;1)
					$at_footerTrf{1}:=ST_ConcatenatePaddedStrings (->at_textos;->as1_Pad;->al1_Largo;->as1_Posicion;->as1_Delimiter)
					$at_footerTrf{1}:=$at_footerTrf{1}+"\r\n"
					IO_SendPacket ($ref;$at_footerTrf{1})
				End if 
				$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
			End if 
		End if 
		CLOSE DOCUMENT:C267($ref)
		
		  // Modificado por: Saúl Ponce (22-02-2017) Ticket Nº 175397 - Aparecía error al finalizar la generación de los archivos.
		  //ACTcd_DlogWithShowOnDisk ($filePath;0;"El archivo "+ST_Qte ($fileName)+" se generó correctamente. Lo puede encontrar en: "+$folderPath)
		ACTcd_DlogWithShowOnDisk (vtACT_document;0;"El archivo "+ST_Qte ($fileName)+" se generó correctamente. Lo puede encontrar en: "+SYS_GetParentNme (vtACT_document))
	Else 
		  // Modificado por: Saúl Ponce (22-02-2017) Ticket Nº 175397 - Aparecía error al finalizar la generación de los archivos.
		  //CD_Dlog (0;"No es posible modificar el archivo "+ST_Qte ($fileName)+" ubicado en la carpeta "+$folderPath+"."+"\r\r"+"El archivo no fue generado.")
		CD_Dlog (0;"No es posible modificar el archivo "+ST_Qte ($fileName)+" ubicado en la carpeta "+SYS_GetParentNme (vtACT_document)+"."+"\r\r"+"El archivo no fue generado.")
	End if 
	USE CHARACTER SET:C205(*;0)
End if 
