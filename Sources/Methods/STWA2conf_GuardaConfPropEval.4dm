//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda 
  // Fecha y hora: 20-08-18, 19:43:05
  // ----------------------------------------------------
  // Método: STWA2conf_GuardaConfPropEval
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------



C_OBJECT:C1216($o_parametros;$o_nodo;$o_parametrosOpciones;$o_parciales;$o_propiedades;$o_parcialesdatos;$o_respuesta)
C_OBJECT:C1216($o_parametrosSubAsig;$o_propSA;$o_copia)
C_LONGINT:C283($l_iteraciones)
C_BOOLEAN:C305($b_conSubasignaturas;$b_consolida;$b_cancelTrans;$b_bloqueado)
C_BOOLEAN:C305($b_calcularPromedio;$b_cancelTrans;$b_conservar;$b_conservarSub;$b_consolida;$b_ConsolidaPorPeriodo;$b_conSubasignaturas;$b_crearSub)
C_BOOLEAN:C305($b_inicializarTodo;$b_esSubAsignatura;$b_crearSubCopia)
C_BLOB:C604($x_RecNumsArray)

ARRAY LONGINT:C221($alAS_EvalPropSourceID;0)
ARRAY TEXT:C222($atAS_EvalPropSourceName;0)
ARRAY LONGINT:C221($al_RecNumsAsignaturas;0)
ARRAY LONGINT:C221($al_asignaturasRecalculoID;0)
$b_cancelTrans:=False:C215

$y_Names:=$1
$y_Data:=$2

$uuid:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"UUID")
$userID:=STWA2_Session_GetUserSTID ($uuid)
$o_parametros:=JSON Parse:C1218(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"parametros"))
$o_copia:=JSON Parse:C1218(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"copia"))
$b_calcularPromedio:=Choose:C955(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"calcularPromedio")="false";False:C215;True:C214)
$o_propiedades:=OB Get:C1224($o_parametros;"propiedades")
$o_propSA:=OB Get:C1224($o_parametros;"SA")
$l_rnAsig:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"rnAsig"))
$b_conSubasignaturas:=False:C215
$b_consolida:=False:C215

KRL_GotoRecord (->[Asignaturas:18];$l_rnAsig;True:C214)
$l_idMadre:=[Asignaturas:18]Numero:1
$t_asignatura:=[Asignaturas:18]Asignatura:3
$b_validar:=Not:C34(Locked:C147([Asignaturas:18]))


$t_jsonOriginal:=JSON Stringify:C1217([Asignaturas:18]Configuracion:63)
$t_jsonOriginalSTWA:=JSON Stringify:C1217($o_copia)

$t_diggestOriginal:=Generate digest:C1147($t_jsonOriginal;MD5 digest:K66:1)
$t_diggestSTWA:=Generate digest:C1147($t_jsonOriginalSTWA;MD5 digest:K66:1)

$b_validar:=$b_validar & ($t_diggestOriginal=$t_diggestSTWA)

$b_registroEditado:=($t_diggestOriginal#$t_diggestSTWA)
$b_registrorTomado:=Locked:C147([Asignaturas:18])

START TRANSACTION:C239
If ($b_validar)
	
	  //realizo por periodo
	
	$o_opciones:=OB Get:C1224($o_propiedades;"opciones")
	$b_crearSubCopia:=OB Get:C1224($o_opciones;"crearSubCopia";Is boolean:K8:9)
	$b_ConsolidaPorPeriodo:=OB Get:C1224($o_opciones;"Consolidacion_PorPeriodo";Is boolean:K8:9)
	$b_inicializarTodo:=OB Get:C1224($o_opciones;"inicializarTodo";Is boolean:K8:9)
	$b_conservarSub:=OB Get:C1224($o_opciones;"conservarSub";Is boolean:K8:9)
	vb_CsdVariable:=$b_ConsolidaPorPeriodo
	
	If ($b_inicializarTodo)
		$cancelTrans:=AScsd_DesconectaHijas_TODAS ([Asignaturas:18]Numero:1;Not:C34($b_conservarSub))
		Log_RegisterEvtSTW ("Propiedades de evaluación: Inicialización de configuración para la asignatura "+$t_asignatura;$userID)
	Else 
		If ($b_ConsolidaPorPeriodo)
			If ($b_conservarSub)
				QUERY:C277([xxSTR_Subasignaturas:83];[xxSTR_Subasignaturas:83]ID_Mother:6=$l_idMadre)
				LONGINT ARRAY FROM SELECTION:C647([xxSTR_Subasignaturas:83];$al_RecNumSubasignaturas;"")
				For ($i_subasignaturas;1;Size of array:C274($al_RecNumSubasignaturas))
					KRL_GotoRecord (->[xxSTR_Subasignaturas:83];$al_RecNumSubasignaturas{$i_subasignaturas};True:C214)
					If (OK=1)
						[xxSTR_Subasignaturas:83]Columna:13:=0
						SAVE RECORD:C53([xxSTR_Subasignaturas:83])
					Else 
						$i_subasignaturas:=Size of array:C274($al_RecNumSubasignaturas)
						$b_cancelTrans:=True:C214
					End if 
				End for 
				KRL_UnloadReadOnly (->[xxSTR_Subasignaturas:83])
			End if 
		End if 
	End if 
	
	If ($b_ConsolidaPorPeriodo)
		PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
		For ($l_iPeriodo;1;viSTR_Periodos_NumeroPeriodos)
			CLEAR VARIABLE:C89($o_respuesta)
			$t_nodo:="P"+String:C10($l_iPeriodo)
			$o_nodo:=OB Get:C1224($o_propiedades;$t_nodo)
			OB GET ARRAY:C1229($o_nodo;"SourceID";$alAS_EvalPropSourceID)
			OB GET ARRAY:C1229($o_nodo;"SourceName";$atAS_EvalPropSourceName)
			AS_ReadEvalProperties ($t_nodo)
			For ($l_iSource;1;Size of array:C274($alAS_EvalPropSourceID))
				  //desconecto la asignatura si corresponde
				If (alAS_EvalPropSourceID{$l_iSource}#$alAS_EvalPropSourceID{$l_iSource})
					If (alAS_EvalPropSourceID{$l_iSource}>0)
						If ([Asignaturas:18]Consolidacion_PorPeriodo:58)
							vb_CsdVariable:=True:C214
							AScsd_DesconectaHija_UNA (alAS_EvalPropSourceID{$l_iSource};$l_iPeriodo;$l_iSource;$l_idMadre)
							Log_RegisterEvtSTW ("Propiedades de evaluación: Se elimina relación de consolidación de la asignatura "+$t_asignatura+" ID SchoolTrack: "+String:C10($l_idMadre)+" para el período : "+atSTR_Periodos_Nombre{$l_iPeriodo};$userID)
						Else 
							vb_CsdVariable:=False:C215
							AScsd_DesconectaHija_UNA (alAS_EvalPropSourceID{$l_iSource};$l_iPeriodo;$l_iSource;$l_idMadre)
							Log_RegisterEvtSTW ("Propiedades de evaluación: Se elimina relación de consolidación de la asignatura "+$t_asignatura+" ID SchoolTrack: "+String:C10($l_idMadre);$userID)
						End if 
					End if 
				End if 
				If ($alAS_EvalPropSourceID{$l_iSource}>0)
					APPEND TO ARRAY:C911($al_asignaturasRecalculoID;$alAS_EvalPropSourceID{$l_iSource})
					vb_CsdVariable:=True:C214
					AScsd_AsignaAsignaturaHija ($l_idMadre;$atAS_EvalPropSourceName{$l_iSource};$alAS_EvalPropSourceID{$l_iSource};$l_iSource;String:C10($l_iPeriodo))
					Log_RegisterEvtSTW ("Propiedades de evaluación: Se crea relación de consolidación de la asignatura "+$t_asignatura+" ID SchoolTrack: "+String:C10($l_idMadre)+" para el período : "+atSTR_Periodos_Nombre{$l_iPeriodo};$userID)
					$b_consolida:=True:C214
				End if 
			End for 
		End for 
		
	Else 
		CLEAR VARIABLE:C89($o_respuesta)
		$t_nodo:="Anual"
		$o_nodo:=OB Get:C1224($o_propiedades;$t_nodo)
		OB GET ARRAY:C1229($o_nodo;"SourceID";$alAS_EvalPropSourceID)
		OB GET ARRAY:C1229($o_nodo;"SourceName";$atAS_EvalPropSourceName)
		AS_ReadEvalProperties ($t_nodo)
		For ($l_iSource;1;Size of array:C274($alAS_EvalPropSourceID))
			  //desconecto la asignatura si corresponde
			If (alAS_EvalPropSourceID{$l_iSource}#$alAS_EvalPropSourceID{$l_iSource})
				If (alAS_EvalPropSourceID{$l_iSource}>0)
					If ([Asignaturas:18]Consolidacion_PorPeriodo:58)
						vb_CsdVariable:=True:C214
						AScsd_DesconectaHija_UNA (alAS_EvalPropSourceID{$l_iSource};$l_iPeriodo;$l_iSource;$l_idMadre)
						Log_RegisterEvtSTW ("Propiedades de evaluación: Se elimina relación de consolidación de la asignatura "+$t_asignatura+" ID SchoolTrack: "+String:C10($l_idMadre);$userID)
					Else 
						vb_CsdVariable:=False:C215
						AScsd_DesconectaHija_UNA (alAS_EvalPropSourceID{$l_iSource};$l_iPeriodo;$l_iSource;$l_idMadre)
						Log_RegisterEvtSTW ("Propiedades de evaluación: Se elimina relación de consolidación de la asignatura "+$t_asignatura+" ID SchoolTrack: "+String:C10($l_idMadre);$userID)
					End if 
				End if 
			End if 
			If ($alAS_EvalPropSourceID{$l_iSource}>0)
				APPEND TO ARRAY:C911($al_asignaturasRecalculoID;$alAS_EvalPropSourceID{$l_iSource})
				vb_CsdVariable:=False:C215
				AScsd_AsignaAsignaturaHija ($l_idMadre;$atAS_EvalPropSourceName{$l_iSource};$alAS_EvalPropSourceID{$l_iSource};$l_iSource)
				Log_RegisterEvtSTW ("Propiedades de evaluación: Se crea relación de consolidación de la asignatura "+$t_asignatura+" ID SchoolTrack: "+String:C10($l_idMadre);$userID)
			End if 
		End for 
		
	End if 
	
	
	  //Código para el manejo de las subasignaturas
	If ($b_ConsolidaPorPeriodo)
		PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
		
		For ($l_iPeriodo;1;viSTR_Periodos_NumeroPeriodos)
			$t_nodo:="P"+String:C10($l_iPeriodo)
			$o_nodo:=OB Get:C1224($o_propiedades;$t_nodo)
			$o_parametrosOpciones:=OB Get:C1224($o_opciones;"parametrosEspecifica")
			$o_parciales:=OB Get:C1224($o_parametrosOpciones;$t_nodo)
			
			OB GET ARRAY:C1229($o_nodo;"SourceID";$alAS_EvalPropSourceID)
			OB GET ARRAY:C1229($o_nodo;"SourceName";$atAS_EvalPropSourceName)
			
			If (Not:C34(OB Is empty:C1297($o_parciales)))
				For ($l_iParcial;1;12)
					$t_nodoParcial:="parcial-"+String:C10($l_iParcial)
					$o_parcialesdatos:=OB Get:C1224($o_parciales;$t_nodoParcial)
					
					$o_eliminarSub:=OB Get:C1224($o_parcialesdatos;"eliminarSub")
					$b_conservar:=OB Get:C1224($o_eliminarSub;"conservar")
					$l_idSub:=OB Get:C1224($o_eliminarSub;"idSub")
					$b_crearSub:=OB Get:C1224($o_parcialesdatos;"crearSub")
					$t_nombreSub:=OB Get:C1224($o_parcialesdatos;"aCsdPop")
					$l_ID:=OB Get:C1224($o_parcialesdatos;"aCsdPopID";Is longint:K8:6)
					$b_esSubAsignatura:=OB Get:C1224($o_parcialesdatos;"esSubAsignatura";Is boolean:K8:9)
					
					If (($b_esSubAsignatura) | ($l_idSub#0))
						
						OB SET:C1220($o_parametrosSubAsig;"madreID";$l_idMadre)
						OB SET:C1220($o_parametrosSubAsig;"nombre";$t_nombreSub)
						OB SET:C1220($o_parametrosSubAsig;"Anual";False:C215)
						OB SET:C1220($o_parametrosSubAsig;"columna";$l_iParcial)
						OB SET:C1220($o_parametrosSubAsig;"periodo";$l_iPeriodo)
						
						Case of 
								
							: (($b_crearSub) & (Not:C34($b_conservar)))
								$o_respuesta:=AS_ManejaRegistrosSubAsignatura ("eliminar";$o_parametrosSubAsig)
								$o_respuesta:=AS_ManejaRegistrosSubAsignatura ("crear";$o_parametrosSubAsig)
								$b_validar:=OB Get:C1224($o_respuesta;"TransValida";Is boolean:K8:9)
								$alAS_EvalPropSourceID{$l_iParcial}:=OB Get:C1224($o_respuesta;"LongID";Is longint:K8:6)
								OB SET ARRAY:C1227($o_nodo;"SourceID";$alAS_EvalPropSourceID)
								$b_conSubasignaturas:=True:C214
								Log_RegisterEvtSTW ("Propiedades de evaluación: Creación de sub-asignatura: "+$t_nombreSub+" en la asignatura "+$t_asignatura+" ID SchoolTrack: "+String:C10($l_idMadre);$userID)
								
							: (($b_crearSub) & ($b_conservar))
								$o_respuesta:=AS_ManejaRegistrosSubAsignatura ("conservar";$o_parametrosSubAsig)
								$o_respuesta:=AS_ManejaRegistrosSubAsignatura ("crear";$o_parametrosSubAsig)
								$b_validar:=OB Get:C1224($o_respuesta;"TransValida";Is boolean:K8:9)
								$alAS_EvalPropSourceID{$l_iParcial}:=OB Get:C1224($o_respuesta;"LongID";Is longint:K8:6)
								OB SET ARRAY:C1227($o_nodo;"SourceID";$alAS_EvalPropSourceID)
								$b_conSubasignaturas:=True:C214
								Log_RegisterEvtSTW ("Propiedades de evaluación: Creación de sub-asignatura: "+$t_nombreSub+" en la asignatura "+$t_asignatura+" ID SchoolTrack: "+String:C10($l_idMadre);$userID)
								
							: (($b_crearSub) & (Not:C34($b_conservar)) & ($l_idSub#0))
								$t_referencia:=String:C10($l_idMadre)+"."+String:C10($l_periodo)+"."+String:C10($l_columna)
								QUERY:C277([xxSTR_Subasignaturas:83];[xxSTR_Subasignaturas:83]Referencia:11=$t_referencia)
								Log_RegisterEvtSTW ("Propiedades de evaluación: Eliminación de sub-asignatura: "+[xxSTR_Subasignaturas:83]Name:2+" en la asignatura "+$t_asignatura+" ID SchoolTrack: "+String:C10($l_idMadre);$userID)
								
								$o_respuesta:=AS_ManejaRegistrosSubAsignatura ("eliminar";$o_parametrosSubAsig)
								$o_respuesta:=AS_ManejaRegistrosSubAsignatura ("crear";$o_parametrosSubAsig)
								$b_validar:=OB Get:C1224($o_respuesta;"TransValida";Is boolean:K8:9)
								$alAS_EvalPropSourceID{$l_iParcial}:=OB Get:C1224($o_respuesta;"LongID";Is longint:K8:6)
								OB SET ARRAY:C1227($o_nodo;"SourceID";$alAS_EvalPropSourceID)
								$b_conSubasignaturas:=True:C214
								Log_RegisterEvtSTW ("Propiedades de evaluación: Creación de sub-asignatura: "+$t_nombreSub+" en la asignatura "+$t_asignatura+" ID SchoolTrack: "+String:C10($l_idMadre);$userID)
								
							: ($l_ID<0)
								$o_respuesta:=AS_ManejaRegistrosSubAsignatura ("asigna";$o_parametrosSubAsig)
								Log_RegisterEvtSTW ("Propiedades de evaluación: asignación de sub-asignatura: "+$t_nombreSub+" en la asignatura "+$t_asignatura+" ID SchoolTrack: "+String:C10($l_idMadre);$userID)
								
							: ((Not:C34($b_crearSub)) & (Not:C34($b_conservar)) & ($l_idSub#0))
								$o_respuesta:=AS_ManejaRegistrosSubAsignatura ("eliminar";$o_parametrosSubAsig)
								$b_validar:=OB Get:C1224($o_respuesta;"TransValida";Is boolean:K8:9)
								
							Else 
								If ($b_conservar)
									$o_respuesta:=AS_ManejaRegistrosSubAsignatura ("conservar";$o_parametrosSubAsig)
								End if 
						End case 
						$b_cancelTrans:=Not:C34(OB Get:C1224($o_respuesta;"TransValida";Is boolean:K8:9))
						If ($b_cancelTrans)
							$l_iPeriodo:=viSTR_Periodos_NumeroPeriodos+1
							$l_iParcial:=13
						End if 
					End if 
				End for 
				
			End if 
			
		End for 
		
	Else 
		$t_nodo:="Anual"
		$o_parametrosOpciones:=OB Get:C1224($o_opciones;"parametrosAnual")
		$o_parciales:=OB Get:C1224($o_parametrosOpciones;$t_nodo)
		
		$o_nodo:=OB Get:C1224($o_propiedades;$t_nodo)
		OB GET ARRAY:C1229($o_nodo;"SourceID";$alAS_EvalPropSourceID)
		OB GET ARRAY:C1229($o_nodo;"SourceName";$atAS_EvalPropSourceName)
		
		If (Not:C34(OB Is empty:C1297($o_parciales)))
			For ($l_iParcial;1;12)
				$t_nodoParcial:="parcial-"+String:C10($l_iParcial)
				$o_parcialesdatos:=OB Get:C1224($o_parciales;$t_nodoParcial)
				
				$o_eliminarSub:=OB Get:C1224($o_parcialesdatos;"eliminarSub")
				$b_conservar:=OB Get:C1224($o_eliminarSub;"conservar")
				$l_idSub:=OB Get:C1224($o_eliminarSub;"idSub")
				$b_crearSub:=OB Get:C1224($o_parcialesdatos;"crearSub")
				$t_nombreSub:=OB Get:C1224($o_parcialesdatos;"aCsdPop")
				$l_ID:=OB Get:C1224($o_parcialesdatos;"aCsdPopID";Is longint:K8:6)
				$b_esSubAsignatura:=OB Get:C1224($o_parcialesdatos;"esSubAsignatura";Is boolean:K8:9)
				
				If (($b_esSubAsignatura) | ($l_idSub#0))
					OB SET:C1220($o_parametrosSubAsig;"madreID";$l_idMadre)
					OB SET:C1220($o_parametrosSubAsig;"nombre";$t_nombreSub)
					OB SET:C1220($o_parametrosSubAsig;"Anual";True:C214)
					OB SET:C1220($o_parametrosSubAsig;"columna";$l_iParcial)
					OB SET:C1220($o_parametrosSubAsig;"periodo";-1)
					
					Case of 
							
						: (($b_crearSub) & ($b_conservar))
							$o_respuesta:=AS_ManejaRegistrosSubAsignatura ("conservar";$o_parametrosSubAsig)
							$o_respuesta:=AS_ManejaRegistrosSubAsignatura ("crear";$o_parametrosSubAsig)
							$b_validar:=OB Get:C1224($o_respuesta;"TransValida";Is boolean:K8:9)
							$alAS_EvalPropSourceID{$l_iParcial}:=OB Get:C1224($o_respuesta;"LongID";Is longint:K8:6)
							OB SET ARRAY:C1227($o_nodo;"SourceID";$alAS_EvalPropSourceID)
							$b_conSubasignaturas:=True:C214
							Log_RegisterEvtSTW ("Propiedades de evaluación: Creación de sub-asignatura: "+$t_nombreSub+" en la asignatura "+$t_asignatura+" ID SchoolTrack: "+String:C10($l_idMadre);$userID)
							
						: (($b_crearSub) & (Not:C34($b_conservar)) & ($l_idSub#0))
							$t_referencia:=String:C10($l_idMadre)+"."+String:C10($l_periodo)+"."+String:C10($l_columna)
							QUERY:C277([xxSTR_Subasignaturas:83];[xxSTR_Subasignaturas:83]Referencia:11=$t_referencia)
							Log_RegisterEvtSTW ("Propiedades de evaluación: Eliminación de sub-asignatura: "+[xxSTR_Subasignaturas:83]Name:2+" en la asignatura "+$t_asignatura+" ID SchoolTrack: "+String:C10($l_idMadre);$userID)
							
							$o_respuesta:=AS_ManejaRegistrosSubAsignatura ("eliminar";$o_parametrosSubAsig)
							$o_respuesta:=AS_ManejaRegistrosSubAsignatura ("crear";$o_parametrosSubAsig)
							$b_validar:=OB Get:C1224($o_respuesta;"TransValida";Is boolean:K8:9)
							$alAS_EvalPropSourceID{$l_iParcial}:=OB Get:C1224($o_respuesta;"LongID";Is longint:K8:6)
							OB SET ARRAY:C1227($o_nodo;"SourceID";$alAS_EvalPropSourceID)
							$b_conSubasignaturas:=True:C214
							Log_RegisterEvtSTW ("Propiedades de evaluación: Creación de sub-asignatura: "+$t_nombreSub+" en la asignatura "+$t_asignatura+" ID SchoolTrack: "+String:C10($l_idMadre);$userID)
							
						: (($b_crearSub) & (Not:C34($b_conservar)))
							$o_respuesta:=AS_ManejaRegistrosSubAsignatura ("eliminar";$o_parametrosSubAsig)
							$o_respuesta:=AS_ManejaRegistrosSubAsignatura ("crear";$o_parametrosSubAsig)
							$b_validar:=OB Get:C1224($o_respuesta;"TransValida";Is boolean:K8:9)
							$alAS_EvalPropSourceID{$l_iParcial}:=OB Get:C1224($o_respuesta;"LongID";Is longint:K8:6)
							OB SET ARRAY:C1227($o_nodo;"SourceID";$alAS_EvalPropSourceID)
							$b_conSubasignaturas:=True:C214
							Log_RegisterEvtSTW ("Propiedades de evaluación: Creación de sub-asignatura: "+$t_nombreSub+" en la asignatura "+$t_asignatura+" ID SchoolTrack: "+String:C10($l_idMadre);$userID)
						: ($l_ID<0)
							$o_respuesta:=AS_ManejaRegistrosSubAsignatura ("asigna";$o_parametrosSubAsig)
							Log_RegisterEvtSTW ("Propiedades de evaluación: asignación de sub-asignatura: "+$t_nombreSub+" en la asignatura "+$t_asignatura+" ID SchoolTrack: "+String:C10($l_idMadre);$userID)
							
						: ((Not:C34($b_crearSub)) & (Not:C34($b_conservar)) & ($l_idSub#0))
							$o_respuesta:=AS_ManejaRegistrosSubAsignatura ("eliminar";$o_parametrosSubAsig)
							$b_validar:=OB Get:C1224($o_respuesta;"TransValida";Is boolean:K8:9)
						Else 
							If ($b_conservar)
								$o_respuesta:=AS_ManejaRegistrosSubAsignatura ("conservar";$o_parametrosSubAsig)
							End if 
					End case 
					$b_cancelTrans:=Not:C34(OB Get:C1224($o_respuesta;"TransValida";Is boolean:K8:9))
					If ($b_cancelTrans)
						$l_iParcial:=13
					End if 
				End if 
			End for 
		End if 
	End if 
	
End if 

If (($b_validar) & ($b_cancelTrans=False:C215))
	
	KRL_GotoRecord (->[Asignaturas:18];$l_rnAsig;True:C214)
	
	$l_calculado:=OB Get:C1224($o_opciones;"Calculado";Is longint:K8:6)
	$l_sinAprox:=OB Get:C1224($o_opciones;"sinAproximacion";Is longint:K8:6)
	$l_promediarTodas:=OB Get:C1224($o_opciones;"promediarTodas";Is longint:K8:6)
	$b_ConsolidaPorPeriodo:=OB Get:C1224($o_opciones;"Consolidacion_PorPeriodo";Is boolean:K8:9)
	$l_CalcMethod:=OB Get:C1224($o_opciones;"CalcMethod";Is longint:K8:6)
	$b_bloqueado:=OB Get:C1224($o_opciones;"bloqueado";Is boolean:K8:9)
	
	[Asignaturas:18]Consolidacion_TipoPonderacion:50:=$l_CalcMethod
	[Asignaturas:18]Consolidacion_EsConsolidante:35:=((Size of array:C274($al_asignaturasRecalculoID)>0) | $b_consolida | $b_conSubasignaturas)
	[Asignaturas:18]Consolidacion_ConSubasignaturas:31:=$b_conSubasignaturas
	[Asignaturas:18]Consolidacion_PorPeriodo:58:=$b_ConsolidaPorPeriodo
	
	Case of 
		: ($l_calculado=1)
			[Asignaturas:18]Consolidacion_Metodo:55:=0
		: ($l_sinAprox=1)
			[Asignaturas:18]Consolidacion_Metodo:55:=1
		: ($l_promediarTodas=1)
			[Asignaturas:18]Consolidacion_Metodo:55:=2
			[Asignaturas:18]Consolidacion_TipoPonderacion:50:=0
	End case 
	
	
	OB SET:C1220([Asignaturas:18]Opciones:57;"BloqueoPropDeEval";$b_bloqueado)
	OB REMOVE:C1226($o_propiedades;"opciones")
	
	[Asignaturas:18]Configuracion:63:=$o_propiedades
	SAVE RECORD:C53([Asignaturas:18])
	
	
	BLOB_Variables2Blob (->$x_RecNumsArray;0;->$al_RecNumsAsignaturas)
	
	  //guardo las subasignaturas
	
	If ($b_crearSubCopia)
		KRL_GotoRecord (->[Asignaturas:18];$l_rnAsig;True:C214)
		
		If ([Asignaturas:18]Consolidacion_PorPeriodo:58)
			For ($l_periodo;1;viSTR_Periodos_NumeroPeriodos)
				$t_nodo:="P"+String:C10($l_periodo)
				$o_nodo:=OB Get:C1224($o_propiedades;$t_nodo)
				OB GET ARRAY:C1229($o_nodo;"SourceID";$alAS_EvalPropSourceID)
				OB GET ARRAY:C1229($o_nodo;"SourceName";$atAS_EvalPropSourceName)
				For ($l_propID;1;Size of array:C274($alAS_EvalPropSourceID))
					If ($alAS_EvalPropSourceID{$l_propID}<0)
						$l_columna:=$l_propID
						OB SET:C1220($o_parametrosSubAsig;"madreID";[Asignaturas:18]Numero:1)
						OB SET:C1220($o_parametrosSubAsig;"nombre";$atAS_EvalPropSourceName{$l_propID})
						OB SET:C1220($o_parametrosSubAsig;"Anual";False:C215)
						OB SET:C1220($o_parametrosSubAsig;"columna";$l_columna)
						OB SET:C1220($o_parametrosSubAsig;"periodo";$l_periodo)
						$o_respuesta:=AS_ManejaRegistrosSubAsignatura ("crear";$o_parametrosSubAsig)
						$alAS_EvalPropSourceID{$l_propID}:=OB Get:C1224($o_respuesta;"LongID";Is longint:K8:6)
						Log_RegisterEvtSTW ("Propiedades de evaluación: Creación de sub-asignatura: "+$atAS_EvalPropSourceName{$l_propID}+" en la asignatura "+$t_asignatura+" ID SchoolTrack: "+String:C10($l_idMadre);$userID)
					End if 
				End for 
				OB SET ARRAY:C1227($o_nodo;"SourceID";$alAS_EvalPropSourceID)
			End for 
		Else 
			$t_nodo:="Anual"
			$o_nodo:=OB Get:C1224($o_propiedades;$t_nodo)
			OB GET ARRAY:C1229($o_nodo;"SourceID";$alAS_EvalPropSourceID)
			OB GET ARRAY:C1229($o_nodo;"SourceName";$atAS_EvalPropSourceName)
			For ($l_propID;1;Size of array:C274($alAS_EvalPropSourceID))
				If ($alAS_EvalPropSourceID{$l_propID}<0)
					$l_columna:=$l_propID
					OB SET:C1220($o_parametrosSubAsig;"madreID";[Asignaturas:18]Numero:1)
					OB SET:C1220($o_parametrosSubAsig;"nombre";$atAS_EvalPropSourceName{$l_propID})
					OB SET:C1220($o_parametrosSubAsig;"Anual";True:C214)
					OB SET:C1220($o_parametrosSubAsig;"columna";$l_columna)
					OB SET:C1220($o_parametrosSubAsig;"periodo";-1)
					$o_respuesta:=AS_ManejaRegistrosSubAsignatura ("crear";$o_parametrosSubAsig)
					$alAS_EvalPropSourceID{$l_propID}:=OB Get:C1224($o_respuesta;"LongID";Is longint:K8:6)
					Log_RegisterEvtSTW ("Propiedades de evaluación: Creación de sub-asignatura: "+$atAS_EvalPropSourceName{$l_propID}+" en la asignatura "+$t_asignatura+" ID SchoolTrack: "+String:C10($l_idMadre);$userID)
				End if 
			End for 
			OB SET ARRAY:C1227($o_nodo;"SourceID";$alAS_EvalPropSourceID)
		End if 
		
		[Asignaturas:18]Configuracion:63:=$o_propiedades
		SAVE RECORD:C53([Asignaturas:18])
		
	Else 
		KRL_GotoRecord (->[Asignaturas:18];$l_rnAsig;False:C215)
		READ WRITE:C146([xxSTR_Subasignaturas:83])
		C_OBJECT:C1216($o_temporal)
		ARRAY TEXT:C222($at_propiedades;0)
		ARRAY TEXT:C222($at_parciales;0)
		OB GET PROPERTY NAMES:C1232($o_propSA;$at_propiedades)
		C_TEXT:C284($t_nombre;$t_referencia)
		
		For ($l_indice;1;Size of array:C274($at_propiedades))
			$o_temporal:=OB Get:C1224($o_propSA;$at_propiedades{$l_indice})
			$t_uuid:=OB Get:C1224($o_temporal;"UUID")
			If ($t_uuid#"")
				OB GET ARRAY:C1229($o_temporal;"aSubEvalNombreParciales";$at_parciales)
				For ($l_indiceP;1;Size of array:C274($at_parciales))
					$t_valor:=Replace string:C233($at_parciales{$l_indiceP};" ";"")
					If ($t_valor="")
						$at_parciales{$l_indiceP}:="Parcial "+String:C10($l_indiceP)
					End if 
				End for 
				QUERY:C277([xxSTR_Subasignaturas:83];[xxSTR_Subasignaturas:83]Auto_UUID:20=$t_uuid)
				OB SET ARRAY:C1227([xxSTR_Subasignaturas:83]o_Data:21;"aSubEvalNombreParciales";$at_parciales)
				SAVE RECORD:C53([xxSTR_Subasignaturas:83])
				Log_RegisterEvtSTW ("Propiedades de evaluación: Se realizan cambios en los nombres de parciales de sub-asignatura "+[xxSTR_Subasignaturas:83]Name:2;$userID)
			Else 
				$t_referencia:=OB Get:C1224($o_temporal;"referencia")
				$t_nombre:=OB Get:C1224($o_temporal;"nombre")
				$t_referencia:=Replace string:C233($t_referencia;"0";String:C10([Asignaturas:18]Numero:1))
				OB GET ARRAY:C1229($o_temporal;"aSubEvalNombreParciales";$at_parciales)
				For ($l_indiceP;1;Size of array:C274($at_parciales))
					$t_valor:=Replace string:C233($at_parciales{$l_indiceP};" ";"")
					If ($t_valor="")
						$at_parciales{$l_indiceP}:="Parcial "+String:C10($l_indiceP)
					End if 
				End for 
				QUERY:C277([xxSTR_Subasignaturas:83];[xxSTR_Subasignaturas:83]Referencia:11=$t_referencia;*)
				QUERY:C277([xxSTR_Subasignaturas:83]; & ;[xxSTR_Subasignaturas:83]Name:2=$t_nombre)
				If (Records in selection:C76([xxSTR_Subasignaturas:83])>0)
					OB SET ARRAY:C1227([xxSTR_Subasignaturas:83]o_Data:21;"aSubEvalNombreParciales";$at_parciales)
					SAVE RECORD:C53([xxSTR_Subasignaturas:83])
					Log_RegisterEvtSTW ("Propiedades de evaluación: Se realizan cambios en los nombres de parciales de sub-asignatura "+[xxSTR_Subasignaturas:83]Name:2;$userID)
				End if 
			End if 
			CLEAR VARIABLE:C89($o_temporal)
		End for 
	End if 
	
	If ($b_calcularPromedio)
		APPEND TO ARRAY:C911($al_RecNumsAsignaturas;$l_rnAsig)
		BLOB_Variables2Blob (->$x_RecNumsArray;0;->$al_RecNumsAsignaturas)
		EV2dbu_Recalculos ($x_RecNumsArray;False:C215)
	End if 
	
	AS_FijaNivelJeraquicoHijas ($l_rnAsig)
	AS_AbstractoConfiguracion ($l_idMadre)
	
	KRL_UnloadReadOnly (->[xxSTR_Subasignaturas:83])
	KRL_UnloadReadOnly (->[Asignaturas:18])
	OB SET:C1220($o_respuesta;"estado";True:C214)
	
	
	VALIDATE TRANSACTION:C240
Else 
	CANCEL TRANSACTION:C241
	OB SET:C1220($o_respuesta;"estado";False:C215)
	OB SET:C1220($o_respuesta;"RegistroEditado";$b_registroEditado)
	OB SET:C1220($o_respuesta;"RegistroTomado";$b_registrorTomado)
	OB SET:C1220($o_respuesta;"problemaSub";True:C214)
End if 
$0:=$o_respuesta
