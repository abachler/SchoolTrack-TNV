//%attributes = {}
  // IT_MuestraTip(texto:T {;limite:L {;relativoAlMouse:B)
  // Por: Alberto Bachler K.: 06-02-14, 16:07:45
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

C_LONGINT:C283($l_abajo;$l_arriba;$l_derecha;$l_izquierda;$l_limite;$l_boton;$l_coordenadaX;$l_CoordenadaY)
C_TEXT:C284($t_textoTip)
C_BOOLEAN:C305($b_relativoAlMouse)

$t_textoTip:=$1
Case of 
	: (Count parameters:C259=3)
		$b_relativoAlMouse:=$3
		$l_limite:=$2
		
	: (Count parameters:C259=2)
		$l_limite:=$2
	Else 
End case 

If ($l_limite=0)
	$l_limite:=60
End if 

If ($b_relativoAlMouse)
	GET MOUSE:C468($l_coordenadaX;$l_CoordenadaY;$l_boton;*)
	$l_coordenadaX:=Int:C8($l_coordenadaX)
	$l_CoordenadaY:=Int:C8($l_coordenadaY)
	API Create Tip ($t_textoTip;$l_coordenadaX-$l_limite;$l_CoordenadaY-$l_limite;$l_CoordenadaX+$l_limite;$l_CoordenadaY+$l_limite)
	
Else 
	OBJECT SET HELP TIP:C1181(*;OBJECT Get name:C1087(Object current:K67:2);$t_textoTip)
End if 


