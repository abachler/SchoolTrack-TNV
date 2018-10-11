//%attributes = {}
  //AS_fmNosOrden

MESSAGES OFF:C175

ARRAY TEXT:C222(aText1;0)
ARRAY TEXT:C222(aText2;0)
ARRAY INTEGER:C220(aInt1;0)
ARRAY LONGINT:C221(aLong1;0)


$mode:=$1

EV2_RegistrosDeLaAsignatura ([Asignaturas:18]Numero:1)
ORDER BY:C49([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Alumno:6;>)
SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]ID_Alumno:6;aLong1;[Alumnos_Calificaciones:208]NoDeLista:10;aInt1;[Alumnos:2]apellidos_y_nombres:40;aText1;[Alumnos:2]curso:20;aText2)
CUT NAMED SELECTION:C334([Alumnos_Calificaciones:208];"notas")
SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)


If (Not:C34(SYS_isSpanishOrder ))
	For ($i;1;Size of array:C274(aText1))
		aText1{$i}:=ST_nTilde2Special (aText1{$i})
	End for 
End if 
If ($mode=2)
	SORT ARRAY:C229(aText1;aText2;aInt1;aLong1;>)
Else 
	AT_MultiLevelSort (">>";->aText2;->aText1;->aInt1;->aLong1)
End if 

For ($i;1;Size of array:C274(aInt1))
	aInt1{$i}:=$i
End for 
SORT ARRAY:C229(aLong1;aInt1;aText1;>)
USE NAMED SELECTION:C332("notas")
READ WRITE:C146([Alumnos_Calificaciones:208])
ARRAY TO SELECTION:C261(aInt1;[Alumnos_Calificaciones:208]NoDeLista:10)
KRL_UnloadReadOnly (->[Alumnos_Calificaciones:208])

$0:=Size of array:C274(aLong1)

LOG_RegisterEvt ("Reasignación de Numeros de Lista: "+[Asignaturas:18]denominacion_interna:16+", "+[Asignaturas:18]Curso:5)

ARRAY TEXT:C222(aText1;0)
ARRAY TEXT:C222(aText2;0)
ARRAY INTEGER:C220(aInt1;0)
ARRAY LONGINT:C221(aLong1;0)