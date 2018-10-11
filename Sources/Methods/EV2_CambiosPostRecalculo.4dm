//%attributes = {}
  // MÉTODO: EV2_CambiosPostRecalculo
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 26/12/11, 15:18:50
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // Maneja todas las accionespostrecalculo de promedios en el pseudo componente de comparación
  // de promedios antes y después recalculo
  // PARÁMETROS
  // EV2_CambiosPostRecalculo(método)
  // $1: metodo a ejecutar: texto
  // ----------------------------------------------------
C_TEXT:C284($1)

C_LONGINT:C283($i;$iAlumnos;$iAsignaturas;$l_ComparacionesRealizadas;$l_itemEncontrado;$l_p;$l_recNumAsignatura;$l_recNumEvaluacion;$l_Registros_a_Comparar;$l_thermProcessID)
C_TIME:C306($h_referenciaDocumento)
C_TEXT:C284($t_Alumno;$t_asignatura;$t_detalleDiferencia;$t_llaveRegistro;$t_method;$t_Prefijo)

ARRAY LONGINT:C221($al_RecNums;0)
ARRAY TEXT:C222($at_Rows;0)
If (False:C215)
	C_TEXT:C284(EV2_CambiosPostRecalculo ;$1)
End if 

  // CODIGO PRINCIPAL

C_BOOLEAN:C305(<>vb_ComparacionDisponible)
C_LONGINT:C283(<>hl_avgDiff_Asignaturas)
C_LONGINT:C283(<>hl_avgDiff_Alumnos)

$t_method:=$1

Case of 
	: ($t_method="Init")
		<>vb_ComparacionActiva:=True:C214
		ARRAY TEXT:C222(<>at_KeyCalificaciones;0)
		ARRAY TEXT:C222(<>at_Final_Literal;0)
		ARRAY TEXT:C222(<>at_Final_Simbolos;0)
		ARRAY TEXT:C222(<>at_FinalOficial_Literal;0)
		ARRAY TEXT:C222(<>at_FinalOficial_Simbolos;0)
		ARRAY TEXT:C222(<>at_Anual_Literal;0)
		ARRAY TEXT:C222(<>at_Anual_Simbolos;0)
		ARRAY TEXT:C222(<>at_P01_Literal;0)
		ARRAY TEXT:C222(<>at_P02_Literal;0)
		ARRAY TEXT:C222(<>at_P03_Literal;0)
		ARRAY TEXT:C222(<>at_P04_Literal;0)
		ARRAY TEXT:C222(<>at_P05_Literal;0)
		ARRAY TEXT:C222(<>at_P01_Simbolos;0)
		ARRAY TEXT:C222(<>at_P02_Simbolos;0)
		ARRAY TEXT:C222(<>at_P03_Simbolos;0)
		ARRAY TEXT:C222(<>at_P04_Simbolos;0)
		ARRAY TEXT:C222(<>at_P05_Simbolos;0)
		ARRAY REAL:C219(<>ar_Final_Real;0)
		ARRAY REAL:C219(<>ar_Final_Nota;0)
		ARRAY REAL:C219(<>ar_Final_Puntos;0)
		ARRAY REAL:C219(<>ar_FinalOficial_Nota;0)
		ARRAY REAL:C219(<>ar_FinalOficial_Puntos;0)
		ARRAY REAL:C219(<>ar_FinalOficial_Real;0)
		ARRAY REAL:C219(<>ar_Anual_Real;0)
		ARRAY REAL:C219(<>ar_Anual_Nota;0)
		ARRAY REAL:C219(<>ar_Anual_Puntos;0)
		ARRAY REAL:C219(<>ar_P01_Real;0)
		ARRAY REAL:C219(<>ar_P02_Real;0)
		ARRAY REAL:C219(<>ar_P03_Real;0)
		ARRAY REAL:C219(<>ar_P04_Real;0)
		ARRAY REAL:C219(<>ar_P05_Real;0)
		ARRAY REAL:C219(<>ar_P01_Nota;0)
		ARRAY REAL:C219(<>ar_P02_Nota;0)
		ARRAY REAL:C219(<>ar_P04_Nota;0)
		ARRAY REAL:C219(<>ar_P03_Nota;0)
		ARRAY REAL:C219(<>ar_P05_Nota;0)
		ARRAY REAL:C219(<>ar_P01_Puntos;0)
		ARRAY REAL:C219(<>ar_P02_Puntos;0)
		ARRAY REAL:C219(<>ar_P03_Puntos;0)
		ARRAY REAL:C219(<>ar_P04_Puntos;0)
		ARRAY REAL:C219(<>ar_P05_Puntos;0)
		HL_ClearList (<>hl_avgDiff_Asignaturas;<>hl_avgDiff_Alumnos)
		<>hl_avgDiff_Asignaturas:=New list:C375
		<>hl_avgDiff_Alumnos:=New list:C375
		<>vt_IPMsg_Message:=""
		<>vl_IPMsg_Tab2Select:=0
		<>vl_IPMsg_OpenRecNum:=-1
		
	: ($t_method="LoadAverages_BeforeRecalc")
		
		<>vb_ComparacionDisponible:=True:C214
		
		If (Records in selection:C76([Asignaturas:18])>5)
			$l_thermProcessID:=IT_UThermometer (1;0;__ ("Preparando datos para comparaciones post cálculo de promedios..."))
		End if 
		EV2_Calificaciones_SeleccionAS 
		  //ALERT("Registros de calificaciones a comparar: "+String(Records in selection([Alumnos_Calificaciones])))
		SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
		ORDER BY:C49([Alumnos_Calificaciones:208];[Asignaturas:18]Numero_del_Nivel:6;>;[Asignaturas:18]Curso:5;>;[Asignaturas:18]denominacion_interna:16;>;[Alumnos:2]apellidos_y_nombres:40;>)
		SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]Llave_principal:1;<>at_KeyCalificaciones;[Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30;<>at_Final_Literal;[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26;<>ar_Final_Real;[Alumnos_Calificaciones:208]EvaluacionFinal_Nota:27;<>ar_Final_Nota;[Alumnos_Calificaciones:208]EvaluacionFinal_Puntos:28;<>ar_Final_Puntos;[Alumnos_Calificaciones:208]EvaluacionFinal_Simbolo:29;<>at_Final_Simbolos)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36;<>at_FinalOficial_Literal;[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32;<>ar_FinalOficial_Real;[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33;<>ar_FinalOficial_Nota;[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Puntos:34;<>ar_FinalOficial_Puntos;[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Simbolo:35;<>at_FinalOficial_Simbolos)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]Anual_Literal:15;<>at_Anual_Literal;[Alumnos_Calificaciones:208]Anual_Real:11;<>ar_Anual_Real;[Alumnos_Calificaciones:208]Anual_Nota:12;<>ar_Anual_Nota;[Alumnos_Calificaciones:208]Anual_Puntos:13;<>ar_Anual_Puntos;[Alumnos_Calificaciones:208]Anual_Simbolo:14;<>at_Anual_Simbolos)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P01_Final_Literal:116;<>at_P01_Literal;[Alumnos_Calificaciones:208]P01_Final_Real:112;<>ar_P01_Real;[Alumnos_Calificaciones:208]P01_Final_Nota:113;<>ar_P01_Nota;[Alumnos_Calificaciones:208]P01_Final_Puntos:114;<>ar_P01_Puntos;[Alumnos_Calificaciones:208]P01_Final_Simbolo:115;<>at_P01_Simbolos)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P02_Final_Literal:191;<>at_P02_Literal;[Alumnos_Calificaciones:208]P02_Final_Real:187;<>ar_P02_Real;[Alumnos_Calificaciones:208]P02_Final_Nota:188;<>ar_P02_Nota;[Alumnos_Calificaciones:208]P02_Final_Puntos:189;<>ar_P02_Puntos;[Alumnos_Calificaciones:208]P02_Final_Simbolo:190;<>at_P02_Simbolos)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P03_Final_Literal:266;<>at_P03_Literal;[Alumnos_Calificaciones:208]P03_Final_Real:262;<>ar_P03_Real;[Alumnos_Calificaciones:208]P03_Final_Nota:263;<>ar_P03_Nota;[Alumnos_Calificaciones:208]P03_Final_Puntos:264;<>ar_P03_Puntos;[Alumnos_Calificaciones:208]P03_Final_Simbolo:265;<>at_P03_Simbolos)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P04_Final_Literal:341;<>at_P04_Literal;[Alumnos_Calificaciones:208]P04_Final_Real:337;<>ar_P04_Real;[Alumnos_Calificaciones:208]P04_Final_Nota:338;<>ar_P04_Nota;[Alumnos_Calificaciones:208]P04_Final_Puntos:339;<>ar_P04_Puntos;[Alumnos_Calificaciones:208]P04_Final_Simbolo:340;<>at_P04_Simbolos)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P05_Final_Literal:416;<>at_P05_Literal;[Alumnos_Calificaciones:208]P05_Final_Real:412;<>ar_P05_Real;[Alumnos_Calificaciones:208]P05_Final_Nota:413;<>ar_P05_Nota;[Alumnos_Calificaciones:208]P05_Final_Puntos:414;<>ar_P05_Puntos;[Alumnos_Calificaciones:208]P05_Final_Simbolo:415;<>at_P05_Simbolos)
		If ($l_thermProcessID>0)
			$l_thermProcessID:=IT_UThermometer (-2;$l_thermProcessID)
		End if 
		
	: ($t_method="BuildChangeList")
		
		If (Size of array:C274(<>at_KeyCalificaciones)>200)
			$l_thermProcessID:=IT_UThermometer (1;0;__ ("Buscando diferencias post re-cálculo de promedios..."))
		End if 
		HL_ClearList (<>hl_avgDiff_Asignaturas;<>hl_avgDiff_Alumnos)
		<>hl_avgDiff_Asignaturas:=New list:C375
		<>hl_avgDiff_Alumnos:=New list:C375
		
		CREATE EMPTY SET:C140([Asignaturas:18];"DiferenciasPromedio")
		
		
		$l_Registros_a_Comparar:=Size of array:C274(<>at_KeyCalificaciones)
		For ($i;1;$l_Registros_a_Comparar)
			$t_llaveRegistro:=<>at_KeyCalificaciones{$i}
			KRL_FindAndLoadRecordByIndex (->[Alumnos_Calificaciones:208]Llave_principal:1;->$t_llaveRegistro;False:C215)
			KRL_FindAndLoadRecordByIndex (->[Asignaturas:18]Numero:1;->[Alumnos_Calificaciones:208]ID_Asignatura:5;False:C215)
			Case of 
				: (([Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30#<>at_Final_Literal{$i}) | ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26#<>ar_Final_Real{$i}) | ([Alumnos_Calificaciones:208]EvaluacionFinal_Nota:27#<>ar_Final_Nota{$i}) | ([Alumnos_Calificaciones:208]EvaluacionFinal_Puntos:28#<>ar_Final_Puntos{$i}) | ([Alumnos_Calificaciones:208]EvaluacionFinal_Simbolo:29#<>at_Final_Simbolos{$i}))
					If (HL_FindInListByReference (<>hl_avgDiff_Asignaturas;Record number:C243([Asignaturas:18]))="")
						APPEND TO LIST:C376(<>hl_avgDiff_Asignaturas;[Asignaturas:18]denominacion_interna:16+", "+[Asignaturas:18]Curso:5;Record number:C243([Asignaturas:18]))
						ADD TO SET:C119([Asignaturas:18];"DiferenciasPromedio")
					End if 
				: (([Asignaturas:18]Incide_en_promedio:27 | [Asignaturas:18]Incluida_en_Actas:44) & (([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36#<>at_FinalOficial_Literal{$i}) | ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32#<>ar_FinalOficial_Real{$i}) | ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33#<>ar_FinalOficial_Nota{$i}) | ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Puntos:34#<>ar_FinalOficial_Puntos{$i}) | ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Simbolo:35#<>at_FinalOficial_Simbolos{$i})))
					If (HL_FindInListByReference (<>hl_avgDiff_Asignaturas;Record number:C243([Asignaturas:18]))="")
						APPEND TO LIST:C376(<>hl_avgDiff_Asignaturas;[Asignaturas:18]denominacion_interna:16+", "+[Asignaturas:18]Curso:5;Record number:C243([Asignaturas:18]))
						ADD TO SET:C119([Asignaturas:18];"DiferenciasPromedio")
					End if 
				: (([Alumnos_Calificaciones:208]Anual_Literal:15#<>at_Anual_Literal{$i}) | ([Alumnos_Calificaciones:208]Anual_Real:11#<>ar_Anual_Real{$i}) | ([Alumnos_Calificaciones:208]Anual_Nota:12#<>ar_Anual_Nota{$i}) | ([Alumnos_Calificaciones:208]Anual_Puntos:13#<>ar_Anual_Puntos{$i}) | ([Alumnos_Calificaciones:208]Anual_Simbolo:14#<>at_Anual_Simbolos{$i}))
					If (HL_FindInListByReference (<>hl_avgDiff_Asignaturas;Record number:C243([Asignaturas:18]))="")
						APPEND TO LIST:C376(<>hl_avgDiff_Asignaturas;[Asignaturas:18]denominacion_interna:16+", "+[Asignaturas:18]Curso:5;Record number:C243([Asignaturas:18]))
						ADD TO SET:C119([Asignaturas:18];"DiferenciasPromedio")
					End if 
				: (([Alumnos_Calificaciones:208]P01_Final_Literal:116#<>at_P01_Literal{$i}) | ([Alumnos_Calificaciones:208]P01_Final_Real:112#<>ar_P01_Real{$i}) | ([Alumnos_Calificaciones:208]P01_Final_Nota:113#<>ar_P01_Nota{$i}) | ([Alumnos_Calificaciones:208]P01_Final_Puntos:114#<>ar_P01_Puntos{$i}) | ([Alumnos_Calificaciones:208]P01_Final_Simbolo:115#<>at_P01_Simbolos{$i}))
					If (HL_FindInListByReference (<>hl_avgDiff_Asignaturas;Record number:C243([Asignaturas:18]))="")
						APPEND TO LIST:C376(<>hl_avgDiff_Asignaturas;[Asignaturas:18]denominacion_interna:16+", "+[Asignaturas:18]Curso:5;Record number:C243([Asignaturas:18]))
						ADD TO SET:C119([Asignaturas:18];"DiferenciasPromedio")
					End if 
				: (([Alumnos_Calificaciones:208]P02_Final_Literal:191#<>at_P02_Literal{$i}) | ([Alumnos_Calificaciones:208]P02_Final_Real:187#<>ar_P02_Real{$i}) | ([Alumnos_Calificaciones:208]P02_Final_Nota:188#<>ar_P02_Nota{$i}) | ([Alumnos_Calificaciones:208]P02_Final_Puntos:189#<>ar_P02_Puntos{$i}) | ([Alumnos_Calificaciones:208]P02_Final_Simbolo:190#<>at_P02_Simbolos{$i}))
					If (HL_FindInListByReference (<>hl_avgDiff_Asignaturas;Record number:C243([Asignaturas:18]))="")
						APPEND TO LIST:C376(<>hl_avgDiff_Asignaturas;[Asignaturas:18]denominacion_interna:16+", "+[Asignaturas:18]Curso:5;Record number:C243([Asignaturas:18]))
						ADD TO SET:C119([Asignaturas:18];"DiferenciasPromedio")
					End if 
				: (([Alumnos_Calificaciones:208]P03_Final_Literal:266#<>at_P03_Literal{$i}) | ([Alumnos_Calificaciones:208]P03_Final_Real:262#<>ar_P03_Real{$i}) | ([Alumnos_Calificaciones:208]P03_Final_Nota:263#<>ar_P03_Nota{$i}) | ([Alumnos_Calificaciones:208]P03_Final_Puntos:264#<>ar_P03_Puntos{$i}) | ([Alumnos_Calificaciones:208]P03_Final_Simbolo:265#<>at_P03_Simbolos{$i}))
					If (HL_FindInListByReference (<>hl_avgDiff_Asignaturas;Record number:C243([Asignaturas:18]))="")
						APPEND TO LIST:C376(<>hl_avgDiff_Asignaturas;[Asignaturas:18]denominacion_interna:16+", "+[Asignaturas:18]Curso:5;Record number:C243([Asignaturas:18]))
						ADD TO SET:C119([Asignaturas:18];"DiferenciasPromedio")
					End if 
				: (([Alumnos_Calificaciones:208]P04_Final_Literal:341#<>at_P04_Literal{$i}) | ([Alumnos_Calificaciones:208]P04_Final_Real:337#<>ar_P04_Real{$i}) | ([Alumnos_Calificaciones:208]P04_Final_Nota:338#<>ar_P04_Nota{$i}) | ([Alumnos_Calificaciones:208]P04_Final_Puntos:339#<>ar_P04_Puntos{$i}) | ([Alumnos_Calificaciones:208]P04_Final_Simbolo:340#<>at_P04_Simbolos{$i}))
					If (HL_FindInListByReference (<>hl_avgDiff_Asignaturas;Record number:C243([Asignaturas:18]))="")
						APPEND TO LIST:C376(<>hl_avgDiff_Asignaturas;[Asignaturas:18]denominacion_interna:16+", "+[Asignaturas:18]Curso:5;Record number:C243([Asignaturas:18]))
						ADD TO SET:C119([Asignaturas:18];"DiferenciasPromedio")
					End if 
				: (([Alumnos_Calificaciones:208]P05_Final_Literal:416#<>at_P05_Literal{$i}) | ([Alumnos_Calificaciones:208]P05_Final_Real:412#<>ar_P05_Real{$i}) | ([Alumnos_Calificaciones:208]P05_Final_Nota:413#<>ar_P05_Nota{$i}) | ([Alumnos_Calificaciones:208]P05_Final_Puntos:414#<>ar_P05_Puntos{$i}) | ([Alumnos_Calificaciones:208]P05_Final_Simbolo:415#<>at_P05_Simbolos{$i}))
					If (HL_FindInListByReference (<>hl_avgDiff_Asignaturas;Record number:C243([Asignaturas:18]))="")
						APPEND TO LIST:C376(<>hl_avgDiff_Asignaturas;[Asignaturas:18]denominacion_interna:16+", "+[Asignaturas:18]Curso:5;Record number:C243([Asignaturas:18]))
						ADD TO SET:C119([Asignaturas:18];"DiferenciasPromedio")
					End if 
			End case 
		End for 
		
		If ((Size of array:C274(<>at_KeyCalificaciones)>200) & ($l_thermProcessID>0))
			$l_thermProcessID:=IT_UThermometer (-2;$l_thermProcessID)
		End if 
		
		
		If (Count list items:C380(<>hl_avgDiff_Asignaturas)>0)
			$l_p:=New process:C317("EV2_CambiosPostRecalculo";128000;"AverageChangesViewer";"StartViewer")
		Else 
			CD_Dlog (0;__ ("No se detectó ningún cambio después de recalcular promedios."))
			<>vb_ComparacionActiva:=False:C215
		End if 
		
	: ($t_method="StartViewer")
		BRING TO FRONT:C326(Current process:C322)
		WDW_OpenFormWindow (->[xxSTR_Constants:1];"STR_Comp_PostCalculoPromedio";-1;8;__ ("Cambios detectados en promedios"))
		DIALOG:C40([xxSTR_Constants:1];"STR_Comp_PostCalculoPromedio")
		CLOSE WINDOW:C154
		<>vb_ComparacionActiva:=False:C215
		<>vt_IPMsg_Message:=""
		<>vl_IPMsg_Tab2Select:=0
		<>vl_IPMsg_OpenRecNum:=-1
		
	: ($t_method="SelectAsignatura")
		HL_ClearList (<>hl_avgDiff_Alumnos)
		<>hl_avgDiff_Alumnos:=New list:C375
		GET LIST ITEM:C378(<>hl_avgDiff_Asignaturas;*;$l_recNumAsignatura;vt_Asignatura)
		KRL_GotoRecord (->[Asignaturas:18];$l_recNumAsignatura;False:C215)
		EV2_RegistrosDeLaAsignatura ([Asignaturas:18]Numero:1)
		SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
		ORDER BY:C49([Alumnos_Calificaciones:208];[Alumnos:2]apellidos_y_nombres:40;>)
		SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
		LONGINT ARRAY FROM SELECTION:C647([Alumnos_Calificaciones:208];$al_RecNums;"")
		
		For ($i;1;Size of array:C274($al_RecNums))
			GOTO RECORD:C242([Alumnos_Calificaciones:208];$al_RecNums{$i})
			$l_itemEncontrado:=Find in array:C230(<>at_KeyCalificaciones;[Alumnos_Calificaciones:208]Llave_principal:1)
			If ($l_itemEncontrado>0)
				Case of 
					: (([Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30#<>at_Final_Literal{$l_itemEncontrado}) | ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26#<>ar_Final_Real{$l_itemEncontrado}) | ([Alumnos_Calificaciones:208]EvaluacionFinal_Nota:27#<>ar_Final_Nota{$l_itemEncontrado}) | ([Alumnos_Calificaciones:208]EvaluacionFinal_Puntos:28#<>ar_Final_Puntos{$l_itemEncontrado}) | ([Alumnos_Calificaciones:208]EvaluacionFinal_Simbolo:29#<>at_Final_Simbolos{$l_itemEncontrado}))
						KRL_FindAndLoadRecordByIndex (->[Alumnos:2]numero:1;->[Alumnos_Calificaciones:208]ID_Alumno:6)
						APPEND TO LIST:C376(<>hl_avgDiff_Alumnos;[Alumnos:2]apellidos_y_nombres:40;Record number:C243([Alumnos_Calificaciones:208]))
					: (([Asignaturas:18]Incluida_en_Actas:44 | [Asignaturas:18]Incide_en_promedio:27) & (([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36#<>at_FinalOficial_Literal{$l_itemEncontrado}) | ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32#<>ar_FinalOficial_Real{$l_itemEncontrado}) | ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33#<>ar_FinalOficial_Nota{$l_itemEncontrado}) | ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Puntos:34#<>ar_FinalOficial_Puntos{$l_itemEncontrado}) | ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Simbolo:35#<>at_FinalOficial_Simbolos{$l_itemEncontrado})))
						KRL_FindAndLoadRecordByIndex (->[Alumnos:2]numero:1;->[Alumnos_Calificaciones:208]ID_Alumno:6)
						APPEND TO LIST:C376(<>hl_avgDiff_Alumnos;[Alumnos:2]apellidos_y_nombres:40;Record number:C243([Alumnos_Calificaciones:208]))
					: (([Alumnos_Calificaciones:208]Anual_Literal:15#<>at_Anual_Literal{$l_itemEncontrado}) | ([Alumnos_Calificaciones:208]Anual_Real:11#<>ar_Anual_Real{$l_itemEncontrado}) | ([Alumnos_Calificaciones:208]Anual_Nota:12#<>ar_Anual_Nota{$l_itemEncontrado}) | ([Alumnos_Calificaciones:208]Anual_Puntos:13#<>ar_Anual_Puntos{$l_itemEncontrado}) | ([Alumnos_Calificaciones:208]Anual_Simbolo:14#<>at_Anual_Simbolos{$l_itemEncontrado}))
						KRL_FindAndLoadRecordByIndex (->[Alumnos:2]numero:1;->[Alumnos_Calificaciones:208]ID_Alumno:6)
						APPEND TO LIST:C376(<>hl_avgDiff_Alumnos;[Alumnos:2]apellidos_y_nombres:40;Record number:C243([Alumnos_Calificaciones:208]))
					: (([Alumnos_Calificaciones:208]P01_Final_Literal:116#<>at_P01_Literal{$l_itemEncontrado}) | ([Alumnos_Calificaciones:208]P01_Final_Real:112#<>ar_P01_Real{$l_itemEncontrado}) | ([Alumnos_Calificaciones:208]P01_Final_Nota:113#<>ar_P01_Nota{$l_itemEncontrado}) | ([Alumnos_Calificaciones:208]P01_Final_Puntos:114#<>ar_P01_Puntos{$l_itemEncontrado}) | ([Alumnos_Calificaciones:208]P01_Final_Simbolo:115#<>at_P01_Simbolos{$l_itemEncontrado}))
						KRL_FindAndLoadRecordByIndex (->[Alumnos:2]numero:1;->[Alumnos_Calificaciones:208]ID_Alumno:6)
						APPEND TO LIST:C376(<>hl_avgDiff_Alumnos;[Alumnos:2]apellidos_y_nombres:40;Record number:C243([Alumnos_Calificaciones:208]))
					: (([Alumnos_Calificaciones:208]P02_Final_Literal:191#<>at_P02_Literal{$l_itemEncontrado}) | ([Alumnos_Calificaciones:208]P02_Final_Real:187#<>ar_P02_Real{$l_itemEncontrado}) | ([Alumnos_Calificaciones:208]P02_Final_Nota:188#<>ar_P02_Nota{$l_itemEncontrado}) | ([Alumnos_Calificaciones:208]P02_Final_Puntos:189#<>ar_P02_Puntos{$l_itemEncontrado}) | ([Alumnos_Calificaciones:208]P02_Final_Simbolo:190#<>at_P02_Simbolos{$l_itemEncontrado}))
						KRL_FindAndLoadRecordByIndex (->[Alumnos:2]numero:1;->[Alumnos_Calificaciones:208]ID_Alumno:6)
						APPEND TO LIST:C376(<>hl_avgDiff_Alumnos;[Alumnos:2]apellidos_y_nombres:40;Record number:C243([Alumnos_Calificaciones:208]))
					: (([Alumnos_Calificaciones:208]P03_Final_Literal:266#<>at_P03_Literal{$l_itemEncontrado}) | ([Alumnos_Calificaciones:208]P03_Final_Real:262#<>ar_P03_Real{$l_itemEncontrado}) | ([Alumnos_Calificaciones:208]P03_Final_Nota:263#<>ar_P03_Nota{$l_itemEncontrado}) | ([Alumnos_Calificaciones:208]P03_Final_Puntos:264#<>ar_P03_Puntos{$l_itemEncontrado}) | ([Alumnos_Calificaciones:208]P03_Final_Simbolo:265#<>at_P03_Simbolos{$l_itemEncontrado}))
						KRL_FindAndLoadRecordByIndex (->[Alumnos:2]numero:1;->[Alumnos_Calificaciones:208]ID_Alumno:6)
						APPEND TO LIST:C376(<>hl_avgDiff_Alumnos;[Alumnos:2]apellidos_y_nombres:40;Record number:C243([Alumnos_Calificaciones:208]))
					: (([Alumnos_Calificaciones:208]P04_Final_Literal:341#<>at_P04_Literal{$l_itemEncontrado}) | ([Alumnos_Calificaciones:208]P04_Final_Real:337#<>ar_P04_Real{$l_itemEncontrado}) | ([Alumnos_Calificaciones:208]P04_Final_Nota:338#<>ar_P04_Nota{$l_itemEncontrado}) | ([Alumnos_Calificaciones:208]P04_Final_Puntos:339#<>ar_P04_Puntos{$l_itemEncontrado}) | ([Alumnos_Calificaciones:208]P04_Final_Simbolo:340#<>at_P04_Simbolos{$l_itemEncontrado}))
						KRL_FindAndLoadRecordByIndex (->[Alumnos:2]numero:1;->[Alumnos_Calificaciones:208]ID_Alumno:6)
						APPEND TO LIST:C376(<>hl_avgDiff_Alumnos;[Alumnos:2]apellidos_y_nombres:40;Record number:C243([Alumnos_Calificaciones:208]))
					: (([Alumnos_Calificaciones:208]P05_Final_Literal:416#<>at_P05_Literal{$l_itemEncontrado}) | ([Alumnos_Calificaciones:208]P05_Final_Real:412#<>ar_P05_Real{$l_itemEncontrado}) | ([Alumnos_Calificaciones:208]P05_Final_Nota:413#<>ar_P05_Nota{$l_itemEncontrado}) | ([Alumnos_Calificaciones:208]P05_Final_Puntos:414#<>ar_P05_Puntos{$l_itemEncontrado}) | ([Alumnos_Calificaciones:208]P05_Final_Simbolo:415#<>at_P05_Simbolos{$l_itemEncontrado}))
						KRL_FindAndLoadRecordByIndex (->[Alumnos:2]numero:1;->[Alumnos_Calificaciones:208]ID_Alumno:6)
						APPEND TO LIST:C376(<>hl_avgDiff_Alumnos;[Alumnos:2]apellidos_y_nombres:40;Record number:C243([Alumnos_Calificaciones:208]))
				End case 
			End if 
		End for 
		
		
		If (Count list items:C380(<>hl_avgDiff_Alumnos)>0)
			SELECT LIST ITEMS BY POSITION:C381(<>hl_avgDiff_Alumnos;1)
		Else 
			SELECT LIST ITEMS BY POSITION:C381(<>hl_avgDiff_Alumnos;-1)
		End if 
		EV2_CambiosPostRecalculo ("SelectAlumno")
		
	: ($t_method="SelectAlumno")
		vt_P01:=""
		vt_P02:=""
		vt_P03:=""
		vt_P04:=""
		vt_P05:=""
		vt_Simbolo_P01:=""
		vt_Simbolo_P02:=""
		vt_Simbolo_P03:=""
		vt_Simbolo_P04:=""
		vt_Simbolo_P05:=""
		vr_Nota_P01:=-10
		vr_Nota_P02:=-10
		vr_Nota_P03:=-10
		vr_Nota_P04:=-10
		vr_Nota_P05:=-10
		vr_puntos_P01:=-10
		vr_puntos_P02:=-10
		vr_puntos_P03:=-10
		vr_puntos_P04:=-10
		vr_puntos_P05:=-10
		vr_P01:=-10
		vr_P02:=-10
		vr_P03:=-10
		vr_P04:=-10
		vr_P05:=-10
		vt_PA:=""
		vt_NF:=""
		vt_NO:=""
		vt_Simbolo_PA:=""
		vt_Simbolo_NF:=""
		vt_Simbolo_NO:=""
		vr_PA:=-10
		vr_NF:=-10
		vr_NO:=-10
		vr_Nota_PA:=-10
		vr_Nota_NF:=-10
		vr_Nota_NO:=-10
		vr_puntos_PA:=-10
		vr_puntos_NF:=-10
		vr_puntos_NO:=-10
		REDUCE SELECTION:C351([Alumnos_Calificaciones:208];0)
		
		If (Selected list items:C379(<>hl_avgDiff_Alumnos)>0)
			
			GET LIST ITEM:C378(<>hl_avgDiff_Alumnos;*;$l_recNumEvaluacion;vt_Alumno)
			vt_TituloDiferencias:="Diferencias para "+vt_Alumno+" en "+vt_Asignatura
			KRL_GotoRecord (->[Alumnos_Calificaciones:208];$l_recNumEvaluacion;False:C215)
			$l_itemEncontrado:=Find in array:C230(<>at_KeyCalificaciones;[Alumnos_Calificaciones:208]Llave_principal:1)
			If ($l_itemEncontrado>0)
				OBJECT SET FONT STYLE:C166(*;"v@";0)
				OBJECT SET FONT STYLE:C166(*;"campo@";0)
				OBJECT SET COLOR:C271(*;"v@";-15)
				OBJECT SET COLOR:C271(*;"campo@";-15)
				
				vt_P01:=<>at_P01_Literal{$l_itemEncontrado}
				vt_P02:=<>at_P02_Literal{$l_itemEncontrado}
				vt_P03:=<>at_P03_Literal{$l_itemEncontrado}
				vt_P04:=<>at_P04_Literal{$l_itemEncontrado}
				vt_P05:=<>at_P05_Literal{$l_itemEncontrado}
				If (vt_P01#[Alumnos_Calificaciones:208]P01_Final_Literal:116)
					OBJECT SET FONT STYLE:C166(vt_P01;1)
					OBJECT SET FONT STYLE:C166([Alumnos_Calificaciones:208]P01_Final_Literal:116;1)
					OBJECT SET COLOR:C271([Alumnos_Calificaciones:208]P01_Final_Literal:116;-3)
				End if 
				If (vt_P02#[Alumnos_Calificaciones:208]P02_Final_Literal:191)
					OBJECT SET FONT STYLE:C166(vt_P02;1)
					OBJECT SET FONT STYLE:C166([Alumnos_Calificaciones:208]P02_Final_Literal:191;1)
					OBJECT SET COLOR:C271([Alumnos_Calificaciones:208]P02_Final_Literal:191;-3)
				End if 
				If (vt_P03#[Alumnos_Calificaciones:208]P03_Final_Literal:266)
					OBJECT SET FONT STYLE:C166(vt_P03;1)
					OBJECT SET FONT STYLE:C166([Alumnos_Calificaciones:208]P03_Final_Literal:266;1)
					OBJECT SET COLOR:C271([Alumnos_Calificaciones:208]P03_Final_Literal:266;-3)
				End if 
				If (vt_P04#[Alumnos_Calificaciones:208]P04_Final_Literal:341)
					OBJECT SET FONT STYLE:C166(vt_P04;1)
					OBJECT SET FONT STYLE:C166([Alumnos_Calificaciones:208]P04_Final_Literal:341;1)
					OBJECT SET COLOR:C271([Alumnos_Calificaciones:208]P04_Final_Literal:341;-3)
				End if 
				If (vt_P05#[Alumnos_Calificaciones:208]P05_Final_Literal:416)
					OBJECT SET FONT STYLE:C166(vt_P05;1)
					OBJECT SET FONT STYLE:C166([Alumnos_Calificaciones:208]P05_Final_Literal:416;1)
					OBJECT SET COLOR:C271([Alumnos_Calificaciones:208]P05_Final_Literal:416;-3)
				End if 
				
				vr_Nota_P01:=<>ar_P01_nota{$l_itemEncontrado}
				vr_Nota_P02:=<>ar_P02_nota{$l_itemEncontrado}
				vr_Nota_P03:=<>ar_P03_nota{$l_itemEncontrado}
				vr_Nota_P04:=<>ar_P04_nota{$l_itemEncontrado}
				vr_Nota_P05:=<>ar_P05_nota{$l_itemEncontrado}
				If (vr_Nota_P01#[Alumnos_Calificaciones:208]P01_Final_Nota:113)
					OBJECT SET FONT STYLE:C166(vr_Nota_P01;1)
					OBJECT SET FONT STYLE:C166([Alumnos_Calificaciones:208]P01_Final_Nota:113;1)
					OBJECT SET COLOR:C271([Alumnos_Calificaciones:208]P01_Final_Nota:113;-3)
				End if 
				If (vr_Nota_P02#[Alumnos_Calificaciones:208]P02_Final_Nota:188)
					OBJECT SET FONT STYLE:C166(vr_Nota_P02;1)
					OBJECT SET FONT STYLE:C166([Alumnos_Calificaciones:208]P02_Final_Nota:188;1)
					OBJECT SET COLOR:C271([Alumnos_Calificaciones:208]P02_Final_Nota:188;-3)
				End if 
				If (vr_Nota_P03#[Alumnos_Calificaciones:208]P03_Final_Nota:263)
					OBJECT SET FONT STYLE:C166(vr_Nota_P03;1)
					OBJECT SET FONT STYLE:C166([Alumnos_Calificaciones:208]P03_Final_Nota:263;1)
					OBJECT SET COLOR:C271([Alumnos_Calificaciones:208]P03_Final_Nota:263;-3)
				End if 
				If (vr_Nota_P04#[Alumnos_Calificaciones:208]P04_Final_Nota:338)
					OBJECT SET FONT STYLE:C166(vr_Nota_P04;1)
					OBJECT SET FONT STYLE:C166([Alumnos_Calificaciones:208]P04_Final_Nota:338;1)
					OBJECT SET COLOR:C271([Alumnos_Calificaciones:208]P04_Final_Nota:338;-3)
				End if 
				If (vr_Nota_P05#[Alumnos_Calificaciones:208]P05_Final_Nota:413)
					OBJECT SET FONT STYLE:C166(vr_Nota_P05;1)
					OBJECT SET FONT STYLE:C166([Alumnos_Calificaciones:208]P05_Final_Nota:413;1)
					OBJECT SET COLOR:C271([Alumnos_Calificaciones:208]P05_Final_Nota:413;-3)
				End if 
				
				vr_Puntos_P01:=<>ar_P01_Puntos{$l_itemEncontrado}
				vr_Puntos_P02:=<>ar_P02_Puntos{$l_itemEncontrado}
				vr_Puntos_P03:=<>ar_P03_Puntos{$l_itemEncontrado}
				vr_Puntos_P04:=<>ar_P04_Puntos{$l_itemEncontrado}
				vr_Puntos_P05:=<>ar_P05_Puntos{$l_itemEncontrado}
				If (vr_Puntos_P01#[Alumnos_Calificaciones:208]P01_Final_Puntos:114)
					OBJECT SET FONT STYLE:C166(vr_Puntos_P01;1)
					OBJECT SET FONT STYLE:C166([Alumnos_Calificaciones:208]P01_Final_Puntos:114;1)
					OBJECT SET COLOR:C271([Alumnos_Calificaciones:208]P01_Final_Puntos:114;-3)
				End if 
				If (vr_Puntos_P02#[Alumnos_Calificaciones:208]P02_Final_Puntos:189)
					OBJECT SET FONT STYLE:C166(vr_Puntos_P02;1)
					OBJECT SET FONT STYLE:C166([Alumnos_Calificaciones:208]P02_Final_Puntos:189;1)
					OBJECT SET COLOR:C271([Alumnos_Calificaciones:208]P02_Final_Puntos:189;-3)
				End if 
				If (vr_Puntos_P03#[Alumnos_Calificaciones:208]P03_Final_Puntos:264)
					OBJECT SET FONT STYLE:C166(vr_Puntos_P03;1)
					OBJECT SET FONT STYLE:C166([Alumnos_Calificaciones:208]P03_Final_Puntos:264;1)
					OBJECT SET COLOR:C271([Alumnos_Calificaciones:208]P03_Final_Puntos:264;-3)
				End if 
				If (vr_Puntos_P04#[Alumnos_Calificaciones:208]P04_Final_Puntos:339)
					OBJECT SET FONT STYLE:C166(vr_Puntos_P04;1)
					OBJECT SET FONT STYLE:C166([Alumnos_Calificaciones:208]P04_Final_Puntos:339;1)
					OBJECT SET COLOR:C271([Alumnos_Calificaciones:208]P04_Final_Puntos:339;-3)
				End if 
				If (vr_Puntos_P05#[Alumnos_Calificaciones:208]P05_Final_Puntos:414)
					OBJECT SET FONT STYLE:C166(vr_Puntos_P05;1)
					OBJECT SET FONT STYLE:C166([Alumnos_Calificaciones:208]P05_Final_Puntos:414;1)
					OBJECT SET COLOR:C271([Alumnos_Calificaciones:208]P05_Final_Puntos:414;-3)
				End if 
				
				vt_Simbolo_P01:=<>at_P01_Simbolos{$l_itemEncontrado}
				vt_Simbolo_P02:=<>at_P02_Simbolos{$l_itemEncontrado}
				vt_Simbolo_P03:=<>at_P03_Simbolos{$l_itemEncontrado}
				vt_Simbolo_P04:=<>at_P04_Simbolos{$l_itemEncontrado}
				vt_Simbolo_P05:=<>at_P05_Simbolos{$l_itemEncontrado}
				If (vt_simbolo_P01#[Alumnos_Calificaciones:208]P01_Final_Simbolo:115)
					OBJECT SET FONT STYLE:C166(vt_simbolo_P01;1)
					OBJECT SET FONT STYLE:C166([Alumnos_Calificaciones:208]P01_Final_Simbolo:115;1)
					OBJECT SET COLOR:C271([Alumnos_Calificaciones:208]P01_Final_Simbolo:115;-3)
				End if 
				If (vt_simbolo_P02#[Alumnos_Calificaciones:208]P02_Final_Simbolo:190)
					OBJECT SET FONT STYLE:C166(vt_simbolo_P02;1)
					OBJECT SET FONT STYLE:C166([Alumnos_Calificaciones:208]P02_Final_Simbolo:190;1)
					OBJECT SET COLOR:C271([Alumnos_Calificaciones:208]P02_Final_Simbolo:190;-3)
				End if 
				If (vt_simbolo_P03#[Alumnos_Calificaciones:208]P03_Final_Simbolo:265)
					OBJECT SET FONT STYLE:C166(vt_simbolo_P03;1)
					OBJECT SET FONT STYLE:C166([Alumnos_Calificaciones:208]P03_Final_Simbolo:265;1)
					OBJECT SET COLOR:C271([Alumnos_Calificaciones:208]P03_Final_Simbolo:265;-3)
				End if 
				If (vt_simbolo_P04#[Alumnos_Calificaciones:208]P04_Final_Simbolo:340)
					OBJECT SET FONT STYLE:C166(vt_simbolo_P04;1)
					OBJECT SET FONT STYLE:C166([Alumnos_Calificaciones:208]P04_Final_Simbolo:340;1)
					OBJECT SET COLOR:C271([Alumnos_Calificaciones:208]P04_Final_Simbolo:340;-3)
				End if 
				If (vt_simbolo_P05#[Alumnos_Calificaciones:208]P05_Final_Simbolo:415)
					OBJECT SET FONT STYLE:C166(vt_simbolo_P05;1)
					OBJECT SET FONT STYLE:C166([Alumnos_Calificaciones:208]P05_Final_Simbolo:415;1)
					OBJECT SET COLOR:C271([Alumnos_Calificaciones:208]P05_Final_Simbolo:415;-3)
				End if 
				
				vr_P01:=<>ar_P01_Real{$l_itemEncontrado}
				vr_P02:=<>ar_P02_Real{$l_itemEncontrado}
				vr_P03:=<>ar_P03_Real{$l_itemEncontrado}
				vr_P04:=<>ar_P04_Real{$l_itemEncontrado}
				vr_P05:=<>ar_P05_Real{$l_itemEncontrado}
				If (vr_P01#[Alumnos_Calificaciones:208]P01_Final_Real:112)
					OBJECT SET FONT STYLE:C166(vr_P01;1)
					OBJECT SET FONT STYLE:C166([Alumnos_Calificaciones:208]P01_Final_Real:112;1)
					OBJECT SET COLOR:C271([Alumnos_Calificaciones:208]P01_Final_Real:112;-3)
				End if 
				If (vr_P02#[Alumnos_Calificaciones:208]P02_Final_Real:187)
					OBJECT SET FONT STYLE:C166(vr_P02;1)
					OBJECT SET FONT STYLE:C166([Alumnos_Calificaciones:208]P02_Final_Real:187;1)
					OBJECT SET COLOR:C271([Alumnos_Calificaciones:208]P02_Final_Real:187;-3)
				End if 
				If (vr_P03#[Alumnos_Calificaciones:208]P03_Final_Real:262)
					OBJECT SET FONT STYLE:C166(vr_P03;1)
					OBJECT SET FONT STYLE:C166([Alumnos_Calificaciones:208]P03_Final_Real:262;1)
					OBJECT SET COLOR:C271([Alumnos_Calificaciones:208]P03_Final_Real:262;-3)
				End if 
				If (vr_P04#[Alumnos_Calificaciones:208]P04_Final_Real:337)
					OBJECT SET FONT STYLE:C166(vr_P04;1)
					OBJECT SET FONT STYLE:C166([Alumnos_Calificaciones:208]P04_Final_Real:337;1)
					OBJECT SET COLOR:C271([Alumnos_Calificaciones:208]P04_Final_Real:337;-3)
				End if 
				If (vr_P05#[Alumnos_Calificaciones:208]P05_Final_Real:412)
					OBJECT SET FONT STYLE:C166(vr_P05;1)
					OBJECT SET FONT STYLE:C166([Alumnos_Calificaciones:208]P05_Final_Real:412;1)
					OBJECT SET COLOR:C271([Alumnos_Calificaciones:208]P05_Final_Real:412;-3)
				End if 
				
				vt_PA:=<>at_Anual_Literal{$l_itemEncontrado}
				vt_NF:=<>at_Final_Literal{$l_itemEncontrado}
				vt_NO:=<>at_FinalOficial_Literal{$l_itemEncontrado}
				If (vt_NO#[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36)
					OBJECT SET FONT STYLE:C166(vt_NO;1)
					OBJECT SET FONT STYLE:C166([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36;1)
					OBJECT SET COLOR:C271([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36;-3)
				End if 
				If (vt_NF#[Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30)
					OBJECT SET FONT STYLE:C166(vt_NF;1)
					OBJECT SET FONT STYLE:C166([Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30;1)
					OBJECT SET COLOR:C271([Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30;-3)
				End if 
				If (vt_PA#[Alumnos_Calificaciones:208]Anual_Literal:15)
					OBJECT SET FONT STYLE:C166(vt_PA;1)
					OBJECT SET FONT STYLE:C166([Alumnos_Calificaciones:208]Anual_Literal:15;1)
					OBJECT SET COLOR:C271([Alumnos_Calificaciones:208]Anual_Literal:15;-3)
				End if 
				
				vr_Nota_PA:=<>ar_Anual_Nota{$l_itemEncontrado}
				vr_Nota_NF:=<>ar_Final_Nota{$l_itemEncontrado}
				vr_Nota_NO:=<>ar_FinalOficial_Nota{$l_itemEncontrado}
				If (vr_Nota_NO#[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33)
					OBJECT SET FONT STYLE:C166(vr_Nota_NO;1)
					OBJECT SET FONT STYLE:C166([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33;1)
					OBJECT SET COLOR:C271([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33;-3)
				End if 
				If (vr_Nota_NF#[Alumnos_Calificaciones:208]EvaluacionFinal_Nota:27)
					OBJECT SET FONT STYLE:C166(vr_Nota_NF;1)
					OBJECT SET FONT STYLE:C166([Alumnos_Calificaciones:208]EvaluacionFinal_Nota:27;1)
					OBJECT SET COLOR:C271([Alumnos_Calificaciones:208]EvaluacionFinal_Nota:27;-3)
				End if 
				If (vr_Nota_PA#[Alumnos_Calificaciones:208]Anual_Nota:12)
					OBJECT SET FONT STYLE:C166(vr_Nota_PA;1)
					OBJECT SET FONT STYLE:C166([Alumnos_Calificaciones:208]Anual_Nota:12;1)
					OBJECT SET COLOR:C271([Alumnos_Calificaciones:208]Anual_Nota:12;-3)
				End if 
				
				vr_Puntos_PA:=<>ar_Anual_Puntos{$l_itemEncontrado}
				vr_Puntos_NF:=<>ar_Final_Puntos{$l_itemEncontrado}
				vr_Puntos_NO:=<>ar_FinalOficial_Puntos{$l_itemEncontrado}
				If (vr_Puntos_NO#[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Puntos:34)
					OBJECT SET FONT STYLE:C166(vr_Puntos_NO;1)
					OBJECT SET FONT STYLE:C166([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Puntos:34;1)
					OBJECT SET COLOR:C271([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Puntos:34;-3)
				End if 
				If (vr_Puntos_NF#[Alumnos_Calificaciones:208]EvaluacionFinal_Puntos:28)
					OBJECT SET FONT STYLE:C166(vr_Puntos_NF;1)
					OBJECT SET FONT STYLE:C166([Alumnos_Calificaciones:208]EvaluacionFinal_Puntos:28;1)
					OBJECT SET COLOR:C271([Alumnos_Calificaciones:208]EvaluacionFinal_Puntos:28;-3)
				End if 
				If (vr_Puntos_PA#[Alumnos_Calificaciones:208]Anual_Puntos:13)
					OBJECT SET FONT STYLE:C166(vr_Puntos_PA;1)
					OBJECT SET FONT STYLE:C166([Alumnos_Calificaciones:208]Anual_Puntos:13;1)
					OBJECT SET COLOR:C271([Alumnos_Calificaciones:208]Anual_Puntos:13;-3)
				End if 
				
				vt_Simbolo_PA:=<>at_Anual_Simbolos{$l_itemEncontrado}
				vt_Simbolo_NF:=<>at_Final_Simbolos{$l_itemEncontrado}
				vt_Simbolo_NO:=<>at_FinalOficial_Simbolos{$l_itemEncontrado}
				If (vt_simbolo_NO#[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Simbolo:35)
					OBJECT SET FONT STYLE:C166(vt_simbolo_NO;1)
					OBJECT SET FONT STYLE:C166([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Simbolo:35;1)
					OBJECT SET FONT STYLE:C166([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Simbolo:35;-3)
				End if 
				If (vt_simbolo_NF#[Alumnos_Calificaciones:208]EvaluacionFinal_Simbolo:29)
					OBJECT SET FONT STYLE:C166(vt_simbolo_NF;1)
					OBJECT SET FONT STYLE:C166([Alumnos_Calificaciones:208]EvaluacionFinal_Simbolo:29;1)
					OBJECT SET COLOR:C271([Alumnos_Calificaciones:208]EvaluacionFinal_Simbolo:29;-3)
				End if 
				If (vt_simbolo_PA#[Alumnos_Calificaciones:208]Anual_Simbolo:14)
					OBJECT SET FONT STYLE:C166(vt_simbolo_PA;1)
					OBJECT SET FONT STYLE:C166([Alumnos_Calificaciones:208]Anual_Simbolo:14;1)
					OBJECT SET COLOR:C271([Alumnos_Calificaciones:208]Anual_Simbolo:14;-3)
				End if 
				
				vr_PA:=<>ar_Anual_Real{$l_itemEncontrado}
				vr_NF:=<>ar_Final_Real{$l_itemEncontrado}
				vr_NO:=<>ar_FinalOficial_Real{$l_itemEncontrado}
				If (vr_NO#[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32)
					OBJECT SET FONT STYLE:C166(vr_NO;1)
					OBJECT SET FONT STYLE:C166([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32;1)
					OBJECT SET COLOR:C271([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32;-3)
				End if 
				If (vr_NF#[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26)
					OBJECT SET FONT STYLE:C166(vr_NF;1)
					OBJECT SET FONT STYLE:C166([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26;1)
					OBJECT SET COLOR:C271([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26;-3)
				End if 
				If (vr_PA#[Alumnos_Calificaciones:208]Anual_Real:11)
					OBJECT SET FONT STYLE:C166(vr_PA;1)
					OBJECT SET FONT STYLE:C166([Alumnos_Calificaciones:208]Anual_Real:11;1)
					OBJECT SET COLOR:C271([Alumnos_Calificaciones:208]Anual_Real:11;-3)
				End if 
			End if 
		End if 
		
	: ($t_method="GenerarDocumento")
		
		$h_referenciaDocumento:=Create document:C266("";"TEXT")
		If ($h_referenciaDocumento#?00:00:00?)
			$l_thermProcessID:=IT_UThermometer (1;0;"Generando Documento...")
			For ($iAsignaturas;1;Count list items:C380(<>hl_avgDiff_Asignaturas))
				SELECT LIST ITEMS BY POSITION:C381(<>hl_avgDiff_Asignaturas;$iAsignaturas)
				GET LIST ITEM:C378(<>hl_avgDiff_Asignaturas;$iAsignaturas;$l_recNumAsignatura;$t_asignatura)
				KRL_GotoRecord (->[Asignaturas:18];$l_recNumAsignatura;False:C215)
				$t_detalleDiferencia:="#"+String:C10([Asignaturas:18]Numero:1)+": "+$t_asignatura+" [Estilo Evaluación: "+String:C10([Asignaturas:18]Numero_de_EstiloEvaluacion:39)+":"+KRL_GetTextFieldData (->[xxSTR_EstilosEvaluacion:44]ID:1;->[Asignaturas:18]Numero_de_EstiloEvaluacion:39;->[xxSTR_EstilosEvaluacion:44]Name:2)+"]"
				APPEND TO ARRAY:C911($at_Rows;$t_detalleDiferencia)
				EV2_CambiosPostRecalculo ("SelectAsignatura")
				For ($iAlumnos;1;Count list items:C380(<>hl_avgDiff_Alumnos))
					SELECT LIST ITEMS BY POSITION:C381(<>hl_avgDiff_Alumnos;$iAlumnos)
					GET LIST ITEM:C378(<>hl_avgDiff_Alumnos;$iAlumnos;$l_recNumEvaluacion;$t_Alumno)
					EV2_CambiosPostRecalculo ("SelectAlumno")
					KRL_GotoRecord (->[Alumnos_Calificaciones:208];$l_recNumEvaluacion;False:C215)
					$l_itemEncontrado:=Find in array:C230(<>at_KeyCalificaciones;[Alumnos_Calificaciones:208]Llave_principal:1)
					If ($l_itemEncontrado>0)
						APPEND TO ARRAY:C911($at_Rows;Char:C90(Tab:K15:37)+$t_Alumno)
						$t_Prefijo:="\t\tLiteral\t"
						vt_P01:=<>at_P01_Literal{$l_itemEncontrado}
						vt_P02:=<>at_P02_Literal{$l_itemEncontrado}
						vt_P03:=<>at_P03_Literal{$l_itemEncontrado}
						vt_P04:=<>at_P04_Literal{$l_itemEncontrado}
						vt_P05:=<>at_P05_Literal{$l_itemEncontrado}
						vt_PA:=<>at_Anual_Literal{$l_itemEncontrado}
						vt_NF:=<>at_Final_Literal{$l_itemEncontrado}
						vt_NO:=<>at_FinalOficial_Literal{$l_itemEncontrado}
						If (vt_P01#[Alumnos_Calificaciones:208]P01_Final_Literal:116)
							$t_detalleDiferencia:=$t_Prefijo+"P1\t"+vt_P01+"\t["+[Alumnos_Calificaciones:208]P01_Final_Literal:116+"]"
							APPEND TO ARRAY:C911($at_Rows;$t_detalleDiferencia)
						End if 
						If (vt_P02#[Alumnos_Calificaciones:208]P02_Final_Literal:191)
							$t_detalleDiferencia:=$t_Prefijo+"P2\t"+vt_P02+"\t["+[Alumnos_Calificaciones:208]P02_Final_Literal:191+"]"
							APPEND TO ARRAY:C911($at_Rows;$t_detalleDiferencia)
						End if 
						If (vt_P03#[Alumnos_Calificaciones:208]P03_Final_Literal:266)
							$t_detalleDiferencia:=$t_Prefijo+"P3\t"+vt_P03+"\t["+[Alumnos_Calificaciones:208]P03_Final_Literal:266+"]"
							APPEND TO ARRAY:C911($at_Rows;$t_detalleDiferencia)
						End if 
						If (vt_P04#[Alumnos_Calificaciones:208]P04_Final_Literal:341)
							$t_detalleDiferencia:=$t_Prefijo+"P4\t"+vt_P04+"\t["+[Alumnos_Calificaciones:208]P04_Final_Literal:341+"]"
							APPEND TO ARRAY:C911($at_Rows;$t_detalleDiferencia)
						End if 
						If (vt_P05#[Alumnos_Calificaciones:208]P05_Final_Literal:416)
							$t_detalleDiferencia:=$t_Prefijo+"P5\t"+vt_P05+"\t["+[Alumnos_Calificaciones:208]P05_Final_Literal:416+"]"
							APPEND TO ARRAY:C911($at_Rows;$t_detalleDiferencia)
						End if 
						If (vt_PA#[Alumnos_Calificaciones:208]Anual_Literal:15)
							$t_detalleDiferencia:=$t_Prefijo+"Promedio Anual\t"+vt_PA+"\t["+[Alumnos_Calificaciones:208]Anual_Literal:15+"]"
							APPEND TO ARRAY:C911($at_Rows;$t_detalleDiferencia)
						End if 
						If (vt_NF#[Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30)
							$t_detalleDiferencia:=$t_Prefijo+"Nota Final\t"+vt_NF+"\t["+[Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30+"]"
							APPEND TO ARRAY:C911($at_Rows;$t_detalleDiferencia)
						End if 
						If (([Asignaturas:18]Incluida_en_Actas:44 | [Asignaturas:18]Incide_en_promedio:27) & (vt_NO#[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36))
							$t_detalleDiferencia:=$t_Prefijo+"Nota Oficial\t"+vt_NO+"\t["+[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36+"]"
							APPEND TO ARRAY:C911($at_Rows;$t_detalleDiferencia)
						End if 
						
						$t_Prefijo:="\t\tNotas\t"
						vr_Nota_P01:=<>ar_P01_nota{$l_itemEncontrado}
						vr_Nota_P02:=<>ar_P02_nota{$l_itemEncontrado}
						vr_Nota_P03:=<>ar_P03_nota{$l_itemEncontrado}
						vr_Nota_P04:=<>ar_P04_nota{$l_itemEncontrado}
						vr_Nota_P05:=<>ar_P05_nota{$l_itemEncontrado}
						vr_Nota_PA:=<>ar_Anual_Nota{$l_itemEncontrado}
						vr_Nota_NF:=<>ar_Final_Nota{$l_itemEncontrado}
						vr_Nota_NO:=<>ar_FinalOficial_Nota{$l_itemEncontrado}
						If (vr_Nota_P01#[Alumnos_Calificaciones:208]P01_Final_Nota:113)
							$t_detalleDiferencia:=$t_Prefijo+"P1\t"+String:C10(vr_Nota_P01)+"\t["+String:C10([Alumnos_Calificaciones:208]P01_Final_Nota:113)+"]"
							APPEND TO ARRAY:C911($at_Rows;$t_detalleDiferencia)
						End if 
						If (vr_Nota_P02#[Alumnos_Calificaciones:208]P02_Final_Nota:188)
							$t_detalleDiferencia:=$t_Prefijo+"P2\t"+String:C10(vr_Nota_P02)+"\t["+String:C10([Alumnos_Calificaciones:208]P02_Final_Nota:188)+"]"
							APPEND TO ARRAY:C911($at_Rows;$t_detalleDiferencia)
						End if 
						If (vr_Nota_P03#[Alumnos_Calificaciones:208]P03_Final_Nota:263)
							$t_detalleDiferencia:=$t_Prefijo+"P3\t"+String:C10(vr_Nota_P03)+"\t["+String:C10([Alumnos_Calificaciones:208]P03_Final_Nota:263)+"]"
							APPEND TO ARRAY:C911($at_Rows;$t_detalleDiferencia)
						End if 
						If (vr_Nota_P04#[Alumnos_Calificaciones:208]P04_Final_Nota:338)
							$t_detalleDiferencia:=$t_Prefijo+"P4\t"+String:C10(vr_Nota_P04)+"\t["+String:C10([Alumnos_Calificaciones:208]P04_Final_Nota:338)+"]"
							APPEND TO ARRAY:C911($at_Rows;$t_detalleDiferencia)
						End if 
						If (vr_Nota_P05#[Alumnos_Calificaciones:208]P05_Final_Nota:413)
							$t_detalleDiferencia:=$t_Prefijo+"P5\t"+String:C10(vr_Nota_P05)+"\t["+String:C10([Alumnos_Calificaciones:208]P05_Final_Nota:413)+"]"
							APPEND TO ARRAY:C911($at_Rows;$t_detalleDiferencia)
						End if 
						If (vr_Nota_PA#[Alumnos_Calificaciones:208]Anual_Nota:12)
							$t_detalleDiferencia:=$t_Prefijo+"Promedio Anual\t"+String:C10(vr_Nota_PA)+"\t["+String:C10([Alumnos_Calificaciones:208]Anual_Nota:12)+"]"
							APPEND TO ARRAY:C911($at_Rows;$t_detalleDiferencia)
						End if 
						If (vr_Nota_NF#[Alumnos_Calificaciones:208]EvaluacionFinal_Nota:27)
							$t_detalleDiferencia:=$t_Prefijo+"Nota Final\t"+String:C10(vr_Nota_NF)+"\t["+String:C10([Alumnos_Calificaciones:208]EvaluacionFinal_Nota:27)+"]"
							APPEND TO ARRAY:C911($at_Rows;$t_detalleDiferencia)
						End if 
						If (vr_Nota_NO#[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33)
							$t_detalleDiferencia:=$t_Prefijo+"Nota Oficial\t"+String:C10(vr_Nota_NO)+"\t["+String:C10([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33)+"]"
							APPEND TO ARRAY:C911($at_Rows;$t_detalleDiferencia)
						End if 
						
						$t_Prefijo:="\t\tPuntos\t"
						vr_Puntos_P01:=<>ar_P01_Puntos{$l_itemEncontrado}
						vr_Puntos_P02:=<>ar_P02_Puntos{$l_itemEncontrado}
						vr_Puntos_P03:=<>ar_P03_Puntos{$l_itemEncontrado}
						vr_Puntos_P04:=<>ar_P04_Puntos{$l_itemEncontrado}
						vr_Puntos_P05:=<>ar_P05_Puntos{$l_itemEncontrado}
						vr_Puntos_PA:=<>ar_Anual_Puntos{$l_itemEncontrado}
						vr_Puntos_NF:=<>ar_Final_Puntos{$l_itemEncontrado}
						vr_Puntos_NO:=<>ar_FinalOficial_Puntos{$l_itemEncontrado}
						If (vr_Puntos_P01#[Alumnos_Calificaciones:208]P01_Final_Puntos:114)
							$t_detalleDiferencia:=$t_Prefijo+"P1\t"+String:C10(vr_Puntos_P01)+"\t["+String:C10([Alumnos_Calificaciones:208]P01_Final_Puntos:114)+"]"
							APPEND TO ARRAY:C911($at_Rows;$t_detalleDiferencia)
						End if 
						If (vr_Puntos_P02#[Alumnos_Calificaciones:208]P02_Final_Puntos:189)
							$t_detalleDiferencia:=$t_Prefijo+"P2\t"+String:C10(vr_Puntos_P02)+"\t["+String:C10([Alumnos_Calificaciones:208]P02_Final_Puntos:189)+"]"
							APPEND TO ARRAY:C911($at_Rows;$t_detalleDiferencia)
						End if 
						If (vr_Puntos_P03#[Alumnos_Calificaciones:208]P03_Final_Puntos:264)
							$t_detalleDiferencia:=$t_Prefijo+"P3\t"+String:C10(vr_Puntos_P03)+"\t["+String:C10([Alumnos_Calificaciones:208]P03_Final_Puntos:264)+"]"
							APPEND TO ARRAY:C911($at_Rows;$t_detalleDiferencia)
						End if 
						If (vr_Puntos_P04#[Alumnos_Calificaciones:208]P04_Final_Puntos:339)
							$t_detalleDiferencia:=$t_Prefijo+"P4\t"+String:C10(vr_Puntos_P04)+"\t["+String:C10([Alumnos_Calificaciones:208]P04_Final_Puntos:339)+"]"
							APPEND TO ARRAY:C911($at_Rows;$t_detalleDiferencia)
						End if 
						If (vr_Puntos_P05#[Alumnos_Calificaciones:208]P05_Final_Puntos:414)
							$t_detalleDiferencia:=$t_Prefijo+"P5\t"+String:C10(vr_Puntos_P05)+"\t["+String:C10([Alumnos_Calificaciones:208]P05_Final_Puntos:414)+"]"
							APPEND TO ARRAY:C911($at_Rows;$t_detalleDiferencia)
						End if 
						If (vr_Puntos_PA#[Alumnos_Calificaciones:208]Anual_Puntos:13)
							$t_detalleDiferencia:=$t_Prefijo+"Promedio Anual\t"+String:C10(vr_Puntos_PA)+"\t["+String:C10([Alumnos_Calificaciones:208]Anual_Puntos:13)+"]"
							APPEND TO ARRAY:C911($at_Rows;$t_detalleDiferencia)
						End if 
						If (vr_Puntos_NF#[Alumnos_Calificaciones:208]EvaluacionFinal_Puntos:28)
							$t_detalleDiferencia:=$t_Prefijo+"Puntos Final\t"+String:C10(vr_Puntos_NF)+"\t["+String:C10([Alumnos_Calificaciones:208]EvaluacionFinal_Puntos:28)+"]"
							APPEND TO ARRAY:C911($at_Rows;$t_detalleDiferencia)
						End if 
						If (vr_Puntos_NO#[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Puntos:34)
							$t_detalleDiferencia:=$t_Prefijo+"Puntos Oficial\t"+String:C10(vr_Puntos_NO)+"\t["+String:C10([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Puntos:34)+"]"
							APPEND TO ARRAY:C911($at_Rows;$t_detalleDiferencia)
						End if 
						
						$t_Prefijo:="\t\\Símbolo\t"
						vt_Simbolo_P01:=<>at_P01_Simbolos{$l_itemEncontrado}
						vt_Simbolo_P02:=<>at_P02_Simbolos{$l_itemEncontrado}
						vt_Simbolo_P03:=<>at_P03_Simbolos{$l_itemEncontrado}
						vt_Simbolo_P04:=<>at_P04_Simbolos{$l_itemEncontrado}
						vt_Simbolo_P05:=<>at_P05_Simbolos{$l_itemEncontrado}
						vt_Simbolo_PA:=<>at_Anual_Simbolos{$l_itemEncontrado}
						vt_Simbolo_NF:=<>at_Final_Simbolos{$l_itemEncontrado}
						vt_Simbolo_NO:=<>at_FinalOficial_Simbolos{$l_itemEncontrado}
						If (vt_simbolo_P01#[Alumnos_Calificaciones:208]P01_Final_Simbolo:115)
							$t_detalleDiferencia:=$t_Prefijo+"P1\t"+vt_Simbolo_P01+"\t["+[Alumnos_Calificaciones:208]P01_Final_Simbolo:115+"]"
							APPEND TO ARRAY:C911($at_Rows;$t_detalleDiferencia)
						End if 
						If (vt_simbolo_P02#[Alumnos_Calificaciones:208]P02_Final_Simbolo:190)
							$t_detalleDiferencia:=$t_Prefijo+"P2\t"+vt_Simbolo_P02+"\t["+[Alumnos_Calificaciones:208]P02_Final_Simbolo:190+"]"
							APPEND TO ARRAY:C911($at_Rows;$t_detalleDiferencia)
						End if 
						If (vt_simbolo_P03#[Alumnos_Calificaciones:208]P03_Final_Simbolo:265)
							$t_detalleDiferencia:=$t_Prefijo+"P3\t"+vt_Simbolo_P03+"\t["+[Alumnos_Calificaciones:208]P03_Final_Simbolo:265+"]"
							APPEND TO ARRAY:C911($at_Rows;$t_detalleDiferencia)
						End if 
						If (vt_simbolo_P04#[Alumnos_Calificaciones:208]P04_Final_Simbolo:340)
							$t_detalleDiferencia:=$t_Prefijo+"P4\t"+vt_Simbolo_P04+"\t["+[Alumnos_Calificaciones:208]P04_Final_Simbolo:340+"]"
							APPEND TO ARRAY:C911($at_Rows;$t_detalleDiferencia)
						End if 
						If (vt_simbolo_P05#[Alumnos_Calificaciones:208]P05_Final_Simbolo:415)
							$t_detalleDiferencia:=$t_Prefijo+"P5\t"+vt_Simbolo_P05+"\t["+[Alumnos_Calificaciones:208]P05_Final_Simbolo:415+"]"
							APPEND TO ARRAY:C911($at_Rows;$t_detalleDiferencia)
						End if 
						If (vt_Simbolo_PA#[Alumnos_Calificaciones:208]Anual_Simbolo:14)
							$t_detalleDiferencia:=$t_Prefijo+"Promedio Anual\t"+vt_Simbolo_PA+"\t["+[Alumnos_Calificaciones:208]Anual_Simbolo:14+"]"
							APPEND TO ARRAY:C911($at_Rows;$t_detalleDiferencia)
						End if 
						If (vt_Simbolo_NF#[Alumnos_Calificaciones:208]EvaluacionFinal_Simbolo:29)
							$t_detalleDiferencia:=$t_Prefijo+"Nota Final\t"+vt_Simbolo_NF+"\t["+[Alumnos_Calificaciones:208]EvaluacionFinal_Simbolo:29+"]"
							APPEND TO ARRAY:C911($at_Rows;$t_detalleDiferencia)
						End if 
						If (vt_Simbolo_NO#[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Simbolo:35)
							$t_detalleDiferencia:=$t_Prefijo+"Nota Oficial\t"+vt_Simbolo_NO+"\t["+[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Simbolo:35+"]"
							APPEND TO ARRAY:C911($at_Rows;$t_detalleDiferencia)
						End if 
						
						$t_Prefijo:="\t\tPorcentaje\t"
						vr_P01:=<>ar_P01_Real{$l_itemEncontrado}
						vr_P02:=<>ar_P02_Real{$l_itemEncontrado}
						vr_P03:=<>ar_P03_Real{$l_itemEncontrado}
						vr_P04:=<>ar_P04_Real{$l_itemEncontrado}
						vr_P05:=<>ar_P05_Real{$l_itemEncontrado}
						vr_PA:=<>ar_Anual_Real{$l_itemEncontrado}
						vr_NF:=<>ar_Final_Real{$l_itemEncontrado}
						vr_NO:=<>ar_FinalOficial_Real{$l_itemEncontrado}
						If (vr_P01#[Alumnos_Calificaciones:208]P01_Final_Real:112)
							$t_detalleDiferencia:=$t_Prefijo+"P1\t"+String:C10(vr_P01)+"\t["+String:C10([Alumnos_Calificaciones:208]P01_Final_Real:112)+"]"
							APPEND TO ARRAY:C911($at_Rows;$t_detalleDiferencia)
						End if 
						If (vr_P02#[Alumnos_Calificaciones:208]P02_Final_Real:187)
							$t_detalleDiferencia:=$t_Prefijo+"P2\t"+String:C10(vr_P02)+"\t["+String:C10([Alumnos_Calificaciones:208]P02_Final_Real:187)+"]"
							APPEND TO ARRAY:C911($at_Rows;$t_detalleDiferencia)
						End if 
						If (vr_P03#[Alumnos_Calificaciones:208]P03_Final_Real:262)
							$t_detalleDiferencia:=$t_Prefijo+"P3\t"+String:C10(vr_P03)+"\t["+String:C10([Alumnos_Calificaciones:208]P03_Final_Real:262)+"]"
							APPEND TO ARRAY:C911($at_Rows;$t_detalleDiferencia)
						End if 
						If (vr_P04#[Alumnos_Calificaciones:208]P04_Final_Real:337)
							$t_detalleDiferencia:=$t_Prefijo+"P4\t"+String:C10(vr_P04)+"\t["+String:C10([Alumnos_Calificaciones:208]P04_Final_Real:337)+"]"
							APPEND TO ARRAY:C911($at_Rows;$t_detalleDiferencia)
						End if 
						If (vr_P05#[Alumnos_Calificaciones:208]P05_Final_Real:412)
							$t_detalleDiferencia:=$t_Prefijo+"P5\t"+String:C10(vr_P05)+"\t["+String:C10([Alumnos_Calificaciones:208]P05_Final_Real:412)+"]"
							APPEND TO ARRAY:C911($at_Rows;$t_detalleDiferencia)
						End if 
						If (vr_PA#[Alumnos_Calificaciones:208]Anual_Real:11)
							$t_detalleDiferencia:=$t_Prefijo+"Promedio Anual\t"+String:C10(vr_PA)+"\t["+String:C10([Alumnos_Calificaciones:208]Anual_Real:11)+"]"
							APPEND TO ARRAY:C911($at_Rows;$t_detalleDiferencia)
						End if 
						If (vr_NF#[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26)
							$t_detalleDiferencia:=$t_Prefijo+"Nota Final\t"+String:C10(vr_NF)+"\t["+String:C10([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26)+"]"
							APPEND TO ARRAY:C911($at_Rows;$t_detalleDiferencia)
						End if 
						If (vr_NO#[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32)
							$t_detalleDiferencia:=$t_Prefijo+"Nota Oficial\t"+String:C10(vr_NO)+"\t["+String:C10([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32)+"]"
							APPEND TO ARRAY:C911($at_Rows;$t_detalleDiferencia)
						End if 
						
					End if 
					
				End for 
			End for 
			
			For ($i;1;Size of array:C274($at_Rows))
				SEND PACKET:C103($h_referenciaDocumento;$at_Rows{$i}+Char:C90(Carriage return:K15:38))
			End for 
			CLOSE DOCUMENT:C267($h_referenciaDocumento)
			
			$l_thermProcessID:=IT_UThermometer (-2;$l_thermProcessID)
			SELECT LIST ITEMS BY POSITION:C381(<>hl_avgDiff_Asignaturas;1)
			EV2_CambiosPostRecalculo ("SelectAsignatura")
		End if 
End case 

