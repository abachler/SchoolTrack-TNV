  // [BBL_Préstamos].OpcionesConsola.$t_contraseña()
  // Por: Alberto Bachler: 15/10/13, 10:17:49
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
OBJECT SET FONT:C164(*;"$t_contraseña";"%Password")

C_POINTER:C301($y_objeto)
C_TEXT:C284($t_nombreObjeto;$t_valor)

$t_nombreObjeto:=OBJECT Get name:C1087(Object current:K67:2)
$y_objeto:=OBJECT Get pointer:C1124(Object current:K67:2)
Case of 
	: (Form event:C388=On Getting Focus:K2:7)
		OBJECT SET FONT:C164(*;"$t_contraseña";"%Password")
		
	: (Form event:C388=On Losing Focus:K2:8)
		If ($y_objeto->="")
			OBJECT SET FONT:C164(*;"$t_contraseña";"")
		End if 
		
	: (Form event:C388=On Data Change:K2:15)
		$t_valor:=$y_objeto->
		OT PutVariable (vl_refObjectoPreferencias_BBLci;$t_nombreObjeto;->$t_valor)
End case 


