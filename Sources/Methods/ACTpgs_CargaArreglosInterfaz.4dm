//%attributes = {}
  // Método: ACTpgs_CargaArreglosInterfaz
  //----------------------------------------------
  // Usuario (OS): roberto
  // Fecha: 11-03-10, 11:05:24
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones
ACTpgs_ArreglosItems ("DeclaraArreglos")
ACTpgs_ArreglosCuentas ("DeclaraArreglos")
ACTpgs_ArreglosAgrupado ("DeclaraArreglos")

$vd_fecha:=$1

  // Código principal

If ((RNApdo#-1) | (RNCta#-1) | (RNTercero#-1))
	ARRAY BOOLEAN:C223(abACT_ASelectedItem;0)
	COPY ARRAY:C226(alACT_CRefs;alACT_RefItem)
	AT_DistinctsArrayValues (->alACT_RefItem)
	AT_RedimArrays (Size of array:C274(alACT_RefItem);->apACT_ASelectedItem;->arACT_AMontoSeleccionadoXI)
	For ($i;1;Size of array:C274(alACT_RefItem))
		READ ONLY:C145([xxACT_Items:179])
		$vl_idItem:=alACT_RefItem{$i}
		KRL_FindAndLoadRecordByIndex (->[xxACT_Items:179]ID:1;->$vl_idItem)
		If (Records in selection:C76([xxACT_Items:179])=1)
			APPEND TO ARRAY:C911(atACT_GlosaItem;[xxACT_Items:179]Glosa:2)
		Else 
			$el:=Find in array:C230(alACT_CRefs;$vl_idItem)
			APPEND TO ARRAY:C911(atACT_GlosaItem;atACT_CGlosa{$el})
		End if 
		GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";apACT_ASelectedItem{$i})
		APPEND TO ARRAY:C911(abACT_ASelectedItem;False:C215)
	End for 
	
	For ($i;1;Size of array:C274(alACT_RefItem))
		APPEND TO ARRAY:C911(arACT_MontoXItem;ACTpgs_RetornaMontoXAviso ("MontoDesdeNoItem";False:C215;String:C10(alACT_RefItem{$i});$vd_fecha))
	End for 
End if 


  //Cargos desde cuentas
If ((RNApdo#-1) | (RNCta#-1) | (RNTercero#-1))
	ARRAY BOOLEAN:C223(abACT_ASelectedAlumno;0)
	COPY ARRAY:C226(alACT_CIDCtaCte;alACT_AIdsCtas)
	AT_DistinctsArrayValues (->alACT_AIdsCtas)
	AT_RedimArrays (Size of array:C274(alACT_AIdsCtas);->apACT_ASelectedAlumnos;->arACT_AMontoSeleccionadoXAl)
	For ($i;1;Size of array:C274(alACT_AIdsCtas))
		READ ONLY:C145([Alumnos:2])
		READ ONLY:C145([ACT_CuentasCorrientes:175])
		$vl_idCuenta:=alACT_AIdsCtas{$i}
		KRL_FindAndLoadRecordByIndex (->[ACT_CuentasCorrientes:175]ID:1;->$vl_idCuenta)
		If (Records in selection:C76([ACT_CuentasCorrientes:175])=1)
			APPEND TO ARRAY:C911(atACT_ANombresAlumnos;KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3;->[Alumnos:2]apellidos_y_nombres:40))
		Else 
			$el:=Find in array:C230(alACT_CIDCtaCte;$vl_idCuenta)
			APPEND TO ARRAY:C911(atACT_ANombresAlumnos;atACT_CAlumno{$el})
		End if 
		GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";apACT_ASelectedAlumnos{$i})
		APPEND TO ARRAY:C911(abACT_ASelectedAlumno;False:C215)
	End for 
	
	For ($i;1;Size of array:C274(alACT_AIdsCtas))
		APPEND TO ARRAY:C911(arACT_AMontoXAlumno;ACTpgs_RetornaMontoXAviso ("MontoDesdeNoCta";False:C215;String:C10(alACT_AIdsCtas{$i});$vd_fecha))
	End for 
End if 

  //Agrupado por meses
If ((RNApdo#-1) | (RNCta#-1) | (RNTercero#-1))
	ARRAY BOOLEAN:C223(abACT_ASelectedAgrupado;0)
	ARRAY TEXT:C222($at_fechas;0)
	ARRAY TEXT:C222($at_meses;0)
	
	  //COPY ARRAY(adACT_CFechaVencimiento;$adACT_AFechasDocumento)
	COPY ARRAY:C226(adACT_CFechaEmision;$adACT_AFechasDocumento)
	AT_DistinctsArrayValues (->$adACT_AFechasDocumento)
	For ($i;1;Size of array:C274($adACT_AFechasDocumento))
		APPEND TO ARRAY:C911($at_fechas;String:C10(Year of:C25($adACT_AFechasDocumento{$i});"0000")+String:C10(Month of:C24($adACT_AFechasDocumento{$i});"00"))
	End for 
	AT_DistinctsArrayValues (->$at_fechas)
	COPY ARRAY:C226(<>atXS_MonthNames;$at_meses)
	For ($i;1;Size of array:C274($at_fechas))
		C_PICTURE:C286($vp_pict)
		GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";$vp_pict)
		APPEND TO ARRAY:C911(apACT_ASelectedAgrupado;$vp_pict)
		APPEND TO ARRAY:C911(alACT_AYearAgrupado;Num:C11(Substring:C12($at_fechas{$i};1;4)))
		APPEND TO ARRAY:C911(atACT_AMesAgrupado;$at_meses{Num:C11(Substring:C12($at_fechas{$i};5;2))})
		APPEND TO ARRAY:C911(arACT_AMontoXAgrupado;ACTpgs_RetornaMontoXAviso ("MontoDesdeAgrupado";False:C215;$at_fechas{$i};$vd_fecha))
		APPEND TO ARRAY:C911(arACT_AMontoSelXAgrup;0)
		APPEND TO ARRAY:C911(abACT_ASelectedAgrupado;False:C215)
		APPEND TO ARRAY:C911(atACT_YearMonthAgrupado;$at_fechas{$i})
	End for 
End if 