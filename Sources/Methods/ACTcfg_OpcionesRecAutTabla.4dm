//%attributes = {}
  //ACTcfg_OpcionesRecAutTabla
C_TEXT:C284($1;$t_accion)
C_TEXT:C284($t_retorno;$0)
C_BLOB:C604($xBlob)
C_POINTER:C301(${2})

$t_accion:=$1
If (Count parameters:C259>=2)
	$ptr1:=$2
End if 
If (Count parameters:C259>=3)
	$ptr2:=$3
End if 

Case of 
	: ($t_accion="LeeConf")
		  //C_REAL(csdesde_multaDesdeFE;csdesde_multaDesdeFV)
		C_REAL:C285(fecha_multaDesdeFE;fecha_multaDesdeFV)  //20140602 RCH Cambio de nombre de variables por problemas en la interfaz
		C_REAL:C285(desde_multaUsandoFE;desde_multaUsandoFV)
		C_REAL:C285(cbRecargoAutXTramo)
		C_TEXT:C284(vtACTcfg_SelectedItemAutXTramo)
		C_REAL:C285(vrACTcfg_SelectedItemAutXTramo)
		
		cbRecargoAutXTramo:=0
		vtACTcfg_SelectedItemAutXTramo:=""
		vrACTcfg_SelectedItemAutXTramo:=0
		
		fecha_multaDesdeFE:=1
		fecha_multaDesdeFV:=0
		
		desde_multaUsandoFE:=0
		desde_multaUsandoFV:=1
		
		ARRAY TEXT:C222(atACT_RecargosAutoDias;0)
		ARRAY REAL:C219(arACT_RecargosAutoDias;0)
		ARRAY BOOLEAN:C223(abACT_RecargosAutoTipoPct;0)
		ARRAY REAL:C219(arACT_RecargosAutoValor;0)
		  //ARRAY REAL(arACT_RecargosAutoRepVeces;0)
		
		If (False:C215)
			READ WRITE:C146([xShell_Prefs:46])
			QUERY:C277([xShell_Prefs:46];[xShell_Prefs:46]User:9=0;*)
			QUERY:C277([xShell_Prefs:46]; & [xShell_Prefs:46]Reference:1="ACT_PrefRecargosAutTramos")
			DELETE RECORD:C58([xShell_Prefs:46])
			KRL_UnloadReadOnly (->[xShell_Prefs:46])
		End if 
		
		ACTcfg_OpcionesRecAutTabla ("LeeBlob";->$xBlob)
		
	: ($t_accion="CreaBlob")
		BLOB_Variables2Blob ($ptr1;0;->cbRecargoAutXTramo;->vtACTcfg_SelectedItemAutXTramo;->vrACTcfg_SelectedItemAutXTramo;->fecha_multaDesdeFE;->fecha_multaDesdeFV;->desde_multaUsandoFE;->desde_multaUsandoFV;->atACT_RecargosAutoDias;->arACT_RecargosAutoDias;->abACT_RecargosAutoTipoPct;->arACT_RecargosAutoValor)
		
	: ($t_accion="LeeBlob")
		ACTcfg_OpcionesRecAutTabla ("CreaBlob";->$xBlob)
		$xBlob:=PREF_fGetBlob (0;"ACT_PrefRecargosAutTramos";$xBlob)
		ACTcfg_OpcionesRecAutTabla ("CargaBlob";->$xBlob)
		
	: ($t_accion="CargaBlob")
		BLOB_Blob2Vars ($ptr1;0;->cbRecargoAutXTramo;->vtACTcfg_SelectedItemAutXTramo;->vrACTcfg_SelectedItemAutXTramo;->fecha_multaDesdeFE;->fecha_multaDesdeFV;->desde_multaUsandoFE;->desde_multaUsandoFV;->atACT_RecargosAutoDias;->arACT_RecargosAutoDias;->abACT_RecargosAutoTipoPct;->arACT_RecargosAutoValor)
		
	: ($t_accion="InsertaElementoEnArreglos")
		APPEND TO ARRAY:C911(arACT_RecargosAutoDias;1)
		APPEND TO ARRAY:C911(atACT_RecargosAutoDias;String:C10(arACT_RecargosAutoDias{Size of array:C274(arACT_RecargosAutoDias)}))
		APPEND TO ARRAY:C911(abACT_RecargosAutoTipoPct;False:C215)
		APPEND TO ARRAY:C911(arACT_RecargosAutoValor;0)
		  //APPEND TO ARRAY(arACT_RecargosAutoRepVeces;1)
		
	: ($t_accion="EliminaElementoEnArreglos")
		$l_Pos2Del:=$ptr1->
		AT_Delete ($l_Pos2Del;1;->arACT_RecargosAutoDias;->atACT_RecargosAutoDias;->abACT_RecargosAutoTipoPct;->arACT_RecargosAutoValor)
		
	: ($t_accion="ClickEnColumnaListBox")
		$t_arreglo:=$ptr1->
		$l_linea:=$ptr2->
		If (cbRecargoAutXTramo=1)
			Case of 
				: ($t_arreglo="atACT_RecargosAutoDias")
					  //si es ondata change no se considera
					Case of 
						: (Form event:C388=On Clicked:K2:4)
							ARRAY TEXT:C222(atACT_lista;0)
							ARRAY REAL:C219(arACT_lista;0)
							ACTcfg_OpcionesRecAutTabla ("ObtieneArreglosDias";->atACT_lista;->arACT_lista)
							C_POINTER:C301($ptr)
							
							ARRAY POINTER:C280(<>aChoicePtrs;0)
							APPEND TO ARRAY:C911(<>aChoicePtrs;->atACT_lista)
							APPEND TO ARRAY:C911(<>aChoicePtrs;->arACT_lista)
							TBL_ShowChoiceList (1;"Seleccione día...";-MAXINT:K35:1;$ptr;False:C215)
							If (ok=1)
								atACT_RecargosAutoDias{$l_linea}:=atACT_lista{choiceidx}
								arACT_RecargosAutoDias{$l_linea}:=arACT_lista{choiceidx}
							End if 
							
							  //  //Si ingresan un valor a mano y no pertenece a la lista, se asigna el primer valor de la lista
							  //If ((Find in array(atACT_lista;atACT_RecargosAutoDias{$l_linea})=-1) & (Size of array(atACT_lista)>0))
							  //BEEP
							  //atACT_RecargosAutoDias{$l_linea}:=atACT_lista{1}
							  //arACT_RecargosAutoDias{$l_linea}:=arACT_lista{1}
							  //End if 
						: (Form event:C388=On Data Change:K2:15)
							atACT_RecargosAutoDias{$l_linea}:=atACT_RecargosAutoDias{0}
							arACT_RecargosAutoDias{$l_linea}:=arACT_lista{Find in array:C230(atACT_lista;atACT_RecargosAutoDias{0})}
							
					End case 
					  //: ($t_arreglo="abACT_RecargosAutoTipoPct")
					  //If (abACT_RecargosAutoTipoPct{$l_linea}<0)
					  //abACT_RecargosAutoTipoPct{$l_linea}:=0
					  //End if 
					
				: (($t_arreglo="arACT_RecargosAutoValor") | ($t_arreglo="abACT_RecargosAutoTipoPct"))
					
					If (arACT_RecargosAutoValor{$l_linea}<0)
						BEEP:C151
						arACT_RecargosAutoValor{$l_linea}:=0
					End if 
					
					If (abACT_RecargosAutoTipoPct{$l_linea})
						If (arACT_RecargosAutoValor{$l_linea}>100)
							BEEP:C151
							arACT_RecargosAutoValor{$l_linea}:=0
						End if 
					End if 
					
					  //: ($t_arreglo="arACT_RecargosAutoRepVeces")
					  //If (arACT_RecargosAutoRepVeces{$l_linea}<=0)
					  //arACT_RecargosAutoRepVeces{$l_linea}:=1
					  //End if 
					
			End case 
		End if 
	: ($t_accion="GuardaBlob")
		ACTcfg_OpcionesRecAutTabla ("CreaBlob";->$xBlob)
		PREF_SetBlob (0;"ACT_PrefRecargosAutTramos";$xBlob)
		
	: ($t_accion="ObtieneArreglosDias")
		AT_Initialize ($ptr1)
		AT_Initialize ($ptr2)
		
		For ($i;1;28)
			APPEND TO ARRAY:C911($ptr1->;String:C10($i))
			APPEND TO ARRAY:C911($ptr2->;$i)
		End for 
		APPEND TO ARRAY:C911($ptr1->;"Fin de mes")
		APPEND TO ARRAY:C911($ptr2->;32)
		
		APPEND TO ARRAY:C911($ptr1->;"Vencimiento + 1")
		APPEND TO ARRAY:C911($ptr2->;33)
		
	: ($t_accion="ValidacionesClick")
		  //ACTcfg_OpcionesRecAutTabla ("DeclaraVariablesForm")
		If (fecha_multaDesdeFV=1)
			desde_multaUsandoFE:=0
			desde_multaUsandoFV:=1
		End if 
		
	: ($t_accion="CargaVarsConfiguracion")
		  //ACTcfg_OpcionesRecAutTabla ("CargaVarsConfiguracion")
		recargo_aut0:=Choose:C955([xxACT_Items:179]id_tipoRecargoAut:45=0;1;0)
		recargo_aut1:=Choose:C955([xxACT_Items:179]id_tipoRecargoAut:45=1;1;0)
		recargo_aut2:=Choose:C955([xxACT_Items:179]id_tipoRecargoAut:45=2;1;0)
		
	: ($t_accion="GuardaVarsEnCampoConfiguracion")
		Case of 
			: (recargo_aut0=1)
				$l_id:=0
			: (recargo_aut1=1)
				$l_id:=1
			: (recargo_aut2=1)
				$l_id:=2
		End case 
		If ((([xxACT_Items:179]id_tipoRecargoAut:45=0) | ($l_id=0)) & ([xxACT_Items:179]id_tipoRecargoAut:45#$l_id))  //si cambian la conf y seleccionan no calcular, se actualiza el campo en cargos
			$vt_nombreCampo:="Afecto a recargos automáticos"
			vtMsg:="Si lo desea puede aplicar el cambio a los cargos ya generados/emitidos o bien sólo para los cargos que se generen de ahora en adelante."
			vtDesc1:="La opción "+ST_Qte ($vt_nombreCampo)+" es modificada, pero sólo será aplicada a los nuevos "+"cargos que se generen."
			vtDesc2:="Se asigna el cambio a los cargos ya generados/emitidos."
			vtBtn1:="Sólo para los nuevos cargos"
			vtBtn2:="Aplicar también a los cargos ya generados/emitidos"
			WDW_OpenDialogInDrawer (->[xxACT_GlosasExtraordinarias:5];"ACT_DLG_ModGExtras")
			If (ok=1)
				Case of 
					: (r1=1)
						LOG_RegisterEvt ("Configuración ítems: Campo "+ST_Qte ($vt_nombreCampo)+" modificado a: "+ST_Boolean2Str (($l_id=0);"Verdadero";"Falso")+" sin asignar el valor a los cargos ya emitidos.")
						
					: (r2=1)
						C_LONGINT:C283($proc)
						$proc:=IT_UThermometer (1;0;"Aplicando cambio a cargos ya generados/emitidos...")
						READ WRITE:C146([ACT_Cargos:173])
						QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=[xxACT_Items:179]ID:1)
						  //APPLY TO SELECTION([ACT_Cargos];[ACT_Cargos]NoAfecto_a_DescuentosAut:=Self->)
						APPLY TO SELECTION:C70([ACT_Cargos:173];[ACT_Cargos:173]NoAfecto_a_DescuentosAut:60:=($l_id=0))
						KRL_UnloadReadOnly (->[ACT_Cargos:173])
						IT_UThermometer (-2;$proc)
						  //LOG_RegisterEvt ("Configuración ítems: Campo "+ST_Qte ($vt_nombreCampo)+" modificado a: "+ST_Boolean2Str (Self->;"Verdadero";"Falso"))
						LOG_RegisterEvt ("Configuración ítems: Campo "+ST_Qte ($vt_nombreCampo)+" modificado a: "+ST_Boolean2Str (($l_id=0);"Verdadero";"Falso"))
						
				End case 
			End if 
		End if 
		[xxACT_Items:179]id_tipoRecargoAut:45:=$l_id
		
	: ($t_accion="ValidacionesForm")
		
		If (cbRecargoAutXTramo=1)
			_O_ENABLE BUTTON:C192(*;"multaXTramo@")
			OBJECT SET ENTERABLE:C238(*;"multaXTramo@";True:C214)
			If (Size of array:C274(at_GlosasItems)=0)
				ACTcfg_OpcionesRecargosAut ("BuscaItemsADesplegar")  // SE BUSCAN LOS MISMOS AVISOS
			End if 
			
		Else 
			_O_DISABLE BUTTON:C193(*;"multaXTramo@")
			OBJECT SET ENTERABLE:C238(*;"multaXTramo@";False:C215)
		End if 
		If (vtACTcfg_SelectedItemAutXTramo="")
			vrACTcfg_SelectedItemAutXTramo:=0
		End if 
		
End case 

$0:=$t_retorno