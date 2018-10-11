//%attributes = {}
  //dbu_ExportaMapasAprendizajes

C_TIME:C306($ref)
C_TEXT:C284($folder)

$folder:=Select folder:C670("Seleccione la carpeta en la que desea guardar el archivo MapasAprendizajes.txt...")

ARRAY POINTER:C280(aTablesToExport;8)
ALL RECORDS:C47([MPA_DefinicionAreas:186])
ALL RECORDS:C47([MPA_DefinicionEjes:185])
ALL RECORDS:C47([MPA_DefinicionDimensiones:188])
ALL RECORDS:C47([MPA_DefinicionCompetencias:187])
ALL RECORDS:C47([MPA_AsignaturasMatrices:189])
ALL RECORDS:C47([MPA_ObjetosMatriz:204])

  //ajustar para exportar los estilos de evaluación utilizados y los registros de las tabla [xxSTR_Materias]
  //en el script o método de importación asegurarse de manejar la importación correctamente
QUERY:C277([xxSTR_EstilosEvaluacion:44];[xxSTR_EstilosEvaluacion:44]ID:1=14)
QUERY:C277([xxSTR_Materias:20];[xxSTR_Materias:20]Materia:2="Evaluación Personal@")
aTablesToExport{1}:=->[MPA_DefinicionAreas:186]
aTablesToExport{2}:=->[MPA_DefinicionEjes:185]
aTablesToExport{3}:=->[MPA_DefinicionDimensiones:188]
aTablesToExport{4}:=->[MPA_DefinicionCompetencias:187]
aTablesToExport{5}:=->[MPA_AsignaturasMatrices:189]
aTablesToExport{6}:=->[MPA_ObjetosMatriz:204]
aTablesToExport{7}:=->[xxSTR_EstilosEvaluacion:44]
aTablesToExport{8}:=->[xxSTR_Materias:20]
IO_ExportSelectionFromTables (->aTablesToExport;$folder+"MapasAprendizaje.txt")


  //IO_ImportRecords2Tables 
  //SQ_SetSequences 
  //SQ_CargaDatos 