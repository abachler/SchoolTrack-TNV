//%attributes = {}
  // Método: BWR_InputFormButtonsHandler
  //
  //
  // por Alberto Bachler Klein
  // creación 29/05/17, 13:10:53
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
C_POINTER:C301($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)

C_BOOLEAN:C305($b_noPreguntar;$b_recordIsLocked)
C_LONGINT:C283($i;$l_buttonAction;$l_Deleted;$l_recordID;$l_recordWasSaved;$l_resultado)
C_POINTER:C301($y_tabla)
C_BOOLEAN:C305(vb_guardarCambios)  //



If (False:C215)
	C_POINTER:C301(BWR_InputFormButtonsHandler ;$1)
	C_LONGINT:C283(BWR_InputFormButtonsHandler ;$2)
	C_LONGINT:C283(BWR_InputFormButtonsHandler ;$3)
End if 

C_LONGINT:C283(vl_recordDeleted)
$l_recordWasSaved:=0
vl_recordDeleted:=0
$b_recordIsLocked:=False:C215
vb_inBrowsingMode:=True:C214
$y_tabla:=$1
$l_buttonAction:=$2
If (Count parameters:C259=3)
	$l_recordID:=$3
Else 
	$l_recordID:=0
End if 


Case of 
	: (vlBWR_BrowsingMethod=BWR Browsing Disabled)
		Case of 
			: ($l_buttonAction=-3)  //user clicked the delete button
				$l_Deleted:=BWR_OnDeleteRecord ($y_tabla)
			: ($l_buttonAction=-2)  //user clicked the close box
				If (KRL_RegistroFueModificado ($y_tabla) | (vb_guardarCambios))  //198325 //ABC //  
					$b_noPreguntar:=False:C215  //esta variable
					If (USR_checkRights ("M";$y_tabla))
						$l_resultado:=BWR_SaveChanges ($y_tabla)
						Case of 
							: ($l_resultado=1)
								$l_recordWasSaved:=BWR_OnSaveRecord ($y_tabla)
								CANCEL:C270
							: ($l_resultado=3)
								CANCEL:C270
						End case 
					Else 
						CANCEL:C270
					End if 
				Else 
					CANCEL:C270
				End if 
				
			: ($l_buttonAction=-1)  //user clicked the cancel button
				$trapped:=BWR_OnCancelRecordEdition ($y_tabla)
				If (Not:C34($trapped))
					CANCEL:C270
				End if 
				
				
			: ($l_buttonAction=-4)
				$l_recordWasSaved:=BWR_OnSaveRecord ($y_tabla)
				If ($l_recordWasSaved>=0)
					CANCEL:C270
				End if 
				
			: ($l_buttonAction=0)
				$l_recordWasSaved:=BWR_OnSaveRecord ($y_tabla)
				If ($l_recordWasSaved>=0)
					CANCEL:C270
				End if 
			: ($l_buttonAction=5)
				  //saved:=fDupliRecord
			: ($l_buttonAction=6)
				$l_recordWasSaved:=BWR_ChangeCurrentRecord ($l_recordID)
				
			: ($l_buttonAction>0)
				$l_recordWasSaved:=BWR_OnSaveRecord ($y_tabla)
		End case 
		
		
		
		
		
	: (vlBWR_BrowsingMethod=BWR Standard Browsing)
		Case of 
			: ($l_buttonAction=-3)  //user clicked the delete button
				$l_Deleted:=BWR_OnDeleteRecord ($y_tabla)
				If ($l_Deleted=1)
					$l_recordWasSaved:=-1
					BWR_AfterDeleteOnLoading 
				End if 
			: ($l_buttonAction=-2)  //user clicked the close box
				If (KRL_RegistroFueModificado ($y_tabla) | (vb_guardarCambios))
					If (USR_checkRights ("M";$y_tabla))
						$l_resultado:=BWR_SaveChanges ($y_tabla)
						Case of 
							: ($l_resultado=1)
								$l_recordWasSaved:=BWR_OnSaveRecord ($y_tabla)
								CANCEL:C270
							: ($l_resultado=3)
								CANCEL:C270
						End case 
					Else 
						CANCEL:C270
					End if 
				Else 
					CANCEL:C270
				End if 
				
			: ($l_buttonAction=-1)  //user clicked the cancel button
				$trapped:=BWR_OnCancelRecordEdition ($y_tabla)
				If (Not:C34($trapped))
					CANCEL:C270
				End if 
				
			: ($l_buttonAction=-4)
				$l_recordWasSaved:=BWR_OnSaveRecord ($y_tabla)
				If ($l_recordWasSaved>=0)
					CANCEL:C270
				End if 
				
			: ($l_buttonAction=0)
				$l_recordWasSaved:=BWR_OnSaveRecord ($y_tabla)
				If ($l_recordWasSaved>=0)
					CANCEL:C270
				End if 
			: ($l_buttonAction=5)
				  //saved:=fDupliRecord
			: ($l_buttonAction=6)
				$l_recordWasSaved:=BWR_ChangeCurrentRecord ($l_recordID)
			: ($l_buttonAction>0)
				$l_recordWasSaved:=BWR_OnSaveRecord ($y_tabla)
		End case 
		
		$trapped:=dhBWR_UpdateRecordsList ($y_tabla)
		If (Not:C34($trapped))
			If ($l_Deleted#1)
				BWR_UpdateLastRecordSelected ($y_tabla)
			End if 
		End if 
		
		If (($l_buttonAction>0) & ($l_recordWasSaved>=0))
			Case of 
				: (($l_buttonAction=1) & (lBWR_recordNumber>1))
					lBWR_recordNumber:=1
				: (($l_buttonAction=2) & (lBWR_recordNumber>1))
					lBWR_recordNumber:=lBWR_recordNumber-1
				: (($l_buttonAction=3) & (lBWR_recordNumber<Size of array:C274(alBWR_recordNumber)))
					lBWR_recordNumber:=lBWR_recordNumber+1
				: (($l_buttonAction=4) & (lBWR_recordNumber<Size of array:C274(alBWR_recordNumber)))
					lBWR_recordNumber:=Size of array:C274(alBWR_recordNumber)
				: ($l_buttonAction=5)
					  //  goto
			End case 
			UNLOAD RECORD:C212($y_tabla->)
			GOTO RECORD:C242($y_tabla->;alBWR_recordNumber{lBWR_recordNumber})
			$b_recordIsLocked:=KRL_IsRecordLocked ($y_tabla)
			If (Not:C34($b_recordIsLocked))
				BWR_OnLoadingRecord ($y_tabla)
			Else 
				CANCEL:C270
			End if 
		End if 
		
		
		
		
		
	: (vlBWR_BrowsingMethod=BWR Array Browsing)
		Case of 
			: ($l_buttonAction=-3)
				$l_Deleted:=BWR_OnDeleteRecord ($y_tabla)
				vl_recordDeleted:=$l_Deleted
				REDUCE SELECTION:C351($y_tabla->;0)
				CANCEL:C270
			: ($l_buttonAction=-2)
				If (KRL_RegistroFueModificado ($y_tabla))
					$l_resultado:=BWR_SaveChanges ($y_tabla)
					Case of 
						: ($l_resultado=1)
							$l_recordWasSaved:=BWR_OnSaveRecord ($y_tabla)
							CANCEL:C270
						: ($l_resultado=3)
							CANCEL:C270
					End case 
				Else 
					CANCEL:C270
				End if 
			: ($l_buttonAction=-1)
				$trapped:=BWR_OnCancelRecordEdition ($y_tabla)
				If (Not:C34($trapped))
					CANCEL:C270
				End if 
				
			: ($l_buttonAction=0)
				$l_recordWasSaved:=BWR_OnSaveRecord ($y_tabla)
				If ($l_recordWasSaved>=0)
					CANCEL:C270
				End if 
			: ($l_buttonAction>0)
				$l_recordWasSaved:=BWR_OnSaveRecord ($y_tabla)
		End case 
		If (vb_inBrowsingMode)
			If (($l_buttonAction>0) & ($l_recordWasSaved>=0))
				Case of 
					: (($l_buttonAction=1) & (vyBWR_CustomArrayPointer->>1))
						vyBWR_CustomArrayPointer->:=1
					: (($l_buttonAction=2) & (vyBWR_CustomArrayPointer->>1))
						vyBWR_CustomArrayPointer->:=vyBWR_CustomArrayPointer->-1
					: (($l_buttonAction=3) & (vyBWR_CustomArrayPointer-><Size of array:C274(vyBWR_CustomArrayPointer->)))
						vyBWR_CustomArrayPointer->:=vyBWR_CustomArrayPointer->+1
					: (($l_buttonAction=4) & (vyBWR_CustomArrayPointer-><Size of array:C274(vyBWR_CustomArrayPointer->)))
						vyBWR_CustomArrayPointer->:=Size of array:C274(vyBWR_CustomArrayPointer->)
					: ($l_buttonAction=5)
						  //  goto
				End case 
				
				QUERY:C277($y_tabla->;vyBWR_CustonFieldRefPointer->=vyBWR_CustomArrayPointer->{vyBWR_CustomArrayPointer->})
				$b_recordIsLocked:=KRL_IsRecordLocked ($y_tabla)
				If (Not:C34($b_recordIsLocked))
					BWR_OnLoadingRecord ($y_tabla)
				Else 
					CANCEL:C270
				End if 
			End if 
		End if 
		
		
		
		
		
	: (vlBWR_BrowsingMethod=BWR Browse Selection)
		Case of 
			: ($l_buttonAction=-3)
				$l_Deleted:=BWR_OnDeleteRecord ($y_tabla)
				If ($l_Deleted=1)
					CANCEL:C270
				End if 
				
			: ($l_buttonAction=-2)
				If (KRL_RegistroFueModificado ($y_tabla))
					$l_resultado:=BWR_SaveChanges ($y_tabla)
					Case of 
						: ($l_resultado=1)
							$l_recordWasSaved:=BWR_OnSaveRecord ($y_tabla)
							CANCEL:C270
						: ($l_resultado=3)
							CANCEL:C270
					End case 
				Else 
					CANCEL:C270
				End if 
				
			: ($l_buttonAction=-1)
				$trapped:=BWR_OnCancelRecordEdition ($y_tabla)
				If (Not:C34($trapped))
					CANCEL:C270
				End if 
				
			: ($l_buttonAction=0)
				$l_recordWasSaved:=BWR_OnSaveRecord ($y_tabla)
				If ($l_recordWasSaved>=0)
					CANCEL:C270
				End if 
				
			: ($l_buttonAction>0)
				$l_recordWasSaved:=BWR_OnSaveRecord ($y_tabla)
				
				
		End case 
		If (vb_inBrowsingMode)
			If (($l_recordWasSaved>=0) & ($l_buttonAction>0))
				Case of 
					: ($l_buttonAction=1)
						FIRST RECORD:C50($y_tabla->)
					: ($l_buttonAction=2)
						PREVIOUS RECORD:C110($y_tabla->)
					: ($l_buttonAction=3)
						NEXT RECORD:C51($y_tabla->)
					: ($l_buttonAction=4)
						LAST RECORD:C200($y_tabla->)
					: ($l_buttonAction=5)
						  //goto (not used)
				End case 
				
				$b_recordIsLocked:=KRL_IsRecordLocked ($y_tabla)
				If (Not:C34($b_recordIsLocked))
					BWR_OnLoadingRecord ($y_tabla)
				Else 
					CANCEL:C270
				End if 
			End if 
		End if 
End case 

viBWR_RecordWasSaved:=$l_recordWasSaved