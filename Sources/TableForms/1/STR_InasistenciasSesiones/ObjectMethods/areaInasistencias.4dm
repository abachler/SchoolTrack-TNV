  // [xxSTR_Constants].STR_InasistenciasSesiones.areaInasistencias()
  // Por: Alberto Bachler: 03/07/13, 20:24:29
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_actualizarArea;$b_alumnoActivo;$b_celdaUnica;$b_esSeleccionContigua;$b_seleccionInvalida;$b_sesionImpartida;$b_usuarioAutorizado)
_O_C_INTEGER:C282($i_alumnos;$i_celdas;$i_columnas;$i_filas;$i_hora;$i_horas)
C_LONGINT:C283($i;$l_ausentesEnSeleccion;$l_boton;$l_columna;$l_columnaSeleccionada;$l_coordenadasCeldas;$l_ErrorALP;$l_fila;$l_filaSeleccionada;$l_hora)
C_LONGINT:C283($l_HorasEnElDia;$l_IdAlumno;$l_IdSesion;$l_InasistenciaRegistrada;$l_indexSesion;$l_itemMenu;$l_numerofila;$l_numeroHora;$l_posicionHorizontal;$l_posicionVertical)
C_LONGINT:C283($l_presenciaRegistrada;$l_presentesEnSeleccion;$l_primeraColumna;$l_primeraFila;$l_ultimaColumna;$l_ultimaFila;$l_valorCelda)
C_POINTER:C301($y_ArregloEnColumna)
C_TEXT:C284($t_popupItems;$t_tip)

ARRAY LONGINT:C221($al_Columnas;0)
ARRAY LONGINT:C221($al_Filas;0)
ARRAY LONGINT:C221($al_horasEnHorario;0)
ARRAY LONGINT:C221($al_IdAlumnos_Justificacion;0)
ARRAY LONGINT:C221($al_IdSesiones_Justificacion;0)
ARRAY LONGINT:C221($al2D_CoordenadasCeldas;2;0)
ARRAY LONGINT:C221($al2D_SeleccionVacia;2;0)

For ($i;1;Size of array:C274(aiSTR_Horario_HoraNo))
	If (alSTR_Horario_RefTipoHora{$i}=1)
		APPEND TO ARRAY:C911($al_horasEnHorario;aiSTR_Horario_HoraNo{$i})
	End if 
End for 
$l_HorasEnElDia:=Size of array:C274($al_horasEnHorario)

If (1=0)
	  //BLOQUE 1:
	  //Manejamos la seleccion para controlar que las celdas seleccionadas sean del mismo tipo(ausente/presente/impartida/asignada)
End if 
$l_ErrorALP:=AL_GetCellSel (Self:C308->;$l_primeraColumna;$l_primeraFila;$l_ultimaColumna;$l_ultimaFila;$al2D_CoordenadasCeldas)
$l_filaSeleccionada:=AL_GetClickedRow (Self:C308->)
$l_columnaSeleccionada:=AL_GetColumn (Self:C308->)

  // Para manejar de manera uniforme la seleccion de celdas en caso de celdas contiguas pongo en el arreglo de coordenadas de celdas
  // las celdas contiguas seleccionadas (ALP no lo hace)
If (Size of array:C274($al2D_CoordenadasCeldas{1})=0)
	$b_esSeleccionContigua:=True:C214
	Case of 
		: (($l_primeraFila>0) & ($l_ultimaFila=0) & ($l_primeraColumna>0) & ($l_ultimaColumna=0))
			APPEND TO ARRAY:C911($al2D_CoordenadasCeldas{1};$l_primeraColumna)
			APPEND TO ARRAY:C911($al2D_CoordenadasCeldas{2};$l_primeraFila)
		: (($l_ultimaFila>$l_primeraFila) & ($l_primeraColumna>0) & ($l_ultimaColumna=0))
			For ($i_filas;$l_primeraFila;$l_ultimaFila)
				APPEND TO ARRAY:C911($al2D_CoordenadasCeldas{1};$l_primeraColumna)
				APPEND TO ARRAY:C911($al2D_CoordenadasCeldas{2};$i_filas)
			End for 
		: (($l_ultimaFila>$l_primeraFila) & ($l_ultimaColumna>$l_primeraColumna))
			For ($i_columnas;$l_primeraColumna;$l_ultimaColumna)
				For ($i_filas;$l_primeraFila;$l_ultimaFila)
					APPEND TO ARRAY:C911($al2D_CoordenadasCeldas{1};$i_columnas)
					APPEND TO ARRAY:C911($al2D_CoordenadasCeldas{2};$i_filas)
				End for 
			End for 
		: (($l_ultimaColumna>$l_primeraColumna) & ($l_ultimaFila=$l_primeraFila))
			For ($i_columnas;$l_primeraColumna;$l_ultimaColumna)
				APPEND TO ARRAY:C911($al2D_CoordenadasCeldas{1};$i_columnas)
				APPEND TO ARRAY:C911($al2D_CoordenadasCeldas{2};$l_primeraFila)
			End for 
		: (($l_ultimaColumna=$l_primeraColumna) & ($l_ultimaFila>$l_primeraFila))
			For ($i_Filas;$l_primeraFila;$l_ultimaFila)
				APPEND TO ARRAY:C911($al2D_CoordenadasCeldas{1};$l_primeraColumna)
				APPEND TO ARRAY:C911($al2D_CoordenadasCeldas{2};$i_Filas)
			End for 
	End case 
End if 
If (Size of array:C274($al2D_CoordenadasCeldas{1})>0)
	COPY ARRAY:C226($al2D_CoordenadasCeldas{1};$al_Columnas)
	COPY ARRAY:C226($al2D_CoordenadasCeldas{2};$al_Filas)
	AT_DistinctsArrayValues (->$al_Filas)
	AT_DistinctsArrayValues (->$al_Columnas)
End if 

$l_coordenadasCeldas:=Size of array:C274($al2D_CoordenadasCeldas{1})
For ($i_filas;$l_coordenadasCeldas;1;-1)
	$l_columna:=$al2D_CoordenadasCeldas{1}{$i_filas}
	$l_numerofila:=$al2D_CoordenadasCeldas{2}{$i_filas}
	$b_alumnoActivo:=((adSTK_fechaIngreso{$l_numerofila}<=dFrom) | (adSTK_fechaIngreso{$l_numerofila}=!00-00-00!))
	$b_alumnoActivo:=$b_alumnoActivo & ((adSTK_fechaRetiro{$l_numerofila}>dFrom) | (adSTK_fechaRetiro{$l_numerofila}=!00-00-00!))
	
	If (Find in array:C230($al_Columnas;1)>0)
		If (Size of array:C274($al_Columnas)>1)
			  // si en la matriz hay celdas de la columna 1 (alumnos) y celdas correspondientes a sesiones, retiro la última celda seleccionada
			  // o se opera sobre una sesion aislada o sobre todas las sesiones del alumno
			$b_seleccionInvalida:=True:C214
			$t_tip:=__ ("No es posible operar simultánemente sobre una sesión y sobre todas.")
			
		Else 
			
			  // la celda seleccionada corresponde a la columna 1, nombre del alumno
			Case of 
				: (Not:C34($b_alumnoActivo))  // alumno esta inactivo, lo retiro de la selección
					$b_seleccionInvalida:=True:C214
					$t_tip:=__ ("La celda seleccionada corresponde a un alumno inactivo.")
				Else 
					For ($i_horas;1;$l_HorasEnElDia)
						$y_ArregloEnColumna:=Get pointer:C304("alSTK_Hora"+String:C10($i_horas))
						$l_valorCelda:=$y_ArregloEnColumna->{$l_numerofila}
						Case of 
							: ($l_valorCelda>0)
								If ($l_ausentesEnSeleccion>0)
									  // si hay celdas "ausentes" en la matriz y la ultima celda seleccionada es "presente" la retiro de la selección
									$b_seleccionInvalida:=True:C214
									$t_tip:=__ ("No es posible operar sobre inasistencias o presencias simultáneamente.")
									If (Not:C34($b_esSeleccionContigua))
										$i_filas:=0
									End if 
								Else 
									$b_usuarioAutorizado:=ASrs_ValidaPermisos (Abs:C99($l_valorCelda);"A")
									If ($b_usuarioAutorizado)
										$l_presentesEnSeleccion:=$l_presentesEnSeleccion+1  // cuento las celdas "presentes" en la selección
									Else 
										  // si el usuario no está autorizado para registrar inasistencias en la sesión correspondiente a la última celda seleccionada la retiro de la matriz
										$b_seleccionInvalida:=True:C214
										$t_tip:=__ ("Usted no esta autorizado para registrar inasistencias en una o mas de las sesiones de clases seleccionadas.")
										If (Not:C34($b_esSeleccionContigua))
											$i_filas:=0
											$i_horas:=$l_HorasEnElDia
										End if 
									End if 
								End if 
								
							: ($l_valorCelda<0)
								If ($l_PresentesEnSeleccion>0)
									  // si hay celdas "presentes" en la matriz y la ultima celda seleccionada es "ausente" la retiro de la selección
									$b_seleccionInvalida:=True:C214
									$t_tip:=__ ("No es posible operar sobre inasistencias o presencias simultáneamente.")
									If (Not:C34($b_esSeleccionContigua))
										$i_filas:=0
									End if 
								Else 
									$b_usuarioAutorizado:=ASrs_ValidaPermisos (Abs:C99($l_valorCelda);"D")
									If ($b_usuarioAutorizado)
										$l_ausentesEnSeleccion:=$l_ausentesEnSeleccion+1  // cuento las celdas "ausentes" en la selección
									Else 
										  // si el usuario no está autorizado para registrar inasistencias en la sesión correspondiente a la última celda seleccionada la retiro de la matriz
										$b_seleccionInvalida:=True:C214
										$t_tip:=__ ("Usted no esta autorizado para eliminar inasistencias en una o más de las las sesiones de clases seleccionadas.")
										If (Not:C34($b_esSeleccionContigua))
											$i_filas:=0
											$i_horas:=$l_HorasEnElDia
										End if 
									End if 
								End if 
						End case 
					End for 
			End case 
		End if 
		
	Else 
		If ($l_columna>1)
			$y_ArregloEnColumna:=Get pointer:C304("alSTK_Hora"+String:C10($l_columna-1))
			$l_valorCelda:=$y_ArregloEnColumna->{$l_numerofila}
			$l_IdSesion:=Abs:C99($l_valorCelda)
			If ($l_IdSesion>0)
				$b_sesionImpartida:=KRL_GetBooleanFieldData (->[Asignaturas_RegistroSesiones:168]ID_Sesion:1;->$l_IdSesion;->[Asignaturas_RegistroSesiones:168]Impartida:5)
			End if 
			Case of 
				: (Not:C34($b_alumnoActivo))  // alumno esta inactivo, lo retiro de la selección
					$b_seleccionInvalida:=True:C214
					$t_tip:=__ ("La celda seleccionada corresponde a un alumno inactivo.")
					
				: (($l_valorCelda=0) | (Not:C34($b_sesionImpartida)))
					  // si la celda seleccionada no está asignada en el horario o la sesión no fue impartida retiro la celda de la matriz
					$b_seleccionInvalida:=True:C214
					$t_tip:=__ ("No hay ninguna sesion de clases impartida en esta hora.")
					If (Not:C34($b_esSeleccionContigua))
						$i_filas:=0
					End if 
					
				: (($l_valorCelda>0) & ($b_alumnoActivo))
					If ($l_ausentesEnSeleccion>0)
						  // si hay celdas "ausentes" en la matriz y la ultima celda seleccionada es "presente" la retiro de la selección
						$b_seleccionInvalida:=True:C214
						$t_tip:=__ ("No es posible operar sobre inasistencias o presencias simultáneamente.")
						If (Not:C34($b_esSeleccionContigua))
							$i_filas:=0
						End if 
					Else 
						$b_usuarioAutorizado:=ASrs_ValidaPermisos (Abs:C99($l_valorCelda);"A")
						If ($b_usuarioAutorizado)
							$l_presentesEnSeleccion:=$l_presentesEnSeleccion+1  // cuento las celdas "presentes" en la selección
						Else 
							  // si el usuario no está autorizado para registrar inasistencias en la sesión correspondiente a la última celda seleccionada la retiro de la matriz
							$b_seleccionInvalida:=True:C214
							$t_tip:=__ ("Usted no esta autorizado para registrar inasistencias en una o mas de las sesiones de clases seleccionadas.")
							If (Not:C34($b_esSeleccionContigua))
								$i_filas:=0
							End if 
						End if 
					End if 
					
				: (($l_valorCelda<0) & ($b_alumnoActivo))
					If ($l_PresentesEnSeleccion>0)
						  // si hay celdas "presentes" en la matriz y la ultima celda seleccionada es "ausente" la retiro de la selección
						$b_seleccionInvalida:=True:C214
						$t_tip:=__ ("No es posible operar sobre inasistencias o presencias simultáneamente.")
						If (Not:C34($b_esSeleccionContigua))
							$i_filas:=0
						End if 
					Else 
						$b_usuarioAutorizado:=ASrs_ValidaPermisos (Abs:C99($l_valorCelda);"D")
						If ($b_usuarioAutorizado)
							$l_ausentesEnSeleccion:=$l_ausentesEnSeleccion+1  // cuento las celdas "ausentes" en la selección
						Else 
							  // si el usuario no está autorizado para registrar inasistencias en la sesión correspondiente a la última celda seleccionada la retiro de la matriz
							$b_seleccionInvalida:=True:C214
							$t_tip:=__ ("Usted no esta autorizado para eliminar inasistencias en una o más de las las sesiones de clases seleccionadas.")
							If (Not:C34($b_esSeleccionContigua))
								$i_filas:=0
							End if 
						End if 
					End if 
			End case 
		End if 
	End if 
End for 

If ($b_seleccionInvalida)
	If (Not:C34($b_esSeleccionContigua))
		If (Size of array:C274($al2D_CoordenadasCeldas{1})>0)
			For ($i;Size of array:C274($al2D_CoordenadasCeldas{1});1;-1)
				If (($al2D_CoordenadasCeldas{1}{$i}=$l_columnaSeleccionada) & ($al2D_CoordenadasCeldas{2}{$i}=$l_filaSeleccionada))
					DELETE FROM ARRAY:C228($al2D_CoordenadasCeldas{1};$i)
					DELETE FROM ARRAY:C228($al2D_CoordenadasCeldas{2};$i)
					$i:=Size of array:C274($al2D_CoordenadasCeldas{1})
					BEEP:C151
				End if 
			End for 
		End if 
	Else 
		$l_ausentesEnSeleccion:=0
		$l_presentesEnSeleccion:=0
	End if 
	BEEP:C151
	GET MOUSE:C468($l_posicionHorizontal;$l_posicionVertical;$l_boton)
	API Create Tip ($t_tip;$l_posicionHorizontal-50;$l_posicionVertical-50;$l_posicionHorizontal+50;$l_posicionVertical+50)
	
	COPY ARRAY:C226($al2D_CoordenadasCeldas{1};$al_Columnas)
	COPY ARRAY:C226($al2D_CoordenadasCeldas{2};$al_Filas)
	AT_DistinctsArrayValues (->$al_Filas)
	AT_DistinctsArrayValues (->$al_Columnas)
	AL_SetCellSel (xALP_Inasistencias;0;0;0;0;$al2D_CoordenadasCeldas)
End if 

If (Size of array:C274($al_Filas)=1)
	$l_primeraFila:=$al_Filas{1}
End if 
If (Size of array:C274($al_Columnas)=1)
	$l_primeraColumna:=$al_Columnas{1}
End if 
If ($l_primeraColumna#0) & ($l_primeraFila#0)
	$b_celdaUnica:=True:C214
End if 

If ($l_primeraColumna#1)
	For ($i_filas;1;Size of array:C274($al2D_CoordenadasCeldas{1}))
		$l_columna:=$al2D_CoordenadasCeldas{1}{$i_filas}
		$l_hora:=$l_columna-1
		$l_numerofila:=$al2D_CoordenadasCeldas{2}{$i_filas}
		$y_ArregloEnColumna:=Get pointer:C304("alSTK_Hora"+String:C10($l_hora))
		$l_valorCelda:=$y_ArregloEnColumna->{$l_numerofila}
		If ($l_valorCelda<0)
			$l_IdAlumno:=alSTK_StudentIDs{$l_numerofila}
			APPEND TO ARRAY:C911($al_IdAlumnos_Justificacion;$l_IdAlumno)
			APPEND TO ARRAY:C911($al_IdSesiones_Justificacion;Abs:C99($l_valorCelda))
		End if 
	End for 
End if 

$l_ErrorALP:=AL_GetCellSel (Self:C308->;$l_primeraColumna;$l_primeraFila;$l_ultimaColumna;$l_ultimaFila;$al2D_CoordenadasCeldas)

Case of 
	: (alProEvt=AL Single Control Click)
		If (Not:C34($b_seleccionInvalida))
			If ($l_primeraColumna=1)
				$t_popupItems:=__ ("Ausente todo el día")+";"+__ ("Presente todo el día")
				Case of 
					: (($l_ausentesEnSeleccion=0) & ($l_presentesEnSeleccion=0))
						$t_popupItems:=IT_FijaEstadoPopupItem ($t_popupItems;1;True:C214)
						$t_popupItems:=IT_FijaEstadoPopupItem ($t_popupItems;2;False:C215)
						$t_popupItems:=IT_FijaEstadoPopupItem ($t_popupItems;4;False:C215)
					: (($l_ausentesEnSeleccion>0) & ($l_presentesEnSeleccion=0))
						$t_popupItems:=IT_FijaEstadoPopupItem ($t_popupItems;1;True:C214)
						$t_popupItems:=IT_FijaEstadoPopupItem ($t_popupItems;2;True:C214)
						$t_popupItems:=IT_FijaEstadoPopupItem ($t_popupItems;4;True:C214)
					: (($l_ausentesEnSeleccion=0) & ($l_presentesEnSeleccion>0))
						$t_popupItems:=IT_FijaEstadoPopupItem ($t_popupItems;1;True:C214)
						$t_popupItems:=IT_FijaEstadoPopupItem ($t_popupItems;2;False:C215)
						$t_popupItems:=IT_FijaEstadoPopupItem ($t_popupItems;4;False:C215)
				End case 
				$l_itemMenu:=Pop up menu:C542($t_popupItems)
				Case of 
					: ($l_itemMenu=1)  // registrar inasistencias
						For ($i_hora;1;$l_HorasEnElDia)
							$l_columna:=$i_hora+1
							$y_ArregloEnColumna:=Get pointer:C304("alSTK_Hora"+String:C10($i_hora))
							For ($i_alumnos;1;Size of array:C274($al_filas))
								$l_IdSesion:=$y_ArregloEnColumna->{$al_filas{$i_alumnos}}
								If ($l_idSesion#0)
									$l_IdAlumno:=alSTK_StudentIDs{$al_filas{$i_alumnos}}
									$l_InasistenciaRegistrada:=ASrs_RegistraInasistencia ($l_IdSesion;$l_IdAlumno)
									If ($l_InasistenciaRegistrada=1)
										$l_fila:=$al_filas{$i_alumnos}
										$y_ArregloEnColumna->{$l_Fila}:=-Abs:C99($l_IdSesion)
										$b_actualizarArea:=True:C214
									End if 
								End if 
							End for 
						End for 
						
					: ($l_itemMenu=2)  // eliminar inasistencias
						For ($i_hora;1;$l_HorasEnElDia)
							$l_columna:=$i_hora+1
							$y_ArregloEnColumna:=Get pointer:C304("alSTK_Hora"+String:C10($i_hora))
							For ($i_alumnos;1;Size of array:C274($al_filas))
								$l_IdSesion:=$y_ArregloEnColumna->{$al_filas{$i_alumnos}}
								If ($l_IdSesion#0)
									$l_IdAlumno:=alSTK_StudentIDs{$al_filas{$i_alumnos}}
									$l_presenciaRegistrada:=ASrs_RegistraPresencia ($l_IdSesion;$l_IdAlumno)
									If ($l_presenciaRegistrada=1)
										$l_fila:=$al_filas{$i_alumnos}
										$y_ArregloEnColumna->{$l_fila}:=Abs:C99($l_IdSesion)
										$b_actualizarArea:=True:C214
									End if 
								End if 
							End for 
						End for 
						
						  //: ($l_itemMenu=4)  // justificar inasistencias
						  //ASrs_JustificaInasistencia (->$al_IdSesiones_Justificacion;->$al_IdAlumnos_Justificacion)
						  //$b_actualizarArea:=True
				End case 
				
				  //If ($b_actualizarArea)
				  //ALabs_UpdateForm 
				  //End if 
				
			Else 
				  // hay una o mas celdas de mismo tipo y con permisos validados en la planilla de asistencia
				$t_popupItems:=__ ("Ausente")+";"+__ ("Presente")+";"+"(-;"+__ ("Justificación")
				Case of 
					: (($l_ausentesEnSeleccion=0) & ($l_presentesEnSeleccion=0))
						$t_popupItems:=IT_FijaEstadoPopupItem ($t_popupItems;1;False:C215)
						$t_popupItems:=IT_FijaEstadoPopupItem ($t_popupItems;2;False:C215)
						$t_popupItems:=IT_FijaEstadoPopupItem ($t_popupItems;4;False:C215)
					: (($l_ausentesEnSeleccion>0) & ($l_presentesEnSeleccion=0))
						$t_popupItems:=IT_FijaEstadoPopupItem ($t_popupItems;1;False:C215)
						$t_popupItems:=IT_FijaEstadoPopupItem ($t_popupItems;2;True:C214)
						$t_popupItems:=IT_FijaEstadoPopupItem ($t_popupItems;4;True:C214)
					: (($l_ausentesEnSeleccion=0) & ($l_presentesEnSeleccion>0))
						$t_popupItems:=IT_FijaEstadoPopupItem ($t_popupItems;1;True:C214)
						$t_popupItems:=IT_FijaEstadoPopupItem ($t_popupItems;2;False:C215)
						$t_popupItems:=IT_FijaEstadoPopupItem ($t_popupItems;4;False:C215)
				End case 
				$l_itemMenu:=Pop up menu:C542($t_popupItems)
				
				Case of 
					: ($l_itemMenu=1)  // registrar inasistencias
						For ($i_celdas;1;Size of array:C274($al2D_CoordenadasCeldas{1}))
							$l_columna:=$al2D_CoordenadasCeldas{1}{$i_celdas}
							$l_Hora:=$l_columna-1
							$l_fila:=$al2D_CoordenadasCeldas{2}{$i_celdas}
							$y_ArregloEnColumna:=Get pointer:C304("alSTK_Hora"+String:C10($l_Hora))
							$l_IdAlumno:=alSTK_StudentIDs{$l_fila}
							$l_IdSesion:=$y_ArregloEnColumna->{$l_fila}
							If ($l_IdSesion>0)
								$l_InasistenciaRegistrada:=ASrs_RegistraInasistencia ($l_IdSesion;$l_IdAlumno)
								If ($l_InasistenciaRegistrada=1)
									$y_ArregloEnColumna->{$l_fila}:=-Abs:C99($l_IdSesion)
									AL_SetCellColor (xALP_Inasistencias;$l_columna;$l_fila;$l_columna;$l_fila;$al2D_SeleccionVacia;"";4;"";4)
									$b_actualizarArea:=True:C214
								End if 
							End if 
						End for 
						
					: ($l_itemMenu=2)  // eliminar inasistencia
						For ($i_celdas;1;Size of array:C274($al2D_CoordenadasCeldas{1}))
							$l_columna:=$al2D_CoordenadasCeldas{1}{$i_celdas}
							$l_Hora:=$l_columna-1
							$l_fila:=$al2D_CoordenadasCeldas{2}{$i_celdas}
							$y_ArregloEnColumna:=Get pointer:C304("alSTK_Hora"+String:C10($l_Hora))
							$l_IdAlumno:=alSTK_StudentIDs{$l_fila}
							$l_IdSesion:=$y_ArregloEnColumna->{$l_fila}
							If ($l_IdSesion<0)
								$l_PresenciaRegistrada:=ASrs_RegistraPresencia ($l_IdSesion;$l_IdAlumno)
								If ($l_PresenciaRegistrada=1)
									$y_ArregloEnColumna->{$l_fila}:=Abs:C99($l_IdSesion)
									AL_SetCellColor (xALP_Inasistencias;$l_columna;$l_fila;$l_columna;$l_fila;$al2D_SeleccionVacia;"";11*16+2;"";11*16+2)
									$b_actualizarArea:=True:C214
								End if 
							End if 
						End for 
						
					: ($l_itemMenu=4)  // registrar justificacion
						ASrs_JustificaInasistencia (->$al_IdSesiones_Justificacion;->$al_IdAlumnos_Justificacion)
						$b_actualizarArea:=True:C214
				End case 
			End if 
			
			AL_SetCellSel (xALP_Inasistencias;0;0;0;0;$al2D_SeleccionVacia)
		End if 
		
	: (alProEvt=AL Single click event)
		
	: ((alProEvt=AL Double click event) & (Not:C34($b_seleccionInvalida)))
		$l_filaSeleccionada:=AL_GetClickedRow (Self:C308->)
		$l_columnaSeleccionada:=AL_GetColumn (Self:C308->)
		$b_alumnoActivo:=((adSTK_fechaIngreso{$l_filaSeleccionada}<=dFrom) | (adSTK_fechaIngreso{$l_filaSeleccionada}=!00-00-00!))
		$b_alumnoActivo:=$b_alumnoActivo & ((adSTK_fechaRetiro{$l_filaSeleccionada}>dFrom) | (adSTK_fechaRetiro{$l_filaSeleccionada}=!00-00-00!))
		
		If (Not:C34($b_alumnoActivo))
			  // el alumno no está activo
			BEEP:C151
		Else 
			
			If ($l_columnaSeleccionada>0)
				If ($l_columnaSeleccionada=1)
					  // el usuario hace doble click en una celda de la columna 1
					  // se registra inasistencia para todas las sesiones del día
					For ($i;1;$l_HorasEnElDia)
						$l_columna:=$i+1
						$l_numeroHora:=$al_horasEnHorario{$i}
						$y_ArregloEnColumna:=Get pointer:C304("alSTK_Hora"+String:C10($i))
						$l_IdSesion:=$y_ArregloEnColumna->{$l_filaSeleccionada}
						$l_IdAlumno:=alSTK_StudentIDs{$l_filaSeleccionada}
						If (($l_presentesEnSeleccion>0) & ($l_ausentesEnSeleccion=0)) | (($l_presentesEnSeleccion=0) & ($l_ausentesEnSeleccion>0))
							Case of 
								: ($l_IdSesion=0)
									
								: ($l_IdSesion>0)
									$l_InasistenciaRegistrada:=ASrs_RegistraInasistencia ($l_IdSesion;$l_IdAlumno)
									If ($l_InasistenciaRegistrada=1)
										$y_ArregloEnColumna->{$l_filaSeleccionada}:=-Abs:C99($l_IdSesion)
										AL_SetCellColor (xALP_Inasistencias;$l_columna;$l_filaSeleccionada;$l_columna;$l_filaSeleccionada;$al2D_SeleccionVacia;"";4;"";4)
										$b_actualizarArea:=True:C214
									End if 
								: ($l_IdSesion<0)
									$l_PresenciaRegistrada:=ASrs_RegistraPresencia ($l_IdSesion;$l_IdAlumno)
									If ($l_PresenciaRegistrada=1)
										$y_ArregloEnColumna->{$l_filaSeleccionada}:=Abs:C99($l_IdSesion)
										$b_actualizarArea:=True:C214
									End if 
									
							End case 
						End if 
					End for 
					
				Else 
					  //se hace doble click en una columna especifica para dejar inasistente/presente una hora de clase
					$y_ArregloEnColumna:=Get pointer:C304("alSTK_Hora"+String:C10($l_columnaSeleccionada-1))
					$l_IdSesion:=$y_ArregloEnColumna->{$l_filaSeleccionada}
					$l_IdAlumno:=alSTK_StudentIDs{$l_filaSeleccionada}
					$l_indexSesion:=Find in array:C230(alSTK_SesionID;Abs:C99($l_IdSesion))
					If ($l_indexSesion>0)
						$b_sesionImpartida:=aImpartida{$l_indexSesion}
					Else 
						$b_sesionImpartida:=False:C215
					End if 
					Case of 
						: (($l_IdSesion=-1) | ($l_IdSesion=0) | ($b_sesionImpartida=False:C215))
							BEEP:C151
						: ($l_IdSesion>0)
							  // el alumno esta presente, registramos la inasistencia
							$l_InasistenciaRegistrada:=ASrs_RegistraInasistencia ($l_IdSesion;$l_IdAlumno)
							If ($l_InasistenciaRegistrada=1)
								$y_ArregloEnColumna->{$l_filaSeleccionada}:=-Abs:C99($l_IdSesion)
								$b_actualizarArea:=True:C214
							End if 
							
						: ($l_IdSesion<0)
							  // el alumno esta ausente, eliminamos la inasistencia
							$l_PresenciaRegistrada:=ASrs_RegistraPresencia ($l_IdSesion;$l_IdAlumno)
							If ($l_PresenciaRegistrada=1)
								$y_ArregloEnColumna->{$l_filaSeleccionada}:=Abs:C99($l_IdSesion)
								$b_actualizarArea:=True:C214
							End if 
					End case 
					
					
				End if 
			End if 
		End if 
		AL_SetCellSel (xALP_Inasistencias;0;0;0;0;$al2D_SeleccionVacia)
End case 

If ($b_actualizarArea)
	READ ONLY:C145([Asignaturas_RegistroSesiones:168])
	QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3=dFrom)
	QRY_QueryWithArray (->[Asignaturas_RegistroSesiones:168]ID_Asignatura:2;->alSTK_IDsubsector;True:C214)
	SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
	SELECTION TO ARRAY:C260([Asignaturas_RegistroSesiones:168]ID_Sesion:1;alSTK_SesionID;[Asignaturas_RegistroSesiones:168]ID_Asignatura:2;alSTK_IDsubsector;[Asignaturas_RegistroSesiones:168]Hora:4;aiSTK_Hora;[Asignaturas:18]denominacion_interna:16;atSTK_Subsectores;[Asignaturas_RegistroSesiones:168]Impartida:5;aImpartida;[Asignaturas_RegistroSesiones:168]AsistenciaRegistrada:18;ab_InasistenciaTomada;[Asignaturas:18]Curso:5;$at_nombreCurso;[Profesores:4]Nombre_comun:21;$at_profesores)
	SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
	
	$t_curso:=<>aCursos{<>aCursos}
	For ($i;1;Size of array:C274(atSTK_Subsectores))
		If ($at_nombreCurso{$i}#$t_curso)
			atSTK_Subsectores{$i}:=atSTK_Subsectores{$i}+" ("+$at_nombreCurso{$i}+")\r"+$at_profesores{$i}
		Else 
			atSTK_Subsectores{$i}:=atSTK_Subsectores{$i}+"\r"+$at_profesores{$i}
		End if 
	End for 
	ALabs_UpdateForm 
End if 
