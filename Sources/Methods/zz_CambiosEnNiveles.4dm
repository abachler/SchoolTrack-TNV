//%attributes = {}
  //zz_CambiosEnNiveles

ARRAY TEXT:C222($aString2Replace;585)
ARRAY TEXT:C222($aReplaceBy;585)
AT_Inc (0)

$Ref:=Open document:C264("";Get pathname:K24:6)
$apiRef:=API Open Resource File (document)

  //**********************************************************************
  //**************                  CAMBIOS EN LAS BUSQUEDAS                 ************** 
  //**********************************************************************

  //==================================================
  //[Alumnos]Nivel_Numero
  //==================================================

  //cambios en búsquedas [Alumnos]Nivel_Numero >=
$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]Nivel_Numero>=Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[Alumnos]Nivel_Numero>=Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]Nivel_Numero>=Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[Alumnos]Nivel_Numero>=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]Nivel_Numero>=-3"
$aReplaceBy{$element}:="[Alumnos]Nivel_Numero>=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]Nivel_Numero>=-2"
$aReplaceBy{$element}:="[Alumnos]Nivel_Numero>=-3"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]Nivel_Numero>=-1"
$aReplaceBy{$element}:="[Alumnos]Nivel_Numero>=-2"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]Nivel_Numero>=Nivel_Egresados"
$aReplaceBy{$element}:="[Alumnos]Nivel_Numero>=Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]Nivel_Numero>=Nivel_Retirados"
$aReplaceBy{$element}:="[Alumnos]Nivel_Numero>=Nivel_Retirados"


  //cambios en búsquedas [Alumnos]Nivel_Numero <=
$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]Nivel_Numero<=Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[Alumnos]Nivel_Numero<=Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]Nivel_Numero<=Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[Alumnos]Nivel_Numero<=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]Nivel_Numero<=-3"
$aReplaceBy{$element}:="[Alumnos]Nivel_Numero<=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]Nivel_Numero<=-2"
$aReplaceBy{$element}:="[Alumnos]Nivel_Numero<=-3"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]Nivel_Numero<=-1"
$aReplaceBy{$element}:="[Alumnos]Nivel_Numero<=-2"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]Nivel_Numero<=Nivel_Egresados"
$aReplaceBy{$element}:="[Alumnos]Nivel_Numero<=Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]Nivel_Numero<=Nivel_Retirados"
$aReplaceBy{$element}:="[Alumnos]Nivel_Numero<=Nivel_Retirados"



  //cambios en búsquedas [Alumnos]Nivel_Numero =
$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]Nivel_Numero=Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[Alumnos]Nivel_Numero=Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]Nivel_Numero=Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[Alumnos]Nivel_Numero=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]Nivel_Numero=-3"
$aReplaceBy{$element}:="[Alumnos]Nivel_Numero=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]Nivel_Numero=-2"
$aReplaceBy{$element}:="[Alumnos]Nivel_Numero=-3"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]Nivel_Numero=-1"
$aReplaceBy{$element}:="[Alumnos]Nivel_Numero=-2"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]Nivel_Numero=Nivel_Egresados"
$aReplaceBy{$element}:="[Alumnos]Nivel_Numero=Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]Nivel_Numero=Nivel_Retirados"
$aReplaceBy{$element}:="[Alumnos]Nivel_Numero=Nivel_Retirados"


  //cambios en búsquedas [Alumnos]Nivel_Numero >
$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]Nivel_Numero>Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[Alumnos]Nivel_Numero>Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]Nivel_Numero>Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[Alumnos]Nivel_Numero>Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]Nivel_Numero>-3"
$aReplaceBy{$element}:="[Alumnos]Nivel_Numero>Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]Nivel_Numero>-2"
$aReplaceBy{$element}:="[Alumnos]Nivel_Numero>-3"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]Nivel_Numero>-1"
$aReplaceBy{$element}:="[Alumnos]Nivel_Numero>-2"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]Nivel_Numero>Nivel_Egresados"
$aReplaceBy{$element}:="[Alumnos]Nivel_Numero>Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]Nivel_Numero>Nivel_Retirados"
$aReplaceBy{$element}:="[Alumnos]Nivel_Numero>Nivel_Retirados"


  //cambios en búsquedas [Alumnos]Nivel_Numero <
$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]Nivel_Numero<Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[Alumnos]Nivel_Numero<Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]Nivel_Numero<Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[Alumnos]Nivel_Numero<Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]Nivel_Numero<-3"
$aReplaceBy{$element}:="[Alumnos]Nivel_Numero<Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]Nivel_Numero<-2"
$aReplaceBy{$element}:="[Alumnos]Nivel_Numero<-3"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]Nivel_Numero<-1"
$aReplaceBy{$element}:="[Alumnos]Nivel_Numero<-2"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]Nivel_Numero<Nivel_Egresados"
$aReplaceBy{$element}:="[Alumnos]Nivel_Numero<Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]Nivel_Numero<Nivel_Retirados"
$aReplaceBy{$element}:="[Alumnos]Nivel_Numero<Nivel_Retirados"



  //==================================================
  //[Alumnos]NoNivel_alRetirarse
  //==================================================

  //cambios en búsquedas [Alumnos]NoNivel_alRetirarse >=
$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]NoNivel_alRetirarse>=Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[Alumnos]NoNivel_alRetirarse>=Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]NoNivel_alRetirarse>=Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[Alumnos]NoNivel_alRetirarse>=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]NoNivel_alRetirarse>=-3"
$aReplaceBy{$element}:="[Alumnos]NoNivel_alRetirarse>=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]NoNivel_alRetirarse>=-2"
$aReplaceBy{$element}:="[Alumnos]NoNivel_alRetirarse>=-3"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]NoNivel_alRetirarse>=-1"
$aReplaceBy{$element}:="[Alumnos]NoNivel_alRetirarse>=-2"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]NoNivel_alRetirarse>=Nivel_Egresados"
$aReplaceBy{$element}:="[Alumnos]NoNivel_alRetirarse>=Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]NoNivel_alRetirarse>=Nivel_Retirados"
$aReplaceBy{$element}:="[Alumnos]NoNivel_alRetirarse>=Nivel_Retirados"



  //cambios en búsquedas [Alumnos]NoNivel_alRetirarse <=
$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]NoNivel_alRetirarse<=Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[Alumnos]NoNivel_alRetirarse<=Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]NoNivel_alRetirarse<=Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[Alumnos]NoNivel_alRetirarse<=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]NoNivel_alRetirarse<=-3"
$aReplaceBy{$element}:="[Alumnos]NoNivel_alRetirarse<=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]NoNivel_alRetirarse<=-2"
$aReplaceBy{$element}:="[Alumnos]NoNivel_alRetirarse<=-3"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]NoNivel_alRetirarse<=-1"
$aReplaceBy{$element}:="[Alumnos]NoNivel_alRetirarse<=-2"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]NoNivel_alRetirarse<=Nivel_Egresados"
$aReplaceBy{$element}:="[Alumnos]NoNivel_alRetirarse<=Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]NoNivel_alRetirarse<=Nivel_Retirados"
$aReplaceBy{$element}:="[Alumnos]NoNivel_alRetirarse<=Nivel_Retirados"



  //cambios en búsquedas [Alumnos]NoNivel_alRetirarse =
$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]NoNivel_alRetirarse=Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[Alumnos]NoNivel_alRetirarse=Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]NoNivel_alRetirarse=Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[Alumnos]NoNivel_alRetirarse=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]NoNivel_alRetirarse=-3"
$aReplaceBy{$element}:="[Alumnos]NoNivel_alRetirarse=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]NoNivel_alRetirarse=-2"
$aReplaceBy{$element}:="[Alumnos]NoNivel_alRetirarse=-3"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]NoNivel_alRetirarse=-1"
$aReplaceBy{$element}:="[Alumnos]NoNivel_alRetirarse=-2"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]NoNivel_alRetirarse=Nivel_Egresados"
$aReplaceBy{$element}:="[Alumnos]NoNivel_alRetirarse=Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]NoNivel_alRetirarse=Nivel_Retirados"
$aReplaceBy{$element}:="[Alumnos]NoNivel_alRetirarse=Nivel_Retirados"


  //cambios en búsquedas [Alumnos]NoNivel_alRetirarse >
$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]NoNivel_alRetirarse>Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[Alumnos]NoNivel_alRetirarse>Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]NoNivel_alRetirarse>Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[Alumnos]NoNivel_alRetirarse>Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]NoNivel_alRetirarse>-3"
$aReplaceBy{$element}:="[Alumnos]NoNivel_alRetirarse>Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]NoNivel_alRetirarse>-2"
$aReplaceBy{$element}:="[Alumnos]NoNivel_alRetirarse>-3"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]NoNivel_alRetirarse>-1"
$aReplaceBy{$element}:="[Alumnos]NoNivel_alRetirarse>-2"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]NoNivel_alRetirarse>Nivel_Egresados"
$aReplaceBy{$element}:="[Alumnos]NoNivel_alRetirarse>Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]NoNivel_alRetirarse>Nivel_Retirados"
$aReplaceBy{$element}:="[Alumnos]NoNivel_alRetirarse>Nivel_Retirados"


  //cambios en búsquedas [Alumnos]NoNivel_alRetirarse <
$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]NoNivel_alRetirarse<Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[Alumnos]NoNivel_alRetirarse<Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]NoNivel_alRetirarse<Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[Alumnos]NoNivel_alRetirarse<Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]NoNivel_alRetirarse<-3"
$aReplaceBy{$element}:="[Alumnos]NoNivel_alRetirarse<Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]NoNivel_alRetirarse<-2"
$aReplaceBy{$element}:="[Alumnos]NoNivel_alRetirarse<-3"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]NoNivel_alRetirarse<-1"
$aReplaceBy{$element}:="[Alumnos]NoNivel_alRetirarse<-2"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]NoNivel_alRetirarse<Nivel_Egresados"
$aReplaceBy{$element}:="[Alumnos]NoNivel_alRetirarse<Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]NoNivel_alRetirarse<Nivel_Retirados"
$aReplaceBy{$element}:="[Alumnos]NoNivel_alRetirarse<Nivel_Retirados"



  //==================================================
  //[Cursos]Nivel_Numero
  //==================================================

  //cambios en búsquedas [Cursos]Nivel_Numero >=
$element:=AT_Inc 
$aString2Replace{$element}:="[Cursos]Nivel_Numero>=Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[Cursos]Nivel_Numero>=Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[Cursos]Nivel_Numero>=Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[Cursos]Nivel_Numero>=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Cursos]Nivel_Numero>=-3"
$aReplaceBy{$element}:="[Cursos]Nivel_Numero>=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Cursos]Nivel_Numero>=-2"
$aReplaceBy{$element}:="[Cursos]Nivel_Numero>=-3"

$element:=AT_Inc 
$aString2Replace{$element}:="[Cursos]Nivel_Numero>=-1"
$aReplaceBy{$element}:="[Cursos]Nivel_Numero>=-2"

$element:=AT_Inc 
$aString2Replace{$element}:="[Cursos]Nivel_Numero>=Nivel_Egresados"
$aReplaceBy{$element}:="[Cursos]Nivel_Numero>=Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[Cursos]Nivel_Numero>=Nivel_Retirados"
$aReplaceBy{$element}:="[Cursos]Nivel_Numero>=Nivel_Retirados"


  //cambios en búsquedas [Cursos]Nivel_Numero <=
$element:=AT_Inc 
$aString2Replace{$element}:="[Cursos]Nivel_Numero<=Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[Cursos]Nivel_Numero<=Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[Cursos]Nivel_Numero<=Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[Cursos]Nivel_Numero<=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Cursos]Nivel_Numero<=-3"
$aReplaceBy{$element}:="[Cursos]Nivel_Numero<=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Cursos]Nivel_Numero<=-2"
$aReplaceBy{$element}:="[Cursos]Nivel_Numero<=-3"

$element:=AT_Inc 
$aString2Replace{$element}:="[Cursos]Nivel_Numero<=-1"
$aReplaceBy{$element}:="[Cursos]Nivel_Numero<=-2"

$element:=AT_Inc 
$aString2Replace{$element}:="[Cursos]Nivel_Numero<=Nivel_Egresados"
$aReplaceBy{$element}:="[Cursos]Nivel_Numero<=Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[Cursos]Nivel_Numero<=Nivel_Retirados"
$aReplaceBy{$element}:="[Cursos]Nivel_Numero<=Nivel_Retirados"



  //cambios en búsquedas [Cursos]Nivel_Numero =
$element:=AT_Inc 
$aString2Replace{$element}:="[Cursos]Nivel_Numero=Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[Cursos]Nivel_Numero=Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[Cursos]Nivel_Numero=Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[Cursos]Nivel_Numero=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Cursos]Nivel_Numero=-3"
$aReplaceBy{$element}:="[Cursos]Nivel_Numero=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Cursos]Nivel_Numero=-2"
$aReplaceBy{$element}:="[Cursos]Nivel_Numero=-3"

$element:=AT_Inc 
$aString2Replace{$element}:="[Cursos]Nivel_Numero=-1"
$aReplaceBy{$element}:="[Cursos]Nivel_Numero=-2"

$element:=AT_Inc 
$aString2Replace{$element}:="[Cursos]Nivel_Numero=Nivel_Egresados"
$aReplaceBy{$element}:="[Cursos]Nivel_Numero=Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[Cursos]Nivel_Numero=Nivel_Retirados"
$aReplaceBy{$element}:="[Cursos]Nivel_Numero=Nivel_Retirados"


  //cambios en búsquedas [Cursos]Nivel_Numero >
$element:=AT_Inc 
$aString2Replace{$element}:="[Cursos]Nivel_Numero>Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[Cursos]Nivel_Numero>Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[Cursos]Nivel_Numero>Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[Cursos]Nivel_Numero>Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Cursos]Nivel_Numero>-3"
$aReplaceBy{$element}:="[Cursos]Nivel_Numero>Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Cursos]Nivel_Numero>-2"
$aReplaceBy{$element}:="[Cursos]Nivel_Numero>-3"

$element:=AT_Inc 
$aString2Replace{$element}:="[Cursos]Nivel_Numero>-1"
$aReplaceBy{$element}:="[Cursos]Nivel_Numero>-2"

$element:=AT_Inc 
$aString2Replace{$element}:="[Cursos]Nivel_Numero>Nivel_Egresados"
$aReplaceBy{$element}:="[Cursos]Nivel_Numero>Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[Cursos]Nivel_Numero>Nivel_Retirados"
$aReplaceBy{$element}:="[Cursos]Nivel_Numero>Nivel_Retirados"


  //cambios en búsquedas [Cursos]Nivel_Numero <
$element:=AT_Inc 
$aString2Replace{$element}:="[Cursos]Nivel_Numero<Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[Cursos]Nivel_Numero<Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[Cursos]Nivel_Numero<Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[Cursos]Nivel_Numero<Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Cursos]Nivel_Numero<-3"
$aReplaceBy{$element}:="[Cursos]Nivel_Numero<Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Cursos]Nivel_Numero<-2"
$aReplaceBy{$element}:="[Cursos]Nivel_Numero<-3"

$element:=AT_Inc 
$aString2Replace{$element}:="[Cursos]Nivel_Numero<-1"
$aReplaceBy{$element}:="[Cursos]Nivel_Numero<-2"

$element:=AT_Inc 
$aString2Replace{$element}:="[Cursos]Nivel_Numero<Nivel_Egresados"
$aReplaceBy{$element}:="[Cursos]Nivel_Numero<Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[Cursos]Nivel_Numero<Nivel_Retirados"
$aReplaceBy{$element}:="[Cursos]Nivel_Numero<Nivel_Retirados"


  //==================================================
  //[xxSTR_Niveles]noNivel
  //==================================================

  //cambios en búsquedas [xxSTR_Niveles]noNivel >=
$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Niveles]noNivel>=Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[xxSTR_Niveles]noNivel>=Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Niveles]noNivel>=Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[xxSTR_Niveles]noNivel>=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Niveles]noNivel>=-3"
$aReplaceBy{$element}:="[xxSTR_Niveles]noNivel>=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Niveles]noNivel>=-2"
$aReplaceBy{$element}:="[xxSTR_Niveles]noNivel>=-3"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Niveles]noNivel>=-1"
$aReplaceBy{$element}:="[xxSTR_Niveles]noNivel>=-2"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Niveles]noNivel>=Nivel_Egresados"
$aReplaceBy{$element}:="[xxSTR_Niveles]noNivel>=Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Niveles]noNivel>=Nivel_Retirados"
$aReplaceBy{$element}:="[xxSTR_Niveles]noNivel>=Nivel_Retirados"


  //cambios en búsquedas [xxSTR_Niveles]noNivel <=
$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Niveles]noNivel<=Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[xxSTR_Niveles]noNivel<=Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Niveles]noNivel<=Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[xxSTR_Niveles]noNivel<=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Niveles]noNivel<=-3"
$aReplaceBy{$element}:="[xxSTR_Niveles]noNivel<=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Niveles]noNivel<=-2"
$aReplaceBy{$element}:="[xxSTR_Niveles]noNivel<=-3"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Niveles]noNivel<=-1"
$aReplaceBy{$element}:="[xxSTR_Niveles]noNivel<=-2"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Niveles]noNivel<=Nivel_Egresados"
$aReplaceBy{$element}:="[xxSTR_Niveles]noNivel<=Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Niveles]noNivel<=Nivel_Retirados"
$aReplaceBy{$element}:="[xxSTR_Niveles]noNivel<=Nivel_Retirados"



  //cambios en búsquedas [xxSTR_Niveles]noNivel =
$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Niveles]noNivel=Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[xxSTR_Niveles]noNivel=Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Niveles]noNivel=Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[xxSTR_Niveles]noNivel=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Niveles]noNivel=-3"
$aReplaceBy{$element}:="[xxSTR_Niveles]noNivel=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Niveles]noNivel=-2"
$aReplaceBy{$element}:="[xxSTR_Niveles]noNivel=-3"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Niveles]noNivel=-1"
$aReplaceBy{$element}:="[xxSTR_Niveles]noNivel=-2"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Niveles]noNivel=Nivel_Egresados"
$aReplaceBy{$element}:="[xxSTR_Niveles]noNivel=Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Niveles]noNivel=Nivel_Retirados"
$aReplaceBy{$element}:="[xxSTR_Niveles]noNivel=Nivel_Retirados"


  //cambios en búsquedas [xxSTR_Niveles]noNivel >
$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Niveles]noNivel>Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[xxSTR_Niveles]noNivel>Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Niveles]noNivel>Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[xxSTR_Niveles]noNivel>Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Niveles]noNivel>-3"
$aReplaceBy{$element}:="[xxSTR_Niveles]noNivel>Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Niveles]noNivel>-2"
$aReplaceBy{$element}:="[xxSTR_Niveles]noNivel>-3"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Niveles]noNivel>-1"
$aReplaceBy{$element}:="[xxSTR_Niveles]noNivel>-2"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Niveles]noNivel>Nivel_Egresados"
$aReplaceBy{$element}:="[xxSTR_Niveles]noNivel>Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Niveles]noNivel>Nivel_Retirados"
$aReplaceBy{$element}:="[xxSTR_Niveles]noNivel>Nivel_Retirados"


  //cambios en búsquedas [xxSTR_Niveles]noNivel <
$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Niveles]noNivel<Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[xxSTR_Niveles]noNivel<Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Niveles]noNivel<Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[xxSTR_Niveles]noNivel<Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Niveles]noNivel<-3"
$aReplaceBy{$element}:="[xxSTR_Niveles]noNivel<Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Niveles]noNivel<-2"
$aReplaceBy{$element}:="[xxSTR_Niveles]noNivel<-3"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Niveles]noNivel<-1"
$aReplaceBy{$element}:="[xxSTR_Niveles]noNivel<-2"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Niveles]noNivel<Nivel_Egresados"
$aReplaceBy{$element}:="[xxSTR_Niveles]noNivel<Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Niveles]noNivel<Nivel_Retirados"
$aReplaceBy{$element}:="[xxSTR_Niveles]noNivel<Nivel_Retirados"



  //==================================================
  //[Asignaturas]Numero_del_Nivel
  //==================================================

  //cambios en búsquedas [Asignaturas]Numero_del_Nivel >=
$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas]Numero_del_Nivel>=Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[Asignaturas]Numero_del_Nivel>=Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas]Numero_del_Nivel>=Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[Asignaturas]Numero_del_Nivel>=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas]Numero_del_Nivel>=-3"
$aReplaceBy{$element}:="[Asignaturas]Numero_del_Nivel>=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas]Numero_del_Nivel>=-2"
$aReplaceBy{$element}:="[Asignaturas]Numero_del_Nivel>=-3"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas]Numero_del_Nivel>=-1"
$aReplaceBy{$element}:="[Asignaturas]Numero_del_Nivel>=-2"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas]Numero_del_Nivel>=Nivel_Egresados"
$aReplaceBy{$element}:="[Asignaturas]Numero_del_Nivel>=Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas]Numero_del_Nivel>=Nivel_Retirados"
$aReplaceBy{$element}:="[Asignaturas]Numero_del_Nivel>=Nivel_Retirados"


  //cambios en búsquedas [Asignaturas]Numero_del_Nivel <=
$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas]Numero_del_Nivel<=Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[Asignaturas]Numero_del_Nivel<=Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas]Numero_del_Nivel<=Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[Asignaturas]Numero_del_Nivel<=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas]Numero_del_Nivel<=-3"
$aReplaceBy{$element}:="[Asignaturas]Numero_del_Nivel<=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas]Numero_del_Nivel<=-2"
$aReplaceBy{$element}:="[Asignaturas]Numero_del_Nivel<=-3"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas]Numero_del_Nivel<=-1"
$aReplaceBy{$element}:="[Asignaturas]Numero_del_Nivel<=-2"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas]Numero_del_Nivel<=Nivel_Egresados"
$aReplaceBy{$element}:="[Asignaturas]Numero_del_Nivel<=Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas]Numero_del_Nivel<=Nivel_Retirados"
$aReplaceBy{$element}:="[Asignaturas]Numero_del_Nivel<=Nivel_Retirados"



  //cambios en búsquedas [Asignaturas]Numero_del_Nivel =
$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas]Numero_del_Nivel=Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[Asignaturas]Numero_del_Nivel=Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas]Numero_del_Nivel=Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[Asignaturas]Numero_del_Nivel=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas]Numero_del_Nivel=-3"
$aReplaceBy{$element}:="[Asignaturas]Numero_del_Nivel=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas]Numero_del_Nivel=-2"
$aReplaceBy{$element}:="[Asignaturas]Numero_del_Nivel=-3"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas]Numero_del_Nivel=-1"
$aReplaceBy{$element}:="[Asignaturas]Numero_del_Nivel=-2"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas]Numero_del_Nivel=Nivel_Egresados"
$aReplaceBy{$element}:="[Asignaturas]Numero_del_Nivel=Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas]Numero_del_Nivel=Nivel_Retirados"
$aReplaceBy{$element}:="[Asignaturas]Numero_del_Nivel=Nivel_Retirados"


  //cambios en búsquedas [Asignaturas]Numero_del_Nivel >
$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas]Numero_del_Nivel>Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[Asignaturas]Numero_del_Nivel>Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas]Numero_del_Nivel>Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[Asignaturas]Numero_del_Nivel>Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas]Numero_del_Nivel>-3"
$aReplaceBy{$element}:="[Asignaturas]Numero_del_Nivel>Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas]Numero_del_Nivel>-2"
$aReplaceBy{$element}:="[Asignaturas]Numero_del_Nivel>-3"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas]Numero_del_Nivel>-1"
$aReplaceBy{$element}:="[Asignaturas]Numero_del_Nivel>-2"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas]Numero_del_Nivel>Nivel_Egresados"
$aReplaceBy{$element}:="[Asignaturas]Numero_del_Nivel>Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas]Numero_del_Nivel>Nivel_Retirados"
$aReplaceBy{$element}:="[Asignaturas]Numero_del_Nivel>Nivel_Retirados"


  //cambios en búsquedas [Asignaturas]Numero_del_Nivel <
$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas]Numero_del_Nivel<Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[Asignaturas]Numero_del_Nivel<Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas]Numero_del_Nivel<Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[Asignaturas]Numero_del_Nivel<Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas]Numero_del_Nivel<-3"
$aReplaceBy{$element}:="[Asignaturas]Numero_del_Nivel<Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas]Numero_del_Nivel<-2"
$aReplaceBy{$element}:="[Asignaturas]Numero_del_Nivel<-3"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas]Numero_del_Nivel<-1"
$aReplaceBy{$element}:="[Asignaturas]Numero_del_Nivel<-2"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas]Numero_del_Nivel<Nivel_Egresados"
$aReplaceBy{$element}:="[Asignaturas]Numero_del_Nivel<Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas]Numero_del_Nivel<Nivel_Retirados"
$aReplaceBy{$element}:="[Asignaturas]Numero_del_Nivel<Nivel_Retirados"

  //==================================================
  //[xxSTR_Materias]Observaciones’NumeroNivel
  //==================================================

  //cambios en búsquedas [xxSTR_Materias]Observaciones’NumeroNivel >=
$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel>=Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel>=Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel>=Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel>=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel>=-3"
$aReplaceBy{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel>=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel>=-2"
$aReplaceBy{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel>=-3"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel>=-1"
$aReplaceBy{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel>=-2"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel>=Nivel_Egresados"
$aReplaceBy{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel>=Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel>=Nivel_Retirados"
$aReplaceBy{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel>=Nivel_Retirados"


  //cambios en búsquedas [xxSTR_Materias]Observaciones’NumeroNivel <=
$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel<=Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel<=Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel<=Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel<=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel<=-3"
$aReplaceBy{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel<=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel<=-2"
$aReplaceBy{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel<=-3"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel<=-1"
$aReplaceBy{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel<=-2"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel<=Nivel_Egresados"
$aReplaceBy{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel<=Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel<=Nivel_Retirados"
$aReplaceBy{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel<=Nivel_Retirados"



  //cambios en búsquedas [xxSTR_Materias]Observaciones’NumeroNivel =
$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel=Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel=Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel=Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel=-3"
$aReplaceBy{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel=-2"
$aReplaceBy{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel=-3"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel=-1"
$aReplaceBy{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel=-2"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel=Nivel_Egresados"
$aReplaceBy{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel=Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel=Nivel_Retirados"
$aReplaceBy{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel=Nivel_Retirados"


  //cambios en búsquedas [xxSTR_Materias]Observaciones’NumeroNivel >
$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel>Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel>Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel>Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel>Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel>-3"
$aReplaceBy{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel>Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel>-2"
$aReplaceBy{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel>-3"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel>-1"
$aReplaceBy{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel>-2"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel>Nivel_Egresados"
$aReplaceBy{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel>Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel>Nivel_Retirados"
$aReplaceBy{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel>Nivel_Retirados"


  //cambios en búsquedas [xxSTR_Materias]Observaciones’NumeroNivel <
$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel<Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel<Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel<Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel<Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel<-3"
$aReplaceBy{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel<Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel<-2"
$aReplaceBy{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel<-3"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel<-1"
$aReplaceBy{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel<-2"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel<Nivel_Egresados"
$aReplaceBy{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel<Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel<Nivel_Retirados"
$aReplaceBy{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel<Nivel_Retirados"



  //==================================================
  //[Alumnos_Histórico]Nivel
  //==================================================

  //cambios en búsquedas [Alumnos_Histórico]Nivel >=
$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_Histórico]Nivel>=Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[Alumnos_Histórico]Nivel>=Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_Histórico]Nivel>=Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[Alumnos_Histórico]Nivel>=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_Histórico]Nivel>=-3"
$aReplaceBy{$element}:="[Alumnos_Histórico]Nivel>=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_Histórico]Nivel>=-2"
$aReplaceBy{$element}:="[Alumnos_Histórico]Nivel>=-3"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_Histórico]Nivel>=-1"
$aReplaceBy{$element}:="[Alumnos_Histórico]Nivel>=-2"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_Histórico]Nivel>=Nivel_Egresados"
$aReplaceBy{$element}:="[Alumnos_Histórico]Nivel>=Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_Histórico]Nivel>=Nivel_Retirados"
$aReplaceBy{$element}:="[Alumnos_Histórico]Nivel>=Nivel_Retirados"


  //cambios en búsquedas [Alumnos_Histórico]Nivel <=
$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_Histórico]Nivel<=Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[Alumnos_Histórico]Nivel<=Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_Histórico]Nivel<=Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[Alumnos_Histórico]Nivel<=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_Histórico]Nivel<=-3"
$aReplaceBy{$element}:="[Alumnos_Histórico]Nivel<=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_Histórico]Nivel<=-2"
$aReplaceBy{$element}:="[Alumnos_Histórico]Nivel<=-3"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_Histórico]Nivel<=-1"
$aReplaceBy{$element}:="[Alumnos_Histórico]Nivel<=-2"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_Histórico]Nivel<=Nivel_Egresados"
$aReplaceBy{$element}:="[Alumnos_Histórico]Nivel<=Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_Histórico]Nivel<=Nivel_Retirados"
$aReplaceBy{$element}:="[Alumnos_Histórico]Nivel<=Nivel_Retirados"



  //cambios en búsquedas [Alumnos_Histórico]Nivel =
$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_Histórico]Nivel=Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[Alumnos_Histórico]Nivel=Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_Histórico]Nivel=Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[Alumnos_Histórico]Nivel=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_Histórico]Nivel=-3"
$aReplaceBy{$element}:="[Alumnos_Histórico]Nivel=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_Histórico]Nivel=-2"
$aReplaceBy{$element}:="[Alumnos_Histórico]Nivel=-3"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_Histórico]Nivel=-1"
$aReplaceBy{$element}:="[Alumnos_Histórico]Nivel=-2"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_Histórico]Nivel=Nivel_Egresados"
$aReplaceBy{$element}:="[Alumnos_Histórico]Nivel=Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_Histórico]Nivel=Nivel_Retirados"
$aReplaceBy{$element}:="[Alumnos_Histórico]Nivel=Nivel_Retirados"


  //cambios en búsquedas [Alumnos_Histórico]Nivel >
$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_Histórico]Nivel>Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[Alumnos_Histórico]Nivel>Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_Histórico]Nivel>Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[Alumnos_Histórico]Nivel>Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_Histórico]Nivel>-3"
$aReplaceBy{$element}:="[Alumnos_Histórico]Nivel>Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_Histórico]Nivel>-2"
$aReplaceBy{$element}:="[Alumnos_Histórico]Nivel>-3"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_Histórico]Nivel>-1"
$aReplaceBy{$element}:="[Alumnos_Histórico]Nivel>-2"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_Histórico]Nivel>Nivel_Egresados"
$aReplaceBy{$element}:="[Alumnos_Histórico]Nivel>Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_Histórico]Nivel>Nivel_Retirados"
$aReplaceBy{$element}:="[Alumnos_Histórico]Nivel>Nivel_Retirados"


  //cambios en búsquedas [Alumnos_Histórico]Nivel <
$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_Histórico]Nivel<Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[Alumnos_Histórico]Nivel<Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_Histórico]Nivel<Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[Alumnos_Histórico]Nivel<Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_Histórico]Nivel<-3"
$aReplaceBy{$element}:="[Alumnos_Histórico]Nivel<Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_Histórico]Nivel<-2"
$aReplaceBy{$element}:="[Alumnos_Histórico]Nivel<-3"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_Histórico]Nivel<-1"
$aReplaceBy{$element}:="[Alumnos_Histórico]Nivel<-2"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_Histórico]Nivel<Nivel_Egresados"
$aReplaceBy{$element}:="[Alumnos_Histórico]Nivel<Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_Histórico]Nivel<Nivel_Retirados"
$aReplaceBy{$element}:="[Alumnos_Histórico]Nivel<Nivel_Retirados"



  //==================================================
  //[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel
  //==================================================

  //cambios en búsquedas [Alumnos_FichaMedica]Aparatos_Protesis'NoNivel >=
$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel>=Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel>=Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel>=Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel>=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel>=-3"
$aReplaceBy{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel>=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel>=-2"
$aReplaceBy{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel>=-3"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel>=-1"
$aReplaceBy{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel>=-2"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel>=Nivel_Egresados"
$aReplaceBy{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel>=Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel>=Nivel_Retirados"
$aReplaceBy{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel>=Nivel_Retirados"


  //cambios en búsquedas [Alumnos_FichaMedica]Aparatos_Protesis'NoNivel <=
$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel<=Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel<=Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel<=Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel<=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel<=-3"
$aReplaceBy{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel<=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel<=-2"
$aReplaceBy{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel<=-3"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel<=-1"
$aReplaceBy{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel<=-2"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel<=Nivel_Egresados"
$aReplaceBy{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel<=Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel<=Nivel_Retirados"
$aReplaceBy{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel<=Nivel_Retirados"



  //cambios en búsquedas [Alumnos_FichaMedica]Aparatos_Protesis'NoNivel =
$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel=Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel=Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel=Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel=-3"
$aReplaceBy{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel=-2"
$aReplaceBy{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel=-3"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel=-1"
$aReplaceBy{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel=-2"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel=Nivel_Egresados"
$aReplaceBy{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel=Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel=Nivel_Retirados"
$aReplaceBy{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel=Nivel_Retirados"


  //cambios en búsquedas [Alumnos_FichaMedica]Aparatos_Protesis'NoNivel >
$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel>Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel>Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel>Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel>Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel>-3"
$aReplaceBy{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel>Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel>-2"
$aReplaceBy{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel>-3"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel>-1"
$aReplaceBy{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel>-2"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel>Nivel_Egresados"
$aReplaceBy{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel>Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel>Nivel_Retirados"
$aReplaceBy{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel>Nivel_Retirados"


  //cambios en búsquedas [Alumnos_FichaMedica]Aparatos_Protesis'NoNivel <
$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel<Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel<Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel<Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel<Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel<-3"
$aReplaceBy{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel<Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel<-2"
$aReplaceBy{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel<-3"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel<-1"
$aReplaceBy{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel<-2"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel<Nivel_Egresados"
$aReplaceBy{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel<Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel<Nivel_Retirados"
$aReplaceBy{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel<Nivel_Retirados"



  //==================================================
  //[Actividades]Desde_NumeroNivel
  //==================================================

  //cambios en búsquedas [Actividades]Desde_NumeroNivel >=
$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Desde_NumeroNivel>=Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[Actividades]Desde_NumeroNivel>=Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Desde_NumeroNivel>=Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[Actividades]Desde_NumeroNivel>=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Desde_NumeroNivel>=-3"
$aReplaceBy{$element}:="[Actividades]Desde_NumeroNivel>=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Desde_NumeroNivel>=-2"
$aReplaceBy{$element}:="[Actividades]Desde_NumeroNivel>=-3"

$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Desde_NumeroNivel>=-1"
$aReplaceBy{$element}:="[Actividades]Desde_NumeroNivel>=-2"

$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Desde_NumeroNivel>=Nivel_Egresados"
$aReplaceBy{$element}:="[Actividades]Desde_NumeroNivel>=Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Desde_NumeroNivel>=Nivel_Retirados"
$aReplaceBy{$element}:="[Actividades]Desde_NumeroNivel>=Nivel_Retirados"


  //cambios en búsquedas [Actividades]Desde_NumeroNivel <=
$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Desde_NumeroNivel<=Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[Actividades]Desde_NumeroNivel<=Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Desde_NumeroNivel<=Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[Actividades]Desde_NumeroNivel<=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Desde_NumeroNivel<=-3"
$aReplaceBy{$element}:="[Actividades]Desde_NumeroNivel<=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Desde_NumeroNivel<=-2"
$aReplaceBy{$element}:="[Actividades]Desde_NumeroNivel<=-3"

$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Desde_NumeroNivel<=-1"
$aReplaceBy{$element}:="[Actividades]Desde_NumeroNivel<=-2"

$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Desde_NumeroNivel<=Nivel_Egresados"
$aReplaceBy{$element}:="[Actividades]Desde_NumeroNivel<=Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Desde_NumeroNivel<=Nivel_Retirados"
$aReplaceBy{$element}:="[Actividades]Desde_NumeroNivel<=Nivel_Retirados"



  //cambios en búsquedas [Actividades]Desde_NumeroNivel =
$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Desde_NumeroNivel=Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[Actividades]Desde_NumeroNivel=Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Desde_NumeroNivel=Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[Actividades]Desde_NumeroNivel=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Desde_NumeroNivel=-3"
$aReplaceBy{$element}:="[Actividades]Desde_NumeroNivel=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Desde_NumeroNivel=-2"
$aReplaceBy{$element}:="[Actividades]Desde_NumeroNivel=-3"

$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Desde_NumeroNivel=-1"
$aReplaceBy{$element}:="[Actividades]Desde_NumeroNivel=-2"

$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Desde_NumeroNivel=Nivel_Egresados"
$aReplaceBy{$element}:="[Actividades]Desde_NumeroNivel=Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Desde_NumeroNivel=Nivel_Retirados"
$aReplaceBy{$element}:="[Actividades]Desde_NumeroNivel=Nivel_Retirados"


  //cambios en búsquedas [Actividades]Desde_NumeroNivel >
$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Desde_NumeroNivel>Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[Actividades]Desde_NumeroNivel>Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Desde_NumeroNivel>Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[Actividades]Desde_NumeroNivel>Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Desde_NumeroNivel>-3"
$aReplaceBy{$element}:="[Actividades]Desde_NumeroNivel>Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Desde_NumeroNivel>-2"
$aReplaceBy{$element}:="[Actividades]Desde_NumeroNivel>-3"

$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Desde_NumeroNivel>-1"
$aReplaceBy{$element}:="[Actividades]Desde_NumeroNivel>-2"

$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Desde_NumeroNivel>Nivel_Egresados"
$aReplaceBy{$element}:="[Actividades]Desde_NumeroNivel>Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Desde_NumeroNivel>Nivel_Retirados"
$aReplaceBy{$element}:="[Actividades]Desde_NumeroNivel>Nivel_Retirados"


  //cambios en búsquedas [Actividades]Desde_NumeroNivel <
$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Desde_NumeroNivel<Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[Actividades]Desde_NumeroNivel<Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Desde_NumeroNivel<Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[Actividades]Desde_NumeroNivel<Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Desde_NumeroNivel<-3"
$aReplaceBy{$element}:="[Actividades]Desde_NumeroNivel<Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Desde_NumeroNivel<-2"
$aReplaceBy{$element}:="[Actividades]Desde_NumeroNivel<-3"

$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Desde_NumeroNivel<-1"
$aReplaceBy{$element}:="[Actividades]Desde_NumeroNivel<-2"

$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Desde_NumeroNivel<Nivel_Egresados"
$aReplaceBy{$element}:="[Actividades]Desde_NumeroNivel<Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Desde_NumeroNivel<Nivel_Retirados"
$aReplaceBy{$element}:="[Actividades]Desde_NumeroNivel<Nivel_Retirados"



  //==================================================
  //[Actividades]Hasta_NumeroNivel
  //==================================================

  //cambios en búsquedas [Actividades]Hasta_NumeroNivel >=
$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Hasta_NumeroNivel>=Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[Actividades]Hasta_NumeroNivel>=Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Hasta_NumeroNivel>=Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[Actividades]Hasta_NumeroNivel>=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Hasta_NumeroNivel>=-3"
$aReplaceBy{$element}:="[Actividades]Hasta_NumeroNivel>=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Hasta_NumeroNivel>=-2"
$aReplaceBy{$element}:="[Actividades]Hasta_NumeroNivel>=-3"

$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Hasta_NumeroNivel>=-1"
$aReplaceBy{$element}:="[Actividades]Hasta_NumeroNivel>=-2"

$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Hasta_NumeroNivel>=Nivel_Egresados"
$aReplaceBy{$element}:="[Actividades]Hasta_NumeroNivel>=Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Hasta_NumeroNivel>=Nivel_Retirados"
$aReplaceBy{$element}:="[Actividades]Hasta_NumeroNivel>=Nivel_Retirados"


  //cambios en búsquedas [Actividades]Hasta_NumeroNivel <=
$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Hasta_NumeroNivel<=Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[Actividades]Hasta_NumeroNivel<=Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Hasta_NumeroNivel<=Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[Actividades]Hasta_NumeroNivel<=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Hasta_NumeroNivel<=-3"
$aReplaceBy{$element}:="[Actividades]Hasta_NumeroNivel<=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Hasta_NumeroNivel<=-2"
$aReplaceBy{$element}:="[Actividades]Hasta_NumeroNivel<=-3"

$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Hasta_NumeroNivel<=-1"
$aReplaceBy{$element}:="[Actividades]Hasta_NumeroNivel<=-2"

$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Hasta_NumeroNivel<=Nivel_Egresados"
$aReplaceBy{$element}:="[Actividades]Hasta_NumeroNivel<=Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Hasta_NumeroNivel<=Nivel_Retirados"
$aReplaceBy{$element}:="[Actividades]Hasta_NumeroNivel<=Nivel_Retirados"



  //cambios en búsquedas [Actividades]Hasta_NumeroNivel =
$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Hasta_NumeroNivel=Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[Actividades]Hasta_NumeroNivel=Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Hasta_NumeroNivel=Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[Actividades]Hasta_NumeroNivel=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Hasta_NumeroNivel=-3"
$aReplaceBy{$element}:="[Actividades]Hasta_NumeroNivel=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Hasta_NumeroNivel=-2"
$aReplaceBy{$element}:="[Actividades]Hasta_NumeroNivel=-3"

$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Hasta_NumeroNivel=-1"
$aReplaceBy{$element}:="[Actividades]Hasta_NumeroNivel=-2"

$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Hasta_NumeroNivel=Nivel_Egresados"
$aReplaceBy{$element}:="[Actividades]Hasta_NumeroNivel=Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Hasta_NumeroNivel=Nivel_Retirados"
$aReplaceBy{$element}:="[Actividades]Hasta_NumeroNivel=Nivel_Retirados"


  //cambios en búsquedas [Actividades]Hasta_NumeroNivel >
$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Hasta_NumeroNivel>Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[Actividades]Hasta_NumeroNivel>Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Hasta_NumeroNivel>Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[Actividades]Hasta_NumeroNivel>Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Hasta_NumeroNivel>-3"
$aReplaceBy{$element}:="[Actividades]Hasta_NumeroNivel>Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Hasta_NumeroNivel>-2"
$aReplaceBy{$element}:="[Actividades]Hasta_NumeroNivel>-3"

$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Hasta_NumeroNivel>-1"
$aReplaceBy{$element}:="[Actividades]Hasta_NumeroNivel>-2"

$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Hasta_NumeroNivel>Nivel_Egresados"
$aReplaceBy{$element}:="[Actividades]Hasta_NumeroNivel>Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Hasta_NumeroNivel>Nivel_Retirados"
$aReplaceBy{$element}:="[Actividades]Hasta_NumeroNivel>Nivel_Retirados"


  //cambios en búsquedas [Actividades]Hasta_NumeroNivel <
$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Hasta_NumeroNivel<Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[Actividades]Hasta_NumeroNivel<Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Hasta_NumeroNivel<Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[Actividades]Hasta_NumeroNivel<Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Hasta_NumeroNivel<-3"
$aReplaceBy{$element}:="[Actividades]Hasta_NumeroNivel<Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Hasta_NumeroNivel<-2"
$aReplaceBy{$element}:="[Actividades]Hasta_NumeroNivel<-3"

$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Hasta_NumeroNivel<-1"
$aReplaceBy{$element}:="[Actividades]Hasta_NumeroNivel<-2"

$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Hasta_NumeroNivel<Nivel_Egresados"
$aReplaceBy{$element}:="[Actividades]Hasta_NumeroNivel<Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Hasta_NumeroNivel<Nivel_Retirados"
$aReplaceBy{$element}:="[Actividades]Hasta_NumeroNivel<Nivel_Retirados"



  //==================================================
  //[xxSTR_MatrizDeDestrezas]No_Nivel
  //==================================================

  //cambios en búsquedas [xxSTR_MatrizDeDestrezas]No_Nivel >=
$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel>=Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel>=Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel>=Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel>=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel>=-3"
$aReplaceBy{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel>=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel>=-2"
$aReplaceBy{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel>=-3"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel>=-1"
$aReplaceBy{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel>=-2"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel>=Nivel_Egresados"
$aReplaceBy{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel>=Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel>=Nivel_Retirados"
$aReplaceBy{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel>=Nivel_Retirados"


  //cambios en búsquedas [xxSTR_MatrizDeDestrezas]No_Nivel <=
$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel<=Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel<=Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel<=Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel<=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel<=-3"
$aReplaceBy{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel<=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel<=-2"
$aReplaceBy{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel<=-3"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel<=-1"
$aReplaceBy{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel<=-2"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel<=Nivel_Egresados"
$aReplaceBy{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel<=Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel<=Nivel_Retirados"
$aReplaceBy{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel<=Nivel_Retirados"



  //cambios en búsquedas [xxSTR_MatrizDeDestrezas]No_Nivel =
$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel=Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel=Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel=Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel=-3"
$aReplaceBy{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel=-2"
$aReplaceBy{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel=-3"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel=-1"
$aReplaceBy{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel=-2"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel=Nivel_Egresados"
$aReplaceBy{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel=Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel=Nivel_Retirados"
$aReplaceBy{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel=Nivel_Retirados"


  //cambios en búsquedas [xxSTR_MatrizDeDestrezas]No_Nivel >
$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel>Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel>Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel>Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel>Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel>-3"
$aReplaceBy{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel>Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel>-2"
$aReplaceBy{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel>-3"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel>-1"
$aReplaceBy{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel>-2"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel>Nivel_Egresados"
$aReplaceBy{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel>Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel>Nivel_Retirados"
$aReplaceBy{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel>Nivel_Retirados"


  //cambios en búsquedas [xxSTR_MatrizDeDestrezas]No_Nivel <
$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel<Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel<Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel<Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel<Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel<-3"
$aReplaceBy{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel<Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel<-2"
$aReplaceBy{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel<-3"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel<-1"
$aReplaceBy{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel<-2"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel<Nivel_Egresados"
$aReplaceBy{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel<Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel<Nivel_Retirados"
$aReplaceBy{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel<Nivel_Retirados"



  //==================================================
  //[Asignaturas_Historico]Nivel
  //==================================================

  //cambios en búsquedas [Asignaturas_Historico]Nivel >=
$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Historico]Nivel>=Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[Asignaturas_Historico]Nivel>=Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Historico]Nivel>=Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[Asignaturas_Historico]Nivel>=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Historico]Nivel>=-3"
$aReplaceBy{$element}:="[Asignaturas_Historico]Nivel>=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Historico]Nivel>=-2"
$aReplaceBy{$element}:="[Asignaturas_Historico]Nivel>=-3"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Historico]Nivel>=-1"
$aReplaceBy{$element}:="[Asignaturas_Historico]Nivel>=-2"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Historico]Nivel>=Nivel_Egresados"
$aReplaceBy{$element}:="[Asignaturas_Historico]Nivel>=Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Historico]Nivel>=Nivel_Retirados"
$aReplaceBy{$element}:="[Asignaturas_Historico]Nivel>=Nivel_Retirados"


  //cambios en búsquedas [Asignaturas_Historico]Nivel <=
$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Historico]Nivel<=Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[Asignaturas_Historico]Nivel<=Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Historico]Nivel<=Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[Asignaturas_Historico]Nivel<=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Historico]Nivel<=-3"
$aReplaceBy{$element}:="[Asignaturas_Historico]Nivel<=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Historico]Nivel<=-2"
$aReplaceBy{$element}:="[Asignaturas_Historico]Nivel<=-3"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Historico]Nivel<=-1"
$aReplaceBy{$element}:="[Asignaturas_Historico]Nivel<=-2"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Historico]Nivel<=Nivel_Egresados"
$aReplaceBy{$element}:="[Asignaturas_Historico]Nivel<=Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Historico]Nivel<=Nivel_Retirados"
$aReplaceBy{$element}:="[Asignaturas_Historico]Nivel<=Nivel_Retirados"



  //cambios en búsquedas [Asignaturas_Historico]Nivel =
$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Historico]Nivel=Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[Asignaturas_Historico]Nivel=Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Historico]Nivel=Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[Asignaturas_Historico]Nivel=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Historico]Nivel=-3"
$aReplaceBy{$element}:="[Asignaturas_Historico]Nivel=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Historico]Nivel=-2"
$aReplaceBy{$element}:="[Asignaturas_Historico]Nivel=-3"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Historico]Nivel=-1"
$aReplaceBy{$element}:="[Asignaturas_Historico]Nivel=-2"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Historico]Nivel=Nivel_Egresados"
$aReplaceBy{$element}:="[Asignaturas_Historico]Nivel=Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Historico]Nivel=Nivel_Retirados"
$aReplaceBy{$element}:="[Asignaturas_Historico]Nivel=Nivel_Retirados"


  //cambios en búsquedas [Asignaturas_Historico]Nivel >
$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Historico]Nivel>Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[Asignaturas_Historico]Nivel>Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Historico]Nivel>Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[Asignaturas_Historico]Nivel>Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Historico]Nivel>-3"
$aReplaceBy{$element}:="[Asignaturas_Historico]Nivel>Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Historico]Nivel>-2"
$aReplaceBy{$element}:="[Asignaturas_Historico]Nivel>-3"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Historico]Nivel>-1"
$aReplaceBy{$element}:="[Asignaturas_Historico]Nivel>-2"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Historico]Nivel>Nivel_Egresados"
$aReplaceBy{$element}:="[Asignaturas_Historico]Nivel>Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Historico]Nivel>Nivel_Retirados"
$aReplaceBy{$element}:="[Asignaturas_Historico]Nivel>Nivel_Retirados"


  //cambios en búsquedas [Asignaturas_Historico]Nivel <
$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Historico]Nivel<Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[Asignaturas_Historico]Nivel<Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Historico]Nivel<Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[Asignaturas_Historico]Nivel<Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Historico]Nivel<-3"
$aReplaceBy{$element}:="[Asignaturas_Historico]Nivel<Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Historico]Nivel<-2"
$aReplaceBy{$element}:="[Asignaturas_Historico]Nivel<-3"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Historico]Nivel<-1"
$aReplaceBy{$element}:="[Asignaturas_Historico]Nivel<-2"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Historico]Nivel<Nivel_Egresados"
$aReplaceBy{$element}:="[Asignaturas_Historico]Nivel<Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Historico]Nivel<Nivel_Retirados"
$aReplaceBy{$element}:="[Asignaturas_Historico]Nivel<Nivel_Retirados"




  //==================================================
  //[Asignaturas_Objetivos]Nivel_numero
  //==================================================

  //cambios en búsquedas [Asignaturas_Objetivos]Nivel_numero >=
$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Objetivos]Nivel_numero>=Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[Asignaturas_Objetivos]Nivel_numero>=Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Objetivos]Nivel_numero>=Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[Asignaturas_Objetivos]Nivel_numero>=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Objetivos]Nivel_numero>=-3"
$aReplaceBy{$element}:="[Asignaturas_Objetivos]Nivel_numero>=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Objetivos]Nivel_numero>=-2"
$aReplaceBy{$element}:="[Asignaturas_Objetivos]Nivel_numero>=-3"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Objetivos]Nivel_numero>=-1"
$aReplaceBy{$element}:="[Asignaturas_Objetivos]Nivel_numero>=-2"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Objetivos]Nivel_numero>=Nivel_Egresados"
$aReplaceBy{$element}:="[Asignaturas_Objetivos]Nivel_numero>=Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Objetivos]Nivel_numero>=Nivel_Retirados"
$aReplaceBy{$element}:="[Asignaturas_Objetivos]Nivel_numero>=Nivel_Retirados"


  //cambios en búsquedas [Asignaturas_Objetivos]Nivel_numero <=
$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Objetivos]Nivel_numero<=Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[Asignaturas_Objetivos]Nivel_numero<=Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Objetivos]Nivel_numero<=Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[Asignaturas_Objetivos]Nivel_numero<=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Objetivos]Nivel_numero<=-3"
$aReplaceBy{$element}:="[Asignaturas_Objetivos]Nivel_numero<=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Objetivos]Nivel_numero<=-2"
$aReplaceBy{$element}:="[Asignaturas_Objetivos]Nivel_numero<=-3"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Objetivos]Nivel_numero<=-1"
$aReplaceBy{$element}:="[Asignaturas_Objetivos]Nivel_numero<=-2"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Objetivos]Nivel_numero<=Nivel_Egresados"
$aReplaceBy{$element}:="[Asignaturas_Objetivos]Nivel_numero<=Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Objetivos]Nivel_numero<=Nivel_Retirados"
$aReplaceBy{$element}:="[Asignaturas_Objetivos]Nivel_numero<=Nivel_Retirados"



  //cambios en búsquedas [Asignaturas_Objetivos]Nivel_numero =
$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Objetivos]Nivel_numero=Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[Asignaturas_Objetivos]Nivel_numero=Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Objetivos]Nivel_numero=Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[Asignaturas_Objetivos]Nivel_numero=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Objetivos]Nivel_numero=-3"
$aReplaceBy{$element}:="[Asignaturas_Objetivos]Nivel_numero=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Objetivos]Nivel_numero=-2"
$aReplaceBy{$element}:="[Asignaturas_Objetivos]Nivel_numero=-3"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Objetivos]Nivel_numero=-1"
$aReplaceBy{$element}:="[Asignaturas_Objetivos]Nivel_numero=-2"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Objetivos]Nivel_numero=Nivel_Egresados"
$aReplaceBy{$element}:="[Asignaturas_Objetivos]Nivel_numero=Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Objetivos]Nivel_numero=Nivel_Retirados"
$aReplaceBy{$element}:="[Asignaturas_Objetivos]Nivel_numero=Nivel_Retirados"


  //cambios en búsquedas [Asignaturas_Objetivos]Nivel_numero >
$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Objetivos]Nivel_numero>Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[Asignaturas_Objetivos]Nivel_numero>Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Objetivos]Nivel_numero>Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[Asignaturas_Objetivos]Nivel_numero>Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Objetivos]Nivel_numero>-3"
$aReplaceBy{$element}:="[Asignaturas_Objetivos]Nivel_numero>Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Objetivos]Nivel_numero>-2"
$aReplaceBy{$element}:="[Asignaturas_Objetivos]Nivel_numero>-3"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Objetivos]Nivel_numero>-1"
$aReplaceBy{$element}:="[Asignaturas_Objetivos]Nivel_numero>-2"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Objetivos]Nivel_numero>Nivel_Egresados"
$aReplaceBy{$element}:="[Asignaturas_Objetivos]Nivel_numero>Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Objetivos]Nivel_numero>Nivel_Retirados"
$aReplaceBy{$element}:="[Asignaturas_Objetivos]Nivel_numero>Nivel_Retirados"


  //cambios en búsquedas [Asignaturas_Objetivos]Nivel_numero <
$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Objetivos]Nivel_numero<Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[Asignaturas_Objetivos]Nivel_numero<Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Objetivos]Nivel_numero<Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[Asignaturas_Objetivos]Nivel_numero<Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Objetivos]Nivel_numero<-3"
$aReplaceBy{$element}:="[Asignaturas_Objetivos]Nivel_numero<Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Objetivos]Nivel_numero<-2"
$aReplaceBy{$element}:="[Asignaturas_Objetivos]Nivel_numero<-3"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Objetivos]Nivel_numero<-1"
$aReplaceBy{$element}:="[Asignaturas_Objetivos]Nivel_numero<-2"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Objetivos]Nivel_numero<Nivel_Egresados"
$aReplaceBy{$element}:="[Asignaturas_Objetivos]Nivel_numero<Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Objetivos]Nivel_numero<Nivel_Retirados"
$aReplaceBy{$element}:="[Asignaturas_Objetivos]Nivel_numero<Nivel_Retirados"



  //==================================================
  //[TMT_Horario]Nivel
  //==================================================

  //cambios en búsquedas [TMT_Horario]Nivel >=
$element:=AT_Inc 
$aString2Replace{$element}:="[TMT_Horario]Nivel>=Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[TMT_Horario]Nivel>=Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[TMT_Horario]Nivel>=Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[TMT_Horario]Nivel>=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[TMT_Horario]Nivel>=-3"
$aReplaceBy{$element}:="[TMT_Horario]Nivel>=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[TMT_Horario]Nivel>=-2"
$aReplaceBy{$element}:="[TMT_Horario]Nivel>=-3"

$element:=AT_Inc 
$aString2Replace{$element}:="[TMT_Horario]Nivel>=-1"
$aReplaceBy{$element}:="[TMT_Horario]Nivel>=-2"

$element:=AT_Inc 
$aString2Replace{$element}:="[TMT_Horario]Nivel>=Nivel_Egresados"
$aReplaceBy{$element}:="[TMT_Horario]Nivel>=Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[TMT_Horario]Nivel>=Nivel_Retirados"
$aReplaceBy{$element}:="[TMT_Horario]Nivel>=Nivel_Retirados"


  //cambios en búsquedas [TMT_Horario]Nivel <=
$element:=AT_Inc 
$aString2Replace{$element}:="[TMT_Horario]Nivel<=Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[TMT_Horario]Nivel<=Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[TMT_Horario]Nivel<=Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[TMT_Horario]Nivel<=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[TMT_Horario]Nivel<=-3"
$aReplaceBy{$element}:="[TMT_Horario]Nivel<=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[TMT_Horario]Nivel<=-2"
$aReplaceBy{$element}:="[TMT_Horario]Nivel<=-3"

$element:=AT_Inc 
$aString2Replace{$element}:="[TMT_Horario]Nivel<=-1"
$aReplaceBy{$element}:="[TMT_Horario]Nivel<=-2"

$element:=AT_Inc 
$aString2Replace{$element}:="[TMT_Horario]Nivel<=Nivel_Egresados"
$aReplaceBy{$element}:="[TMT_Horario]Nivel<=Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[TMT_Horario]Nivel<=Nivel_Retirados"
$aReplaceBy{$element}:="[TMT_Horario]Nivel<=Nivel_Retirados"



  //cambios en búsquedas [TMT_Horario]Nivel =
$element:=AT_Inc 
$aString2Replace{$element}:="[TMT_Horario]Nivel=Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[TMT_Horario]Nivel=Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[TMT_Horario]Nivel=Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[TMT_Horario]Nivel=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[TMT_Horario]Nivel=-3"
$aReplaceBy{$element}:="[TMT_Horario]Nivel=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[TMT_Horario]Nivel=-2"
$aReplaceBy{$element}:="[TMT_Horario]Nivel=-3"

$element:=AT_Inc 
$aString2Replace{$element}:="[TMT_Horario]Nivel=-1"
$aReplaceBy{$element}:="[TMT_Horario]Nivel=-2"

$element:=AT_Inc 
$aString2Replace{$element}:="[TMT_Horario]Nivel=Nivel_Egresados"
$aReplaceBy{$element}:="[TMT_Horario]Nivel=Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[TMT_Horario]Nivel=Nivel_Retirados"
$aReplaceBy{$element}:="[TMT_Horario]Nivel=Nivel_Retirados"


  //cambios en búsquedas [TMT_Horario]Nivel >
$element:=AT_Inc 
$aString2Replace{$element}:="[TMT_Horario]Nivel>Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[TMT_Horario]Nivel>Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[TMT_Horario]Nivel>Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[TMT_Horario]Nivel>Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[TMT_Horario]Nivel>-3"
$aReplaceBy{$element}:="[TMT_Horario]Nivel>Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[TMT_Horario]Nivel>-2"
$aReplaceBy{$element}:="[TMT_Horario]Nivel>-3"

$element:=AT_Inc 
$aString2Replace{$element}:="[TMT_Horario]Nivel>-1"
$aReplaceBy{$element}:="[TMT_Horario]Nivel>-2"

$element:=AT_Inc 
$aString2Replace{$element}:="[TMT_Horario]Nivel>Nivel_Egresados"
$aReplaceBy{$element}:="[TMT_Horario]Nivel>Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[TMT_Horario]Nivel>Nivel_Retirados"
$aReplaceBy{$element}:="[TMT_Horario]Nivel>Nivel_Retirados"


  //cambios en búsquedas [TMT_Horario]Nivel <
$element:=AT_Inc 
$aString2Replace{$element}:="[TMT_Horario]Nivel<Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[TMT_Horario]Nivel<Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[TMT_Horario]Nivel<Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[TMT_Horario]Nivel<Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[TMT_Horario]Nivel<-3"
$aReplaceBy{$element}:="[TMT_Horario]Nivel<Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[TMT_Horario]Nivel<-2"
$aReplaceBy{$element}:="[TMT_Horario]Nivel<-3"

$element:=AT_Inc 
$aString2Replace{$element}:="[TMT_Horario]Nivel<-1"
$aReplaceBy{$element}:="[TMT_Horario]Nivel<-2"

$element:=AT_Inc 
$aString2Replace{$element}:="[TMT_Horario]Nivel<Nivel_Egresados"
$aReplaceBy{$element}:="[TMT_Horario]Nivel<Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[TMT_Horario]Nivel<Nivel_Retirados"
$aReplaceBy{$element}:="[TMT_Horario]Nivel<Nivel_Retirados"



  //==================================================
  //[MPA_AsignaturasMatrices]NumeroNivel
  //==================================================

  //cambios en búsquedas [MPA_AsignaturasMatrices]NumeroNivel >=
$element:=AT_Inc 
$aString2Replace{$element}:="[MPA_AsignaturasMatrices]NumeroNivel>=Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[MPA_AsignaturasMatrices]NumeroNivel>=Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[MPA_AsignaturasMatrices]NumeroNivel>=Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[MPA_AsignaturasMatrices]NumeroNivel>=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[MPA_AsignaturasMatrices]NumeroNivel>=-3"
$aReplaceBy{$element}:="[MPA_AsignaturasMatrices]NumeroNivel>=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[MPA_AsignaturasMatrices]NumeroNivel>=-2"
$aReplaceBy{$element}:="[MPA_AsignaturasMatrices]NumeroNivel>=-3"

$element:=AT_Inc 
$aString2Replace{$element}:="[MPA_AsignaturasMatrices]NumeroNivel>=-1"
$aReplaceBy{$element}:="[MPA_AsignaturasMatrices]NumeroNivel>=-2"

$element:=AT_Inc 
$aString2Replace{$element}:="[MPA_AsignaturasMatrices]NumeroNivel>=Nivel_Egresados"
$aReplaceBy{$element}:="[MPA_AsignaturasMatrices]NumeroNivel>=Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[MPA_AsignaturasMatrices]NumeroNivel>=Nivel_Retirados"
$aReplaceBy{$element}:="[MPA_AsignaturasMatrices]NumeroNivel>=Nivel_Retirados"


  //cambios en búsquedas [MPA_AsignaturasMatrices]NumeroNivel <=
$element:=AT_Inc 
$aString2Replace{$element}:="[MPA_AsignaturasMatrices]NumeroNivel<=Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[MPA_AsignaturasMatrices]NumeroNivel<=Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[MPA_AsignaturasMatrices]NumeroNivel<=Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[MPA_AsignaturasMatrices]NumeroNivel<=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[MPA_AsignaturasMatrices]NumeroNivel<=-3"
$aReplaceBy{$element}:="[MPA_AsignaturasMatrices]NumeroNivel<=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[MPA_AsignaturasMatrices]NumeroNivel<=-2"
$aReplaceBy{$element}:="[MPA_AsignaturasMatrices]NumeroNivel<=-3"

$element:=AT_Inc 
$aString2Replace{$element}:="[MPA_AsignaturasMatrices]NumeroNivel<=-1"
$aReplaceBy{$element}:="[MPA_AsignaturasMatrices]NumeroNivel<=-2"

$element:=AT_Inc 
$aString2Replace{$element}:="[MPA_AsignaturasMatrices]NumeroNivel<=Nivel_Egresados"
$aReplaceBy{$element}:="[MPA_AsignaturasMatrices]NumeroNivel<=Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[MPA_AsignaturasMatrices]NumeroNivel<=Nivel_Retirados"
$aReplaceBy{$element}:="[MPA_AsignaturasMatrices]NumeroNivel<=Nivel_Retirados"



  //cambios en búsquedas [MPA_AsignaturasMatrices]NumeroNivel =
$element:=AT_Inc 
$aString2Replace{$element}:="[MPA_AsignaturasMatrices]NumeroNivel=Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[MPA_AsignaturasMatrices]NumeroNivel=Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[MPA_AsignaturasMatrices]NumeroNivel=Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[MPA_AsignaturasMatrices]NumeroNivel=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[MPA_AsignaturasMatrices]NumeroNivel=-3"
$aReplaceBy{$element}:="[MPA_AsignaturasMatrices]NumeroNivel=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[MPA_AsignaturasMatrices]NumeroNivel=-2"
$aReplaceBy{$element}:="[MPA_AsignaturasMatrices]NumeroNivel=-3"

$element:=AT_Inc 
$aString2Replace{$element}:="[MPA_AsignaturasMatrices]NumeroNivel=-1"
$aReplaceBy{$element}:="[MPA_AsignaturasMatrices]NumeroNivel=-2"

$element:=AT_Inc 
$aString2Replace{$element}:="[MPA_AsignaturasMatrices]NumeroNivel=Nivel_Egresados"
$aReplaceBy{$element}:="[MPA_AsignaturasMatrices]NumeroNivel=Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[MPA_AsignaturasMatrices]NumeroNivel=Nivel_Retirados"
$aReplaceBy{$element}:="[MPA_AsignaturasMatrices]NumeroNivel=Nivel_Retirados"


  //cambios en búsquedas [MPA_AsignaturasMatrices]NumeroNivel >
$element:=AT_Inc 
$aString2Replace{$element}:="[MPA_AsignaturasMatrices]NumeroNivel>Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[MPA_AsignaturasMatrices]NumeroNivel>Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[MPA_AsignaturasMatrices]NumeroNivel>Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[MPA_AsignaturasMatrices]NumeroNivel>Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[MPA_AsignaturasMatrices]NumeroNivel>-3"
$aReplaceBy{$element}:="[MPA_AsignaturasMatrices]NumeroNivel>Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[MPA_AsignaturasMatrices]NumeroNivel>-2"
$aReplaceBy{$element}:="[MPA_AsignaturasMatrices]NumeroNivel>-3"

$element:=AT_Inc 
$aString2Replace{$element}:="[MPA_AsignaturasMatrices]NumeroNivel>-1"
$aReplaceBy{$element}:="[MPA_AsignaturasMatrices]NumeroNivel>-2"

$element:=AT_Inc 
$aString2Replace{$element}:="[MPA_AsignaturasMatrices]NumeroNivel>Nivel_Egresados"
$aReplaceBy{$element}:="[MPA_AsignaturasMatrices]NumeroNivel>Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[MPA_AsignaturasMatrices]NumeroNivel>Nivel_Retirados"
$aReplaceBy{$element}:="[MPA_AsignaturasMatrices]NumeroNivel>Nivel_Retirados"


  //cambios en búsquedas [MPA_AsignaturasMatrices]NumeroNivel <
$element:=AT_Inc 
$aString2Replace{$element}:="[MPA_AsignaturasMatrices]NumeroNivel<Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[MPA_AsignaturasMatrices]NumeroNivel<Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[MPA_AsignaturasMatrices]NumeroNivel<Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[MPA_AsignaturasMatrices]NumeroNivel<Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[MPA_AsignaturasMatrices]NumeroNivel<-3"
$aReplaceBy{$element}:="[MPA_AsignaturasMatrices]NumeroNivel<Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[MPA_AsignaturasMatrices]NumeroNivel<-2"
$aReplaceBy{$element}:="[MPA_AsignaturasMatrices]NumeroNivel<-3"

$element:=AT_Inc 
$aString2Replace{$element}:="[MPA_AsignaturasMatrices]NumeroNivel<-1"
$aReplaceBy{$element}:="[MPA_AsignaturasMatrices]NumeroNivel<-2"

$element:=AT_Inc 
$aString2Replace{$element}:="[MPA_AsignaturasMatrices]NumeroNivel<Nivel_Egresados"
$aReplaceBy{$element}:="[MPA_AsignaturasMatrices]NumeroNivel<Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[MPA_AsignaturasMatrices]NumeroNivel<Nivel_Retirados"
$aReplaceBy{$element}:="[MPA_AsignaturasMatrices]NumeroNivel<Nivel_Retirados"






  //**********************************************************************
  //**************             CAMBIOS EN LAS ASIGNACIONES                 ************** 
  //**********************************************************************


  //==================================================
  //[Alumnos]Nivel_Numero
  //==================================================

  //cambios en asignaciones [Alumnos]Nivel_Numero
$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]Nivel_Numero:=Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[Alumnos]Nivel_Numero:=Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]Nivel_Numero:=Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[Alumnos]Nivel_Numero:=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]Nivel_Numero:=Nivel_Egresados"
$aReplaceBy{$element}:="[Alumnos]Nivel_Numero:=Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]Nivel_Numero:=Nivel_Retirados"
$aReplaceBy{$element}:="[Alumnos]Nivel_Numero:=Nivel_Retirados"



  //==================================================
  //[Alumnos]NoNivel_alRetirarse
  //==================================================

  //cambios en asignaciones [Alumnos]NoNivel_alRetirarse
$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]NoNivel_alRetirarse:=Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[Alumnos]NoNivel_alRetirarse:=Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]NoNivel_alRetirarse:=Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[Alumnos]NoNivel_alRetirarse:=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]NoNivel_alRetirarse:=Nivel_Egresados"
$aReplaceBy{$element}:="[Alumnos]NoNivel_alRetirarse:=Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos]NoNivel_alRetirarse:=Nivel_Retirados"
$aReplaceBy{$element}:="[Alumnos]NoNivel_alRetirarse:=Nivel_Retirados"



  //==================================================
  //[Cursos]Nivel_Numero
  //==================================================

  //cambios en asignaciones [Cursos]Nivel_Numero
$element:=AT_Inc 
$aString2Replace{$element}:="[Cursos]Nivel_Numero:=0"
$aReplaceBy{$element}:="[Cursos]Nivel_Numero:=0"

$element:=AT_Inc 
$aString2Replace{$element}:="[Cursos]Nivel_Numero:=0"
$aReplaceBy{$element}:="[Cursos]Nivel_Numero:=0"

$element:=AT_Inc 
$aString2Replace{$element}:="[Cursos]Nivel_Numero:=0"
$aReplaceBy{$element}:="[Cursos]Nivel_Numero:=0"

$element:=AT_Inc 
$aString2Replace{$element}:="[Cursos]Nivel_Numero:=0"
$aReplaceBy{$element}:="[Cursos]Nivel_Numero:=0"



  //==================================================
  //[xxSTR_Niveles]noNivel
  //==================================================

  //cambios en asignaciones [xxSTR_Niveles]noNivel
$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Niveles]noNivel:=Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[xxSTR_Niveles]noNivel:=Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Niveles]noNivel:=Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[xxSTR_Niveles]noNivel:=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Niveles]noNivel:=Nivel_Egresados"
$aReplaceBy{$element}:="[xxSTR_Niveles]noNivel:=Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Niveles]noNivel:=Nivel_Retirados"
$aReplaceBy{$element}:="[xxSTR_Niveles]noNivel:=Nivel_Retirados"



  //==================================================
  //[Asignaturas]Numero_del_Nivel
  //==================================================

  //cambios en asignaciones [Asignaturas]Numero_del_Nivel
$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas]Numero_del_Nivel:=Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[Asignaturas]Numero_del_Nivel:=Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas]Numero_del_Nivel:=Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[Asignaturas]Numero_del_Nivel:=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas]Numero_del_Nivel:=Nivel_Egresados"
$aReplaceBy{$element}:="[Asignaturas]Numero_del_Nivel:=Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas]Numero_del_Nivel:=Nivel_Retirados"
$aReplaceBy{$element}:="[Asignaturas]Numero_del_Nivel:=Nivel_Retirados"



  //==================================================
  //[xxSTR_Materias]Observaciones’NumeroNivel
  //==================================================

  //cambios en asignaciones [xxSTR_Materias]Observaciones’NumeroNivel
$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel:=Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel:=Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel:=Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel:=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel:=Nivel_Egresados"
$aReplaceBy{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel:=Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel:=Nivel_Retirados"
$aReplaceBy{$element}:="[xxSTR_Materias]Observaciones’NumeroNivel:=Nivel_Retirados"



  //==================================================
  //[Alumnos_Histórico]Nivel
  //==================================================

  //cambios en asignaciones [Alumnos_Histórico]Nivel
$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_Histórico]Nivel:=Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[Alumnos_Histórico]Nivel:=Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_Histórico]Nivel:=Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[Alumnos_Histórico]Nivel:=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_Histórico]Nivel:=Nivel_Egresados"
$aReplaceBy{$element}:="[Alumnos_Histórico]Nivel:=Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_Histórico]Nivel:=Nivel_Retirados"
$aReplaceBy{$element}:="[Alumnos_Histórico]Nivel:=Nivel_Retirados"



  //==================================================
  //[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel
  //==================================================

  //cambios en asignaciones [Alumnos_FichaMedica]Aparatos_Protesis'NoNivel
$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel:=Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel:=Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel:=Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel:=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel:=Nivel_Egresados"
$aReplaceBy{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel:=Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel:=Nivel_Retirados"
$aReplaceBy{$element}:="[Alumnos_FichaMedica]Aparatos_Protesis'NoNivel:=Nivel_Retirados"



  //==================================================
  //[Actividades]Desde_NumeroNivel
  //==================================================

  //cambios en asignaciones [Actividades]Desde_NumeroNivel
$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Desde_NumeroNivel:=Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[Actividades]Desde_NumeroNivel:=Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Desde_NumeroNivel:=Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[Actividades]Desde_NumeroNivel:=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Desde_NumeroNivel:=Nivel_Egresados"
$aReplaceBy{$element}:="[Actividades]Desde_NumeroNivel:=Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Desde_NumeroNivel:=Nivel_Retirados"
$aReplaceBy{$element}:="[Actividades]Desde_NumeroNivel:=Nivel_Retirados"



  //==================================================
  //[Actividades]Hasta_NumeroNivel
  //==================================================

  //cambios en asignaciones [Actividades]Hasta_NumeroNivel
$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Hasta_NumeroNivel:=Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[Actividades]Hasta_NumeroNivel:=Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Hasta_NumeroNivel:=Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[Actividades]Hasta_NumeroNivel:=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Hasta_NumeroNivel:=Nivel_Egresados"
$aReplaceBy{$element}:="[Actividades]Hasta_NumeroNivel:=Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[Actividades]Hasta_NumeroNivel:=Nivel_Retirados"
$aReplaceBy{$element}:="[Actividades]Hasta_NumeroNivel:=Nivel_Retirados"



  //==================================================
  //[xxSTR_MatrizDeDestrezas]No_Nivel
  //==================================================

  //cambios en asignaciones [xxSTR_MatrizDeDestrezas]No_Nivel
$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel:=Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel:=Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel:=Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel:=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel:=Nivel_Egresados"
$aReplaceBy{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel:=Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel:=Nivel_Retirados"
$aReplaceBy{$element}:="[xxSTR_MatrizDeDestrezas]No_Nivel:=Nivel_Retirados"



  //==================================================
  //[Asignaturas_Historico]Nivel
  //==================================================

  //cambios en asignaciones [Asignaturas_Historico]Nivel
$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Historico]Nivel:=Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[Asignaturas_Historico]Nivel:=Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Historico]Nivel:=Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[Asignaturas_Historico]Nivel:=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Historico]Nivel:=Nivel_Egresados"
$aReplaceBy{$element}:="[Asignaturas_Historico]Nivel:=Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Historico]Nivel:=Nivel_Retirados"
$aReplaceBy{$element}:="[Asignaturas_Historico]Nivel:=Nivel_Retirados"



  //==================================================
  //[Asignaturas_Objetivos]Nivel_numero
  //==================================================

  //cambios en asignaciones [Asignaturas_Objetivos]Nivel_numero
$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Objetivos]Nivel_numero:=Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[Asignaturas_Objetivos]Nivel_numero:=Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Objetivos]Nivel_numero:=Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[Asignaturas_Objetivos]Nivel_numero:=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Objetivos]Nivel_numero:=Nivel_Egresados"
$aReplaceBy{$element}:="[Asignaturas_Objetivos]Nivel_numero:=Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[Asignaturas_Objetivos]Nivel_numero:=Nivel_Retirados"
$aReplaceBy{$element}:="[Asignaturas_Objetivos]Nivel_numero:=Nivel_Retirados"



  //==================================================
  //[TMT_Horario]Nivel
  //==================================================

  //cambios en asignaciones [TMT_Horario]Nivel
$element:=AT_Inc 
$aString2Replace{$element}:="[TMT_Horario]Nivel:=Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[TMT_Horario]Nivel:=Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[TMT_Horario]Nivel:=Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[TMT_Horario]Nivel:=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[TMT_Horario]Nivel:=Nivel_Egresados"
$aReplaceBy{$element}:="[TMT_Horario]Nivel:=Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[TMT_Horario]Nivel:=Nivel_Retirados"
$aReplaceBy{$element}:="[TMT_Horario]Nivel:=Nivel_Retirados"



  //==================================================
  //[MPA_AsignaturasMatrices]NumeroNivel
  //==================================================

  //cambios en asignaciones [MPA_AsignaturasMatrices]NumeroNivel
$element:=AT_Inc 
$aString2Replace{$element}:="[MPA_AsignaturasMatrices]NumeroNivel:=Nivel_AdmissionTrack"
$aReplaceBy{$element}:="[MPA_AsignaturasMatrices]NumeroNivel:=Nivel_AdmissionTrack"

$element:=AT_Inc 
$aString2Replace{$element}:="[MPA_AsignaturasMatrices]NumeroNivel:=Nivel_AdmisionDirecta"
$aReplaceBy{$element}:="[MPA_AsignaturasMatrices]NumeroNivel:=Nivel_AdmisionDirecta"

$element:=AT_Inc 
$aString2Replace{$element}:="[MPA_AsignaturasMatrices]NumeroNivel:=Nivel_Egresados"
$aReplaceBy{$element}:="[MPA_AsignaturasMatrices]NumeroNivel:=Nivel_Egresados"

$element:=AT_Inc 
$aString2Replace{$element}:="[MPA_AsignaturasMatrices]NumeroNivel:=Nivel_Retirados"
$aReplaceBy{$element}:="[MPA_AsignaturasMatrices]NumeroNivel:=Nivel_Retirados"


0xDev_ReplaceExpresion_inCC4D (->$aString2Replace;->$aReplaceBy;$apiRef)

API Close Resource File ($apiRef)
