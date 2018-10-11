//%attributes = {}
  //SOPORTE_ImportaInasistencias

C_TIME:C306($ref)
C_LONGINT:C283($Created;$procesed;$numAlumno;$numLista;$numAsignatura;$length)
C_TEXT:C284($nombreoficial;$nombreInterno;$abreviatura;$runAlumno;$codeAlumno)
C_REAL:C285($nota1;$nota2;$nota3;$nota4;$nota5;$nota6;$nota7;$nota8;$nota9;$nota10;$nota11;$nota12)



EVS_LoadStyles 
EVS_ReadStyleData (-5)

READ WRITE:C146([Alumnos_Inasistencias:10])
READ ONLY:C145([Alumnos:2])
$ref:=Open document:C264("")
$size:=Get document size:C479(document)
RECEIVE PACKET:C104($ref;$text;"\r")
$copies:=0
$created:=0
$procesed:=0
$length:=0
MESSAGES OFF:C175
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Importando registros de inasistencias... "))
While ((ok=1) & ($text#""))
	$length:=$length+Length:C16($text)+1
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$length/$size;__ ("Importando Registros de inasistencias... "))
	ARRAY TEXT:C222(aText1;0)
	AT_Text2Array (->aText1;$text;"\t")
	ARRAY TEXT:C222(aText1;43)
	$codeAlumno:=ST_GetCleanString (aText1{1})
	$fecha:=Date:C102(ST_GetCleanString (aText1{2}))
	
	
	QUERY:C277([Alumnos:2];[Alumnos:2]RUT:5=$codeAlumno)
	$idAlumno:=[Alumnos:2]numero:1
	$numeroNivel:=[Alumnos:2]nivel_numero:29
	
	PERIODOS_LoadData ($numeroNivel)
	If (DateIsValid ($fecha;0))
		Case of 
			: (Records in selection:C76([Alumnos:2])=0)
			: (Records in selection:C76([Alumnos:2])>1)
			: (Records in selection:C76([Alumnos:2])=1)
				QUERY:C277([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Alumno_Numero:4=$idAlumno;*)
				QUERY:C277([Alumnos_Inasistencias:10]; & [Alumnos_Inasistencias:10]Fecha:1=$fecha)
				If (Records in selection:C76([Alumnos_Inasistencias:10])=0)
					CREATE RECORD:C68([Alumnos_Inasistencias:10])
					[Alumnos_Inasistencias:10]Alumno_Numero:4:=$idAlumno
					[Alumnos_Inasistencias:10]Fecha:1:=$fecha
					[Alumnos_Inasistencias:10]Nivel_Numero:9:=$numeroNivel
					SAVE RECORD:C53([Alumnos_Inasistencias:10])
				End if 
		End case 
	End if 
	RECEIVE PACKET:C104($ref;$text;"\r")
End while 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
KRL_UnloadReadOnly (->[Alumnos_Inasistencias:10])
FLUSH CACHE:C297

dbu_ReparaConducta 
C_BLOB:C604($blob)
SET BLOB SIZE:C606($blob;0)
dbu_CalculaSituacionFinal ($blob;False:C215)
FLUSH CACHE:C297
