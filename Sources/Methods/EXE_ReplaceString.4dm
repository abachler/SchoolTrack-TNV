//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda 
  // Fecha y hora: 06-12-16, 09:51:33
  // ----------------------------------------------------
  // Método: EXE_ReplaceString
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------

C_LONGINT:C283($l_longitud;$l_pos;$l_posFinal)
C_POINTER:C301($y_codigo)
C_TEXT:C284($t_accion;$t_arreglo;$t_nuevoTexto;$t_original;$t_Reemplazar;$t_reemplazo;$t_tamaño)

$t_accion:=$1
$t_original:=$2
$t_reemplazo:=$3
$y_codigo:=$4

Case of 
	: ($t_accion="generales")
		$y_codigo->:=Replace string:C233($y_codigo->;$t_original;$t_reemplazo)
	: ($t_accion="arreglos")
		Case of 
			: ($t_original="ARRAY STRING")
				$l_pos:=Position:C15("ARRAY STRING";$y_codigo->;1;$l_longitud)
				While ($l_pos>0)
					$t_Reemplazar:=""
					$t_nuevoTexto:=""
					$l_posFinal:=Position:C15(")";$y_codigo->;$l_pos)
					$l_largoTexto:=($l_posFinal-$l_pos)+1
					$t_Reemplazar:=Substring:C12($y_codigo->;$l_pos;$l_largoTexto)
					$t_arreglo:=ST_GetWord ($t_Reemplazar;2;";")
					$t_tamaño:=Replace string:C233(ST_GetWord ($t_Reemplazar;3;";");")";"")
					$t_nuevoTexto:="ARRAY TEXT("+$t_arreglo+";"+$t_tamaño+")"
					$y_codigo->:=Replace string:C233($y_codigo->;$t_Reemplazar;$t_nuevoTexto)
					$l_pos:=Position:C15("ARRAY STRING";$y_codigo->;1;$l_longitud)
				End while 
				
		End case 
End case 


