  // [Asignaturas].Input.P01_btn_PropiedadesAvanzadas()
  // Por: Alberto Bachler K.: 05-02-14, 09:50:19
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_periodoActual;$l_recNumAsignatura)


viBWR_RecordWasSaved:=AS_fSave 

If (viBWR_RecordWasSaved>=0)
	AL_UpdateArrays (xALP_ASNotas;0)
	AL_UpdateArrays (xALP_StdList;0)
	ARRAY TEXT:C222(<>aSAsgName;0)  //source name
	ARRAY TEXT:C222(<>aSAsgClass;0)  //source class
	ARRAY LONGINT:C221(<>aSAsgID;0)  //id source
	
	$l_recNumAsignatura:=Record number:C243([Asignaturas:18])
	$l_periodoActual:=atSTR_Periodos_Nombre
	
	PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)  //20130816 ASM se necesitan leer los periodos.
	AS_PropEval_Configura 
	KRL_GotoRecord (->[Asignaturas:18];$l_recNumAsignatura;True:C214)
	
	PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
	If (Size of array:C274(atSTR_Periodos_Nombre)<=0)
		atSTR_Periodos_Nombre:=viSTR_PeriodoActual_Numero
	End if 
	vl_LastPeriod:=$l_periodoActual
	vlSTR_PeriodoSeleccionado:=$l_periodoActual
	atSTR_Periodos_Nombre:=$l_periodoActual
	If (atSTR_Periodos_Nombre>Size of array:C274(atSTR_Periodos_Nombre))
		sPeriodo:=Replace string:C233(atSTR_Periodos_Nombre{Size of array:C274(atSTR_Periodos_Nombre)};" ";"")
	Else 
		sPeriodo:=Replace string:C233(atSTR_Periodos_Nombre{atSTR_Periodos_Nombre};" ";"")
	End if 
	AL_UpdateArrays (xALP_StdList;-2)
	AS_PaginaPropiedades 
End if 