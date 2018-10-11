//%attributes = {}
  // WIZ_STR_ImportacionAlumnos()
  // Por: Alberto Bachler: 08/03/13, 20:01:37
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------

C_LONGINT:C283($i;$l_elemento;$l_tamañoArreglo;$l_conexionOK)
C_TIME:C306($h_refDocumento)
C_PICTURE:C286($p_iconoCampoEditable;$p_iconoCampoNoEditable;$p_IconoLlaveImportacion)
C_TEXT:C284($t_nombresCampos)
C_POINTER:C301($y_Nil)
C_BOOLEAN:C305(b_conexionWeb)

ARRAY INTEGER:C220($ai_CampoEsImportable;0)
ARRAY LONGINT:C221($al_IdCampos;0)
ARRAY INTEGER:C220($ai_numeroCampos;0)
ARRAY TEXT:C222($at_nombreCampos;0)

C_LONGINT:C283(viIOstr_PlatFormSource)
C_TEXT:C284(vtIOstr_FilePath;vt_ApoderadoCuentas;vt_ApoderadoAcadémico)
C_TEXT:C284(vt_ParentescoApAcademico;vt_ParentescoApCuentas)  //MonoFIX

ARRAY PICTURE:C279(aRecordFieldKey;0)
ARRAY PICTURE:C279(aRecordFieldModifiable;0)
ARRAY TEXT:C222(aRecordLine;0)
ARRAY LONGINT:C221(aRecordLineElement;0)
ARRAY TEXT:C222(aRecordFieldNames;0)
ARRAY POINTER:C280(aRecordFieldPointers;0)
ARRAY INTEGER:C220(aRecordFieldModAtt;0)
ARRAY TEXT:C222(aSourceDataName;0)
ARRAY LONGINT:C221(aSourceDataElement;0)
document:=""

b_conexionWeb:=False:C215
If (Count parameters:C259=3)
	b_conexionWeb:=True:C214
	vtIOstr_FilePath:=$1
	$t_uuidProceso:=$2
	$t_url:=$3
End if 


ST_LoadModuleFormatExceptions ("SchoolTrack")

WIZ_STR_CargaDatosEncabezadotxt ("CargaCamposAlumno")
WIZ_STR_CargaDatosEncabezadotxt ("CargaCamposApoderadoAcademico")
WIZ_STR_CargaDatosEncabezadotxt ("CargaCamposApoderadoCuenta")
WIZ_STR_CargaDatosEncabezadotxt ("CargaCamposPadre")
WIZ_STR_CargaDatosEncabezadotxt ("CargaCamposMadre")
WIZ_STR_CargaDatosEncabezadotxt ("CargaCamposFamilia")


For ($i;1;Size of array:C274(at_nombreCampoAlumno))
	APPEND TO ARRAY:C911(aRecordFieldNames;at_nombreCampoAlumnotxt{$i})
	APPEND TO ARRAY:C911(aRecordFieldPointers;ay_CampoAlumno{$i})
	If (KRL_isSameField (ay_CampoAlumno{$i};->[Alumnos:2]RUT:5))
		APPEND TO ARRAY:C911(aRecordFieldModAtt;0)
	Else 
		APPEND TO ARRAY:C911(aRecordFieldModAtt;1)
	End if 
End for 



For ($i;1;Size of array:C274(at_nombreCampoApoAcatxt))
	APPEND TO ARRAY:C911(aRecordFieldNames;at_nombreCampoApoAcatxt{$i})
	APPEND TO ARRAY:C911(aRecordFieldPointers;ay_CampoApoAca{$i})
	APPEND TO ARRAY:C911(aRecordFieldModAtt;1)
End for 

For ($i;1;Size of array:C274(at_nombreCampoApoCta))
	APPEND TO ARRAY:C911(aRecordFieldNames;at_nombreCampoApoCtatxt{$i})
	APPEND TO ARRAY:C911(aRecordFieldPointers;ay_CampoApoCta{$i})
	APPEND TO ARRAY:C911(aRecordFieldModAtt;1)
End for 

For ($i;1;Size of array:C274(at_nombreCampoPadre))
	APPEND TO ARRAY:C911(aRecordFieldNames;at_nombreCampoPadretxt{$i})
	APPEND TO ARRAY:C911(aRecordFieldPointers;ay_CampoPadre{$i})
	APPEND TO ARRAY:C911(aRecordFieldModAtt;1)
End for 

For ($i;1;Size of array:C274(at_nombreCampoMadre))
	APPEND TO ARRAY:C911(aRecordFieldNames;at_nombreCampoMadretxt{$i})
	APPEND TO ARRAY:C911(aRecordFieldPointers;ay_CampoMadre{$i})
	APPEND TO ARRAY:C911(aRecordFieldModAtt;1)
End for 

For ($i;1;Size of array:C274(at_nombreCampoFamilia))
	APPEND TO ARRAY:C911(aRecordFieldNames;at_nombreCampoFamiliatxt{$i})
	APPEND TO ARRAY:C911(aRecordFieldPointers;ay_CampoFamilia{$i})
	APPEND TO ARRAY:C911(aRecordFieldModAtt;1)
End for 

ARRAY TEXT:C222(aSourceDataName;Size of array:C274(aRecordFieldNames))
ARRAY LONGINT:C221(aSourceDataElement;Size of array:C274(aRecordFieldNames))
ARRAY PICTURE:C279(aRecordFieldKey;Size of array:C274(aRecordFieldNames))
ARRAY PICTURE:C279(aRecordFieldModifiable;Size of array:C274(aRecordFieldNames))


GET PICTURE FROM LIBRARY:C565(30215;$p_IconoLlaveImportacion)
GET PICTURE FROM LIBRARY:C565(24456;$p_iconoCampoEditable)
GET PICTURE FROM LIBRARY:C565(5381;$p_iconoCampoNoEditable)
$l_elemento:=Find in array:C230(aRecordFieldNames;"[Alumno]Identificador Nacional")
If ($l_elemento>0)
	aRecordFieldKey{$l_elemento}:=$p_IconoLlaveImportacion
End if 

$l_elemento:=Find in array:C230(aRecordFieldNames;"[Madre]Identificador Nacional")
If ($l_elemento>0)
	aRecordFieldKey{$l_elemento}:=$p_IconoLlaveImportacion
End if 

$l_elemento:=Find in array:C230(aRecordFieldNames;"[Padre]Identificador Nacional")
If ($l_elemento>0)
	aRecordFieldKey{$l_elemento}:=$p_IconoLlaveImportacion
End if 

$l_elemento:=Find in array:C230(aRecordFieldNames;"[Apoderado de cuenta]Identificador Nacional")
If ($l_elemento>0)
	aRecordFieldKey{$l_elemento}:=$p_IconoLlaveImportacion
End if 

$l_elemento:=Find in array:C230(aRecordFieldNames;"[Apoderado académico]Identificador Nacional")
If ($l_elemento>0)
	aRecordFieldKey{$l_elemento}:=$p_IconoLlaveImportacion
End if 

$l_elemento:=Find in array:C230(aRecordFieldNames;"[Familia]Nombre_de_la_Familia")
If ($l_elemento>0)
	aRecordFieldKey{$l_elemento}:=$p_IconoLlaveImportacion
End if 

$l_elemento:=Find in array:C230(aRecordFieldNames;"[Familia]Código_Interno")
If ($l_elemento>0)
	aRecordFieldKey{$l_elemento}:=$p_IconoLlaveImportacion
End if 


  //movido a WIZ_STR_CargaDatosEncabezadotxt
  //$l_elemento:=Find in array(aRecordFieldNames;"[Alumno]Curso")
  //If ($l_elemento>0)
  //aRecordFieldNames{$l_elemento}:="[Alumno]Curso (solo letra)"
  //End if 

  //$l_elemento:=Find in array(aRecordFieldNames;"[Alumno]Nivel_Numero")
  //If ($l_elemento>0)
  //aRecordFieldNames{$l_elemento}:="[Alumno]Nivel_Numero (-6 a 18)"
  //End if 

For ($i;1;Size of array:C274(aRecordFieldNames))
	Case of 
		: ((aRecordFieldModAtt{$i}=-1) | (Picture size:C356(aRecordFieldKey{$i})>0))
			aRecordFieldModifiable{$i}:=$p_iconoCampoNoEditable
		: (aRecordFieldModAtt{$i}=1)
			aRecordFieldModifiable{$i}:=$p_iconoCampoEditable
	End case 
End for 

If (Shift down:C543)  //guarda en un archivo texto los nombres de los campos 
	$t_nombresCampos:=AT_array2text (->aRecordFieldNames;"\t")
	$h_refDocumento:=Create document:C266("";"TEXT")
	SEND PACKET:C103($h_refDocumento;$t_nombresCampos)
	CLOSE DOCUMENT:C267($h_refDocumento)
End if 

If (Not:C34(b_conexionWeb))
	
	Case of   //20171122 RCH
		: (viIOstr_PlatFormSource=3)
			USE CHARACTER SET:C205("windows-1252";1)
		: (viIOstr_PlatFormSource=1)
			USE CHARACTER SET:C205("MacRoman";1)
		: (viIOstr_PlatFormSource=4)
			USE CHARACTER SET:C205("UTF-8";1)
	End case 
	
	If (SYS_IsWindows )  //20171122 RCH
		USE CHARACTER SET:C205("windows-1252";0)
	Else 
		USE CHARACTER SET:C205("MacRoman";0)
	End if 
	
	WDW_OpenFormWindow (->[xxSTR_Constants:1];"STR_Asistente_ImportaAlumnos";-1;4;__ ("Asistentes"))
	DIALOG:C40([xxSTR_Constants:1];"STR_Asistente_ImportaAlumnos")
	CLOSE WINDOW:C154
	
Else 
	
	USE CHARACTER SET:C205("UTF-8";1)
	USE CHARACTER SET:C205("UTF-8";0)
	ok:=WIZ_ADT_PreparaDatosImport (vtIOstr_FilePath)
End if 

If (ok=1)
	C_OBJECT:C1216($ob_respuesta)
	bc_InscribirAlumnos:=0
	$t_NombreDocLog:=Choose:C955(b_conexionWeb;"Importación de alumnos[web]";"Importación de alumnos")
	$t_RutaArchivoLog:=SYS_CarpetaAplicacion (CLG_DocumentosServer)+"Importacion de Alumnos"
	SYS_CreaCarpetaServidor ($t_RutaArchivoLog)
	$t_RutaArchivoLog:=$t_RutaArchivoLog+SYS_FolderDelimiterOnServer +$t_NombreDocLog+"_"+DTS_Get_GMT_TimeStamp +".log"
	$ob_respuesta:=IOstr_ImportStudentData (vtIOstr_FilePath;bc_InscribirAlumnos;$t_RutaArchivoLog;b_conexionWeb)  //20171122 RCH
	  //SQ_SetSequences //20171122 RCH Según lo analizado, esto no sería necesario
	FLUSH CACHE:C297
	
	If (b_conexionWeb)
		ADT_postEnviaRespuestaImport (vtIOstr_FilePath;$t_uuidProceso;$t_url;$t_RutaArchivoLog;$ob_respuesta)  //20171122 RCH
	End if 
	
	
End if 

USE CHARACTER SET:C205(*;0)
USE CHARACTER SET:C205(*;1)