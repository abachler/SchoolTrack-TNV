If (Self:C308->>0)
	If (<>gGroupAL=False:C215)
		[Familia:78]Grupo_Familia:4:=Self:C308->{Self:C308->}
		If (([Familia:78]Grupo_Familia:4#Old:C35([Familia:78]Grupo_Familia:4)) & (Record number:C243([Familia:78])>0) & (Not:C34(<>gGroupAL)) & ([Familia:78]Grupo_Familia:4#""))
			READ ONLY:C145([Alumnos:2])
			QUERY:C277([Alumnos:2];[Alumnos:2]Familia_Número:24=[Familia:78]Numero:1)
			ARRAY TEXT:C222(aText;Records in selection:C76([Alumnos:2]))
			sString:=[Familia:78]Grupo_Familia:4
			AT_Populate (->aText;->sString)
			KRL_Array2Selection (->aText;->[Alumnos:2]Grupo:11)
			SAVE RECORD:C53([Familia:78])
			ARRAY TEXT:C222(aText;0)
			sString:=""
		End if 
	Else 
		CD_Dlog (0;__ ("El grupo debe ser asignado al alumno y no a la familia."))
	End if 
End if 
