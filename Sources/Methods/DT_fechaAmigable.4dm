//%attributes = {}
  // DT_fechaAmigable()
  // Por: Alberto Bachler: 09/11/13, 16:10:10
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

$d_Fecha:=$1
$l_formatoFecha:=Internal date short special:K1:4

Case of 
	: (Count parameters:C259=2)
		$t_prefijoFecha:=$2
	: (Count parameters:C259=3)
		$t_prefijoFecha:=$2
		$l_formatoFecha:=$3
End case 
If ($l_formatoFecha=0)
	$l_formatoFecha:=Internal date short special:K1:4
End if 

$d_Hoy:=Current date:C33(*)

Case of 
	: (($d_Fecha-$d_Hoy)>2)
		$0:=$t_prefijoFecha+" "+String:C10($d_Fecha)
	: (($d_Fecha-$d_Hoy)=2)
		$0:=__ ("antes de ayer")
	: (($d_Fecha-$d_Hoy)=1)
		$0:=__ ("ayer")
	: (($d_Fecha-$d_Hoy)=0)
		$0:=__ ("hoy")
	: (($d_Fecha-$d_Hoy)=-1)
		$0:=__ ("mañana")
	: (($d_Fecha-$d_Hoy)=-2)
		$0:=__ ("pasado mañana")
	: (($d_Fecha-$d_Hoy)<-2)
		$0:=$t_prefijoFecha+" "+String:C10($d_Fecha)
End case 


