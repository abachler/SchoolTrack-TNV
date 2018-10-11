//%attributes = {}
  //ACTabc_EjecutaScriptPP 

C_LONGINT:C283($err;$i;$0;$vl_existe)
C_TEXT:C284($script;vtACTFileName;$vt_code;$2;$3;$TableNumtxt;$FieldNumtxt;$fileName)
C_POINTER:C301(vyACT_Pointer2Field)
C_BOOLEAN:C305($vb_exportador)

ARRAY TEXT:C222($at_TextArray;0)

$vt_code:=$1
$fileName:=$2
If (Count parameters:C259>=3)
	$TableNumtxt:=$3
	$FieldNumtxt:=$4
	vyACT_Pointer2Field:=Field:C253(Num:C11($TableNumtxt);Num:C11($FieldNumtxt))
	$vb_exportador:=True:C214
End if 

vtACTFileName:=$fileName

If ((Not:C34(Shift down:C543)) & (Not:C34(IT_AltKeyIsDown )))
	$script:=SR_VerificaCodigo ($vt_code)
	AT_Text2Array (->$at_TextArray;$script;"\r")
	For ($i;Size of array:C274($at_TextArray);1;-1)
		If ($vb_exportador)
			  //reemplaza $1
			$vl_existe:=Position:C15("$1";$at_TextArray{$i})
			If ($vl_existe>0)
				$vl_existe:=Position:C15(":=";$at_TextArray{$i})
				If ($vl_existe>0)
					$var:=Substring:C12($at_TextArray{$i};1;$vl_existe-1)
					$at_TextArray{$i}:=$var+":=vtACTFileName"
				End if 
			End if 
			
			  //reemplaza $2
			$vl_existe:=Position:C15("$2";$at_TextArray{$i})
			If ($vl_existe>0)
				$vl_existe:=Position:C15(":=";$at_TextArray{$i})
				If ($vl_existe>0)
					$var:=Substring:C12($at_TextArray{$i};1;$vl_existe-1)
					$at_TextArray{$i}:=$var+":=vyACT_Pointer2Field"
				End if 
			End if 
		Else 
			  //reemplaza $1
			$vl_existe:=Position:C15("$1";$at_TextArray{$i})
			If ($vl_existe>0)
				$at_TextArray{$i}:=Replace string:C233($at_TextArray{$i};"$1";"vtACTFileName")
			End if 
		End if 
	End for 
	$script:=AT_array2text (->$at_TextArray;"\r")
	EXE_Execute ($script)
Else 
	If ($vb_exportador)
		EXE_Execute ($vt_code;False:C215;"";->$fileName;->$TableNumtxt;->$FieldNumtxt)
	Else 
		EXE_Execute ($vt_code;False:C215;"";->$fileName)
	End if 
	
	  //If (False)  //FOOTRUNNER OUT !
	  //If ($vb_exportador)
	  //$err:=FRRunText ($vt_code;0;->$fileName;->$TableNumtxt;->$FieldNumtxt)
	  //Else 
	  //$err:=FRRunText ($vt_code;0;$fileName)
	  //End if 
	  //End if 
	
End if 
$0:=$err