//%attributes = {}
  //ACTAS_PLPPage1


$err:=PL_SetArraysNam (pl_acta;1;6;"alActas_ColumnNumber";"aC0";"aCRUN";"aCSex";"aCBirthDate";"aCLocality")
For ($i;1;vi_columns)
	  //arrPtr:=Get pointer("aC"+String($i))
	R:=$i+6
	$err:=PL_SetArraysNam (pl_acta;R;1;"aC"+String:C10($i))
End for 
$err:=PL_SetArraysNam (pl_acta;vi_columns+7;1;"aC37")
PL_SetFormat (pl_acta;1;"##";2;0;0)
PL_SetFormat (pl_acta;3;"";2;0;0)
PL_SetFormat (pl_acta;4;"";2;0;0)
PL_SetWidths (pl_acta;1;6;iNo;iNames;iRut;iSex;iBirthDate;iComuna)

For ($i;1;vi_columns)
	PL_SetFormat (pl_acta;$i+6;"";2;0;0)
	PL_SetWidths (pl_acta;$i+6;1;colwidth)
End for 
PL_SetWidths (pl_acta;vi_columns+7;1;obswidth)
PL_SetFormat (pl_acta;vi_columns+7;"";0;0;0)
PL_SetHdrOpts (pl_acta;0;0)
PL_SetColOpts (pl_acta;0;0)
PL_SetDividers (pl_acta;0.25;"Black";"Black";0;0.25;"Black";"Black";0)
PL_SetFrame (pl_acta;0.25;"Black";"Black";0;0.25;"Black";"Black";0)

PL_SetStyle (pl_acta;0;vs_ActaFont;vi_FontSize;0)

  //193355 ajusto tamaño de letra a 3 antes estaba en 5 ABC 2017/11/22
PL_SetStyle (pl_acta;3;"Tahoma";3;0)


_O_PLATFORM PROPERTIES:C365($platForm)
Case of 
	: ($platform=3)
		Case of 
			: (Size of array:C274(alActas_ColumnNumber)<=35)
				PL_SetHeight (pl_acta;0;0;0;3)
			: (Size of array:C274(alActas_ColumnNumber)<=41)
				PL_SetHeight (pl_acta;0;0;0;2)
			: (Size of array:C274(alActas_ColumnNumber)<=50)
				PL_SetHeight (pl_acta;0;0;0;1)
			Else 
				PL_SetHeight (pl_acta;0;0;0;0)
		End case 
	Else 
		Case of 
			: (Size of array:C274(alActas_ColumnNumber)<=35)
				PL_SetHeight (pl_acta;0;0;0;3)
			: (Size of array:C274(alActas_ColumnNumber)<=45)
				PL_SetHeight (pl_acta;0;0;0;2)
			: (Size of array:C274(alActas_ColumnNumber)<=50)
				PL_SetHeight (pl_acta;0;0;0;1)
			Else 
				PL_SetHeight (pl_acta;0;0;0;0)
		End case 
End case 
  //End if 