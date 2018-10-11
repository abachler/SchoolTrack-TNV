//%attributes = {}
  // EVLG_Configuracion()
  //
  //
  //
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 27/06/12, 20:55:47
  // ---------------------------------------------
C_BLOB:C604($x_recNumAsignaturas)
C_LONGINT:C283($l_procesoRecalculo)
C_TEXT:C284($t_mensaje)

ARRAY LONGINT:C221($al_recNumAsignaturas;0)

  // CÓDIGO
EVLG_Init 

  //***
  // Creo los conjuntos vacios en los que pondré las matrices y las asignaturas en las que será necesario
  // recalcular promedios al salir del formulario de configuración.
  // Estos conjuntos son alimentados en los métodos que introducen cambios en las matrices llamados desde
  // el formulario de configuración:

  // - creación del conjunto vacío para las matrices de evaluación modificadas
CREATE EMPTY SET:C140([MPA_AsignaturasMatrices:189];"$matrices_a_recalcular")

  // - creación del conjunto de asignaturas
  // este conjunto se utiliza cuando se han eliminado las matrices utilizadas por las asignaturas
  // este conjunto es alimentado en los siguientes métodos
  // - EVLG_EliminaArea
  // - EVLG_EliminaAsignaciones
CREATE EMPTY SET:C140([Asignaturas:18];"$asignaturas_a_recalcular")
  //***

CFG_OpenConfigPanel (->[MPA_DefinicionAreas:186];"Configuracion")
KRL_UnloadReadOnly (->[MPA_DefinicionAreas:186])
KRL_UnloadReadOnly (->[MPA_AsignaturasMatrices:189])
KRL_UnloadReadOnly (->[MPA_DefinicionEjes:185])
KRL_UnloadReadOnly (->[MPA_DefinicionCompetencias:187])
KRL_UnloadReadOnly (->[Asignaturas:18])
KRL_UnloadReadOnly (->[MPA_ObjetosMatriz:204])
KRL_UnloadReadOnly (->[Alumnos_EvaluacionAprendizajes:203])
KRL_UnloadReadOnly (->[Alumnos_Calificaciones:208])
KRL_UnloadReadOnly (->[Alumnos_ComplementoEvaluacion:209])
FLUSH CACHE:C297

If (Records in set:C195("$matrices_a_recalcular")>0)
	  // Si hay registros de matrices modificadas que podrían exigir el recalculo de promedios en las asignaturas
	  // que las utilizan, utilizo el conjunto
	USE SET:C118("$matrices_a_recalcular")
	SET_ClearSets ("$matrices_a_recalcular")
	
	  // determino cuales son las matrices en las que hay opciones de calculos activas
	QUERY SELECTION:C341([MPA_AsignaturasMatrices:189];[MPA_AsignaturasMatrices:189]ModoCalculoDimensiones:6>0;*)
	QUERY SELECTION:C341([MPA_AsignaturasMatrices:189]; | ;[MPA_AsignaturasMatrices:189]ModoCalculoEjes:10>0;*)
	QUERY SELECTION:C341([MPA_AsignaturasMatrices:189]; | ;[MPA_AsignaturasMatrices:189]ResultadoFinalCalculado:7=True:C214;*)
	QUERY SELECTION:C341([MPA_AsignaturasMatrices:189]; | ;[MPA_AsignaturasMatrices:189]Convertir_a_Notas:9=True:C214)
	
	If (Records in selection:C76([MPA_AsignaturasMatrices:189])>0)
		  // construyo la selección de asignaturas para recalculo a partir de la selección de matrices modificadas
		  // y con opciones de calculos activas
		KRL_RelateSelection (->[Asignaturas:18]EVAPR_IdMatriz:91;->[MPA_AsignaturasMatrices:189]ID_Matriz:1)
		CREATE SET:C116([Asignaturas:18];"$asignaturas_conMatricesModificadas")
		UNION:C120("$asignaturas_a_recalcular";"$asignaturas_conMatricesModificadas";"$asignaturas_a_recalcular")
	End if 
End if 



If (Records in set:C195("$asignaturas_a_recalcular")>0)
	  // si hay asignaturas en el conjunto de asignaturas a recalcular (matrices eliminadas)
	  // creo un conjunto con la selección de asignaturas anterior
	CREATE SET:C116([Asignaturas:18];"$asignaturas_de_matrices")
	  // combino ambos conjuntos y utilizo el resultado
	UNION:C120("$asignaturas_a_recalcular";"$asignaturas_de_matrices";"$asignaturas_a_recalcular")
	USE SET:C118("$asignaturas_a_recalcular")
	
	  // pongo los recum de asignaturas a recalcular en un rreglo y en un blob
	LONGINT ARRAY FROM SELECTION:C647([Asignaturas:18];$al_recNumAsignaturas;"")
	BLOB_Variables2Blob (->$x_recNumAsignaturas;0;->$al_recNumAsignaturas)
	
	
	  // advierto al usuario del inicio de la tarea de recalculo
	$t_mensaje:=__ ("Usted introdujo cambios en mapas de aprendizaje que hacen necesario el recalculo de promedios en algunas asignaturas.")
	$t_mensaje:=$t_mensaje+"\r\r"+__ ("El calculo de promedios se ejecutará en una tarea de segundo plano para evitar bloquear su trabajo en SchoolTrack.\rTenga en cuenta que el recalculo sólo estará completo una vez que la tarea de segundo plano haya finalizado.")
	CD_Dlog (0;$t_mensaje)
	
	  // y ejecuto la tarea en segundo plano, en un proceso aparte
	$l_procesoRecalculo:=New process:C317("EV2dbu_Recalculos";256*1024;"Recalculo de promedios";$x_recNumAsignaturas)
	
End if 


SET_ClearSets ("$asignaturas_a_recalcular";"$asignaturas_conMatricesModificadas";"$matrices_a_recalcular";"$asignaturas_de_matrices")