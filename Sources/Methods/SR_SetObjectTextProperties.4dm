//%attributes = {}
  //SR_SetObjectTextProperties

  //`xShell, Alberto Bachler
  //Metodo: SR_SetObjectTextProperties
  //Por abachler
  //Creada el 26/11/2005, 19:53:24
  //Modificaciones:
If ("DESCRIPCION"="")
	  //
End if 

  //****DECLARACIONES****
C_LONGINT:C283($area;$objectID;$action;$l_tamaño;$l_estilo;$justification;$foreRed;$foreGreen;$foreBlue;$backRed;$backGreen;$backBlue;$forePattern;$backPattern;$lineThickness;$foreColor;$backColor)
C_TEXT:C284($t_nombreFuente;$formatString)

  //****INICIALIZACIONES****
$area:=$1
$objectID:=$2
$justification:=0
$l_estilo:=0
$l_tamaño:=9
$t_nombreFuente:="Arial"
Case of 
	: (Count parameters:C259=6)
		$justification:=$6
		$l_estilo:=$5
		$l_tamaño:=$4
		$t_nombreFuente:=$3
	: (Count parameters:C259=5)
		$l_estilo:=$5
		$l_tamaño:=$4
		$t_nombreFuente:=$3
	: (Count parameters:C259=4)
		$l_tamaño:=$4
		$t_nombreFuente:=$3
	: (Count parameters:C259=3)
		$t_nombreFuente:=$3
End case 


Case of 
	: ([xShell_Reports:54]ReportType:2="hmRE")
		
		
	: ([xShell_Reports:54]ReportType:2="gSR2")
		SR_SetTextProperty (SRArea;SRObjectPrintRef;SRP_Style_FontName;$t_nombreFuente)
		SR_SetLongProperty (SRArea;SRObjectPrintRef;SRP_Style_Full;$l_estilo)
		SR_SetLongProperty (SRArea;SRObjectPrintRef;SRP_Style_Size;$l_tamaño)
		
End case 








  //****CUERPO****


  //****LIMPIEZA****

