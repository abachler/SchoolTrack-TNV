//%attributes = {}
  // ModernUI_SetStyle(nombreObjeto:&T {;estilo:&L {;tamaño:&L {;colorTextoRGB:&L {;colorFondoRGB}}}}})
If (False:C215)
	  // Por: Alberto Bachler: 25/10/13, 13:39:07
	  //  ---------------------------------------------
	  //
	  //
	  //  ---------------------------------------------
End if 
C_TEXT:C284($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)
C_LONGINT:C283($4)
C_LONGINT:C283($5)
C_LONGINT:C283($6)

C_LONGINT:C283($l_color;$l_estilo;$l_rgbColorFondo;$l_rgbColorTexto;$l_tamaño)
C_TEXT:C284($t_fuente;$t_NombreObjeto)

If (False:C215)
	C_TEXT:C284(ModernUI_SetTextAttributes ;$1)
	C_LONGINT:C283(ModernUI_SetTextAttributes ;$2)
	C_LONGINT:C283(ModernUI_SetTextAttributes ;$3)
	C_LONGINT:C283(ModernUI_SetTextAttributes ;$4)
	C_LONGINT:C283(ModernUI_SetTextAttributes ;$5)
	C_LONGINT:C283(ModernUI_SetTextAttributes ;$6)
End if 

$t_NombreObjeto:=$1
  //$l_estilo:=$2
  //$l_tamaño:=$3
  //$l_color:=$4

Case of 
	: (Count parameters:C259=1)
		$l_estilo:=-1
		
	: (Count parameters:C259=2)
		$l_estilo:=$2
		
	: (Count parameters:C259=3)
		$l_estilo:=$2
		$l_tamaño:=$3
		
	: (Count parameters:C259=3)
		$l_estilo:=$2
		$l_tamaño:=$3
		
	: (Count parameters:C259=4)
		$l_estilo:=$2
		$l_tamaño:=$3
		$l_color:=$4
		
	: (Count parameters:C259=5)
		$l_estilo:=$2
		$l_tamaño:=$3
		$l_color:=$4
		$l_rgbColorTexto:=$5
		$l_rgbColorFondo:=0x00FFFFFF
		
	: (Count parameters:C259=6)
		$l_estilo:=$2
		$l_tamaño:=$3
		$l_color:=$4
		$l_rgbColorTexto:=$5
		$l_rgbColorFondo:=$6
		
End case 

If ($l_estilo=-1)
	$t_fuente:=OBJECT Get font:C1069(*;$t_NombreObjeto)
End if 

If ($l_tamaño<=0)
	$l_tamaño:=OBJECT Get font size:C1070(*;$t_NombreObjeto)
End if 

Case of 
	: ((Count parameters:C259>4) & ($l_rgbColorTexto=0) & ($l_rgbColorFondo=0))
		OBJECT GET RGB COLORS:C1074(*;$t_NombreObjeto;$l_rgbColorTexto;$l_rgbColorFondo)
	: (($l_color=0) & (Count parameters:C259<5))
		OBJECT GET RGB COLORS:C1074(*;$t_NombreObjeto;$l_rgbColorTexto;$l_rgbColorFondo)
	: (($l_color=0) & ($l_rgbColorTexto=0))
		OBJECT GET RGB COLORS:C1074(*;$t_NombreObjeto;$l_rgbColorTexto;$l_rgbColorFondo)
End case 


If ($l_estilo>=0)
	If ($l_estilo ?? 0)
		Case of 
			: (SYS_IsMacintosh )
				$t_fuente:="Helvetica Neue Medium"
			: (SYS_IsWindows )
				$t_fuente:="Segoe UI Semibold"
		End case 
		$l_estilo:=$l_estilo ?- 0
	Else 
		Case of 
			: (SYS_IsMacintosh )
				$t_fuente:="Helvetica Neue Light"
			: (SYS_IsWindows )
				$t_fuente:="Segoe UI Light"
		End case 
	End if 
	OBJECT SET FONT STYLE:C166(*;$t_NombreObjeto;$l_estilo)
End if 

If ($t_fuente#"")
	OBJECT SET FONT:C164(*;$t_NombreObjeto;$t_fuente)
End if 

If ($l_tamaño>0)
	OBJECT SET FONT SIZE:C165(*;$t_NombreObjeto;$l_tamaño)
End if 

Case of 
	: ($l_color#0)
		OBJECT SET COLOR:C271(*;$t_NombreObjeto;$l_color)
		
	: (($l_rgbColorTexto>0) & ($l_rgbColorFondo>0))
		OBJECT SET RGB COLORS:C628(*;$t_NombreObjeto;$l_rgbColorTexto;$l_rgbColorFondo)
		
End case 

