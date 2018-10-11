//%attributes = {}
  // MÉTODO: SYS_Path2FileName
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 20/07/11, 13:44:01
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // Esta versión del método no obtiene el separador del sistema sino lo determina de acuerdo a la ruta pasada en paramétros.
  // Esto permite que pueda operar sobre una ruta correspondiente a otra plataforma
  //
  // PARÁMETROS
  // SYS_Path2FileName(ruta&t)
  // ----------------------------------------------------


  // DECLARACIONES E INICIALIZACIONES
C_LONGINT:C283($l_words)
C_TEXT:C284($1;$t_Path;$t_platFormSeparator;$t_Separator)


  // CODIGO PRINCIPAL
$t_Path:=$1
$t_platFormSeparator:=Folder separator:K24:12

Case of 
	: (Position:C15(":\\\\";$t_Path)>0)  //windows (ruta absoluta)
		$t_Separator:="\\"
	: (Position:C15("\\";$t_Path)>0)  //windows (ruta relativa)
		$t_Separator:="\\"
	: (Position:C15(":";$t_Path)>0)  //macOS
		$t_Separator:=":"
	Else 
		$0:=$t_Path
End case 

$l_words:=ST_CountWords ($t_Path;1;$t_Separator)
$0:=ST_GetWord ($t_Path;$l_words;$t_Separator)



  // VERSION ANTERIOR al 20/07/2011
  //$viLen:=Length($1)
  //$viPos:=0
  //For ($viChar;$viLen;1;-1)
  //If ($1≤$viChar≥=SYS_FolderDelimiter )
  //$viPos:=$viChar
  //$viChar:=0
  //End if
  //End for
  //If ($viPos>0)
  //$0:=Substring($1;$viPos+1)
  //Else
  //$0:=$1
  //End if