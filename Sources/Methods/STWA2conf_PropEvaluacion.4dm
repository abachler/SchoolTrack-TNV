//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda 
  // Fecha y hora: 20-08-18, 19:43:52
  // ----------------------------------------------------
  // Método: STWA2conf_PropEvaluacion
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------


C_OBJECT:C1216($o_propiedades;$o_raiz;$o_jsonIni;$o_opciones;$o_opcionesInit;$o_nodo;$o_parametrosAnual;$o_parametrosEspecifica;$o_temporal;$o_nodoPS)
C_LONGINT:C283($l_iguales;$l_coeficiente;$l_porcentaje;$l_periodo)
ARRAY TEXT:C222($at_propiedadesObjeto;0)
ARRAY OBJECT:C1221($ao_SubAsignaturas;0)
ARRAY TEXT:C222($at_nombreParciales;0)
ARRAY OBJECT:C1221($ao_periodos;0)
ARRAY OBJECT:C1221($ao_objetos;0)
$o_temporal:=OB_Create 

$uuid:=$1
$y_ParameterNames:=$2
$y_ParameterValues:=$3
$profID:=STWA2_Session_GetProfID ($uuid)
$userID:=STWA2_Session_GetUserSTID ($uuid)
$admin:=USR_IsGroupMember_by_GrpID (-15001;$userID)
$t_acccion:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"accion")
$l_periodo:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"periodo"))
$l_rnAsig:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"rnAsig"))

Case of 
	: ($t_acccion="init")
		
		KRL_GotoRecord (->[Asignaturas:18];$l_rnAsig;False:C215)
		
		PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
		AS_PropEval_MenuAsignaturas ([Asignaturas:18]Numero:1;True:C214)
		
		ARRAY TEXT:C222(aCsdPopIDText;0)
		AT_RedimArrays (Size of array:C274(aCsdPop);->aCsdPopIDText)
		For ($l_indice;1;Size of array:C274(aCsdPopIDText))
			aCsdPopIDText{$l_indice}:=String:C10(aCsdPopID{$l_indice})
			If (aCsdPopID{$l_indice}<0)
				$l_cantidad:=Count in array:C907(aCsdPopID;aCsdPopID{$l_indice})
				If ($l_cantidad>0)
					aCsdPopIDText{$l_indice}:=String:C10(aCsdPopID{$l_indice})+"_"+String:C10($l_indice)
				End if 
			End if 
		End for 
		For ($i;Size of array:C274(aCsdPop);1;-1)
			If (aCsdPop{$i}="-")
				DELETE FROM ARRAY:C228(aCsdPop;$i)
				DELETE FROM ARRAY:C228(aCsdPopID;$i)
				DELETE FROM ARRAY:C228(aCsdPopIDText;$i)
				DELETE FROM ARRAY:C228(aRefSubAsignatura;$i)
			End if 
			Case of 
				: (aCsdPop{$i}="Evaluacion ingresable")
					aCsdPopIDText{$i}:="ingresable"
				: (aCsdPop{$i}="No ingresable")
					aCsdPopIDText{$i}:="noingresable"
				: (aCsdPop{$i}="Nueva Sub@")
					aCsdPopIDText{$i}:="nuevasub"
			End case 
		End for 
		
		$t_jsonOriginal:=JSON Stringify:C1217([Asignaturas:18]Configuracion:63)
		$b_puedeBloquear:=STWA2_Priv_GetMethodAccess ("Bloquear propiedades de evaluacion";$userID)
		$l_AutorizarPropEval:=Num:C11(PREF_fGet (0;"PermitirConfigPropEval";"0"))
		$o_jsonIni:=AS_PropEval_CreaObjeto ([Asignaturas:18]Numero_del_Nivel:6)
		$b_blockPropEva:=OB Get:C1224([Asignaturas:18]Opciones:57;"BloqueoPropDeEval")
		
		  //Permisos
		$b_puedeEditar:=(USR_checkRights ("M";->[Asignaturas:18];$userID)) | (STWA2_Priv_GetMethodAccess ("Propiedades de evaluación";$userID))
		$b_puedeEditar:=$b_puedeEditar | (($l_AutorizarPropEval=1) & ([Asignaturas:18]profesor_numero:4=$profID) & ($b_blockPropEva=False:C215))
		
		  //cargo la información de configuración
		$o_propiedades:=[Asignaturas:18]Configuracion:63
		$b_blockOpcionesCalculo:=True:C214
		
		  //para bloquear las opciones de calculo
		ARRAY LONGINT:C221(alAS_EvalPropSourceID;0)
		PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
		$l_iteraciones:=Size of array:C274(atSTR_Periodos_Nombre)+1
		For ($l_indice;1;$l_iteraciones)
			If ($l_indice<=Size of array:C274(atSTR_Periodos_Nombre))
				$t_nodo:="P"+String:C10($l_indice)
			Else 
				$t_nodo:="Anual"
			End if 
			
			OB GET PROPERTY NAMES:C1232([Asignaturas:18]Configuracion:63;$at_propiedadesObjeto)
			If (Find in array:C230($at_propiedadesObjeto;$t_nodo)#-1)
				$o_nodo:=OB Get:C1224([Asignaturas:18]Configuracion:63;$t_nodo)
				
				OB GET ARRAY:C1229($o_nodo;"SourceID";alAS_EvalPropSourceID)
				
				For ($l_iNodo;1;Size of array:C274(alAS_EvalPropSourceID))
					If (alAS_EvalPropSourceID{$l_iNodo}#0)
						$b_blockOpcionesCalculo:=False:C215
						$l_iNodo:=Size of array:C274(alAS_EvalPropSourceID)+1
						$l_indice:=$l_iteraciones+1
					End if 
				End for 
			End if 
		End for 
		
		  //Cargo la información de subasignaturas para el cambio del nombre en las parciales
		
		QUERY:C277([xxSTR_Subasignaturas:83];[xxSTR_Subasignaturas:83]ID_Mother:6=[Asignaturas:18]Numero:1;*)
		QUERY:C277([xxSTR_Subasignaturas:83]; & ;[xxSTR_Subasignaturas:83]Columna:13#0)
		SELECTION TO ARRAY:C260([xxSTR_Subasignaturas:83]Referencia:11;$at_referenciaSA;[xxSTR_Subasignaturas:83]o_Data:21;$aob_SubAsigObjeto;[xxSTR_Subasignaturas:83]Name:2;$at_nombreSubAsig;*)
		SELECTION TO ARRAY:C260([xxSTR_Subasignaturas:83]Periodo:12;$al_periodo;[xxSTR_Subasignaturas:83]Auto_UUID:20;$at_uuid_SubAsignatura)
		
		For ($i;1;Size of array:C274($aob_SubAsigObjeto))
			AT_Initialize (->$at_nombreParciales)
			OB GET ARRAY:C1229($aob_SubAsigObjeto{$i};"aSubEvalNombreParciales";$at_nombreParciales)
			OB SET:C1220($o_nodoPS;"UUID";$at_uuid_SubAsignatura{$i})
			OB SET ARRAY:C1227($o_nodoPS;"aSubEvalNombreParciales";$at_nombreParciales)
			OB SET:C1220($o_nodoPS;"referencia";$at_referenciaSA{$i})
			OB SET:C1220($o_nodoPS;"periodo";$al_periodo{$i})
			OB SET:C1220($o_nodoPS;"nombre";$at_nombreSubAsig{$i})
			APPEND TO ARRAY:C911($ao_SubAsignaturas;$o_nodoPS)
			CLEAR VARIABLE:C89($o_nodoPS)
		End for 
		
		
		OB SET:C1220($o_parametrosAnual;"Anual";$o_temporal)
		OB SET:C1220($o_parametrosEspecifica;"P1";$o_temporal)
		OB SET:C1220($o_parametrosEspecifica;"P2";$o_temporal)
		OB SET:C1220($o_parametrosEspecifica;"P3";$o_temporal)
		OB SET:C1220($o_parametrosEspecifica;"P4";$o_temporal)
		OB SET:C1220($o_parametrosEspecifica;"P5";$o_temporal)
		
		OB SET:C1220($o_opciones;"Consolidacion_PorPeriodo";[Asignaturas:18]Consolidacion_PorPeriodo:58)
		OB SET:C1220($o_opciones;"BloqueoPropEva";$b_blockPropEva)
		OB SET ARRAY:C1227($o_opciones;"periodos";atSTR_Periodos_Nombre)
		OB SET ARRAY:C1227($o_opciones;"aCsdPop";aCsdPop)
		OB SET ARRAY:C1227($o_opciones;"aCsdPopID";aCsdPopID)
		OB SET ARRAY:C1227($o_opciones;"aCsdPopIDText";aCsdPopIDText)
		OB SET ARRAY:C1227($o_opciones;"aRefSubAsignatura";aRefSubAsignatura)
		OB SET:C1220($o_opciones;"Consolidacion_Metodo";[Asignaturas:18]Consolidacion_Metodo:55)
		OB SET:C1220($o_opciones;"Puededesbloquear";$b_puedeBloquear)
		OB SET:C1220($o_opciones;"puedeEditar";$b_puedeEditar)
		OB SET:C1220($o_opciones;"blockOpcionesCalculo";$b_blockOpcionesCalculo)
		OB SET:C1220($o_opciones;"parametrosAnual";$o_parametrosAnual)
		OB SET:C1220($o_opciones;"parametrosEspecifica";$o_parametrosEspecifica)
		OB SET:C1220($o_propiedades;"opciones";$o_opciones)
		
		OB SET:C1220($o_opcionesInit;"Consolidacion_PorPeriodo";False:C215)
		OB SET:C1220($o_opcionesInit;"BloqueoPropEva";$b_blockPropEva)
		OB SET ARRAY:C1227($o_opcionesInit;"periodos";atSTR_Periodos_Nombre)
		OB SET ARRAY:C1227($o_opcionesInit;"aCsdPop";aCsdPop)
		OB SET ARRAY:C1227($o_opcionesInit;"aCsdPopID";aCsdPopID)
		OB SET ARRAY:C1227($o_opcionesInit;"aCsdPopIDText";aCsdPopIDText)
		OB SET ARRAY:C1227($o_opcionesInit;"aRefSubAsignatura";aRefSubAsignatura)
		OB SET:C1220($o_opcionesInit;"Consolidacion_Metodo";[Asignaturas:18]Consolidacion_Metodo:55)
		OB SET:C1220($o_opcionesInit;"Puededesbloquear";$b_puedeBloquear)
		OB SET:C1220($o_opcionesInit;"Consolidacion_PorPeriodo";False:C215)
		OB SET:C1220($o_opcionesInit;"puedeEditar";$b_puedeEditar)
		OB SET:C1220($o_opcionesInit;"blockOpcionesCalculo";False:C215)
		OB SET:C1220($o_opcionesInit;"parametrosAnual";$o_parametrosAnual)
		OB SET:C1220($o_opcionesInit;"parametrosEspecifica";$o_parametrosEspecifica)
		OB SET:C1220($o_jsonIni;"opciones";$o_opcionesInit)
		
		APPEND TO ARRAY:C911($ao_objetos;$o_propiedades)
		APPEND TO ARRAY:C911($ao_objetos;$o_jsonIni)
		APPEND TO ARRAY:C911($ao_objetos;JSON Parse:C1218($t_jsonOriginal))
		OB SET ARRAY:C1227($o_raiz;"propEval";$ao_objetos)
		OB SET ARRAY:C1227($o_raiz;"SA";$ao_SubAsignaturas)
		
		
	: ($t_acccion="initCopia")
		
		If ($userID<0)
			ALL RECORDS:C47([Asignaturas:18])
		Else 
			dhSTWA2_SpecialSearch ("SchoolTrack";->[Asignaturas:18];$profID)
		End if 
		CREATE SET:C116([Asignaturas:18];"$todas")
		KRL_GotoRecord (->[Asignaturas:18];$l_rnAsig;False:C215)
		REMOVE FROM SET:C561([Asignaturas:18];"$todas")
		USE SET:C118("$todas")
		ORDER BY:C49([Asignaturas:18];[Asignaturas:18]Numero_del_Nivel:6;>;[Asignaturas:18]Curso:5;>)
		SELECTION TO ARRAY:C260([Asignaturas:18];$at_recNumAsignatura;[Asignaturas:18]Curso:5;$at_cursoAsignatura;[Asignaturas:18]Asignatura:3;$at_nombreAsignatura;[Asignaturas:18]Numero:1;$at_asignaturasID;[Asignaturas:18]Configuracion:63;$ao_configuracion;*)
		SELECTION TO ARRAY:C260([Asignaturas:18]Consolidacion_Metodo:55;$al_consolidacionMetodo;[Asignaturas:18]Consolidacion_PorPeriodo:58;$ab_porPeriodo;[Asignaturas:18]Numero_del_Nivel:6;$al_nivel;*)
		SELECTION TO ARRAY:C260([Asignaturas:18]Seleccion:17;$esGrupal)
		
		COPY ARRAY:C226($at_cursoAsignatura;$at_cursoFiltrado)
		AT_DistinctsArrayValues (->$at_cursoFiltrado)
		
		  //cargo los periodos de las asignaturas
		C_OBJECT:C1216($o_periodo)
		For ($l_indice;1;Size of array:C274($al_nivel))
			PERIODOS_LoadData ($al_nivel{$l_indice})
			OB SET ARRAY:C1227($o_periodo;"nombre";atSTR_Periodos_Nombre)
			OB SET ARRAY:C1227($o_periodo;"numeroPeriodo";viSTR_Periodos_NumeroPeriodos)
			APPEND TO ARRAY:C911($ao_periodos;$o_periodo)
			CLEAR VARIABLE:C89($o_periodo)
		End for 
		
		
		OB SET ARRAY:C1227($o_raiz;"rnAsig";$at_recNumAsignatura)
		OB SET ARRAY:C1227($o_raiz;"curso";$at_cursoAsignatura)
		OB SET ARRAY:C1227($o_raiz;"nombre";$at_nombreAsignatura)
		OB SET ARRAY:C1227($o_raiz;"id";$at_asignaturasID)
		OB SET ARRAY:C1227($o_raiz;"consolidacionMetodo";$al_consolidacionMetodo)
		OB SET ARRAY:C1227($o_raiz;"configuracion";$ao_configuracion)
		OB SET ARRAY:C1227($o_raiz;"porPeriodo";$ab_porPeriodo)
		OB SET ARRAY:C1227($o_raiz;"cursosFiltrado";$at_cursoFiltrado)
		OB SET ARRAY:C1227($o_raiz;"periodos";$ao_periodos)
		OB SET ARRAY:C1227($o_raiz;"esgrupal";$esGrupal)
		
		
		SET_ClearSets ("$todas")
		
	: ($t_acccion="copiaConfiguracion")
		
		ARRAY LONGINT:C221($alAS_EvalPropSourceID;0)
		ARRAY TEXT:C222($atAS_EvalPropSourceName;0)
		C_OBJECT:C1216($o_detalle;$o_propiedadesCopiar)
		
		$l_rnAsigAcopiar:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"rnAsigAcopiar"))
		KRL_GotoRecord (->[Asignaturas:18];$l_rnAsig;False:C215)
		$l_nivelAsignatura:=[Asignaturas:18]Numero_del_Nivel:6
		
		  //cargo la información de la asignatura a copiar
		KRL_GotoRecord (->[Asignaturas:18];$l_rnAsigAcopiar;False:C215)
		PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
		
		If ([Asignaturas:18]Consolidacion_PorPeriodo:58)
			AS_ReadEvalProperties ("Anual")
			
			For ($l_indice;1;Size of array:C274(alAS_EvalPropSourceID))
				
				If (alAS_EvalPropSourceID{$l_indice}>0)  //asignaturas
					
					QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=alAS_EvalPropSourceID{$l_indice})
					If ([Asignaturas:18]Seleccion:17)
						  //verifico si la asignatura pertenece al nivel de la asignatura donde se copiará 
						If ($l_nivelAsignatura#[Asignaturas:18]Numero_del_Nivel:6)
							alAS_EvalPropSourceID{$l_indice}:=0
							atAS_EvalPropSourceName{$l_indice}:="Evaluación ingresable"
							atAS_EvalPropClassName{$l_indice}:=""
							aiAS_EvalPropEnterable{$l_indice}:=1
							arAS_EvalPropCoefficient{$l_indice}:=1
							atAS_EvalPropPrintName{$l_indice}:=""
							atAS_EvalPropDescription{$l_indice}:=""
							adAS_EvalPropDueDate{$l_indice}:=!00-00-00!
							arAS_EvalPropPonderacion{$l_indice}:=0
						End if 
					Else 
						alAS_EvalPropSourceID{$l_indice}:=0
						atAS_EvalPropSourceName{$l_indice}:="Evaluación ingresable"
						atAS_EvalPropClassName{$l_indice}:=""
						aiAS_EvalPropEnterable{$l_indice}:=1
						arAS_EvalPropCoefficient{$l_indice}:=1
						atAS_EvalPropPrintName{$l_indice}:=""
						atAS_EvalPropDescription{$l_indice}:=""
						adAS_EvalPropDueDate{$l_indice}:=!00-00-00!
						arAS_EvalPropPonderacion{$l_indice}:=0
					End if 
				End if 
			End for 
			
			AS_PropEval_Escritura (0;False:C215)
		Else 
			
			For ($l_periodo;1;viSTR_Periodos_NumeroPeriodos)
				$t_nodo:="P"+String:C10($l_periodo)
				AS_ReadEvalProperties ($t_nodo)
				For ($l_indice;1;Size of array:C274(alAS_EvalPropSourceID))
					
					If (alAS_EvalPropSourceID{$l_indice}>0)  //asignaturas
						
						QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=alAS_EvalPropSourceID{$l_indice})
						If ([Asignaturas:18]Seleccion:17)
							  //verifico si la asignatura pertenece al nivel de la asignatura donde se copiará 
							If ($l_nivelAsignatura#[Asignaturas:18]Numero_del_Nivel:6)
								alAS_EvalPropSourceID{$l_indice}:=0
								atAS_EvalPropSourceName{$l_indice}:="Evaluación ingresable"
								atAS_EvalPropClassName{$l_indice}:=""
								aiAS_EvalPropEnterable{$l_indice}:=1
								arAS_EvalPropCoefficient{$l_indice}:=1
								atAS_EvalPropPrintName{$l_indice}:=""
								atAS_EvalPropDescription{$l_indice}:=""
								adAS_EvalPropDueDate{$l_indice}:=!00-00-00!
								arAS_EvalPropPonderacion{$l_indice}:=0
							End if 
						Else 
							alAS_EvalPropSourceID{$l_indice}:=0
							atAS_EvalPropSourceName{$l_indice}:="Evaluación ingresable"
							atAS_EvalPropClassName{$l_indice}:=""
							aiAS_EvalPropEnterable{$l_indice}:=1
							arAS_EvalPropCoefficient{$l_indice}:=1
							atAS_EvalPropPrintName{$l_indice}:=""
							atAS_EvalPropDescription{$l_indice}:=""
							adAS_EvalPropDueDate{$l_indice}:=!00-00-00!
							arAS_EvalPropPonderacion{$l_indice}:=0
						End if 
					End if 
				End for 
				AS_PropEval_Escritura (0;False:C215)
			End for 
			
		End if 
		
		$o_propiedadesCopiar:=[Asignaturas:18]Configuracion:63
		
		  //asignatura de origen
		KRL_GotoRecord (->[Asignaturas:18];$l_rnAsig;False:C215)
		
End case 

$0:=JSON Stringify:C1217($o_raiz)

