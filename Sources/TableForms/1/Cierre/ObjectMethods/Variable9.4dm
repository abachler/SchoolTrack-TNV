$path:=xfGetDirName 
If ($path#"")
	ok:=1
	$path:=$path+"PagosConProblemas.txt"
	EM_ErrorManager ("Install")
	EM_ErrorManager ("SetMode";"")
	If (SYS_TestPathName ($path)=1)
		DELETE DOCUMENT:C159($path)
	End if 
	EM_ErrorManager ("Clear")
	If (ok=1)
		$ref:=Create document:C266($path)
		$text:="Id Pagos"+"\t"+"Fecha del pago"+"\t"+"Monto en cargos"+"\t"+"Monto del pago"+"\r"
		IO_SendPacket ($ref;$text)
		For ($i;1;Size of array:C274(aQR_Longint1))
			$text:=String:C10(aQR_Longint1{$i})+"\t"+String:C10(aQR_Date2{$i};Internal date short special:K1:4)+"\t"+String:C10(aQR_Real3{$i};"|Despliegue_ACT_Pagos")+"\t"+String:C10(aQR_Real4{$i};"|Despliegue_ACT_Pagos")+"\r"
			IO_SendPacket ($ref;$text)
		End for 
		CLOSE DOCUMENT:C267($ref)
		
		$msg:="Archivo generado con éxito."+"\r"+ST_Qte ($path)+"\r\r"+"Le recomendamos abrir el archivo con Excel."
	Else 
		$msg:="No fue posible generar el archivo."
	End if 
Else 
	$msg:="No fue posible crear el archivo."
End if 
ACTcd_DlogWithShowOnDisk ($path;0;$msg)
CANCEL:C270