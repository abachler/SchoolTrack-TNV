If (False:C215)
	  //============================== IDENTIFICACION ==============================
	  // Script ◊aUFFileNm
	  //Autor: Alberto Bachler
	  //Creada el 20/6/96 a 8:49 AM
	  //============================== DESCRIPCION ==============================
	  //Package:
	  //Descripción:
	  //Sintaxis:
	  //============================== MODIFICACIONES ==============================
	  //Fecha: 
	  //Autor:
	  //Descripción:
End if 
If (Self:C308->>0)
	If (<>aUFFileNo{<>aUFFileNm}#[xShell_Userfields:76]FileNo:6)
		If (Old:C35([xShell_Userfields:76]FieldID:7)=0)
			[xShell_Userfields:76]FileNo:6:=<>aUFFileNo{<>aUFFileNm}
			sFileName:=<>aUFFileNm{<>aUFFileNm}
			vField:="["+Table name:C256([xShell_Userfields:76]FileNo:6)+"]Userfields'Value"
			EXECUTE FORMULA:C63("vPointer:=»"+vField)
		Else 
			$r:=CD_Dlog (0;__ ("Este campo ya fue asignado al archivo ")+<>aUFFileNm{Find in array:C230(<>aUFFileNo;[xShell_Userfields:76]FileNo:6)}+__ (".\rNo es posible cambiar el archivo de un campo propio existente."))
		End if 
	End if 
End if 