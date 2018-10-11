//%attributes = {}
  //4D_ParseFormObject

C_LONGINT:C283($1;$resIndex)

$resIndex:=$1
$top:=$2
$left:=$3
$bottom:=$4
$right:=$5
$text:=$6
$ObjName:=$7
$varType:=$8
If (Count parameters:C259=9)
	$pages:=$9
End if 
If ($resIndex>0)
	Case of 
		: (at_ResourceType{$resIndex}="FILD")  // Parse Field
			$offset:=al_ResourceOffset{$resIndex}+8
			$top->:=BLOB to integer:C549(vx_ResData;byte;$offset)
			$left->:=BLOB to integer:C549(vx_ResData;byte;$offset)
			$bottom->:=BLOB to integer:C549(vx_ResData;byte;$offset)
			$right->:=BLOB to integer:C549(vx_ResData;byte;$offset)
			$offset:=$offset+4
			$length:=BLOB to longint:C551(vx_ResData;byte;$offset)
			$text->:=BLOB to text:C555(vx_ResData;Mac Pascal string:K22:8;$offset)
			If (Dec:C9(Length:C16($text->)/2)=0)
				$offset:=$offset+9
			Else 
				$offset:=$offset+8
			End if 
			$length:=BLOB to longint:C551(vx_ResData;byte;$offset)
			$ObjName->:=BLOB to text:C555(vx_ResData;Mac Pascal string:K22:8;$offset)
			$varType->:=""
		: (at_ResourceType{$resIndex}="GRPB")  // Parse Groupbox
			$offset:=al_ResourceOffset{$resIndex}+8
			$top->:=BLOB to integer:C549(vx_ResData;byte;$offset)
			$left->:=BLOB to integer:C549(vx_ResData;byte;$offset)
			$bottom->:=BLOB to integer:C549(vx_ResData;byte;$offset)
			$right->:=BLOB to integer:C549(vx_ResData;byte;$offset)
			$offset:=$offset+9
			$length:=BLOB to longint:C551(vx_ResData;byte;$offset)
			$text->:=BLOB to text:C555(vx_ResData;Mac text without length:K22:10;$offset;$length)
			$ObjName->:=BLOB to text:C555(vx_ResData;Mac Pascal string:K22:8;$offset)
			$varType->:=""
		: (at_ResourceType{$resIndex}="TEXT")  // parse text...
			$offset:=al_ResourceOffset{$resIndex}+8
			$top->:=BLOB to integer:C549(vx_ResData;byte;$offset)
			$left->:=BLOB to integer:C549(vx_ResData;byte;$offset)
			$bottom->:=BLOB to integer:C549(vx_ResData;byte;$offset)
			$right->:=BLOB to integer:C549(vx_ResData;byte;$offset)
			$offset:=$offset+9
			$length:=BLOB to longint:C551(vx_ResData;byte;$offset)
			$text->:=BLOB to text:C555(vx_ResData;Mac text without length:K22:10;$offset;$length)
			$ObjName->:=BLOB to text:C555(vx_ResData;Mac Pascal string:K22:8;$offset)
			$varType->:=""
		: (at_ResourceType{$resIndex}="VAR ")  // parse variable...
			$offset:=al_ResourceOffset{$resIndex}+8
			$top->:=BLOB to integer:C549(vx_ResData;byte;$offset)
			$left->:=BLOB to integer:C549(vx_ResData;byte;$offset)
			$bottom->:=BLOB to integer:C549(vx_ResData;byte;$offset)
			$right->:=BLOB to integer:C549(vx_ResData;byte;$offset)
			$offset:=$offset+8
			$text->:=BLOB to text:C555(vx_ResData;Mac Pascal string:K22:8;$offset)
			If (Dec:C9(Length:C16($text->)/2)=0)
				$offset:=$offset+1
			End if 
			$nameSize:=vx_ResData{$offset}
			If ($nameSize=0)
				$offset:=$offset+1
				$nameSize:=vx_ResData{$offset}
			End if 
			$offset:=$offset+1+$nameSize
			$variableType:=BLOB to longint:C551(vx_ResData;byte;$offset)
			Case of 
				: ($variableType=0)
					$varType->:="enterable variable"
				: ($variableType=1)
					$varType->:="non-enterable variable"
				: ($variableType=2)
					$varType->:="boton"
				: ($variableType=3)
					$varType->:="boton de opcion"
				: ($variableType=4)
					$varType->:="casilla de seleccion"
				: ($variableType=6)
					$varType->:="area de desplazamiento"
				: ($variableType=7)
					$varType->:="boton invisible"
				: ($variableType=8)
					$varType->:="boton inverso"
				: ($variableType=9)
					$varType->:="boton imagen de opcion"
				: ($variableType=11)
					$varType->:="Plugin-area"
				: ($variableType=12)
					$varType->:="termometro"
				: ($variableType=13)
					$varType->:="regla"
				: ($variableType=14)
					$varType->:="dial"
				: ($variableType=16)
					$varType->:="pestaña"
				: ($variableType=17)
					$varType->:="menu imagen desplegable"
				: ($variableType=18)
					$varType->:="boton 3D"
				: ($variableType=19)
					$varType->:="casilla de seleccion 3D"
				: ($variableType=20)
					$varType->:="boton de opcion 3D"
				: ($variableType=22)
					$varType->:="rejilla de botones"
				: ($variableType=23)
					$varType->:="lista jerarquica"
				: ($variableType=24)
					$varType->:="menu jerarquico desplegable"
				: ($variableType=25)
					$varType->:="Combo box"
				: ($variableType=26)
					$varType->:="menu desplegable"
				: ($variableType=27)
					$varType->:="boton imagen"
				: ($variableType=28)
					$varType->:="boton defecto"
				: ($variableType=29)
					$varType->:="separador"
				Else 
					$varType->:=""
			End case 
			$offset:=$offset+20
			$ObjName->:=BLOB to text:C555(vx_ResData;Mac Pascal string:K22:8;$offset)
		: (at_ResourceType{$resIndex}="PAG#")  // parse # of pages...
			$offset:=al_ResourceOffset{$resIndex}+8
			$pages->:=BLOB to integer:C549(vx_ResData;byte;$offset)
			$top->:=0
			$left->:=0
			$bottom->:=0
			$right->:=0
			$text->:=""
			$ObjName->:=""
			$varType->:=""
		: (at_ResourceType{$resIndex}="PAGE")  // parse Page separator...
			$offset:=al_ResourceOffset{$resIndex}+8
			$pages->:=BLOB to integer:C549(vx_ResData;byte;$offset)
			$top->:=0
			$left->:=0
			$bottom->:=0
			$right->:=0
			$text->:=""
			$ObjName->:=""
			$varType->:=""
	End case 
	$text->:=XML_GetValidXMLText ($text->;False:C215)
End if 