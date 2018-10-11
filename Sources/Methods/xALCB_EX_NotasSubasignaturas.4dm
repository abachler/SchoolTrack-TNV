//%attributes = {}
  //xALCB_EX_NotasSubasignaturas


C_BOOLEAN:C305($0)
C_LONGINT:C283($1;$2)
C_LONGINT:C283(vCol;vRow)
C_REAL:C285($nValue)
_O_C_STRING:C293(255;$value)

If ($2=8)  //soft deselect
	$0:=False:C215
Else 
	$0:=True:C214
End if 
If (AL_GetCellMod (xALP_SubEvals)=1)
	$stop:=False:C215
	modNotas:=True:C214
	modSubEvals:=True:C214
	AL_GetCurrCell (xALP_SubEvals;vCol;vRow)
	
	ARRAY TEXT:C222($aArrayNames;0)
	$err:=AL_GetArrayNames (xALP_SubEvals;$aArrayNames)
	$arrayName:=$aArrayNames{vcol}
	
	
	
	
	If (vCol>3)
		Case of 
			: ($arrayName="aSubEvalP1")
				$value:=aSubEvalP1{vRow}
				$arrPtr:=->aSubEvalP1
				$realArrPtr:=->aRealSubEvalP1
			: ($arrayName="aSubEvalControles")
				$value:=aSubEvalControles{vRow}
				$arrPtr:=->aSubEvalControles
				$realArrPtr:=->aRealSubEvalControles
			: ($arrayName="aSubEval@")
				$arrPtr:=Get pointer:C304($arrayName)
				$value:=$arrPtr->{vrow}
				$realArrPtr:=Get pointer:C304(Replace string:C233($arrayName;"aSubEval";"aRealSubEval"))
				
		End case 
		
		If ($value#"")
			$nValue:=EV2_ValidaIngreso ($value)
			$stringValue:=EV2_Real_a_Literal ($nValue;vi_lastGradeView;vlNTA_DecimalesParciales)
		Else 
			$nValue:=-10
			$stringValue:=""
		End if 
		
		If (($value#"") & ($stringValue=""))
			$arrPtr->{vRow}:=$stringValue
			<>crtSEvalPerPtr->{vRow}:=$stringValue
			$realArrPtr->{vRow}:=$nValue
			AL_GotoCell (xALP_SubEvals;vCol;vRow)
		Else 
			$arrPtr->{vRow}:=$stringValue
			<>crtSEvalPerPtr->{vRow}:=$stringValue
			$realArrPtr->{vRow}:=$nValue
		End if 
		
		
		
		
		If (Not:C34($stop))  //if there is no entry data error
			$el:=Find in array:C230(al_IdAlumnoNotasModificadas;aSubEvalID{vRow})
			If ($el<0)
				APPEND TO ARRAY:C911(al_IdAlumnoNotasModificadas;aSubEvalID{vRow})
			End if 
			ASsev_Average (vRow)
			
			  //If (◊gNaColor)
			ARRAY INTEGER:C220(aInt2D1;0;0)
			NTA_SetSingleCellColorsev ($realArrPtr->{vRow})
			  //***** 20110530 RCH Se seteaba vCol:=4 y se estaba coloreando la primera parcial (ticket 99997)...
			  //vCol:=4
			vCol:=Find in array:C230($aArrayNames;"aSubEvalP1")
			  //***** 20110530 RCH
			NTA_SetSingleCellColorsev (aRealSubEvalP1{vRow})
			
			AL_UpdateArrays (xALP_SubEvals;-1)
			  //End if 
		End if 
	End if 
End if 
