//%attributes = {}
  // Método: SYS_EstableceVersionEstructura

C_TEXT:C284($1;$t_ItemVersion)
C_TEXT:C284($2)

$t_ItemVersion:=$1
$t_valorItem:=$2
$l_HLversion:=Load list:C383("XS_ApplicationVersion")


Case of 
	: ($t_ItemVersion="aplicacion")
		SET LIST ITEM:C385($l_HLversion;1;$t_valorItem;1)
		
	: ($t_ItemVersion="principal")  // version principal
		SET LIST ITEM:C385($l_HLversion;2;$t_valorItem;2)
		
	: ($t_ItemVersion="revision")  // revision
		SET LIST ITEM:C385($l_HLversion;3;$t_valorItem;3)
		
	: ($t_ItemVersion="build")  // build
		SET LIST ITEM:C385($l_HLversion;4;$t_valorItem;4)
		
	: ($t_ItemVersion="tipo")  // tipo version
		SET LIST ITEM:C385($l_HLversion;5;$t_valorItem;5)
		
	: ($t_ItemVersion="dts")  // dts generacion
		SET LIST ITEM:C385($l_HLversion;6;$t_valorItem;6)
		
	: ($t_ItemVersion="marcadorCodigo")  // dts generacion
		SET LIST ITEM:C385($l_HLversion;7;$t_valorItem;7)
		
	Else 
		ALERT:C41("Tipo de item de version incorrecto")
End case 

SAVE LIST:C384($l_HLversion;"XS_ApplicationVersion")
CLEAR LIST:C377($l_HLversion)