//%attributes = {}
  //UD_v20170913_SubEvalBlob2Obj
  //MONO Ticket 187315
C_LONGINT:C283($i;$j;$l_idTermometro;$offset)
C_OBJECT:C1216($ob_subAsig)
ARRAY LONGINT:C221($aSubAsigRecNums;0)

$l_idTermometro:=IT_Progress (1;0;0;"SubAsignaturas: Migrando Data Blob a Data Object...")

READ ONLY:C145([xxSTR_Subasignaturas:83])
ALL RECORDS:C47([xxSTR_Subasignaturas:83])
LONGINT ARRAY FROM SELECTION:C647([xxSTR_Subasignaturas:83];$aSubAsigRecNums;"")

ARRAY REAL:C219(aRealTemp;0)
ARRAY POINTER:C280(aSubEvalArrPtr;12)
ARRAY TEXT:C222(aRealSubEvalArrNames;12)
ARRAY TEXT:C222($at_SubEvalNombreParciales;12)

For ($i;1;12)
	aSubEvalArrPtr{$i}:=Get pointer:C304("aSubEval"+String:C10($i))
	aRealSubEvalArrNames{$i}:="aRealSubEval"+String:C10($i)
	$at_SubEvalNombreParciales{$i}:=__ ("Parcial")+" "+String:C10($i)
End for 

For ($iSubAsg;1;Size of array:C274($aSubAsigRecNums))
	
	$l_idTermometro:=IT_Progress (0;$l_idTermometro;$iSubAsg/Size of array:C274($aSubAsigRecNums))
	
	READ WRITE:C146([xxSTR_Subasignaturas:83])
	GOTO RECORD:C242([xxSTR_Subasignaturas:83];$aSubAsigRecNums{$iSubAsg})
	If (BLOB size:C605([xxSTR_Subasignaturas:83]Data:4)>0)
		
	End if 
	ASsev_InitArrays 
	$offset:=0
	$offset:=BLOB_Blob2Vars (->[xxSTR_Subasignaturas:83]Data:4;$offset;->aSubEvalID;->aSubEvalStdNme;->aSubEvalCurso;->aSubEvalStatus;->aSubEvalOrden)
	
	$ob_subAsig:=OB_Create 
	OB_SET ($ob_subAsig;->aSubEvalID;"aSubEvalID")
	OB_SET ($ob_subAsig;->aSubEvalStdNme;"aSubEvalStdNme")
	OB_SET ($ob_subAsig;->aSubEvalCurso;"aSubEvalCurso")
	OB_SET ($ob_subAsig;->aSubEvalStatus;"aSubEvalStatus")
	OB_SET ($ob_subAsig;->aSubEvalOrden;"aSubEvalOrden")
	
	For ($j;1;Size of array:C274(aRealSubEvalArrPtr))
		$offset:=BLOB_Blob2Vars (->[xxSTR_Subasignaturas:83]Data:4;$offset;aRealSubEvalArrPtr{$j})
		OB_SET ($ob_subAsig;aRealSubEvalArrPtr{$j};aRealSubEvalArrNames{$j})
	End for 
	
	$offset:=BLOB_Blob2Vars (->[xxSTR_Subasignaturas:83]Data:4;$offset;->aRealSubEvalP1)
	$offset:=BLOB_Blob2Vars (->[xxSTR_Subasignaturas:83]Data:4;$offset;->aRealSubEvalControles)
	$offset:=BLOB_Blob2Vars (->[xxSTR_Subasignaturas:83]Data:4;$offset;->aRealSubEvalPresentacion)
	
	OB_SET ($ob_subAsig;->aRealSubEvalP1;"aRealSubEvalP1")
	OB_SET ($ob_subAsig;->aRealSubEvalControles;"aRealSubEvalControles")
	OB_SET ($ob_subAsig;->aRealSubEvalPresentacion;"aRealSubEvalPresentacion")
	OB_SET ($ob_subAsig;->$at_SubEvalNombreParciales;"aSubEvalNombreParciales")
	
	[xxSTR_Subasignaturas:83]o_Data:21:=$ob_subAsig
	SAVE RECORD:C53([xxSTR_Subasignaturas:83])
	KRL_UnloadReadOnly (->[xxSTR_Subasignaturas:83])
End for 

$l_idTermometro:=IT_Progress (-1;$l_idTermometro)