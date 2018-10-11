//%attributes = {}
  // AL_AsignaturasConcentracion()
  // Por: Alberto Bachler K.: 28-02-14, 10:34:35
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BLOB:C604($x_blob)
C_LONGINT:C283($i_años;$i_filas;$l_añoInicio;$l_añoTermino;$l_idProgress;$l_idxAsignatura;$l_idxPlanComun;$l_idxPlanElectivo;$l_nivel)
C_TEXT:C284($t_refConfiguracion;$t_refPreferencia;$t_ultimaConfigActasLeida)

ARRAY INTEGER:C220($ai_Ordenamiento;0)
ARRAY INTEGER:C220($ai_año;0)
ARRAY LONGINT:C221($al_IdAlumnos;0)
ARRAY LONGINT:C221($al_nivel;0)
ARRAY TEXT:C222($at_Asignaturas;0)
ARRAY TEXT:C222($at_asignaturasEnModelo;0)
ARRAY TEXT:C222($at_asignaturasTemporal;0)
ARRAY TEXT:C222($at_ordenamientoCompuesto;0)

$l_añoTermino:=$1
$l_añoInicio:=$l_añoTermino-3


ARRAY TEXT:C222(aPEAsgName;0)
ARRAY INTEGER:C220(aPEAsgPos;0)
ARRAY TEXT:C222(aPCAsgName;0)
ARRAY INTEGER:C220(aPCAsgPos;0)


  // ajuste del año de inicio
QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]Año:2;=;$l_añoTermino;*)
QUERY:C277([Alumnos_SintesisAnual:210]; & ;[Alumnos_SintesisAnual:210]NumeroNivel:6;>=;9;*)
QUERY:C277([Alumnos_SintesisAnual:210]; & ;[Alumnos_SintesisAnual:210]NumeroNivel:6;<=;12)
QUERY SELECTION:C341([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]SituacionFinal:8;=;"P";*)
QUERY SELECTION:C341([Alumnos_SintesisAnual:210]; | ;[Alumnos_SintesisAnual:210]SituacionFinal:8;=;"";*)
If (Records in selection:C76([Alumnos_SintesisAnual:210])>0)
	SELECTION TO ARRAY:C260([Alumnos_SintesisAnual:210]ID_Alumno:4;$al_IdAlumnos)
	AT_NegativeNumericArray (->$al_IdAlumnos)
	
	QUERY WITH ARRAY:C644([Alumnos_SintesisAnual:210]ID_Alumno:4;$al_IdAlumnos)
	QUERY SELECTION:C341([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]NumeroNivel:6;=;9;*)
	QUERY SELECTION:C341([Alumnos_SintesisAnual:210]; & ;[Alumnos_SintesisAnual:210]SituacionFinal:8="P")
	
	ORDER BY:C49([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]Año:2;>)
	FIRST RECORD:C50([Alumnos_SintesisAnual:210])
	$l_añoInicio:=[Alumnos_SintesisAnual:210]Año:2  //restablezco el año de inicio para considerar anños anteriores en caso de alumnos que repitieron algún curso de enseñanza media
End if 


$l_idProgress:=Progress New 
For ($i_años;$l_añoInicio;$l_añoTermino)
	
	Progress SET PROGRESS ($l_idProgress;$i_años/$l_añoTermino;__ ("Verificando modelo de concentración para el año ")+String:C10($l_añoTermino);True:C214)
	
	  // inicializo la configuración
	AT_Initialize (->aPCAsgName;->aPCAsgPos;->aPEAsgName;->aPEAsgPos)
	BLOB_Variables2Blob (->$x_blob;0;->aPCAsgName;->aPCAsgPos;->aPEAsgName;->aPEAsgPos)
	
	  // leo la configuración
	$t_refPreferencia:="ConcentraciónNotas.cl."+String:C10($l_añoTermino)
	$x_blob:=PREF_fGetBlob (0;$t_refPreferencia;$x_blob)
	BLOB_Blob2Vars (->$x_blob;0;->aPCAsgName;->aPCAsgPos;->aPEAsgName;->aPEAsgPos)
	  //.
	
	  // verifico que las asignaturas no esten duplicadas en los planes común y electivo
	For ($i_filas;Size of array:C274(aPEAsgName);1;-1)
		If (Find in array:C230(aPCAsgName;aPEAsgName{$i_filas})>0)
			AT_Delete ($i_filas;1;->aPEAsgName;->aPEAsgPos)
		End if 
	End for 
	
	  // reasigno los numeros de fila en planes común y electivo
	ARRAY INTEGER:C220(aPCAsgPos;Size of array:C274(aPCAsgName))
	For ($i_filas;1;Size of array:C274(aPCAsgName))
		aPCAsgPos{$i_filas}:=$i_filas
	End for 
	ARRAY INTEGER:C220(aPEAsgPos;Size of array:C274(aPEAsgName))
	For ($i_filas;1;Size of array:C274(aPEAsgName))
		aPEAsgPos{$i_filas}:=$i_filas
	End for 
	  //.
	
	
	CREATE EMPTY SET:C140([Asignaturas_Historico:84];"Historico")
	
	  //**** LECTURA DE LAS ASIGNATURAS DEL PLAN COMUN DE AÑOS ANTERIORES  ****
	SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
	QUERY:C277([Asignaturas_Historico:84];[Asignaturas_Historico:84]Año:5>=$l_añoInicio;*)
	QUERY:C277([Asignaturas_Historico:84]; & [Asignaturas_Historico:84]Año:5<=$l_añoTermino;*)
	QUERY:C277([Asignaturas_Historico:84]; & [Asignaturas_Historico:84]Nivel:4>=9;*)
	QUERY:C277([Asignaturas_Historico:84]; & [Asignaturas_Historico:84]Nivel:4<=12)
	QUERY SELECTION:C341([Asignaturas_Historico:84];[Asignaturas_Historico:84]Incluida_En_Actas:7=True:C214;*)
	QUERY SELECTION:C341([Asignaturas_Historico:84]; & [Asignaturas_Historico:84]Electiva:10=False:C215;*)
	QUERY SELECTION:C341([Asignaturas_Historico:84]; & [Asignaturas_Historico:84]Promediable:6=True:C214)
	CREATE SET:C116([Asignaturas_Historico:84];"Obligatorias")
	UNION:C120("Historico";"Obligatorias";"Historico")
	SET_ClearSets ("Obligatorias")
	ORDER BY:C49([Asignaturas_Historico:84];[Asignaturas_Historico:84]Asignatura:2;>)
	SELECTION TO ARRAY:C260([Asignaturas_Historico:84]Asignatura:2;$at_Asignaturas;[Asignaturas_Historico:84]Año:5;$ai_año;[Asignaturas_Historico:84]Nivel:4;$al_nivel)
	SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
	
	
	SORT ARRAY:C229($at_Asignaturas;$ai_año;$al_nivel;>)
	For ($i_filas;Size of array:C274($at_Asignaturas);1;-1)
		If ($at_Asignaturas{$i_filas}=$at_Asignaturas{$i_filas-1})
			AT_Delete ($i_filas;1;->$at_Asignaturas;->$ai_año;->$al_nivel)
		End if 
	End for 
	COPY ARRAY:C226($at_asignaturasEnModelo;$at_asignaturasTemporal)
	AT_Union (->$at_Asignaturas;->$at_asignaturasTemporal;->$at_asignaturasEnModelo)
	
	
	
	  // **** POSICIONAMIENTO DE LAS ASIGNATURAS DEL PLAN COMUN DE AÑOS ANTERIORES EN EL MODELO DE CONCENTRACION ****
	AT_MultiLevelSort (">>";->$ai_año;->$al_nivel;->$at_Asignaturas)
	$t_ultimaConfigActasLeida:=""
	For ($i_filas;1;Size of array:C274($at_Asignaturas))
		  // determino si es necesario leer la configuración de actas y la leo
		$t_refConfiguracion:=String:C10($ai_año{$i_filas})+"."+String:C10($al_nivel{$i_filas})
		If ($t_ultimaConfigActasLeida#$t_refConfiguracion)
			ACTAS_LeeConfiguracion ($al_nivel{$i_filas};"";$ai_año{$i_filas})
		End if 
		
		  // busco la asignatura en el plan común de la concentración
		$l_idxPlanComun:=Find in array:C230(aPCAsgName;$at_Asignaturas{$i_filas})
		
		If ($l_idxPlanComun<0)
			  // si no está la busco en el plan electivo
			$l_idxPlanElectivo:=Find in array:C230(aPEAsgName;$at_Asignaturas{$i_filas})
			
			If ($l_idxPlanElectivo<0)
				  // si no está en el plan común ni en el plan electivo, la agrego al plan común
				$l_idxAsignatura:=Find in array:C230(atActas_Subsectores;$at_Asignaturas{$i_filas})
				If ($l_idxAsignatura>0) & ($l_idxAsignatura<=Size of array:C274(alActas_ColumnNumber))
					$l_idxPlanComun:=alActas_ColumnNumber{$l_idxAsignatura}
				Else 
					$l_idxPlanComun:=1000
				End if 
				  //$l_idxPlanComun:=Choose($l_idxAsignatura>0;alActas_ColumnNumber{$l_idxAsignatura};1000)  // si no está en la configuracion la agrego en el índice 1000
				APPEND TO ARRAY:C911(aPCAsgName;$at_Asignaturas{$i_filas})
				APPEND TO ARRAY:C911(aPCAsgPos;$l_idxPlanComun)
			End if 
		Else 
			$l_idxAsignatura:=Find in array:C230(atActas_Subsectores;$at_Asignaturas{$i_filas})
			If ($l_idxAsignatura>0) & ($l_idxAsignatura<=Size of array:C274(alActas_ColumnNumber))
				aPCAsgPos{$l_idxPlanComun}:=alActas_ColumnNumber{$l_idxAsignatura}
			End if 
		End if 
	End for 
	  //.
	
	  //**** LECTURA DE LAS ASIGNATURAS DEL PLAN ELECTIVO AÑOS ANTERIORES  ****
	SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
	  // Selecciono las asignaturas en actas, electivas y con incidencia en promedio en años anteriores
	QUERY:C277([Asignaturas_Historico:84];[Asignaturas_Historico:84]Año:5>=$l_añoInicio;*)
	QUERY:C277([Asignaturas_Historico:84]; & [Asignaturas_Historico:84]Año:5<=$l_añoTermino)
	QUERY:C277([Asignaturas_Historico:84]; & [Asignaturas_Historico:84]Nivel:4>=9;*)
	QUERY:C277([Asignaturas_Historico:84]; & [Asignaturas_Historico:84]Nivel:4<=12)
	QUERY SELECTION:C341([Asignaturas_Historico:84];[Asignaturas_Historico:84]Incluida_En_Actas:7=True:C214;*)
	QUERY SELECTION:C341([Asignaturas_Historico:84]; & [Asignaturas_Historico:84]Electiva:10=True:C214;*)
	QUERY SELECTION:C341([Asignaturas_Historico:84]; & [Asignaturas_Historico:84]Promediable:6=True:C214)
	CREATE SET:C116([Asignaturas_Historico:84];"Electivas")
	UNION:C120("Historico";"Electivas";"Historico")
	SET_ClearSets ("Electivas")
	ORDER BY:C49([Asignaturas_Historico:84];[Asignaturas_Historico:84]Asignatura:2;>)
	SELECTION TO ARRAY:C260([Asignaturas_Historico:84]Asignatura:2;$at_Asignaturas;[Asignaturas_Historico:84]Año:5;$ai_año;[Asignaturas_Historico:84]Nivel:4;$al_nivel)
	SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
	SORT ARRAY:C229($at_Asignaturas;$ai_año;$al_nivel;>)
	For ($i_filas;Size of array:C274($at_Asignaturas);1;-1)
		If ($at_Asignaturas{$i_filas}=$at_Asignaturas{$i_filas-1})
			AT_Delete ($i_filas;1;->$at_Asignaturas;->$ai_año;->$al_nivel)
		End if 
	End for 
	COPY ARRAY:C226($at_asignaturasEnModelo;$at_asignaturasTemporal)
	AT_Union (->$at_Asignaturas;->$at_asignaturasTemporal;->$at_asignaturasEnModelo)
	  //.
	
	  // determino la posición de las asignaturas elecivas en la concentración de acuerdo a la configuración del acta
	AT_MultiLevelSort (">>";->$ai_año;->$al_nivel;->$at_Asignaturas)
	$t_ultimaConfigActasLeida:=""
	For ($i_filas;1;Size of array:C274($at_Asignaturas))
		  // determino si es necesario leer la configuración de actas y la leo
		$t_refConfiguracion:=String:C10($ai_año{$i_filas})+"."+String:C10($al_nivel{$i_filas})
		If ($t_ultimaConfigActasLeida#$t_refConfiguracion)
			ACTAS_LeeConfiguracion ($al_nivel{$i_filas};"";$ai_año{$i_filas})
		End if 
		  // busco la asignatura en el plan electivo de la concentración
		$l_idxPlanElectivo:=Find in array:C230(aPEAsgName;$at_Asignaturas{$i_filas})
		If ($l_idxPlanElectivo<0)
			  // si no está la busco en el plan común
			$l_idxPlanComun:=Find in array:C230(aPCAsgName;$at_Asignaturas{$i_filas})
			If ($l_idxPlanComun<0)
				  // si no está en el plan común ni en el plan electivo, la agrego al plan electivo
				$l_idxAsignatura:=Find in array:C230(atActas_Subsectores;$at_Asignaturas{$i_filas})
				  //$l_idxPlanElectivo:=Choose($l_idxAsignatura;alActas_ColumnNumber{$l_idxAsignatura};1000)  // si no está en la configuracion la agrego en el índice 1000
				
				If ($l_idxAsignatura>0) & ($l_idxAsignatura<=Size of array:C274(alActas_ColumnNumber))
					$l_idxPlanComun:=alActas_ColumnNumber{$l_idxAsignatura}
				Else 
					$l_idxPlanComun:=1000
				End if 
				
				APPEND TO ARRAY:C911(aPEAsgName;$at_Asignaturas{$i_filas})
				APPEND TO ARRAY:C911(aPEAsgPos;$l_idxPlanElectivo)
			End if 
		Else 
			$l_idxAsignatura:=Find in array:C230(atActas_Subsectores;$at_Asignaturas{$i_filas})
			If ($l_idxAsignatura>0) & ($l_idxAsignatura<=Size of array:C274(alActas_ColumnNumber))
				aPEAsgPos{$l_idxPlanElectivo}:=alActas_ColumnNumber{$l_idxAsignatura}
			End if 
		End if 
	End for 
	  //.
	
	
	If ($l_añoTermino=<>gYear)
		  // leo la configuración del acta para poder determinar la posición de las asignaturas en el modelo de concentración
		$l_nivel:=12
		ACTAS_LeeConfiguracion ($l_nivel;"";$l_añoTermino)
		
		
		
		  //Selecciono las asignaturas en actas, electivas y con incidencia en promedio del plan común del 4º medio actual
		QUERY:C277([Asignaturas:18]; & [Asignaturas:18]Numero_del_Nivel:6=12)
		QUERY SELECTION:C341([Asignaturas:18];[Asignaturas:18]Incluida_en_Actas:44=True:C214;*)
		QUERY SELECTION:C341([Asignaturas:18]; & [Asignaturas:18]Electiva:11=False:C215;*)
		QUERY SELECTION:C341([Asignaturas:18]; & [Asignaturas:18]Incide_en_promedio:27=True:C214)
		SELECTION TO ARRAY:C260([Asignaturas:18]Asignatura:3;$at_Asignaturas)
		SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
		SORT ARRAY:C229($at_Asignaturas;>)
		For ($i_filas;Size of array:C274($at_Asignaturas);1;-1)
			If ($at_Asignaturas{$i_filas}=$at_Asignaturas{$i_filas-1})
				AT_Delete ($i_filas;1;->$at_Asignaturas)
			End if 
		End for 
		COPY ARRAY:C226($at_asignaturasEnModelo;$at_asignaturasTemporal)
		AT_Union (->$at_Asignaturas;->$at_asignaturasTemporal;->$at_asignaturasEnModelo)
		  //.
		
		
		  // **** POSICIONAMIENTO DE LAS ASIGNATURAS EN EL MODELO DE CONCENTRACION ****
		For ($i_filas;1;Size of array:C274($at_Asignaturas))
			  // busco la asignatura en el plan común de la concentración
			$l_idxPlanComun:=Find in array:C230(aPCAsgName;$at_Asignaturas{$i_filas})
			
			If ($l_idxPlanComun<0)
				  // si no está la busco en el plan electivo
				$l_idxPlanElectivo:=Find in array:C230(aPEAsgName;$at_Asignaturas{$i_filas})
				
				If ($l_idxPlanElectivo<0)
					  // si no está en el plan común ni en el plan electivo, la agrego al plan común
					$l_idxAsignatura:=Find in array:C230(atActas_Subsectores;$at_Asignaturas{$i_filas})
					  //$l_idxPlanComun:=Choose($l_idxAsignatura;alActas_ColumnNumber{$l_idxAsignatura};1000)  // si no está en la configuracion la agrego en el índice 1000
					
					If ($l_idxAsignatura>0) & ($l_idxAsignatura<=Size of array:C274(alActas_ColumnNumber))
						$l_idxPlanComun:=alActas_ColumnNumber{$l_idxAsignatura}
					Else 
						$l_idxPlanComun:=1000
					End if 
					
					APPEND TO ARRAY:C911(aPCAsgName;$at_Asignaturas{$i_filas})
					APPEND TO ARRAY:C911(aPCAsgPos;$l_idxPlanComun)
				End if 
				
			Else 
				$l_idxAsignatura:=Find in array:C230(atActas_Subsectores;$at_Asignaturas{$i_filas})
				If ($l_idxAsignatura>0) & ($l_idxAsignatura<=Size of array:C274(alActas_ColumnNumber))
					aPCAsgPos{$l_idxPlanComun}:=alActas_ColumnNumber{$l_idxAsignatura}
				End if 
			End if 
		End for 
		  // **** //
		
		
		
		  //**** LECTURA DE LAS ASIGNATURAS DEL PLAN ELECTIVO DE 4º MEDIO ACTUAL  ****
		QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero_del_Nivel:6=12)
		QUERY SELECTION:C341([Asignaturas:18];[Asignaturas:18]Incluida_en_Actas:44=True:C214;*)
		QUERY SELECTION:C341([Asignaturas:18]; & [Asignaturas:18]Electiva:11=True:C214;*)
		QUERY SELECTION:C341([Asignaturas:18]; & [Asignaturas:18]Incide_en_promedio:27=True:C214)
		SELECTION TO ARRAY:C260([Asignaturas:18]Asignatura:3;$at_Asignaturas)
		SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
		
		SORT ARRAY:C229($at_Asignaturas;>)
		For ($i_filas;Size of array:C274($at_Asignaturas);1;-1)
			If ($at_Asignaturas{$i_filas}=$at_Asignaturas{$i_filas-1})
				AT_Delete ($i_filas;1;->$at_Asignaturas)
			End if 
		End for 
		COPY ARRAY:C226($at_asignaturasEnModelo;$at_asignaturasTemporal)
		AT_Union (->$at_Asignaturas;->$at_asignaturasTemporal;->$at_asignaturasEnModelo)
		  // **** //
		
		  // **** POSICIONAMIENTO DE LAS ASIGNATURAS ELECTIVAS EN EL MODELO DE CONCENTRACION ****
		For ($i_filas;1;Size of array:C274($at_Asignaturas))
			  // busco la asignatura en el plan electivo de la concentración
			$l_idxPlanElectivo:=Find in array:C230(aPEAsgName;$at_Asignaturas{$i_filas})
			
			If ($l_idxPlanElectivo<0)
				  // si no está la busco en el plan común
				$l_idxPlanComun:=Find in array:C230(aPCAsgName;$at_Asignaturas{$i_filas})
				
				If ($l_idxPlanComun<0)
					  // si no está en el plan común ni en el plan electivo, la agrego al plan electivo
					$l_idxAsignatura:=Find in array:C230(atActas_Subsectores;$at_Asignaturas{$i_filas})
					  //$l_idxPlanElectivo:=Choose($l_idxAsignatura;alActas_ColumnNumber{$l_idxAsignatura};1000)  // si no está en la configuracion la agrego en el índice 1000
					If ($l_idxAsignatura>0) & ($l_idxAsignatura<=Size of array:C274(alActas_ColumnNumber))
						$l_idxPlanComun:=alActas_ColumnNumber{$l_idxAsignatura}
					Else 
						$l_idxPlanComun:=1000
					End if 
					APPEND TO ARRAY:C911(aPEAsgName;$at_Asignaturas{$i_filas})
					APPEND TO ARRAY:C911(aPEAsgPos;$l_idxPlanElectivo)
				End if 
			Else 
				aPEAsgPos{$l_idxPlanElectivo}:=alActas_ColumnNumber{$l_idxAsignatura}
			End if 
		End for 
		  // **** //
		
	End if 
End for 
Progress QUIT ($l_idProgress)


For ($i_filas;Size of array:C274(aPCAsgName);1;-1)
	If (Find in array:C230($at_asignaturasEnModelo;aPCAsgName{$i_filas})<1)
		AT_Delete ($i_filas;1;->aPCAsgName;->aPCAsgPos)
	End if 
End for 
SORT ARRAY:C229(aPCAsgPos;aPCAsgName;>)
For ($i_filas;1;Size of array:C274(aPCAsgName))
	aPCAsgPos{$i_filas}:=$i_filas
End for 

For ($i_filas;Size of array:C274(aPEAsgName);1;-1)
	If (Find in array:C230($at_asignaturasEnModelo;aPEAsgName{$i_filas})<1)
		AT_Delete ($i_filas;1;->aPEAsgName;->aPEAsgPos)
	End if 
End for 
SORT ARRAY:C229(aPEAsgPos;aPEAsgName;>)
For ($i_filas;1;Size of array:C274(aPEAsgName))
	aPEAsgPos{$i_filas}:=$i_filas
End for 


$t_refPreferencia:="ConcentraciónNotas.cl."+String:C10($l_añoTermino)
SET BLOB SIZE:C606($x_blob;0)
BLOB_Variables2Blob (->$x_blob;0;->aPCAsgName;->aPCAsgPos;->aPEAsgName;->aPEAsgPos)
PREF_SetBlob (0;$t_refPreferencia;$x_blob)



vt_Errores:=""
vl_MaxPC:=0
vl_MaxPE:=0