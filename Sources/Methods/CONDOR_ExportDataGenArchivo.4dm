//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Roberto Catalán
  // Fecha y hora: 17-05-17, 12:07:11
  // ----------------------------------------------------
  // Método: CONDOR_ExportDataGenArchivo
  // Descripción
  // Crea archivo xml que va a condor
  //
  // Parámetros
  // ----------------------------------------------------



C_TIME:C306($refXMLDoc;$0)
C_POINTER:C301($2)
C_TEXT:C284($vt_RefContenido;$1;$vt_FileName;$vt_RefVersion;$t_tipoArchivo;$t_tipo;$t_path)

$vt_RefContenido:=$1

Case of 
	: ($vt_RefContenido="personas")
		$t_tipoArchivo:="_100.snt"
		
	: ($vt_RefContenido="familias")
		$t_tipoArchivo:="_101.snt"
		
	: ($vt_RefContenido="cursos")
		$t_tipoArchivo:="_102.snt"
		
	: ($vt_RefContenido="niveles")
		$t_tipoArchivo:="_103.snt"
		
	: ($vt_RefContenido="asignaturas")
		$t_tipoArchivo:="_104.snt"
		
	: ($vt_RefContenido="colegio")
		$t_tipoArchivo:="_99.snt"
		
End case 

$vt_FileName:=SN3_GetFilesPath +"condorfiles"+Folder separator:K24:12+SN3_GenerateUniqueName +"."+<>vtXS_CountryCode+"."+<>gRolBD+$t_tipoArchivo

  //elimina archivos ya creados del mismo tipo
ARRAY TEXT:C222($at_archivos;0)
$t_path:=SYS_GetParentNme ($vt_FileName)
DOCUMENT LIST:C474($t_path;$at_archivos)
$t_tipo:=Replace string:C233($t_tipoArchivo;"snt";"")
For ($l_indice;1;Size of array:C274($at_archivos))
	If (Position:C15($t_tipo;$at_archivos{$l_indice})>0)
		DELETE DOCUMENT:C159($t_path+$at_archivos{$l_indice})
	End if 
End for 

If (SYS_TestPathName ($vt_FileName)=Is a document:K24:1)
	DELETE DOCUMENT:C159($vt_FileName)
End if 
$refXMLDoc:=Create document:C266($vt_FileName)
XML SET OPTIONS:C1090($refXMLDoc;XML String encoding:K45:21;XML raw data:K45:23)

SAX_OpenRoot ($refXMLDoc;"colegium";"UTF-8";False:C215)

$vt_RefVersion:=SYS_LeeVersionBaseDeDatos 

CONDOR_ExportSAXCreateNode ($refXMLDoc;"ref_vers";True:C214;$vt_RefVersion)
CONDOR_ExportSAXCreateNode ($refXMLDoc;"ref_cont";True:C214;$vt_RefContenido)
CONDOR_ExportSAXCreateNode ($refXMLDoc;"file_year";True:C214;String:C10(<>gYear;"0000"))

CONDOR_ExportSAXCreateNode ($refXMLDoc;"maquina";True:C214;Current machine:C483)
CONDOR_ExportSAXCreateNode ($refXMLDoc;"usuariomaquina";True:C214;Current system user:C484)
CONDOR_ExportSAXCreateNode ($refXMLDoc;"usuariost";True:C214;USR_GetUserName (<>lUSR_CurrentUserID))


CONDOR_ExportSAXCreateNode ($refXMLDoc;"xml_data")
SN3_InsertDTS ($refXMLDoc)
CONDOR_ExportSAXCreateNode ($refXMLDoc;$vt_RefContenido)

$2->:=$vt_FileName

$0:=$refXMLDoc