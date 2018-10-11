//%attributes = {}
  // MPA_ConfiguracionMatriz()
  // Por: Alberto Bachler K.: 19-05-14, 16:36:13
  //  ---------------------------------------------
  //
  //
  //  --------------------------------------------
C_BLOB:C604($x_blob)
C_OBJECT:C1216($o_objeto)
C_TEXT:C284($t_json;$t_numeroNivelName)

$y_nivelNumero_al:=OBJECT Get pointer:C1124(Object named:K67:5;"nivelNumero")
$l_numeroNivel:=$y_nivelNumero_al->{$y_nivelNumero_al->}
$t_numeroNivelName:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$l_numeroNivel;->[xxSTR_Niveles:6]Nivel:1)
$l_numeroPeriodo:=(OBJECT Get pointer:C1124(Object named:K67:5;"refPeriodo"))->


QUERY:C277([MPA_AsignaturasMatrices:189];[MPA_AsignaturasMatrices:189]Asignatura:3=[xxSTR_Materias:20]Materia:2;*)
QUERY:C277([MPA_AsignaturasMatrices:189]; & ;[MPA_AsignaturasMatrices:189]NumeroNivel:4=$l_numeroNivel)


$recNumArea:=Find in field:C653([MPA_DefinicionAreas:186]AreaAsignatura:4;[xxSTR_Materias:20]AreaMPA:4)
If ($recNumArea>No current record:K29:2)
	KRL_GotoRecord (->[MPA_DefinicionAreas:186];$recNumArea;False:C215)
	If (Records in selection:C76([MPA_AsignaturasMatrices:189])=0)
		$idArea:=[MPA_DefinicionAreas:186]ID:1
		CREATE RECORD:C68([MPA_AsignaturasMatrices:189])
		[MPA_AsignaturasMatrices:189]Asignatura:3:=[xxSTR_Materias:20]Materia:2
		[MPA_AsignaturasMatrices:189]Area:13:=[xxSTR_Materias:20]AreaMPA:4
		[MPA_AsignaturasMatrices:189]ID_Area:22:=[MPA_DefinicionAreas:186]ID:1
		[MPA_AsignaturasMatrices:189]ConfiguracionPrincipal:19:=True:C214
		[MPA_AsignaturasMatrices:189]CreadaPor:15:=USR_GetUserName (USR_GetUserID )
		[MPA_AsignaturasMatrices:189]DTS_Creacion:16:=DTS_MakeFromDateTime (Current date:C33(*);Current time:C178(*))
		[MPA_AsignaturasMatrices:189]DTS_Modificacion:18:=DTS_MakeFromDateTime (Current date:C33(*);Current time:C178(*))
		[MPA_AsignaturasMatrices:189]ID_Creador:20:=USR_GetUserID 
		[MPA_AsignaturasMatrices:189]ID_Matriz:1:=SQ_SeqNumber (->[MPA_AsignaturasMatrices:189]ID_Matriz:1)
		[MPA_AsignaturasMatrices:189]ModificadaPor:17:=USR_GetUserName (USR_GetUserID )
		[MPA_AsignaturasMatrices:189]NombreMatriz:2:=[xxSTR_Materias:20]Materia:2+", "+$t_numeroNivelName
		[MPA_AsignaturasMatrices:189]NumeroNivel:4:=$l_numeroNivel
		[MPA_AsignaturasMatrices:189]PonderacionResultado:8:=0
		[MPA_AsignaturasMatrices:189]ResultadoFinalCalculado:7:=False:C215
		SAVE RECORD:C53([MPA_AsignaturasMatrices:189])
	End if 
	
	QUERY:C277([MPA_AsignaturasMatrices:189];[MPA_AsignaturasMatrices:189]Asignatura:3=[xxSTR_Materias:20]Materia:2;*)
	QUERY:C277([MPA_AsignaturasMatrices:189]; & ;[MPA_AsignaturasMatrices:189]NumeroNivel:4=$l_numeroNivel)
	ORDER BY:C49([MPA_AsignaturasMatrices:189];[MPA_AsignaturasMatrices:189]ConfiguracionPrincipal:19;<)
	
	If (Records in selection:C76([MPA_AsignaturasMatrices:189])>0)
		$y_recNumMatriz_al:=OBJECT Get pointer:C1124(Object named:K67:5;"matrizRecnum")
		$y_nombreMatriz_at:=OBJECT Get pointer:C1124(Object named:K67:5;"matrizNombre")
		SELECTION TO ARRAY:C260([MPA_AsignaturasMatrices:189];$y_recNumMatriz_al->;[MPA_AsignaturasMatrices:189]NombreMatriz:2;$y_nombreMatriz_at->)
		LISTBOX SELECT ROW:C912(*;"lb_matrices";1;lk replace selection:K53:1)
		
		$y_listaEnunciadosMapa:=OBJECT Get pointer:C1124(Object named:K67:5;"enunciadosMapa")
		MPA_ListaEnunciadosMapa ([xxSTR_Materias:20]Materia:2;$l_numeroNivel;$y_listaEnunciadosMapa)
		MPA_ListaEnunciadosMapa ([xxSTR_Materias:20]Materia:2;$l_numeroNivel;->$o_objeto)
		
		
		If (Size of array:C274($y_recNumMatriz_al->)>0)
			$y_listaEnunciadosMatriz:=OBJECT Get pointer:C1124(Object named:K67:5;"asignatura.mpa.enunciados")
			MPA_ListaEnunciadosMatriz ($y_recNumMatriz_al->{1};$l_numeroPeriodo;$y_listaEnunciadosMatriz)
		End if 
		
	End if 
	
	OBJECT SET TITLE:C194(*;"tituloArea";[xxSTR_Materias:20]AreaMPA:4)
	OBJECT SET TITLE:C194(*;"tituloArea";[MPA_AsignaturasMatrices:189]NombreMatriz:2)
End if 

