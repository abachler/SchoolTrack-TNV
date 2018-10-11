  // SQL_Consola.Botón()
  // Por: Alberto Bachler K.: 01-07-15, 15:24:08
  //  ---------------------------------------------
  //  ---------------------------------------------
C_LONGINT:C283($l_columnas;$l_ms)
C_TEXT:C284($t_columnas;$t_filas;$t_ms)

ARRAY BOOLEAN:C223($ab_visibles;0)
ARRAY POINTER:C280($ay_columnas;0)
ARRAY POINTER:C280($ay_encabezados;0)
ARRAY POINTER:C280($ay_estilos;0)
ARRAY TEXT:C222($at_columnas;0)
ARRAY TEXT:C222($at_encabezados;0)
C_TEXT:C284(vt_Sentencia_SQL)


LISTBOX GET ARRAYS:C832(*;"lbSQL";$at_columnas;$at_encabezados;$ay_columnas;$ay_encabezados;$ab_visibles;$ay_estilos)
LISTBOX DELETE COLUMN:C830(*;"lbSql";1;Size of array:C274($at_columnas))

$l_ms:=Milliseconds:C459
  //vt_Sentencia_SQL:=(OBJECT Get pointer(Object named;"sentencia"))->
$y_sentencia:=(OBJECT Get pointer:C1124(Object named:K67:5;"sentencia"))

GET HIGHLIGHT:C209(*;"sentencia";$l_inicio;$l_termino)
If (($l_termino-$l_inicio)>0)
	$l_numeroCaracteres:=$l_termino-$l_inicio+1
	$t_sentencia:=Substring:C12($y_sentencia->;$l_inicio;$l_numeroCaracteres)
	vt_Sentencia_SQL:=$t_sentencia
Else 
	vt_Sentencia_SQL:=$y_sentencia->
End if 

If (vt_Sentencia_SQL#"")
	If (vt_Sentencia_SQL[[Length:C16(vt_Sentencia_SQL)]]=";")
		vt_Sentencia_SQL:=Substring:C12(vt_Sentencia_SQL;1;Length:C16(vt_Sentencia_SQL)-1)
	End if 
	$l_columnas:=LISTBOX Get number of columns:C831(lbSQL)
	vt_Sentencia_SQL:=vt_Sentencia_SQL+" INTO :lbSQL;"
	Begin SQL
		EXECUTE IMMEDIATE :vt_Sentencia_SQL;
	End SQL
	$t_ms:=String:C10(Milliseconds:C459-$l_ms)+" ms ("+String:C10(Round:C94(Milliseconds:C459-$l_ms/1000;2))+" segundos)"
	LISTBOX GET ARRAYS:C832(*;"lbSQL";$at_columnas;$at_encabezados;$ay_columnas;$ay_encabezados;$ab_visibles;$ay_estilos)
	$t_columnas:="Columnas: "+String:C10(Size of array:C274($at_columnas))
	$t_filas:="Filas: "+String:C10(Size of array:C274($ay_columnas{1}->))
	OBJECT SET TITLE:C194(*;"ms";$t_ms)
	OBJECT SET TITLE:C194(*;"filas";$t_filas)
	OBJECT SET TITLE:C194(*;"columnas";$t_columnas)
End if 

