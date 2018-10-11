//%attributes = {}
  // MÉTODO: EV2_RetornaPonderacion
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 28/12/11, 17:29:05
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // EV2_RetornaPonderacion()
  // ----------------------------------------------------
C_REAL:C285($0)

C_LONGINT:C283($el;$l_arrayElem;$l_calcType;$l_cols;$l_numeroCampo;$l_IdAsignaturaHija;$l_IdAsignaturaMadre;$l_numeroEnSeleccion;$l_objType;$l_options)
C_LONGINT:C283($l_order;$l_rectBottom;$l_rectLeft;$l_rectRight;$l_rectTop;$l_repeatHOffset;$l_repeatVOffset;$l_rows;$l_selected;$l_numeroTabla)
C_LONGINT:C283($l_varType;$l_error)
C_POINTER:C301($y_SRobjectPointer)
C_REAL:C285($r_ponderacion)
C_TEXT:C284($t_calcName;$t_nombrePropiedadesEvaluacion;$t_objName)
C_LONGINT:C283(vPeriodo;vlQR_SRMainTable;SRArea;SRObjectPrintRef)
If (False:C215)
	C_REAL:C285(EV2_RetornaPonderacion ;$0)
End if 


  // CODIGO PRINCIPAL
If ((SRArea#0) & (SRObjectPrintRef#0))  //si el método es llamado desde un objeto SuperReport válido
	If (Application version:C493>="15@")
		$t_tipoObjeto:=SR_GetTextProperty (SRArea;SRObjectPrintRef;SRP_Object_Kind)
		$t_nombreObjeto:=SR_GetTextProperty (SRArea;SRObjectPrintRef;SRP_Object_Name)
		$t_RefCampo:=SR_GetTextProperty (SRArea;SRObjectPrintRef;SRP_Field_Source)
		$l_numeroTabla:=Num:C11(ST_GetWord ($t_RefCampo;1;"]"))
		$l_numeroCampo:=Num:C11(ST_GetWord ($t_RefCampo;2;"]"))
		Case of 
			: ($t_tipoObjeto="field")
				$y_SRobjectPointer:=Field:C253($l_numeroTabla;$l_numeroCampo)
			: (($t_tipoObjeto="variable") | ($t_tipoObjeto="var"))
				$y_SRobjectPointer:=Get pointer:C304($t_RefCampo)
		End case 
	Else 
		$l_error:=SR Get Object Properties (SRArea;SRObjectPrintRef;$t_objName;$l_rectTop;$l_rectLeft;$l_rectBottom;$l_rectRight;$l_objType;$l_options;$l_order;$l_selected;$l_numeroTabla;$l_numeroCampo;$l_varType;$l_arrayElem;$l_calcType;$t_calcName;$l_rows;$l_cols;$l_repeatHOffset;$l_repeatVOffset)
	End if 
	Case of 
		: ($l_numeroCampo>0)
			$y_SRobjectPointer:=Field:C253($l_numeroTabla;$l_numeroCampo)
		: ($t_objName#"")
			$y_SRobjectPointer:=Get pointer:C304($t_objName)
		Else 
			
	End case 
End if 

  //si estoy imprimiendo a partir de la tabla [asignaturas]copio la selección para poder reestablecerla luego de leer las propiedades de la asignatura madre
If (vlQR_SRMainTable=Table:C252(->[Asignaturas:18]))
	COPY NAMED SELECTION:C331([Asignaturas:18];"Seleccion")
End if 

$l_numeroEnSeleccion:=Selected record number:C246([Asignaturas:18])
AScsd_LeeReferencias ([Asignaturas:18]Numero:1;vPeriodo)
If (Records in selection:C76([Asignaturas_Consolidantes:231])>0)
	$l_IdAsignaturaMadre:=[Asignaturas_Consolidantes:231]ID_AsignaturaMadre:1
End if 
GOTO SELECTED RECORD:C245([Asignaturas:18];$l_numeroEnSeleccion)

  //busco la asignatura madre
If ($l_IdAsignaturaMadre>0)
	KRL_FindAndLoadRecordByIndex (->[Asignaturas:18]Numero:1;->$l_IdAsignaturaMadre;False:C215)
	If (OK=1)
		If ([Asignaturas:18]Consolidacion_PorPeriodo:58)
			  //MONO CAMBIO AS_PropEval_Lectura
			  //$t_nombrePropiedadesEvaluacion:="Blob_ConfigNotas/"+String([Asignaturas]Numero)+"/P"+String(vPeriodo)
			$t_nombrePropiedadesEvaluacion:="P"+String:C10(vPeriodo)
		Else 
			  //MONO CAMBIO AS_PropEval_Lectura
			  //$t_nombrePropiedadesEvaluacion:="Blob_ConfigNotas/"+String([Asignaturas]Numero)
			$t_nombrePropiedadesEvaluacion:="Anual"
		End if 
		AS_PropEval_Lectura ($t_nombrePropiedadesEvaluacion)
		
		$el:=Find in array:C230(alAS_EvalPropSourceID;$l_IdAsignaturaHija)
		If ($el>0)
			$r_ponderacion:=arAS_EvalPropPonderacion{$el}
		End if 
	End if 
	$0:=$r_ponderacion
End if 

  //reestablezco las propiedades de evaluacion de la asignatura original
If (vlQR_SRMainTable=Table:C252(->[Asignaturas:18]))
	USE NAMED SELECTION:C332("Seleccion")
	CLEAR NAMED SELECTION:C333("seleccion")
End if 
GOTO SELECTED RECORD:C245([Asignaturas:18];$l_numeroEnSeleccion)

If ([Asignaturas:18]Consolidacion_PorPeriodo:58)
	  //MONO CAMBIO AS_PropEval_Lectura
	  //$t_nombrePropiedadesEvaluacion:="Blob_ConfigNotas/"+String([Asignaturas]Numero)+"/P"+String(vPeriodo)
	$t_nombrePropiedadesEvaluacion:="P"+String:C10(vPeriodo)
Else 
	  //MONO CAMBIO AS_PropEval_Lectura
	  //$t_nombrePropiedadesEvaluacion:="Blob_ConfigNotas/"+String([Asignaturas]Numero)
	$t_nombrePropiedadesEvaluacion:="Anual"
End if 
AS_PropEval_Lectura ($t_nombrePropiedadesEvaluacion)

If ((SRArea#0) & (SRObjectPrintRef#0) & (Not:C34(Is nil pointer:C315($y_SRobjectPointer))))  //si el método es llamado desde un objeto SuperReport válido
	$y_SRobjectPointer->:=$0
End if 