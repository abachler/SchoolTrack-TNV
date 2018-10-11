//%attributes = {}
  // ----------------------------------------------------
  // Usuario (SO): Daniel Ledezma
  // Fecha y hora: 20-07-18, 16:22:38
  // ----------------------------------------------------
  // Método: EV2_GetPromedioBonificacion
  // Descripción: 
  // 1) Obtener los promedios de alumno para sus calificaciones de bonificación
  // 2) Obtener los promedios de las bonificaciones de una asignatura (promedio grupal).
  // EL resultado será devuelto en un objeto
  // Parámetros 1) Tipo (ALU - ASIG) - 2) ID
  // ----------------------------------------------------
READ ONLY:C145([Alumnos_Calificaciones:208])
C_TEXT:C284($1;$t_tipo;$t_simbolo;$t_literal)
C_LONGINT:C283($2;$l_id;$i_periodo;$i_estilos;$l_modoCalculo;$l_decimales)
C_OBJECT:C1216($0;$o_resp;$o_promedio)
C_POINTER:C301($y_fieldBonificacion)
C_REAL:C285($r_real;$r_nota;$r_punto)

ARRAY REAL:C219($ar_calificacion;0)

$t_tipo:=$1
$l_id:=$2

OB SET:C1220($o_resp;$t_tipo;$l_id)

Case of 
	: ($t_tipo="ALU")
		QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Alumno:6=$l_id)
	: ($t_tipo="ASIG")
		QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Asignatura:5=$l_id)
End case 
$l_ris:=Records in selection:C76([Alumnos_Calificaciones:208])

If ($l_ris>0)
	CREATE SET:C116([Alumnos_Calificaciones:208];"$setCalificaciones")
	PERIODOS_LoadData ([Alumnos_Calificaciones:208]NIvel_Numero:4)
	
	ARRAY LONGINT:C221($al_estilos;0)
	Case of 
		: ($t_tipo="ALU")
			$l_estiloEvaOficial:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos_Calificaciones:208]NIvel_Numero:4;->[xxSTR_Niveles:6]EvStyle_oficial:23)
			$l_estiloEvaInterno:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos_Calificaciones:208]NIvel_Numero:4;->[xxSTR_Niveles:6]EvStyle_interno:33)
			APPEND TO ARRAY:C911($al_estilos;$l_estiloEvaOficial)
			APPEND TO ARRAY:C911($al_estilos;$l_estiloEvaInterno)
			AT_DistinctsArrayValues (->$al_estilos)
			
		: ($t_tipo="ASIG")
			$l_estiloEvaluacion:=KRL_GetNumericFieldData (->[Asignaturas:18]Numero:1;->[Alumnos_Calificaciones:208]ID_Asignatura:5;->[Asignaturas:18]Numero_de_EstiloEvaluacion:39)
			APPEND TO ARRAY:C911($al_estilos;$l_estiloEvaluacion)
			
	End case 
	
	For ($i_estilos;1;Size of array:C274($al_estilos))
		EVS_ReadStyleData ($al_estilos{$i_estilos})
		$l_decimales:=0
		Case of 
			: (iViewMode=Notas)
				$l_decimales:=iGradesDecPP
			: (iViewMode=Puntos)
				$l_decimales:=iPointsDecPP
		End case 
		
		If (vrNTA_MinimoEscalaReferencia=0)
			$l_modoCalculo:=3
		Else 
			$l_modoCalculo:=1
		End if 
		
		CLEAR VARIABLE:C89($o_promedio)
		
		For ($i_periodo;1;Size of array:C274(aiSTR_Periodos_Numero))
			
			$t_nodo:="P0"+String:C10($i_periodo)+"_"
			USE SET:C118("$setCalificaciones")
			$y_fieldBonificacion:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P"+String:C10(aiSTR_Periodos_Numero{$i_periodo};"00")+"_Bonificacion_Real")
			QUERY SELECTION:C341([Alumnos_Calificaciones:208];$y_fieldBonificacion->>-10)
			SELECTION TO ARRAY:C260($y_fieldBonificacion->;$ar_calificacion)
			
			$r_real:=-10
			
			$l_fia:=Find in array:C230($ar_calificacion;-2)  // hay una P? Pendiente
			If ($l_fia>0)
				$r_nota:=-2
				$r_punto:=-2
				$t_simbolo:="P"
				$t_literal:="P"
				$r_real:=-2
				ARRAY REAL:C219($ar_calificacion;0)
			End if 
			
			$l_fia:=Find in array:C230($ar_calificacion;-3)  // hay una X? Eximido
			If ($l_fia>0)
				$r_nota:=-3
				$r_punto:=-3
				$t_simbolo:="X"
				$t_literal:="X"
				$r_real:=-3
				ARRAY REAL:C219($ar_calificacion;0)
			End if 
			
			If (Size of array:C274($ar_calificacion)>0)
				$r_real:=Round:C94(AT_Mean (->$ar_calificacion;$l_modoCalculo);11)
				$r_nota:=EV2_Real_a_Nota ($r_real;vi_gTrPAvg;iGradesDecPP)
				$r_punto:=EV2_Real_a_Puntos ($r_real;vi_gTrPAvg;iPointsDecPP)
				$t_simbolo:=EV2_Real_a_Simbolo ($r_real)
				$t_literal:=EV2_Real_a_Literal ($r_real;iViewMode;$l_decimales;vi_gTrPAvg)
			End if 
			
			OB SET:C1220($o_promedio;$t_nodo+"Real";$r_real)
			OB SET:C1220($o_promedio;$t_nodo+"Nota";$r_nota)
			OB SET:C1220($o_promedio;$t_nodo+"Punto";$r_punto)
			OB SET:C1220($o_promedio;$t_nodo+"Simbolo";$t_simbolo)
			OB SET:C1220($o_promedio;$t_nodo+"Literal";$t_literal)
			
		End for 
		
		OB SET:C1220($o_resp;String:C10($al_estilos{$i_estilos});$o_promedio)
		
	End for 
	
	CLEAR SET:C117("$setCalificaciones")
End if 

$0:=$o_resp