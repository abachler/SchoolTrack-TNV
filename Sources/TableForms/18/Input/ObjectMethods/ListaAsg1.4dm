  //[Asignaturas].Input.ListaAsg1

C_LONGINT:C283($l_IdAsignatura;$l_IdObjetivos;$l_nivelAsignatura;$l_UserChoice)

ARRAY LONGINT:C221($al_Asignaturas_IdObjetivo;0)
ARRAY LONGINT:C221($al_Asignaturas_recNum;0)
ARRAY TEXT:C222($at_Asignaturas_Curso;0)
ARRAY TEXT:C222($at_Asignaturas_NombreInterno;0)
ARRAY TEXT:C222($at_Asignaturas_NombreOficial;0)

$l_nivelAsignatura:=[Asignaturas:18]Numero_del_Nivel:6
$l_IdAsignatura:=[Asignaturas:18]Numero:1
PUSH RECORD:C176([Asignaturas:18])
QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero_del_Nivel:6=$l_nivelAsignatura;*)
QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]Numero:1#$l_IdAsignatura;*)
QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]ID_Objetivos:43>0)
SELECTION TO ARRAY:C260([Asignaturas:18]Asignatura:3;$at_Asignaturas_NombreOficial;[Asignaturas:18];$al_Asignaturas_recNum;[Asignaturas:18]Curso:5;$at_Asignaturas_Curso;[Asignaturas:18]denominacion_interna:16;$at_Asignaturas_NombreInterno;[Asignaturas:18]ID_Objetivos:43;$al_Asignaturas_IdObjetivo)
POP RECORD:C177([Asignaturas:18])

If ((Macintosh option down:C545) | (Windows Alt down:C563))
	AT_MultiLevelSort (">>";->$at_Asignaturas_NombreInterno;->$at_Asignaturas_Curso;->$al_Asignaturas_IdObjetivo)
	$l_UserChoice:=Pop up menu:C542(Char:C90(1)+AT_Arrays2Text (Char:C90(1);"";->$at_Asignaturas_NombreInterno;->$at_Asignaturas_Curso))
	
Else 
	AT_MultiLevelSort (">>";->$at_Asignaturas_NombreOficial;->$at_Asignaturas_Curso;->$al_Asignaturas_IdObjetivo)
	$l_UserChoice:=Pop up menu:C542(Char:C90(1)+AT_Arrays2Text (Char:C90(1);"";->$at_Asignaturas_NombreOficial;->$at_Asignaturas_Curso))
End if 

If ($l_UserChoice>0)
	modObjetivos:=True:C214
	$l_IdObjetivos:=$al_Asignaturas_IdObjetivo{$l_UserChoice}
	If ($l_IdObjetivos>0)
		vObj_P1:=KRL_GetTextFieldData (->[Asignaturas_Objetivos:104]ID:1;->$l_IdObjetivos;->[Asignaturas_Objetivos:104]Objetivos_P1:6)
		vObj_P2:=KRL_GetTextFieldData (->[Asignaturas_Objetivos:104]ID:1;->$l_IdObjetivos;->[Asignaturas_Objetivos:104]Objetivos_P2:7)
		vObj_P3:=KRL_GetTextFieldData (->[Asignaturas_Objetivos:104]ID:1;->$l_IdObjetivos;->[Asignaturas_Objetivos:104]Objetivos_P3:8)
		vObj_P4:=KRL_GetTextFieldData (->[Asignaturas_Objetivos:104]ID:1;->$l_IdObjetivos;->[Asignaturas_Objetivos:104]Objetivos_P4:9)
		vObj_P5:=KRL_GetTextFieldData (->[Asignaturas_Objetivos:104]ID:1;->$l_IdObjetivos;->[Asignaturas_Objetivos:104]Objetivos_P5:10)
	Else 
		CD_Dlog (0;__ ("La asignatura elegida no tiene objetivos definidos."))
	End if 
	
	OBJECT SET VISIBLE:C603(*;"ListaAsg@";[Asignaturas:18]ConObjetivosEspecificos:62)
End if 

