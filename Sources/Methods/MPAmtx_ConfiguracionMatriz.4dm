//%attributes = {}
  // MPAmtx_ConfiguracionMatriz()
  // Por: Alberto Bachler K.: 19-05-14, 16:17:32
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_TEXT:C284($1)

C_LONGINT:C283($i;$l_IdAreaMPA;$l_nivel_Numero;$l_numeroPeriodo;$l_recNumArea)
C_TEXT:C284($t_areaMPA;$t_nivel_Nombre;$t_nombrePeriodo)

If (False:C215)
	C_TEXT:C284(MPAmtx_ConfiguracionMatriz ;$1)
End if 


  //arreglos para competencias o logros asignados a una asignatura (utilizado en área  ` xALP_LogrosAsignaturas, en configuracion avanzada)
If (Count parameters:C259=0)
	$t_areaMPA:=[xxSTR_Materias:20]AreaMPA:4
Else 
	$t_areaMPA:=$1
End if 

$l_recNumArea:=Find in field:C653([MPA_DefinicionAreas:186]AreaAsignatura:4;$t_areaMPA)
KRL_GotoRecord (->[MPA_DefinicionAreas:186];$l_recNumArea)
If (OK=1)
	$l_IdAreaMPA:=[MPA_DefinicionAreas:186]ID:1
	vtEVLG_AreaComptencias:=__ ("Competencias esperadas en el área ")+$t_areaMPA
	GET LIST ITEM:C378(hl_niveles;Selected list items:C379(hl_niveles);$l_nivel_Numero;$t_nivel_Nombre)
	GET LIST ITEM:C378(hl_Periodos;Selected list items:C379(hl_Periodos);$l_numeroPeriodo;$t_nombrePeriodo)
	vl_PeriodoSeleccionado:=$l_numeroPeriodo
	aiSTR_Periodos_Numero:=$l_numeroPeriodo
	vlSTR_PeriodoSeleccionado:=$l_numeroPeriodo
	atSTR_Periodos_Nombre:=Find in array:C230(aiSTR_Periodos_Numero;vlSTR_PeriodoSeleccionado)
	
	
	
	  // busqueda de la matriz principal
	READ WRITE:C146([MPA_AsignaturasMatrices:189])
	QUERY:C277([MPA_AsignaturasMatrices:189];[MPA_AsignaturasMatrices:189]Asignatura:3=[xxSTR_Materias:20]Materia:2;*)
	QUERY:C277([MPA_AsignaturasMatrices:189]; & ;[MPA_AsignaturasMatrices:189]NumeroNivel:4=$l_nivel_Numero;*)
	QUERY:C277([MPA_AsignaturasMatrices:189]; & ;[MPA_AsignaturasMatrices:189]ConfiguracionPrincipal:19;=;True:C214)
	If (Records in selection:C76([MPA_AsignaturasMatrices:189])=0)
		CREATE RECORD:C68([MPA_AsignaturasMatrices:189])
		[MPA_AsignaturasMatrices:189]Asignatura:3:=[xxSTR_Materias:20]Materia:2
		[MPA_AsignaturasMatrices:189]Area:13:=[xxSTR_Materias:20]AreaMPA:4
		[MPA_AsignaturasMatrices:189]ID_Area:22:=$l_IdAreaMPA
		[MPA_AsignaturasMatrices:189]ConfiguracionPrincipal:19:=True:C214
		[MPA_AsignaturasMatrices:189]CreadaPor:15:=USR_GetUserName (USR_GetUserID )
		[MPA_AsignaturasMatrices:189]DTS_Creacion:16:=DTS_MakeFromDateTime (Current date:C33(*);Current time:C178(*))
		[MPA_AsignaturasMatrices:189]DTS_Modificacion:18:=DTS_MakeFromDateTime (Current date:C33(*);Current time:C178(*))
		[MPA_AsignaturasMatrices:189]ID_Creador:20:=USR_GetUserID 
		[MPA_AsignaturasMatrices:189]ID_Matriz:1:=SQ_SeqNumber (->[MPA_AsignaturasMatrices:189]ID_Matriz:1)
		[MPA_AsignaturasMatrices:189]ModificadaPor:17:=USR_GetUserName (USR_GetUserID )
		[MPA_AsignaturasMatrices:189]NombreMatriz:2:=[xxSTR_Materias:20]Materia:2+", "+$t_nivel_Nombre
		[MPA_AsignaturasMatrices:189]NumeroNivel:4:=$l_nivel_Numero
		[MPA_AsignaturasMatrices:189]PonderacionResultado:8:=0
		[MPA_AsignaturasMatrices:189]ResultadoFinalCalculado:7:=False:C215
		SAVE RECORD:C53([MPA_AsignaturasMatrices:189])
	End if 
	SAVE RECORD:C53([xxSTR_Materias:20])
	vlEVLG_DefaultMatrixID:=[MPA_AsignaturasMatrices:189]ID_Matriz:1
	bConfiguracionesPropias:=Num:C11([MPA_AsignaturasMatrices:189]PersonalizacionPermitida:21)
	
	$y_listaEnunciadosMapa:=OBJECT Get pointer:C1124(Object named:K67:5;"enunciadosMapa")
	MPA_ListaEnunciadosMapa ([xxSTR_Materias:20]Materia:2;$l_nivel_Numero;$y_listaEnunciadosMapa)
	$y_listaEnunciadosMatriz:=OBJECT Get pointer:C1124(Object named:K67:5;"asignatura.mpa.enunciados")
	MPA_ListaEnunciadosMatriz (Record number:C243([MPA_AsignaturasMatrices:189]);$l_numeroPeriodo;$y_listaEnunciadosMatriz)
	
	
	SET QUERY DESTINATION:C396(Into variable:K19:4;$l_objetosEnMatriz)
	QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1;=;[MPA_AsignaturasMatrices:189]ID_Matriz:1)
	If ($l_objetosEnMatriz>0)
		_O_ENABLE BUTTON:C192(bOpcionesAprendizajes)
	Else 
		_O_DISABLE BUTTON:C193(bOpcionesAprendizajes)
	End if 
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	
	_O_ENABLE BUTTON:C192(bPermisos)
	_O_ENABLE BUTTON:C192(hl_Periodos)  // para circunvenir un bug de 4D en el caso que el usuario haya abierto la opción configuraciones en una asignatura donde la lista pudo haber sido desactivada
	
Else 
	
End if 
