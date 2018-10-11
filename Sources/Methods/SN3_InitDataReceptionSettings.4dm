//%attributes = {}
  //CONFIG GENERAL NOTIFICACIONES
ARRAY TEXT:C222(SN3_NotificacionUsr;0)
ARRAY TEXT:C222(SN3_NotificacionMail;0)
ARRAY LONGINT:C221(SN3_NotificacionUsrID;0)

C_DATE:C307(vd_fecha_ini_actuadatos)
C_LONGINT:C283(SN3_ActuaDatosActivar;SN3_ActuaDatos_RecibirDatos)

SN3_ActuaDatosPublica:=0
SN3_ActuaDatosReqVerif:=0
SN3_ActuaDatosNoMailApo:=0
SN3_DataRecInterval:=0
SN3_ActuaDatosEncargadoID:=1  //Administrador
SN3_ActuaDatos_RecibirDatos:=0

C_TEXT:C284(SN3_ActuaDatosEncargado)
SN3_ActuaDatosEncargado:=__ ("Administrador")

ARRAY TEXT:C222(SN3_ListaCamposAlumnoRefField;0)
ARRAY TEXT:C222(SN3_ListaTagsXMLAlumno;0)
ARRAY TEXT:C222(SN3_ListaCamposAlumno;0)
ARRAY TEXT:C222(SN3_FieldGroupsAlumno;0)  //Para los campos que van en un conjunto de publicación por ejemplo las alergias y el alergeno debo publicarlos a ambos 
ARRAY BOOLEAN:C223(SN3_PublicaAlumno;0)
ARRAY BOOLEAN:C223(SN3_EditaAlumno;0)

ARRAY TEXT:C222(SN3_ListaCamposRFRefField;0)
ARRAY TEXT:C222(SN3_ListaTagsXMLRF;0)
ARRAY TEXT:C222(SN3_ListaCamposRF;0)
ARRAY TEXT:C222(SN3_FieldGroupsRF;0)
ARRAY BOOLEAN:C223(SN3_PublicaRF;0)
ARRAY BOOLEAN:C223(SN3_EditaRF;0)

ARRAY TEXT:C222(SN3_ReceivedFileName;0)

ARRAY TEXT:C222(SN3_ListaCamposAlumnoRefField;36)
ARRAY TEXT:C222(SN3_ListaTagsXMLAlumno;36)
ARRAY TEXT:C222(SN3_ListaCamposAlumno;36)
ARRAY TEXT:C222(SN3_FieldGroupsAlumno;36)
ARRAY BOOLEAN:C223(SN3_PublicaAlumno;36)
ARRAY BOOLEAN:C223(SN3_EditaAlumno;36)

ARRAY TEXT:C222(SN3_ListaCamposRFRefField;17)
ARRAY TEXT:C222(SN3_ListaTagsXMLRF;17)
ARRAY TEXT:C222(SN3_ListaCamposRF;17)
ARRAY TEXT:C222(SN3_FieldGroupsRF;17)  //Actualmente en RF no hay campos agrupados como en los alumnos
ARRAY BOOLEAN:C223(SN3_PublicaRF;17)
ARRAY BOOLEAN:C223(SN3_EditaRF;17)

LOC_LoadIdenNacionales   //20180306 RCH

AT_Inc (0)
$x:=AT_Inc 
SN3_ListaCamposAlumno{$x}:=<>vt_IDNacional1_name  //20180306 RCH
SN3_ListaTagsXMLAlumno{$x}:="identificadornacional"
SN3_ListaCamposAlumnoRefField{$x}:=String:C10(Table:C252(->[Alumnos:2]))+"."+String:C10(Field:C253(->[Alumnos:2]RUT:5))
SN3_FieldGroupsAlumno{$x}:=""
$x:=AT_Inc 
SN3_ListaCamposAlumno{$x}:=XSvs_nombreCampoLocal_Numero (Table:C252(->[Alumnos:2]);Field:C253(->[Alumnos:2]Nombres:2);<>vtXS_CountryCode;<>vtXS_langage;False:C215)
SN3_ListaTagsXMLAlumno{$x}:="nombres"
SN3_ListaCamposAlumnoRefField{$x}:=String:C10(Table:C252(->[Alumnos:2]))+"."+String:C10(Field:C253(->[Alumnos:2]Nombres:2))
SN3_FieldGroupsAlumno{$x}:=""
$x:=AT_Inc 
SN3_ListaCamposAlumno{$x}:=XSvs_nombreCampoLocal_Numero (Table:C252(->[Alumnos:2]);Field:C253(->[Alumnos:2]Apellido_paterno:3);<>vtXS_CountryCode;<>vtXS_langage;False:C215)
SN3_ListaTagsXMLAlumno{$x}:="appaterno"
SN3_ListaCamposAlumnoRefField{$x}:=String:C10(Table:C252(->[Alumnos:2]))+"."+String:C10(Field:C253(->[Alumnos:2]Apellido_paterno:3))
SN3_FieldGroupsAlumno{$x}:=""
$x:=AT_Inc 
SN3_ListaCamposAlumno{$x}:=XSvs_nombreCampoLocal_Numero (Table:C252(->[Alumnos:2]);Field:C253(->[Alumnos:2]Apellido_materno:4);<>vtXS_CountryCode;<>vtXS_langage;False:C215)
SN3_ListaTagsXMLAlumno{$x}:="apmaterno"
SN3_ListaCamposAlumnoRefField{$x}:=String:C10(Table:C252(->[Alumnos:2]))+"."+String:C10(Field:C253(->[Alumnos:2]Apellido_materno:4))
SN3_FieldGroupsAlumno{$x}:=""
$x:=AT_Inc 
SN3_ListaCamposAlumno{$x}:=XSvs_nombreCampoLocal_Numero (Table:C252(->[Alumnos:2]);Field:C253(->[Alumnos:2]Fecha_de_nacimiento:7);<>vtXS_CountryCode;<>vtXS_langage;False:C215)
SN3_ListaTagsXMLAlumno{$x}:="fechanacimiento"
SN3_ListaCamposAlumnoRefField{$x}:=String:C10(Table:C252(->[Alumnos:2]))+"."+String:C10(Field:C253(->[Alumnos:2]Fecha_de_nacimiento:7))
SN3_FieldGroupsAlumno{$x}:=""
$x:=AT_Inc 
SN3_ListaCamposAlumno{$x}:=XSvs_nombreCampoLocal_Numero (Table:C252(->[Alumnos:2]);Field:C253(->[Alumnos:2]Nacido_en:10);<>vtXS_CountryCode;<>vtXS_langage;False:C215)
SN3_ListaTagsXMLAlumno{$x}:="nacidoen"
SN3_ListaCamposAlumnoRefField{$x}:=String:C10(Table:C252(->[Alumnos:2]))+"."+String:C10(Field:C253(->[Alumnos:2]Nacido_en:10))
SN3_FieldGroupsAlumno{$x}:=""
$x:=AT_Inc 
SN3_ListaCamposAlumno{$x}:=XSvs_nombreCampoLocal_Numero (Table:C252(->[Alumnos:2]);Field:C253(->[Alumnos:2]Nacionalidad:8);<>vtXS_CountryCode;<>vtXS_langage;False:C215)
SN3_ListaTagsXMLAlumno{$x}:="nacionalidad"
SN3_ListaCamposAlumnoRefField{$x}:=String:C10(Table:C252(->[Alumnos:2]))+"."+String:C10(Field:C253(->[Alumnos:2]Nacionalidad:8))
SN3_FieldGroupsAlumno{$x}:=""
$x:=AT_Inc 
SN3_ListaCamposAlumno{$x}:=XSvs_nombreCampoLocal_Numero (Table:C252(->[Alumnos:2]);Field:C253(->[Alumnos:2]Religion:9);<>vtXS_CountryCode;<>vtXS_langage;False:C215)
SN3_ListaTagsXMLAlumno{$x}:="religion"
SN3_ListaCamposAlumnoRefField{$x}:=String:C10(Table:C252(->[Alumnos:2]))+"."+String:C10(Field:C253(->[Alumnos:2]Religion:9))
SN3_FieldGroupsAlumno{$x}:=""
$x:=AT_Inc 
SN3_ListaCamposAlumno{$x}:=XSvs_nombreCampoLocal_Numero (Table:C252(->[Alumnos:2]);Field:C253(->[Alumnos:2]Direccion:12);<>vtXS_CountryCode;<>vtXS_langage;False:C215)
SN3_ListaTagsXMLAlumno{$x}:="direccion"
SN3_ListaCamposAlumnoRefField{$x}:=String:C10(Table:C252(->[Alumnos:2]))+"."+String:C10(Field:C253(->[Alumnos:2]Direccion:12))
SN3_FieldGroupsAlumno{$x}:=""
$x:=AT_Inc 
SN3_ListaCamposAlumno{$x}:=XSvs_nombreCampoLocal_Numero (Table:C252(->[Alumnos:2]);Field:C253(->[Alumnos:2]Telefono:17);<>vtXS_CountryCode;<>vtXS_langage;False:C215)
SN3_ListaTagsXMLAlumno{$x}:="telefono"
SN3_ListaCamposAlumnoRefField{$x}:=String:C10(Table:C252(->[Alumnos:2]))+"."+String:C10(Field:C253(->[Alumnos:2]Telefono:17))
SN3_FieldGroupsAlumno{$x}:=""
$x:=AT_Inc 
SN3_ListaCamposAlumno{$x}:=XSvs_nombreCampoLocal_Numero (Table:C252(->[Alumnos:2]);Field:C253(->[Alumnos:2]Comuna:14);<>vtXS_CountryCode;<>vtXS_langage;False:C215)
SN3_ListaTagsXMLAlumno{$x}:="comuna"
SN3_ListaCamposAlumnoRefField{$x}:=String:C10(Table:C252(->[Alumnos:2]))+"."+String:C10(Field:C253(->[Alumnos:2]Comuna:14))
SN3_FieldGroupsAlumno{$x}:=""
$x:=AT_Inc 
SN3_ListaCamposAlumno{$x}:=XSvs_nombreCampoLocal_Numero (Table:C252(->[Alumnos:2]);Field:C253(->[Alumnos:2]Ciudad:15);<>vtXS_CountryCode;<>vtXS_langage;False:C215)
SN3_ListaTagsXMLAlumno{$x}:="ciudad"
SN3_ListaCamposAlumnoRefField{$x}:=String:C10(Table:C252(->[Alumnos:2]))+"."+String:C10(Field:C253(->[Alumnos:2]Ciudad:15))
SN3_FieldGroupsAlumno{$x}:=""
$x:=AT_Inc 
SN3_ListaCamposAlumno{$x}:=XSvs_nombreCampoLocal_Numero (Table:C252(->[Alumnos:2]);Field:C253(->[Alumnos:2]Celular:95);<>vtXS_CountryCode;<>vtXS_langage;False:C215)
SN3_ListaTagsXMLAlumno{$x}:="celular"
SN3_ListaCamposAlumnoRefField{$x}:=String:C10(Table:C252(->[Alumnos:2]))+"."+String:C10(Field:C253(->[Alumnos:2]Celular:95))
SN3_FieldGroupsAlumno{$x}:=""
$x:=AT_Inc 
SN3_ListaCamposAlumno{$x}:=XSvs_nombreCampoLocal_Numero (Table:C252(->[Alumnos:2]);Field:C253(->[Alumnos:2]eMAIL:68);<>vtXS_CountryCode;<>vtXS_langage;False:C215)
SN3_ListaTagsXMLAlumno{$x}:="email"
SN3_ListaCamposAlumnoRefField{$x}:=String:C10(Table:C252(->[Alumnos:2]))+"."+String:C10(Field:C253(->[Alumnos:2]eMAIL:68))
SN3_FieldGroupsAlumno{$x}:=""
$x:=AT_Inc 
SN3_ListaCamposAlumno{$x}:=XSvs_nombreCampoLocal_Numero (Table:C252(->[Alumnos_FichaMedica:13]);Field:C253(->[Alumnos_FichaMedica:13]GrupoSanguineo:2);<>vtXS_CountryCode;<>vtXS_langage;False:C215)
SN3_ListaTagsXMLAlumno{$x}:="gruposanguineo"
SN3_ListaCamposAlumnoRefField{$x}:=String:C10(Table:C252(->[Alumnos_FichaMedica:13]))+"."+String:C10(Field:C253(->[Alumnos_FichaMedica:13]GrupoSanguineo:2))
SN3_FieldGroupsAlumno{$x}:=""
$x:=AT_Inc 
SN3_ListaCamposAlumno{$x}:=XSvs_nombreCampoLocal_Numero (Table:C252(->[Alumnos_FichaMedica:13]);Field:C253(->[Alumnos_FichaMedica:13]Previsión_institución:9);<>vtXS_CountryCode;<>vtXS_langage;False:C215)
SN3_ListaTagsXMLAlumno{$x}:="previsioninstitucion"
SN3_ListaCamposAlumnoRefField{$x}:=String:C10(Table:C252(->[Alumnos_FichaMedica:13]))+"."+String:C10(Field:C253(->[Alumnos_FichaMedica:13]Previsión_institución:9))
SN3_FieldGroupsAlumno{$x}:=""
$x:=AT_Inc 
SN3_ListaCamposAlumno{$x}:=XSvs_nombreCampoLocal_Numero (Table:C252(->[Alumnos_FichaMedica:13]);Field:C253(->[Alumnos_FichaMedica:13]Prevision_Código:10);<>vtXS_CountryCode;<>vtXS_langage;False:C215)
SN3_ListaTagsXMLAlumno{$x}:="previsioncodigo"
SN3_ListaCamposAlumnoRefField{$x}:=String:C10(Table:C252(->[Alumnos_FichaMedica:13]))+"."+String:C10(Field:C253(->[Alumnos_FichaMedica:13]Prevision_Código:10))
SN3_FieldGroupsAlumno{$x}:=""
$x:=AT_Inc 
SN3_ListaCamposAlumno{$x}:=XSvs_nombreCampoLocal_Numero (Table:C252(->[Alumnos_FichaMedica_Alergias:223]);Field:C253(->[Alumnos_FichaMedica_Alergias:223]Tipo_alergia:1);<>vtXS_CountryCode;<>vtXS_langage;False:C215)
SN3_ListaTagsXMLAlumno{$x}:="alergia:tipoalergia"
SN3_ListaCamposAlumnoRefField{$x}:=String:C10(Table:C252(->[Alumnos_FichaMedica_Alergias:223]))+"."+String:C10(Field:C253(->[Alumnos_FichaMedica_Alergias:223]Tipo_alergia:1))
SN3_FieldGroupsAlumno{$x}:="alergias"
$x:=AT_Inc 
SN3_ListaCamposAlumno{$x}:=XSvs_nombreCampoLocal_Numero (Table:C252(->[Alumnos_FichaMedica_Alergias:223]);Field:C253(->[Alumnos_FichaMedica_Alergias:223]Alergeno:2);<>vtXS_CountryCode;<>vtXS_langage;False:C215)
SN3_ListaTagsXMLAlumno{$x}:="alergia:alergeno"
SN3_ListaCamposAlumnoRefField{$x}:=String:C10(Table:C252(->[Alumnos_FichaMedica_Alergias:223]))+"."+String:C10(Field:C253(->[Alumnos_FichaMedica_Alergias:223]Alergeno:2))
SN3_FieldGroupsAlumno{$x}:="alergias"
$x:=AT_Inc 
SN3_ListaCamposAlumno{$x}:=XSvs_nombreCampoLocal_Numero (Table:C252(->[Alumnos_FichaMedica_Enfermedade:224]);Field:C253(->[Alumnos_FichaMedica_Enfermedade:224]Enfermedad:1);<>vtXS_CountryCode;<>vtXS_langage;False:C215)
SN3_ListaTagsXMLAlumno{$x}:="enfermedad:enfermedad"
SN3_ListaCamposAlumnoRefField{$x}:=String:C10(Table:C252(->[Alumnos_FichaMedica_Enfermedade:224]))+"."+String:C10(Field:C253(->[Alumnos_FichaMedica_Enfermedade:224]Enfermedad:1))
SN3_FieldGroupsAlumno{$x}:="enfermedades"
$x:=AT_Inc 
SN3_ListaCamposAlumno{$x}:=XSvs_nombreCampoLocal_Numero (Table:C252(->[Alumnos_Vacunas:101]);Field:C253(->[Alumnos_Vacunas:101]Enfermedad:3);<>vtXS_CountryCode;<>vtXS_langage;False:C215)
SN3_ListaTagsXMLAlumno{$x}:="vacuna:enfermedad"
SN3_ListaCamposAlumnoRefField{$x}:=String:C10(Table:C252(->[Alumnos_Vacunas:101]))+"."+String:C10(Field:C253(->[Alumnos_Vacunas:101]Enfermedad:3))
SN3_FieldGroupsAlumno{$x}:="vacunas"
$x:=AT_Inc 
SN3_ListaCamposAlumno{$x}:=XSvs_nombreCampoLocal_Numero (Table:C252(->[Alumnos_Vacunas:101]);Field:C253(->[Alumnos_Vacunas:101]Meses:4);<>vtXS_CountryCode;<>vtXS_langage;False:C215)
SN3_ListaTagsXMLAlumno{$x}:="vacuna:meses"
SN3_ListaCamposAlumnoRefField{$x}:=String:C10(Table:C252(->[Alumnos_Vacunas:101]))+"."+String:C10(Field:C253(->[Alumnos_Vacunas:101]Meses:4))
SN3_FieldGroupsAlumno{$x}:="vacunas"
$x:=AT_Inc 
SN3_ListaCamposAlumno{$x}:=XSvs_nombreCampoLocal_Numero (Table:C252(->[Alumnos_FichaMedica:13]);Field:C253(->[Alumnos_FichaMedica:13]Observaciones:3);<>vtXS_CountryCode;<>vtXS_langage;False:C215)
SN3_ListaTagsXMLAlumno{$x}:="observacionesmedicas"
SN3_ListaCamposAlumnoRefField{$x}:=String:C10(Table:C252(->[Alumnos_FichaMedica:13]))+"."+String:C10(Field:C253(->[Alumnos_FichaMedica:13]Observaciones:3))
SN3_FieldGroupsAlumno{$x}:=""
$x:=AT_Inc 
SN3_ListaCamposAlumno{$x}:=XSvs_nombreCampoLocal_Numero (Table:C252(->[Alumnos_FichaMedica:13]);Field:C253(->[Alumnos_FichaMedica:13]Medicamentos_autorizados:11);<>vtXS_CountryCode;<>vtXS_langage;False:C215)
SN3_ListaTagsXMLAlumno{$x}:="medicamentosautorizados"
SN3_ListaCamposAlumnoRefField{$x}:=String:C10(Table:C252(->[Alumnos_FichaMedica:13]))+"."+String:C10(Field:C253(->[Alumnos_FichaMedica:13]Medicamentos_autorizados:11))
SN3_FieldGroupsAlumno{$x}:=""
$x:=AT_Inc 
SN3_ListaCamposAlumno{$x}:=XSvs_nombreCampoLocal_Numero (Table:C252(->[Alumnos_FichaMedica:13]);Field:C253(->[Alumnos_FichaMedica:13]Medicamentos_prohibidos:17);<>vtXS_CountryCode;<>vtXS_langage;False:C215)
SN3_ListaTagsXMLAlumno{$x}:="medicamentosprohibidos"
SN3_ListaCamposAlumnoRefField{$x}:=String:C10(Table:C252(->[Alumnos_FichaMedica:13]))+"."+String:C10(Field:C253(->[Alumnos_FichaMedica:13]Medicamentos_prohibidos:17))
SN3_FieldGroupsAlumno{$x}:=""
$x:=AT_Inc 
SN3_ListaCamposAlumno{$x}:=XSvs_nombreCampoLocal_Numero (Table:C252(->[Alumnos_FichaMedica:13]);Field:C253(->[Alumnos_FichaMedica:13]Tratamientos:18);<>vtXS_CountryCode;<>vtXS_langage;False:C215)
SN3_ListaTagsXMLAlumno{$x}:="tratamientos"
SN3_ListaCamposAlumnoRefField{$x}:=String:C10(Table:C252(->[Alumnos_FichaMedica:13]))+"."+String:C10(Field:C253(->[Alumnos_FichaMedica:13]OB_tratamiento:23))  //MONO 209951  //[Alumnos_FichaMedica]Tratamientos--Campo Anterior
SN3_FieldGroupsAlumno{$x}:=""

  //$x:=AT_Inc 
  //SN3_ListaCamposAlumno{$x}:=__ ("Médico de Cabecera")  //????
  //SN3_ListaTagsXMLAlumno{$x}:="doctorcabecera"
  //SN3_ListaCamposAlumnoRefField{$x}:=""  //"Médicos"  //no se q campo es????
  //$x:=AT_Inc 
  //SN3_ListaCamposAlumno{$x}:=__ ("Teléfono Médico de Cabecera")  //????
  //SN3_ListaTagsXMLAlumno{$x}:="telefonodoctorcabecera"
  //SN3_ListaCamposAlumnoRefField{$x}:=""  //no se q campo es????
$x:=AT_Inc 
SN3_ListaCamposAlumno{$x}:=XSvs_nombreCampoLocal_Numero (Table:C252(->[Alumnos_FichaMedica:13]);Field:C253(->[Alumnos_FichaMedica:13]Urgencia_Contacto:4);<>vtXS_CountryCode;<>vtXS_langage;False:C215)
SN3_ListaTagsXMLAlumno{$x}:="contactourgencia"
SN3_ListaCamposAlumnoRefField{$x}:=String:C10(Table:C252(->[Alumnos_FichaMedica:13]))+"."+String:C10(Field:C253(->[Alumnos_FichaMedica:13]Urgencia_Contacto:4))
SN3_FieldGroupsAlumno{$x}:=""
$x:=AT_Inc 
SN3_ListaCamposAlumno{$x}:=XSvs_nombreCampoLocal_Numero (Table:C252(->[Alumnos_FichaMedica:13]);Field:C253(->[Alumnos_FichaMedica:13]Urgencia_Fonos:5);<>vtXS_CountryCode;<>vtXS_langage;False:C215)
SN3_ListaTagsXMLAlumno{$x}:="telefonocontactourgencia"
SN3_ListaCamposAlumnoRefField{$x}:=String:C10(Table:C252(->[Alumnos_FichaMedica:13]))+"."+String:C10(Field:C253(->[Alumnos_FichaMedica:13]Urgencia_Fonos:5))
SN3_FieldGroupsAlumno{$x}:=""
$x:=AT_Inc 
SN3_ListaCamposAlumno{$x}:=XSvs_nombreCampoLocal_Numero (Table:C252(->[Alumnos_FichaMedica:13]);Field:C253(->[Alumnos_FichaMedica:13]Urgencia_Traslado:8);<>vtXS_CountryCode;<>vtXS_langage;False:C215)
SN3_ListaTagsXMLAlumno{$x}:="trasladourgencia"
SN3_ListaCamposAlumnoRefField{$x}:=String:C10(Table:C252(->[Alumnos_FichaMedica:13]))+"."+String:C10(Field:C253(->[Alumnos_FichaMedica:13]Urgencia_Traslado:8))
SN3_FieldGroupsAlumno{$x}:=""
$x:=AT_Inc 
SN3_ListaCamposAlumno{$x}:=XSvs_nombreCampoLocal_Numero (Table:C252(->[Alumnos:2]);Field:C253(->[Alumnos:2]Grupo:11);<>vtXS_CountryCode;<>vtXS_langage;False:C215)
SN3_ListaTagsXMLAlumno{$x}:="grupo"
SN3_ListaCamposAlumnoRefField{$x}:=String:C10(Table:C252(->[Alumnos:2]))+"."+String:C10(Field:C253(->[Alumnos:2]Grupo:11))
SN3_FieldGroupsAlumno{$x}:=""
$x:=AT_Inc 
SN3_ListaCamposAlumno{$x}:=XSvs_nombreCampoLocal_Numero (Table:C252(->[Alumnos:2]);Field:C253(->[Alumnos:2]Vive_con:81);<>vtXS_CountryCode;<>vtXS_langage;False:C215)
SN3_ListaTagsXMLAlumno{$x}:="vivecon"
SN3_ListaCamposAlumnoRefField{$x}:=String:C10(Table:C252(->[Alumnos:2]))+"."+String:C10(Field:C253(->[Alumnos:2]Vive_con:81))
SN3_FieldGroupsAlumno{$x}:=""

  //MONO: ACTUA DATOS FATOBJECTS
  //urgenciacontactos FAT-OBJECTS //este tipo de datos los iremos agregando en el mismo orden en el que son almacenados en el BLOB
$x:=AT_Inc 
SN3_ListaCamposAlumno{$x}:=__ ("Otros Contactos de Urgencia: Nombre")
SN3_ListaTagsXMLAlumno{$x}:="urgenciacontacto:nombrecontacto"
SN3_ListaCamposAlumnoRefField{$x}:=String:C10(Table:C252(->[XShell_FatObjects:86]))+".contactos.ALU."+"\t"+"1"
SN3_FieldGroupsAlumno{$x}:="contactos.ALU."
$x:=AT_Inc 
SN3_ListaCamposAlumno{$x}:=__ ("Otros Contactos de Urgencia: Relación")
SN3_ListaTagsXMLAlumno{$x}:="urgenciacontacto:relacioncontacto"
SN3_ListaCamposAlumnoRefField{$x}:=String:C10(Table:C252(->[XShell_FatObjects:86]))+".contactos.ALU."+"\t"+"2"
SN3_FieldGroupsAlumno{$x}:="contactos.ALU."
$x:=AT_Inc 
SN3_ListaCamposAlumno{$x}:=__ ("Otros Contactos de Urgencia: Teléfonos")
SN3_ListaTagsXMLAlumno{$x}:="urgenciacontacto:telefonoscontacto"
SN3_ListaCamposAlumnoRefField{$x}:=String:C10(Table:C252(->[XShell_FatObjects:86]))+".contactos.ALU."+"\t"+"3"
SN3_FieldGroupsAlumno{$x}:="contactos.ALU."
$x:=AT_Inc 
SN3_ListaCamposAlumno{$x}:=XSvs_nombreCampoLocal_Numero (Table:C252(->[Alumnos_FichaMedica:13]);Field:C253(->[Alumnos_FichaMedica:13]Dieta:19);<>vtXS_CountryCode;<>vtXS_langage;False:C215)
SN3_ListaTagsXMLAlumno{$x}:="dieta"
SN3_ListaCamposAlumnoRefField{$x}:=String:C10(Table:C252(->[Alumnos_FichaMedica:13]))+"."+String:C10(Field:C253(->[Alumnos_FichaMedica:13]Dieta:19))
SN3_FieldGroupsAlumno{$x}:=""
$x:=AT_Inc 
SN3_ListaCamposAlumno{$x}:=XSvs_nombreCampoLocal_Numero (Table:C252(->[Alumnos:2]);Field:C253(->[Alumnos:2]Sector_Domicilio:80);<>vtXS_CountryCode;<>vtXS_langage;False:C215)
SN3_ListaTagsXMLAlumno{$x}:="sector"
SN3_ListaCamposAlumnoRefField{$x}:=String:C10(Table:C252(->[Alumnos:2]))+"."+String:C10(Field:C253(->[Alumnos:2]Sector_Domicilio:80))
SN3_FieldGroupsAlumno{$x}:=""

  // /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  // CAMPOS DE RELACIÓN FAMILIAR
AT_Inc (0)
$x:=AT_Inc 
SN3_ListaCamposRF{$x}:=<>vt_IDNacional1_name  //20180306 RCH
SN3_ListaTagsXMLRF{$x}:="identificadornacional"
SN3_ListaCamposRFRefField{$x}:=String:C10(Table:C252(->[Personas:7]))+"."+String:C10(Field:C253(->[Personas:7]RUT:6))
$x:=AT_Inc 
SN3_ListaCamposRF{$x}:=XSvs_nombreCampoLocal_Numero (Table:C252(->[Personas:7]);Field:C253(->[Personas:7]Nombres:2);<>vtXS_CountryCode;<>vtXS_langage;False:C215)
SN3_ListaTagsXMLRF{$x}:="nombres"
SN3_ListaCamposRFRefField{$x}:=String:C10(Table:C252(->[Personas:7]))+"."+String:C10(Field:C253(->[Personas:7]Nombres:2))
$x:=AT_Inc 
SN3_ListaCamposRF{$x}:=XSvs_nombreCampoLocal_Numero (Table:C252(->[Personas:7]);Field:C253(->[Personas:7]Apellido_paterno:3);<>vtXS_CountryCode;<>vtXS_langage;False:C215)
SN3_ListaTagsXMLRF{$x}:="appaterno"
SN3_ListaCamposRFRefField{$x}:=String:C10(Table:C252(->[Personas:7]))+"."+String:C10(Field:C253(->[Personas:7]Apellido_paterno:3))
$x:=AT_Inc 
SN3_ListaCamposRF{$x}:=XSvs_nombreCampoLocal_Numero (Table:C252(->[Personas:7]);Field:C253(->[Personas:7]Apellido_materno:4);<>vtXS_CountryCode;<>vtXS_langage;False:C215)
SN3_ListaTagsXMLRF{$x}:="apmaterno"
SN3_ListaCamposRFRefField{$x}:=String:C10(Table:C252(->[Personas:7]))+"."+String:C10(Field:C253(->[Personas:7]Apellido_materno:4))
$x:=AT_Inc 
SN3_ListaCamposRF{$x}:=XSvs_nombreCampoLocal_Numero (Table:C252(->[Personas:7]);Field:C253(->[Personas:7]Prefijo:90);<>vtXS_CountryCode;<>vtXS_langage;False:C215)
SN3_ListaTagsXMLRF{$x}:="prefijo"
SN3_ListaCamposRFRefField{$x}:=String:C10(Table:C252(->[Personas:7]))+"."+String:C10(Field:C253(->[Personas:7]Prefijo:90))
$x:=AT_Inc 
SN3_ListaCamposRF{$x}:=XSvs_nombreCampoLocal_Numero (Table:C252(->[Personas:7]);Field:C253(->[Personas:7]Nacionalidad:7);<>vtXS_CountryCode;<>vtXS_langage;False:C215)
SN3_ListaTagsXMLRF{$x}:="nacionalidad"
SN3_ListaCamposRFRefField{$x}:=String:C10(Table:C252(->[Personas:7]))+"."+String:C10(Field:C253(->[Personas:7]Nacionalidad:7))
$x:=AT_Inc 
SN3_ListaCamposRF{$x}:=XSvs_nombreCampoLocal_Numero (Table:C252(->[Personas:7]);Field:C253(->[Personas:7]Religión:9);<>vtXS_CountryCode;<>vtXS_langage;False:C215)
SN3_ListaTagsXMLRF{$x}:="religion"
SN3_ListaCamposRFRefField{$x}:=String:C10(Table:C252(->[Personas:7]))+"."+String:C10(Field:C253(->[Personas:7]Religión:9))
$x:=AT_Inc 
SN3_ListaCamposRF{$x}:=XSvs_nombreCampoLocal_Numero (Table:C252(->[Personas:7]);Field:C253(->[Personas:7]Profesion:13);<>vtXS_CountryCode;<>vtXS_langage;False:C215)
SN3_ListaTagsXMLRF{$x}:="profesion"
SN3_ListaCamposRFRefField{$x}:=String:C10(Table:C252(->[Personas:7]))+"."+String:C10(Field:C253(->[Personas:7]Profesion:13))
$x:=AT_Inc 
SN3_ListaCamposRF{$x}:=XSvs_nombreCampoLocal_Numero (Table:C252(->[Personas:7]);Field:C253(->[Personas:7]Direccion:14);<>vtXS_CountryCode;<>vtXS_langage;False:C215)
SN3_ListaTagsXMLRF{$x}:="direccion"
SN3_ListaCamposRFRefField{$x}:=String:C10(Table:C252(->[Personas:7]))+"."+String:C10(Field:C253(->[Personas:7]Direccion:14))
$x:=AT_Inc 
SN3_ListaCamposRF{$x}:=XSvs_nombreCampoLocal_Numero (Table:C252(->[Personas:7]);Field:C253(->[Personas:7]Telefono_domicilio:19);<>vtXS_CountryCode;<>vtXS_langage;False:C215)
SN3_ListaTagsXMLRF{$x}:="telefono"
SN3_ListaCamposRFRefField{$x}:=String:C10(Table:C252(->[Personas:7]))+"."+String:C10(Field:C253(->[Personas:7]Telefono_domicilio:19))
$x:=AT_Inc 
SN3_ListaCamposRF{$x}:=XSvs_nombreCampoLocal_Numero (Table:C252(->[Personas:7]);Field:C253(->[Personas:7]Comuna:16);<>vtXS_CountryCode;<>vtXS_langage;False:C215)
SN3_ListaTagsXMLRF{$x}:="comuna"
SN3_ListaCamposRFRefField{$x}:=String:C10(Table:C252(->[Personas:7]))+"."+String:C10(Field:C253(->[Personas:7]Comuna:16))
$x:=AT_Inc 
SN3_ListaCamposRF{$x}:=XSvs_nombreCampoLocal_Numero (Table:C252(->[Personas:7]);Field:C253(->[Personas:7]Ciudad:17);<>vtXS_CountryCode;<>vtXS_langage;False:C215)
SN3_ListaTagsXMLRF{$x}:="ciudad"
SN3_ListaCamposRFRefField{$x}:=String:C10(Table:C252(->[Personas:7]))+"."+String:C10(Field:C253(->[Personas:7]Ciudad:17))
$x:=AT_Inc 
SN3_ListaCamposRF{$x}:=XSvs_nombreCampoLocal_Numero (Table:C252(->[Personas:7]);Field:C253(->[Personas:7]Celular:24);<>vtXS_CountryCode;<>vtXS_langage;False:C215)
SN3_ListaTagsXMLRF{$x}:="celular"
SN3_ListaCamposRFRefField{$x}:=String:C10(Table:C252(->[Personas:7]))+"."+String:C10(Field:C253(->[Personas:7]Celular:24))
$x:=AT_Inc 
SN3_ListaCamposRF{$x}:=XSvs_nombreCampoLocal_Numero (Table:C252(->[Personas:7]);Field:C253(->[Personas:7]eMail:34);<>vtXS_CountryCode;<>vtXS_langage;False:C215)
SN3_ListaTagsXMLRF{$x}:="email"
SN3_ListaCamposRFRefField{$x}:=String:C10(Table:C252(->[Personas:7]))+"."+String:C10(Field:C253(->[Personas:7]eMail:34))
$x:=AT_Inc 
SN3_ListaCamposRF{$x}:=XSvs_nombreCampoLocal_Numero (Table:C252(->[Personas:7]);Field:C253(->[Personas:7]Empresa:20);<>vtXS_CountryCode;<>vtXS_langage;False:C215)
SN3_ListaTagsXMLRF{$x}:="empresa"
SN3_ListaCamposRFRefField{$x}:=String:C10(Table:C252(->[Personas:7]))+"."+String:C10(Field:C253(->[Personas:7]Empresa:20))
$x:=AT_Inc 
SN3_ListaCamposRF{$x}:=XSvs_nombreCampoLocal_Numero (Table:C252(->[Personas:7]);Field:C253(->[Personas:7]Cargo:21);<>vtXS_CountryCode;<>vtXS_langage;False:C215)
SN3_ListaTagsXMLRF{$x}:="cargo"
SN3_ListaCamposRFRefField{$x}:=String:C10(Table:C252(->[Personas:7]))+"."+String:C10(Field:C253(->[Personas:7]Cargo:21))
$x:=AT_Inc 
SN3_ListaCamposRF{$x}:=XSvs_nombreCampoLocal_Numero (Table:C252(->[Personas:7]);Field:C253(->[Personas:7]Telefono_profesional:29);<>vtXS_CountryCode;<>vtXS_langage;False:C215)
SN3_ListaTagsXMLRF{$x}:="telefonoprofesional"
SN3_ListaCamposRFRefField{$x}:=String:C10(Table:C252(->[Personas:7]))+"."+String:C10(Field:C253(->[Personas:7]Telefono_profesional:29))
