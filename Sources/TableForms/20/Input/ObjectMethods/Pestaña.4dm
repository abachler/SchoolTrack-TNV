  // [xxSTR_Materias].Input.Pestaña()
  // Por: Alberto Bachler K.: 20-05-14, 19:39:19
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_arriba;$l_derecha;$l_IdAreaMPA;$l_ignorar;$l_izquierda;$l_limiteInferior;$l_nivelNumero;$l_numeroPeriodo;$l_objetosEnMatriz;$l_recNumMatriz)
C_POINTER:C301($y_listaEnunciadosMapa;$y_listaEnunciadosMatriz;$y_matrizNombre;$y_matrizRecnum;$y_Pestaña;$y_refNivel;$y_refPeriodo)
C_TEXT:C284($t_nivel_Nombre;$t_pestaña;$t_tituloArea;$t_tituloMatriz)
C_POINTER:C301($y_nivelNumero;$y_nivelNombre)

If (vlSTR_UltimaPaginaMaterias=2)  //20170623 RCH Retorno de observaciones
	CFGstr_GuardaObsSubsectores 
End if 

$y_Pestaña:=OBJECT Get pointer:C1124(Object named:K67:5;"pestaña")
GET LIST ITEM:C378($y_Pestaña->;*;vlSTR_UltimaPaginaMaterias;$t_pestaña)

C_POINTER:C301($y_listboxObservaciones;$y_listaCategorias;$y_categorias;$y_observaciones)  //20170623 RCH Retorno de observaciones
$y_listboxObservaciones:=OBJECT Get pointer:C1124(Object named:K67:5;"lb_observaciones")
$y_listaCategorias:=OBJECT Get pointer:C1124(Object named:K67:5;"listaCategorias")
$y_categorias:=OBJECT Get pointer:C1124(Object named:K67:5;"categoriaObservacion")
$y_observaciones:=OBJECT Get pointer:C1124(Object named:K67:5;"observacion")

$y_nivelNombre:=OBJECT Get pointer:C1124(Object named:K67:5;"nivelNombre")
$y_nivelNumero:=OBJECT Get pointer:C1124(Object named:K67:5;"nivelNumero")
$y_refNivel:=OBJECT Get pointer:C1124(Object named:K67:5;"nivelActual")
If (Size of array:C274($y_nivelNumero->)>0)
	If ($y_nivelNumero->=0)
		LISTBOX SELECT ROW:C912(*;"listbox.niveles";1;lk replace selection:K53:1)
		$y_nivelNumero->:=1
		$y_refNivel->:=String:C10($y_nivelNumero->{$y_nivelNumero->})
	Else 
		$y_refNivel->:=String:C10($y_nivelNumero->{$y_nivelNumero->})
	End if 
Else 
	$y_refNivel->:=""
	vlSTR_UltimaPaginaMaterias:=1
End if 


Case of 
	: (vlSTR_UltimaPaginaMaterias=1)
		OBJECT SET VISIBLE:C603(*;"listbox.niveles";False:C215)
		FORM GOTO PAGE:C247(vlSTR_UltimaPaginaMaterias)
		
	: (vlSTR_UltimaPaginaMaterias=2)  //20170623 RCH Retorno de observaciones
		OBJECT SET VISIBLE:C603(*;"listbox.niveles";True:C214)
		OBJECT GET COORDINATES:C663(*;"lineaPie";$l_ignorar;$l_limiteInferior;$l_ignorar;$l_ignorar)
		OBJECT GET COORDINATES:C663(*;"listbox.niveles";$l_izquierda;$l_arriba;$l_derecha;$l_ignorar)
		OBJECT SET COORDINATES:C1248(*;"listbox.niveles";$l_izquierda;$l_arriba;$l_derecha;$l_limiteInferior)
		
		CFGstr_LeeObsSubsectores 
		FORM GOTO PAGE:C247(vlSTR_UltimaPaginaMaterias)
		
		
	: (vlSTR_UltimaPaginaMaterias=3)
		$l_IdAreaMPA:=KRL_GetNumericFieldData (->[MPA_DefinicionAreas:186]AreaAsignatura:4;->[xxSTR_Materias:20]AreaMPA:4;->[MPA_DefinicionAreas:186]ID:1)
		If ($l_IdAreaMPA#0)
			$l_nivelNumero:=$y_nivelNumero->{$y_nivelNumero->}
			PERIODOS_LoadData ($l_nivelNumero)
			
			  // busqueda de la matriz principal
			READ WRITE:C146([MPA_AsignaturasMatrices:189])
			QUERY:C277([MPA_AsignaturasMatrices:189];[MPA_AsignaturasMatrices:189]Asignatura:3=[xxSTR_Materias:20]Materia:2;*)
			QUERY:C277([MPA_AsignaturasMatrices:189]; & ;[MPA_AsignaturasMatrices:189]NumeroNivel:4=$l_nivelNumero;*)
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
				[MPA_AsignaturasMatrices:189]NumeroNivel:4:=$l_nivelNumero
				[MPA_AsignaturasMatrices:189]PonderacionResultado:8:=0
				[MPA_AsignaturasMatrices:189]ResultadoFinalCalculado:7:=False:C215
				SAVE RECORD:C53([MPA_AsignaturasMatrices:189])
			End if 
			SAVE RECORD:C53([xxSTR_Materias:20])
			vlEVLG_DefaultMatrixID:=[MPA_AsignaturasMatrices:189]ID_Matriz:1
			bConfiguracionesPropias:=Num:C11([MPA_AsignaturasMatrices:189]PersonalizacionPermitida:21)
			
			$y_matrizNombre:=OBJECT Get pointer:C1124(Object named:K67:5;"matrizNombre")
			$y_matrizRecnum:=OBJECT Get pointer:C1124(Object named:K67:5;"matrizRecnum")
			QUERY:C277([MPA_AsignaturasMatrices:189];[MPA_AsignaturasMatrices:189]Asignatura:3=[xxSTR_Materias:20]Materia:2;*)
			QUERY:C277([MPA_AsignaturasMatrices:189]; & ;[MPA_AsignaturasMatrices:189]NumeroNivel:4=$l_nivelNumero)
			ORDER BY:C49([MPA_AsignaturasMatrices:189];[MPA_AsignaturasMatrices:189]ConfiguracionPrincipal:19;<)
			SELECTION TO ARRAY:C260([MPA_AsignaturasMatrices:189];$y_matrizRecnum->;[MPA_AsignaturasMatrices:189]NombreMatriz:2;$y_matrizNombre->)
			
			
			$y_listaEnunciadosMapa:=OBJECT Get pointer:C1124(Object named:K67:5;"enunciadosMapa")
			MPA_ListaEnunciadosMapa ([xxSTR_Materias:20]Materia:2;$l_nivelNumero;$y_listaEnunciadosMapa)
			$y_listaEnunciadosMatriz:=OBJECT Get pointer:C1124(Object named:K67:5;"asignatura.mpa.enunciados")
			If (Size of array:C274($y_matrizNombre->)>0)
				LISTBOX SELECT ROW:C912(*;"lb_matrices";1)
				$l_recNumMatriz:=$y_matrizRecnum->{1}
				MPA_ListaEnunciadosMatriz ($l_recNumMatriz;$l_numeroPeriodo;$y_listaEnunciadosMatriz)
			End if 
			
			$t_tituloArea:=__ ("Competencias en ^0 en ^1")
			$t_tituloArea:=Replace string:C233($t_tituloArea;"^0";[xxSTR_Materias:20]AreaMPA:4)
			$t_tituloArea:=Replace string:C233($t_tituloArea;"^1";$y_nivelNombre->{$y_nivelNombre->})
			OBJECT SET TITLE:C194(*;"tituloArea";$t_tituloArea)
			
			$t_tituloMatriz:=__ ("Competencias en ^0")
			$t_tituloMatriz:=Replace string:C233($t_tituloMatriz;"^0";$y_matrizNombre->{$y_matrizNombre->})
			OBJECT SET TITLE:C194(*;"tituloMatriz";$t_tituloMatriz)
			
			OBJECT SET VISIBLE:C603(*;"listbox.niveles";True:C214)
			OBJECT GET COORDINATES:C663(*;"separadorHorizontal1";$l_ignorar;$l_limiteInferior;$l_ignorar;$l_ignorar)
			OBJECT GET COORDINATES:C663(*;"listbox.niveles";$l_izquierda;$l_arriba;$l_derecha;$l_ignorar)
			OBJECT SET COORDINATES:C1248(*;"listbox.niveles";$l_izquierda;$l_arriba;$l_derecha;$l_limiteInferior)
			
			
			$y_refPeriodo:=OBJECT Get pointer:C1124(Object named:K67:5;"refPeriodo")
			Case of 
				: ($y_refPeriodo->=0)
					OBJECT SET TITLE:C194(*;"MenuPeriodo";__ ("Comunes a todos los períodos"))
				: ($y_refPeriodo->>0)
					OBJECT SET TITLE:C194(*;"MenuPeriodo";atSTR_Periodos_Nombre{$y_refPeriodo->})
			End case 
			
			
			SET QUERY DESTINATION:C396(Into variable:K19:4;$l_objetosEnMatriz)
			QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1;=;[MPA_AsignaturasMatrices:189]ID_Matriz:1)
			OBJECT SET ENABLED:C1123(bOpcionesAprendizajes;$l_objetosEnMatriz>0)
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			
			OBJECT SET ENABLED:C1123(bPermisos;True:C214)
			OBJECT SET ENABLED:C1123(hl_Periodos;True:C214)
			
			FORM GOTO PAGE:C247(vlSTR_UltimaPaginaMaterias)
			
		End if 
		
End case 


