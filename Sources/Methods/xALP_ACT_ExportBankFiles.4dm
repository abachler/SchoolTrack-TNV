//%attributes = {}
  //xALP_ACT_ExportBankFiles

If (False:C215)
	  //1 encabezado
	  //2 pie
	  //3 cuerpo
End if 
C_LONGINT:C283($1;$area;$areaList)
$area:=$1
Case of 
	: (($area=1) | ($area=2))
		AT_Initialize (->at_DescripcionExp;->atACT_FormatExp;->atACT_AlinExp;->atACT_FillExp)  //8 Rel
		If (PWTrf_Ptb1=1)  //archivos bancarios
			AT_Insert (0;8;->at_DescripcionExp)
			at_DescripcionExp{1}:="Texto fijo"
			at_DescripcionExp{2}:="Fecha actual"
			at_DescripcionExp{3}:="Fecha de información -sólo PAC-"
			at_DescripcionExp{4}:="Número total de transacciones"
			at_DescripcionExp{5}:="Suma total de las trasacciones"
			at_DescripcionExp{6}:="Día actual"
			at_DescripcionExp{7}:="Mes actual"
			at_DescripcionExp{8}:="Año actual"
			APPEND TO ARRAY:C911(at_DescripcionExp;"Fecha vencimiento primer aviso de cobranza")
			APPEND TO ARRAY:C911(at_DescripcionExp;"Número total de transacciones + 1")
		Else   //archivos contables
			AT_Insert (0;9;->at_DescripcionExp)
			at_DescripcionExp{1}:="Texto fijo"
			at_DescripcionExp{2}:="Fecha actual"
			at_DescripcionExp{3}:="Número total de transacciones"
			at_DescripcionExp{4}:="Suma total de cargos"
			at_DescripcionExp{5}:="Suma total de abonos"
			at_DescripcionExp{6}:="Día actual"
			at_DescripcionExp{7}:="Mes actual"
			at_DescripcionExp{8}:="Año actual"
			at_DescripcionExp{9}:="Número mes inicio período generación"
		End if 
		APPEND TO ARRAY:C911(at_DescripcionExp;"Día Juliano")
		AT_Insert (1;2;->atACT_AlinExp)
		atACT_AlinExp{1}:="Der"
		atACT_AlinExp{2}:="Izq"
		
		AT_Insert (1;3;->atACT_FillExp)
		atACT_FillExp{1}:="Espacio"
		atACT_FillExp{2}:="Cero"
		atACT_FillExp{3}:="Ajustado a contenido"
		Case of 
			: ($area=1)  //encabezado
				ALP_DefaultColSettings (xALP_ExportBankFilesH;1;"al_NumeroHe";__ ("Pos.");30;"#0";2;0;0)  //´1
				ALP_DefaultColSettings (xALP_ExportBankFilesH;2;"at_DescripcionHe";__ ("Descripción");120;"";0;0;1)  //´2
				ALP_DefaultColSettings (xALP_ExportBankFilesH;3;"al_PosIniHe";__ ("Pos.\rInicial");35;"###0";2;0;0)  //´3
				ALP_DefaultColSettings (xALP_ExportBankFilesH;4;"al_LargoHe";__ ("Largo");35;"###0";2;0;1)  //´4
				ALP_DefaultColSettings (xALP_ExportBankFilesH;5;"al_PosFinalHe";__ ("Pos.\rFinal");35;"###0";2;0;0)  //´5
				ALP_DefaultColSettings (xALP_ExportBankFilesH;6;"at_formatoHe";__ ("Formato");90;"";0;0;1)  //´6
				ALP_DefaultColSettings (xALP_ExportBankFilesH;7;"at_AlineadoHe";__ ("Alineado");60;"";0;0;1)  //´7
				ALP_DefaultColSettings (xALP_ExportBankFilesH;8;"at_RellenoHe";__ ("Relleno");85;"";0;0;1)  //´8
				  //Modificado por: Saul Ponce (29/11/2017) Ticket 193963, evitar el formato erróneo al ingresar los valores en la celda
				  //ALP_DefaultColSettings (xALP_ExportBankFilesH;9;"at_TextoFijoHe";__ ("Texto Fijo");80;"#0";0;0;1)  //´10
				ALP_DefaultColSettings (xALP_ExportBankFilesH;9;"at_TextoFijoHe";__ ("Texto Fijo");80;"";0;0;1)  //´10
				$areaList:=xALP_ExportBankFilesH
			: ($area=2)  //pie
				ALP_DefaultColSettings (xALP_ExportBankFilesF;1;"al_NumeroFo";__ ("Pos.");30;"#0";2;0;0)  //´1
				ALP_DefaultColSettings (xALP_ExportBankFilesF;2;"at_DescripcionFo";__ ("Descripción");120;"";0;0;1)  //´2
				ALP_DefaultColSettings (xALP_ExportBankFilesF;3;"al_PosIniFo";__ ("Pos.\rInicial");35;"###0";2;0;0)  //´3
				ALP_DefaultColSettings (xALP_ExportBankFilesF;4;"al_LargoFo";__ ("Largo");35;"###0";2;0;1)  //´4
				ALP_DefaultColSettings (xALP_ExportBankFilesF;5;"al_PosFinalFo";__ ("Pos.\rFinal");35;"###0";2;0;0)  //´5
				ALP_DefaultColSettings (xALP_ExportBankFilesF;6;"at_formatoFo";__ ("Formato");90;"";0;0;1)  //´6
				ALP_DefaultColSettings (xALP_ExportBankFilesF;7;"at_AlineadoFo";__ ("Alineado");60;"";0;0;1)  //´7
				ALP_DefaultColSettings (xALP_ExportBankFilesF;8;"at_RellenoFo";__ ("Relleno");85;"";0;0;1)  //´8
				  //Modificado por: Saul Ponce (29/11/2017) Ticket 193963, evitar el formato erróneo al ingresar los valores en la celda
				  //ALP_DefaultColSettings (xALP_ExportBankFilesF;9;"at_TextoFijoFo";__ ("Texto Fijo");80;"#0";0;0;1)  //´10
				ALP_DefaultColSettings (xALP_ExportBankFilesF;9;"at_TextoFijoFo";__ ("Texto Fijo");80;"";0;0;1)  //´10
				$areaList:=xALP_ExportBankFilesF
		End case 
	: ($area=3)  //cuerpo
		AT_Initialize (->aRecordFieldPointersExp;->aRecordFieldPointersExp;->atACT_FormatExp;->atACT_AlinExp;->atACT_FillExp;->at_DescripcionExp)  //8 Rel
		C_POINTER:C301($ptr_campoABuscar)
		If (PWTrf_Ptb1=1)
			Case of 
				: (vlACT_id_modo_pago=-10)
					$ptr_campoABuscar:=->[xxACT_TransferenciaBancaria:131]EnPAC:5
				: (vlACT_id_modo_pago=-9)
					$ptr_campoABuscar:=->[xxACT_TransferenciaBancaria:131]EnPAT:4
				: (vlACT_id_modo_pago=-11)
					$ptr_campoABuscar:=->[xxACT_TransferenciaBancaria:131]EnCuponera:6
				Else 
					$ptr_campoABuscar:=->[xxACT_TransferenciaBancaria:131]EnPAC:5
			End case 
		Else 
			If (PWTrf_Pac1=1)
				$ptr_campoABuscar:=->[xxACT_TransferenciaBancaria:131]EnContabilidad:7
			End if 
		End if 
		READ ONLY:C145([xxACT_TransferenciaBancaria:131])
		ARRAY LONGINT:C221(al_rnCamposT;0)
		QUERY:C277([xxACT_TransferenciaBancaria:131];$ptr_campoABuscar->=True:C214)
		ORDER BY:C49([xxACT_TransferenciaBancaria:131];[xxACT_TransferenciaBancaria:131]Tabla_Número:2;>;[xxACT_TransferenciaBancaria:131]Campo_Número:3;>)
		SELECTION TO ARRAY:C260([xxACT_TransferenciaBancaria:131];al_rnCamposT)
		For ($i;1;Size of array:C274(al_rnCamposT))
			GOTO RECORD:C242([xxACT_TransferenciaBancaria:131];al_rnCamposT{$i})
			
			  //20130401 RCH
			  //QUERY([xShell_Fields];[xShell_Fields]ID=[xxACT_TransferenciaBancaria]id_xShellFields)
			QUERY:C277([xShell_Fields:52];[xShell_Fields:52]NumeroTabla:1=[xxACT_TransferenciaBancaria:131]Tabla_Número:2;*)
			QUERY:C277([xShell_Fields:52]; & ;[xShell_Fields:52]NumeroCampo:2=[xxACT_TransferenciaBancaria:131]Campo_Número:3)
			
			If (Records in selection:C76([xShell_Fields:52])>0)
				AT_Insert (0;1;->at_DescripcionExp;->aRecordFieldPointersExp)
				at_DescripcionExp{Size of array:C274(at_DescripcionExp)}:=Table name:C256([xxACT_TransferenciaBancaria:131]Tabla_Número:2)
				$el:=Position:C15("_";at_DescripcionExp{Size of array:C274(at_DescripcionExp)})
				If ($el>0)
					  //20130401 RCH
					  //at_DescripcionExp{Size of array(at_DescripcionExp)}:="["+ST_Uppercase (Substring(at_DescripcionExp{Size of array(at_DescripcionExp)};$el+1;3))+"]"+XSvs_nombreCampoLocal_Numero ([xxACT_TransferenciaBancaria]Tabla_Número;[xShell_Fields]ID;<>vtXS_CountryCode;<>vtXS_langage)
					at_DescripcionExp{Size of array:C274(at_DescripcionExp)}:="["+ST_Uppercase (Substring:C12(at_DescripcionExp{Size of array:C274(at_DescripcionExp)};$el+1;3))+"]"+XSvs_nombreCampoLocal_Numero ([xxACT_TransferenciaBancaria:131]Tabla_Número:2;[xxACT_TransferenciaBancaria:131]Campo_Número:3;<>vtXS_CountryCode;<>vtXS_langage)
				Else 
					  //20130401 RCH
					  //at_DescripcionExp{Size of array(at_DescripcionExp)}:="["+ST_Uppercase (Substring(at_DescripcionExp{Size of array(at_DescripcionExp)};1;3))+"]"+XSvs_nombreCampoLocal_Numero ([xxACT_TransferenciaBancaria]Tabla_Número;[xShell_Fields]ID;<>vtXS_CountryCode;<>vtXS_langage)
					at_DescripcionExp{Size of array:C274(at_DescripcionExp)}:="["+ST_Uppercase (Substring:C12(at_DescripcionExp{Size of array:C274(at_DescripcionExp)};1;3))+"]"+XSvs_nombreCampoLocal_Numero ([xxACT_TransferenciaBancaria:131]Tabla_Número:2;[xxACT_TransferenciaBancaria:131]Campo_Número:3;<>vtXS_CountryCode;<>vtXS_langage)
				End if 
				aRecordFieldPointersExp{Size of array:C274(aRecordFieldPointersExp)}:=Field:C253([xxACT_TransferenciaBancaria:131]Tabla_Número:2;[xxACT_TransferenciaBancaria:131]Campo_Número:3)
			End if 
		End for 
		
		AT_Insert (1;2;->atACT_AlinExp)
		atACT_AlinExp{1}:="Der"  //7 Alineado
		atACT_AlinExp{2}:="Izq"
		If (PWTrf_Ptb1=1)  //banco
			AT_Insert (1;2;->at_DescripcionExp;->aRecordFieldPointersExp)
			at_DescripcionExp{1}:="Texto Fijo"
			at_DescripcionExp{2}:="Día Juliano"
			  //at_DescripcionExp{3}:="Número de Tarjeta de Crédito"
			  //If (vlACT_id_modo_pago=-9)  //20140526 RCH Se habilita como texto fijo puesto que el campo esta oculto en la estructur…
			  //AT_Insert (0;1;->at_DescripcionExp;->aRecordFieldPointersExp)
			  //at_DescripcionExp{3}:="Número de Tarjeta de Crédito"
			  //End if 
			If (vlACT_id_modo_pago=-9)  //20160506 RCH
				AT_Insert (3;1;->at_DescripcionExp;->aRecordFieldPointersExp)
				at_DescripcionExp{3}:="Número de Tarjeta de Crédito"
				aRecordFieldPointersExp{3}:=->[Personas:7]ACT_Numero_TC:54
			End if 
			ALP_DefaultColSettings (xALP_ExportBankFiles;1;"al_Numero";__ ("Pos.");30;"#0";2;0;0)  //´1
			ALP_DefaultColSettings (xALP_ExportBankFiles;2;"at_Descripcion";__ ("Descripción");125;"";0;0;1)  //´2
			ALP_DefaultColSettings (xALP_ExportBankFiles;3;"al_PosIni";__ ("Pos.\rInicial");35;"###0";2;0;0)  //´3
			ALP_DefaultColSettings (xALP_ExportBankFiles;4;"al_Largo";__ ("Largo");35;"###0";2;0;1)  //´4
			ALP_DefaultColSettings (xALP_ExportBankFiles;5;"al_PosFinal";__ ("Pos.\rFinal");35;"###0";2;0;0)  //´5
			ALP_DefaultColSettings (xALP_ExportBankFiles;6;"at_formato";__ ("Formato");85;"";0;0;1)  //´6
			ALP_DefaultColSettings (xALP_ExportBankFiles;7;"at_Alineado";__ ("Alineado");55;"";0;0;1)  //´7
			ALP_DefaultColSettings (xALP_ExportBankFiles;8;"at_Relleno";__ ("Relleno");90;"";0;0;1)  //´8
			  //Modificado por: Saul Ponce (29/11/2017) Ticket 193963, evitar el formato erróneo al ingresar los valores en la celda
			  //ALP_DefaultColSettings (xALP_ExportBankFiles;9;"at_TextoFijo";__ ("Texto Fijo");80;"#0";0;0;1)  //´10
			ALP_DefaultColSettings (xALP_ExportBankFiles;9;"at_TextoFijo";__ ("Texto Fijo");80;"";0;0;1)
		Else   //contabilidad
			  //AT_Insert (1;19;->at_DescripcionExp;->aRecordFieldPointersExp)
			  //at_DescripcionExp{1}:="Texto Fijo"
			  //at_DescripcionExp{2}:="Código Plan de Cuentas"
			  //at_DescripcionExp{3}:="Monto al haber moneda Base"
			  //at_DescripcionExp{4}:="Monto al debe moneda Base"
			  //at_DescripcionExp{5}:="Descripción de Movimiento"
			  //at_DescripcionExp{6}:="Código centro de costos"
			  //at_DescripcionExp{7}:="Código Auxiliar"
			  //at_DescripcionExp{8}:="Código Forma de Pago"
			  //at_DescripcionExp{9}:="Monto del concepto"
			  //at_DescripcionExp{10}:="Tipo de movimiento"
			  //at_DescripcionExp{11}:="Correlativo"
			  //at_DescripcionExp{12}:="Fecha actual"
			  //at_DescripcionExp{13}:="Nro. dcto. referencia"
			  //at_DescripcionExp{14}:="Tipo documento"
			  //at_DescripcionExp{15}:="Fecha referencia documento"
			  //at_DescripcionExp{16}:="Fecha vencimiento documento"
			  //at_DescripcionExp{17}:="Tipo documento conciliación"
			  //at_DescripcionExp{18}:="Número documento conciliación"
			  //at_DescripcionExp{19}:="Código Interno Forma de Pago"
			ARRAY TEXT:C222(atACTtrf_DescripcionExp;0)
			COPY ARRAY:C226(at_DescripcionExp;atACTtrf_DescripcionExp)
			ACTtrf_Master (7;"at_DescripcionExp")
			AT_Insert (1;Size of array:C274(at_DescripcionExp);->aRecordFieldPointersExp)
			AT_MergeArrays (->atACTtrf_DescripcionExp;->at_DescripcionExp)
			AT_RedimArrays (Size of array:C274(at_DescripcionExp);->aRecordFieldPointersExp)
			
			ALP_DefaultColSettings (xALP_ExportBankFiles;1;"al_Numero";__ ("Pos.");24;"#0";2;0;0)  //´1
			ALP_DefaultColSettings (xALP_ExportBankFiles;2;"at_Descripcion";__ ("Descripción");115;"";0;0;1)  //´2
			ALP_DefaultColSettings (xALP_ExportBankFiles;3;"al_PosIni";__ ("Pos.\rInicial");29;"###0";2;0;0)  //´3
			ALP_DefaultColSettings (xALP_ExportBankFiles;4;"al_Largo";__ ("Largo");29;"###0";2;0;1)  //´4
			ALP_DefaultColSettings (xALP_ExportBankFiles;5;"al_PosFinal";__ ("Pos.\rFinal");29;"###0";2;0;0)  //´5
			ALP_DefaultColSettings (xALP_ExportBankFiles;6;"at_formato";__ ("Formato");75;"";0;0;1)  //´6
			ALP_DefaultColSettings (xALP_ExportBankFiles;7;"at_Alineado";__ ("Alineado");49;"";0;0;1)  //´7
			ALP_DefaultColSettings (xALP_ExportBankFiles;8;"at_Relleno";__ ("Relleno");85;"";0;0;1)  //´8
			  //Modificado por: Saul Ponce (29/11/2017) Ticket 193963, evitar el formato erróneo al ingresar los valores en la celda
			  //ALP_DefaultColSettings (xALP_ExportBankFiles;9;"at_TextoFijo";__ ("Texto Fijo");70;"#0";0;0;1)  //´10
			ALP_DefaultColSettings (xALP_ExportBankFiles;9;"at_TextoFijo";__ ("Texto Fijo");70;"";0;0;1)
			ALP_DefaultColSettings (xALP_ExportBankFiles;10;"at_HeaderAC";__ ("Titulos");70;"#0";0;0;1)  //´10
		End if 
		If (PWTrf_h1=1)  //tab
			AT_Insert (1;3;->atACT_FillExp)
			atACT_FillExp{1}:="Espacio"  //8 Relleno
			atACT_FillExp{2}:="Cero"
			atACT_FillExp{3}:="Ajustado a contenido"
		Else   //ancho fijo banco y contabilidad
			AT_Insert (1;2;->atACT_FillExp)
			atACT_FillExp{1}:="Espacio"  //8 Relleno
			atACT_FillExp{2}:="Cero"
		End if 
		$areaList:=xALP_ExportBankFiles
	: ($area=4)  //importacion
		AT_Initialize (->atACT_FillExp;->atACT_AlinExp)
		If (PWTrf_h1=1)  //separado por algún caracter
			ALP_DefaultColSettings (xALP_ImportPagos;1;"al_Numero";__ ("Posición");50;"##0";2;0;0)  //´1
			ALP_DefaultColSettings (xALP_ImportPagos;2;"at_Descripcion";__ ("Descripción");120;"";0;0;1)  //´2
			ALP_DefaultColSettings (xALP_ImportPagos;3;"at_Alineado";__ ("Alineado de datos \ren la celda");95;"";0;0;1)  //´3
			  //ALP_DefaultColSettings (xALP_ImportPagos;4;"at_Relleno";__ ("Relleno");95;"";0;0;1)  //´4
			ALP_DefaultColSettings (xALP_ImportPagos;4;"at_Relleno";__ ("Relleno/Formato");95;"";0;0;1)  //´4//20180822 RCH Ticket 214674
			ALP_DefaultColSettings (xALP_ImportPagos;5;"al_Decimales";__ ("Decimales");50;"##0";0;0;1)  //´5
			AT_Insert (1;3;->atACT_FillExp)
			atACT_FillExp{1}:="Espacio"  //8 Relleno
			atACT_FillExp{2}:="Cero"
			atACT_FillExp{3}:="Ajustado a contenido"
			APPEND TO ARRAY:C911(atACT_FillExp;"-")  //20180822 RCH Ticket 214674
			APPEND TO ARRAY:C911(atACT_FillExp;"DDMMAAAA")
			APPEND TO ARRAY:C911(atACT_FillExp;"DDMMAA")
			APPEND TO ARRAY:C911(atACT_FillExp;"MMDDAAAA")
			APPEND TO ARRAY:C911(atACT_FillExp;"MMDDAA")
			APPEND TO ARRAY:C911(atACT_FillExp;"AAAAMMDD")
			APPEND TO ARRAY:C911(atACT_FillExp;"AAMMDD")
			
			APPEND TO ARRAY:C911(atACT_FillExp;"DDMMAAAA con separador")
			APPEND TO ARRAY:C911(atACT_FillExp;"DDMMAA con separador")
			APPEND TO ARRAY:C911(atACT_FillExp;"MMDDAAAA con separador")
			APPEND TO ARRAY:C911(atACT_FillExp;"MMDDAA con separador")
			APPEND TO ARRAY:C911(atACT_FillExp;"AAAAMMDD con separador")
			APPEND TO ARRAY:C911(atACT_FillExp;"AAMMDD con separador")
			
		Else   //archivo plano  (ancho fijo)
			ALP_DefaultColSettings (xALP_ImportPagos;1;"at_Descripcion";__ ("Descripción");110;"";0;0;1)  //´1
			ALP_DefaultColSettings (xALP_ImportPagos;2;"al_PosIni";__ ("Pos.\rInicial");45;"###0";2;0;0)  //´2
			ALP_DefaultColSettings (xALP_ImportPagos;3;"al_Largo";__ ("Largo");45;"###0";2;0;1)  //´3
			ALP_DefaultColSettings (xALP_ImportPagos;4;"at_Alineado";__ ("Alineado de datos \ren la celda");85;"";0;0;1)  //´
			  //ALP_DefaultColSettings (xALP_ImportPagos;5;"at_Relleno";__ ("Relleno");85;"";0;0;1)  //´5
			ALP_DefaultColSettings (xALP_ImportPagos;5;"at_Relleno";__ ("Relleno/Formato");85;"";0;0;1)  //´5 //20180822 RCH Ticket 214674
			ALP_DefaultColSettings (xALP_ImportPagos;6;"al_Decimales";__ ("Decimales");40;"##0";0;0;1)  //´6
			AT_Insert (1;2;->atACT_FillExp)
			atACT_FillExp{1}:="Espacio"  //8 Relleno
			atACT_FillExp{2}:="Cero"
			APPEND TO ARRAY:C911(atACT_FillExp;"-")  //20180822 RCH Ticket 214674
			APPEND TO ARRAY:C911(atACT_FillExp;"DDMMAAAA")
			APPEND TO ARRAY:C911(atACT_FillExp;"DDMMAA")
			APPEND TO ARRAY:C911(atACT_FillExp;"MMDDAAAA")
			APPEND TO ARRAY:C911(atACT_FillExp;"MMDDAA")
			APPEND TO ARRAY:C911(atACT_FillExp;"AAAAMMDD")
			APPEND TO ARRAY:C911(atACT_FillExp;"AAMMDD")
			
			APPEND TO ARRAY:C911(atACT_FillExp;"DDMMAAAA con separador")
			APPEND TO ARRAY:C911(atACT_FillExp;"DDMMAA con separador")
			APPEND TO ARRAY:C911(atACT_FillExp;"MMDDAAAA con separador")
			APPEND TO ARRAY:C911(atACT_FillExp;"MMDDAA con separador")
			APPEND TO ARRAY:C911(atACT_FillExp;"AAAAMMDD con separador")
			APPEND TO ARRAY:C911(atACT_FillExp;"AAMMDD con separador")
		End if 
		AT_Insert (1;2;->atACT_AlinExp)
		atACT_AlinExp{1}:="Der"  //7 Alineado
		atACT_AlinExp{2}:="Izq"
		$areaList:=xALP_ImportPagos
End case 

ALP_SetDefaultAppareance ($areaList;9;2;2;2;6)
AL_SetColOpts ($areaList;1;1;1;0;0)
AL_SetRowOpts ($areaList;0;1;0;0;1;0)
AL_SetCellOpts ($areaList;0;1;1)
AL_SetMiscOpts ($areaList;0;0;"\\";0;1)
AL_SetMainCalls ($areaList;"";"")
AL_SetSortOpts ($areaList;1;0)
AL_SetCallbacks ($areaList;"xAL_ACT_CBEntry_ExportBankFiles";"xAL_ACT_CBExit_ExportBankFiles")
AL_SetScroll ($areaList;0;-3)
AL_SetEntryOpts ($areaList;3;0;0;1;0;<>tXS_RS_DecimalSeparator;1)
AL_SetDrgOpts ($areaList;0;30;0)

  //dragging options

AL_SetDrgSrc ($areaList;1;"";"";"")
AL_SetDrgSrc ($areaList;2;"";"";"")
AL_SetDrgSrc ($areaList;3;"";"";"")
AL_SetDrgDst ($areaList;1;"";"";"")
AL_SetDrgDst ($areaList;1;"";"";"")
AL_SetDrgDst ($areaList;1;"";"";"")

Case of 
	: (((($area=1) & (cs_encabezado=0)) | (($area=2) & (cs_registroControl=0))) & ((WTrf_tb2=1) | (WTrf_ac2=1)))  //bloqueo cuando sea nuevo archivo y habilito cuando sea una modificación
		AL_SetEnterable ($areaList;1;0)
		AL_SetEnterable ($areaList;2;0)
		AL_SetEnterable ($areaList;3;0)
		AL_SetEnterable ($areaList;4;0)
		AL_SetEnterable ($areaList;5;0)
		AL_SetEnterable ($areaList;6;0)
		AL_SetEnterable ($areaList;7;0)
		AL_SetEnterable ($areaList;8;0)
		AL_SetEnterable ($areaList;9;0)
		AL_SetEnterable ($areaList;10;0)  //test
		IT_SetButtonState (False:C215;->bSubirLineaExp;->bBajarLineaExp;->bDeleteLine;->bInsertLine)
	: ($area<4)
		AL_SetEnterable ($areaList;1;0)
		AL_SetEnterable ($areaList;2;2;at_DescripcionExp)
		AL_SetEnterable ($areaList;4;1)
		AL_SetEnterable ($areaList;6;2;atACT_FormatExp)
		AL_SetEnterable ($areaList;7;2;atACT_AlinExp)
		AL_SetEnterable ($areaList;8;2;atACT_FillExp)
		AL_SetEnterable ($areaList;9;1)
		AL_SetEnterable ($areaList;10;1)  //test
		AL_SetFilter ($areaList;4;"&9")
	: ($area=4)
		If (PWTrf_h1=1)  //delimitado
			AL_SetEnterable ($areaList;1;1)  //número
			AL_SetEnterable ($areaList;2;0)  //descripción
			AL_SetEnterable ($areaList;3;2;atACT_AlinExp)  // alineado
			AL_SetEnterable ($areaList;4;2;atACT_FillExp)  //relleno 
			AL_SetEnterable ($areaList;5;1)  //decimales
			AL_SetFilter ($areaList;1;"&9")
			AL_SetFilter ($areaList;5;"&9")
		Else   //ancho fijo
			AL_SetEnterable ($areaList;1;0)  //descripción
			AL_SetEnterable ($areaList;2;1)  //inicio
			AL_SetEnterable ($areaList;3;1)  //largo
			AL_SetEnterable ($areaList;4;2;atACT_AlinExp)  //alineado
			AL_SetEnterable ($areaList;5;2;atACT_FillExp)  //relleno 
			AL_SetEnterable ($areaList;6;1)  //decimales
			
			AL_SetFilter ($areaList;2;"&9")
			AL_SetFilter ($areaList;3;"&9")
			AL_SetFilter ($areaList;6;"&9")
		End if 
End case 
IT_SetButtonState (True:C214;->bInsertLine)