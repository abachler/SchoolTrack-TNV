//%attributes = {}
  // ACTcc_OpcionesDctos()
  //
  //
  // modificado por: Alberto Bachler Klein: 26-12-16, 16:53:57
  // -----------------------------------------------------------
C_TEXT:C284($0)
C_TEXT:C284($1)
C_POINTER:C301(${2})

C_LONGINT:C283($l_cuantos;$l_id;$l_idAl;$l_indice;$l_pos;$l_recs;$l_refItem;$l_resp)
C_POINTER:C301($y_pointer1;$y_pointer2)
C_REAL:C285($r_sumaDescuentos)
C_TEXT:C284($t_accion;$t_alumno;$t_creaOActualiza;$t_ids;$t_nombreDcto;$t_nomDcto;$t_retorno)

ARRAY LONGINT:C221($alACT_idsActivos;0)
ARRAY LONGINT:C221($alACT_idsCargosAEliminarF;0)
ARRAY LONGINT:C221($alACT_posActivos;0)
ARRAY LONGINT:C221($alACT_posFinales;0)
ARRAY LONGINT:C221($alACT_posTipoDcto;0)



If (False:C215)
	C_TEXT:C284(ACTcc_OpcionesDctos ;$0)
	C_TEXT:C284(ACTcc_OpcionesDctos ;$1)
	C_POINTER:C301(ACTcc_OpcionesDctos ;${2})
End if 

$t_accion:=$1

If (Count parameters:C259>=2)
	$y_pointer1:=$2
End if 
If (Count parameters:C259>=3)
	$y_pointer2:=$3
End if 

Case of 
	: ($t_accion="DeclaraArreglos")
		ARRAY TEXT:C222(atACT_PeriodoT;0)
		ARRAY TEXT:C222(atACT_DescuentosT;0)
		ARRAY REAL:C219(arACT_DescuentosT;0)
		ARRAY BOOLEAN:C223(abACT_InactivosT;0)
		ARRAY LONGINT:C221(alACT_DescuentosIdsT;0)
		ARRAY LONGINT:C221(alACT_DescuentosIdsCFG_T;0)
		
		ARRAY LONGINT:C221(alACT_idsEliminados;0)
		
	: ($t_accion="DeclaraArreglosResumen")
		ARRAY TEXT:C222(atACT_Descuentos;0)
		ARRAY REAL:C219(arACT_Descuentos;0)
		
	: ($t_accion="CargaResumen")
		ACTcc_OpcionesDctos ("DeclaraArreglosResumen")
		abACT_InactivosT{0}:=False:C215
		AT_SearchArray (->abACT_InactivosT;"=";->$alACT_idsActivos)
		For ($l_indice;1;Size of array:C274($alACT_idsActivos))
			APPEND TO ARRAY:C911(atACT_Descuentos;atACT_DescuentosT{$alACT_idsActivos{$l_indice}})
			APPEND TO ARRAY:C911(arACT_Descuentos;arACT_DescuentosT{$alACT_idsActivos{$l_indice}})
		End for 
		
	: ($t_accion="OnLoadingCtaCte")
		ACTcc_OpcionesDctos ("DeclaraArreglos")
		ACTdctos_OnRecordLoad ($y_pointer1->;True:C214;->arACT_DescuentosT;->atACT_DescuentosT;->atACT_PeriodoT;->abACT_InactivosT;->alACT_DescuentosIdsT;->alACT_DescuentosIdsCFG_T)
		
		ACTcc_OpcionesDctos ("CargaResumen")
		
	: ($t_accion="ObtieneSumaDescuentos")
		
		$y_pointer1->{0}:=False:C215
		AT_SearchArray ($y_pointer1;"=";->$alACT_posActivos)
		
		$r_sumaDescuentos:=0
		For ($l_indice;1;Size of array:C274($alACT_posActivos))
			$r_sumaDescuentos:=$r_sumaDescuentos+$y_pointer2->{$alACT_posActivos{$l_indice}}
		End for 
		$t_retorno:=String:C10($r_sumaDescuentos)
		
	: ($t_accion="InsertaDescuento")
		$r_sumaDescuentos:=Num:C11(ACTcc_OpcionesDctos ("ObtieneSumaDescuentos";->abACT_InactivosT;->arACT_DescuentosT))
		$l_cuantos:=Count in array:C907(abACT_InactivosT;False:C215)
		If ($r_sumaDescuentos<100)
			
			If (($l_cuantos<lACTcfgdctos_maximoDescuento) | (lACTcfgdctos_maximoDescuento=0))
				
				$l_id:=Num:C11(ACTcfg_OpcionesDescuentos ("SeleccionaDescuento"))
				
				If ($l_id#0)
					
					abACT_InactivosT{0}:=False:C215
					AT_SearchArray (->abACT_InactivosT;"=";->$alACT_posActivos)
					alACT_DescuentosIdsCFG_T{0}:=$l_id
					AT_SearchArray (->alACT_DescuentosIdsCFG_T;"=";->$alACT_posTipoDcto)
					AT_intersect (->$alACT_posActivos;->$alACT_posTipoDcto;->$alACT_posFinales)
					
					$t_nombreDcto:=ACTcfg_OpcionesDescuentos ("ObtieneNombreXid";->$l_id)
					
					If (Size of array:C274($alACT_posFinales)=0)
						$l_pos:=Size of array:C274(atACT_PeriodoT)+1
						LISTBOX INSERT ROWS:C913(lb_descuentosTodos;$l_pos)
						atACT_PeriodoT{$l_pos}:=<>GNOMBREAGNOESCOLAR
						alACT_DescuentosIdsCFG_T{$l_pos}:=$l_id
						atACT_DescuentosT{$l_pos}:=$t_nombreDcto
						EDIT ITEM:C870(*;"arACT_DescuentosT";$l_pos)
						ACTcc_OpcionesDctos ("CargaResumen")
						  // MOD Ticket Nº 210644 PA 20180626
						vb_guardarCambios:=True:C214
					Else 
						CD_Dlog (0;"La Cuenta Corriente ya tiene el descuento "+ST_Qte ($t_nombreDcto)+" asignado y activo.\r\rDesactive el descuento actual antes de crear uno nuevo o modifique el descuento vigente.")
					End if 
					
				End if 
				
			Else 
				
				If (lACTcfgdctos_maximoDescuento#0)
					CD_Dlog (0;"Se superó el número máximo de descuentos activos configurados ("+String:C10(lACTcfgdctos_maximoDescuento)+").")
				End if 
				
			End if 
			
		Else 
			CD_Dlog (0;"La Cuenta Corriente ya tiene asignado un 100% de descuento.\r\rPor ahora no es posible ingresar otro descuento.")
		End if 
		
	: ($t_accion="EliminaDescuento")
		If (lb_descuentosTodos<=Size of array:C274(atACT_PeriodoT))
			READ ONLY:C145([ACT_Cargos:173])
			SET QUERY DESTINATION:C396(Into variable:K19:4;$l_recs)
			SET QUERY LIMIT:C395(1)
			QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]id_DescuentoIndividual:68=alACT_DescuentosIdsT{lb_descuentosTodos})
			SET QUERY LIMIT:C395(0)
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			If ($l_recs>0)
				$l_resp:=CD_Dlog (0;"Este descuento está siendo utilizado en algunos cargos existentes.\r\rEliminar esta información podría ocasionar problemas en la impresión de reportes.\r\r¿Está seguro que desea continuar?";"";"Si";"No")
			Else 
				$l_resp:=1
			End if 
			
			If ($l_resp=1)
				If (alACT_DescuentosIdsT{lb_descuentosTodos}#0)
					APPEND TO ARRAY:C911(alACT_idsEliminados;alACT_DescuentosIdsT{lb_descuentosTodos})
				End if 
				[ACT_CuentasCorrientes:175]Descuento:23:=0
				LISTBOX DELETE ROWS:C914(lb_descuentosTodos;lb_descuentosTodos)
				ACTcc_OpcionesDctos ("CargaResumen")
				  // MOD Ticket Nº 210644 PA 20180626
				vb_guardarCambios:=True:C214
			End if 
		End if 
		
	: ($t_accion="OnSavingCtaCte")
		  //elimina
		For ($l_indice;1;Size of array:C274(alACT_idsEliminados))
			KRL_FindAndLoadRecordByIndex (->[ACT_DctosIndividuales_Cuentas:228]ID:1;->alACT_idsEliminados{$l_indice};True:C214)
			If (ok=1)
				
				  //elimino posibles dctos ya creados
				ACTcc_OpcionesDctos ("EliminaDctosYaCreados";->[ACT_DctosIndividuales_Cuentas:228]ID_Descuento:5)
				
				$t_nombreDcto:=ACTcfg_OpcionesDescuentos ("ObtieneNombreXid";->[ACT_DctosIndividuales_Cuentas:228]ID_Descuento:5)
				LOG_RegisterEvt ("Eliminación de descuento individual "+ST_Qte ($t_nombreDcto)+" (id "+String:C10([ACT_DctosIndividuales_Cuentas:228]ID:1)+"), para alumno "+[Alumnos:2]apellidos_y_nombres:40+".")
				DELETE RECORD:C58([ACT_DctosIndividuales_Cuentas:228])
				
			Else 
				CD_Dlog (0;"El registro de descuento está en uso. No fue posible eliminar el descuento.")
			End if 
			KRL_UnloadReadOnly (->[ACT_DctosIndividuales_Cuentas:228])
		End for 
		
		  //guarda
		SORT ARRAY:C229(abACT_InactivosT;arACT_DescuentosT;atACT_DescuentosT;atACT_PeriodoT;alACT_DescuentosIdsT;alACT_DescuentosIdsCFG_T;>)
		AT_OrderArraysByArray (MAXLONG:K35:2;->alACTcfg_Ids;->alACT_DescuentosIdsCFG_T;->arACT_DescuentosT;->atACT_DescuentosT;->atACT_PeriodoT;->abACT_InactivosT;->alACT_DescuentosIdsT)
		For ($l_indice;1;Size of array:C274(arACT_DescuentosT))
			READ WRITE:C146([ACT_DctosIndividuales_Cuentas:228])
			If (alACT_DescuentosIdsT{$l_indice}=0)
				ACTdic_CreaRegistro ([ACT_CuentasCorrientes:175]ID:1;alACT_DescuentosIdsCFG_T{$l_indice};abACT_InactivosT{$l_indice};$l_indice;atACT_PeriodoT{$l_indice};arACT_DescuentosT{$l_indice})
			Else 
				KRL_FindAndLoadRecordByIndex (->[ACT_DctosIndividuales_Cuentas:228]ID:1;->alACT_DescuentosIdsT{$l_indice};True:C214)
				If (ok=1)
					[ACT_DctosIndividuales_Cuentas:228]Periodo:9:=atACT_PeriodoT{$l_indice}
					[ACT_DctosIndividuales_Cuentas:228]Porcentaje:7:=arACT_DescuentosT{$l_indice}
					[ACT_DctosIndividuales_Cuentas:228]Inactivo:10:=abACT_InactivosT{$l_indice}
					[ACT_DctosIndividuales_Cuentas:228]Orden:8:=$l_indice
					  // MOD Ticket Nº 210644 PA 20180626
					  //[ACT_CuentasCorrientes]Descuento:=arACT_DescuentosT{$l_indice}
					ACTcc_OpcionesDctos ("ActualizaDctoCtaCte";->[ACT_DctosIndividuales_Cuentas:228]ID_Descuento:5;->arACT_DescuentosT{$l_indice})
					If (KRL_FieldChanges (->[ACT_DctosIndividuales_Cuentas:228]Porcentaje:7;->[ACT_DctosIndividuales_Cuentas:228]Inactivo:10;->[ACT_DctosIndividuales_Cuentas:228]Periodo:9))
						ACTcc_OpcionesDctos ("RegistraLog")
					End if 
					
					SAVE RECORD:C53([ACT_DctosIndividuales_Cuentas:228])
				End if 
			End if 
			KRL_UnloadReadOnly (->[ACT_DctosIndividuales_Cuentas:228])
			
			If (abACT_InactivosT{$l_indice})
				  //elimino los no activos
				KRL_FindAndLoadRecordByIndex (->[ACT_DctosIndividuales_Cuentas:228]ID:1;->alACT_DescuentosIdsT{$l_indice})
				$t_ids:=ACTcc_OpcionesDctos ("EliminaDctosYaCreados";->[ACT_DctosIndividuales_Cuentas:228]ID_Descuento:5)
				If ($t_ids#"")
				End if 
			End if 
		End for 
		
		
		
	: ($t_accion="RegistraLog")
		$t_nomDcto:=ACTcfg_OpcionesDescuentos ("ObtieneNombreXid";->[ACT_DctosIndividuales_Cuentas:228]ID_Descuento:5)
		$l_idAl:=KRL_GetNumericFieldData (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_DctosIndividuales_Cuentas:228]ID_CuentaCorriente:6;->[ACT_CuentasCorrientes:175]ID_Alumno:3)
		$t_alumno:=KRL_GetTextFieldData (->[Alumnos:2]numero:1;->$l_idAl;->[Alumnos:2]apellidos_y_nombres:40)
		$t_creaOActualiza:=Choose:C955(Is new record:C668([ACT_DctosIndividuales_Cuentas:228]);"Creación";"Modificación")
		LOG_RegisterEvt ($t_creaOActualiza+" de descuento individual: "+ST_Qte ($t_nomDcto)+", (id conf. descuento: "+String:C10([ACT_DctosIndividuales_Cuentas:228]ID_Descuento:5)+"), para alumno: "+$t_alumno+", porcentaje asignado: "+String:C10([ACT_DctosIndividuales_Cuentas:228]Porcentaje:7)+", estado: "+Choose:C955([ACT_DctosIndividuales_Cuentas:228]Inactivo:10;"Inactivo";"Activo")+", porcentaje: "+String:C10([ACT_DctosIndividuales_Cuentas:228]Porcentaje:7)+". Id registro descuento: "+String:C10([ACT_DctosIndividuales_Cuentas:228]ID:1)+".")
		
	: ($t_accion="EliminaDctosYaCreados")
		$l_refItem:=KRL_GetNumericFieldData (->[ACT_CFG_DctosIndividuales:229]ID:1;$y_pointer1;->[ACT_CFG_DctosIndividuales:229]Id_Item_de_Cargo:7)
		READ WRITE:C146([ACT_Cargos:173])
		QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1;*)
		QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22=!00-00-00!;*)
		QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Ref_Item:16=$l_refItem)
		SELECTION TO ARRAY:C260([ACT_Cargos:173]ID:1;$alACT_idsCargosAEliminarF)
		ACTcc_EliminaCargosLoop 
		If (Size of array:C274($alACT_idsCargosAEliminarF)>0)
			$t_ids:=AT_array2text (->$alACT_idsCargosAEliminarF;" - ";"############")
			LOG_RegisterEvt ("Eliminación de cargos proyectados mediante Asistente. Los siguientes ids de cargos fueron eliminados "+$t_ids+".")
		End if 
		$t_retorno:=$t_ids
		
	: ($t_accion="VisualizacionArea")
		C_LONGINT:C283(vlACT_paginaSelDcto)
		If (vlACT_paginaSelDcto=0)
			vlACT_paginaSelDcto:=1
		End if 
		
		If (vlACT_paginaSelDcto=2)
			If (Not:C34(USR_GetMethodAcces ("ACTcc_HabilitarDescuentosCC")))
				vlACT_paginaSelDcto:=1
				SELECT LIST ITEMS BY POSITION:C381(HLTAB_ACTcc_Dctos;vlACT_paginaSelDcto)
			End if 
		End if 
		
		OBJECT SET VISIBLE:C603(*;"pg_@";(vlACT_paginaSelDcto=1))
		OBJECT SET VISIBLE:C603(*;"descto_@";(vlACT_paginaSelDcto=2))
	: ($t_accion="ActualizaDctoCtaCte")  // MOD Ticket Nº 210644 PA 20180626
		If ($y_pointer1->=-1)
			[ACT_CuentasCorrientes:175]Descuento:23:=$y_pointer2->
		End if 
End case 

$0:=$t_retorno