$fieldName:="[Alumnos_SintesisAnual]"+Field name:C257(Self:C308)
$realPointer:=KRL_GetFieldPointerByName (Replace string:C233($fieldName;"_literal";"_Real"))
$notaPointer:=KRL_GetFieldPointerByName (Replace string:C233($fieldName;"_literal";"_Nota"))
$puntosPointer:=KRL_GetFieldPointerByName (Replace string:C233($fieldName;"_literal";"_Puntos"))
$simboloPointer:=KRL_GetFieldPointerByName (Replace string:C233($fieldName;"_literal";"_Simbolo"))

EVS_initialize 
EVS_LeeEstiloEvalHistorico (vx_EstiloInterno)

$realPointer->:=NTA_StringValue2Percent (Self:C308->)
$notaPointer->:=EV2_Real_a_Nota ($realPointer->;0;iGradesDecNF)
$puntosPointer->:=EV2_Real_a_Puntos ($realPointer->;0;iPointsDecNF)
$simboloPointer->:=EV2_Real_a_Simbolo ($realPointer->)


SAVE RECORD:C53([Alumnos_SintesisAnual:210])