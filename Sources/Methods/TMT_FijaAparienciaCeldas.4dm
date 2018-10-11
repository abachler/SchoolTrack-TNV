//%attributes = {}
  // TMT_FijaAparienciaCeldas()
  //
  //
  // creado por: Alberto Bachler Klein: 20-07-16, 10:45:39
  // -----------------------------------------------------------
C_LONGINT:C283($i_columna;$i_columnas;$i_fila;$l_anchoactual;$l_anchoCeldas;$l_anchodisponible;$l_anchoListbox;$l_anchoResidual;$l_color1;$l_color2)
C_LONGINT:C283($l_Columna;$l_columnasDias;$l_filas;$l_indiceTipoHora;$l_nuevoAncho;$l_ultimaColumna;$l_ultimaHora;$l_ultimoColor;$l_ultimoDia)
C_POINTER:C301($y_celda_Asignada)
C_REAL:C285($r_Celda_DiaHora;$r_ultimaCelda)
C_TEXT:C284($t_nombreObjeto)

ARRAY BOOLEAN:C223($ab_visibles;0)
ARRAY POINTER:C280($ay_Columnas;0)
ARRAY POINTER:C280($ay_Encabezados;0)
ARRAY POINTER:C280($ay_estilos;0)
ARRAY TEXT:C222($at_nombreColumnas;0)
ARRAY TEXT:C222($at_nombreEncabezados;0)

$l_color1:=0x00E6F0F0
$l_color2:=0x00FFFFF5
$l_ultimoColor:=$l_color1
$l_ultimaColumna:=Choose:C955(vlSTR_Horario_SabadoLabor=1;10;9)  //MONO Ticket 144924 el resultado antes era 9;8
$l_columnasDias:=Choose:C955(vlSTR_Horario_SabadoLabor=0;5;6)

$l_filas:=LISTBOX Get number of rows:C915(*;"lbHorario")
LISTBOX GET ARRAYS:C832(*;"lbHorario";$at_nombreColumnas;$at_nombreEncabezados;$ay_Columnas;$ay_Encabezados;$ab_visibles;$ay_estilos)
  //OBJECT SET RGB COLORS(*;"lbHorario";0;0x00FFFFFF;0x00F0F0F0)
OBJECT SET RGB COLORS:C628(*;"lbHorario";0;0x00FFFFFF)

$l_anchoListbox:=IT_Objeto_Ancho ("lbhorario")
$l_anchodisponible:=$l_anchoListbox-200  //MONO Ticket 144924 ahora es 200 ya que son 4 columnas de 50
$l_anchoCeldas:=Int:C8($l_anchodisponible/$l_columnasDias)
$l_anchoactual:=LISTBOX Get column width:C834(*;$at_nombreColumnas{5})  //MONO Ticket 144924 el indice antes era 4 para comenzar en el lunes
$l_nuevoAncho:=$l_anchoCeldas*$l_columnasDias
$l_anchoResidual:=$l_anchoListbox-(200+$l_nuevoAncho)  //MONO Ticket 144924 ahora es 200 ya que son 4 columnas de 50
LISTBOX SET COLUMN WIDTH:C833(*;$at_nombreColumnas{1};50+$l_anchoResidual)
OBJECT SET VISIBLE:C603(*;"rectanguloSeleccion";False:C215)
OBJECT SET VISIBLE:C603(*;$at_nombreColumnas{10};vlSTR_Horario_SabadoLabor=1)  //MONO Ticket 144924 el indice antes era 9 para ocultar el sábado

$r_ultimaCelda:=1.1
For ($l_Columna;5;$l_ultimaColumna)  //MONO Ticket 144924 el indice antes era 4 para comenzar en el lunes
	$t_nombreObjeto:=$at_nombreColumnas{$l_Columna}
	For ($i_fila;1;$l_filas)
		$r_Celda_DiaHora:=Num:C11(String:C10($l_Columna)+","+String:C10(aiSTK_Hora{$i_fila}))
		If ($r_Celda_DiaHora#$r_ultimaCelda)
			$l_ultimoColor:=Choose:C955($l_ultimoColor=$l_color1;$l_color2;$l_color1)
			$r_ultimaCelda:=$r_Celda_DiaHora
		End if 
		LISTBOX SET ROW COLOR:C1270(*;$t_nombreObjeto;$i_fila;$l_ultimoColor;lk background color:K53:25)
	End for 
	LISTBOX SET COLUMN WIDTH:C833(*;$at_nombreColumnas{$l_columna};$l_anchoCeldas)
End for 


For ($i_fila;1;$l_filas)
	For ($i_columna;5;$l_ultimaColumna)  //MONO Ticket 144924 el indice antes era 4 para comenzar en el lunes
		$t_nombreObjeto:=$at_nombreColumnas{$i_columna}
		If (alSTK_RefTipoHora{$i_fila}<=0)
			LISTBOX SET ROW COLOR:C1270(*;$t_nombreObjeto;$i_fila;0x00FFFFFF;lk background color:K53:25)
			LISTBOX SET ROW COLOR:C1270(*;$t_nombreObjeto;$i_fila;0x00999999;lk font color:K53:24)
			$l_indiceTipoHora:=Find in array:C230(<>alSTR_Horario_RefTipoHora;alSTK_RefTipoHora{$i_fila})
			$ay_Columnas{$i_columna}->{$i_fila}:=<>atSTR_Horario_TipoHora{$l_indiceTipoHora}
		Else 
			LISTBOX SET ROW COLOR:C1270(*;$t_nombreObjeto;$i_fila;0;lk font color:K53:24)
		End if 
	End for 
	If ($i_fila>1)
		If (aiSTK_Hora{$i_fila}=aiSTK_Hora{$i_fila-1})
			$l_ColorFondo:=LISTBOX Get row color:C1271(aiSTK_Hora;$i_fila-1;lk background color:K53:25)
			LISTBOX SET ROW COLOR:C1270(aiSTK_Hora;$i_fila;$l_ColorFondo;lk background color:K53:25)
			LISTBOX SET ROW COLOR:C1270(aiSTK_Hora;$i_fila;$l_ColorFondo;lk font color:K53:24)
			LISTBOX SET ROW COLOR:C1270(atSTK_HoraAlias;$i_fila;$l_ColorFondo;lk background color:K53:25)  //MONO Ticket 144924
			LISTBOX SET ROW COLOR:C1270(atSTK_HoraAlias;$i_fila;$l_ColorFondo;lk font color:K53:24)  //MONO Ticket 144924
			LISTBOX SET ROW COLOR:C1270(alSTK_desde;$i_fila;$l_ColorFondo;lk background color:K53:25)
			LISTBOX SET ROW COLOR:C1270(alSTK_desde;$i_fila;$l_ColorFondo;lk font color:K53:24)
			LISTBOX SET ROW COLOR:C1270(alSTK_hasta;$i_fila;$l_ColorFondo;lk background color:K53:25)
			LISTBOX SET ROW COLOR:C1270(alSTK_hasta;$i_fila;$l_ColorFondo;lk font color:K53:24)
		Else 
			$l_ColorFondo:=LISTBOX Get row color:C1271(aiSTK_Hora;$i_fila-1;lk background color:K53:25)
			If ($l_ColorFondo=color RGB whitesmoke)
				LISTBOX SET ROW COLOR:C1270(aiSTK_Hora;$i_fila;color RGB white;lk background color:K53:25)
				LISTBOX SET ROW COLOR:C1270(aiSTK_Hora;$i_fila;color RGB black;lk font color:K53:24)
				LISTBOX SET ROW COLOR:C1270(atSTK_HoraAlias;$i_fila;color RGB white;lk background color:K53:25)  //MONO Ticket 144924
				LISTBOX SET ROW COLOR:C1270(atSTK_HoraAlias;$i_fila;color RGB black;lk font color:K53:24)  //MONO Ticket 144924
				LISTBOX SET ROW COLOR:C1270(alSTK_desde;$i_fila;color RGB white;lk background color:K53:25)
				LISTBOX SET ROW COLOR:C1270(alSTK_desde;$i_fila;color RGB black;lk font color:K53:24)
				LISTBOX SET ROW COLOR:C1270(alSTK_hasta;$i_fila;color RGB white;lk background color:K53:25)
				LISTBOX SET ROW COLOR:C1270(alSTK_hasta;$i_fila;color RGB black;lk font color:K53:24)
			Else 
				LISTBOX SET ROW COLOR:C1270(aiSTK_Hora;$i_fila;color RGB whitesmoke;lk background color:K53:25)
				LISTBOX SET ROW COLOR:C1270(aiSTK_Hora;$i_fila;color RGB black;lk font color:K53:24)
				LISTBOX SET ROW COLOR:C1270(atSTK_HoraAlias;$i_fila;color RGB whitesmoke;lk background color:K53:25)  //MONO Ticket 144924
				LISTBOX SET ROW COLOR:C1270(atSTK_HoraAlias;$i_fila;color RGB black;lk font color:K53:24)  //MONO Ticket 144924
				LISTBOX SET ROW COLOR:C1270(alSTK_desde;$i_fila;color RGB whitesmoke;lk background color:K53:25)
				LISTBOX SET ROW COLOR:C1270(alSTK_desde;$i_fila;color RGB black;lk font color:K53:24)
				LISTBOX SET ROW COLOR:C1270(alSTK_hasta;$i_fila;color RGB whitesmoke;lk background color:K53:25)
				LISTBOX SET ROW COLOR:C1270(alSTK_hasta;$i_fila;color RGB black;lk font color:K53:24)
			End if 
		End if 
	Else 
		LISTBOX SET ROW COLOR:C1270(aiSTK_Hora;$i_fila;color RGB white;lk background color:K53:25)
		LISTBOX SET ROW COLOR:C1270(aiSTK_Hora;$i_fila;color RGB black;lk font color:K53:24)
		LISTBOX SET ROW COLOR:C1270(atSTK_HoraAlias;$i_fila;color RGB white;lk background color:K53:25)  //MONO Ticket 144924
		LISTBOX SET ROW COLOR:C1270(atSTK_HoraAlias;$i_fila;color RGB black;lk font color:K53:24)  //MONO Ticket 144924
		LISTBOX SET ROW COLOR:C1270(alSTK_desde;$i_fila;color RGB white;lk background color:K53:25)
		LISTBOX SET ROW COLOR:C1270(alSTK_desde;$i_fila;color RGB black;lk font color:K53:24)
		LISTBOX SET ROW COLOR:C1270(alSTK_hasta;$i_fila;color RGB white;lk background color:K53:25)
		LISTBOX SET ROW COLOR:C1270(alSTK_hasta;$i_fila;color RGB black;lk font color:K53:24)
	End if 
End for 

LISTBOX SELECT ROW:C912(*;"lbhorario";0;lk remove from selection:K53:3)
OBJECT SET VISIBLE:C603(*;"rectanguloSeleccion";False:C215)




