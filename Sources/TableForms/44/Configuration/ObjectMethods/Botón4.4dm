  // [xxSTR_EstilosEvaluacion].Configuration.Botón4()
  //
  //
  // creado por: Alberto Bachler Klein: 16-07-16, 12:20:54
  // -----------------------------------------------------------
C_LONGINT:C283($l_abajo;$l_alto;$l_ancho;$l_arr;$l_arriba;$l_arribaLB;$l_columna;$l_der;$l_derechaLB;$l_fila)
C_LONGINT:C283($l_izq;$l_izquierda;$l_omitir)


OBJECT GET COORDINATES:C663(*;"lbesfuerzo";$l_omitir;$l_arribaLB;$l_derechaLB;$l_omitir)
LISTBOX GET CELL POSITION:C971(*;"lbesfuerzo";$l_columna;$l_fila)
$l_columna:=3
LISTBOX GET CELL COORDINATES:C1330(*;"lbesfuerzo";$l_columna;$l_fila;$l_izquierda;$l_arriba;$l_omitir;$l_abajo)
$l_ancho:=IT_Objeto_Ancho ("menuContextual_esfuerzo")
$l_alto:=IT_Objeto_Alto ("menuContextual_esfuerzo")
OBJECT GET COORDINATES:C663(*;"menuContextual_esfuerzo";$l_izq;$l_arr;$l_der;$l_abajo)
OBJECT SET COORDINATES:C1248(*;"menuContextual_esfuerzo";$l_derechaLB+3;$l_arriba+6)
GOTO OBJECT:C206(*;"lbesfuerzo")
EDIT ITEM:C870(*;"esfuerzo_indicador";$l_fila)