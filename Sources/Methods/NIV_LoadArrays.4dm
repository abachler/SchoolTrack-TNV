//%attributes = {}
  // MÉTODO: NIV_LoadArrays
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 07/03/12, 10:39:28
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // NIV_LoadArrays()
  // ----------------------------------------------------
C_LONGINT:C283(hl_cursos)


  // CODIGO PRINCIPAL
If (Records in table:C83([xxSTR_Niveles:6])<28)
	IN_LoadNiveles 
End if 

C_LONGINT:C283(hl_MenuNiveles)

ARRAY TEXT:C222(<>aNivel;0)
ARRAY TEXT:C222(<>aNivelB;0)
ARRAY TEXT:C222(<>aNivelT;0)
ARRAY LONGINT:C221(<>aNivNo;0)

READ ONLY:C145([xxSTR_Niveles:6])
ALL RECORDS:C47([xxSTR_Niveles:6])

READ ONLY:C145([xxSTR_Niveles:6])
QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]EsNivelSistema:10=False:C215)
ORDER BY:C49([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5;>)
SELECTION TO ARRAY:C260([xxSTR_Niveles:6]Nivel:1;<>aNivel;[xxSTR_Niveles:6]NoNivel:5;<>aNivNo)

QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]EsNivelRegular:4=True:C214)
ORDER BY:C49([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5;>)
SELECTION TO ARRAY:C260([xxSTR_Niveles:6]Nivel:1;<>at_NombreNivelesRegulares;[xxSTR_Niveles:6]NoNivel:5;<>al_NumeroNivelRegular)
SORT ARRAY:C229(<>al_NumeroNivelRegular;<>at_NombreNivelesRegulares;>)

QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]EsNIvelActivo:30=True:C214)
ORDER BY:C49([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5;>)
SELECTION TO ARRAY:C260([xxSTR_Niveles:6]Nivel:1;<>at_NombreNivelesActivos;[xxSTR_Niveles:6]NoNivel:5;<>al_NumeroNivelesActivos)
SORT ARRAY:C229(<>al_NumeroNivelesActivos;<>at_NombreNivelesActivos;>)

QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]EsNivelOficial:15=True:C214)
ORDER BY:C49([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5;>)
SELECTION TO ARRAY:C260([xxSTR_Niveles:6]Nivel:1;<>at_NombreNivelesOficiales;[xxSTR_Niveles:6]NoNivel:5;<>al_NumeroNivelesOficiales)
SORT ARRAY:C229(<>al_NumeroNivelesOficiales;<>at_NombreNivelesOficiales;>)

QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]EsNivelSchoolNet:14=True:C214)
ORDER BY:C49([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5;>)
SELECTION TO ARRAY:C260([xxSTR_Niveles:6]Nivel:1;<>at_NombreNivelesSchoolNet;[xxSTR_Niveles:6]NoNivel:5;<>al_NumeroNivelesSchoolNet)
SORT ARRAY:C229(<>al_NumeroNivelesSchoolNet;<>at_NombreNivelesSchoolNet;>)

QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]EsNivelSchoolCenter:12=True:C214)
ORDER BY:C49([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5;>)
SELECTION TO ARRAY:C260([xxSTR_Niveles:6]Nivel:1;<>at_NombreNivelesSchoolCenter;[xxSTR_Niveles:6]NoNivel:5;<>al_NumeroNivelesSchoolCenter)
SORT ARRAY:C229(<>al_NumeroNivelesSchoolCenter;<>at_NombreNivelesSchoolCenter;>)

QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]EsPostulable:45=True:C214)
ORDER BY:C49([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5;>)
SELECTION TO ARRAY:C260([xxSTR_Niveles:6]Nivel:1;<>at_NombreNivelesAdmissionTrack;[xxSTR_Niveles:6]NoNivel:5;<>al_NumeroNivelesAdmissionTrack)
SORT ARRAY:C229(<>al_NumeroNivelesAdmissionTrack;<>at_NombreNivelesAdmissionTrack;>)


COPY ARRAY:C226(<>at_NombreNivelesActivos;<>at_NivelesAlumnos)
INSERT IN ARRAY:C227(<>at_NivelesAlumnos;1)
<>at_NivelesAlumnos{1}:="Admisión"
APPEND TO ARRAY:C911(<>at_NivelesAlumnos;"Retirados")
APPEND TO ARRAY:C911(<>at_NivelesAlumnos;"Egresados")

COPY ARRAY:C226(<>at_NombreNivelesRegulares;<>aNivelB)
COPY ARRAY:C226(<>at_NombreNivelesRegulares;<>aNivelT)

HL_ClearList (hl_MenuNiveles)

QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]EsNIvelActivo:30=True:C214)
ORDER BY:C49([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5;>)
hl_MenuNiveles:=HL_Selection2List (->[xxSTR_Niveles:6]Nivel:1;->[xxSTR_Niveles:6]NoNivel:5)

HL_ClearList (hl_cursosAsistenciaSesiones)