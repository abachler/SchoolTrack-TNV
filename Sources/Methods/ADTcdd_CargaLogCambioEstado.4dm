//%attributes = {}
  //ADTcdd_CargaLogCambioEstado

If (Count parameters:C259=1)
	$idCandidato:=$1
Else 
	$idCandidato:=[ADT_Candidatos:49]Candidato_numero:1
End if 
QUERY:C277([xxADT_LogCambioEstado:162];[xxADT_LogCambioEstado:162]ID_Candidato:1=$idCandidato;*)
QUERY:C277([xxADT_LogCambioEstado:162]; & ;[xxADT_LogCambioEstado:162]ID_Estado_Nuevo:4=[ADT_Candidatos:49]ID_Estado:49)
ORDER BY:C49([xxADT_LogCambioEstado:162];[xxADT_LogCambioEstado:162]DTS:2;<)