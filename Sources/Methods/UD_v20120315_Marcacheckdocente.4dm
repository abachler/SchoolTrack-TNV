//%attributes = {}
  //UD_v20120315_Marcacheckdocente

READ WRITE:C146([Profesores:4])
READ ONLY:C145([Asignaturas:18])
ARRAY LONGINT:C221($al_rn_prof;0)
C_LONGINT:C283($i;$p)
C_BOOLEAN:C305($guardar)
QUERY:C277([Profesores:4];[Profesores:4]Es_docente:76=False:C215)
LONGINT ARRAY FROM SELECTION:C647([Profesores:4];$al_rn_prof;"")
$p:=IT_UThermometer (1;0;"Marcando check  Es Docente")
For ($i;1;Size of array:C274($al_rn_prof))
	GOTO RECORD:C242([Profesores:4];$al_rn_prof{$i})
	QUERY:C277([Asignaturas:18];[Asignaturas:18]profesor_firmante_numero:33=[Profesores:4]Numero:1;*)
	QUERY:C277([Asignaturas:18]; | ;[Asignaturas:18]profesor_numero:4=[Profesores:4]Numero:1)
	QUERY:C277([Cursos:3];[Cursos:3]Numero_del_profesor_jefe:2=[Profesores:4]Numero:1)
	If ((Records in selection:C76([Asignaturas:18])>0) | (Records in selection:C76([Cursos:3])>0))
		[Profesores:4]Es_docente:76:=True:C214
		$guardar:=True:C214
	Else 
		If ([Profesores:4]Es_Tutor:34)
			[Profesores:4]Es_docente:76:=True:C214
			$guardar:=True:C214
		Else 
			$guardar:=False:C215
		End if 
	End if 
	If ($guardar)
		SAVE RECORD:C53([Profesores:4])
	End if 
End for 
IT_UThermometer (-2;$p)
KRL_UnloadReadOnly (->[Profesores:4])

