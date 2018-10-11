//%attributes = {}
  //IOstr_ImportStudentData
C_BOOLEAN:C305($b_conexionWeb)
C_LONGINT:C283($inscribeAlumnos;$2)
C_TEXT:C284($1)
C_OBJECT:C1216($ob_respuesta;$0)
ON ERR CALL:C155("ERR_GenericOnError")

$t_rutaLog:="Importación de alumnos.log"
Case of 
	: (Count parameters:C259=4)
		$document:=$1
		$inscribeAlumnos:=$2
		$t_rutaLog:=$3
		$b_conexionWeb:=$4
	: (Count parameters:C259=3)
		$document:=$1
		$inscribeAlumnos:=$2
		$t_rutaLog:=$3
	: (Count parameters:C259=2)
		$document:=$1
		$inscribeAlumnos:=$2
	: (Count parameters:C259=1)
		$document:=$1
		$inscribeAlumnos:=1
	: (Count parameters:C259=0)
		$document:=""
		$inscribeAlumnos:=1
End case 

READ WRITE:C146([Alumnos:2])
READ WRITE:C146([Personas:7])
READ WRITE:C146([Familia:78])
READ WRITE:C146([Cursos:3])
READ WRITE:C146([Familia_RelacionesFamiliares:77])
CREATE EMPTY SET:C140([Alumnos:2];"Importación")

  //20171122 RCH
ARRAY TEXT:C222(atIOstr_UUIDAlumnosN;0)
ARRAY TEXT:C222(atIOstr_UUIDAlumnosA;0)

ARRAY TEXT:C222(atIOstr_UUIDApdosN;0)
ARRAY TEXT:C222(atIOstr_UUIDApdosA;0)

ARRAY TEXT:C222(atIOstr_UUIDFamiliasN;0)
ARRAY TEXT:C222(atIOstr_UUIDFamiliasA;0)

$l_lineasDelArchivo:=0

vi_newClasses:=0
$ref:=Append document:C265($document)
SEND PACKET:C103($ref;"\r")
CLOSE DOCUMENT:C267($ref)


vH_logRef:=Create document:C266($t_rutaLog)
$logText:="Importación de alumnos iniciada el: "+String:C10(Current date:C33(*))+"a las "+String:C10(Current time:C178;2)+" por"+<>tUSR_CurrentUser+"\r"
$logText:=$logText+"Base de datos: "+<>syT_DDPath+"\r\r"
SEND PACKET:C103(vH_logRef;$logText)


$ref:=Open document:C264($document;"";Read mode:K24:5)
If (OK=1)
	EVS_LoadStyles 
	LOC_LoadIdenNacionales   //MONO VALIDACION DE RUT EN IMPORTACION
	
	  //JVP 20160816 ticket 166318 
	$delimiter:=ACTabc_DetectDelimiter ($document)
	$size:=SYS_GetFileSize ($document)
	RECEIVE PACKET:C104($ref;$Header;$delimiter)
	
	AT_Text2Array (->aRecordLine;$header;"\t")
	$arrayElements:=Size of array:C274(aRecordLine)
	
	RECEIVE PACKET:C104($ref;$text;$delimiter)
	
	$length:=0
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Importando Registros... "))
	While ($text#"")
		$length:=$length+Length:C16($text)+1
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$length/$size;__ ("Importando Registros... "))
		If ($text#"")
			$l_lineasDelArchivo:=$l_lineasDelArchivo+1  //20171122 RCH
			
			ARRAY TEXT:C222(aRecordLine;0)
			AT_Text2Array (->aRecordLine;$text;"\t")
			ARRAY TEXT:C222(aRecordLine;$arrayElements)
			For ($i;1;$arrayElements)
				aRecordLine{$i}:=ST_CleanString (aRecordLine{$i})
			End for 
			vl_StudentRecNum:=-1
			vl_FamilyRecNum:=-1
			vl_MotherRecNum:=-1
			vl_FatherRecNum:=-1
			vl_apAcademicoRecNum:=-1
			vl_apCuentasRecNum:=-1
			vt_ApoderadoAcadémico:=""
			vt_ApoderadoCuentas:=""
			IOstr_ProcessStudentRecord ($b_conexionWeb)
			If (vl_StudentRecNum>=0)
				$familyRecNum:=IOstr_ProcessFamilyRecord ($b_conexionWeb)
				
				KRL_GotoRecord (->[Alumnos:2];vl_StudentRecNum;True:C214)
				  //$familyRecNum:=Record number([Familia])
				IOstr_ProcessParentRecord ("[Madre]";$b_conexionWeb)
				
				KRL_GotoRecord (->[Alumnos:2];vl_StudentRecNum;True:C214)
				IOstr_ProcessParentRecord ("[Padre]";$b_conexionWeb)
				Case of 
					: (vt_ApoderadoCuentas="")
						IOstr_ProcessParentRecord ("[Apoderado de cuenta]";$b_conexionWeb)
					: ((vt_ApoderadoCuentas="P@") | (vt_ApoderadoCuentas="F@"))
						vl_apCuentasRecNum:=vl_FatherRecNum
					: (vt_ApoderadoCuentas="M@")
						vl_apCuentasRecNum:=vl_MotherRecNum
				End case 
				
				KRL_GotoRecord (->[Alumnos:2];vl_StudentRecNum;True:C214)
				Case of 
					: (vt_ApoderadoAcademico="")
						IOstr_ProcessParentRecord ("[Apoderado académico]";$b_conexionWeb)
					: ((vt_ApoderadoAcademico="P@") | (vt_ApoderadoAcademico="F@"))
						vl_apAcademicoRecNum:=vl_FatherRecNum
					: (vt_ApoderadoAcademico="M@")
						vl_apAcademicoRecNum:=vl_MotherRecNum
				End case 
				
				KRL_GotoRecord (->[Alumnos:2];vl_StudentRecNum;True:C214)
				IOstr_linkStudentToFamily ($familyRecNum)
				
				KRL_GotoRecord (->[Alumnos:2];vl_StudentRecNum;True:C214)
				If (vl_apCuentasRecNum>=0)
					GOTO RECORD:C242([Personas:7];vl_apCuentasRecNum)
					[Alumnos:2]Apoderado_Cuentas_Número:28:=[Personas:7]No:1
				End if 
				If (vl_apAcademicoRecNum>=0)
					GOTO RECORD:C242([Personas:7];vl_apAcademicoRecNum)
					[Alumnos:2]Apoderado_académico_Número:27:=[Personas:7]No:1
				End if 
				
				KRL_GotoRecord (->[Alumnos:2];vl_StudentRecNum;True:C214)
				If (vl_FamilyRecNum>=0)
					GOTO RECORD:C242([Familia:78];vl_FamilyRecNum)
					[Alumnos:2]Familia_Número:24:=[Familia:78]Numero:1
				End if 
				[Alumnos:2]Apellido_paterno:3:=ST_Format (->[Alumnos:2]Apellido_paterno:3)
				[Alumnos:2]Apellido_materno:4:=ST_Format (->[Alumnos:2]Apellido_materno:4)
				[Alumnos:2]Nombres:2:=ST_Format (->[Alumnos:2]Nombres:2)
				AL_ProcesaNombres (False:C215)
				
				SAVE RECORD:C53([Alumnos:2])
				LOAD RECORD:C52([Familia:78])  //ABC 20171611 Ticket 191650  //Al importar por asistente la familia quedaba inactiva.
				SAVE RECORD:C53([Alumnos_FichaMedica:13])
			Else 
				  //IOstr_ProcessFamilyRecord ($b_conexionWeb)
				  //$familyRecNum:=Record number([Familia])
				REDUCE SELECTION:C351([Alumnos:2];0)
				$familyRecNum:=IOstr_ProcessFamilyRecord ($b_conexionWeb)
				IOstr_ProcessParentRecord ("[Madre]";$b_conexionWeb)
				IOstr_ProcessParentRecord ("[Padre]";$b_conexionWeb)
				IOstr_linkStudentToFamily ($familyRecNum)
			End if 
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
		Else 
			OK:=0
		End if 
		  //JVP 20160816 ticket 166318 
		  //RECEIVE PACKET($ref;$text;<>cr)
		RECEIVE PACKET:C104($ref;$text;$delimiter)
	End while 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	CLOSE DOCUMENT:C267($ref)
	
	
	If (Records in set:C195("Importación")>0)
		USE SET:C118("Importación")
		SELECTION TO ARRAY:C260([Alumnos:2];$recNums)
		$gradeRecordsHasBeenDeleted:=True:C214
		$s:=Size of array:C274($recNums)
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Creando registro de alumnos..."))
		For ($i;1;$s)
			GOTO RECORD:C242([Alumnos:2];$recNums{$i})
			AL_CreaRegistros 
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/$s;__ ("Creando registro de alumnos...."))
		End for 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		CLEAR SET:C117("Importación")
	End if 
	
	If ($inscribeAlumnos=1)
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Incribiendo alumnos en asignaturas..."))
		For ($i;1;$s)
			GOTO RECORD:C242([Alumnos:2];$recNums{$i})
			AL_CreateGradeRecords 
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/$s;__ ("Incribiendo alumnos en asignaturas..."))
		End for 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		CLEAR SET:C117("Importación")
	End if 
	
	$logText:="Importación de alumnos terminada el: "+String:C10(Current date:C33(*))+"a las "+String:C10(Current time:C178;2)+"\r\r"
	$logText:=$logText+"Fueron creados: "+"\r"
	$logText:=$logText+String:C10(Size of array:C274(atIOstr_UUIDAlumnosN))+" Alumnos"+"\r"  //20171122 RCH
	$logText:=$logText+String:C10(Size of array:C274(atIOstr_UUIDApdosN))+" Padres o apoderados"+"\r"  //20171122 RCH
	$logText:=$logText+String:C10(Size of array:C274(atIOstr_UUIDFamiliasN))+" Familias"+"\r"
	$logText:=$logText+String:C10(vi_newClasses)+" Cursos"+"\r"
	SEND PACKET:C103(vH_logRef;$logText)
	CLOSE DOCUMENT:C267(vH_logRef)
	dbuSTR_ReparaTipoApoderadoRF 
Else 
	$logText:="Importación de alumnos abortada."+"\r\r"
	SEND PACKET:C103(vH_logRef;$logText)
	CLOSE DOCUMENT:C267(vH_logRef)
End if 

KRL_UnloadReadOnly (->[Alumnos_FichaMedica:13])
KRL_UnloadReadOnly (->[Alumnos:2])
KRL_UnloadReadOnly (->[Personas:7])
KRL_UnloadReadOnly (->[Familia:78])
KRL_UnloadReadOnly (->[Cursos:3])
KRL_UnloadReadOnly (->[Familia_RelacionesFamiliares:77])
CU_LoadArrays 
CLOSE DOCUMENT:C267($ref)

ARRAY TEXT:C222(aListElements;0)
READ WRITE:C146([xShell_List:39])
QUERY:C277([xShell_List:39];[xShell_List:39]Listname:1="Secciones")
TBL_Rebuild 
  //BLOB_Variables2Blob (->[xShell_List]Contents;0;->aListElements)
  //SAVE RECORD([xShell_List])

  //20140107 ASM Ticket  128514
TBL_SaveListAndArrays (->aListElements;->aListElements)
UNLOAD RECORD:C212([xShell_List:39])
READ ONLY:C145([xShell_List:39])

OB SET:C1220($ob_respuesta;"lineas_recibidas";$l_lineasDelArchivo)
OB SET ARRAY:C1227($ob_respuesta;"alumnos_nuevos";atIOstr_UUIDAlumnosN)
OB SET ARRAY:C1227($ob_respuesta;"alumnos_actualizados";atIOstr_UUIDAlumnosA)

OB SET ARRAY:C1227($ob_respuesta;"apoderados_nuevos";atIOstr_UUIDApdosN)
OB SET ARRAY:C1227($ob_respuesta;"apoderados_actualizados";atIOstr_UUIDApdosA)

OB SET ARRAY:C1227($ob_respuesta;"familias_nuevas";atIOstr_UUIDFamiliasN)
OB SET ARRAY:C1227($ob_respuesta;"familias_actualizadas";atIOstr_UUIDFamiliasA)

AT_Initialize (->atIOstr_UUIDAlumnosN;->atIOstr_UUIDAlumnosA;->atIOstr_UUIDApdosN;->atIOstr_UUIDApdosA;->atIOstr_UUIDFamiliasN;->atIOstr_UUIDFamiliasA)

$0:=$ob_respuesta