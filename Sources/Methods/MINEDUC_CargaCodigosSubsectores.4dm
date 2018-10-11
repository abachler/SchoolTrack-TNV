//%attributes = {}
  //MINEDUC_CargaCodigosSubsectores

C_BLOB:C604($blob)
ARRAY TEXT:C222(at_Subsector;0)
ARRAY TEXT:C222(at_CodeSubsector;0)
$ref:=Open document:C264("")
RECEIVE PACKET:C104($ref;$text;"\r")
While (ok=1)
	$ss:=ST_GetCleanString (Substring:C12($text;1;Position:C15("\t";$text)-1))
	$code:=ST_GetCleanString (Substring:C12($text;Position:C15("\t";$text)+1))
	$s:=Size of array:C274(at_Subsector)+1
	If (($ss#"") & ($code#""))
		AT_Insert ($s;1;->at_Subsector;->at_CodeSubsector)
		at_Subsector{$s}:=$ss
		at_CodeSubsector{$s}:=$code
	End if 
	RECEIVE PACKET:C104($ref;$text;"\r")
End while 
CLOSE DOCUMENT:C267($ref)


VARIABLE TO BLOB:C532(at_Subsector;$blob)
VARIABLE TO BLOB:C532(at_CodeSubsector;$blob;*)
COMPRESS BLOB:C534($blob)

$file:=SYS_CarpetaAplicacion (CLG_Estructura)+"Config"+Folder separator:K24:12+"codigos_subsectores.txt"

$ref:=Create document:C266($file)
CLOSE DOCUMENT:C267($ref)
BLOB TO DOCUMENT:C526(document;$blob)