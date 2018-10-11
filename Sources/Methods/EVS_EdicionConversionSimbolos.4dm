//%attributes = {}
  // EVS_EdicionConversionSimbolos()
  //
  //
  // creado por: Alberto Bachler Klein: 26-06-16, 10:01:31
  // -----------------------------------------------------------
C_BOOLEAN:C305($b_rangoCompatibleConAnterior;$b_rangoCompatibleConSiguiente;$b_rangoValido)
C_LONGINT:C283($i_fila;$l_columna;$l_decimales;$l_fila;$l_indice;$l_modoConversion;$l_opcion;$l_posicion)
C_POINTER:C301($y_antesEdicionDescripcion;$y_antesEdicionRangoConversion;$y_antesEdicionRangoDesde;$y_antesEdicionRangoHasta;$y_antesEdicionSimbolo;$y_conversion;$y_conversionPct;$y_desde;$y_hasta;$y_RealDesde)
C_POINTER:C301($y_RealHasta;$y_simbolo;$y_simboloDescripcion;$y_variable)
C_REAL:C285($r_desdeRangoAnterior;$r_desdeRangoSiguiente;$r_evaluacion;$r_evaluationCorregida;$r_finRangoActual;$r_finRangoAnteriorActual;$r_finRangoAnteriorNuevo;$r_hastaRangoAnterior;$r_inicioRangoActual;$r_inicioRangoAnteriorNuevo)
C_REAL:C285($r_inicioRangoSiguiente;$r_intervalo;$r_MaxDiferencia;$r_maximoEscala;$r_minimoEscala;$r_nuevoFinRangoSiguiente;$r_nuevoInicioRangoSiguiente;$r_rangoDesdeEditado;$r_rangohastaEditado;$r_realEvaluacion)
C_TEXT:C284($t_conversion;$t_descripcion;$t_diferencia;$t_finRangoAnteriorActual;$t_finRangoAnteriorNuevo;$t_formato;$t_inicioRangoAnteriorNuevo;$t_inicioRangoSiguiente;$t_maxDiferencia;$t_mensaje)
C_TEXT:C284($t_nuevoFinRangoInsertado;$t_nuevoInicioRangoSiguiente;$t_separadorDecimal;$t_simbolo;$t_simboloDescripcion;$t_valorCorrecto)

ARRAY BOOLEAN:C223($ab_visibles;0)
ARRAY LONGINT:C221($al_decimales;0)
ARRAY LONGINT:C221($al_estilos;0)
ARRAY LONGINT:C221($al_visibles;0)
ARRAY POINTER:C280($ay_estilos;0)
ARRAY POINTER:C280($ay_variableColumnas;0)
ARRAY POINTER:C280($ay_variableEncabezados;0)
ARRAY TEXT:C222($at_nombreColumnas;0)
ARRAY TEXT:C222($at_nombreEncabezados;0)

$l_modoConversion:=(OBJECT Get pointer:C1124(Object named:K67:5;"modoConversionSimbolos"))->
$y_desde:=OBJECT Get pointer:C1124(Object named:K67:5;"simbolos_desde")
$y_hasta:=OBJECT Get pointer:C1124(Object named:K67:5;"simbolos_hasta")
$y_conversion:=OBJECT Get pointer:C1124(Object named:K67:5;"simbolos_conversion")
$y_RealDesde:=OBJECT Get pointer:C1124(Object named:K67:5;"simbolos_desde%")
$y_RealHasta:=OBJECT Get pointer:C1124(Object named:K67:5;"simbolos_hasta%")
$y_conversionPct:=OBJECT Get pointer:C1124(Object named:K67:5;"simbolos_conversion%")
$y_simbolo:=OBJECT Get pointer:C1124(Object named:K67:5;"simbolos_simbolo")
$y_simboloDescripcion:=OBJECT Get pointer:C1124(Object named:K67:5;"simbolos_descripcion")
$y_antesEdicionRangoDesde:=OBJECT Get pointer:C1124(Object named:K67:5;"antesEdicionRangoDesde")
$y_antesEdicionRangoHasta:=OBJECT Get pointer:C1124(Object named:K67:5;"antesEdicionRangoHasta")
$y_antesEdicionRangoConversion:=OBJECT Get pointer:C1124(Object named:K67:5;"antesEdicionRangoConversion")
$y_antesEdicionSimbolo:=OBJECT Get pointer:C1124(Object named:K67:5;"antesEdicionSimbolo")
$y_antesEdicionDescripcion:=OBJECT Get pointer:C1124(Object named:K67:5;"antesEdicionDescripcion")

Case of 
	: ($l_modoConversion=Notas)
		$r_minimoEscala:=rGradesFrom
		$r_maximoEscala:=rGradesTo
		$l_decimales:=iGradesDec
		$l_decimales:=MATH_Max (iGradesDec;iGradesDecPP;iGradesDecPF;iGradesDecNF;iGradesDecNO)
		$r_intervalo:=1/(10^$l_decimales)
	: ($l_modoConversion=Puntos)
		$r_minimoEscala:=rPointsFrom
		$r_maximoEscala:=rPointsTo
		$l_decimales:=iPointsDec
		$l_decimales:=MATH_Max (iPointsDec;iPointsDecPP;iPointsDecPF;iPointsDecNF;iPointsDecNO)
		$r_intervalo:=1/(10^$l_decimales)
	: ($l_modoConversion=Porcentaje)
		$r_minimoEscala:=1
		$r_maximoEscala:=100
		$l_decimales:=1
		$r_intervalo:=0.1  // el intervalo en porcentajes es siempre 0.1
End case 

  // determino el formato de las evaluaciones según las propiedades de la escala de referencia
GET SYSTEM FORMAT:C994(Decimal separator:K60:1;$t_separadorDecimal)
$t_formato:=Choose:C955($l_decimales>0;"##0"+$t_separadorDecimal+("0"*$l_decimales);"###0")


LISTBOX GET ARRAYS:C832(*;OBJECT Get name:C1087;$at_nombreColumnas;$at_nombreEncabezados;$ay_variableColumnas;$ay_variableEncabezados;$ab_visibles;$ay_estilos)
LISTBOX GET CELL POSITION:C971(*;OBJECT Get name:C1087;$l_columna;$l_fila;$y_variable)
Case of 
	: (Form event:C388=On Before Data Entry:K2:39)
		Case of 
			: ($at_nombreColumnas{$l_columna}="simbolos_simbolo")
				$y_antesEdicionSimbolo->:=$y_simbolo->{$l_fila}
			: ($at_nombreColumnas{$l_columna}="simbolos_Descripcion")
				$y_antesEdicionDescripcion->:=$y_simboloDescripcion->{$l_fila}
			: ($at_nombreColumnas{$l_columna}="simbolos_desde")
				$y_antesEdicionRangoDesde->:=$ay_variableColumnas{$l_columna}->{$l_fila}
			: ($at_nombreColumnas{$l_columna}="simbolos_hasta")
				$y_antesEdicionRangoHasta->:=$ay_variableColumnas{$l_columna}->{$l_fila}
			: ($at_nombreColumnas{$l_columna}="simbolos_conversion")
				$y_antesEdicionRangoConversion->:=$ay_variableColumnas{$l_columna}->{$l_fila}
		End case 
		
		
	: (Form event:C388=On Data Change:K2:15)
		
		Case of 
			: ($at_nombreColumnas{$l_columna}="simbolos_simbolo")
				$t_simbolo:=$y_simbolo->{$l_fila}
				Case of 
					: (Length:C16($t_simbolo)=0)
						ModernUI_Notificacion (__ ("Conversión a símbolos");__ ("El símbolo no puede ser vacío\r\rPor favor defínalo usando entre 1 y 5 caracteres"))
						$y_simbolo->{$l_fila}:=$y_antesEdicionSimbolo->
						EDIT ITEM:C870(*;"simbolos_simbolo";$l_fila)
					: (Length:C16($t_simbolo)>5)
						ModernUI_Notificacion (__ ("Conversión a símbolos");__ ("El símbolo no puede tener más de 5 caracteres.\r\rPor favor utilice otro símbolo"))
						$y_simbolo->{$l_fila}:=$y_antesEdicionSimbolo->
						EDIT ITEM:C870(*;"simbolos_simbolo";$l_fila)
						  //
					: (($t_simbolo="P") | ($t_simbolo="X") | ($t_simbolo="EX") | ($t_simbolo="*"))
						ModernUI_Notificacion (__ ("Conversión a símbolos");IT_SetTextStyle_Bold (->$t_simbolo)+__ (" es una expresión reservada en SchoolTrack.\r\rPor favor utilice otro símbolo"))
						$y_simbolo->{$l_fila}:=$y_antesEdicionSimbolo->
						EDIT ITEM:C870(*;"simbolos_simbolo";$l_fila)
						  //
					: (AT_CountValueOccurrences ($y_simbolo;->$t_simbolo)>1)
						$y_simbolo->{$l_fila}:=$y_antesEdicionSimbolo->
						ModernUI_Notificacion (__ ("Conversión a símbolos");__ ("El símbolo editado ya existe en la tabla de conversión.\r\rPor favor ingrese un símbolo válido."))
						EDIT ITEM:C870(*;"simbolos_simbolo";$l_fila)
				End case 
				  //
			: ($at_nombreColumnas{$l_columna}="simbolos_descripcion")
				$t_simboloDescripcion:=$y_simboloDescripcion->{$l_fila}
				If (AT_CountValueOccurrences ($y_simboloDescripcion;->$t_simboloDescripcion)>1)
					$y_simboloDescripcion->{$l_fila}:=$y_antesEdicionDescripcion->
					ModernUI_Notificacion (__ ("Conversión a símbolos");__ ("El descripción del símbolo editada ya existe en la tabla de conversión.\r\rPor favor ingrese una descripción válida."))
				End if 
				  //
				
				
			Else 
				  // valido el ingreso en la escala
				  //$r_realEvaluacion:=EV2_ValidaIngreso (String($ay_variableColumnas{$l_columna}->{$l_fila});$l_modoConversion)  // el "desde" del rango es validado y convertido a real
				
				$r_evaluacion:=$ay_variableColumnas{$l_columna}->{$l_fila}
				$r_realEvaluacion:=Choose:C955($l_modoConversion-1;Round:C94($r_evaluacion/rGradesTo*100;11);Round:C94($r_evaluacion/rPointsTo*100;11);Round:C94($r_evaluacion/$r_maximoEscala*100;11))  //ABC cambio 3 caso de choose.189357 
				If (($r_realEvaluacion>=1) & ($r_evaluacion<=100))
					$ay_variableColumnas{$l_columna}->{$l_fila}:=$r_evaluacion
					
				Else 
					Case of 
						: ($at_nombreColumnas{$l_columna}="simbolos_desde")
							$ay_variableColumnas{$l_columna}->{$l_fila}:=$y_antesEdicionRangoDesde->
						: ($at_nombreColumnas{$l_columna}="simbolos_hasta")
							$ay_variableColumnas{$l_columna}->{$l_fila}:=$y_antesEdicionRangoHasta->
						: ($at_nombreColumnas{$l_columna}="simbolos_conversion")
							$ay_variableColumnas{$l_columna}->{$l_fila}:=$y_antesEdicionRangoConversion->
					End case 
				End if 
				
				If (($r_realEvaluacion>=1) & ($r_realEvaluacion<=100))
					Case of 
						: ($at_nombreColumnas{$l_columna}="simbolos_desde")
							  // VALIDACION DEL VALOR INGRESADO EN LA COLUMNA DESDE
							  // si el valor "desde" correspondiente al símbolo es editado verifico su validez frente al valor en "hasta"
							$b_rangoValido:=($ay_variableColumnas{4}->{$l_fila}-$ay_variableColumnas{$l_columna}->{$l_fila}>=$r_intervalo)
							  //.
							
							  // verifico que el valor "desde" editado sea compatible con el valor "hasta" del rango anterior: diferencia igual (1/(10^$l_decimales))
							$b_rangoCompatibleConAnterior:=True:C214
							If ($l_fila>1)
								$r_desdeRangoAnterior:=$ay_variableColumnas{$l_columna}->{$l_fila-1}
								$r_hastaRangoAnterior:=$ay_variableColumnas{4}->{$l_fila-1}
								$r_rangoDesdeEditado:=$ay_variableColumnas{$l_columna}->{$l_fila}
								$b_rangoCompatibleConAnterior:=(($r_rangoDesdeEditado-$r_hastaRangoAnterior)=$r_intervalo)
							End if 
							  //.
							
							  // verifico que el valor "desde" editado sea compatible con el valor "desde" del rango siguiente: diferencia igual (1/(10^$l_decimales))
							$b_rangoCompatibleConSiguiente:=True:C214
							If ($l_fila<Size of array:C274($y_simbolo->))
								$r_desdeRangoSiguiente:=$ay_variableColumnas{$l_columna}->{$l_fila+1}
								$r_rangoDesdeEditado:=$ay_variableColumnas{$l_columna}->{$l_fila}
								$b_rangoCompatibleConSiguiente:=(Abs:C99($r_rangoDesdeEditado-$r_desdeRangoSiguiente)<=$r_intervalo)
							End if 
							
							
							
							Case of 
								: (($r_evaluacion>$r_minimoEscala) & ($l_fila=1))
									$t_valorCorrecto:=String:C10($r_minimoEscala;$t_formato)
									IT_SetTextStyle_Bold (->$t_valorCorrecto)
									ModernUI_Notificacion (__ ("Conversión a símbolos");__ ("El primer rango de la tabla de conversión a símbolos debe comenzar con el mínimo de la escala de referencia: ")+$t_valorCorrecto)
									$r_Evaluacion:=$r_minimoEscala
									
								: (Not:C34($b_rangoValido))
									$t_valorCorrecto:=String:C10(1/(10^$l_decimales);$t_formato)
									IT_SetTextStyle_Bold (->$t_valorCorrecto)
									ModernUI_Notificacion (__ ("Conversión a símbolos");__ ("La amplitud mínima del rango de conversión debe ser superior o igual a ")+$t_valorCorrecto)
									$r_Evaluacion:=$y_antesEdicionRangoDesde->
									
								: (Not:C34($b_rangoCompatibleConAnterior))
									$r_inicioRangoActual:=$r_evaluacion
									$r_finRangoActual:=$ay_variableColumnas{4}->{$l_fila}
									
									$r_MaxDiferencia:=1/(10^$l_decimales)
									$t_maxDiferencia:=String:C10($r_MaxDiferencia;$t_formato)
									
									$r_finRangoAnteriorActual:=$ay_variableColumnas{4}->{$l_fila-1}
									$t_finRangoAnteriorActual:=String:C10($r_finRangoAnteriorActual;$t_formato)
									$r_inicioRangoAnteriorNuevo:=$r_finRangoAnteriorActual+$r_MaxDiferencia
									$t_inicioRangoAnteriorNuevo:=String:C10($r_inicioRangoAnteriorNuevo;$t_formato)
									$r_finRangoAnteriorNuevo:=$r_inicioRangoActual-$r_MaxDiferencia
									$t_finRangoAnteriorNuevo:=String:C10($r_finRangoAnteriorNuevo;$t_formato)
									
									$r_inicioRangoActual:=$r_evaluacion
									$r_finRangoActual:=$ay_variableColumnas{4}->{$l_fila}
									
									IT_SetTextStyle_Bold (->$t_inicioRangoAnteriorNuevo)
									IT_SetTextStyle_Bold (->$t_maxDiferencia)
									$t_mensaje:=__ ("La diferencia entre el inicio del rango actual y el fin del rango anterior debe ser igual ")+$t_maxDiferencia\
										+"\r\r"+__ ("¿Que desea hacer?")+"\r"\
										+__ ("- Descartar el cambio en el rango actual")\
										+__ ("\r- Reducir el rango siguiente para fijar su limite superior en: ")+$t_finRangoAnteriorNuevo
									If (($r_finRangoAnteriorNuevo-$r_finRangoAnteriorActual)>$r_MaxDiferencia)
										$t_mensaje:=$t_mensaje+__ ("\r- Insertar un nuevo rango: ^0 a ^1")
										IT_SetTextStyle_Bold (->$t_inicioRangoAnteriorNuevo)
										IT_SetTextStyle_Bold (->$t_finRangoAnteriorNuevo)
										$t_mensaje:=Replace string:C233(Replace string:C233($t_mensaje;"^0";$t_inicioRangoAnteriorNuevo);"^1";$t_finRangoAnteriorNuevo)
										$l_opcion:=ModernUI_Notificacion (__ ("Conversión a símbolos");$t_mensaje;__ ("Descartar cambio");__ ("Modificar rango anterior");__ ("Insertar rango"))
									Else 
										$l_opcion:=ModernUI_Notificacion (__ ("Conversión a símbolos");$t_mensaje;__ ("Descartar cambio");__ ("Modificar rango anterior"))
									End if 
									
									Case of 
										: ($l_opcion=1)
											$ay_variableColumnas{$l_columna}->{$l_fila}:=$y_antesEdicionRangoDesde->
										: ($l_opcion=2)
											$ay_variableColumnas{4}->{$l_fila-1}:=$r_finRangoAnteriorNuevo
											
										: ($l_opcion=3)
											$l_indice:=$l_fila
											$t_simbolo:="S"+String:C10($l_indice)
											$l_posicion:=Find in array:C230($y_simbolo->;$t_simbolo)
											While ($l_posicion>0)
												$l_indice:=$l_indice+1
												$t_simbolo:="S"+String:C10($l_indice)
												$l_posicion:=Find in array:C230($y_simbolo->;$t_simbolo)
											End while 
											$t_descripcion:=__ ("Símbolo")+String:C10($l_indice)
											
											AT_Insert ($l_fila;1;$y_desde;$y_hasta;$y_conversion;$y_RealDesde;$y_RealHasta;$y_conversionPct;$y_simbolo;$y_simboloDescripcion)
											$y_desde->{$l_fila}:=$r_inicioRangoAnteriorNuevo
											$y_hasta->{$l_fila}:=$r_finRangoAnteriorNuevo
											$y_simbolo->{$l_fila}:=$t_simbolo
											$y_simboloDescripcion->{$l_fila}:=$t_descripcion
											  ///
											  // Modificado por: Alexis Bustamante (06-07-2017)
											$y_conversionPct->{$l_fila}:=$y_hasta->{$l_fila}
											$y_conversion->{$l_fila}:=$y_hasta->{$l_fila}
									End case 
									
									
									
									
									
								: (($y_conversion->{$l_fila}<$ay_variableColumnas{3}->{$l_fila}) | ($y_conversion->{$l_fila}>$ay_variableColumnas{4}->{$l_fila}))
									ModernUI_Notificacion (__ ("Conversión a símbolos");__ ("El valor de conversión del símbolo no puede estar fuera del rango.\rSe establecerá en el limite superior del rango ")+String:C10($ay_variableColumnas{4}->{$l_fila}))
									$y_conversion->{$l_fila}:=$ay_variableColumnas{4}->{$l_fila}
								Else 
									  // el valor ingresado es válido
									  // convierto el valor "hasta" del rango a real
									$ay_variableColumnas{$l_columna}->{$l_fila}:=$r_Evaluacion
							End case 
							
							
							
							
						: ($at_nombreColumnas{$l_columna}="simbolos_hasta")
							  // VALIDACION DEL VALOR INGRESADO EN LA COLUMNA HASTA
							  // si el valor "hasta" correspondiente al símbolo es editado verifico su validez frente al valor en "desde"
							$b_rangoValido:=($ay_variableColumnas{$l_columna}->{$l_fila}-$ay_variableColumnas{3}->{$l_fila}>=$r_intervalo)
							  //.
							
							  // verifico que el valor "hasta" editado sea compatible con el valor "desde" del rango siguiente: diferencia igual (1/(10^$l_decimales))
							$b_rangoCompatibleConSiguiente:=True:C214
							If ($l_fila<Size of array:C274($y_simbolo->))
								$r_desdeRangoSiguiente:=$ay_variableColumnas{3}->{$l_fila+1}
								$r_rangohastaEditado:=$ay_variableColumnas{$l_columna}->{$l_fila}
								$b_rangoCompatibleConSiguiente:=(($r_desdeRangoSiguiente-$r_rangohastaEditado)=$r_intervalo)
							End if 
							
							Case of 
								: (($r_evaluacion<$r_maximoEscala) & ($l_fila=Size of array:C274($y_simbolo->)))
									  ///Preguntar que hacer ya que se agrega un rango malo.
									
									  // mostrar a usuaria que el valor es mayor al rango de la escala utilizadfa, nod eberia agregar posicion adicional.
									
									ModernUI_Notificacion (__ ("Conversión a símbolos");__ ("El último rango de la tabla de conversión a símbolos debe terminar con el máximo de la escala de referencia"))
									$r_nuevoInicioRangoSiguiente:=$r_rangohastaEditado+(1/(10^$l_decimales))
									$r_nuevoFinRangoSiguiente:=$r_maximoEscala
									
									AT_Insert ($l_fila+1;1;$y_desde;$y_hasta;$y_conversion;$y_RealDesde;$y_RealHasta;$y_conversionPct;$y_simbolo;$y_simboloDescripcion)
									$y_desde->{$l_fila+1}:=$r_nuevoInicioRangoSiguiente
									$y_hasta->{$l_fila+1}:=$r_nuevoFinRangoSiguiente
									$y_simbolo->{$l_fila+1}:="S"+String:C10($l_fila+1)
									$y_simboloDescripcion->{$l_fila+1}:=__ ("Símbolo #")+String:C10($l_fila+1)
									$ay_variableColumnas{$l_columna}->{$l_fila+1}:=$r_maximoEscala
									
									
								: (Not:C34($b_rangoValido))
									If ($l_fila=1)
										ModernUI_Notificacion (__ ("Conversión a símbolos");__ ("El primer rango de la tabla de conversión a símbolos debe comenzar con el mínimo de la escala de referencia"))
									Else 
										ModernUI_Notificacion (__ ("Conversión a símbolos");__ ("El nuevo valor ingresado no es compatible con el rango. Por favor ingrese un limite superior que no entre en conflicto con los demás rangos"))
										$ay_variableColumnas{$l_columna}->{$l_fila}:=$y_antesEdicionRangoHasta->
									End if 
									
								: (Not:C34($b_rangoCompatibleConSiguiente))
									$r_inicioRangoSiguiente:=$ay_variableColumnas{3}->{$l_fila+1}
									$r_nuevoInicioRangoSiguiente:=$r_rangohastaEditado+(1/(10^$l_decimales))
									$r_nuevoFinRangoSiguiente:=$ay_variableColumnas{3}->{$l_fila+1}+$r_intervalo
									
									$t_inicioRangoSiguiente:=String:C10($r_rangohastaEditado+$r_intervalo;$t_formato)
									$t_diferencia:=String:C10($r_intervalo;$t_formato)
									IT_SetTextStyle_Bold (->$t_inicioRangoSiguiente)
									IT_SetTextStyle_Bold (->$t_diferencia)
									$t_mensaje:=__ ("La diferencia entre el limite superior del rango actual y el inicio del rango siguiente debe ser igual ")+$t_diferencia\
										+"\r\r"+__ ("¿Que desea hacer?")+"\r"\
										+__ ("- Descartar el cambio en el rango actual")\
										+__ ("\r- Modificar el rango siguiente para fijar su inicio en: ")+$t_inicioRangoSiguiente
									If (($r_inicioRangoSiguiente-$r_nuevoInicioRangoSiguiente)>($r_intervalo*2))
										$t_mensaje:=$t_mensaje+__ ("\r- Insertar un nuevo rango: ^0 a ^1")
										$t_nuevoInicioRangoSiguiente:=String:C10($r_nuevoInicioRangoSiguiente;$t_formato)
										IT_SetTextStyle_Bold (->$t_nuevoInicioRangoSiguiente)
										$t_nuevoFinRangoInsertado:=String:C10($r_nuevoFinRangoSiguiente;$t_formato)
										IT_SetTextStyle_Bold (->$t_nuevoFinRangoInsertado)
										$t_mensaje:=Replace string:C233(Replace string:C233($t_mensaje;"^0";$t_inicioRangoSiguiente);"^1";$t_nuevoFinRangoInsertado)
										$l_opcion:=ModernUI_Notificacion (__ ("Conversión a símbolos");$t_mensaje;__ ("Descartar cambio");__ ("Modificar rango siguiente");__ ("Insertar rango"))
									Else 
										$l_opcion:=ModernUI_Notificacion (__ ("Conversión a símbolos");$t_mensaje;__ ("Descartar cambio");__ ("Modificar rango siguiente"))
									End if 
									
									Case of 
										: ($l_opcion=1)
											$r_Evaluacion:=$y_antesEdicionRangoHasta->
										: ($l_opcion=2)
											$r_evaluationCorregida:=$r_rangohastaEditado+$r_intervalo
											$ay_variableColumnas{$l_columna}->{$l_fila}:=$r_Evaluacion
											$ay_variableColumnas{3}->{$l_fila+1}:=$r_evaluationCorregida
											
											  //agregamos mas intervalos
										: ($l_opcion=3)
											$l_fila:=$l_fila+1
											$l_indice:=$l_fila
											$t_simbolo:="S"+String:C10($l_indice)
											$l_posicion:=Find in array:C230($y_simbolo->;$t_simbolo)
											While ($l_posicion>0)
												$l_indice:=$l_indice+1
												$t_simbolo:="S"+String:C10($l_indice)
												$l_posicion:=Find in array:C230($y_simbolo->;$t_simbolo)
											End while 
											$t_descripcion:=__ ("Símbolo")+String:C10($l_indice)
											
											AT_Insert ($l_fila;1;$y_desde;$y_hasta;$y_conversion;$y_RealDesde;$y_RealHasta;$y_conversionPct;$y_simbolo;$y_simboloDescripcion)
											$y_desde->{$l_fila}:=$r_nuevoInicioRangoSiguiente
											$y_hasta->{$l_fila}:=$r_nuevoFinRangoSiguiente
											$y_simbolo->{$l_fila}:=$t_simbolo
											$y_simboloDescripcion->{$l_fila}:=$t_descripcion
											
											  // Modificado por: Alexis Bustamante (06-07-2017)
											$y_conversionPct->{$l_fila}:=$y_hasta->{$l_fila}
											$y_conversion->{$l_fila}:=$y_hasta->{$l_fila}
											
											
									End case 
									
								Else 
									  // el valor ingresado es válido
									  // convierto el valor "hasta" del rango a real
									$ay_variableColumnas{$l_columna}->{$l_fila}:=$r_Evaluacion
							End case 
							
					End case 
					
					  //Convierto los valores Desde y Hasta a los valores en porcentaje y verifico que los valores de conversión estén dentro del rango
					For ($i_fila;1;Size of array:C274($y_simbolo->))
						$y_RealDesde->{$i_fila}:=Choose:C955($l_modoConversion-1;Round:C94($y_desde->{$i_fila}/rGradesTo*100;11);Round:C94($y_desde->{$i_fila}/rPointsTo*100;11);Round:C94($y_desde->{$i_fila}/100*100;11))
						$y_Realhasta->{$i_fila}:=Choose:C955($l_modoConversion-1;Round:C94($y_hasta->{$i_fila}/rGradesTo*100;11);Round:C94($y_hasta->{$i_fila}/rPointsTo*100;11);Round:C94($y_hasta->{$i_fila}/100*100;11))
						If (($y_conversion->{$i_fila}<$ay_variableColumnas{3}->{$i_fila}) | ($y_conversion->{$i_fila}>$ay_variableColumnas{4}->{$i_fila}))
							  // si el valor no está dentro del rango informo al usuario y lo restablezco a su valor por defecto: el tope del rango
							$y_conversion->{$i_fila}:=$ay_variableColumnas{4}->{$i_fila}
							$y_conversionPct->{$i_fila}:=Choose:C955($l_modoConversion-1;Round:C94($y_conversion->{$i_fila}/rGradesTo*100;11);Round:C94($y_conversion->{$i_fila}/rPointsTo*100;11);Round:C94($y_conversion->{$i_fila}/100*100;11))
							$t_conversion:=String:C10($y_conversion->{$i_fila};$t_formato)
							IT_SetTextStyle_Bold (->$t_conversion)
							ModernUI_Notificacion (__ ("Conversión a símbolos");__ ("El valor de conversión del símbolo no puede estar fuera del rango.\rSe estableció la conversión del símbolo en: ")+$t_conversion)
						Else 
							$y_conversionPct->{$i_fila}:=Choose:C955($l_modoConversion-1;Round:C94($y_conversion->{$i_fila}/rGradesTo*100;11);Round:C94($y_conversion->{$i_fila}/rPointsTo*100;11);Round:C94($y_conversion->{$i_fila}/100*100;11))
						End if 
					End for 
				End if 
		End case 
End case 





