//%attributes = {}
  // (PM) 4D_GetTF4DResourceIDs
  // Fills an array with the TF4D resource ID for each table
  // The index in the array corresponds to the table number
  // $1 = Pointer to longint array

C_POINTER:C301($1;$vp_Array)
C_LONGINT:C283($vl_Error;$vl_Offset1;$vl_TableNr;$vl_Offset2)
C_BLOB:C604($vx_data;$vx_TableInfos)

$vp_Array:=$1

CLEAR VARIABLE:C89($vp_Array->)

  // Get the PR4D resource
$vl_Error:=API Get Resource ("PR4D";0;$vx_data)

If ($vl_Error=0)
	
	$vl_Offset1:=94
	ARRAY LONGINT:C221($vp_Array->;Get last table number:C254)
	
	For ($vl_TableNr;1;Get last table number:C254)
		
		If (Is table number valid:C999($vl_TableNr))
			
			SET BLOB SIZE:C606($vx_TableInfos;0)
			COPY BLOB:C558($vx_data;$vx_TableInfos;$vl_Offset1;0;24)
			
			If ((OK=1) & (BLOB size:C605($vx_TableInfos)=24))
				$vl_Offset2:=20
				$vp_Array->{$vl_TableNr}:=BLOB to longint:C551($vx_TableInfos;Native byte ordering:K22:1;$vl_Offset2)
			Else 
				$vl_Error:=-1234
			End if 
			
			$vl_Offset1:=$vl_Offset1+24
		Else 
			$vp_Array->{$vl_TableNr}:=0
		End if 
		
		If ($vl_Error#0)
			$vl_TableNr:=Get last table number:C254
		End if 
		
	End for 
	
End if 


