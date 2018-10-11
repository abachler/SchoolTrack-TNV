//%attributes = {}
  //ADTcdd_DeleteEducacionAntBatch

C_BOOLEAN:C305($0)
C_BLOB:C604($1;$xBlob)
C_TEXT:C284($t_tipo)
ARRAY LONGINT:C221($alIDS;0)

$0:=True:C214
  //
  //$tipo:=$2  //el tipo puede ser "al", "pe" o "pr" (alumno, persona o profesor)
$xBlob:=$1

BLOB_Blob2Vars (->$xBlob;0;->$alIDS;->$t_tipo)

If (Size of array:C274($alIDS)>0)
	READ WRITE:C146([STR_EducacionAnterior:87])
	QUERY:C277([STR_EducacionAnterior:87];[STR_EducacionAnterior:87]Tipo_Persona:8=$t_tipo)
	Case of 
		: ($t_tipo="al")
			QRY_QueryWithArray (->[STR_EducacionAnterior:87]ID_Alumno:5;->$alIDS;True:C214)
		: ($t_tipo="pe")
			QRY_QueryWithArray (->[STR_EducacionAnterior:87]ID_Persona:6;->$alIDS;True:C214)
		: ($t_tipo="pr")
			QRY_QueryWithArray (->[STR_EducacionAnterior:87]ID_Profesor:7;->$alIDS;True:C214)
		Else 
			REDUCE SELECTION:C351([STR_EducacionAnterior:87];0)
	End case 
	$l_eliminado:=KRL_DeleteSelection (->[STR_EducacionAnterior:87];True:C214;__ ("Eliminando registros de educación anterior..."))
	If ($l_eliminado=0)
		$0:=False:C215
	Else 
		$0:=True:C214
	End if 
	KRL_UnloadReadOnly (->[STR_EducacionAnterior:87])
Else 
	$0:=True:C214
End if 