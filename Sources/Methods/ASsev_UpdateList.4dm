//%attributes = {}
  //ASsev_UpdateList


For ($i;1;Size of array:C274(aNtaIdAlumno))
	$el:=Find in array:C230(aSubEvalID;aNtaIdAlumno{$i})
	If ($el=-1)
		$s:=Size of array:C274(aSubEvalID)+1
		AT_Insert ($s;1;->aSubEvalID;->aSubEvalStdNme;->aSubEvalCurso;->aSubEvalStatus;->aSubEvalOrden;->aSubEval1;->aSubEval2;->aSubEval3;->aSubEval4;->aSubEval5;->aSubEval6;->aSubEval7;->aSubEval8;->aSubEval9;->aSubEval10;->aSubEval11;->aSubEval12;->aSubEvalP1;->aSubEvalControles;->aSubEvalPresentacion)
		AT_Insert ($s;1;->aRealSubEval1;->aRealSubEval2;->aRealSubEval3;->aRealSubEval4;->aRealSubEval5;->aRealSubEval6;->aRealSubEval7;->aRealSubEval8;->aRealSubEval9;->aRealSubEval10;->aRealSubEval11;->aRealSubEval12;->aRealSubEvalP1;->aRealSubEvalControles;->aRealSubEvalPresentacion)
		aSubEvalID{$s}:=aNtaIdAlumno{$i}
		aSubEvalStdNme{$s}:=aNtaStdNme{$i}
		aSubEvalCurso{$s}:=aNtaCurso{$i}
		aRealSubEvalP1{$s}:=-10
		aRealSubEvalControles{$s}:=-10
		aRealSubEvalPresentacion{$s}:=-10
		For ($iParciales;1;Size of array:C274(aRealSubEvalArrPtr))
			aRealSubEvalArrPtr{$iParciales}->{$s}:=-10
		End for 
		
		Case of 
			: (aNtaRegEximicion{$i}>0)
				aSubEvalStatus{$s}:="X"
			: ((aNtaStatus{$i}="Ret@") | (aNtaStatus{$i}="Promo@"))
				aSubEvalStatus{$s}:="R"
			Else 
				aSubEvalStatus{$s}:="Activo"
		End case 
		aSubEvalOrden{$s}:=aNtaOrden{$i}
	Else 
		If (aSubEvalStdNme{$el}#aNtaStdNme{$i})
			aSubEvalStdNme{$el}:=aNtaStdNme{$i}
		End if 
		If (aSubEvalCurso{$el}#aNtaCurso{$i})
			aSubEvalCurso{$el}:=aNtaCurso{$i}
		End if 
		Case of 
			: (aNtaRegEximicion{$i}>0)
				aSubEvalStatus{$el}:="X"
			: ((aNtaStatus{$i}="Ret@") | (aNtaStatus{$i}="Promo@"))
				aSubEvalStatus{$el}:="R"
			Else 
				aSubEvalStatus{$el}:="Activo"
		End case 
		If (aSubEvalOrden{$el}#aNtaOrden{$i})
			aSubEvalOrden{$el}:=aNtaOrden{$i}
		End if 
	End if 
End for 

For ($i;Size of array:C274(aSubEvalID);1;-1)
	$el:=Find in array:C230(aNtaIdAlumno;aSubEvalID{$i})
	If ($el=-1)
		$s:=Size of array:C274(aSubEvalID)+1
		AT_Delete ($i;1;->aSubEvalID;->aSubEvalStdNme;->aSubEvalCurso;->aSubEvalStatus;->aSubEvalOrden;->aSubEval1;->aSubEval2;->aSubEval3;->aSubEval4;->aSubEval5;->aSubEval6;->aSubEval7;->aSubEval8;->aSubEval9;->aSubEval10;->aSubEval11;->aSubEval12;->aSubEvalP1;->aSubEvalControles;->aSubEvalPresentacion)
		AT_Delete ($i;1;->aRealSubEval1;->aRealSubEval2;->aRealSubEval3;->aRealSubEval4;->aRealSubEval5;->aRealSubEval6;->aRealSubEval7;->aRealSubEval8;->aRealSubEval9;->aRealSubEval10;->aRealSubEval11;->aRealSubEval12;->aRealSubEvalP1;->aRealSubEvalControles;->aRealSubEvalPresentacion)
	End if 
End for 


For ($k;1;12)
	If (Size of array:C274(aSubEvalArrPtr{$k}->)>Size of array:C274(aSubEvalID))
		AT_ResizeArrays (aSubEvalArrPtr{$k};Size of array:C274(aSubEvalID))
		AT_ResizeArrays (aRealSubEvalArrPtr{$k};Size of array:C274(aSubEvalID))
	End if 
End for 
If (Size of array:C274(aRealSubEvalP1)>Size of array:C274(aSubEvalID))
	AT_ResizeArrays (->aRealSubEvalP1;Size of array:C274(aSubEvalID))
End if 
If (Size of array:C274(aSubEvalP1)>Size of array:C274(aSubEvalID))
	AT_ResizeArrays (->aSubEvalP1;Size of array:C274(aSubEvalID))
End if 
If (Size of array:C274(aSubEvalControles)>Size of array:C274(aSubEvalID))
	AT_ResizeArrays (->aSubEvalControles;Size of array:C274(aSubEvalID))
End if 
If (Size of array:C274(aSubEvalPresentacion)>Size of array:C274(aSubEvalID))
	AT_ResizeArrays (->aSubEvalPresentacion;Size of array:C274(aSubEvalID))
End if 
If (Size of array:C274(aRealSubEvalControles)>Size of array:C274(aSubEvalID))
	AT_ResizeArrays (->aRealSubEvalControles;Size of array:C274(aSubEvalID))
End if 
If (Size of array:C274(aRealSubEvalPresentacion)>Size of array:C274(aSubEvalID))
	AT_ResizeArrays (->aRealSubEvalPresentacion;Size of array:C274(aSubEvalID))
End if 

  //MONO TICKET 187315 
If (Size of array:C274(aSubEvalNombreParciales)=0)
	ARRAY TEXT:C222(aSubEvalNombreParciales;12)
	For ($i;1;12)
		aSubEvalNombreParciales{$i}:=__ ("Parcial")+" "+String:C10($i)
	End for 
Else 
	ARRAY TEXT:C222(aSubEvalNombreParciales;12)
End if 

