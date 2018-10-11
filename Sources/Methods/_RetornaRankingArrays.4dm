//%attributes = {}
  //(DLC)  _RetornaRankingArrays
  //Carga los siguientes arreglos ordenados para un ranking de promedios según el periodo entregado y el universo parámetro para de creación del ranking
  // Luego tiene la opción de desempate para los alumnos en una misma posición dentro del Ranking, reorganizando el arreglo, por medio de un desmpate
  //     de promedios en asignaturas seleccionadas para este desempate. 
  //aR_prom_OM(Porcentaje que representa el promedio)
  //aL_id_alu_OM(Id de los alumnos)
  //aI_Ranking_OM(Ubicación en el Ranking)
  //at_nom_alu_ranking(Apellidos y Nombres de los alumnos)
  //at_curso_alu_ranking(Curso del alumno)
  //at_promedios_ranking(Promedios convertidos a la evaluación correspondiente al nivel)

  // PARAMETROS
  // $1: puntero sobre un campo de referencia
  // $2: período (0: final; 1: Período1; 2: Período2; 3: Período3; 4: Período4)

  //SALIDA
  //Si tenemos un alumno cargado en la selección, entrega la posición en el Ranking, en un entero.

C_POINTER:C301($1;$universoReferencia)
C_LONGINT:C283($2;$periodoValores;$universo;$vindex;$num_OM)
_O_C_INTEGER:C282($0)

C_REAL:C285($promaux)
ARRAY REAL:C219(aR_prom_OM;0)
ARRAY LONGINT:C221(aL_id_alu_OM;0)
ARRAY INTEGER:C220(aI_Ranking_OM;0)
ARRAY TEXT:C222(at_nom_alu_ranking;0)
ARRAY TEXT:C222(at_curso_alu_ranking;0)
ARRAY REAL:C219(aR_promedios_ranking;0)
READ ONLY:C145([Alumnos:2])
READ ONLY:C145([Cursos:3])
READ ONLY:C145([xxSTR_Niveles:6])

$periodoValores:=$2
$universoReferencia:=$1


QUERY:C277([Cursos:3];[Cursos:3]Nivel_Numero:7=[Alumnos:2]nivel_numero:29)
QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5=[Cursos:3]Nivel_Numero:7)

  //CUERPO
MESSAGES OFF:C175
$selectedRecNum:=Selected record number:C246([Alumnos:2])

  //copio la selección para restaurarla despues de obtener los valores de cada quantil
COPY NAMED SELECTION:C331([Alumnos:2];"temp")

QUERY:C277([Alumnos:2];$universoReferencia->=$universoReferencia->)

Case of 
	: ($periodoValores=0)
		KRL_RelateSelection (->[Alumnos_SintesisAnual:210]ID_Alumno:4;->[Alumnos:2]numero:1;"")
		QUERY SELECTION:C341([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]ID_Institucion:1=<>gInstitucion)
		QUERY SELECTION:C341([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]Año:2=<>gYear)
		SELECTION TO ARRAY:C260([Alumnos_SintesisAnual:210]PromedioInt_NoAprox_Real:272;aR_prom_OM;[Alumnos_SintesisAnual:210]ID_Alumno:4;aL_id_alu_OM;[Alumnos_SintesisAnual:210]PromedioInt_NoAprox_Nota:273;aR_promedios_ranking)
		SORT ARRAY:C229(aR_prom_OM;aL_id_alu_OM;aR_promedios_ranking;<)
		$fieldPointer:=->[Alumnos_SintesisAnual:210]PromedioAnualInterno_Real:10
		
	: ($periodoValores=1)
		KRL_RelateSelection (->[Alumnos_SintesisAnual:210]ID_Alumno:4;->[Alumnos:2]numero:1;"")
		QUERY SELECTION:C341([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]ID_Institucion:1=<>gInstitucion)
		QUERY SELECTION:C341([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]Año:2=<>gYear)
		SELECTION TO ARRAY:C260([Alumnos_SintesisAnual:210]P01_PromedioInterno_Real:92;aR_prom_OM;[Alumnos_SintesisAnual:210]ID_Alumno:4;aL_id_alu_OM;[Alumnos_SintesisAnual:210]P01_PromedioInterno_Nota:93;aR_promedios_ranking)
		SORT ARRAY:C229(aR_prom_OM;aL_id_alu_OM;aR_promedios_ranking;<)
		$fieldPointer:=->[Alumnos_SintesisAnual:210]P01_PromedioInterno_Real:92
		
	: ($periodoValores=2)
		KRL_RelateSelection (->[Alumnos_SintesisAnual:210]ID_Alumno:4;->[Alumnos:2]numero:1;"")
		QUERY SELECTION:C341([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]ID_Institucion:1=<>gInstitucion)
		QUERY SELECTION:C341([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]Año:2=<>gYear)
		SELECTION TO ARRAY:C260([Alumnos_SintesisAnual:210]P02_PromedioInterno_Real:121;aR_prom_OM;[Alumnos_SintesisAnual:210]ID_Alumno:4;aL_id_alu_OM;[Alumnos_SintesisAnual:210]P02_PromedioInterno_Nota:122;aR_promedios_ranking)
		SORT ARRAY:C229(aR_prom_OM;aL_id_alu_OM;aR_promedios_ranking;<)
		$fieldPointer:=->[Alumnos_SintesisAnual:210]P02_PromedioInterno_Real:121
		
	: ($periodoValores=3)
		KRL_RelateSelection (->[Alumnos_SintesisAnual:210]ID_Alumno:4;->[Alumnos:2]numero:1;"")
		QUERY SELECTION:C341([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]ID_Institucion:1=<>gInstitucion)
		QUERY SELECTION:C341([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]Año:2=<>gYear)
		SELECTION TO ARRAY:C260([Alumnos_SintesisAnual:210]P03_PromedioInterno_Real:150;aR_prom_OM;[Alumnos_SintesisAnual:210]ID_Alumno:4;aL_id_alu_OM;[Alumnos_SintesisAnual:210]P03_PromedioInterno_Nota:151;aR_promedios_ranking)
		SORT ARRAY:C229(aR_prom_OM;aL_id_alu_OM;aR_promedios_ranking;<)
		$fieldPointer:=->[Alumnos_SintesisAnual:210]P03_PromedioInterno_Real:150
		
	: ($periodoValores=4)
		KRL_RelateSelection (->[Alumnos_SintesisAnual:210]ID_Alumno:4;->[Alumnos:2]numero:1;"")
		QUERY SELECTION:C341([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]ID_Institucion:1=<>gInstitucion)
		QUERY SELECTION:C341([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]Año:2=<>gYear)
		SELECTION TO ARRAY:C260([Alumnos_SintesisAnual:210]P04_PromedioInterno_Real:179;aR_prom_OM;[Alumnos_SintesisAnual:210]ID_Alumno:4;aL_id_alu_OM;[Alumnos_SintesisAnual:210]P04_PromedioInterno_Nota:180;aR_promedios_ranking)
		SORT ARRAY:C229(aR_prom_OM;aL_id_alu_OM;aR_promedios_ranking;<)
		$fieldPointer:=->[Alumnos_SintesisAnual:210]P04_PromedioInterno_Real:179
		
	: ($periodoValores=5)
		KRL_RelateSelection (->[Alumnos_SintesisAnual:210]ID_Alumno:4;->[Alumnos:2]numero:1;"")
		QUERY SELECTION:C341([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]ID_Institucion:1=<>gInstitucion)
		QUERY SELECTION:C341([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]Año:2=<>gYear)
		SELECTION TO ARRAY:C260([Alumnos_SintesisAnual:210]P05_PromedioInterno_Real:208;aR_prom_OM;[Alumnos_SintesisAnual:210]ID_Alumno:4;aL_id_alu_OM;[Alumnos_SintesisAnual:210]P05_PromedioInterno_Nota:209;aR_promedios_ranking)
		SORT ARRAY:C229(aR_prom_OM;aL_id_alu_OM;aR_promedios_ranking;<)
		$fieldPointer:=->[Alumnos_SintesisAnual:210]P05_PromedioInterno_Real:208
		
End case 


$promaux:=101
$num_OM:=0

For ($vindex;1;Size of array:C274(aR_promedios_ranking))
	
	QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=aL_id_alu_OM{$vindex})
	APPEND TO ARRAY:C911(at_nom_alu_ranking;[Alumnos:2]apellidos_y_nombres:40)
	APPEND TO ARRAY:C911(at_curso_alu_ranking;[Alumnos:2]curso:20)
	
	If (aR_promedios_ranking{$vindex}<$promaux)
		$num_OM:=$num_OM+1
		$promaux:=aR_promedios_ranking{$vindex}
	End if 
	APPEND TO ARRAY:C911(aI_Ranking_OM;$num_OM)
	
End for 



  //restauro la selección original  
USE NAMED SELECTION:C332("temp")
GOTO SELECTED RECORD:C245([Alumnos:2];$selectedRecNum)
  //  CLEAR NAMED SELECTION("temp")

$vindex:=Records in selection:C76([Alumnos:2])

If ($vindex=1)
	
	$vindex:=Find in array:C230(aL_id_alu_OM;[Alumnos:2]numero:1;0)
	$0:=aI_Ranking_OM{$vindex}
	
End if 

  // D I R I M I R  -  R E S U L T A D O S

ARRAY INTEGER:C220(a_array_aux;0)
ARRAY INTEGER:C220(ai_rank_o;0)
ARRAY TEXT:C222(at_niveles;0)
ARRAY TEXT:C222(at_asig;0)
READ ONLY:C145([Asignaturas:18])
READ ONLY:C145([Alumnos:2])
READ ONLY:C145([Cursos:3])
READ ONLY:C145([Alumnos_Calificaciones:208])

COPY ARRAY:C226(aI_Ranking_OM;a_array_aux)
COPY ARRAY:C226(aI_Ranking_OM;ai_rank_o)
AT_DistinctsArrayValues (->a_array_aux)

If ((Size of array:C274(aI_Ranking_OM))#(Size of array:C274(a_array_aux)))
	_O_C_INTEGER:C282($v_resp;$i;$index;$v_index;$indice)
	
	$v_resp:=CD_Dlog (0;__ ("Se encontró alumnos con la misma posición en la orden de mérito, presione Continuar para dirimir estos resultados, si desea conservar el ranking original presione Cancelar");"";__ ("Continuar");__ ("Cancelar"))
	
	If ($v_resp=1)
		  //ok:=1
		QUERY WITH ARRAY:C644([Alumnos:2]numero:1;aL_id_alu_OM)
		SELECTION TO ARRAY:C260([Alumnos:2]Nivel_Nombre:34;at_niveles)
		QUERY WITH ARRAY:C644([Asignaturas:18]Nivel:30;at_niveles)
		SELECTION TO ARRAY:C260([Asignaturas:18]Asignatura:3;at_asig)
		AT_DistinctsArrayValues (->at_asig)
		
		SRtbl_ShowChoiceList (0;"Asignaturas para Dirimir";1;->bRepositorio;True:C214;->at_asig)
		
		For ($i;1;Size of array:C274(aI_Ranking_OM))
			_O_C_INTEGER:C282($pos_temp)
			$pos_temp:=aI_Ranking_OM{$i}
			ARRAY LONGINT:C221(al_idalutemp;0)
			aI_Ranking_OM{0}:=aI_Ranking_OM{$i}
			ARRAY LONGINT:C221($DA_Return;0)
			AT_SearchArray (->aI_Ranking_OM;"=";->$DA_Return)
			
			If ((Size of array:C274($DA_return))>1)
				ARRAY REAL:C219(ar_ promedios;0)
				
				For ($index;1;Size of array:C274($DA_return))  //ITERACION POR ALUMNOS EMPATADO EN UNA MISMA POSICION
					
					C_REAL:C285($sumprom;$prom)
					$sumprom:=0
					$prom:=0
					ARRAY REAL:C219(ar_notas;0)
					
					
					
					  //Modificado por ABK 20090119
					  //Modificado por dlc 27/03/2009 filtraba a las asignaturas por grupo y obtenía el promedio de todos los alumnos si se necesitaba dirimir con alumnos en distintos paralelos
					
					For ($v_index;1;Size of array:C274(aLinesSelected))  //CAPTURAR LOS PROMEDIOS DE CADA ASIGNATURA ELEGIDA PARA DIRIMIR
						QUERY:C277([Asignaturas:18];[Asignaturas:18]Asignatura:3=at_asig{aLinesSelected{$v_index}})
						KRL_RelateSelection (->[Alumnos_Calificaciones:208]ID_Asignatura:5;->[Asignaturas:18]Numero:1;"")
						QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Alumno:6=aL_id_alu_OM{$DA_return{$index}})
						
						If ($periodoValores=0)
							APPEND TO ARRAY:C911(ar_notas;[Alumnos_Calificaciones:208]EvaluacionFinal_Nota:27)
						Else 
							
							Case of 
								: ($periodoValores=1)
									APPEND TO ARRAY:C911(ar_notas;[Alumnos_Calificaciones:208]P01_Final_Nota:113)
								: ($periodoValores=2)
									APPEND TO ARRAY:C911(ar_notas;[Alumnos_Calificaciones:208]P02_Final_Nota:188)
								: ($periodoValores=3)
									APPEND TO ARRAY:C911(ar_notas;[Alumnos_Calificaciones:208]P03_Final_Nota:263)
								: ($periodoValores=4)
									APPEND TO ARRAY:C911(ar_notas;[Alumnos_Calificaciones:208]P04_Final_Nota:338)
								: ($periodoValores=5)
									APPEND TO ARRAY:C911(ar_notas;[Alumnos_Calificaciones:208]P05_Final_Nota:413)
							End case 
							
						End if 
					End for 
					  //=====================================================================================
					
					$sum_prom:=AT_GetSumArray (->ar_notas)
					$prom:=$sum_prom/(Size of array:C274(ar_notas))
					
					APPEND TO ARRAY:C911(ar_ promedios;$prom)
					APPEND TO ARRAY:C911(al_idalutemp;aL_id_alu_OM{$DA_return{$index}})
					
				End for 
				
				ARRAY REAL:C219($ar_promedios_temp;0)
				SORT ARRAY:C229(ar_ promedios;al_idalutemp;<)
				COPY ARRAY:C226(ar_ promedios;$ar_promedios_temp)
				AT_DistinctsArrayValues (->$ar_promedios_temp)
				SORT ARRAY:C229($ar_promedios_temp;<)
				  //NUEVO ORDEN DEL RANKING 
				
				
				For ($vindex;1;Size of array:C274($ar_promedios_temp))
					ARRAY INTEGER:C220($ai_validacion_paralela;0)
					ARRAY INTEGER:C220($ai_validacion_paralela;(Size of array:C274(al_id_alu_OM)))
					
					ar_ promedios{0}:=$ar_promedios_temp{$vindex}
					ARRAY LONGINT:C221($DA_Return;0)
					AT_SearchArray (->ar_ promedios;"=";->$DA_Return)
					
					For ($indice;1;Size of array:C274($DA_return))
						ARRAY INTEGER:C220($ai_temp_poss;0)
						al_id_alu_OM{0}:=al_idalutemp{$DA_return{$indice}}
						AT_SearchArray (->al_id_alu_OM;"=";->$ai_temp_poss)
						_O_C_INTEGER:C282($indi)
						For ($indi;1;Size of array:C274($ai_temp_poss))
							$ai_validacion_paralela{$ai_temp_poss{$indi}}:=1
						End for 
						
					End for 
					
					If ($vindex<(Size of array:C274($ar_promedios_temp)))
						_O_C_INTEGER:C282($ind)
						For ($ind;1;Size of array:C274(aI_Ranking_OM))
							
							If ((aI_Ranking_OM{$ind}>=$pos_temp) & ($ai_validacion_paralela{$ind}=0))
								aI_Ranking_OM{$ind}:=aI_Ranking_OM{$ind}+1
							End if 
							
						End for 
						$pos_temp:=$pos_temp+1
						
					End if 
					
					
				End for 
				
				
			End if 
			
			SORT ARRAY:C229(aI_Ranking_OM;aL_id_alu_OM;at_nom_alu_ranking;at_curso_alu_ranking;aR_promedios_ranking;aR_prom_OM;>)
			
		End for 
		
		  //REORGANIZACION DESPUES DEL DESEMPATE
		_O_C_INTEGER:C282($postempo;$sumapos)
		For ($i;1;Size of array:C274(aI_Ranking_OM))
			aI_Ranking_OM{0}:=aI_Ranking_OM{$i}
			ARRAY LONGINT:C221($DA_Return;0)
			AT_SearchArray (->aI_Ranking_OM;"=";->$DA_Return)
			$postempo:=0
			$sumapos:=0
			If ((Size of array:C274($DA_return))>1)
				$postempo:=$DA_return{(Size of array:C274($DA_return))}+1
				$sumapos:=(Size of array:C274($DA_return))-1
				For ($vindex;$postempo;Size of array:C274(aI_Ranking_OM))
					aI_Ranking_OM{$vindex}:=aI_Ranking_OM{$vindex}+$sumapos
				End for 
				$i:=$i+$sumapos
			End if 
			
		End for 
		
		
	End if 
	
	USE NAMED SELECTION:C332("temp")
	GOTO SELECTED RECORD:C245([Alumnos:2];$selectedRecNum)
	
	$vindex:=Records in selection:C76([Alumnos:2])
	
	If ($vindex=1)
		
		$vindex:=Find in array:C230(aL_id_alu_OM;[Alumnos:2]numero:1;0)
		$0:=aI_Ranking_OM{$vindex}
		
	End if 
Else 
	
End if 

CLEAR NAMED SELECTION:C333("temp")

