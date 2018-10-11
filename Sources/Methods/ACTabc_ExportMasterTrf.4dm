//%attributes = {}
  //ACTabc_ExportMasterTrf

C_TEXT:C284($2;$3)  //No incluir en archivo de exportacion!!!
C_DATE:C307(vQR_Date1)
vVerifier:="ColegiumTransferFile"
vType:="exporter"

C_POINTER:C301($FieldPtr;$ptrFieldCargo)
C_TEXT:C284($fileName;$folderPath;$filePath;$line;$fecha;$numTrans)
C_LONGINT:C283($i;$Apdo;$linea)
C_TIME:C306($ref)
C_TEXT:C284($diaFecha;$montoTotal;$footer)
C_TEXT:C284(vtotalPAT;vnumTransPAT;vfechaPAT)
C_TEXT:C284($tipoArchivo)
C_LONGINT:C283($noCuotas)
C_TEXT:C284($textoTemp;$textoTemp2)
C_BOOLEAN:C305($boleta)
C_DATE:C307($vd_fechaUF)
C_REAL:C285($vr_montoTotalArchivo)
C_LONGINT:C283($vl_idFormaDePago)
C_TEXT:C284(vt_total;vtACT_Fecha)

ARRAY TEXT:C222(at_textosFinales;0)
ARRAY TEXT:C222(at_Textos;0)
_O_ARRAY STRING:C218(1;as1_Pad;0)  //espacio o 0
ARRAY LONGINT:C221(al1_Largo;0)
_O_ARRAY STRING:C218(1;as1_Posicion;0)  //d o l
ARRAY TEXT:C222(as1_Delimiter;0)
ARRAY LONGINT:C221(aidsAvisos;0)
ARRAY LONGINT:C221(aidsPersonas;0)
C_LONGINT:C283($suma;$totalAvisos)  //variables utilizadas para el cd_thermometre
C_LONGINT:C283($el)  //para utilizar el monto seleccionado en el asistente
$suma:=0

$fileName:=$1
$FieldPtr:=Field:C253(Num:C11($2);Num:C11($3))
If (KRL_isSameField (->[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14;$FieldPtr))
	$ptrFieldCargo:=->[ACT_Cargos:173]Saldo:23
Else 
	$ptrFieldCargo:=->[ACT_Cargos:173]Monto_Neto:5
End if 

If (Count parameters:C259>=4)
	$vd_fechaUF:=$4
End if 
If (Count parameters:C259>=5)
	$vl_idFormaDePago:=$5
End if 

If ($vd_fechaUF=!00-00-00!)
	$vd_fechaUF:=Current date:C33(*)
End if 

  //para ordenar ascendente o descendente los alumnos... Por defecto es ascendente.
C_LONGINT:C283($vl_Pref)
$vl_Pref:=Num:C11(PREF_fGet (0;"ACT_OrdenAlumnosEnAB";String:C10($vl_Pref)))
  //PREF_Set (0;"ACT_OrdenAlumnosEnAB";"1")

READ ONLY:C145([ACT_Transacciones:178])
READ ONLY:C145([ACT_Cargos:173])
READ ONLY:C145([ACT_Documentos_de_Cargo:174])
If (vl_SeleccionItem=1)
	KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
	KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
	QRY_QueryWithArray (->[ACT_Cargos:173]ID:1;->al_idItems;True:C214)
	KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->[ACT_Cargos:173]ID_Documento_de_Cargo:3;"")
	KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;"")
End if 
CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"Avisos")
$totalAvisos:=Records in selection:C76([ACT_Avisos_de_Cobranza:124])

  //$tipoArchivo:=Substring($fileName;1;3)
$tipoArchivo:=KRL_GetTextFieldData (->[ACT_Formas_de_Pago:287]id:1;->$vl_idFormaDePago;->[ACT_Formas_de_Pago:287]glosa_forma_de_pago:9)
  //If (($tipoArchivo="PAC") | ($tipoArchivo="PAT") | ($tipoArchivo="CUP"))
  //Else 
  //$tipoArchivo:=Substring($fileName;4;3)
  //End if 

C_POINTER:C301($ptrDeclaracion)
C_LONGINT:C283($type)
C_BOOLEAN:C305($FieldValid)
C_BOOLEAN:C305($vb_hayCampoCtaCte)
C_BOOLEAN:C305($vb_hayCampoAlumno)
$FieldValid:=True:C214
ARRAY LONGINT:C221($al_tipoArreglos;Size of array:C274(al_Numero))
ARRAY POINTER:C280($ptrCampo;Size of array:C274(al_Numero))
For ($i;1;Size of array:C274(al_Numero))
	If ((al_recordTablePointersExpTemp{$i}#-1) | (al_recordFieldPointersExpTemp{$i}#-1))
		$ptrCampo{$i}:=Field:C253(al_recordTablePointersExpTemp{$i};al_recordFieldPointersExpTemp{$i})
		$type:=Type:C295($ptrCampo{$i}->)
		Case of 
			: (($type=Is integer:K8:5) | ($type=Is longint:K8:6))  //1
				$al_tipoArreglos{$i}:=1
			: ($type=Is real:K8:4)  //2
				$al_tipoArreglos{$i}:=2
			: ($type=Is date:K8:7)  //3
				$al_tipoArreglos{$i}:=3
			: (($Type=Is alpha field:K8:1) | ($type=Is text:K8:3))  //4
				$al_tipoArreglos{$i}:=4
			: ($type=Is boolean:K8:9)  //5
				$al_tipoArreglos{$i}:=5
			Else 
				$0:=1
				$FieldValid:=False:C215
				$i:=Size of array:C274(al_Numero)
				CD_Dlog (0;__ ("Type ")+String:C10($type)+__ (" is not supported."))
		End case 
		If (Not:C34($vb_hayCampoCtaCte) & Not:C34($vb_hayCampoAlumno))
			Case of 
				: (Table:C252($ptrCampo{$i})=Table:C252(->[ACT_CuentasCorrientes:175]))
					$vb_hayCampoCtaCte:=True:C214
					
				: (Table:C252($ptrCampo{$i})=Table:C252(->[Alumnos:2]))
					$vb_hayCampoAlumno:=True:C214
					
			End case 
		End if 
		If (Not:C34($boleta))
			$boleta:=(Table:C252($ptrCampo{$i})=Table:C252(->[ACT_Boletas:181]))
		End if 
	Else 
		$al_tipoArreglos{$i}:=-1
	End if 
End for 

If ($FieldValid)
	$el:=Find in array:C230($ptrCampo;->[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14)
	If ($el>=0)
		$ptrCampo{$el}:=$FieldPtr
	Else 
		$el:=Find in array:C230($ptrCampo;->[ACT_Avisos_de_Cobranza:124]Monto_Neto:11)
		If ($el>=0)
			$ptrCampo{$el}:=$FieldPtr
		End if 
	End if 
	
	C_POINTER:C301($ptrTable;$ptrField;$ptrArray)
	ARRAY LONGINT:C221($al_identificadores;0)
	C_LONGINT:C283($vl_avisos)
	
	$ptrArray:=->$al_identificadores
	If ((vl_ExportXAC=0) | (cb_IncluirSaldosAnteriores=1))
		$ptrTable:=->[ACT_Avisos_de_Cobranza:124]
		$ptrField:=->[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3
		AT_DistinctsFieldValues (->[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;$ptrArray)
	Else 
		$ptrTable:=->[ACT_Avisos_de_Cobranza:124]
		$ptrField:=->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1
		SELECTION TO ARRAY:C260([ACT_Avisos_de_Cobranza:124]ID_Aviso:1;$ptrArray->)
	End if 
	
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Recopilando información para archivo ")+$tipoArchivo+__ ("..."))
	For ($vl_avisos;1;Size of array:C274($ptrArray->))
		REDUCE SELECTION:C351([Personas:7];0)
		REDUCE SELECTION:C351([Familia_RelacionesFamiliares:77];0)
		REDUCE SELECTION:C351([Familia:78];0)
		REDUCE SELECTION:C351([ACT_CuentasCorrientes:175];0)
		REDUCE SELECTION:C351([Alumnos:2];0)
		USE SET:C118("Avisos")
		AT_Initialize (->at_textos;->as1_Pad;->al1_Largo;->as1_Posicion;->as1_Delimiter)
		QUERY SELECTION:C341($ptrTable->;$ptrField->=$ptrArray->{$vl_avisos})
		ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5;<)
		If ($vl_avisos=1)
			vQR_Date1:=[ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5
		End if 
		If ($boleta)
			KRL_RelateSelection (->[ACT_Transacciones:178]No_Comprobante:10;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
			KRL_RelateSelection (->[ACT_Boletas:181]ID:1;->[ACT_Transacciones:178]No_Boleta:9;"")
			ORDER BY:C49([ACT_Boletas:181];[ACT_Boletas:181]ID:1;>)
		End if 
		CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"AvisosARetirar")  //para quitar del set principal
		
		KRL_RelateSelection (->[ACT_Transacciones:178]No_Comprobante:10;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
		KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
		
		$set:="setCargos"
		CREATE SET:C116([ACT_Cargos:173];$set)
		ACTac_OpcionesGenerales ("FiltraAvisosGenArchivoBancario";->$set)
		
		If (vl_SeleccionItem=1)
			USE SET:C118($set)
			QRY_QueryWithArray (->[ACT_Cargos:173]ID:1;->al_idItems;True:C214)
			CREATE SET:C116([ACT_Cargos:173];$set)
		End if 
		
		If (vl_otrasMonedas=1)
			$vr_monto:=Abs:C99(ACTcar_CalculaMontos ("redondeadoFromSetMPago";->$set;$ptrFieldCargo;$vd_fechaUF))
		Else 
			$vr_monto:=Abs:C99(ACTcar_CalculaMontos ("redondeadoFromSetMEmision";->$set;$ptrFieldCargo;$vd_fechaUF))
		End if 
		CLEAR SET:C117($set)
		$vr_montoTotalArchivo:=$vr_montoTotalArchivo+$vr_monto
		
		USE SET:C118("AvisosARetirar")
		ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5;<)
		QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
		QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Persona:3=[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
		QUERY:C277([Familia:78];[Familia:78]Numero:1=[Familia_RelacionesFamiliares:77]ID_Familia:2)
		
		If ($vb_hayCampoCtaCte | $vb_hayCampoAlumno)
			KRL_RelateSelection (->[ACT_Transacciones:178]No_Comprobante:10;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
			KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Transacciones:178]ID_CuentaCorriente:2;"")
			KRL_RelateSelection (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3;"")
			If ($vl_Pref=0)
				ORDER BY:C49([Alumnos:2];[Alumnos:2]nivel_numero:29;>;[Alumnos:2]curso:20;>;[Alumnos:2]apellidos_y_nombres:40;>)
			Else 
				ORDER BY:C49([Alumnos:2];[Alumnos:2]nivel_numero:29;<;[Alumnos:2]curso:20;<;[Alumnos:2]apellidos_y_nombres:40;>)
			End if 
			ARRAY LONGINT:C221($al_idsAlumnos;0)
			ARRAY LONGINT:C221($al_recNumsCtas;0)
			ARRAY LONGINT:C221($al_idsAlumnosCtas;0)
			SELECTION TO ARRAY:C260([ACT_CuentasCorrientes:175];$al_recNumsCtas;[ACT_CuentasCorrientes:175]ID_Alumno:3;$al_idsAlumnosCtas)
			SELECTION TO ARRAY:C260([Alumnos:2]numero:1;$al_idsAlumnos)
			AT_OrderArraysByArray (MAXLONG:K35:2;->$al_idsAlumnos;->$al_idsAlumnosCtas;->$al_recNumsCtas)
			CREATE SELECTION FROM ARRAY:C640([ACT_CuentasCorrientes:175];$al_recNumsCtas;"")
			FIRST RECORD:C50([Alumnos:2])
			FIRST RECORD:C50([ACT_CuentasCorrientes:175])
		End if 
		
		For ($r;1;Size of array:C274($al_tipoArreglos))
			AT_Insert (0;1;->at_textos;->as1_Pad;->al1_Largo;->as1_Posicion;->as1_Delimiter)
			If ($al_tipoArreglos{$r}>0)
				Case of 
					: ($al_tipoArreglos{$r}=3)  //tipo campo fecha
						C_TEXT:C284($vt_fechaTemp)
						C_DATE:C307($vd_fecha)
						$vd_fecha:=$ptrCampo{$r}->
						C_TEXT:C284($vt_fechaTemp;$dia;$mes;$agno)
						$dia:=ST_RigthChars ("00"+String:C10(Day of:C23($vd_fecha));2)
						$mes:=ST_RigthChars ("00"+String:C10(Month of:C24($vd_fecha));2)
						$agno:=String:C10(Year of:C25($vd_fecha))
						If (($vl_idFormaDePago=-10) & (KRL_isSameField (->[ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5;$ptrCampo{$r})))
							$dia:=ST_Boolean2Str ((cb_DiaApdo=1);String:C10([Personas:7]ACT_DiaCargo:61;"00");String:C10(vl_DiaApdo;"00"))
						End if 
						$vt_fechaTemp:=$mes+$dia+$agno  //formato mm/dd/yyyy
						at_textos{Size of array:C274(at_textos)}:=ACTtrf_Master (5;at_formato{$r};$vt_fechaTemp)
					: (($al_tipoArreglos{$r}=1) | ($al_tipoArreglos{$r}=2))  //algún tipo de número
						Case of 
							: ((KRL_isSameField (->[ACT_Avisos_de_Cobranza:124]Monto_Neto:11;$ptrCampo{$r})) | (KRL_isSameField (->[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14;$ptrCampo{$r})))
								If ($vl_idFormaDePago=-11)  //para cuponera se divide el monto total de los avisos por el número de cuotas configurado pensando en que la cuponera se saca para todo el año
									If ((at_formato{$r}#"Monto total") & (at_formato{$r}#"Monto total con 2 decimales") & (at_formato{$r}#"Monto total con 4 decimales"))
										If ([Personas:7]ACT_NoCuotasCup:80<=0)
											$noCuotas:=10
										Else 
											$noCuotas:=[Personas:7]ACT_NoCuotasCup:80
										End if 
										$vl_decimales:=0
										Case of 
											: (at_formato{$r}="Monto total con 2 decimales")
												$vl_decimales:=2
											: (at_formato{$r}="Monto total con 4 decimales")
												$vl_decimales:=4
											: (at_formato{$r}="Monto total con 2 decimales con separador")
												$vl_decimales:=2
											: (at_formato{$r}="Monto total con 4 decimales con separador")
												$vl_decimales:=4
										End case 
										If ((vl_otrasMonedas=1) | ((vl_otrasMonedas=0) & (<>vsACT_MonedaColegio=ST_GetWord (ACT_DivisaPais ;1;";"))))
											$vl_decimales:=<>vlACT_Decimales
										End if 
										
										at_textos{Size of array:C274(at_textos)}:=ACTtrf_Master (5;Replace string:C233(at_formato{$r};" total";"");String:C10(Round:C94($vr_monto/$noCuotas;$vl_decimales)))  //montos
									Else 
										at_textos{Size of array:C274(at_textos)}:=ACTtrf_Master (5;Replace string:C233(at_formato{$r};" total";"");String:C10($vr_monto))  //montos
									End if 
								Else 
									at_textos{Size of array:C274(at_textos)}:=ACTtrf_Master (5;at_formato{$r};String:C10($vr_monto))  //montos
								End if 
							: (KRL_isSameField (->[Personas:7]ACT_DiaCargo:61;$ptrCampo{$r}))
								If ($vl_idFormaDePago=-10)
									$dia:=ST_Boolean2Str ((cb_DiaApdo=1);String:C10([Personas:7]ACT_DiaCargo:61;"00");String:C10(vl_DiaApdo;"00"))
									$texto:=ST_RigthChars ("00"+String:C10(vl_MesApdo);2)+ST_RigthChars ("00"+$dia;2)+String:C10(vl_AñoApdo)  //mmddaaaa
								Else 
									$dia:=String:C10([Personas:7]ACT_DiaCargo:61)
									$texto:=ST_RigthChars ("00"+String:C10(Month of:C24(Current date:C33(*)));2)+ST_RigthChars ("00"+$dia;2)+String:C10(Year of:C25(Current date:C33(*)))  //mmddaaaa
								End if 
								at_textos{Size of array:C274(at_textos)}:=ACTtrf_Master (5;at_formato{$r};$texto)
							Else 
								at_textos{Size of array:C274(at_textos)}:=ACTtrf_Master (5;at_formato{$r};String:C10($ptrCampo{$r}->))
						End case 
					: ($al_tipoArreglos{$r}=4)  //alpha, string, texto
						Case of 
							: ((KRL_isSameField (->[Personas:7]RUT:6;$ptrCampo{$r})) | (KRL_isSameField (->[Personas:7]ACT_RUTTitular_TC:56;$ptrCampo{$r})) | (KRL_isSameField (->[Personas:7]ACT_RUTTitutal_Cta:50;$ptrCampo{$r})))
								at_textos{Size of array:C274(at_textos)}:=ST_Uppercase (ACTtrf_Master (5;at_formato{$r};$ptrCampo{$r}->))
							: ((KRL_isSameField (->[Personas:7]ACT_AñoVenc_TC:58;$ptrCampo{$r})) | (KRL_isSameField (->[Personas:7]ACT_MesVenc_TC:57;$ptrCampo{$r})))
								C_TEXT:C284($mesTC;$agnoTC;$texto)
								$mesTC:=""
								$agnoTC:=""
								$mesTC:=ST_RigthChars ("00"+[Personas:7]ACT_MesVenc_TC:57;2)
								$agnoTC:=ST_RigthChars ("0000"+[Personas:7]ACT_AñoVenc_TC:58;4)
								$texto:=$mesTC+$agnoTC
								at_textos{Size of array:C274(at_textos)}:=ACTtrf_Master (5;at_formato{$r};$texto)
							: (KRL_isSameField (->[Personas:7]ACT_Numero_TC:54;$ptrCampo{$r}))
								C_TEXT:C284($vt_numTC)
								$vt_numTC:=ACTpp_CRYPTTC ("xxACT_GetDecryptTC";$ptrCampo{$r})
								at_textos{Size of array:C274(at_textos)}:=ACTtrf_Master (5;at_formato{$r};$vt_numTC)
							: (KRL_isSameField (->[ACT_Cargos:173]Glosa:12;$ptrCampo{$r}))
								READ ONLY:C145([xxACT_Items:179])
								QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=[ACT_Cargos:173]Ref_Item:16)
								If (Records in selection:C76([xxACT_Items:179])=1)
									at_textos{Size of array:C274(at_textos)}:=ACTtrf_Master (5;at_formato{$r};[xxACT_Items:179]Glosa_de_Impresión:20)
								Else 
									at_textos{Size of array:C274(at_textos)}:=ACTtrf_Master (5;at_formato{$r};$ptrCampo{$r}->)
								End if 
							Else 
								at_textos{Size of array:C274(at_textos)}:=ACTtrf_Master (5;at_formato{$r};$ptrCampo{$r}->)
						End case 
					Else   //los demás tipos
						If ($al_tipoArreglos{$r}=Is boolean:K8:9)
							at_textos{Size of array:C274(at_textos)}:=ACTtrf_Master (5;at_formato{$r};String:C10(Num:C11($ptrCampo{$r}->)))
						Else 
							at_textos{Size of array:C274(at_textos)}:=ACTtrf_Master (5;at_formato{$r};String:C10($ptrCampo{$r}->))
						End if 
				End case 
			Else 
				Case of 
					: (at_Descripcion{$r}="Texto fijo")
						at_textos{Size of array:C274(at_textos)}:=at_TextoFijo{$r}
						
					: (at_Descripcion{$r}="Día Juliano")
						Case of 
							: (at_formato{$r}="Día Juliano a fecha de Generación del archivo")
								$vd_fechaJulianoFin:=Current date:C33(*)
							: (at_formato{$r}="Día Juliano a fecha de Emisión del aviso")
								$vd_fechaJulianoFin:=[ACT_Avisos_de_Cobranza:124]Fecha_Emision:4
							: (at_formato{$r}="Día Juliano a fecha de Vencimiento del aviso")
								$vd_fechaJulianoFin:=[ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5
							Else 
								$vd_fechaJulianoFin:=Current date:C33(*)
						End case 
						at_textos{Size of array:C274(at_textos)}:=ACTtrf_Master (4;String:C10($r);"";String:C10($vd_fechaJulianoFin))
						
					: (at_Descripcion{$r}="Número de Tarjeta de Crédito")  //20140526 RCH Se habilita como texto fijo puesto que el campo esta oculto en la estructur…
						C_TEXT:C284($vt_numTC)
						$vt_numTC:=ACTpp_CRYPTTC ("xxACT_GetDecryptTC";->[Personas:7]ACT_Numero_TC:54)
						at_textos{Size of array:C274(at_textos)}:=ACTtrf_Master (5;at_formato{$r};$vt_numTC)
						
				End case 
			End if 
			
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
			AT_Insert (1;1;->at_textosFinales)
			at_textosFinales{1}:=ST_ConcatenatePaddedStrings (->at_textos;->as1_Pad;->al1_Largo;->as1_Posicion;->as1_Delimiter)
			$suma:=$suma+Records in selection:C76([ACT_Avisos_de_Cobranza:124])
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$suma/$totalAvisos;__ ("Recopilando información para archivo ")+$tipoArchivo+__ ("..."))
		End if 
		DIFFERENCE:C122("Avisos";"AvisosARetirar";"Avisos")
		USE SET:C118("Avisos")
	End for 
	
	$vt_montoTotalArchivo:=String:C10($vr_montoTotalArchivo)
	
	$vt_despliegue:="|Despliegue_ACT"
	If ((vl_otrasMonedas=1) | (ST_GetWord (ACT_DivisaPais ;1;";")=<>vsACT_MonedaColegio))  // si se exporta en moneda nacional o en la moneda del pais, el formato es con los decimales correspondientes al pais
		$vt_despliegue:="|Despliegue_ACT_Pagos"
	End if 
	Case of 
		: ($vl_idFormaDePago=-10)
			vtotalPAC:=String:C10($vr_montoTotalArchivo;$vt_despliegue)
			vFechaPAC:=String:C10(Current date:C33(*);7)
		: ($vl_idFormaDePago=-9)
			vtotalPAT:=String:C10($vr_montoTotalArchivo;$vt_despliegue)
			vfechaPAT:=String:C10(Current date:C33(*);7)
		: ($vl_idFormaDePago=-11)
			vtotalCUP:=String:C10($vr_montoTotalArchivo;$vt_despliegue)
			vFechaCUP:=String:C10(Current date:C33(*);7)
		Else 
			vtACT_Fecha:=String:C10(Current date:C33(*);7)
			vt_total:=String:C10($vr_montoTotalArchivo;$vt_despliegue)
	End case 
	
	
	If (Records in set:C195("Avisos")>0)
		CLEAR SET:C117("Avisos")
	End if 
	If (Records in set:C195("AvisosARetirar")>0)
		CLEAR SET:C117("AvisosARetirar")
	End if 
	REDUCE SELECTION:C351([ACT_Avisos_de_Cobranza:124];0)  //temporal
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	
	
	  //$ref:=ACTabc_CreaDocumento ($tipoArchivo;$fileName)
	$ref:=ACTabc_CreaArchivo ($tipoArchivo;$fileName)  //20170222 RCH
	If (cs_encabezado=1)  //registro de encabezado
		AT_Initialize (->at_textos;->as1_Pad;->al1_Largo;->as1_Posicion;->as1_Delimiter)
		ARRAY TEXT:C222($at_headerTrf;0)
		C_TEXT:C284($vt_fechaTemp;$dia;$mes;$agno)
		For ($r;1;Size of array:C274(al_NumeroHe))  //encabezado
			AT_Insert (0;1;->at_textos;->as1_Pad;->al1_Largo;->as1_Posicion;->as1_Delimiter)
			Case of 
				: (at_DescripcionHe{$r}="Texto fijo")
					at_textos{Size of array:C274(at_textos)}:=at_TextoFijoHe{$r}
				: (at_DescripcionHe{$r}="Número total de transacciones")
					at_textos{Size of array:C274(at_textos)}:=String:C10(Size of array:C274(at_textosFinales))
				: (at_DescripcionHe{$r}="Suma total de las trasacciones")
					at_textos{Size of array:C274(at_textos)}:=$vt_montoTotalArchivo
					
				: (at_DescripcionHe{$r}="Día Juliano")
					Case of 
						: (at_formatoHe{$r}="Día Juliano a fecha de Generación del archivo")
							$vd_fechaJulianoFin:=Current date:C33(*)
							
						Else 
							$vd_fechaJulianoFin:=Current date:C33(*)
					End case 
					at_textos{Size of array:C274(at_textos)}:=ACTtrf_Master (6;at_DescripcionHe{$r};String:C10($vd_fechaJulianoFin))
					
				: (at_DescripcionHe{$r}="Fecha vencimiento primer aviso de cobranza")
					at_textos{Size of array:C274(at_textos)}:=ACTtrf_Master (6;at_DescripcionHe{$r};String:C10(vQR_Date1))
					
				: (at_DescripcionHe{$r}="Número total de transacciones + 1")
					at_textos{Size of array:C274(at_textos)}:=String:C10(Size of array:C274(at_textosFinales)+1)
					
				Else 
					at_textos{Size of array:C274(at_textos)}:=ACTtrf_Master (6;at_DescripcionHe{$r})
			End case 
			at_textos{Size of array:C274(at_textos)}:=ACTtrf_Master (5;at_formatoHe{$r};at_textos{Size of array:C274(at_textos)})
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
		End for 
		If (Size of array:C274(at_textos)>0)
			INSERT IN ARRAY:C227($at_headerTrf;1;1)
			$at_headerTrf{1}:=ST_ConcatenatePaddedStrings (->at_textos;->as1_Pad;->al1_Largo;->as1_Posicion;->as1_Delimiter)
			$at_headerTrf{1}:=$at_headerTrf{1}+"\r\n"
			IO_SendPacket ($ref;$at_headerTrf{1})
		End if 
	End if 
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generando archivo ")+$tipoArchivo+__ ("..."))
	For ($i;1;Size of array:C274(at_textosFinales))
		at_textosFinales{$i}:=at_textosFinales{$i}+"\r\n"
		IO_SendPacket ($ref;at_textosFinales{$i})
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(at_textosFinales);__ ("Generando archivo ")+$tipoArchivo+__ ("..."))
	End for 
	If ($vl_idFormaDePago=-10)
		vnumTransPAC:=String:C10(Size of array:C274(at_textosFinales))
	Else 
		If ($vl_idFormaDePago=-9)
			vnumTransPAT:=String:C10(Size of array:C274(at_textosFinales))
		Else 
			If ($vl_idFormaDePago=-11)
				vnumTransCUP:=String:C10(Size of array:C274(at_textosFinales))
			End if 
		End if 
	End if 
	If (cs_registroControl=1)  //registro de control
		AT_Initialize (->at_textos;->as1_Pad;->al1_Largo;->as1_Posicion;->as1_Delimiter)
		ARRAY TEXT:C222($at_footerTrf;0)
		C_TEXT:C284($vt_fechaTemp)
		For ($r;1;Size of array:C274(al_NumeroFo))  //encabezado
			AT_Insert (0;1;->at_textos;->as1_Pad;->al1_Largo;->as1_Posicion;->as1_Delimiter)
			Case of 
				: (at_DescripcionFo{$r}="Texto fijo")
					at_textos{Size of array:C274(at_textos)}:=at_TextoFijoFo{$r}
				: (at_DescripcionFo{$r}="Número total de transacciones")
					If ($vl_idFormaDePago=-10)
						at_textos{Size of array:C274(at_textos)}:=vnumTransPAC
					Else 
						If ($vl_idFormaDePago=-9)
							at_textos{Size of array:C274(at_textos)}:=vnumTransPAT
						Else 
							If ($vl_idFormaDePago=-11)
								at_textos{Size of array:C274(at_textos)}:=vnumTransCUP
							End if 
						End if 
					End if 
					
					  //at_textos{Size of array(at_textos)}:=vnumTransPAT
				: (at_DescripcionFo{$r}="Suma total de las trasacciones")
					at_textos{Size of array:C274(at_textos)}:=$vt_montoTotalArchivo
					
				: (at_DescripcionFo{$r}="Día Juliano")
					Case of 
						: (at_formatoFo{$r}="Día Juliano a fecha de Generación del archivo")
							$vd_fechaJulianoFin:=Current date:C33(*)
							
						Else 
							$vd_fechaJulianoFin:=Current date:C33(*)
					End case 
					at_textos{Size of array:C274(at_textos)}:=ACTtrf_Master (6;at_DescripcionFo{$r};String:C10($vd_fechaJulianoFin))
					
				: (at_DescripcionFo{$r}="Número total de transacciones + 1")
					If ($vl_idFormaDePago=-10)
						at_textos{Size of array:C274(at_textos)}:=vnumTransPAC
					Else 
						If ($vl_idFormaDePago=-9)
							at_textos{Size of array:C274(at_textos)}:=vnumTransPAT
						Else 
							If ($vl_idFormaDePago=-11)
								at_textos{Size of array:C274(at_textos)}:=vnumTransCUP
							End if 
						End if 
					End if 
					at_textos{Size of array:C274(at_textos)}:=String:C10(Num:C11(at_textos{Size of array:C274(at_textos)})+1)
					
				Else 
					at_textos{Size of array:C274(at_textos)}:=ACTtrf_Master (6;at_DescripcionFo{$r})
			End case 
			at_textos{Size of array:C274(at_textos)}:=ACTtrf_Master (5;at_formatoFo{$r};at_textos{Size of array:C274(at_textos)})  // PARA FORMATOS
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
		End for 
		If (Size of array:C274(at_textos)>0)
			INSERT IN ARRAY:C227($at_footerTrf;1;1)
			$at_footerTrf{1}:=ST_ConcatenatePaddedStrings (->at_textos;->as1_Pad;->al1_Largo;->as1_Posicion;->as1_Delimiter)
			$at_footerTrf{1}:=$at_footerTrf{1}+"\r\n"
			IO_SendPacket ($ref;$at_footerTrf{1})
		End if 
	End if 
	CLOSE DOCUMENT:C267($ref)
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	
	AT_Initialize (->at_textos;->as1_Pad;->al1_Largo;->as1_Posicion;->as1_Delimiter;->at_textosFinales;->aidsAvisos;->aidsPersonas)
	$0:=1
Else 
	$0:=-1
End if 
ACTtrf_Master (1)  //inicializa ARREGLOS