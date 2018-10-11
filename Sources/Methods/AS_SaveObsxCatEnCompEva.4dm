//%attributes = {}
  // ----------------------------------------------------
  // Usuario (SO): Daniel Ledezma
  // Fecha y hora: 28-08-18, 14:35:44
  // ----------------------------------------------------
  // Método: AS_SaveObsxCatEnCompEva
  // Descripción
  // Consolida la informacion de las observaciones por categoría que están en [Alumnos_ObservacionesEvaluacion]
  // hacia los campos de observaciones academicas en [Alumnos_ComplementoEvaluacion], como por ejemplo P01_Obs_Academicas...
  // Parámetros 1: id alumno - 2: id Asignatura - 3: periodo - 4: registro en selección de complemento evaluación (maneja la modificación del registro en este método o desde otro que lo llamó)
  // 0: true/false, si no hubo problemas para actualizar el registro.(si no lo guarda por que no fue necesario actualizar igual devuelve true) 
  // ----------------------------------------------------

ARRAY TEXT:C222($at_categorias;0)
ARRAY TEXT:C222($at_categoriasDistintas;0)
ARRAY TEXT:C222($at_observaciones;0)

C_LONGINT:C283($i_categorias;$i_observaciones;$1;$l_idAlu;$2;$l_idAsig;$3;$l_periodo;$l_nivel)
C_TEXT:C284($t_llave;$t_Categoria;$t_ObservacionesConsolidadas;$t_obs)
C_POINTER:C301($y_campo)
C_BOOLEAN:C305($b_ok;$0;$4;$b_registroEnSeleccion)

$b_ok:=True:C214

$l_idAlu:=$1
$l_idAsig:=$2
$l_periodo:=$3
$b_registroEnSeleccion:=$4

$t_llave:=KRL_MakeStringAccesKey (->$l_idAlu;->$l_idAsig;->$l_periodo)

READ ONLY:C145([Alumnos_ObservacionesEvaluacion:30])

QUERY:C277([Alumnos_ObservacionesEvaluacion:30];[Alumnos_ObservacionesEvaluacion:30]Key:9=$t_llave)
ORDER BY:C49([Alumnos_ObservacionesEvaluacion:30];[Alumnos_ObservacionesEvaluacion:30]Categoría:4;>;[Alumnos_ObservacionesEvaluacion:30]Observacion:5;>)
SELECTION TO ARRAY:C260([Alumnos_ObservacionesEvaluacion:30]Categoría:4;$at_categorias;[Alumnos_ObservacionesEvaluacion:30]Observacion:5;$at_observaciones)
COPY ARRAY:C226($at_categorias;$at_categoriasDistintas)
AT_DistinctsArrayValues (->$at_categoriasDistintas)
SORT ARRAY:C229($at_categoriasDistintas;>)

For ($i_categorias;1;Size of array:C274($at_categoriasDistintas))
	
	$at_categorias{0}:=$at_categoriasDistintas{$i_categorias}
	ARRAY LONGINT:C221($DA_Return;0)
	AT_SearchArray (->$at_categorias;"=";->$DA_Return)
	
	If (Size of array:C274($DA_Return)>0)
		If (($at_categoriasDistintas{$i_categorias}="none") | ($at_categoriasDistintas{$i_categorias}=__ ("(sin categoría)")))
			$t_Categoria:=""
		Else 
			$t_Categoria:=$at_categoriasDistintas{$i_categorias}
			If ($t_Categoria="@:")
				$t_ObservacionesConsolidadas:=$t_ObservacionesConsolidadas+$t_Categoria+"\r"
			Else 
				$t_ObservacionesConsolidadas:=$t_ObservacionesConsolidadas+$t_Categoria+":\r"
			End if 
		End if 
		
		For ($i_observaciones;1;Size of array:C274($DA_Return))
			$t_ObservacionesConsolidadas:=$t_ObservacionesConsolidadas+("- "*Num:C11($t_Categoria#""))+$at_observaciones{$DA_Return{$i_observaciones}}+"\r"
		End for 
	End if 
End for 

If ($l_periodo>0)
	$y_campo:=KRL_GetFieldPointerByName ("[Alumnos_ComplementoEvaluacion]P0"+String:C10($l_periodo)+"_Obs_Academicas")
Else 
	$y_campo:=->[Alumnos_ComplementoEvaluacion:209]Final_ObservacionesAcademicas:46
End if 

If ($b_registroEnSeleccion)
	If ($y_campo->#$t_ObservacionesConsolidadas)
		$y_campo->:=$t_ObservacionesConsolidadas
	Else 
		$b_ok:=False:C215
	End if 
Else 
	$l_nivel:=KRL_GetNumericFieldData (->[Alumnos:2]numero:1;->$l_idAlu;->[Alumnos:2]nivel_numero:29)
	$t_llave:=String:C10(0)+"."+String:C10(<>gyear)+"."+String:C10($l_nivel)+"."+String:C10(Abs:C99($l_idAsig))+"."+String:C10(Abs:C99($l_idAlu))
	$t_obs:=KRL_GetTextFieldData (->[Alumnos_ComplementoEvaluacion:209]Llave_Principal:1;->$t_llave;$y_campo)
	
	If ($t_obs#$t_ObservacionesConsolidadas)
		READ WRITE:C146([Alumnos_ComplementoEvaluacion:209])
		QUERY:C277([Alumnos_ComplementoEvaluacion:209];[Alumnos_ComplementoEvaluacion:209]Llave_Principal:1=$t_llave)
		If (Not:C34(Locked:C147([Alumnos_ComplementoEvaluacion:209])))
			$y_campo->:=$t_ObservacionesConsolidadas
			SAVE RECORD:C53([Alumnos_ComplementoEvaluacion:209])
		Else 
			$b_ok:=False:C215
		End if 
		KRL_UnloadReadOnly (->[Alumnos_ComplementoEvaluacion:209])
	End if 
End if 
$0:=$b_ok
