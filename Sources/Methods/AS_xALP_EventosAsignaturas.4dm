//%attributes = {}
  // AS_xALP_EventosAsignaturas()
  // Por: Alberto Bachler K.: 31-01-14, 10:02:30
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


C_LONGINT:C283($0;$1;$2;$3;$4;$5;$6)  //object method and form method will not be executed if 0 C_LONGINT($1) //AreaList Pro area
C_LONGINT:C283($2)  //AreaList Pro event
C_LONGINT:C283($3)  //4D event
C_LONGINT:C283($4)  //column — last clicked column C_LONGINT($5) //row — last clicked row C_LONGINT($6) //modifiers

$l_refArea:=$1
$l_eventoALP:=$2
$l_evento4D:=$3  // no utilizado actualmente
$l_columna:=$4
$l_fila:=$5
$l_modificadores:=$6



Case of 
	: ($l_refArea=xALP_ASNotas)
		Case of 
			: ($l_eventoALP=AL Mouse moved event)
				AS_xALP_PropiedadesCalificación ($l_columna;$l_fila)
				POST KEY:C465(Character code:C91("*");256)
				
			: ($l_eventoALP=AL Column control click event)
				AS_xALP_MenuContextualNotas 
				
			: ($l_eventoALP=AL Double click event)
				$l_enterable:=AL_GetColumnLongProperty (xALP_ASNotas;$l_columna;ALP_Column_Enterable)
				If ($l_enterable=0)
					AL_ExitCell (xALP_ASNotas)
				End if 
				
			: ($l_eventoALP=AL Single click event)
				Case of 
					: ($l_modificadores=Option key mask:K16:7)
						AS_xALP_MuestraInfoCalificacion ($l_fila;$l_columna;$l_eventoALP)
					Else 
						
						If ($l_columna>0)
							AS_xALP_ManejoExcepciones ($l_columna;$l_fila)
							$l_columnaPrimerParcial:=vi_PrimeraColumnaParciales
							If ($l_columna>=$l_columnaPrimerParcial)
								ARRAY LONGINT:C221(a2DLong1;0;0)
								Case of 
									: ((alAS_EvalPropSourceID{$l_columna-$l_columnaPrimerParcial+1}<0) & ((USR_checkRights ("L";->[Alumnos_Calificaciones:208]) | (<>lUSR_RelatedTableUserID=[Asignaturas:18]profesor_numero:4))))
										$l_columnaSubEvaluacion:=$l_columna-$l_columnaPrimerParcial+1
										ASsev_EditaSubAsignatura ([Asignaturas:18]Numero:1;atSTR_Periodos_Nombre;$l_columnaSubEvaluacion)
										
									: (alAS_EvalPropSourceID{$l_columna-$l_columnaPrimerParcial+1}>0)
										BEEP:C151
									: (aiAS_EvalPropEnterable{$l_columna-$l_columnaPrimerParcial+1}=0)
										BEEP:C151
								End case 
							End if 
							
						End if 
						
				End case 
				
			: ($l_eventoALP=AL Single Control Click)
				AS_xALP_MuestraInfoCalificacion ($l_fila;$l_columna;$l_eventoALP)
				
		End case 
End case 
