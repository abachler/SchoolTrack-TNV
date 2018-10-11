//%attributes = {}
  //Metodo: AL_CalculaRetardoAcumulado
  //Por abachler
  //Creada el 29/05/2008, 10:47:01
  // ----------------------------------------------------
  // Descripción
  // Efectúa un recalculo completo de las faltas por retardo acumulado
  // - Para todos los alumnos activos si no se reciben argumentos
  // - Para la selección actual si $1 es igual a 0
  // - Para un alumno en específico si $1 es un ID de alumno válido
  // ----------------------------------------------------
  // Parámetros
  // $1: ID de alumno válido o 0 para la selección actual de alumnos, &L; opcional
  // ----------------------------------------------------

  //DECLARACIONES & INICIALIZACIONES


  //CUERPO

  //LIMPIEZA


C_LONGINT:C283($vl_idAlumno;$1)
ARRAY LONGINT:C221($al_rnAlumnos;0)

PERIODOS_LoadData ([Alumnos:2]nivel_numero:29)
STR_LeePreferenciasAtrasos2 
READ ONLY:C145([Alumnos:2])
If (<>vr_InasistenciasXatrasos>0)
	Case of 
		: (Count parameters:C259=0)  //si no se recibe el segundo parametro se asume que se deben calcular los trasos para todos los alumnos activos
			QUERY:C277([Alumnos:2];[Alumnos:2]Status:50="Activo")
			SELECTION TO ARRAY:C260([Alumnos:2];$al_rnAlumnos)
			
		: (Count parameters:C259=1)  //si se recibe un segundo parametro se asume que es un ID de alumno si es superior a 0
			$vl_idAlumno:=$1
			If ($vl_idAlumno>0)
				$recNum:=Find in field:C653([Alumnos:2]numero:1;$vl_idAlumno)
				If ($recNum>=0)
					APPEND TO ARRAY:C911($al_rnAlumnos;$recNum)
				End if 
			Else   //si $2 es igual o inferior a 0 se asume que la contabilización de retardo debe realizarse para todos los alumnos de la selección actual
				SELECTION TO ARRAY:C260([Alumnos:2];$al_rnAlumnos)
			End if 
	End case 
	
	If (Size of array:C274($al_rnAlumnos)>20)
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Totalizando faltas por retardo acumulado..."))
	End if 
	For ($x;1;Size of array:C274($al_rnAlumnos))
		GOTO RECORD:C242([Alumnos:2];$al_rnAlumnos{$x})
		$vl_idAlumno:=[Alumnos:2]numero:1
		$nivel:=[Alumnos:2]nivel_numero:29
		
		$faltasPorRetardoJornada_Anual:=0
		$faltasPorRetardoSesion_Anual:=0
		
		  //inicializo los contadores en los registros de sintesis
		$value:=0
		$key:=String:C10(<>gInstitucion)+"."+String:C10(<>gYear)+"."+String:C10($nivel)+"."+String:C10($vl_idAlumno)
		AL_EscribeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]Faltas_x_RetardoSesiones:46;->$value)
		
		For ($iPeriodos;1;Size of array:C274(aiSTR_Periodos_Numero))
			  //busco los atrasos para cada período
			QUERY:C277([Alumnos_Atrasos:55];[Alumnos_Atrasos:55]Alumno_numero:1=$vl_idAlumno;*)
			QUERY:C277([Alumnos_Atrasos:55]; & [Alumnos_Atrasos:55]Fecha:2>=adSTR_Periodos_Desde{$iPeriodos};*)
			QUERY:C277([Alumnos_Atrasos:55]; & [Alumnos_Atrasos:55]Fecha:2<=adSTR_Periodos_Hasta{$iPeriodos})
			$faltasPorRetardoJornada:=0
			$faltasPorRetardoSesion:=0
			SELECTION TO ARRAY:C260([Alumnos_Atrasos:55]MinutosAtraso:5;$aMinutosAtraso;[Alumnos_Atrasos:55]EsAtrasoInterSesiones:4;$aEsInterSesion)
			
			  //totalización de las faltas por retardo para cada período
			For ($i_Atrasos;1;Size of array:C274($aMinutosAtraso))
				$valorFalta:=AL_RetornaValorFaltaPorRetardo ($aMinutosAtraso{$i_Atrasos};False:C215)
				$faltasPorRetardoJornada:=$valorFalta*Num:C11($aEsInterSesion{$i_Atrasos}=False:C215)
				$faltasPorRetardoSesion:=$valorFalta*Num:C11($aEsInterSesion{$i_Atrasos}=True:C214)
				
				  //incremento los contadores anuales con los valores calculados en los períodos
				$faltasPorRetardoJornada_Anual:=$faltasPorRetardoJornada_Anual+$faltasPorRetardoJornada
				$faltasPorRetardoSesion_Anual:=$faltasPorRetardoSesion_Anual+$faltasPorRetardoSesion
			End for 
			
			  //registro el total para en el registro de síntesis de período correspondiente al alumno
			$key:=String:C10(<>gInstitucion)+"."+String:C10(<>gYear)+"."+String:C10($nivel)+"."+String:C10($vl_idAlumno)
			Case of 
				: ($iPeriodos=1)
					AL_EscribeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]P01_Faltas_x_RetardoJornada:112;->$faltasPorRetardoJornada;False:C215)
					AL_EscribeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]P01_Faltas_x_RetardoSesiones:113;->$faltasPorRetardoSesion;True:C214)
				: ($iPeriodos=2)
					AL_EscribeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]P02_Faltas_x_RetardoJornada:141;->$faltasPorRetardoJornada;False:C215)
					AL_EscribeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]P02_Faltas_x_RetardoSesiones:142;->$faltasPorRetardoSesion;True:C214)
				: ($iPeriodos=3)
					AL_EscribeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]P03_Faltas_x_RetardoJornada:170;->$faltasPorRetardoJornada;False:C215)
					AL_EscribeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]P03_Faltas_x_RetardoSesiones:171;->$faltasPorRetardoSesion;True:C214)
				: ($iPeriodos=4)
					AL_EscribeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]P04_Faltas_x_RetardoJornada:199;->$faltasPorRetardoJornada;False:C215)
					AL_EscribeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]P04_Faltas_x_RetardoSesiones:200;->$faltasPorRetardoSesion;True:C214)
				: ($iPeriodos=5)
					AL_EscribeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]P05_Faltas_x_RetardoJornada:228;->$faltasPorRetardoJornada;False:C215)
					AL_EscribeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]P05_Faltas_x_RetardoSesiones:229;->$faltasPorRetardoSesion;True:C214)
			End case 
		End for 
		
		AL_EscribeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]Faltas_x_RetardoJornada:45;->$faltasPorRetardoJornada_Anual;False:C215)
		AL_EscribeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]Faltas_x_RetardoSesiones:46;->$faltasPorRetardoSesion_Anual;True:C214)
		
		If (Size of array:C274($al_rnAlumnos)>20)
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$x/Size of array:C274($al_rnAlumnos))
		End if 
		
	End for 
	
	If (Size of array:C274($al_rnAlumnos)>20)
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	End if 
	
End if 