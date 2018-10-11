//%attributes = {}
  // ****V11**** New way to get TF4D IDs
  // $L_err:=_GetTF4Ds 
C_POINTER:C301($1)  // Row number == table number. ID 0 means table  nupmber is not used (deleted table)
C_LONGINT:C283($0;$L_err)
  //
ARRAY LONGINT:C221($rL_IDsOfTF4Ds;0)
C_LONGINT:C283($L_offset;$L_idOffset;$i;$L_max;$L_ID)
  //
  // Get the PR4D resource
C_BLOB:C604($Q_PR4D)
$L_err:=API Get Resource ("PR4D";0;$Q_PR4D)
If ($L_err=0)
	$L_offset:=94
	C_BLOB:C604($Q_tableInfos)
	$L_max:=Get last table number:C254
	ARRAY LONGINT:C221($rL_IDsOfTF4Ds;$L_max)
	For ($i;1;$L_max)
		
		If (Is table number valid:C999($i))
			SET BLOB SIZE:C606($Q_tableInfos;0)
			COPY BLOB:C558($Q_PR4D;$Q_tableInfos;$L_offset;0;24)
			If ((OK=1) & (BLOB size:C605($Q_tableInfos)=24))
				$L_idOffset:=20
				$L_ID:=BLOB to longint:C551($Q_tableInfos;Native byte ordering:K22:1;$L_idOffset)
				
				$rL_IDsOfTF4Ds{$i}:=$L_ID
				
				If (False:C215)  // Debug with trace mode
					C_BLOB:C604($Q)
					$err:=API Get Resource ("TF4D";$L_ID;$Q)
				End if 
				
			Else 
				$L_err:=-1234
			End if 
			$L_offset:=$L_offset+24
		Else 
			$rL_IDsOfTF4Ds{$i}:=0
		End if 
		If ($L_err#0)
			$i:=$L_max
		End if 
	End for 
End if 
  //
$0:=$L_Err
COPY ARRAY:C226($rL_IDsOfTF4Ds;$1->)