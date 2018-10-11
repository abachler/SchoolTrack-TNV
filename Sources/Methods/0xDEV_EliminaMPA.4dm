//%attributes = {}
  //0xDEV_EliminaMPA

READ WRITE:C146([MPA_AsignaturasMatrices:189])
TRUNCATE TABLE:C1051([MPA_AsignaturasMatrices:189])

READ WRITE:C146([MPA_DefinicionAreas:186])
TRUNCATE TABLE:C1051([MPA_DefinicionAreas:186])

READ WRITE:C146([MPA_DefinicionDimensiones:188])
TRUNCATE TABLE:C1051([MPA_DefinicionDimensiones:188])

READ WRITE:C146([MPA_DefinicionEjes:185])
TRUNCATE TABLE:C1051([MPA_DefinicionEjes:185])

READ WRITE:C146([MPA_DefinicionCompetencias:187])
TRUNCATE TABLE:C1051([MPA_DefinicionCompetencias:187])

READ WRITE:C146([xxSTR_Materias:20])
ALL RECORDS:C47([xxSTR_Materias:20])
APPLY TO SELECTION:C70([xxSTR_Materias:20];[xxSTR_Materias:20]AreaMPA:4:="")
