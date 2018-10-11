C_TEXT:C284(vTipoUniv;vtACT_fileNameACT;$path;$document;$rut)
C_LONGINT:C283($err)
C_TIME:C306($ref)
C_BOOLEAN:C305($go)
$go:=False:C215
If (PWTrf_h2=1)  //aplano
	vlPos:=0
	WTrf_s1:=0
	WTrf_s2:=0
	WTrf_s3:=0
	$go:=True:C214
	If ((vlInicio=0) | (vlLargo=0) | (vtAlin="") | (vtRelleno=""))
		$go:=False:C215
		CD_Dlog (0;__ ("Debe completar todos los valores en el modo Archivo Plano para poder realizar la importación"))
	End if 
Else 
	If (PWTrf_h1=1)  //delimitado
		vlInicio:=0
		vlLargo:=0
		vtAlin:=""
		vtRelleno:=""
		$go:=True:C214
		If ((vlPos=0) | ((WTrf_s1=0) & (WTrf_s2=0) & (WTrf_s3=0)))
			$go:=False:C215
			CD_Dlog (0;__ ("Debe completar todos los valores en el modo Delimitado para poder realizar la importación"))
		End if 
	End if 
End if 

If ($go)
	at_Descripcion{1}:="Identificador único"
	at_idsTextos{1}:="6"
	al_PosIni{1}:=vlInicio
	al_Largo{1}:=vlLargo
	at_Alineado{1}:=vtAlin
	at_Relleno{1}:=vtRelleno
	al_Decimales{1}:=0
	al_Numero{1}:=vlPos
	vTipoUniv:="Universo"
	
	vt_ICodApr:=""
	
	C_BLOB:C604($blob)
	vt_ruta:=xfGetFileName 
	If (ok=1)
		If (SYS_TestPathName (vt_ruta)=Is a document:K24:1)
			vtACT_fileNameACT:=SYS_Path2FileName (vt_ruta)
			SET BLOB SIZE:C606($blob;0)
			EM_ErrorManager ("Install")
			EM_ErrorManager ("SetMode";"")
			DOCUMENT TO BLOB:C525(vt_ruta;$blob)
			EM_ErrorManager ("Clear")
		End if 
		If (ok=1)
			$path:=Temporary folder:C486+"ImportArchACT.txt"
			SYS_DeleteFile ($path)
			$ref:=Create document:C266($path)
			
			If (ok=1)
				CLOSE DOCUMENT:C267($ref)
				BLOB TO DOCUMENT:C526($path;$blob)
				$ref:=Open document:C264($path;"";Read mode:K24:5)
				If (ok=1)
					CLOSE DOCUMENT:C267($ref)
				End if 
			End if 
			
			If (Ok=1)
				C_LONGINT:C283($proc)
				$proc:=IT_UThermometer (1;0;__ ("Recopilando información..."))
				  //20121005 RCH 
				  //$err:=ACTabc_ImportByWizard ($document)
				$err:=ACTabc_ImportByWizard ($path;Current date:C33(*);False:C215;-10)
				DELETE DOCUMENT:C159($path)
				If ($err=0)
					ARRAY TEXT:C222(at_rutUniverso;0)
					COPY ARRAY:C226(aRUT;at_rutUniverso)
					ARRAY TEXT:C222(at_rutExApdoPAC;0)
					ARRAY TEXT:C222(at_nombreExApdoPAC;0)
					ARRAY TEXT:C222(at_rutPACValidado;0)
					ARRAY TEXT:C222(at_nombrePACValidado;0)
					ARRAY TEXT:C222(at_rutNoIdentificados;0)
					ARRAY TEXT:C222(at_rutNoApoCta;0)
					ARRAY TEXT:C222(at_nombreNoApoCta;0)
					ARRAY TEXT:C222(at_rutMasDeUnaPersona;0)
					ARRAY TEXT:C222(at_rutApdoCtaNoPac;0)
					ARRAY TEXT:C222(at_nombreApdoCtaNoPac;0)
					ARRAY TEXT:C222(at_rutInvalido;0)
					
					For ($i;1;Size of array:C274(at_rutUniverso))
						at_rutUniverso{$i}:=ST_GetCleanString (at_rutUniverso{$i})
						$rut:=CTRY_CL_VerifRUT (at_rutUniverso{$i};False:C215)
						If ($rut#"")
							QUERY:C277([Personas:7];[Personas:7]RUT:6=at_rutUniverso{$i})
							If (Records in selection:C76([Personas:7])>0)
								If (Records in selection:C76([Personas:7])=1)
									If ([Personas:7]ES_Apoderado_de_Cuentas:42)
										  //20121005 RCH
										  //If ([Personas]ACT_Modo_de_pago="Pago Automático de Cuenta")
										If ([Personas:7]ACT_id_modo_de_pago:94=-10)
											AT_Insert (0;1;->at_rutPACValidado;->at_nombrePACValidado)
											at_rutPACValidado{Size of array:C274(at_rutPACValidado)}:=at_rutUniverso{$i}
											at_nombrePACValidado{Size of array:C274(at_nombrePACValidado)}:=[Personas:7]Apellidos_y_nombres:30
										Else 
											AT_Insert (0;1;->at_rutApdoCtaNoPac;->at_nombreApdoCtaNoPac)
											at_rutApdoCtaNoPac{Size of array:C274(at_rutApdoCtaNoPac)}:=at_rutUniverso{$i}
											at_nombreApdoCtaNoPac{Size of array:C274(at_nombreApdoCtaNoPac)}:=[Personas:7]Apellidos_y_nombres:30
										End if 
									Else 
										AT_Insert (0;1;->at_rutNoApoCta;->at_nombreNoApoCta)
										at_rutNoApoCta{Size of array:C274(at_rutNoApoCta)}:=at_rutUniverso{$i}
										at_nombreNoApoCta{Size of array:C274(at_rutNoApoCta)}:=[Personas:7]Apellidos_y_nombres:30
									End if 
								Else 
									AT_Insert (0;1;->at_rutMasDeUnaPersona)
									at_rutMasDeUnaPersona{Size of array:C274(at_rutMasDeUnaPersona)}:=at_rutUniverso{$i}
								End if 
							Else 
								AT_Insert (0;1;->at_rutNoIdentificados)
								at_rutNoIdentificados{Size of array:C274(at_rutNoIdentificados)}:=at_rutUniverso{$i}
							End if 
						Else 
							AT_Insert (0;1;->at_rutInvalido)
							at_rutInvalido{Size of array:C274(at_rutInvalido)}:=at_rutUniverso{$i}
						End if 
					End for 
					
					ARRAY LONGINT:C221($al_rnPersonas;0)
					ARRAY TEXT:C222(at_rutPACActTemp;0)
					ARRAY TEXT:C222(at_nombrePACActTemp;0)
					C_LONGINT:C283($encontrado)
					  //20121005 RCH
					  //QUERY([Personas];[Personas]ACT_Modo_de_pago=atACT_Modo_de_Pago{2};*)
					QUERY:C277([Personas:7];[Personas:7]ACT_id_modo_de_pago:94=-10;*)
					QUERY:C277([Personas:7]; & ;[Personas:7]ES_Apoderado_de_Cuentas:42=True:C214)
					If (Records in selection:C76([Personas:7])>0)
						SELECTION TO ARRAY:C260([Personas:7]RUT:6;at_rutPACActTemp;[Personas:7]Apellidos_y_nombres:30;at_nombrePACActTemp;[Personas:7];$al_rnPersonas)
						For ($i;1;Size of array:C274(at_rutPACActTemp))
							$encontrado:=Find in array:C230(at_rutUniverso;at_rutPACActTemp{$i})
							If ($encontrado<0)
								GOTO RECORD:C242([Personas:7];$al_rnPersonas{$i})
								AT_Insert (0;1;->at_rutExApdoPAC;->at_nombreExApdoPAC)
								at_rutExApdoPAC{Size of array:C274(at_rutExApdoPAC)}:=[Personas:7]RUT:6
								at_nombreExApdoPAC{Size of array:C274(at_nombreExApdoPAC)}:=[Personas:7]Apellidos_y_nombres:30
							End if 
						End for 
					End if 
					
					C_REAL:C285(numProcesados;numAprobados;numRechazados;numNoIdentif;numMasdeUnApdo;numInvalidos;numNoApdoCta)
					numProcesados:=Size of array:C274(at_rutUniverso)
					numAprobados:=Size of array:C274(at_rutPACValidado)
					numRechazados:=Size of array:C274(at_rutExApdoPAC)
					numNoIdentif:=Size of array:C274(at_rutNoIdentificados)
					numMasdeUnApdo:=Size of array:C274(at_rutMasDeUnaPersona)
					numInvalidos:=Size of array:C274(at_rutInvalido)
					numNoApdoCta:=Size of array:C274(at_rutNoApoCta)
					
					IT_UThermometer (-2;$proc)
					
					WDW_OpenFormWindow (->[xxACT_ArchivosBancarios:118];"ACT_PreImportUniverso";0;4;__ ("Datos Importados"))
					DIALOG:C40([xxACT_ArchivosBancarios:118];"ACT_PreImportUniverso")
					CLOSE WINDOW:C154
					AT_Initialize (->aMonto;->aRUT;->aDescCodigo;->aCodAprobacion;->aNumTarjeta;->aNombre;->aFechaPagos;->aSerieCheque;->aFechaDctoCheque;->aCuentaCheque;->aBancoCheque;->aLugarDePago;->aNoOperacion)
					AT_Initialize (->at_rutUniverso;->at_rutExApdoPAC;->at_nombreExApdoPAC;->at_rutPACValidado;->at_nombrePACValidado;->at_rutNoIdentificados;->at_rutNoApoCta;->at_nombreNoApoCta;->at_rutMasDeUnaPersona;->at_rutApdoCtaNoPac;->at_nombreApdoCtaNoPac;->at_rutInvalido)
					AT_Initialize (->at_rutPACActTemp;->at_nombrePACActTemp)
				End if 
			Else 
				CD_Dlog (0;__ ("No se encontró información en el archivo de texto seleccionado."))
			End if 
		Else 
			CD_Dlog (0;__ ("El archivo no pudo ser abierto"))
		End if 
	Else 
		CD_Dlog (0;__ ("El archivo no pudo ser abierto"))
	End if 
End if 