//%attributes = {}
  //ADTcdd_DeleteEducacionAnterior
  //$tipo:=$2  //el tipo puede ser "al", "pe" o "pr" (alumno, persona o profesor)
  //
  //READ WRITE([STR_EducacionAnterior])
  //QUERY([STR_EducacionAnterior];[STR_EducacionAnterior]Tipo_Persona=$tipo)
  //Case of 
  //: ($tipo="al")
  //QRY_QueryWithArray (->[STR_EducacionAnterior]ID_Alumno;$1;True)
  //: ($tipo="pe")
  //QRY_QueryWithArray (->[STR_EducacionAnterior]ID_Persona;$1;True)
  //: ($tipo="pr")
  //QRY_QueryWithArray (->[STR_EducacionAnterior]ID_Profesor;$1;True)
  //End case 
  //KRL_DeleteSelection (->[STR_EducacionAnterior];True;__ ("Eliminando registros de educación anterior..."))
  //KRL_UnloadReadOnly (->[STR_EducacionAnterior])
C_BLOB:C604($xBlob)  //20130730 RCH
C_BOOLEAN:C305($b_hecho)

$tipo:=$2  //el tipo puede ser "al", "pe" o "pr" (alumno, persona o profesor)

BLOB_Variables2Blob (->$xBlob;0;$1;->$tipo)
$b_hecho:=ADTcdd_DeleteEducacionAntBatch ($xBlob)
If (Not:C34($b_hecho))
	BM_CreateRequest ("STR_EliminaEducAnterior";"";"";$xBlob)
End if 
