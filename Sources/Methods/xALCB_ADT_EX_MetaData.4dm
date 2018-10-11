//%attributes = {}
  //xALCB_ADT_EX_MetaData

C_BOOLEAN:C305($0)
C_LONGINT:C283($1;$2)
C_LONGINT:C283($Col;$Row)
If ($2=8)  //soft deselect
	$0:=False:C215
Else 
	$0:=True:C214
	AL_GetCurrCell (xALP_MetaDataValues;$col;$row)
	If (AL_GetCellMod (xALP_MetaDataValues)=1)
		If ($col=3)
			Case of 
				: (alADT_MetaDataTypeLong{$row}=Is text:K8:3)
					
				: (alADT_MetaDataTypeLong{$row}=Is date:K8:7)
					atADT_MetaDataValue{$row}:=String:C10(Date:C102(atADT_MetaDataValue{$row});7)
					If (atADT_MetaDataValue{$row}=dt_GetNullDateString )
						atADT_MetaDataValue{$row}:=""
					End if 
				: (alADT_MetaDataTypeLong{$row}=Is longint:K8:6)
					$num:=Round:C94(Num:C11(atADT_MetaDataValue{$row});0)
					If ($num>0)
						atADT_MetaDataValue{$row}:=String:C10($num)
					Else 
						atADT_MetaDataValue{$row}:=""
					End if 
				: (alADT_MetaDataTypeLong{$row}=Is real:K8:4)
					$num:=Round:C94(Num:C11(atADT_MetaDataValue{$row});2)
					If ($num>0)
						atADT_MetaDataValue{$row}:=String:C10($num;"########0"+<>tXS_RS_DecimalSeparator+"00")
					Else 
						atADT_MetaDataValue{$row}:=""
					End if 
			End case 
		End if 
	End if 
End if 