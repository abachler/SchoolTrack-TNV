//%attributes = {}
  //zz_ImportaAprendizajesScollege



ALERT:C41("Selecconar primer Archivo: Aprendizajes.txt")
IO_ImportRecords2Tables 
ALERT:C41("Selecconar segundo Archivo: EstilosEvaluacion.txt")
IO_ImportRecords2Tables 


ALERT:C41("Selecconar tercer Archivo: Materias.txt")
$ref:=Open document:C264("")
If ($ref#?00:00:00?)
	RECEIVE PACKET:C104($ref;$rec;"\r")
	While ($rec#"")
		$materia:=ST_GetWord ($rec;1;"\t")
		$area:=ST_GetWord ($rec;2;"\t")
		READ WRITE:C146([xxSTR_Materias:20])
		QUERY:C277([xxSTR_Materias:20];[xxSTR_Materias:20]Materia:2=$materia)
		[xxSTR_Materias:20]AreaMPA:4:=$area
		SAVE RECORD:C53([xxSTR_Materias:20])
		UNLOAD RECORD:C212([xxSTR_Materias:20])
		READ ONLY:C145([xxSTR_Materias:20])
		RECEIVE PACKET:C104($ref;$rec;"\r")
	End while 
End if 
CLOSE DOCUMENT:C267($ref)



ALERT:C41("Selecconar último Archivo: RefMatrices.txt")
$ref:=Open document:C264("")
If ($ref#?00:00:00?)
	RECEIVE PACKET:C104($ref;$rec;"\r")
	While ($rec#"")
		$id:=Num:C11(ST_GetWord ($rec;1;"\t"))
		$refMatriz:=Num:C11(ST_GetWord ($rec;2;"\t"))
		READ WRITE:C146([Asignaturas:18])
		QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=$id)
		[Asignaturas:18]EVAPR_IdMatriz:91:=$refMatriz
		SAVE RECORD:C53([Asignaturas:18])
		UNLOAD RECORD:C212([Asignaturas:18])
		READ ONLY:C145([Asignaturas:18])
		RECEIVE PACKET:C104($ref;$rec;"\r")
	End while 
End if 
CLOSE DOCUMENT:C267($ref)


