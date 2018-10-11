  // [xxSTR_EstilosEvaluacion].Configuration.lbEsfuerzo()
  //
  //
  // creado por: Alberto Bachler Klein: 15-07-16, 11:41:37
  // -----------------------------------------------------------
C_LONGINT:C283($l_abajo;$l_alto;$l_ancho;$l_arr;$l_arriba;$l_columna;$l_der;$l_derecha;$l_fila;$l_izq)
C_LONGINT:C283($l_izquierda)
C_POINTER:C301($y_antesEdicionDescripcion;$y_antesEdicionFactor;$y_antesEdicionIndicador;$y_descripciones;$y_factores;$y_indicadores;$y_variable)
C_REAL:C285($r_factor)
C_TEXT:C284($t_indicador)

ARRAY BOOLEAN:C223($ab_visibles;0)
ARRAY POINTER:C280($ay_estilos;0)
ARRAY POINTER:C280($ay_variableColumnas;0)
ARRAY POINTER:C280($ay_variableEncabezados;0)
ARRAY TEXT:C222($at_nombreColumnas;0)
ARRAY TEXT:C222($at_nombreEncabezados;0)

$y_antesEdicionIndicador:=OBJECT Get pointer:C1124(Object named:K67:5;"antesEdicionIndicador_esfuerzo")
$y_antesEdicionDescripcion:=OBJECT Get pointer:C1124(Object named:K67:5;"antesEdicionDescripcion_esfuerzo")
$y_antesEdicionFactor:=OBJECT Get pointer:C1124(Object named:K67:5;"antesEdicionFactor_esfuerzo")

$y_indicadores:=OBJECT Get pointer:C1124(Object named:K67:5;"esfuerzo_indicador")
$y_descripciones:=OBJECT Get pointer:C1124(Object named:K67:5;"esfuerzo_descripcion")
$y_factores:=OBJECT Get pointer:C1124(Object named:K67:5;"esfuerzo_factor")

LISTBOX GET ARRAYS:C832(*;OBJECT Get name:C1087;$at_nombreColumnas;$at_nombreEncabezados;$ay_variableColumnas;$ay_variableEncabezados;$ab_visibles;$ay_estilos)
LISTBOX GET CELL POSITION:C971(*;OBJECT Get name:C1087;$l_columna;$l_fila;$y_variable)


Case of 
	: ((Form event:C388=On Clicked:K2:4) & (Contextual click:C713))
		EVS_MenuContextualEsfuerzo 
		
		
		
	: (Form event:C388=On Before Data Entry:K2:39)
		Case of 
			: ($at_nombreColumnas{$l_columna}="esfuerzo_indicador")
				$y_antesEdicionIndicador->:=$y_indicadores->{$l_fila}
			: ($at_nombreColumnas{$l_columna}="esfuerzo_descripcion")
				$y_antesEdicionDescripcion->:=$y_descripciones->{$l_fila}
			: ($at_nombreColumnas{$l_columna}="esfuerzo_factor")
				$y_antesEdicionFactor->:=$y_factores->{$l_fila}
		End case 
		
	: (Form event:C388=On Clicked:K2:4)
		  //LISTBOX GET CELL POSITION(*;"lbesfuerzo";$l_columna;$l_fila)
		  //LISTBOX GET CELL COORDINATES(*;"lbesfuerzo";5;$l_fila;$l_izquierda;$l_arriba;$l_derecha;$l_abajo)
		  //$l_ancho:=IT_Objeto_Ancho ("menuContextual_esfuerzo")
		  //$l_alto:=IT_Objeto_Alto ("menuContextual_esfuerzo")
		  //OBJECT GET COORDINATES(*;"menuContextual_esfuerzo";$l_izq;$l_arr;$l_der;$l_abajo)
		  //OBJECT SET COORDINATES(*;"menuContextual_esfuerzo";$l_derecha+3;$l_arriba+6)
		  //OBJECT SET VISIBLE(*;"menuContextual_esfuerzo";$l_fila>0)
		EVS_FijaEstadoObjetosInterfaz 
		
	: (Form event:C388=On Data Change:K2:15)
		$t_indicador:=$y_indicadores->{$l_fila}
		Case of 
			: (($at_nombreColumnas{$l_columna}="esfuerzo_indicador") & ($t_indicador#$y_antesEdicionIndicador->))
				Case of 
					: (AT_CountValueOccurrences ($y_indicadores;->$t_indicador)>1)
						ModernUI_Notificacion (__ ("Tabla de indicadores de esfuerzo");__ ("El indicador ya existe en la tabla de indicadores de esfuerzo.\r\rPor favor ingrese un indicador válido."))
						$y_indicadores->{$l_fila}:=$y_antesEdicionFactor->
						EDIT ITEM:C870(*;"esfuerzo_indicador";$l_fila)
					: (Length:C16($t_indicador)>5)
						ModernUI_Notificacion (__ ("Tabla de indicadores de esfuerzo");__ ("El indicador no puede sobrepasar 5 caracteres.\r\rPor favor ingrese un indicador válido."))
						$y_indicadores->{$l_fila}:=$y_antesEdicionFactor->
						EDIT ITEM:C870(*;"esfuerzo_indicador";$l_fila)
					: ($t_indicador#$y_antesEdicionIndicador->)
						EVS_GuardaEstiloEvaluacion 
						EVS_ActualizaIndicadorEsfuerzo ($y_antesEdicionIndicador->;$t_indicador)
						EVS_SetModified 
				End case 
				
			: ($at_nombreColumnas{$l_columna}="esfuerzo_factor")
				$r_factor:=$y_factores->{$l_fila}
				If ($r_factor#$y_antesEdicionFactor->)
					Case of 
						: (($r_factor<0) | ($r_factor>100))
							ModernUI_Notificacion (__ ("Tabla de indicadores de esfuerzo");__ ("El factor debe estar en el rango 0 a 100.\r\rPor favor ingrese un factor válido"))
							$y_factores->{$l_fila}:=$y_antesEdicionFactor->
							EDIT ITEM:C870(*;"esfuerzo_factor";$l_fila)
						Else 
							EVS_SetModified 
					End case 
				End if 
				
		End case 
End case 