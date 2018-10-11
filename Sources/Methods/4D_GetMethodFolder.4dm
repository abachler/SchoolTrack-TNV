//%attributes = {}
  // 4D_GetMethodFolder()
  // Por: Alberto Bachler K.: 01-08-15, 10:34:10
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($0)
C_TEXT:C284($1)

C_LONGINT:C283($l_position;$l_tipoMetodo)
C_POINTER:C301($y_Tabla)
C_TEXT:C284($t_carpeta;$t_codigo;$t_nombreObjeto;$t_nombreObjetoFormulario;$t_rutaMetodo)


If (False:C215)
	C_TEXT:C284(4D_GetMethodFolder ;$0)
	C_TEXT:C284(4D_GetMethodFolder ;$1)
End if 

$t_rutaMetodo:=$1
METHOD RESOLVE PATH:C1165($t_rutaMetodo;$l_tipoMetodo;$y_Tabla;$t_nombreObjeto;$t_nombreObjetoFormulario;*)
If ($l_tipoMetodo=Path project method:K72:1)
	METHOD GET CODE:C1190($t_rutaMetodo;$t_codigo;*)
	$t_codigo:=ST_GetLine ($t_codigo;1)
	$l_position:=Position:C15("\"folder\":";$t_codigo)
	If ($l_position>0)
		$t_carpeta:=Substring:C12($t_codigo;$l_position+10)
		$t_carpeta:=Substring:C12($t_carpeta;1;Position:C15(",";$t_carpeta)-2)
	Else 
		$t_carpeta:="Nivel superior"
	End if 
End if 

$0:=$t_carpeta


