//%attributes = {}
  //SYS_GetFolderNam

If (False:C215)
	  //Method: SYS_GetFolderNam
	  //Written by  Alberto Bachler on 9/4/98
	  //Module: System Pack
	  //Purpose: Return the folder name
	  //Syntax:  SYS_GetFolderNam()
	  //Parameters:
	  //Copyright 1998 Transeo Chile
	<>_v:=False:C215
	
	
	  // Modified by: abachler (1/12/06)
	  //si el ruta recibido en $1 es la ruta de una carpeta (terminada con un separador) elimino el separador final para obtener la ruta de la carpeta que la contiene
	  //       If (Substring($filepath;Length($filepath))=$sep)
	  //          $filepath:=Substring($filepath;1;Length($filepath)-1)
	  //       End if 
	
End if 


  //DECLARATIONS
C_TEXT:C284($0;$1)
_O_C_STRING:C293(1;$sep)
C_LONGINT:C283($p;$m)
C_LONGINT:C283($s)

  //INITIALIZATION
$filepath:=$1

  //MAIN CODE
_O_PLATFORM PROPERTIES:C365($p;$s;$m)
If ($filepath#"")
	If ($p=3)
		$sep:="\\"
	Else 
		$sep:=":"
	End if 
	If (Substring:C12($filepath;Length:C16($filepath))=$sep)
		$filepath:=Substring:C12($filepath;1;Length:C16($filepath)-1)
	End if 
	
	If (Position:C15($sep;$1)>0)
		$last:=Substring:C12($filepath;Length:C16($filepath);1)
		While ($last#$sep)
			$filepath:=Substring:C12($1;1;Length:C16($filepath)-1)
			$last:=Substring:C12($filepath;Length:C16($filepath);1)
		End while 
	End if 
Else 
	$filepath:=""
End if 
$0:=$filepath
  //END OF MAIN CODE 


  //CLEANING


  //END OF METHOD 

