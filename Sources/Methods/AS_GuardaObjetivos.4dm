//%attributes = {}
  // MÉTODO: AS_GuardaObjetivos
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 27/12/11, 12:37:10
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // AS_GuardaObjetivos()
  // ----------------------------------------------------
C_BOOLEAN:C305($b_asignarTodas;$b_crear;$b_modificar)
C_LONGINT:C283($l_IdAsignatura;$l_IdObjetivos_a_Asignar;$l_NivelAsignatura)
C_TEXT:C284($t_nombreAsignatura)


  // CODIGO PRINCIPAL
If (modObjetivos)
	SAVE RECORD:C53([Asignaturas:18])
	READ WRITE:C146([Asignaturas_Objetivos:104])
	QUERY:C277([Asignaturas_Objetivos:104];[Asignaturas_Objetivos:104]ID:1=[Asignaturas:18]ID_Objetivos:43)
	If ([Asignaturas:18]ConObjetivosEspecificos:62=False:C215)
		If (Records in selection:C76([Asignaturas_Objetivos:104])>0)
			$b_modificar:=True:C214
			$b_crear:=False:C215
			$b_asignarTodas:=True:C214
		Else 
			$b_modificar:=True:C214
			$b_crear:=True:C214
			$b_asignarTodas:=True:C214
		End if 
	Else 
		If (Records in selection:C76([Asignaturas_Objetivos:104])>0)
			$b_modificar:=True:C214
			$b_crear:=False:C215
			$b_asignarTodas:=False:C215
		Else 
			$b_modificar:=True:C214
			$b_crear:=True:C214
			$b_asignarTodas:=False:C215
		End if 
	End if 
	If ($b_crear)
		CREATE RECORD:C68([Asignaturas_Objetivos:104])
		[Asignaturas_Objetivos:104]ID:1:=SQ_SeqNumber (->[Asignaturas_Objetivos:104]ID:1;False:C215)
		[Asignaturas_Objetivos:104]Nivel_numero:4:=[Asignaturas:18]Numero_del_Nivel:6
		[Asignaturas_Objetivos:104]Subsector:2:=[Asignaturas:18]Asignatura:3
		[Asignaturas_Objetivos:104]ID_Autor:3:=[Asignaturas:18]profesor_numero:4
		SAVE RECORD:C53([Asignaturas_Objetivos:104])
		[Asignaturas:18]ID_Objetivos:43:=[Asignaturas_Objetivos:104]ID:1
		SAVE RECORD:C53([Asignaturas:18])
	End if 
	If ($b_modificar)
		[Asignaturas_Objetivos:104]Objetivos_P1:6:=vObj_P1
		[Asignaturas_Objetivos:104]Objetivos_P2:7:=vObj_P2
		[Asignaturas_Objetivos:104]Objetivos_P3:8:=vObj_P3
		[Asignaturas_Objetivos:104]Objetivos_P4:9:=vObj_P4
		[Asignaturas_Objetivos:104]Objetivos_P5:10:=vObj_P5
		SAVE RECORD:C53([Asignaturas_Objetivos:104])
	End if 
	If ($b_asignarTodas)
		$l_IdObjetivos_a_Asignar:=[Asignaturas:18]ID_Objetivos:43
		$l_IdAsignatura:=[Asignaturas:18]Numero:1
		$l_NivelAsignatura:=[Asignaturas:18]Numero_del_Nivel:6
		$t_nombreAsignatura:=[Asignaturas:18]Asignatura:3
		PUSH RECORD:C176([Asignaturas:18])
		READ WRITE:C146([Asignaturas:18])
		QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero_del_Nivel:6=$l_NivelAsignatura;*)
		QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]Asignatura:3=$t_nombreAsignatura;*)
		QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]Numero:1#$l_IdAsignatura;*)
		QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]ConObjetivosEspecificos:62=False:C215)
		ARRAY LONGINT:C221($al_IdObjetivos_a_asignar;Records in selection:C76([Asignaturas:18]))
		AT_Populate (->$al_IdObjetivos_a_asignar;->$l_IdObjetivos_a_Asignar)
		ARRAY TO SELECTION:C261($al_IdObjetivos_a_asignar;[Asignaturas:18]ID_Objetivos:43)
		POP RECORD:C177([Asignaturas:18])
	End if 
	UNLOAD RECORD:C212([Asignaturas_Objetivos:104])
	READ ONLY:C145([Asignaturas_Objetivos:104])
	modObjetivos:=False:C215
	LOG_RegisterEvt ("Asignaturas - Modificación en Objetivos: "+[Asignaturas:18]denominacion_interna:16+", "+[Asignaturas:18]Curso:5;Table:C252(->[Asignaturas:18]);[Asignaturas:18]Numero:1)
End if 