//%attributes = {}
  //zz_ExportaAprendizajesSCollege

ARRAY POINTER:C280($aTablesToExport;6)
$aTablesToExport{1}:=->[MPA_DefinicionAreas:186]
$aTablesToExport{2}:=->[MPA_DefinicionEjes:185]
$aTablesToExport{3}:=->[MPA_DefinicionDimensiones:188]
$aTablesToExport{4}:=->[MPA_DefinicionCompetencias:187]
$aTablesToExport{5}:=->[MPA_AsignaturasMatrices:189]
$aTablesToExport{6}:=->[MPA_ObjetosMatriz:204]
IO_ExportRecordsFromTables (->$aTablesToExport;"Aprendizajes.txt")

ARRAY POINTER:C280($aTablesToExport;1)
$aTablesToExport{1}:=->[xxSTR_EstilosEvaluacion:44]
QUERY:C277([xxSTR_EstilosEvaluacion:44];[xxSTR_EstilosEvaluacion:44]ID:1=14)
IO_ExportSelectionFromTables (->$aTablesToExport;"EstilosEvaluacion.txt")


ALL RECORDS:C47([xxSTR_Materias:20])
$ref:=Create document:C266("Materias.txt")
ARRAY LONGINT:C221($aRecNums;0)
LONGINT ARRAY FROM SELECTION:C647([xxSTR_Materias:20];$aRecNums;"")
For ($i;1;Size of array:C274($aRecNums))
	GOTO RECORD:C242([xxSTR_Materias:20];$aRecNums{$i})
	SEND PACKET:C103($ref;[xxSTR_Materias:20]Materia:2+"\t"+[xxSTR_Materias:20]AreaMPA:4+"\r")
End for 
CLOSE DOCUMENT:C267($ref)

ALL RECORDS:C47([Asignaturas:18])
$ref:=Create document:C266("RefMatrices.txt")
ARRAY LONGINT:C221($aRecNums;0)
LONGINT ARRAY FROM SELECTION:C647([Asignaturas:18];$aRecNums;"")
For ($i;1;Size of array:C274($aRecNums))
	GOTO RECORD:C242([Asignaturas:18];$aRecNums{$i})
	SEND PACKET:C103($ref;String:C10([Asignaturas:18]Numero:1)+"\t"+String:C10([Asignaturas:18]EVAPR_IdMatriz:91)+"\r")
End for 
CLOSE DOCUMENT:C267($ref)


