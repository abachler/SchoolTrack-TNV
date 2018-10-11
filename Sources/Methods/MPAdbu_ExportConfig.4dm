//%attributes = {}
  //MPAdbu_ExportConfig

ARRAY POINTER:C280($aPointers;6)
AT_Inc (0)
$aPointers{AT_Inc }:=->[xxSTR_EstilosEvaluacion:44]
$aPointers{AT_Inc }:=->[MPA_DefinicionAreas:186]
$aPointers{AT_Inc }:=->[MPA_DefinicionEjes:185]
$aPointers{AT_Inc }:=->[MPA_DefinicionDimensiones:188]
$aPointers{AT_Inc }:=->[MPA_DefinicionCompetencias:187]
$aPointers{AT_Inc }:=->[xxSTR_Materias:20]



ALL RECORDS:C47([MPA_DefinicionAreas:186])
KRL_RelateSelection (->[xxSTR_Materias:20]AreaMPA:4;->[MPA_DefinicionAreas:186]AreaAsignatura:4)
ALL RECORDS:C47([MPA_DefinicionEjes:185])
ALL RECORDS:C47([MPA_DefinicionDimensiones:188])
ALL RECORDS:C47([MPA_DefinicionCompetencias:187])


CREATE EMPTY SET:C140([xxSTR_EstilosEvaluacion:44];"seleccion")
ARRAY LONGINT:C221($aEstilos;0)
AT_DistinctsFieldValues (->[MPA_DefinicionEjes:185]EstiloEvaluación:13;->$aEstilos)
QUERY WITH ARRAY:C644([xxSTR_EstilosEvaluacion:44]ID:1;$aEstilos)
CREATE SET:C116([xxSTR_EstilosEvaluacion:44];"resultado")
UNION:C120("seleccion";"resultado";"seleccion")

ARRAY LONGINT:C221($aEstilos;0)
AT_DistinctsFieldValues (->[MPA_DefinicionDimensiones:188]EstiloEvaluacion:11;->$aEstilos)
QUERY WITH ARRAY:C644([xxSTR_EstilosEvaluacion:44]ID:1;$aEstilos)
CREATE SET:C116([xxSTR_EstilosEvaluacion:44];"resultado")
UNION:C120("seleccion";"resultado";"seleccion")

ARRAY LONGINT:C221($aEstilos;0)
AT_DistinctsFieldValues (->[MPA_DefinicionCompetencias:187]EstiloEvaluacion:7;->$aEstilos)
QUERY WITH ARRAY:C644([xxSTR_EstilosEvaluacion:44]ID:1;$aEstilos)
CREATE SET:C116([xxSTR_EstilosEvaluacion:44];"resultado")
UNION:C120("seleccion";"resultado";"seleccion")
SET_UseSet ("seleccion")

IO_ExportSelectionFromTables (->$aPointers)

