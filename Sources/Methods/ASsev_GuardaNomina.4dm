//%attributes = {}
  //ASsev_GuardaNomina

$recNum:=$1
C_OBJECT:C1216($o_data)
READ WRITE:C146([xxSTR_Subasignaturas:83])
GOTO RECORD:C242([xxSTR_Subasignaturas:83];$recNum)

ARRAY POINTER:C280(aSubEvalArrPtr;12)
  //SET BLOB SIZE([xxSTR_Subasignaturas]Data;0)
$o_data:=OB_Create   //MONO TICKET 187315

  //ARRAY REAL(aRealTemp;0)
  //$offset:=0
  //$offset:=BLOB_Variables2Blob (->[xxSTR_Subasignaturas]Data;$offset;->aSubEvalID;->aSubEvalStdNme;->aSubEvalCurso;->aSubEvalStatus;->aSubEvalOrden)

OB_SET ($o_data;->aSubEvalID;"aSubEvalID")
OB_SET ($o_data;->aSubEvalStdNme;"aSubEvalStdNme")
OB_SET ($o_data;->aSubEvalCurso;"aSubEvalCurso")
OB_SET ($o_data;->aSubEvalStatus;"aSubEvalStatus")
OB_SET ($o_data;->aSubEvalOrden;"aSubEvalOrden")

For ($j;1;Size of array:C274(aSubEvalArrPtr))
	For ($ifilas;1;Size of array:C274(aSubEvalID))
		If ((aRealSubEvalArrPtr{$j}->{$iFilas}<vrNTA_MinimoEscalaReferencia) & (aRealSubEvalArrPtr{$j}->{$iFilas}#-1) & (aRealSubEvalArrPtr{$j}->{$iFilas}#-2) & (aRealSubEvalArrPtr{$j}->{$iFilas}#-3) & (aRealSubEvalArrPtr{$j}->{$iFilas}#-4))
			aRealSubEvalArrPtr{$j}->{$iFilas}:=-10
		End if 
	End for 
	  //$offset:=BLOB_Variables2Blob (->[xxSTR_Subasignaturas]Data;$offset;aRealSubEvalArrPtr{$j})
	OB_SET ($o_data;aRealSubEvalArrPtr{$j};"aRealSubEval"+String:C10($j))
End for 

For ($iFilas;1;Size of array:C274(aRealSubEvalP1))
	If ((aRealSubEvalP1{$iFilas}<vrNTA_MinimoEscalaReferencia) & (aRealSubEvalP1{$iFilas}#-1) & (aRealSubEvalP1{$iFilas}#-2) & (aRealSubEvalP1{$iFilas}#-3) & (aRealSubEvalP1{$iFilas}#-4))
		aRealSubEvalP1{$iFilas}:=-10
	End if 
	If ((aRealSubEvalControles{$iFilas}<vrNTA_MinimoEscalaReferencia) & (aRealSubEvalControles{$iFilas}#-1) & (aRealSubEvalControles{$iFilas}#-2) & (aRealSubEvalControles{$iFilas}#-3) & (aRealSubEvalControles{$iFilas}#-4))
		aRealSubEvalControles{$iFilas}:=-10
	End if 
	If ((aRealSubEvalPresentacion{$iFilas}<vrNTA_MinimoEscalaReferencia) & (aRealSubEvalPresentacion{$iFilas}#-1) & (aRealSubEvalPresentacion{$iFilas}#-2) & (aRealSubEvalPresentacion{$iFilas}#-3) & (aRealSubEvalPresentacion{$iFilas}#-4))
		aRealSubEvalPresentacion{$iFilas}:=-10
	End if 
End for 

OB_SET ($o_data;->aRealSubEvalP1;"aRealSubEvalP1")
OB_SET ($o_data;->aRealSubEvalControles;"aRealSubEvalControles")
OB_SET ($o_data;->aRealSubEvalPresentacion;"aRealSubEvalPresentacion")
OB_SET ($o_data;->aSubEvalNombreParciales;"aSubEvalNombreParciales")

  //$offset:=BLOB_Variables2Blob (->[xxSTR_Subasignaturas]Data;$offset;->aRealSubEvalP1)
  //$offset:=BLOB_Variables2Blob (->[xxSTR_Subasignaturas]Data;$offset;->aRealSubEvalControles)
  //$offset:=BLOB_Variables2Blob (->[xxSTR_Subasignaturas]Data;$offset;->aRealSubEvalPresentación)
  //COMPRESS BLOB([xxSTR_Subasignaturas]Data;1)

[xxSTR_Subasignaturas:83]o_Data:21:=$o_data
SAVE RECORD:C53([xxSTR_Subasignaturas:83])
KRL_ReloadAsReadOnly (->[xxSTR_Subasignaturas:83])

