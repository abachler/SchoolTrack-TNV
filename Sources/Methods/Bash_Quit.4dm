//%attributes = {}
  //Bash_Quit


C_BOOLEAN:C305(<>vbBash_QuittingWarning)
If (Not:C34(Is compiled mode:C492))
	If (<>vbBash_QuittingWarning)
		$lockedIntegerAr:=Bash_Count_Locked_By_Type (Integer array:K8:18)
		$lockedLongintAr:=Bash_Count_Locked_By_Type (LongInt array:K8:19)
		$lockedRealAr:=Bash_Count_Locked_By_Type (Real array:K8:17)
		$lockedTextAr:=Bash_Count_Locked_By_Type (Text array:K8:16)
		$lockedStringAr:=Bash_Count_Locked_By_Type (String array:K8:15)
		$lockedDateAr:=Bash_Count_Locked_By_Type (Date array:K8:20)
		$lockedBooleanAr:=Bash_Count_Locked_By_Type (Boolean array:K8:21)
		$lockedPictureAr:=Bash_Count_Locked_By_Type (Picture array:K8:22)
		$lockedPointerAr:=Bash_Count_Locked_By_Type (Pointer array:K8:23)
		
		$lockedIntegerVar:=Bash_Count_Locked_By_Type (Is integer:K8:5)
		$lockedLongintVar:=Bash_Count_Locked_By_Type (Is longint:K8:6)
		$lockedRealVar:=Bash_Count_Locked_By_Type (Is real:K8:4)
		$lockedTextVar:=Bash_Count_Locked_By_Type (Is text:K8:3)
		$lockedStringVar:=Bash_Count_Locked_By_Type (Is string var:K8:2)
		$lockedDateVar:=Bash_Count_Locked_By_Type (Is date:K8:7)
		$lockedBooleanVar:=Bash_Count_Locked_By_Type (Is boolean:K8:9)
		$lockedPictureVar:=Bash_Count_Locked_By_Type (Is picture:K8:10)
		$lockedPointerVar:=Bash_Count_Locked_By_Type (Is pointer:K8:14)
		$lockedTimeVar:=Bash_Count_Locked_By_Type (Is time:K8:8)
		$lockedBlobVar:=Bash_Count_Locked_By_Type (Is BLOB:K8:12)
		
		$msg:=""
		$msg:=$msg+ST_Boolean2Str (($lockedIntegerVar>0);String:C10($lockedIntegerVar)+" variable(s) de tipo Integer"+"\r")
		$msg:=$msg+ST_Boolean2Str (($lockedLongintVar>0);String:C10($lockedLongintVar)+" variable(s) de tipo Longint"+"\r")
		$msg:=$msg+ST_Boolean2Str (($lockedRealVar>0);String:C10($lockedRealVar)+" variable(s) de tipo Real"+"\r")
		$msg:=$msg+ST_Boolean2Str (($lockedTextVar>0);String:C10($lockedTextVar)+" variable(s) de tipo Text"+"\r")
		$msg:=$msg+ST_Boolean2Str (($lockedStringVar>0);String:C10($lockedStringVar)+" variable(s) de tipo String"+"\r")
		$msg:=$msg+ST_Boolean2Str (($lockedDateVar>0);String:C10($lockedDateVar)+" variable(s) de tipo Date"+"\r")
		$msg:=$msg+ST_Boolean2Str (($lockedBooleanVar>0);String:C10($lockedBooleanVar)+" variable(s) de tipo Boolean"+"\r")
		$msg:=$msg+ST_Boolean2Str (($lockedPictureVar>0);String:C10($lockedPictureVar)+" variable(s) de tipo Picture"+"\r")
		$msg:=$msg+ST_Boolean2Str (($lockedPointerVar>0);String:C10($lockedPointerVar)+" variable(s) de tipo Pointer"+"\r")
		$msg:=$msg+ST_Boolean2Str (($lockedTimeVar>0);String:C10($lockedTimeVar)+" variable(s) de tipo Time"+"\r")
		$msg:=$msg+ST_Boolean2Str (($lockedBlobVar>0);String:C10($lockedBlobVar)+" variable(s) de tipo Blob"+"\r")
		
		$msg:=$msg+ST_Boolean2Str (($lockedIntegerAr>0);String:C10($lockedIntegerAr)+" arreglo(s) de tipo Integer"+"\r")
		$msg:=$msg+ST_Boolean2Str (($lockedLongintAr>0);String:C10($lockedLongintAr)+" arreglo(s) de tipo Longint"+"\r")
		$msg:=$msg+ST_Boolean2Str (($lockedRealAr>0);String:C10($lockedRealAr)+" arreglo(s) de tipo Real"+"\r")
		$msg:=$msg+ST_Boolean2Str (($lockedTextAr>0);String:C10($lockedTextAr)+" arreglo(s) de tipo Text"+"\r")
		$msg:=$msg+ST_Boolean2Str (($lockedStringAr>0);String:C10($lockedStringAr)+" arreglo(s) de tipo String"+"\r")
		$msg:=$msg+ST_Boolean2Str (($lockedDateAr>0);String:C10($lockedDateAr)+" arreglo(s) de tipo Date"+"\r")
		$msg:=$msg+ST_Boolean2Str (($lockedBooleanAr>0);String:C10($lockedBooleanAr)+" arreglo(s) de tipo Boolean"+"\r")
		$msg:=$msg+ST_Boolean2Str (($lockedPictureAr>0);String:C10($lockedPictureAr)+" arreglo(s) de tipo Picture"+"\r")
		$msg:=$msg+ST_Boolean2Str (($lockedPointerAr>0);String:C10($lockedPointerAr)+" arreglo(s) de tipo Pointer"+"\r")
		
		If ($msg#"")
			GET PICTURE FROM LIBRARY:C565("Module SchoolTrack";vpXS_IconModule)
			vsBWR_CurrentModule:="Bash"
			$msg:="Está saliendo de la aplicación y no han sido devueltas todas las variables o arre"+"glos al pool."+"\r"+"Faltan por devolver: "+"\r\r"+$msg
			$msg:=Substring:C12($msg;1;Length:C16($msg)-1)+"."
			CD_Dlog (0;$msg)
		End if 
	End if 
End if 