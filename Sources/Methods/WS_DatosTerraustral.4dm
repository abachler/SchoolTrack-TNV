//%attributes = {"publishedSoap":true,"publishedWsdl":true}
  //WS_DatosTerraustral



  //****DECLARACIONES****
C_TEXT:C284($1;$2;$3;$4;$5;$schoolID;$userName;$password;$tipo_Persona;$status;vtWS_ErrorString)
C_BLOB:C604(vxWS_Blob1;vxWS_Blob2;vxWS_Blob3;vxWS_Blob4;$blob;$compressedBlob)
C_LONGINT:C283($logged)
C_BOOLEAN:C305($b_archivoComprimido)
C_TEXT:C284($t_resultado)

  //ARCHIVO 1
ARRAY TEXT:C222(atWS_IdTransaccion_A1;0)
ARRAY TEXT:C222(atWS_RutAl_A1;0)
ARRAY TEXT:C222(atWS_NombresAl;0)
ARRAY TEXT:C222(atWS_ApellidoPaternoAl;0)
ARRAY TEXT:C222(atWS_ApellidoMaternoAl;0)
ARRAY TEXT:C222(atWS_SexoAl;0)
ARRAY TEXT:C222(atWS_FechaNacAl;0)
ARRAY TEXT:C222(atWS_DireccionAl;0)
ARRAY TEXT:C222(atWS_ComunaAl;0)
ARRAY TEXT:C222(atWS_TelefonoAl;0)
ARRAY TEXT:C222(atWS_CelularAl;0)
ARRAY TEXT:C222(atWS_EMailAl;0)
ARRAY TEXT:C222(atWS_CursoAl;0)

ARRAY TEXT:C222(atWS_RutAp;0)
ARRAY TEXT:C222(atWS_NombresAp;0)
ARRAY TEXT:C222(atWS_ApellidoPaternoAp;0)
ARRAY TEXT:C222(atWS_ApellidoMaternoAp;0)
ARRAY TEXT:C222(atWS_SexoAp;0)
ARRAY TEXT:C222(atWS_FechaNacAp;0)
ARRAY TEXT:C222(atWS_DireccionPartAp;0)
ARRAY TEXT:C222(atWS_ComunaPartAp;0)
ARRAY TEXT:C222(atWS_DireccionComtAp;0)
ARRAY TEXT:C222(atWS_ComunaComAp;0)
ARRAY TEXT:C222(atWS_TelefonoPartAp;0)
ARRAY TEXT:C222(atWS_CelularAp;0)
ARRAY TEXT:C222(atWS_TelefonoComAp;0)
ARRAY TEXT:C222(atWS_EMailAp;0)

  //ARCHIVO 2
ARRAY TEXT:C222(atWS_IdTransaccion_A2;0)
ARRAY TEXT:C222(atWS_RutAl_A2;0)
ARRAY TEXT:C222(atWS_NumContraro;0)
ARRAY TEXT:C222(atWS_RutApoCuentas_A2;0)
ARRAY TEXT:C222(atWS_FechaEmision;0)
ARRAY TEXT:C222(atWS_NumCuota;0)
ARRAY TEXT:C222(atWS_MontoCuota;0)
ARRAY TEXT:C222(atWS_FechaVencimiento_A2;0)

  //ARCHIVO 3
ARRAY TEXT:C222(atWS_IdTransaccion_A3;0)
ARRAY TEXT:C222(atWS_RutAl_A3;0)
ARRAY TEXT:C222(atWS_RutApoCuentas_A3;0)
ARRAY TEXT:C222(atWS_CodBanco;0)
ARRAY TEXT:C222(atWS_CuentaCte;0)
ARRAY TEXT:C222(atWS_NumCheque;0)
ARRAY TEXT:C222(atWS_FechaVencimiento_A3;0)
ARRAY TEXT:C222(atWS_MontoCheque;0)

  //ARCHIVO 4
ARRAY TEXT:C222(atWS_IdTransaccion_A4;0)
ARRAY TEXT:C222(atWS_RutAl_A4;0)
ARRAY TEXT:C222(atWS_RutApoCuentas_A4;0)
ARRAY TEXT:C222(atWS_Monto;0)
ARRAY TEXT:C222(atWS_TipoTarjeta;0)
ARRAY TEXT:C222(atWS_NombreTarjeta;0)

  //ARCHIVO 5
ARRAY TEXT:C222(atWS_IdTransaccion_A5;0)
ARRAY TEXT:C222(atWS_RutAl_A5;0)
ARRAY TEXT:C222(atWS_RutApoCuentas_A5;0)
ARRAY TEXT:C222(atWS_MontoTotal;0)
ARRAY TEXT:C222(atWS_Fecha;0)
ARRAY TEXT:C222(atWS_NumBoleta;0)
ARRAY TEXT:C222(atWS_UsuarioEjecutivo;0)
ARRAY TEXT:C222(atWS_NumContrato;0)
ARRAY TEXT:C222(atWS_PeriodoAcademico;0)

  //ARCHIVO 6
ARRAY TEXT:C222(atWS_tipoRegistro;0)
ARRAY TEXT:C222(atWS_rut;0)
ARRAY TEXT:C222(atWS_fono;0)
ARRAY TEXT:C222(atWS_celular;0)
ARRAY TEXT:C222(atWS_email;0)
ARRAY TEXT:C222(atWS_nombres;0)
ARRAY TEXT:C222(atWS_ap_paterno;0)
ARRAY TEXT:C222(atWS_ap_materno;0)
ARRAY TEXT:C222(atWS_direccion;0)
ARRAY TEXT:C222(atWS_comuna;0)


  //****SOAP INPUTS****
SOAP DECLARATION:C782($1;Is text:K8:3;SOAP input:K46:1;"identificadorColegio")
SOAP DECLARATION:C782($2;Is text:K8:3;SOAP input:K46:1;"usuario")
SOAP DECLARATION:C782($3;Is text:K8:3;SOAP input:K46:1;"password")
SOAP DECLARATION:C782($4;Is text:K8:3;SOAP input:K46:1;"datosRequeridos")
SOAP DECLARATION:C782($5;Is text:K8:3;SOAP input:K46:1;"formatoArchivos")
SOAP DECLARATION:C782($6;Is text:K8:3;SOAP input:K46:1;"fechaInicio")
SOAP DECLARATION:C782($7;Is text:K8:3;SOAP input:K46:1;"fechaTermino")

  //****INICIALIZACIONES****
C_TEXT:C284($clase_datos;$formatoArchivos;$vt_fecha1;$vt_fecha2)
$schoolID:=$1
$userName:=$2
$password:=$3
$clase_datos:=$4
$formatoArchivos:=$5
If (Count parameters:C259>5)
	$vt_fecha1:=$6
	$vt_fecha2:=$7
End if 
vtWS_ErrorString:=""

  //****SOAP OUTPUTS****
SOAP DECLARATION:C782(vxWS_Blob1;Is BLOB:K8:12;SOAP output:K46:2;"datos")
SOAP DECLARATION:C782(vtWS_ErrorString;Is text:K8:3;SOAP output:K46:2;"mensajeError")


  //ARCHIVO 1
SOAP DECLARATION:C782(atWS_IdTransaccion_A1;Text array:K8:16;SOAP output:K46:2;"A1_id_tra")
SOAP DECLARATION:C782(atWS_RutAl_A1;Text array:K8:16;SOAP output:K46:2;"A1_rut_alu")
SOAP DECLARATION:C782(atWS_NombresAl;Text array:K8:16;SOAP output:K46:2;"A1_nom_alu")
SOAP DECLARATION:C782(atWS_ApellidoPaternoAl;Text array:K8:16;SOAP output:K46:2;"A1_ape_pat_alu")
SOAP DECLARATION:C782(atWS_ApellidoMaternoAl;Text array:K8:16;SOAP output:K46:2;"A1_ape_mat_alu")
SOAP DECLARATION:C782(atWS_SexoAl;Text array:K8:16;SOAP output:K46:2;"A1_sex_alu")
SOAP DECLARATION:C782(atWS_FechaNacAl;Text array:K8:16;SOAP output:K46:2;"A1_fec_nac_alu")
SOAP DECLARATION:C782(atWS_DireccionAl;Text array:K8:16;SOAP output:K46:2;"A1_dir_alu")
SOAP DECLARATION:C782(atWS_ComunaAl;Text array:K8:16;SOAP output:K46:2;"A1_com_alu")
SOAP DECLARATION:C782(atWS_TelefonoAl;Text array:K8:16;SOAP output:K46:2;"A1_tel_alu")
SOAP DECLARATION:C782(atWS_CelularAl;Text array:K8:16;SOAP output:K46:2;"A1_cel_alu")
SOAP DECLARATION:C782(atWS_EMailAl;Text array:K8:16;SOAP output:K46:2;"A1_ema_alu")
SOAP DECLARATION:C782(atWS_CursoAl;Text array:K8:16;SOAP output:K46:2;"A1_cur_alu")

SOAP DECLARATION:C782(atWS_RutAp;Text array:K8:16;SOAP output:K46:2;"A1_rut_apo")
SOAP DECLARATION:C782(atWS_NombresAp;Text array:K8:16;SOAP output:K46:2;"A1_nom_apo")
SOAP DECLARATION:C782(atWS_ApellidoPaternoAp;Text array:K8:16;SOAP output:K46:2;"A1_ape_pat_apo")
SOAP DECLARATION:C782(atWS_ApellidoMaternoAp;Text array:K8:16;SOAP output:K46:2;"A1_ape_mat_apo")
SOAP DECLARATION:C782(atWS_SexoAp;Text array:K8:16;SOAP output:K46:2;"A1_sex_apo")
SOAP DECLARATION:C782(atWS_FechaNacAp;Text array:K8:16;SOAP output:K46:2;"A1_fec_nac_apo")
SOAP DECLARATION:C782(atWS_DireccionPartAp;Text array:K8:16;SOAP output:K46:2;"A1_dir_apo")
SOAP DECLARATION:C782(atWS_ComunaPartAp;Text array:K8:16;SOAP output:K46:2;"A1_com_apo")
SOAP DECLARATION:C782(atWS_DireccionComtAp;Text array:K8:16;SOAP output:K46:2;"A1_dir_com_apo")
SOAP DECLARATION:C782(atWS_ComunaComAp;Text array:K8:16;SOAP output:K46:2;"A1_com_com_apo")
SOAP DECLARATION:C782(atWS_TelefonoPartAp;Text array:K8:16;SOAP output:K46:2;"A1_tel_apo")
SOAP DECLARATION:C782(atWS_CelularAp;Text array:K8:16;SOAP output:K46:2;"A1_cel_apo")
SOAP DECLARATION:C782(atWS_TelefonoComAp;Text array:K8:16;SOAP output:K46:2;"A1_tel_com_apo")
SOAP DECLARATION:C782(atWS_EMailAp;Text array:K8:16;SOAP output:K46:2;"A1_ema_apo")

  //ARCHIVO 2
SOAP DECLARATION:C782(atWS_IdTransaccion_A2;Text array:K8:16;SOAP output:K46:2;"A2_id_tra")
SOAP DECLARATION:C782(atWS_RutAl_A2;Text array:K8:16;SOAP output:K46:2;"A2_rut_alu")
SOAP DECLARATION:C782(atWS_NumContraro;Text array:K8:16;SOAP output:K46:2;"A2_num_con")
SOAP DECLARATION:C782(atWS_RutApoCuentas_A2;Text array:K8:16;SOAP output:K46:2;"A2_rut_apo_cue")
SOAP DECLARATION:C782(atWS_FechaEmision;Text array:K8:16;SOAP output:K46:2;"A2_fec_emi")
SOAP DECLARATION:C782(atWS_NumCuota;Text array:K8:16;SOAP output:K46:2;"A2_num_cuo")
SOAP DECLARATION:C782(atWS_MontoCuota;Text array:K8:16;SOAP output:K46:2;"A2_mon_cuo")
SOAP DECLARATION:C782(atWS_FechaVencimiento_A2;Text array:K8:16;SOAP output:K46:2;"A2_fec_ven")

  //ARCHIVO 3
SOAP DECLARATION:C782(atWS_IdTransaccion_A3;Text array:K8:16;SOAP output:K46:2;"A3_id_tra")
SOAP DECLARATION:C782(atWS_RutAl_A3;Text array:K8:16;SOAP output:K46:2;"A3_rut_alu")
SOAP DECLARATION:C782(atWS_RutApoCuentas_A3;Text array:K8:16;SOAP output:K46:2;"A3_rut_apo_cue")
SOAP DECLARATION:C782(atWS_CodBanco;Text array:K8:16;SOAP output:K46:2;"A3_cod_ban")
SOAP DECLARATION:C782(atWS_CuentaCte;Text array:K8:16;SOAP output:K46:2;"A3_cue_cor")
SOAP DECLARATION:C782(atWS_NumCheque;Text array:K8:16;SOAP output:K46:2;"A3_num_che")
SOAP DECLARATION:C782(atWS_FechaVencimiento_A3;Text array:K8:16;SOAP output:K46:2;"A3_fec_ven")
SOAP DECLARATION:C782(atWS_MontoCheque;Text array:K8:16;SOAP output:K46:2;"A3_mon_che")

  //ARCHIVO 4
SOAP DECLARATION:C782(atWS_IdTransaccion_A4;Text array:K8:16;SOAP output:K46:2;"A4_id_tra")
SOAP DECLARATION:C782(atWS_RutAl_A4;Text array:K8:16;SOAP output:K46:2;"A4_rut_alu")
SOAP DECLARATION:C782(atWS_RutApoCuentas_A4;Text array:K8:16;SOAP output:K46:2;"A4_rut_apo_cue")
SOAP DECLARATION:C782(atWS_Monto;Text array:K8:16;SOAP output:K46:2;"A4_mon")
SOAP DECLARATION:C782(atWS_TipoTarjeta;Text array:K8:16;SOAP output:K46:2;"A4_tip_tar")
SOAP DECLARATION:C782(atWS_NombreTarjeta;Text array:K8:16;SOAP output:K46:2;"A4_nom_tar")

  //ARCHIVO 5
SOAP DECLARATION:C782(atWS_IdTransaccion_A5;Text array:K8:16;SOAP output:K46:2;"A5_id_tra")
SOAP DECLARATION:C782(atWS_RutAl_A5;Text array:K8:16;SOAP output:K46:2;"A5_rut_alu")
SOAP DECLARATION:C782(atWS_RutApoCuentas_A5;Text array:K8:16;SOAP output:K46:2;"A5_rut_apo_cue")
SOAP DECLARATION:C782(atWS_MontoTotal;Text array:K8:16;SOAP output:K46:2;"A5_mon_tot")
SOAP DECLARATION:C782(atWS_Fecha;Text array:K8:16;SOAP output:K46:2;"A5_fec")
SOAP DECLARATION:C782(atWS_NumBoleta;Text array:K8:16;SOAP output:K46:2;"A5_num_bol")
SOAP DECLARATION:C782(atWS_UsuarioEjecutivo;Text array:K8:16;SOAP output:K46:2;"A5_usu_eje")
SOAP DECLARATION:C782(atWS_NumContrato;Text array:K8:16;SOAP output:K46:2;"A5_num_con")
SOAP DECLARATION:C782(atWS_PeriodoAcademico;Text array:K8:16;SOAP output:K46:2;"A5_per_aca")

  //ARCHIVO 6
SOAP DECLARATION:C782(atWS_tipoRegistro;Text array:K8:16;SOAP output:K46:2;"A6_tipo")
SOAP DECLARATION:C782(atWS_rut;Text array:K8:16;SOAP output:K46:2;"A6_rut")
SOAP DECLARATION:C782(atWS_fono;Text array:K8:16;SOAP output:K46:2;"A6_fon")
SOAP DECLARATION:C782(atWS_celular;Text array:K8:16;SOAP output:K46:2;"A6_cel")
SOAP DECLARATION:C782(atWS_email;Text array:K8:16;SOAP output:K46:2;"A6_ema")
SOAP DECLARATION:C782(atWS_nombres;Text array:K8:16;SOAP output:K46:2;"A6_nom")
SOAP DECLARATION:C782(atWS_ap_paterno;Text array:K8:16;SOAP output:K46:2;"A6_ape_pat")
SOAP DECLARATION:C782(atWS_ap_materno;Text array:K8:16;SOAP output:K46:2;"A6_ape_mat")
SOAP DECLARATION:C782(atWS_direccion;Text array:K8:16;SOAP output:K46:2;"A6_dir")
SOAP DECLARATION:C782(atWS_comuna;Text array:K8:16;SOAP output:K46:2;"A6_com")

  //****CUERPO****

vtWS_ErrorString:=""
If ((($schoolID=<>vsACT_RUT) & ($schoolID="760235164")) | (($schoolID=<>vsACT_RUT) & ($schoolID="760440515")))
	vs_Name:=$userName
	vs_Password:=$password
	$logged:=USR_ProcessLogin 
	TRACE:C157
	If ($logged=1)
		If ((Position:C15("txt";$formatoArchivos)>0) | (Position:C15("xml";$formatoArchivos)>0))
			$folderPath:=Get 4D folder:C485(Database folder:K5:14)+"Datos_Colegio"+Folder separator:K24:12
			If (Test path name:C476($folderPath)=Is a folder:K24:2)
				SYS_DeleteFolder ($folderPath)
			End if 
			SYS_CreatePath ($folderPath)
		End if 
		
		C_DATE:C307($vd_fecha1;$vd_fecha2)
		If (($vt_fecha1#"") & ($vt_fecha2#""))
			$vd_fecha1:=DT_GetDateFromDayMonthYear (Num:C11(Substring:C12($vt_fecha1;7;2));Num:C11(Substring:C12($vt_fecha1;5;2));Num:C11(Substring:C12($vt_fecha1;1;4)))
			$vd_fecha2:=DT_GetDateFromDayMonthYear (Num:C11(Substring:C12($vt_fecha2;7;2));Num:C11(Substring:C12($vt_fecha2;5;2));Num:C11(Substring:C12($vt_fecha2;1;4)))
		End if 
		
		If (($clase_datos="Archivo1") | ($clase_datos="todo"))
			READ ONLY:C145([ACT_Pagos:172])
			READ ONLY:C145([ACT_CuentasCorrientes:175])
			If ($vd_fecha1=!00-00-00!)
				ALL RECORDS:C47([ACT_Pagos:172])
			Else 
				QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]Fecha:2>=$vd_fecha1;*)
				QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]Fecha:2<=$vd_fecha2)
			End if 
			ARRAY LONGINT:C221($al_recNum;0)
			LONGINT ARRAY FROM SELECTION:C647([ACT_Pagos:172];$al_recNum;"")
			For ($i;1;Size of array:C274($al_recNum))
				GOTO RECORD:C242([ACT_Pagos:172];$al_recNum{$i})
				ARRAY LONGINT:C221($al_idsCtas;0)
				READ ONLY:C145([ACT_Transacciones:178])
				QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4=[ACT_Pagos:172]ID:1)
				AT_DistinctsFieldValues (->[ACT_Transacciones:178]ID_CuentaCorriente:2;->$al_idsCtas)
				
				For ($j;1;Size of array:C274($al_idsCtas))
					$vl_idCta:=$al_idsCtas{$j}
					KRL_FindAndLoadRecordByIndex (->[ACT_CuentasCorrientes:175]ID:1;->$vl_idCta)
					If ([ACT_CuentasCorrientes:175]Estado:4=True:C214)
						KRL_FindAndLoadRecordByIndex (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3)
						KRL_FindAndLoadRecordByIndex (->[Personas:7]No:1;->[ACT_CuentasCorrientes:175]ID_Apoderado:9)
						
						APPEND TO ARRAY:C911(atWS_IdTransaccion_A1;String:C10([Alumnos:2]numero:1))
						APPEND TO ARRAY:C911(atWS_RutAl_A1;[Alumnos:2]RUT:5)
						APPEND TO ARRAY:C911(atWS_NombresAl;[Alumnos:2]Nombres:2)
						APPEND TO ARRAY:C911(atWS_ApellidoPaternoAl;[Alumnos:2]Apellido_paterno:3)
						APPEND TO ARRAY:C911(atWS_ApellidoMaternoAl;[Alumnos:2]Apellido_materno:4)
						APPEND TO ARRAY:C911(atWS_SexoAl;[Alumnos:2]Sexo:49)
						APPEND TO ARRAY:C911(atWS_FechaNacAl;String:C10([Alumnos:2]Fecha_de_nacimiento:7))
						APPEND TO ARRAY:C911(atWS_DireccionAl;[Alumnos:2]Direccion:12)
						APPEND TO ARRAY:C911(atWS_ComunaAl;[Alumnos:2]Comuna:14)
						APPEND TO ARRAY:C911(atWS_TelefonoAl;[Alumnos:2]Telefono:17)
						APPEND TO ARRAY:C911(atWS_CelularAl;[Alumnos:2]Celular:95)
						APPEND TO ARRAY:C911(atWS_EMailAl;[Alumnos:2]eMAIL:68)
						APPEND TO ARRAY:C911(atWS_CursoAl;[Alumnos:2]curso:20)
						
						APPEND TO ARRAY:C911(atWS_RutAp;[Personas:7]RUT:6)
						APPEND TO ARRAY:C911(atWS_NombresAp;[Personas:7]Nombres:2)
						APPEND TO ARRAY:C911(atWS_ApellidoPaternoAp;[Personas:7]Apellido_paterno:3)
						APPEND TO ARRAY:C911(atWS_ApellidoMaternoAp;[Personas:7]Apellido_materno:4)
						APPEND TO ARRAY:C911(atWS_SexoAp;[Personas:7]Sexo:8)
						APPEND TO ARRAY:C911(atWS_FechaNacAp;String:C10(Day of:C23([Personas:7]Fecha_de_nacimiento:5);"00")+"/"+String:C10(Month of:C24([Personas:7]Fecha_de_nacimiento:5);"00")+"/"+String:C10(Year of:C25([Personas:7]Fecha_de_nacimiento:5);"0000"))
						APPEND TO ARRAY:C911(atWS_DireccionPartAp;[Personas:7]Direccion:14)
						APPEND TO ARRAY:C911(atWS_ComunaPartAp;[Personas:7]Comuna:16)
						APPEND TO ARRAY:C911(atWS_DireccionComtAp;[Personas:7]ACT_DireccionEC:67)
						APPEND TO ARRAY:C911(atWS_ComunaComAp;[Personas:7]ACT_ComunaEC:68)
						APPEND TO ARRAY:C911(atWS_TelefonoPartAp;[Personas:7]Telefono_domicilio:19)
						APPEND TO ARRAY:C911(atWS_CelularAp;[Personas:7]Celular:24)
						APPEND TO ARRAY:C911(atWS_TelefonoComAp;[Personas:7]Telefono_profesional:29)
						APPEND TO ARRAY:C911(atWS_EMailAp;[Personas:7]eMail:34)
					End if 
				End for 
			End for 
			
			If ((Position:C15("txt";$formatoArchivos)>0) | (Position:C15("xml";$formatoArchivos)>0))
				ARRAY TEXT:C222($aElementsNames;0)
				APPEND TO ARRAY:C911($aElementsNames;"A1_id_tra")
				APPEND TO ARRAY:C911($aElementsNames;"A1_rut_alu")
				APPEND TO ARRAY:C911($aElementsNames;"A1_nom_alu")
				APPEND TO ARRAY:C911($aElementsNames;"A1_ape_pat_alu")
				APPEND TO ARRAY:C911($aElementsNames;"A1_ape_mat_alu")
				APPEND TO ARRAY:C911($aElementsNames;"A1_sex_alu")
				APPEND TO ARRAY:C911($aElementsNames;"A1_fec_nac_alu")
				APPEND TO ARRAY:C911($aElementsNames;"A1_dir_alu")
				APPEND TO ARRAY:C911($aElementsNames;"A1_com_alu")
				APPEND TO ARRAY:C911($aElementsNames;"A1_tel_alu")
				APPEND TO ARRAY:C911($aElementsNames;"A1_cel_alu")
				APPEND TO ARRAY:C911($aElementsNames;"A1_ema_alu")
				APPEND TO ARRAY:C911($aElementsNames;"A1_cur_alu")
				APPEND TO ARRAY:C911($aElementsNames;"A1_rut_apo")
				APPEND TO ARRAY:C911($aElementsNames;"A1_nom_apo")
				APPEND TO ARRAY:C911($aElementsNames;"A1_ape_pat_apo")
				APPEND TO ARRAY:C911($aElementsNames;"A1_ape_mat_apo")
				APPEND TO ARRAY:C911($aElementsNames;"A1_sex_apo")
				APPEND TO ARRAY:C911($aElementsNames;"A1_fec_nac_apo")
				APPEND TO ARRAY:C911($aElementsNames;"A1_dir_apo")
				APPEND TO ARRAY:C911($aElementsNames;"A1_com_apo")
				APPEND TO ARRAY:C911($aElementsNames;"A1_dir_apo")
				APPEND TO ARRAY:C911($aElementsNames;"A1_com_apo")
				APPEND TO ARRAY:C911($aElementsNames;"A1_tel_apo")
				APPEND TO ARRAY:C911($aElementsNames;"A1_cel_apo")
				APPEND TO ARRAY:C911($aElementsNames;"A1_tel_apo")
				APPEND TO ARRAY:C911($aElementsNames;"A1_ema_apo")
				
				ARRAY POINTER:C280($aArrayPointers;0)
				APPEND TO ARRAY:C911($aArrayPointers;->atWS_IdTransaccion_A1)
				APPEND TO ARRAY:C911($aArrayPointers;->atWS_RutAl_A1)
				APPEND TO ARRAY:C911($aArrayPointers;->atWS_NombresAl)
				APPEND TO ARRAY:C911($aArrayPointers;->atWS_ApellidoPaternoAl)
				APPEND TO ARRAY:C911($aArrayPointers;->atWS_ApellidoMaternoAl)
				APPEND TO ARRAY:C911($aArrayPointers;->atWS_SexoAl)
				APPEND TO ARRAY:C911($aArrayPointers;->atWS_FechaNacAl)
				APPEND TO ARRAY:C911($aArrayPointers;->atWS_DireccionAl)
				APPEND TO ARRAY:C911($aArrayPointers;->atWS_ComunaAl)
				APPEND TO ARRAY:C911($aArrayPointers;->atWS_TelefonoAl)
				APPEND TO ARRAY:C911($aArrayPointers;->atWS_CelularAl)
				APPEND TO ARRAY:C911($aArrayPointers;->atWS_EMailAl)
				APPEND TO ARRAY:C911($aArrayPointers;->atWS_CursoAl)
				
				APPEND TO ARRAY:C911($aArrayPointers;->atWS_RutAp)
				APPEND TO ARRAY:C911($aArrayPointers;->atWS_NombresAp)
				APPEND TO ARRAY:C911($aArrayPointers;->atWS_ApellidoPaternoAp)
				APPEND TO ARRAY:C911($aArrayPointers;->atWS_ApellidoMaternoAp)
				APPEND TO ARRAY:C911($aArrayPointers;->atWS_SexoAp)
				APPEND TO ARRAY:C911($aArrayPointers;->atWS_FechaNacAp)
				APPEND TO ARRAY:C911($aArrayPointers;->atWS_DireccionPartAp)
				APPEND TO ARRAY:C911($aArrayPointers;->atWS_ComunaPartAp)
				APPEND TO ARRAY:C911($aArrayPointers;->atWS_DireccionComtAp)
				APPEND TO ARRAY:C911($aArrayPointers;->atWS_ComunaComAp)
				APPEND TO ARRAY:C911($aArrayPointers;->atWS_TelefonoPartAp)
				APPEND TO ARRAY:C911($aArrayPointers;->atWS_CelularAp)
				APPEND TO ARRAY:C911($aArrayPointers;->atWS_TelefonoComAp)
				APPEND TO ARRAY:C911($aArrayPointers;->atWS_EMailAp)
				
				If (Position:C15("xml";$formatoArchivos)>0)
					$filepath:=$folderPath+Folder separator:K24:12+"archivo1.xml"
					$DocRef:=Create document:C266($filepath)
					XML_OpenSAX_Root ($DocRef;"Archivo1")
					XML_CreateSaxElements ($docRef;"Alumno";->$aElementsNames;->$aArrayPointers)
					SAX CLOSE XML ELEMENT:C854($DocRef)
					CLOSE DOCUMENT:C267($DocRef)
				End if 
				
				If (Position:C15("txt";$formatoArchivos)>0)
					$filepath:=$folderPath+Folder separator:K24:12+"archivo1.txt"
					AT_Arrays2TextFile ($filepath;->$aElementsNames;->$aArrayPointers)
				End if 
			End if 
		End if 
		
		If (($clase_datos="Archivo2") | ($clase_datos="todo"))
			C_LONGINT:C283($vl_idCta;$vl_idApdo)
			ARRAY REAL:C219($ar_montoNeto;0)
			ARRAY DATE:C224($ad_fEmision;0)
			ARRAY DATE:C224($ad_fVencimiento;0)
			ARRAY LONGINT:C221($al_idApoderado;0)
			ARRAY LONGINT:C221($al_idCtaCte;0)
			
			READ ONLY:C145([ACT_Pagos:172])
			READ ONLY:C145([ACT_Cargos:173])
			If ($vd_fecha1=!00-00-00!)
				ALL RECORDS:C47([ACT_Pagos:172])
			Else 
				QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]Fecha:2>=$vd_fecha1;*)
				QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]Fecha:2<=$vd_fecha2)
			End if 
			ARRAY LONGINT:C221($al_recNumPagos;0)
			LONGINT ARRAY FROM SELECTION:C647([ACT_Pagos:172];$al_recNumPagos;"")
			
			For ($i;1;Size of array:C274($al_recNumPagos))
				GOTO RECORD:C242([ACT_Pagos:172];$al_recNumPagos{$i})
				ARRAY LONGINT:C221($al_idsItems;0)
				READ ONLY:C145([ACT_Transacciones:178])
				QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4=[ACT_Pagos:172]ID:1)
				CREATE SET:C116([ACT_Transacciones:178];"SET_Transacciones")
				AT_DistinctsFieldValues (->[ACT_Transacciones:178]ID_Item:3;->$al_idsItems)
				For ($j;1;Size of array:C274($al_idsItems))
					READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
					$vl_idCargo:=$al_idsItems{$j}
					KRL_FindAndLoadRecordByIndex (->[ACT_Cargos:173]ID:1;->$vl_idCargo)
					REDUCE SELECTION:C351([Personas:7];0)
					REDUCE SELECTION:C351([ACT_CuentasCorrientes:175];0)
					REDUCE SELECTION:C351([Alumnos:2];0)
					KRL_FindAndLoadRecordByIndex (->[Personas:7]No:1;->[ACT_Cargos:173]ID_Apoderado:18)
					KRL_FindAndLoadRecordByIndex (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Cargos:173]ID_CuentaCorriente:2)
					KRL_FindAndLoadRecordByIndex (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3)
					
					USE SET:C118("SET_Transacciones")
					QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1)
					ARRAY LONGINT:C221($al_recNum;0)
					LONGINT ARRAY FROM SELECTION:C647([ACT_Transacciones:178];$al_recNum;"")
					$vr_monto:=ACTtra_CalculaMontos ("calculaFromRecNum";->$al_recNum;->[ACT_Transacciones:178]Debito:6)
					
					APPEND TO ARRAY:C911(atWS_IdTransaccion_A2;String:C10([Alumnos:2]numero:1))
					APPEND TO ARRAY:C911(atWS_RutAl_A2;[Alumnos:2]RUT:5)
					APPEND TO ARRAY:C911(atWS_NumContraro;_CampoPropio ("Contrato Prest Serv."))
					APPEND TO ARRAY:C911(atWS_RutApoCuentas_A2;[Personas:7]RUT:6)
					APPEND TO ARRAY:C911(atWS_FechaEmision;String:C10(Day of:C23([ACT_Cargos:173]FechaEmision:22);"00")+"/"+String:C10(Month of:C24([ACT_Cargos:173]FechaEmision:22);"00")+"/"+String:C10(Year of:C25([ACT_Cargos:173]FechaEmision:22);"0000"))
					APPEND TO ARRAY:C911(atWS_NumCuota;String:C10([ACT_Cargos:173]Mes:13-2))
					APPEND TO ARRAY:C911(atWS_MontoCuota;String:C10($vr_monto))
					APPEND TO ARRAY:C911(atWS_FechaVencimiento_A2;String:C10(Day of:C23([ACT_Cargos:173]Fecha_de_Vencimiento:7);"00")+"/"+String:C10(Month of:C24([ACT_Cargos:173]Fecha_de_Vencimiento:7);"00")+"/"+String:C10(Year of:C25([ACT_Cargos:173]Fecha_de_Vencimiento:7);"0000"))
				End for 
			End for 
			
			If ((Position:C15("txt";$formatoArchivos)>0) | (Position:C15("xml";$formatoArchivos)>0))
				ARRAY TEXT:C222($aElementsNames;0)
				APPEND TO ARRAY:C911($aElementsNames;"A2_id_tra")
				APPEND TO ARRAY:C911($aElementsNames;"A2_rut_alu")
				APPEND TO ARRAY:C911($aElementsNames;"A2_num_con")
				APPEND TO ARRAY:C911($aElementsNames;"A2_rut_apo_cue")
				APPEND TO ARRAY:C911($aElementsNames;"A2_fec_emi")
				APPEND TO ARRAY:C911($aElementsNames;"A2_num_cuo")
				APPEND TO ARRAY:C911($aElementsNames;"A2_mon_cuo")
				APPEND TO ARRAY:C911($aElementsNames;"A2_fec_ven")
				
				ARRAY POINTER:C280($aArrayPointers;0)
				APPEND TO ARRAY:C911($aArrayPointers;->atWS_IdTransaccion_A2)
				APPEND TO ARRAY:C911($aArrayPointers;->atWS_RutAl_A2)
				APPEND TO ARRAY:C911($aArrayPointers;->atWS_NumContraro)
				APPEND TO ARRAY:C911($aArrayPointers;->atWS_RutApoCuentas_A2)
				APPEND TO ARRAY:C911($aArrayPointers;->atWS_FechaEmision)
				APPEND TO ARRAY:C911($aArrayPointers;->atWS_NumCuota)
				APPEND TO ARRAY:C911($aArrayPointers;->atWS_MontoCuota)
				APPEND TO ARRAY:C911($aArrayPointers;->atWS_FechaVencimiento_A2)
				
				If (Position:C15("xml";$formatoArchivos)>0)
					$filepath:=$folderPath+Folder separator:K24:12+"archivo2.xml"
					$DocRef:=Create document:C266($filepath)
					XML_OpenSAX_Root ($DocRef;"Vencimientos")
					XML_CreateSaxElements ($docRef;"Aviso";->$aElementsNames;->$aArrayPointers)
					SAX CLOSE XML ELEMENT:C854($DocRef)
					CLOSE DOCUMENT:C267($DocRef)
				End if 
				
				If (Position:C15("txt";$formatoArchivos)>0)
					$filepath:=$folderPath+Folder separator:K24:12+"archivo2.txt"
					AT_Arrays2TextFile ($filepath;->$aElementsNames;->$aArrayPointers)
				End if 
			End if 
		End if 
		
		If (($clase_datos="Archivo3") | ($clase_datos="todo"))
			READ ONLY:C145([ACT_Pagos:172])
			READ ONLY:C145([ACT_Documentos_de_Pago:176])
			READ ONLY:C145([ACT_Transacciones:178])
			ARRAY LONGINT:C221($al_recNumsPagos;0)
			If ($vd_fecha1=!00-00-00!)
				ALL RECORDS:C47([ACT_Pagos:172])
			Else 
				QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]Fecha:2>=$vd_fecha1;*)
				QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]Fecha:2<=$vd_fecha2)
			End if 
			QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]FormaDePago:7="Cheque")
			LONGINT ARRAY FROM SELECTION:C647([ACT_Pagos:172];$al_recNumsPagos;"")
			For ($i;1;Size of array:C274($al_recNumsPagos))
				GOTO RECORD:C242([ACT_Pagos:172];$al_recNumsPagos{$i})
				QUERY:C277([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]ID:1=[ACT_Pagos:172]ID_DocumentodePago:6)
				  //KRL_FindAndLoadRecordByIndex (->[ACT_CuentasCorrientes]ID;->[ACT_Pagos]ID_CtaCte)
				
				QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4=[ACT_Pagos:172]ID:1;*)
				QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_CuentaCorriente:2#0)
				CREATE SET:C116([ACT_Transacciones:178];"ACT_TransaccionesPago")
				ARRAY LONGINT:C221($al_idsCtas;0)
				AT_DistinctsFieldValues (->[ACT_Transacciones:178]ID_CuentaCorriente:2;->$al_idsCtas)
				For ($x;1;Size of array:C274($al_idsCtas))
					QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=$al_idsCtas{$x})
					ARRAY LONGINT:C221($al_recNumsTransacciones;0)
					USE SET:C118("ACT_TransaccionesPago")
					QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]ID_CuentaCorriente:2=$al_idsCtas{$x})
					LONGINT ARRAY FROM SELECTION:C647([ACT_Transacciones:178];$al_recNumsTransacciones;"")
					$vr_monto:=0
					For ($j;1;Size of array:C274($al_recNumsTransacciones))
						GOTO RECORD:C242([ACT_Transacciones:178];$al_recNumsTransacciones{$j})
						$vr_monto:=$vr_monto+ACTtra_CalculaMontos ("fromCurrentRecord";->[ACT_Transacciones:178]Debito:6)
					End for 
					APPEND TO ARRAY:C911(atWS_IdTransaccion_A3;String:C10([ACT_Pagos:172]ID:1))
					APPEND TO ARRAY:C911(atWS_RutAl_A3;KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3;->[Alumnos:2]RUT:5))
					APPEND TO ARRAY:C911(atWS_RutApoCuentas_A3;KRL_GetTextFieldData (->[Personas:7]No:1;->[ACT_Pagos:172]ID_Apoderado:3;->[Personas:7]RUT:6))
					APPEND TO ARRAY:C911(atWS_CodBanco;[ACT_Documentos_de_Pago:176]Ch_BancoCodigo:8)
					APPEND TO ARRAY:C911(atWS_CuentaCte;[ACT_Documentos_de_Pago:176]Ch_Cuenta:11)
					APPEND TO ARRAY:C911(atWS_NumCheque;[ACT_Documentos_de_Pago:176]NoSerie:12)
					APPEND TO ARRAY:C911(atWS_FechaVencimiento_A3;String:C10(Day of:C23([ACT_Documentos_de_Pago:176]FechaVencimiento:27);"00")+"/"+String:C10(Month of:C24([ACT_Documentos_de_Pago:176]FechaVencimiento:27);"00")+"/"+String:C10(Year of:C25([ACT_Documentos_de_Pago:176]FechaVencimiento:27);"0000"))
					  //APPEND TO ARRAY(atWS_MontoCheque;String([ACT_Documentos_de_Pago]MontoPago))
					APPEND TO ARRAY:C911(atWS_MontoCheque;String:C10($vr_monto))
				End for 
				CLEAR SET:C117("ACT_TransaccionesPago")
			End for 
			If ((Position:C15("txt";$formatoArchivos)>0) | (Position:C15("xml";$formatoArchivos)>0))
				ARRAY TEXT:C222($aElementsNames;0)
				APPEND TO ARRAY:C911($aElementsNames;"A3_id_tra")
				APPEND TO ARRAY:C911($aElementsNames;"A3_rut_alu")
				APPEND TO ARRAY:C911($aElementsNames;"A3_rut_apo_cue")
				APPEND TO ARRAY:C911($aElementsNames;"A3_cod_ban")
				APPEND TO ARRAY:C911($aElementsNames;"A3_cue_cor")
				APPEND TO ARRAY:C911($aElementsNames;"A3_num_che")
				APPEND TO ARRAY:C911($aElementsNames;"A3_fec_ven")
				APPEND TO ARRAY:C911($aElementsNames;"A3_mon_che")
				
				ARRAY POINTER:C280($aArrayPointers;0)
				APPEND TO ARRAY:C911($aArrayPointers;->atWS_IdTransaccion_A3)
				APPEND TO ARRAY:C911($aArrayPointers;->atWS_RutAl_A3)
				APPEND TO ARRAY:C911($aArrayPointers;->atWS_RutApoCuentas_A3)
				APPEND TO ARRAY:C911($aArrayPointers;->atWS_CodBanco)
				APPEND TO ARRAY:C911($aArrayPointers;->atWS_CuentaCte)
				APPEND TO ARRAY:C911($aArrayPointers;->atWS_NumCheque)
				APPEND TO ARRAY:C911($aArrayPointers;->atWS_FechaVencimiento_A3)
				APPEND TO ARRAY:C911($aArrayPointers;->atWS_MontoCheque)
				
				If (Position:C15("xml";$formatoArchivos)>0)
					$filepath:=$folderPath+Folder separator:K24:12+"archivo3.xml"
					$DocRef:=Create document:C266($filepath)
					XML_OpenSAX_Root ($DocRef;"Cheques")
					XML_CreateSaxElements ($docRef;"Cheque";->$aElementsNames;->$aArrayPointers)
					SAX CLOSE XML ELEMENT:C854($DocRef)
					CLOSE DOCUMENT:C267($DocRef)
				End if 
				
				If (Position:C15("txt";$formatoArchivos)>0)
					$filepath:=$folderPath+Folder separator:K24:12+"archivo3.txt"
					AT_Arrays2TextFile ($filepath;->$aElementsNames;->$aArrayPointers)
				End if 
			End if 
		End if 
		
		If (($clase_datos="Archivo4") | ($clase_datos="todo"))
			READ ONLY:C145([ACT_Transacciones:178])
			READ ONLY:C145([ACT_Pagos:172])
			READ ONLY:C145([ACT_Documentos_de_Pago:176])
			ARRAY LONGINT:C221($al_recNumsPagos;0)
			
			If ($vd_fecha1=!00-00-00!)
				ALL RECORDS:C47([ACT_Pagos:172])
			Else 
				QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]Fecha:2>=$vd_fecha1;*)
				QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]Fecha:2<=$vd_fecha2)
			End if 
			QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]FormaDePago:7#"Cheque")
			LONGINT ARRAY FROM SELECTION:C647([ACT_Pagos:172];$al_recNumsPagos;"")
			
			For ($i;1;Size of array:C274($al_recNumsPagos))
				GOTO RECORD:C242([ACT_Pagos:172];$al_recNumsPagos{$i})
				QUERY:C277([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]ID:1=[ACT_Pagos:172]ID_DocumentodePago:6)
				  //KRL_FindAndLoadRecordByIndex (->[ACT_CuentasCorrientes]ID;->[ACT_Pagos]ID_CtaCte)
				
				QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4=[ACT_Pagos:172]ID:1;*)
				QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_CuentaCorriente:2#0)
				CREATE SET:C116([ACT_Transacciones:178];"ACT_TransaccionesPago")
				ARRAY LONGINT:C221($al_idsCtas;0)
				AT_DistinctsFieldValues (->[ACT_Transacciones:178]ID_CuentaCorriente:2;->$al_idsCtas)
				For ($x;1;Size of array:C274($al_idsCtas))
					QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=$al_idsCtas{$x})
					ARRAY LONGINT:C221($al_recNumsTransacciones;0)
					USE SET:C118("ACT_TransaccionesPago")
					QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]ID_CuentaCorriente:2=$al_idsCtas{$x})
					LONGINT ARRAY FROM SELECTION:C647([ACT_Transacciones:178];$al_recNumsTransacciones;"")
					$vr_monto:=0
					For ($j;1;Size of array:C274($al_recNumsTransacciones))
						GOTO RECORD:C242([ACT_Transacciones:178];$al_recNumsTransacciones{$j})
						$vr_monto:=$vr_monto+ACTtra_CalculaMontos ("fromCurrentRecord";->[ACT_Transacciones:178]Debito:6)
					End for 
					
					APPEND TO ARRAY:C911(atWS_IdTransaccion_A4;String:C10([ACT_Pagos:172]ID:1))
					APPEND TO ARRAY:C911(atWS_RutAl_A4;KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3;->[Alumnos:2]RUT:5))
					APPEND TO ARRAY:C911(atWS_RutApoCuentas_A4;KRL_GetTextFieldData (->[Personas:7]No:1;->[ACT_Pagos:172]ID_Apoderado:3;->[Personas:7]RUT:6))
					  //APPEND TO ARRAY(atWS_Monto;String([ACT_Pagos]Monto_Pagado))
					APPEND TO ARRAY:C911(atWS_Monto;String:C10($vr_monto))
					APPEND TO ARRAY:C911(atWS_TipoTarjeta;[ACT_Pagos:172]FormaDePago:7)
					APPEND TO ARRAY:C911(atWS_NombreTarjeta;[ACT_Documentos_de_Pago:176]TC_Tipo:16)
				End for 
				CLEAR SET:C117("ACT_TransaccionesPago")
			End for 
			
			If ((Position:C15("txt";$formatoArchivos)>0) | (Position:C15("xml";$formatoArchivos)>0))
				ARRAY TEXT:C222($aElementsNames;0)
				
				APPEND TO ARRAY:C911($aElementsNames;"A4_id_tra")
				APPEND TO ARRAY:C911($aElementsNames;"A4_rut_alu")
				APPEND TO ARRAY:C911($aElementsNames;"A4_rut_apo_cue")
				APPEND TO ARRAY:C911($aElementsNames;"A4_mon")
				APPEND TO ARRAY:C911($aElementsNames;"A4_tip_tar")
				APPEND TO ARRAY:C911($aElementsNames;"A4_nom_tar")
				
				ARRAY POINTER:C280($aArrayPointers;0)
				APPEND TO ARRAY:C911($aArrayPointers;->atWS_IdTransaccion_A4)
				APPEND TO ARRAY:C911($aArrayPointers;->atWS_RutAl_A4)
				APPEND TO ARRAY:C911($aArrayPointers;->atWS_RutApoCuentas_A4)
				APPEND TO ARRAY:C911($aArrayPointers;->atWS_Monto)
				APPEND TO ARRAY:C911($aArrayPointers;->atWS_TipoTarjeta)
				APPEND TO ARRAY:C911($aArrayPointers;->atWS_NombreTarjeta)
				
				If (Position:C15("xml";$formatoArchivos)>0)
					$filepath:=$folderPath+Folder separator:K24:12+"archivo4.xml"
					$DocRef:=Create document:C266($filepath)
					XML_OpenSAX_Root ($DocRef;"NoCheques")
					XML_CreateSaxElements ($docRef;"Pago";->$aElementsNames;->$aArrayPointers)
					SAX CLOSE XML ELEMENT:C854($DocRef)
					CLOSE DOCUMENT:C267($DocRef)
				End if 
				
				If (Position:C15("txt";$formatoArchivos)>0)
					$filepath:=$folderPath+Folder separator:K24:12+"archivo4.txt"
					AT_Arrays2TextFile ($filepath;->$aElementsNames;->$aArrayPointers)
				End if 
			End if 
		End if 
		
		If (($clase_datos="Archivo5") | ($clase_datos="todo"))
			
			READ ONLY:C145([ACT_Pagos:172])
			READ ONLY:C145([ACT_Transacciones:178])
			READ ONLY:C145([Alumnos:2])
			READ ONLY:C145([ACT_CuentasCorrientes:175])
			READ ONLY:C145([Personas:7])
			READ ONLY:C145([ACT_Boletas:181])
			ARRAY LONGINT:C221($al_recNumsPagos;0)
			If ($vd_fecha1=!00-00-00!)
				ALL RECORDS:C47([ACT_Pagos:172])
			Else 
				QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]Fecha:2>=$vd_fecha1;*)
				QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]Fecha:2<=$vd_fecha2)
			End if 
			LONGINT ARRAY FROM SELECTION:C647([ACT_Pagos:172];$al_recNumsPagos;"")
			
			For ($i;1;Size of array:C274($al_recNumsPagos))
				GOTO RECORD:C242([ACT_Pagos:172];$al_recNumsPagos{$i})
				QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4=[ACT_Pagos:172]ID:1)
				CREATE SET:C116([ACT_Transacciones:178];"SetTransacciones")
				KRL_RelateSelection (->[ACT_Boletas:181]ID:1;->[ACT_Transacciones:178]No_Boleta:9;"")
				ARRAY LONGINT:C221($al_RecNum;0)
				LONGINT ARRAY FROM SELECTION:C647([ACT_Boletas:181];$al_RecNum;"")
				
				For ($j;1;Size of array:C274($al_RecNum))
					GOTO RECORD:C242([ACT_Boletas:181];$al_RecNum{$j})
					USE SET:C118("SetTransacciones")
					QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]No_Boleta:9=[ACT_Boletas:181]ID:1)
					KRL_FindAndLoadRecordByIndex (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Transacciones:178]ID_CuentaCorriente:2)
					APPEND TO ARRAY:C911(atWS_IdTransaccion_A5;String:C10([ACT_Pagos:172]ID:1))
					APPEND TO ARRAY:C911(atWS_RutAl_A5;KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3;->[Alumnos:2]RUT:5))
					APPEND TO ARRAY:C911(atWS_RutApoCuentas_A5;KRL_GetTextFieldData (->[Personas:7]No:1;->[ACT_Boletas:181]ID_Apoderado:14;->[Personas:7]RUT:6))
					APPEND TO ARRAY:C911(atWS_MontoTotal;String:C10([ACT_Boletas:181]Monto_Total:6))
					APPEND TO ARRAY:C911(atWS_Fecha;String:C10([ACT_Boletas:181]FechaEmision:3))
					APPEND TO ARRAY:C911(atWS_NumBoleta;String:C10([ACT_Boletas:181]Numero:11))
					APPEND TO ARRAY:C911(atWS_UsuarioEjecutivo;[ACT_Boletas:181]EmitidoPor:17)
					APPEND TO ARRAY:C911(atWS_NumContrato;_CampoPropio ("Contrato Prest Serv."))
					APPEND TO ARRAY:C911(atWS_PeriodoAcademico;String:C10(Month of:C24([ACT_Pagos:172]Fecha:2);"00")+String:C10(Year of:C25([ACT_Pagos:172]Fecha:2)))
				End for 
				CLEAR SET:C117("SetTransacciones")
				
			End for 
			
			If ((Position:C15("txt";$formatoArchivos)>0) | (Position:C15("xml";$formatoArchivos)>0))
				ARRAY TEXT:C222($aElementsNames;0)
				
				APPEND TO ARRAY:C911($aElementsNames;"A5_id_tra")
				APPEND TO ARRAY:C911($aElementsNames;"A5_rut_alu")
				APPEND TO ARRAY:C911($aElementsNames;"A5_rut_apo_cue")
				APPEND TO ARRAY:C911($aElementsNames;"A5_mon_tot")
				APPEND TO ARRAY:C911($aElementsNames;"A5_fec")
				APPEND TO ARRAY:C911($aElementsNames;"A5_num_bol")
				APPEND TO ARRAY:C911($aElementsNames;"A5_usu_eje")
				APPEND TO ARRAY:C911($aElementsNames;"A5_num_con")
				APPEND TO ARRAY:C911($aElementsNames;"A5_per_aca")
				
				ARRAY POINTER:C280($aArrayPointers;0)
				APPEND TO ARRAY:C911($aArrayPointers;->atWS_IdTransaccion_A5)
				APPEND TO ARRAY:C911($aArrayPointers;->atWS_RutAl_A5)
				APPEND TO ARRAY:C911($aArrayPointers;->atWS_RutApoCuentas_A5)
				APPEND TO ARRAY:C911($aArrayPointers;->atWS_MontoTotal)
				APPEND TO ARRAY:C911($aArrayPointers;->atWS_Fecha)
				APPEND TO ARRAY:C911($aArrayPointers;->atWS_NumBoleta)
				APPEND TO ARRAY:C911($aArrayPointers;->atWS_UsuarioEjecutivo)
				APPEND TO ARRAY:C911($aArrayPointers;->atWS_NumContrato)
				APPEND TO ARRAY:C911($aArrayPointers;->atWS_PeriodoAcademico)
				
				If (Position:C15("xml";$formatoArchivos)>0)
					$filepath:=$folderPath+Folder separator:K24:12+"archivo4.xml"
					$DocRef:=Create document:C266($filepath)
					XML_OpenSAX_Root ($DocRef;"NoCheques")
					XML_CreateSaxElements ($docRef;"Pago";->$aElementsNames;->$aArrayPointers)
					SAX CLOSE XML ELEMENT:C854($DocRef)
					CLOSE DOCUMENT:C267($DocRef)
				End if 
				
				If (Position:C15("txt";$formatoArchivos)>0)
					$filepath:=$folderPath+Folder separator:K24:12+"archivo4.txt"
					AT_Arrays2TextFile ($filepath;->$aElementsNames;->$aArrayPointers)
				End if 
			End if 
		End if 
		
		If (($clase_datos="Archivo6") | ($clase_datos="todo"))
			
			ARRAY TEXT:C222($at_fileNames;0)
			<>vbCMT_SendSoloModificados:=True:C214
			$xml:=CMT_RegistrosMarcados ("CMT_Send_Datos";-><>vsACT_Rut;->$at_fileNames)
			<>vbCMT_SendSoloModificados:=False:C215
			For ($i;Size of array:C274($at_fileNames);1;-1)
				C_BLOB:C604($xBlob)
				DOCUMENT TO BLOB:C525($at_fileNames{$i};$xBlob)
				ACTDOM_2XML2Arrays (->$xBlob)
				$vt_fileName:=SYS_Path2FileName ($at_fileNames{$i})
				For ($j;1;Size of array:C274(aQR_Text2))
					APPEND TO ARRAY:C911(atWS_tipoRegistro;ST_GetWord ($vt_fileName;3;"_"))
					$vl_idEtiqueta:=Find in array:C230(aQR_Text1;"rut")+1
					If ($vl_idEtiqueta#0)
						$ptr:=Get pointer:C304("aQR_Text"+String:C10($vl_idEtiqueta))
						APPEND TO ARRAY:C911(atWS_rut;$ptr->{$j})
					Else 
						APPEND TO ARRAY:C911(atWS_rut;"")
					End if 
					
					$vl_idEtiqueta:=Find in array:C230(aQR_Text1;"fono_fijo")+1
					If ($vl_idEtiqueta#0)
						$ptr:=Get pointer:C304("aQR_Text"+String:C10($vl_idEtiqueta))
						APPEND TO ARRAY:C911(atWS_fono;$ptr->{$j})
					Else 
						APPEND TO ARRAY:C911(atWS_fono;"")
					End if 
					$vl_idEtiqueta:=Find in array:C230(aQR_Text1;"celular")+1
					If ($vl_idEtiqueta#0)
						$ptr:=Get pointer:C304("aQR_Text"+String:C10($vl_idEtiqueta))
						APPEND TO ARRAY:C911(atWS_celular;$ptr->{$j})
					Else 
						APPEND TO ARRAY:C911(atWS_celular;"")
					End if 
					$vl_idEtiqueta:=Find in array:C230(aQR_Text1;"email")+1
					If ($vl_idEtiqueta#0)
						$ptr:=Get pointer:C304("aQR_Text"+String:C10($vl_idEtiqueta))
						APPEND TO ARRAY:C911(atWS_email;$ptr->{$j})
					Else 
						APPEND TO ARRAY:C911(atWS_email;"")
					End if 
					$vl_idEtiqueta:=Find in array:C230(aQR_Text1;"nombres")+1
					If ($vl_idEtiqueta#0)
						$ptr:=Get pointer:C304("aQR_Text"+String:C10($vl_idEtiqueta))
						APPEND TO ARRAY:C911(atWS_nombres;$ptr->{$j})
					Else 
						APPEND TO ARRAY:C911(atWS_nombres;"")
					End if 
					$vl_idEtiqueta:=Find in array:C230(aQR_Text1;"ap_paterno")+1
					If ($vl_idEtiqueta#0)
						$ptr:=Get pointer:C304("aQR_Text"+String:C10($vl_idEtiqueta))
						APPEND TO ARRAY:C911(atWS_ap_paterno;$ptr->{$j})
					Else 
						APPEND TO ARRAY:C911(atWS_ap_paterno;"")
					End if 
					$vl_idEtiqueta:=Find in array:C230(aQR_Text1;"ap_materno")+1
					If ($vl_idEtiqueta#0)
						$ptr:=Get pointer:C304("aQR_Text"+String:C10($vl_idEtiqueta))
						APPEND TO ARRAY:C911(atWS_ap_materno;$ptr->{$j})
					Else 
						APPEND TO ARRAY:C911(atWS_ap_materno;"")
					End if 
					$vl_idEtiqueta:=Find in array:C230(aQR_Text1;"direccion")+1
					If ($vl_idEtiqueta#0)
						$ptr:=Get pointer:C304("aQR_Text"+String:C10($vl_idEtiqueta))
						APPEND TO ARRAY:C911(atWS_direccion;$ptr->{$j})
					Else 
						APPEND TO ARRAY:C911(atWS_direccion;"")
					End if 
					$vl_idEtiqueta:=Find in array:C230(aQR_Text1;"comuna")+1
					If ($vl_idEtiqueta#0)
						$ptr:=Get pointer:C304("aQR_Text"+String:C10($vl_idEtiqueta))
						APPEND TO ARRAY:C911(atWS_comuna;$ptr->{$j})
					Else 
						APPEND TO ARRAY:C911(atWS_comuna;"")
					End if 
				End for 
				DELETE DOCUMENT:C159($at_fileNames{$i})
			End for 
			
			If ((Position:C15("txt";$formatoArchivos)>0) | (Position:C15("xml";$formatoArchivos)>0))
				ARRAY TEXT:C222($aElementsNames;0)
				APPEND TO ARRAY:C911($aElementsNames;"A6_tipo")
				APPEND TO ARRAY:C911($aElementsNames;"A6_rut")
				APPEND TO ARRAY:C911($aElementsNames;"A6_fon")
				APPEND TO ARRAY:C911($aElementsNames;"A6_cel")
				APPEND TO ARRAY:C911($aElementsNames;"A6_ema")
				APPEND TO ARRAY:C911($aElementsNames;"A6_nom")
				APPEND TO ARRAY:C911($aElementsNames;"A6_ape_pat")
				APPEND TO ARRAY:C911($aElementsNames;"A6_ape_mat")
				APPEND TO ARRAY:C911($aElementsNames;"A6_dir")
				APPEND TO ARRAY:C911($aElementsNames;"A6_com")
				
				ARRAY POINTER:C280($aArrayPointers;0)
				APPEND TO ARRAY:C911($aArrayPointers;->atWS_IdTransaccion_A5)
				If (Position:C15("xml";$formatoArchivos)>0)
					$filepath:=$folderPath+Folder separator:K24:12+"archivo6.xml"
					$DocRef:=Create document:C266($filepath)
					XML_OpenSAX_Root ($DocRef;"Modificados")
					XML_CreateSaxElements ($docRef;"Modificado";->$aElementsNames;->$aArrayPointers)
					SAX CLOSE XML ELEMENT:C854($DocRef)
					CLOSE DOCUMENT:C267($DocRef)
				End if 
				
				If (Position:C15("txt";$formatoArchivos)>0)
					$filepath:=$folderPath+Folder separator:K24:12+"archivo6.txt"
					AT_Arrays2TextFile ($filepath;->$aElementsNames;->$aArrayPointers)
				End if 
			End if 
			
		End if 
		
		
		
		If ((Position:C15("txt";$formatoArchivos)>0) | (Position:C15("xml";$formatoArchivos)>0))
			$filename:=Get 4D folder:C485(Database folder:K5:14)+"Datos_Colegio.zip"
			$b_archivoComprimido:=SYS_CompresionDescompresion ($folderPath;"";"";->$t_resultado)
			DOCUMENT TO BLOB:C525($t_resultado;vxWS_Blob1)
		End if 
		
	Else 
		vtWS_ErrorString:="Nombre de usuario o contraseña incorrecto (Error -2)"
	End if 
Else 
	vtWS_ErrorString:="Identificador de la institución incorrecto (Error -1)"
End if 

