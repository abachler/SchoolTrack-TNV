//%attributes = {}
  //AS_fExist

C_LONGINT:C283($r)
C_BOOLEAN:C305($0)
_O_C_STRING:C293(80;$name;$curso)
$name:=[Asignaturas:18]denominacion_interna:16
$curso:=[Asignaturas:18]Curso:5
$sex:=[Asignaturas:18]Seleccion_por_sexo:24
$niv:=[Asignaturas:18]Numero_del_Nivel:6
$id:=[Asignaturas:18]Numero:1
PUSH RECORD:C176([Asignaturas:18])
CUT NAMED SELECTION:C334([Asignaturas:18];"$Temp")
QUERY:C277([Asignaturas:18];[Asignaturas:18]denominacion_interna:16=$name;*)
QUERY:C277([Asignaturas:18]; & [Asignaturas:18]Numero_del_Nivel:6=$niv;*)
QUERY:C277([Asignaturas:18]; & [Asignaturas:18]Curso:5=$curso;*)
QUERY:C277([Asignaturas:18]; & [Asignaturas:18]Numero:1#$id)
QUERY SELECTION:C341([Asignaturas:18];[Asignaturas:18]Seleccion_por_sexo:24=$sex)
If (Records in selection:C76([Asignaturas:18])#0)
	USE NAMED SELECTION:C332("$temp")
	POP RECORD:C177([Asignaturas:18])
	$r:=CD_Dlog (1;__ ("Ya existe una asignatura con el mismo nombre en el mismo curso/nivel"))
	[Asignaturas:18]denominacion_interna:16:=Old:C35([Asignaturas:18]denominacion_interna:16)
	[Asignaturas:18]Asignatura:3:=Old:C35([Asignaturas:18]Asignatura:3)
	[Asignaturas:18]Curso:5:=Old:C35([Asignaturas:18]Curso:5)
	[Asignaturas:18]Numero_del_Nivel:6:=Old:C35([Asignaturas:18]Numero_del_Nivel:6)
	[Asignaturas:18]Nivel:30:=Old:C35([Asignaturas:18]Nivel:30)
	[Asignaturas:18]Numero_del_Curso:25:=Old:C35([Asignaturas:18]Numero_del_Curso:25)
	[Asignaturas:18]Abreviación:26:=Old:C35([Asignaturas:18]Abreviación:26)
	[Asignaturas:18]posicion_en_informes_de_notas:36:=Old:C35([Asignaturas:18]posicion_en_informes_de_notas:36)
	[Asignaturas:18]ordenGeneral:105:=Old:C35([Asignaturas:18]ordenGeneral:105)
	GOTO OBJECT:C206([Asignaturas:18]denominacion_interna:16)
	$0:=True:C214
Else 
	$0:=False:C215
	USE NAMED SELECTION:C332("$temp")
	POP RECORD:C177([Asignaturas:18])
End if 