//%attributes = {}
  //ASsev_GetGradesFromBlob

C_LONGINT:C283($1;$2;$periodo;$id;$0)

$0:=-1
$id:=$1
$periodo:=$2
$convierteNotas:=True:C214
If (Count parameters:C259=3)
	$convierteNotas:=$3
End if 
$subID:=String:C10($id)+"/"+String:C10($periodo)
READ WRITE:C146([xxSTR_Subasignaturas:83])
QUERY:C277([xxSTR_Subasignaturas:83];[xxSTR_Subasignaturas:83]ID_SubAsignatura:1=$subID;*)
QUERY:C277([xxSTR_Subasignaturas:83]; & [xxSTR_Subasignaturas:83]ID_Mother:6=[Asignaturas:18]Numero:1)
If (Records in selection:C76([xxSTR_Subasignaturas:83])=0)
	QUERY:C277([xxSTR_Subasignaturas:83];[xxSTR_Subasignaturas:83]ID_SubAsignatura:1=$subID;*)
	QUERY:C277([xxSTR_Subasignaturas:83]; & [xxSTR_Subasignaturas:83]ID_Mother:6=0)
End if 
If (Records in selection:C76([xxSTR_Subasignaturas:83])=0)
	QUERY:C277([xxSTR_Subasignaturas:83];[xxSTR_Subasignaturas:83]ID_SubAsignatura:1=$subID)
End if 
If (Records in selection:C76([xxSTR_Subasignaturas:83])=1)
	If ([xxSTR_Subasignaturas:83]ID_Mother:6=0)
		[xxSTR_Subasignaturas:83]ID_Mother:6:=[Asignaturas:18]Numero:1
		SAVE RECORD:C53([xxSTR_Subasignaturas:83])
	End if 
	If ([Asignaturas:18]Numero:1=[xxSTR_Subasignaturas:83]ID_Mother:6)
		ASsev_InitArrays 
		<>crtSEvalPerPtr:=->aSubEvalP1
		ARRAY REAL:C219(aRealTemp;0)
		ARRAY POINTER:C280(aSubEvalArrPtr;12)
		ARRAY POINTER:C280(aRealSubEvalArrPtr;12)
		ARRAY TEXT:C222(aRealSubEvalArrNames;12)
		For ($i;1;12)
			aSubEvalArrPtr{$i}:=Get pointer:C304("aSubEval"+String:C10($i))
			aRealSubEvalArrPtr{$i}:=Get pointer:C304("aRealSubEval"+String:C10($i))
			aRealSubEvalArrNames{$i}:="aRealSubEval"+String:C10($i)
		End for 
		
		  //MONO TICKET 187315 
		  //$offset:=0
		  //$offset:=BLOB_Blob2Vars (->[xxSTR_Subasignaturas]Data;$offset;->aSubEvalID;->aSubEvalStdNme;->aSubEvalCurso;->aSubEvalStatus;->aSubEvalOrden)
		OB_GET ([xxSTR_Subasignaturas:83]o_Data:21;->aSubEvalID;"aSubEvalID")
		OB_GET ([xxSTR_Subasignaturas:83]o_Data:21;->aSubEvalStdNme;"aSubEvalStdNme")
		OB_GET ([xxSTR_Subasignaturas:83]o_Data:21;->aSubEvalCurso;"aSubEvalCurso")
		OB_GET ([xxSTR_Subasignaturas:83]o_Data:21;->aSubEvalStatus;"aSubEvalStatus")
		OB_GET ([xxSTR_Subasignaturas:83]o_Data:21;->aSubEvalOrden;"aSubEvalOrden")
		
		For ($j;1;Size of array:C274(aSubEvalArrPtr))
			  //$offset:=BLOB_Blob2Vars (->[xxSTR_Subasignaturas]Data;$offset;aRealSubEvalArrPtr{$j})
			OB_GET ([xxSTR_Subasignaturas:83]o_Data:21;aRealSubEvalArrPtr{$j};"aRealSubEval"+String:C10($j))
			If ($convierteNotas)
				NTA_PercentArray2StrGradeArray (aRealSubEvalArrPtr{$j};aSubEvalArrPtr{$j})
			End if 
		End for 
		  //$offset:=BLOB_Blob2Vars (->[xxSTR_Subasignaturas]Data;$offset;->aRealSubEvalP1)
		  //$offset:=BLOB_Blob2Vars (->[xxSTR_Subasignaturas]Data;$offset;->aRealSubEvalControles)
		  //$offset:=BLOB_Blob2Vars (->[xxSTR_Subasignaturas]Data;$offset;->aRealSubEvalPresentacion)
		OB_GET ([xxSTR_Subasignaturas:83]o_Data:21;->aRealSubEvalP1;"aRealSubEvalP1")
		OB_GET ([xxSTR_Subasignaturas:83]o_Data:21;->aRealSubEvalControles;"aRealSubEvalControles")
		OB_GET ([xxSTR_Subasignaturas:83]o_Data:21;->aRealSubEvalPresentacion;"aRealSubEvalPresentacion")
		OB_GET ([xxSTR_Subasignaturas:83]o_Data:21;->aSubEvalNombreParciales;"aSubEvalNombreParciales")
		
		If ($convierteNotas)
			NTA_PercentArray2StrGradeArray (->aRealSubEvalP1;->aSubEvalP1)
			NTA_PercentArray2StrGradeArray (->aRealSubEvalControles;->aSubEvalControles)
			NTA_PercentArray2StrGradeArray (->aRealSubEvalPresentacion;->aSubEvalPresentacion)
		End if 
		$0:=Record number:C243([xxSTR_Subasignaturas:83])
	Else 
		  //vínculo corrupto
		$0:=-2
	End if 
Else 
	  //subasignatura inexistente
	$0:=-1
	ASsev_InitArrays 
End if 


