//%attributes = {}
  // Método: WS_DatosITC
  //----------------------------------------------
  // Usuario (OS): roberto
  // Fecha: 11-09-10, 17:04:03
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal

  //WS_DatosITC
C_TEXT:C284($1;$2;$3;$schoolID;$userName;$password;vtWS_ErrorString;$tipoSolicitud;vtWS_result;$vt_valor)
C_TEXT:C284($vt_alu_n1;$vt_alu_ap2;$vt_alu_am3;$vt_alu_r4;$vt_alu_dv5;$vt_alu_fn6;$vt_alu_s7;$vt_alu_dc8;$vt_alu_c9;$vt_alu_r10;$vt_alu_t11;$vt_alu_tm12;$vt_alu_e13;$vt_alu_ca14;$vt_alu_ci15;$vt_alu_c16;$vt_cur_c1;$vt_cur_n2;$vt_cur_j3;$vt_cp_aii1;$vt_cp_ec2;$vt_cp_ldt3;$vt_cp_n4;$vt_cp_o5;$vt_cp_ppsu6;$vt_cp_tc7;$vt_cp_t8;$vt_cp_apsu9;$vt_per_tr1;$vt_per_td2;$vt_per_tn3;$vt_per_tap4;$vt_per_tam5;$vt_per_tfn6;$vt_per_td7;$vt_per_tc8;$vt_per_tr9;$vt_per_tt10;$vt_per_tec11;$vt_per_ts12;$vt_per_to13)

  //****SOAP INPUTS****
SOAP DECLARATION:C782($1;Is text:K8:3;SOAP input:K46:1;"identificadorColegio")
SOAP DECLARATION:C782($2;Is text:K8:3;SOAP input:K46:1;"usuario")
SOAP DECLARATION:C782($3;Is text:K8:3;SOAP input:K46:1;"password")
SOAP DECLARATION:C782($4;Is text:K8:3;SOAP input:K46:1;"tipoWS")
SOAP DECLARATION:C782($5;Is text:K8:3;SOAP input:K46:1;"valor")

SOAP DECLARATION:C782($6;Is text:K8:3;SOAP input:K46:1;"vt_alu_n1")
SOAP DECLARATION:C782($7;Is text:K8:3;SOAP input:K46:1;"vt_alu_ap2")
SOAP DECLARATION:C782($8;Is text:K8:3;SOAP input:K46:1;"vt_alu_am3")
SOAP DECLARATION:C782($9;Is text:K8:3;SOAP input:K46:1;"vt_alu_r4")
SOAP DECLARATION:C782($10;Is text:K8:3;SOAP input:K46:1;"vt_alu_dv5")
SOAP DECLARATION:C782($11;Is text:K8:3;SOAP input:K46:1;"vt_alu_fn6")
SOAP DECLARATION:C782($12;Is text:K8:3;SOAP input:K46:1;"vt_alu_s7")
SOAP DECLARATION:C782($13;Is text:K8:3;SOAP input:K46:1;"vt_alu_dc8")
SOAP DECLARATION:C782($14;Is text:K8:3;SOAP input:K46:1;"vt_alu_c9")
SOAP DECLARATION:C782($15;Is text:K8:3;SOAP input:K46:1;"vt_alu_r10")
SOAP DECLARATION:C782($16;Is text:K8:3;SOAP input:K46:1;"vt_alu_t11")
SOAP DECLARATION:C782($17;Is text:K8:3;SOAP input:K46:1;"vt_alu_tm12")
SOAP DECLARATION:C782($18;Is text:K8:3;SOAP input:K46:1;"vt_alu_e13")
SOAP DECLARATION:C782($19;Is text:K8:3;SOAP input:K46:1;"vt_alu_ca14")
SOAP DECLARATION:C782($20;Is text:K8:3;SOAP input:K46:1;"vt_alu_ci15")
SOAP DECLARATION:C782($21;Is text:K8:3;SOAP input:K46:1;"vt_alu_c16")
SOAP DECLARATION:C782($22;Is text:K8:3;SOAP input:K46:1;"vt_cur_c1")
SOAP DECLARATION:C782($23;Is text:K8:3;SOAP input:K46:1;"vt_cur_n2")
SOAP DECLARATION:C782($24;Is text:K8:3;SOAP input:K46:1;"vt_cur_j3")
SOAP DECLARATION:C782($25;Is text:K8:3;SOAP input:K46:1;"vt_cp_aii1")
SOAP DECLARATION:C782($26;Is text:K8:3;SOAP input:K46:1;"vt_cp_ec2")
SOAP DECLARATION:C782($27;Is text:K8:3;SOAP input:K46:1;"vt_cp_ldt3")
SOAP DECLARATION:C782($28;Is text:K8:3;SOAP input:K46:1;"vt_cp_n4")
SOAP DECLARATION:C782($29;Is text:K8:3;SOAP input:K46:1;"vt_cp_o5")
SOAP DECLARATION:C782($30;Is text:K8:3;SOAP input:K46:1;"vt_cp_ppsu6")
SOAP DECLARATION:C782($31;Is text:K8:3;SOAP input:K46:1;"vt_cp_tc7")
SOAP DECLARATION:C782($32;Is text:K8:3;SOAP input:K46:1;"vt_cp_t8")
SOAP DECLARATION:C782($33;Is text:K8:3;SOAP input:K46:1;"vt_cp_apsu9")
SOAP DECLARATION:C782($34;Is text:K8:3;SOAP input:K46:1;"vt_per_tr1")
SOAP DECLARATION:C782($35;Is text:K8:3;SOAP input:K46:1;"vt_per_td2")
SOAP DECLARATION:C782($36;Is text:K8:3;SOAP input:K46:1;"vt_per_tn3")
SOAP DECLARATION:C782($37;Is text:K8:3;SOAP input:K46:1;"vt_per_tap4")
SOAP DECLARATION:C782($38;Is text:K8:3;SOAP input:K46:1;"vt_per_tam5")
SOAP DECLARATION:C782($39;Is text:K8:3;SOAP input:K46:1;"vt_per_tfn6")
SOAP DECLARATION:C782($40;Is text:K8:3;SOAP input:K46:1;"vt_per_td7")
SOAP DECLARATION:C782($41;Is text:K8:3;SOAP input:K46:1;"vt_per_tc8")
SOAP DECLARATION:C782($42;Is text:K8:3;SOAP input:K46:1;"vt_per_tr9")
SOAP DECLARATION:C782($43;Is text:K8:3;SOAP input:K46:1;"vt_per_tt10")
SOAP DECLARATION:C782($44;Is text:K8:3;SOAP input:K46:1;"vt_per_tec11")
SOAP DECLARATION:C782($45;Is text:K8:3;SOAP input:K46:1;"vt_per_ts12")
SOAP DECLARATION:C782($46;Is text:K8:3;SOAP input:K46:1;"vt_per_to13")


  //****INICIALIZACIONES****
$schoolID:=$1
$userName:=$2
$password:=$3
$tipoSolicitud:=$4
$vt_valor:=$5  //se usara para responder. Si todo se hace bien se devuelve este valor
$vt_alu_n1:=$6
$vt_alu_ap2:=$7
$vt_alu_am3:=$8
$vt_alu_r4:=$9
$vt_alu_dv5:=$10
$vt_alu_fn6:=$11
$vt_alu_s7:=$12
$vt_alu_dc8:=$13
$vt_alu_c9:=$14
$vt_alu_r10:=$15
$vt_alu_t11:=$16
$vt_alu_tm12:=$17
$vt_alu_e13:=$18
$vt_alu_ca14:=$19
$vt_alu_ci15:=$20
$vt_alu_c16:=$21

$vt_cur_c1:=$22
$vt_cur_n2:=$23
$vt_cur_j3:=$24
$vt_cp_aii1:=$25
$vt_cp_ec2:=$26
$vt_cp_ldt3:=$27
$vt_cp_n4:=$28
$vt_cp_o5:=$29
$vt_cp_ppsu6:=$30
$vt_cp_tc7:=$31
$vt_cp_t8:=$32
$vt_cp_apsu9:=$33
$vt_per_tr1:=$34
$vt_per_td2:=$35
$vt_per_tn3:=$36
$vt_per_tap4:=$37
$vt_per_tam5:=$38
$vt_per_tfn6:=$39
$vt_per_td7:=$40
$vt_per_tc8:=$41
$vt_per_tr9:=$42
$vt_per_tt10:=$43
$vt_per_tec11:=$44
$vt_per_ts12:=$45
$vt_per_to13:=$46

ARRAY LONGINT:C221(alACTws_Tabla;0)
ARRAY LONGINT:C221(alACTws_Campo;0)
ARRAY TEXT:C222(atACTws_NombreCP;0)
ARRAY TEXT:C222(atACTws_ValoresCampos;0)

APPEND TO ARRAY:C911(alACTws_Tabla;2)
APPEND TO ARRAY:C911(alACTws_Tabla;2)
APPEND TO ARRAY:C911(alACTws_Tabla;2)
APPEND TO ARRAY:C911(alACTws_Tabla;2)
APPEND TO ARRAY:C911(alACTws_Tabla;2)
APPEND TO ARRAY:C911(alACTws_Tabla;2)
APPEND TO ARRAY:C911(alACTws_Tabla;2)
APPEND TO ARRAY:C911(alACTws_Tabla;2)
APPEND TO ARRAY:C911(alACTws_Tabla;2)
APPEND TO ARRAY:C911(alACTws_Tabla;2)
APPEND TO ARRAY:C911(alACTws_Tabla;2)
APPEND TO ARRAY:C911(alACTws_Tabla;2)
APPEND TO ARRAY:C911(alACTws_Tabla;2)
APPEND TO ARRAY:C911(alACTws_Tabla;2)
APPEND TO ARRAY:C911(alACTws_Tabla;2)
APPEND TO ARRAY:C911(alACTws_Tabla;3)
APPEND TO ARRAY:C911(alACTws_Tabla;3)
APPEND TO ARRAY:C911(alACTws_Tabla;3)
APPEND TO ARRAY:C911(alACTws_Tabla;2)
APPEND TO ARRAY:C911(alACTws_Tabla;2)
APPEND TO ARRAY:C911(alACTws_Tabla;2)
APPEND TO ARRAY:C911(alACTws_Tabla;2)
APPEND TO ARRAY:C911(alACTws_Tabla;2)
APPEND TO ARRAY:C911(alACTws_Tabla;2)
APPEND TO ARRAY:C911(alACTws_Tabla;2)
APPEND TO ARRAY:C911(alACTws_Tabla;2)
APPEND TO ARRAY:C911(alACTws_Tabla;2)
APPEND TO ARRAY:C911(alACTws_Tabla;7)
APPEND TO ARRAY:C911(alACTws_Tabla;7)
APPEND TO ARRAY:C911(alACTws_Tabla;7)
APPEND TO ARRAY:C911(alACTws_Tabla;7)
APPEND TO ARRAY:C911(alACTws_Tabla;7)
APPEND TO ARRAY:C911(alACTws_Tabla;7)
APPEND TO ARRAY:C911(alACTws_Tabla;7)
APPEND TO ARRAY:C911(alACTws_Tabla;7)
APPEND TO ARRAY:C911(alACTws_Tabla;7)
APPEND TO ARRAY:C911(alACTws_Tabla;7)
APPEND TO ARRAY:C911(alACTws_Tabla;7)
APPEND TO ARRAY:C911(alACTws_Tabla;7)


APPEND TO ARRAY:C911(alACTws_Campo;Field:C253(->[Alumnos:2]Nombres:2))
APPEND TO ARRAY:C911(alACTws_Campo;Field:C253(->[Alumnos:2]Apellido_paterno:3))
APPEND TO ARRAY:C911(alACTws_Campo;Field:C253(->[Alumnos:2]Apellido_materno:4))
APPEND TO ARRAY:C911(alACTws_Campo;Field:C253(->[Alumnos:2]RUT:5))
APPEND TO ARRAY:C911(alACTws_Campo;Field:C253(->[Alumnos:2]Fecha_de_nacimiento:7))
APPEND TO ARRAY:C911(alACTws_Campo;Field:C253(->[Alumnos:2]Sexo:49))
APPEND TO ARRAY:C911(alACTws_Campo;Field:C253(->[Alumnos:2]Direccion:12))
APPEND TO ARRAY:C911(alACTws_Campo;Field:C253(->[Alumnos:2]Comuna:14))
APPEND TO ARRAY:C911(alACTws_Campo;Field:C253(->[Alumnos:2]Región_o_estado:16))
APPEND TO ARRAY:C911(alACTws_Campo;Field:C253(->[Alumnos:2]Telefono:17))
APPEND TO ARRAY:C911(alACTws_Campo;Field:C253(->[Alumnos:2]Celular:95))
APPEND TO ARRAY:C911(alACTws_Campo;Field:C253(->[Alumnos:2]eMAIL:68))
APPEND TO ARRAY:C911(alACTws_Campo;Field:C253(->[Alumnos:2]Colegio_de_origen:25))
APPEND TO ARRAY:C911(alACTws_Campo;Field:C253(->[Alumnos:2]Codigo_interno:6))
APPEND TO ARRAY:C911(alACTws_Campo;Field:C253(->[Alumnos:2]curso:20))
APPEND TO ARRAY:C911(alACTws_Campo;Field:C253(->[Cursos:3]Sede:19))
APPEND TO ARRAY:C911(alACTws_Campo;Field:C253(->[Cursos:3]Nivel_Numero:7))
APPEND TO ARRAY:C911(alACTws_Campo;Field:C253(->[Cursos:3]Sala:3))
APPEND TO ARRAY:C911(alACTws_Campo;0)
APPEND TO ARRAY:C911(alACTws_Campo;0)
APPEND TO ARRAY:C911(alACTws_Campo;0)
APPEND TO ARRAY:C911(alACTws_Campo;0)
APPEND TO ARRAY:C911(alACTws_Campo;0)
APPEND TO ARRAY:C911(alACTws_Campo;0)
APPEND TO ARRAY:C911(alACTws_Campo;0)
APPEND TO ARRAY:C911(alACTws_Campo;0)
APPEND TO ARRAY:C911(alACTws_Campo;0)
APPEND TO ARRAY:C911(alACTws_Campo;Field:C253(->[Personas:7]RUT:6))
APPEND TO ARRAY:C911(alACTws_Campo;Field:C253(->[Personas:7]Nombres:2))
APPEND TO ARRAY:C911(alACTws_Campo;Field:C253(->[Personas:7]Apellido_paterno:3))
APPEND TO ARRAY:C911(alACTws_Campo;Field:C253(->[Personas:7]Apellido_materno:4))
APPEND TO ARRAY:C911(alACTws_Campo;Field:C253(->[Personas:7]Fecha_de_nacimiento:5))
APPEND TO ARRAY:C911(alACTws_Campo;Field:C253(->[Personas:7]Direccion:14))
APPEND TO ARRAY:C911(alACTws_Campo;Field:C253(->[Personas:7]Comuna:16))
APPEND TO ARRAY:C911(alACTws_Campo;Field:C253(->[Personas:7]Region_o_Estado:18))
APPEND TO ARRAY:C911(alACTws_Campo;Field:C253(->[Personas:7]Telefono_domicilio:19))
APPEND TO ARRAY:C911(alACTws_Campo;Field:C253(->[Personas:7]Estado_civil:10))
APPEND TO ARRAY:C911(alACTws_Campo;Field:C253(->[Personas:7]Sexo:8))
APPEND TO ARRAY:C911(alACTws_Campo;Field:C253(->[Personas:7]Profesion:13))

  //AT_RedimArrays (18;->atACTws_NombreCP) 
AT_RedimArrays (18;->atACTws_NombreCP)  //dv rut

APPEND TO ARRAY:C911(atACTws_NombreCP;"Año Ingreso ITC")
APPEND TO ARRAY:C911(atACTws_NombreCP;"Estado Civil")
APPEND TO ARRAY:C911(atACTws_NombreCP;"Lugar de Trabajo")
APPEND TO ARRAY:C911(atACTws_NombreCP;"NEM")
APPEND TO ARRAY:C911(atACTws_NombreCP;"Ocupación")
APPEND TO ARRAY:C911(atACTws_NombreCP;"Puntaje PSU")
APPEND TO ARRAY:C911(atACTws_NombreCP;"Teléfono Comercial")
APPEND TO ARRAY:C911(atACTws_NombreCP;"Trabaja")
APPEND TO ARRAY:C911(atACTws_NombreCP;"Año PSU")
APPEND TO ARRAY:C911(atACTws_NombreCP;"")
APPEND TO ARRAY:C911(atACTws_NombreCP;"")
APPEND TO ARRAY:C911(atACTws_NombreCP;"")
APPEND TO ARRAY:C911(atACTws_NombreCP;"")
APPEND TO ARRAY:C911(atACTws_NombreCP;"")
APPEND TO ARRAY:C911(atACTws_NombreCP;"")
APPEND TO ARRAY:C911(atACTws_NombreCP;"")
APPEND TO ARRAY:C911(atACTws_NombreCP;"")
APPEND TO ARRAY:C911(atACTws_NombreCP;"")
APPEND TO ARRAY:C911(atACTws_NombreCP;"")
APPEND TO ARRAY:C911(atACTws_NombreCP;"")
APPEND TO ARRAY:C911(atACTws_NombreCP;"")

APPEND TO ARRAY:C911(atACTws_ValoresCampos;$vt_alu_n1)
APPEND TO ARRAY:C911(atACTws_ValoresCampos;$vt_alu_ap2)
APPEND TO ARRAY:C911(atACTws_ValoresCampos;$vt_alu_am3)
APPEND TO ARRAY:C911(atACTws_ValoresCampos;$vt_alu_r4+$vt_alu_dv5)
APPEND TO ARRAY:C911(atACTws_ValoresCampos;$vt_alu_fn6)
APPEND TO ARRAY:C911(atACTws_ValoresCampos;$vt_alu_s7)
APPEND TO ARRAY:C911(atACTws_ValoresCampos;$vt_alu_dc8)
APPEND TO ARRAY:C911(atACTws_ValoresCampos;$vt_alu_c9)
APPEND TO ARRAY:C911(atACTws_ValoresCampos;$vt_alu_r10)
APPEND TO ARRAY:C911(atACTws_ValoresCampos;$vt_alu_t11)
APPEND TO ARRAY:C911(atACTws_ValoresCampos;$vt_alu_tm12)
APPEND TO ARRAY:C911(atACTws_ValoresCampos;$vt_alu_e13)
APPEND TO ARRAY:C911(atACTws_ValoresCampos;$vt_alu_ca14)
APPEND TO ARRAY:C911(atACTws_ValoresCampos;$vt_alu_ci15)
APPEND TO ARRAY:C911(atACTws_ValoresCampos;$vt_alu_c16)
APPEND TO ARRAY:C911(atACTws_ValoresCampos;$vt_cur_c1)
APPEND TO ARRAY:C911(atACTws_ValoresCampos;$vt_cur_n2)
APPEND TO ARRAY:C911(atACTws_ValoresCampos;$vt_cur_j3)
APPEND TO ARRAY:C911(atACTws_ValoresCampos;$vt_cp_aii1)
APPEND TO ARRAY:C911(atACTws_ValoresCampos;$vt_cp_ec2)
APPEND TO ARRAY:C911(atACTws_ValoresCampos;$vt_cp_ldt3)
APPEND TO ARRAY:C911(atACTws_ValoresCampos;$vt_cp_n4)
APPEND TO ARRAY:C911(atACTws_ValoresCampos;$vt_cp_o5)
APPEND TO ARRAY:C911(atACTws_ValoresCampos;$vt_cp_ppsu6)
APPEND TO ARRAY:C911(atACTws_ValoresCampos;$vt_cp_tc7)
APPEND TO ARRAY:C911(atACTws_ValoresCampos;$vt_cp_t8)
APPEND TO ARRAY:C911(atACTws_ValoresCampos;$vt_cp_apsu9)
APPEND TO ARRAY:C911(atACTws_ValoresCampos;$vt_per_tr1+$vt_per_td2)
APPEND TO ARRAY:C911(atACTws_ValoresCampos;$vt_per_tn3)
APPEND TO ARRAY:C911(atACTws_ValoresCampos;$vt_per_tap4)
APPEND TO ARRAY:C911(atACTws_ValoresCampos;$vt_per_tam5)
APPEND TO ARRAY:C911(atACTws_ValoresCampos;$vt_per_tfn6)
APPEND TO ARRAY:C911(atACTws_ValoresCampos;$vt_per_td7)
APPEND TO ARRAY:C911(atACTws_ValoresCampos;$vt_per_tc8)
APPEND TO ARRAY:C911(atACTws_ValoresCampos;$vt_per_tr9)
APPEND TO ARRAY:C911(atACTws_ValoresCampos;$vt_per_tt10)
APPEND TO ARRAY:C911(atACTws_ValoresCampos;$vt_per_tec11)
APPEND TO ARRAY:C911(atACTws_ValoresCampos;$vt_per_ts12)
APPEND TO ARRAY:C911(atACTws_ValoresCampos;$vt_per_to13)

vtWS_ErrorString:=""
vtWS_result:=""

  //****SOAP OUTPUTS****
SOAP DECLARATION:C782(vtWS_ErrorString;Is text:K8:3;SOAP output:K46:2;"mensajeError")
SOAP DECLARATION:C782(vtWS_result;Is text:K8:3;SOAP output:K46:2;"result")


  //****CUERPO****
ST_LoadModuleFormatExceptions 
TRACE:C157
ALL RECORDS:C47([Colegio:31])
FIRST RECORD:C50([Colegio:31])

If (($schoolID=[Colegio:31]Rol Base Datos:9) & ($schoolID="ITC"))
	vs_Name:=$userName
	vs_Password:=$password
	$logged:=USR_ProcessLogin 
	TRACE:C157
	If ($logged=1)
		Case of 
			: ($tipoSolicitud="rutExiste2")
				READ ONLY:C145([Alumnos:2])
				QUERY:C277([Alumnos:2];[Alumnos:2]RUT:5=$vt_valor)
				vtWS_result:=String:C10(Records in selection:C76([Alumnos:2]))
				
			: ($tipoSolicitud="rutExiste")
				$vt_valor:=CTRY_CL_VerifRUT ($vt_valor;False:C215)
				If ($vt_valor#"")
					READ ONLY:C145([Alumnos:2])
					QUERY:C277([Alumnos:2];[Alumnos:2]RUT:5=$vt_valor)
					vtWS_result:=String:C10(Records in selection:C76([Alumnos:2]))
				Else 
					vtWS_ErrorString:="Rut incorrecto (Error -3)"
				End if 
			: ($tipoSolicitud="insertaRegistro")
				vtWS_ErrorString:="Importando... Proceso no terminado (Error -5)"
				  //ON ERR CALL("ERR_GenericOnError")
				
				$inscribeAlumnos:=1
				
				READ WRITE:C146([Alumnos:2])
				READ WRITE:C146([Personas:7])
				READ WRITE:C146([Familia:78])
				READ WRITE:C146([Cursos:3])
				READ WRITE:C146([Familia_RelacionesFamiliares:77])
				CREATE EMPTY SET:C140([Alumnos:2];"Importación")
				
				EVS_LoadStyles 
				
				TRACE:C157
				
				$vl_StudentRecNum:=-1
				$vl_FamilyRecNum:=-1
				$vl_apCuentasRecNum:=-1
				
				  //********** INICIO CREACION ALUMNO **********
				C_LONGINT:C283($tableNum;$fieldNum)
				UFLD_LoadFileTplt (->[Alumnos:2];"SchoolTrack")
				
				$vt_rut:=$vt_alu_r4+$vt_alu_dv5
				READ WRITE:C146([Alumnos:2])
				QUERY:C277([Alumnos:2];[Alumnos:2]RUT:5=$vt_rut)
				If ((Records in selection:C76([Alumnos:2])=0) | ($vt_alu_r4="") | ($vt_alu_dv5=""))
					CREATE RECORD:C68([Alumnos:2])
					[Alumnos:2]numero:1:=SQ_SeqNumber (->[Alumnos:2]numero:1)
					[Alumnos:2]Fecha_de_Creacion:21:=Current date:C33
					CREATE RECORD:C68([Alumnos_FichaMedica:13])
					[Alumnos_FichaMedica:13]Alumno_Numero:1:=[Alumnos:2]numero:1
					[Alumnos_FichaMedica:13]OB_tratamiento:23:=OB_Create 
				Else 
					KRL_FindAndLoadRecordByIndex (->[Alumnos_FichaMedica:13]Alumno_Numero:1;->[Alumnos:2]numero:1;True:C214)
				End if 
				
				For ($i;1;Size of array:C274(alACTws_Tabla))
					If (alACTws_Tabla{$i}=2)
						$text:=ST_GetCleanString (atACTws_ValoresCampos{$i})
						If (alACTws_Campo{$i}#0)
							$isCustomField:=False:C215
							$pointer:=Field:C253(alACTws_Tabla{$i};alACTws_Campo{$i})
						Else 
							$isCustomField:=True:C214
						End if 
						Case of 
							: ($isCustomField)
								$recordFieldName:=atACTws_NombreCP{$i}
								If ($text#"")
									$el:=Find in array:C230(aUFList;$recordFieldName)
									If ($el>0)
										$code:=String:C10(aUFID{$el};"00000")+"/"
										If (aUFMulti{$el})
											_O_CREATE SUBRECORD:C72([Alumnos:2]Userfields:54)
										Else 
											_O_QUERY SUBRECORDS:C108([Alumnos:2]Userfields:54;[Alumnos]Userfields'Value=($code+"@"))
											If (_O_Records in subselection:C7([Alumnos:2]Userfields:54)=0)
												_O_CREATE SUBRECORD:C72([Alumnos:2]Userfields:54)
											End if 
										End if 
										Case of 
											: (aUFType{$el}=0)
												$value:=$text
											: (aUFType{$el}=1)
												$n:=Num:C11($text)
												$value:=String:C10($n;"### ### ##0,00")
											: (aUFType{$el}=4)
												$d:=Date:C102($text)
												$text:=String:C10($d;7)
												$value:=String:C10(DT_Date2Num (Date:C102($text));"0000000000")
											: (aUFType{$el}=9)
												$n:=Num:C11($text)
												$value:=String:C10($n;"### ### ##0")
										End case 
										[Alumnos]Userfields'Value:=$code+$value
									End if 
								End if 
							Else 
								$type:=Type:C295($pointer->)
								Case of 
									: ($type=Is date:K8:7)
										$pointer->:=DT_GetDateFromDayMonthYear (Num:C11(Substring:C12($text;7;2));Num:C11(Substring:C12($text;5;2));Num:C11(Substring:C12($text;1;4)))
									Else 
										$pointer->:=$text
								End case 
						End case 
					End if 
				End for 
				
				READ ONLY:C145([Cursos:3])
				QUERY:C277([Cursos:3];[Cursos:3]Curso:1=[Alumnos:2]curso:20)
				[Alumnos:2]nivel_numero:29:=[Cursos:3]Nivel_Numero:7
				[Alumnos:2]Nivel_Nombre:34:=[Cursos:3]Nivel_Nombre:10
				
				[Alumnos:2]RUT:5:=Replace string:C233(Replace string:C233([Alumnos:2]RUT:5;".";"");"-";"")
				
				[Alumnos:2]Apellido_paterno:3:=ST_Format (->[Alumnos:2]Apellido_paterno:3)
				[Alumnos:2]Apellido_materno:4:=ST_Format (->[Alumnos:2]Apellido_materno:4)
				[Alumnos:2]Nombres:2:=ST_Format (->[Alumnos:2]Nombres:2)
				AL_ProcesaNombres (False:C215)
				
				If (([Alumnos:2]Apellido_paterno:3#"") & ([Alumnos:2]Nombres:2#""))
					[Alumnos_FichaMedica:13]Alumno_Numero:1:=[Alumnos:2]numero:1
					$el:=Find in array:C230(<>al_NumeroNivelesActivos;[Alumnos:2]nivel_numero:29)
					If (($el>0) & ([Alumnos:2]curso:20=""))
						[Alumnos:2]curso:20:="A"
					End if 
					Case of 
						: ([Alumnos:2]nivel_numero:29=Nivel_AdmisionDirecta)
							[Alumnos:2]curso:20:=""
							[Alumnos:2]Nivel_Nombre:34:="Admisión Directa"
							[Alumnos:2]Sección:26:="Admisión"
						: ([Alumnos:2]nivel_numero:29=Nivel_Egresados)
							If ([Alumnos:2]curso:20="")
								[Alumnos:2]curso:20:="EGR"
							End if 
							[Alumnos:2]Nivel_Nombre:34:="Egresados"
							[Alumnos:2]Sección:26:="Egresados"
						: ([Alumnos:2]nivel_numero:29=Nivel_Retirados)
							If ([Alumnos:2]curso:20="")
								[Alumnos:2]curso:20:="RET"
							End if 
							[Alumnos:2]Nivel_Nombre:34:="Retirados"
							[Alumnos:2]Sección:26:="Retirados"
						: (($el>0) & ([Alumnos:2]curso:20#""))
							
							  //[Alumnos]Curso:=KRL_GetTextFieldData (->[xxSTR_Niveles]NoNivel;->[Alumnos]Nivel_Número;->[xxSTR_Niveles]Abreviatura)+"-"+[Alumnos]Curso
							[Alumnos:2]Nivel_Nombre:34:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]Nivel:1)
							[Alumnos:2]Sección:26:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]Sección:9)
							QUERY:C277([Cursos:3];[Cursos:3]Curso:1=[Alumnos:2]curso:20)
							If (Records in selection:C76([Cursos:3])=0)
								CREATE RECORD:C68([Cursos:3])
								[Cursos:3]Curso:1:=[Alumnos:2]curso:20
								[Cursos:3]Ciclo:5:=[Alumnos:2]Sección:26
								[Cursos:3]Letra_del_curso:9:=Substring:C12([Alumnos:2]curso:20;Position:C15("-";[Alumnos:2]curso:20)+1)
								[Cursos:3]Nivel_Nombre:10:=[Alumnos:2]Nivel_Nombre:34
								[Cursos:3]Nivel_Numero:7:=[Alumnos:2]nivel_numero:29
								[Cursos:3]Numero_del_curso:6:=SQ_SeqNumber (->[Cursos:3]Numero_del_curso:6)
								$startAt:=Find in array:C230(alACTws_Tabla;3)
								For ($i;$startAt;Size of array:C274(alACTws_Tabla))
									If (alACTws_Tabla{$i}=3)
										$text:=ST_GetCleanString (atACTws_ValoresCampos{$i})
										$pointer:=Field:C253(alACTws_Tabla{$i};alACTws_Campo{$i})
										$type:=Type:C295($pointer->)
										Case of 
											: ($type=Is date:K8:7)
												$pointer->:=DT_GetDateFromDayMonthYear (Num:C11(Substring:C12($text;7;2));Num:C11(Substring:C12($text;5;2));Num:C11(Substring:C12($text;1;4)))
											Else 
												$pointer->:=$text
										End case 
									End if 
								End for 
							End if 
							SAVE RECORD:C53([Cursos:3])
						Else 
							[Alumnos:2]curso:20:=""
							[Alumnos:2]nivel_numero:29:=Nivel_AdmisionDirecta
							[Alumnos:2]Nivel_Nombre:34:="Admisión"
					End case 
					
					SAVE RECORD:C53([Alumnos_FichaMedica:13])
					
					[Alumnos:2]Fecha_de_modificacion:22:=Current date:C33
					[Alumnos:2]Modificado_por:23:="Importación"
					
					If (Not:C34(Is new record:C668([Alumnos:2])))
						[Alumnos:2]curso:20:=Old:C35([Alumnos:2]curso:20)
						[Alumnos:2]nivel_numero:29:=Old:C35([Alumnos:2]nivel_numero:29)
						[Alumnos:2]Nivel_Nombre:34:=Old:C35([Alumnos:2]Nivel_Nombre:34)
						[Alumnos:2]Sección:26:=Old:C35([Alumnos:2]Sección:26)
					End if 
					
					SAVE RECORD:C53([Alumnos:2])
					ADD TO SET:C119([Alumnos:2];"Importación")
					$vl_StudentRecNum:=Record number:C243([Alumnos:2])
				Else 
					$vl_StudentRecNum:=-1
				End if 
				
				  //********** FIN **********
				
				If ($vl_StudentRecNum>=0)
					  //IOstr_ProcessFamilyRecord 
					  //********** INICIO IMPORTACION FAMILIA **********
					KRL_GotoRecord (->[Alumnos:2];$vl_StudentRecNum;True:C214)
					CREATE RECORD:C68([Familia:78])
					[Familia:78]Numero:1:=SQ_SeqNumber (->[Familia:78]Numero:1)
					[Familia:78]Fecha_de_creación:27:=Current date:C33(*)
					[Familia:78]Fecha_de_Modificacion:28:=[Personas:7]Fecha_de_Creacion:26
					[Familia:78]Nombre_de_la_familia:3:=[Alumnos:2]Apellido_paterno:3+" "+[Alumnos:2]Apellido_materno:4
					If ([Familia:78]Nombre_de_la_familia:3#"")
						If ([Familia:78]Nombre_de_la_familia:3="")
							[Familia:78]Nombre_de_la_familia:3:=ST_ClearSpaces ([Alumnos:2]Apellido_paterno:3+" "+[Alumnos:2]Apellido_materno:4)
						End if 
						[Familia:78]Nombre_de_la_familia:3:=ST_Format (->[Familia:78]Nombre_de_la_familia:3)
						SAVE RECORD:C53([Familia:78])
					End if 
					$familyRecNum:=Record number:C243([Familia:78])
					  //********** FIN **********
					
					  //********** INICIO IMPORTACION RELACION FAMILIAR COMO OTRO **********
					  //IOstr_ProcessParentRecord
					
					QUERY:C277([Personas:7];[Personas:7]RUT:6=$vt_per_tr1+$vt_per_td2)
					If (Records in selection:C76([Personas:7])=0)
						CREATE RECORD:C68([Personas:7])
						[Personas:7]No:1:=SQ_SeqNumber (->[Personas:7]No:1)
						[Personas:7]Modificado_por:28:="Importación"
						[Personas:7]Fecha_de_Creacion:26:=Current date:C33(*)
						[Personas:7]Fecha_de_Modificacion:27:=[Personas:7]Fecha_de_Creacion:26
					Else 
						[Personas:7]Modificado_por:28:="Importación"
						[Personas:7]Fecha_de_Modificacion:27:=Current date:C33(*)
					End if 
					$startAt:=Find in array:C230(alACTws_Tabla;7)
					For ($i;$startAt;Size of array:C274(alACTws_Tabla))
						If (alACTws_Tabla{$i}=7)
							$text:=ST_GetCleanString (atACTws_ValoresCampos{$i})
							If (alACTws_Campo{$i}#0)
								$pointer:=Field:C253(alACTws_Tabla{$i};alACTws_Campo{$i})
								$type:=Type:C295($pointer->)
								$isCustomField:=False:C215
							Else 
								$isCustomField:=True:C214
							End if 
							Case of 
								: ($isCustomField)
									$recordFieldName:=atACTws_NombreCP{$i}
									If ($text#"")
										$el:=Find in array:C230(aUFList;$recordFieldName)
										If ($el>0)
											$code:=String:C10(aUFID{$el};"00000")+"/"
											If (aUFMulti{$el})
												_O_CREATE SUBRECORD:C72([Personas:7]Userfields:31)
											Else 
												_O_QUERY SUBRECORDS:C108([Personas:7]Userfields:31;[Personas]Userfields'Value=$code)
												If (_O_Records in subselection:C7([Personas:7]Userfields:31)=0)
													_O_CREATE SUBRECORD:C72([Personas:7]Userfields:31)
												End if 
											End if 
											Case of 
												: (aUFType{$el}=0)
													$value:=$text
												: (aUFType{$el}=1)
													$n:=Num:C11($text)
													$value:=String:C10($n;"### ### ##0,00")
												: (aUFType{$el}=4)
													$d:=Date:C102($text)
													$text:=String:C10($d;7)
													$value:=String:C10(DT_Date2Num (Date:C102($text));"0000000000")
												: (aUFType{$el}=9)
													$n:=Num:C11($text)
													$value:=String:C10($n;"### ### ##0")
											End case 
											[Personas]Userfields'Value:=$code+$value
										End if 
									End if 
								Else 
									Case of 
										: ($type=Is date:K8:7)
											$pointer->:=DT_GetDateFromDayMonthYear (Num:C11(Substring:C12($text;7;2));Num:C11(Substring:C12($text;5;2));Num:C11(Substring:C12($text;1;4)))
										Else 
											$pointer->:=$text
									End case 
							End case 
							
						End if 
					End for 
					
					If ([Personas:7]Apellido_paterno:3#"")
						[Personas:7]Apellido_paterno:3:=ST_Format (->[Personas:7]Apellido_paterno:3)
						[Personas:7]Apellido_materno:4:=ST_Format (->[Personas:7]Apellido_materno:4)
						[Personas:7]Nombres:2:=ST_Format (->[Personas:7]Nombres:2)
						[Personas:7]Apellidos_y_nombres:30:=Replace string:C233([Personas:7]Apellido_paterno:3+" "+[Personas:7]Apellido_materno:4+" "+[Personas:7]Nombres:2;"  ";" ")
						[Personas:7]Apellidos_y_nombres:30:=ST_Format (->[Personas:7]Apellidos_y_nombres:30)
						[Personas:7]Direccion_Profesional:23:=ST_Format (->[Personas:7]Direccion_Profesional:23)
						[Personas:7]Cargo:21:=ST_Format (->[Personas:7]Cargo:21)
						[Personas:7]Empresa:20:=ST_Format (->[Personas:7]Empresa:20)
						If (Record number:C243([Personas:7])=-3)
							SAVE RECORD:C53([Personas:7])
						Else 
							SAVE RECORD:C53([Personas:7])
						End if 
					End if 
					$vl_apCuentasRecNum:=Record number:C243([Personas:7])
					  //********** FIN **********
					
					KRL_GotoRecord (->[Alumnos:2];$vl_StudentRecNum;True:C214)
					vl_MotherRecNum:=-1
					vl_FatherRecNum:=-1
					vl_apAcademicoRecNum:=-1
					vl_apCuentasRecNum:=$vl_apCuentasRecNum
					IOstr_linkStudentToFamily ($familyRecNum)
					
					KRL_GotoRecord (->[Alumnos:2];$vl_StudentRecNum;True:C214)
					If ($vl_apCuentasRecNum>=0)
						GOTO RECORD:C242([Personas:7];$vl_apCuentasRecNum)
						[Alumnos:2]Apoderado_Cuentas_Número:28:=[Personas:7]No:1
					End if 
					
					KRL_GotoRecord (->[Alumnos:2];$vl_StudentRecNum;True:C214)
					If ($familyRecNum>=0)
						GOTO RECORD:C242([Familia:78];$familyRecNum)
						[Alumnos:2]Familia_Número:24:=[Familia:78]Numero:1
					End if 
					
					SAVE RECORD:C53([Alumnos:2])
					SAVE RECORD:C53([Alumnos_FichaMedica:13])
					
					If ($familyRecNum>=0)
						READ WRITE:C146([Familia:78])
						GOTO RECORD:C242([Familia:78];$familyRecNum)
						READ ONLY:C145([Personas:7])
						If ([Familia:78]Madre_Número:6#0)
							QUERY:C277([Personas:7];[Personas:7]No:1=[Familia:78]Madre_Número:6)
							[Familia:78]Madre_Nombre:16:=[Personas:7]Apellidos_y_nombres:30
							[Familia:78]Nombres_padres:22:=[Personas:7]Nombres:2
							If ([Familia:78]Padre_Número:5#0)
								QUERY:C277([Personas:7];[Personas:7]No:1=[Familia:78]Padre_Número:5)
								[Familia:78]Padre_Nombre:15:=[Personas:7]Apellidos_y_nombres:30
								[Familia:78]Nombres_padres:22:=[Familia:78]Nombres_padres:22+"\r"+[Personas:7]Nombres:2
							End if 
						Else 
							[Familia:78]Madre_Nombre:16:=""
							If ([Familia:78]Padre_Número:5#0)
								QUERY:C277([Personas:7];[Personas:7]No:1=[Familia:78]Padre_Número:5)
								[Familia:78]Padre_Nombre:15:=[Personas:7]Apellidos_y_nombres:30
								[Familia:78]Nombres_padres:22:=[Personas:7]Nombres:2
							Else 
								[Familia:78]Padre_Nombre:15:=""
							End if 
						End if 
						SAVE RECORD:C53([Familia:78])
					End if 
				End if 
				
				
				C_LONGINT:C283($s)
				If (Records in set:C195("Importación")>0)
					USE SET:C118("Importación")
					SELECTION TO ARRAY:C260([Alumnos:2];$recNums)
					$s:=Size of array:C274($recNums)
					For ($i;1;$s)
						GOTO RECORD:C242([Alumnos:2];$recNums{$i})
						AL_CreaRegistros 
					End for 
					CLEAR SET:C117("Importación")
				End if 
				
				If ($inscribeAlumnos=1)
					For ($i;1;$s)
						GOTO RECORD:C242([Alumnos:2];$recNums{$i})
						AL_CreateGradeRecords 
					End for 
					CLEAR SET:C117("Importación")
				End if 
				
				KRL_UnloadReadOnly (->[Alumnos_FichaMedica:13])
				KRL_UnloadReadOnly (->[Alumnos:2])
				KRL_UnloadReadOnly (->[Personas:7])
				KRL_UnloadReadOnly (->[Familia:78])
				KRL_UnloadReadOnly (->[Cursos:3])
				KRL_UnloadReadOnly (->[Familia_RelacionesFamiliares:77])
				CU_LoadArrays 
				
				ARRAY TEXT:C222(aListElements;0)
				READ WRITE:C146([xShell_List:39])
				QUERY:C277([xShell_List:39];[xShell_List:39]Listname:1="Secciones")
				TBL_Rebuild 
				  //BLOB_Variables2Blob (->[xShell_List]Contents;0;->aListElements)
				  //SAVE RECORD([xShell_List])
				TBL_SaveListAndArrays (->aListElements)
				UNLOAD RECORD:C212([xShell_List:39])
				READ ONLY:C145([xShell_List:39])
				
				If ($s>0)
					vtWS_ErrorString:=""
					vtWS_result:=$vt_valor
				Else 
					vtWS_ErrorString:="Registro no importado (Error -4)"
				End if 
				FLUSH CACHE:C297
		End case 
		
	Else 
		vtWS_ErrorString:="Nombre de usuario o contraseña incorrecto (Error -2)"
	End if 
Else 
	vtWS_ErrorString:="Identificador de la institución incorrecto (Error -1)"
End if 




  //C_TEXT($vt_alu_n1;$vt_alu_ap2;$vt_alu_am3;$vt_alu_r4;$vt_alu_dv5;$vt_alu_fn6;$vt_alu_s7;$vt_alu_dc8;$vt_alu_c9;$vt_alu_r10;$vt_alu_t11;$vt_alu_tm12;$vt_alu_e13;$vt_alu_ca14;$vt_alu_ci15;$vt_alu_ci16;$vt_cur_c1;$vt_cur_n2;$vt_cur_j3;$vt_cp_aii1;$vt_cp_ec2;$vt_cp_ldt3;$vt_cp_n4;$vt_cp_o5;$vt_cp_ppsu6;$vt_cp_tc7;$vt_cp_t8;$vt_cp_apsu9;$vt_per_tr1;$vt_per_td2;$vt_per_tn3;$vt_per_tap4;$vt_per_tam5;$vt_per_tfn6;$vt_per_td7;$vt_per_tc8;$vt_per_tr9;$vt_per_tt10;$vt_per_tec11;$vt_per_ts12;$vt_per_to13)
  //
  //$vt_identificadorColegio:="ITC"
  //$vt_usuario:="Administrador"
  //$vt_password:="123"
  //$vt_tipoWS:="insertaRegistro"
  //$vt_valor:="Correcto"
  //
  //ret1:=""
  //ret2:=""
  //
  //$vt_alu_n1:="Juan"
  //$vt_alu_ap2:="Pérez"
  //$vt_alu_am3:="Pérez"
  //$vt_alu_r4:="1"
  //$vt_alu_dv5:="9"
  //$vt_alu_fn6:="20100101"
  //$vt_alu_s7:="M"
  //$vt_alu_dc8:="Bilbao 6103"
  //$vt_alu_c9:=""
  //$vt_alu_r10:=""
  //$vt_alu_t11:="6567500"
  //$vt_alu_tm12:="99999999"
  //$vt_alu_e13:="email@email.com"
  //$vt_alu_ca14:=""
  //$vt_alu_ci15:=""
  //$vt_alu_ci16:="1S-C019JE"
  //$vt_cur_c1:=""
  //$vt_cur_n2:=""
  //$vt_cur_j3:=""
  //$vt_cp_aii1:="2007"
  //$vt_cp_ec2:="Casado(a)"
  //$vt_cp_ldt3:=""
  //$vt_cp_n4:="60"
  //$vt_cp_o5:=""
  //$vt_cp_ppsu6:="500"
  //$vt_cp_tc7:=""
  //$vt_cp_t8:=""
  //$vt_cp_apsu9:="2010"
  //
  //$vt_per_tr1:="2"
  //$vt_per_td2:="7"
  //$vt_per_tn3:="Daniel"
  //$vt_per_tap4:="Ledezma"
  //$vt_per_tam5:="Chirino"
  //$vt_per_tfn6:="19811012"
  //$vt_per_td7:=""
  //$vt_per_tc8:=""
  //$vt_per_tr9:=""
  //$vt_per_tt10:=""
  //$vt_per_tec11:="Soltero"
  //$vt_per_ts12:="M"
  //$vt_per_to13:=""
  //
  //WS_DatosITC ($vt_identificadorColegio;$vt_usuario;$vt_password;$vt_tipoWS;$vt_valor;$vt_alu_n1;$vt_alu_ap2;$vt_alu_am3;$vt_alu_r4;$vt_alu_dv5;$vt_alu_fn6;$vt_alu_s7;$vt_alu_dc8;$vt_alu_c9;$vt_alu_r10;$vt_alu_t11;$vt_alu_tm12;$vt_alu_e13;$vt_alu_ca14;$vt_alu_ci15;$vt_alu_ci16;$vt_cur_c1;$vt_cur_n2;$vt_cur_j3;$vt_cp_aii1;$vt_cp_ec2;$vt_cp_ldt3;$vt_cp_n4;$vt_cp_o5;$vt_cp_ppsu6;$vt_cp_tc7;$vt_cp_t8;$vt_cp_apsu9;$vt_per_tr1;$vt_per_td2;$vt_per_tn3;$vt_per_tap4;$vt_per_tam5;$vt_per_tfn6;$vt_per_td7;$vt_per_tc8;$vt_per_tr9;$vt_per_tt10;$vt_per_tec11;$vt_per_ts12;$vt_per_to13)
  //ret1:=ret1
  //ret2:=ret2


