//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda 
  // Fecha y hora: 05-01-18, 12:27:24
  // ----------------------------------------------------
  // Método: STWA2_BuildCambioNombreParcial
  // 
  //
  // Parámetros
  // ----------------------------------------------------

$uuid:=$1
$y_ParameterNames:=$2
$y_ParameterValues:=$3

ARRAY TEXT:C222($at_nombreParciales;0)
ARRAY TEXT:C222($at_nombreSubAsig;0)
C_OBJECT:C1216($o_raiz;$o_SubAsignatura;$o_nodo)
$o_raiz:=OB_Create 

$l_idUsuario:=STWA2_Session_GetUserSTID ($uuid)
$accion:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"dato")
$rnAsig:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"rnAsig"))

Case of 
	: ($accion="build")
		
		  //cargo datos de subasignaturas
		GOTO RECORD:C242([Asignaturas:18];$rnAsig)
		QUERY:C277([xxSTR_Subasignaturas:83];[xxSTR_Subasignaturas:83]ID_Mother:6=[Asignaturas:18]Numero:1;*)
		QUERY:C277([xxSTR_Subasignaturas:83]; & ;[xxSTR_Subasignaturas:83]Columna:13#0)
		SELECTION TO ARRAY:C260([xxSTR_Subasignaturas:83]Referencia:11;$at_referencia;[xxSTR_Subasignaturas:83]o_Data:21;$aob_SubAsigObjeto;[xxSTR_Subasignaturas:83]Name:2;$at_nombreSubAsig;*)
		SELECTION TO ARRAY:C260([xxSTR_Subasignaturas:83]Periodo:12;$al_periodo;[xxSTR_Subasignaturas:83]Columna:13;$al_columa;[xxSTR_Subasignaturas:83]Auto_UUID:20;$at_uuid_SubAsignatura;*)
		SELECTION TO ARRAY:C260
		For ($i;1;Size of array:C274($aob_SubAsigObjeto))
			AT_Initialize (->$at_nombreParciales)
			$o_nodo:=OB_Create 
			OB_GET ($aob_SubAsigObjeto{$i};->$at_nombreParciales;"aSubEvalNombreParciales")
			OB SET:C1220($o_nodo;"UUID";$at_uuid_SubAsignatura{$i})
			OB SET ARRAY:C1227($o_nodo;"aSubEvalNombreParciales";$at_nombreParciales)
			OB SET:C1220($o_nodo;"referencia";$at_referencia{$i})
			OB SET:C1220($o_nodo;"periodo";$al_periodo{$i})
			OB SET:C1220($o_nodo;"columna";$al_columa{$i})
			OB SET:C1220($o_nodo;"nombre";$at_nombreSubAsig{$i})
			OB SET:C1220($o_SubAsignatura;$at_uuid_SubAsignatura{$i};$o_nodo)
		End for 
		PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
		
		
		  //cargo datos de asignaturas
		CLEAR VARIABLE:C89($o_nodo)
		C_OBJECT:C1216($o_asignaturaMadre;$o_nodo)
		
		If ([Asignaturas:18]Consolidacion_PorPeriodo:58)
			For ($i;1;Size of array:C274(atSTR_Periodos_Nombre))
				CLEAR VARIABLE:C89($o_nodo)
				$t_NombreRegistroPropiedades:="P"+String:C10($i)
				AS_PropEval_Lectura ($t_NombreRegistroPropiedades)
				OB SET ARRAY:C1227($o_nodo;"SourceID";alAS_EvalPropSourceID)
				OB SET ARRAY:C1227($o_nodo;"SourceName";atAS_EvalPropSourceName)
				OB SET ARRAY:C1227($o_nodo;"ClassName";atAS_EvalPropClassName)
				OB SET ARRAY:C1227($o_nodo;"PrintName";atAS_EvalPropPrintName)
				OB SET:C1220($o_asignaturaMadre;$t_NombreRegistroPropiedades;$o_nodo)
			End for 
		Else 
			AS_PropEval_Lectura ("Anual")
			OB SET ARRAY:C1227($o_nodo;"SourceID";alAS_EvalPropSourceID)
			OB SET ARRAY:C1227($o_nodo;"SourceName";atAS_EvalPropSourceName)
			OB SET ARRAY:C1227($o_nodo;"ClassName";atAS_EvalPropClassName)
			OB SET ARRAY:C1227($o_nodo;"PrintName";atAS_EvalPropPrintName)
			OB SET:C1220($o_asignaturaMadre;"Anual";$o_nodo)
		End if 
		
		OB SET:C1220($o_raiz;"consolidaPeriodo";[Asignaturas:18]Consolidacion_PorPeriodo:58)
		OB SET:C1220($o_raiz;"subasignatura";$o_SubAsignatura)
		OB SET:C1220($o_raiz;"asignatura";$o_asignaturaMadre)
		OB SET ARRAY:C1227($o_raiz;"periodos";atSTR_Periodos_Nombre)
		
		$json:=JSON Stringify:C1217($o_raiz)
		$0:=$json
End case 