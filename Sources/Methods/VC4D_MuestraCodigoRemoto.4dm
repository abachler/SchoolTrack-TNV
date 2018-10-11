//%attributes = {}
  // VC4D_MuestraCodigoRemoto()
  // Por: Alberto Bachler K.: 26-02-15, 10:25:12
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BLOB:C604($x_Blob)
C_POINTER:C301($y_NS;$y_URL;$y_WSN)
C_TEXT:C284($t_codigoLocal;$t_codigoRemoto;$t_errorWS;$t_ruta)

ARRAY TEXT:C222($at_CodigoLocal;0)

WINDOW LIST:C442($al_refVentanas)
For ($i;1;Size of array:C274($al_refVentanas))
	$t_tituloVentana:=Get window title:C450($al_refVentanas{$i})
	If ($t_tituloVentana="••• @")
		WDW_SetFrontmost ($al_refVentanas{$i})
		DELAY PROCESS:C323(Current process:C322;10)
		POST KEY:C465(Character code:C91("W");256;Process number:C372("Proceso Diseño"))
		DELAY PROCESS:C323(Current process:C322;10)
	End if 
End for 

$t_ruta:=$1

$y_URL:=OBJECT Get pointer:C1124(Object named:K67:5;"URL")
$y_WSN:=OBJECT Get pointer:C1124(Object named:K67:5;"webServiceName")
$y_NS:=OBJECT Get pointer:C1124(Object named:K67:5;"nameSpace")

METHOD GET CODE:C1190($t_ruta;$t_codigoLocal;*)
AT_Text2Array (->$at_CodigoLocal;$t_codigoLocal;"\r")

WEB SERVICE SET PARAMETER:C777("ruta";$t_ruta)
$t_errorWS:=VC4D_CallWebService ("VC4Dws_ObtenCodigoRemoto";$y_URL->;$y_WSN->;$y_NS->)

If ($t_errorWS="")
	$t_servidor:=$y_URL->
	$t_servidor:=Replace string:C233($t_servidor;"https://";"")
	$t_servidor:=Replace string:C233($t_servidor;"http://";"")
	If (Position:C15(":";$t_servidor)>0)
		$t_servidor:=Substring:C12($t_servidor;1;Position:C15(":";$t_servidor)-1)
	End if 
	
	WEB SERVICE GET RESULT:C779($x_Blob;"codigoRemoto";*)  //20180514 RCH Ticket 206788
	$t_codigoRemoto:=BLOB to text:C555($x_Blob;UTF8 text without length:K22:17)
	METHOD SET CODE:C1194("VC4D_CodigoRemoto";$t_codigoRemoto;*)
	METHOD OPEN PATH:C1213("VC4D_CodigoRemoto";*)
	DELAY PROCESS:C323(Current process:C322;10)
	SET WINDOW TITLE:C213("••• "+$t_ruta+" en "+Uppercase:C13($t_servidor)+" •••";Frontmost window:C447)
	DELAY PROCESS:C323(Current process:C322;10)
End if 

