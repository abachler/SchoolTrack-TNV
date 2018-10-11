//%attributes = {}
  //ACTcfgmyt_OpcionesGenerales

C_TEXT:C284($vt_accion;$1)
C_POINTER:C301($ptr1;$ptr2;$ptr3;$ptr4)
C_TEXT:C284($0;$vt_retorno)
C_BOOLEAN:C305($vb_noActualizarTabla)

$vt_accion:=$1
If (Count parameters:C259>=2)
	$ptr1:=$2
End if 
If (Count parameters:C259>=3)
	$ptr2:=$3
End if 
If (Count parameters:C259>=4)
	$ptr3:=$4
End if 
If (Count parameters:C259>=5)
	$ptr4:=$5
End if 
Case of 
	: ($vt_accion="SetEstadoObjetosMontosFijos")
		C_BOOLEAN:C305($vb_var)
		$vl_opcion:=Num:C11($ptr1->)
		$vb_var:=($vl_opcion=1)
		AT_Populate (->abACT_MontosFijosEm;->$vb_var)
		$vd_fecha:=Current date:C33(*)
		AT_Populate (->adACT_fechasEm;->$vd_fecha)
		If ($vl_opcion=1)
			vbACT_HabilitaFlechas:=True:C214
			_O_ENABLE BUTTON:C192(*;"uf@")
		Else 
			vbACT_HabilitaFlechas:=False:C215
			_O_DISABLE BUTTON:C193(*;"uf@")
		End if 
		OBJECT SET ENTERABLE:C238(*;"colsMontoFijo1";($vl_opcion=1))
		
	: ($vt_accion="CargaListBoxEmision")
		
		ACTcfgmyt_OpcionesGenerales ("LeeMonedas")
		ARRAY TEXT:C222($atACT_NombreMoneda;0)
		ARRAY REAL:C219($arACT_ValorMoneda;0)
		ARRAY BOOLEAN:C223($abACT_GeneraTabla;0)
		ARRAY LONGINT:C221($alACT_IdRegistro;0)
		
		COPY ARRAY:C226(atACT_NombreMoneda;$atACT_NombreMoneda)
		COPY ARRAY:C226(arACT_ValorMoneda;$arACT_ValorMoneda)
		COPY ARRAY:C226(abACT_GeneraTabla;$abACT_GeneraTabla)
		COPY ARRAY:C226(alACT_IdRegistro;$alACT_IdRegistro)
		
		ARRAY TEXT:C222(atACT_NombreMonedaEm;0)
		ARRAY REAL:C219(arACT_ValorMonedaEm;0)
		ARRAY LONGINT:C221(alACT_IdRegistroEm;0)
		ARRAY DATE:C224(adACT_fechasEm;0)
		ARRAY BOOLEAN:C223(abACT_MontosFijosEm;0)
		
		COPY ARRAY:C226($atACT_NombreMoneda;atACT_NombreMonedaEm)
		COPY ARRAY:C226($arACT_ValorMoneda;arACT_ValorMonedaEm)
		COPY ARRAY:C226($alACT_IdRegistro;alACT_IdRegistroEm)
		ARRAY BOOLEAN:C223(abACT_MontosFijosEm;Size of array:C274(atACT_NombreMoneda))
		AT_RedimArrays (Size of array:C274(atACT_NombreMonedaEm);->adACT_fechasEm)
		
		$pos:=Find in array:C230(atACT_NombreMonedaEm;ST_GetWord (ACT_DivisaPais ;1;";"))
		If ($pos#-1)
			AT_Delete ($pos;1;->atACT_NombreMonedaEm;->arACT_ValorMonedaEm;->abACT_MontosFijosEm;->alACT_IdRegistroEm;->adACT_fechasEm)
		End if 
		OBJECT SET ENTERABLE:C238(*;"colsMontoFijo@";False:C215)
		vbACT_HabilitaFlechas:=False:C215
		
	: ($vt_accion="ModificaCampoMoneda")
		$vl_idMoneda:=$ptr1->
		KRL_FindAndLoadRecordByIndex (->[xxACT_Monedas:146]Id_Moneda:1;->$vl_idMoneda;True:C214)
		If (ok=1)
			$ptr2->:=$ptr3->
			SAVE RECORD:C53([xxACT_Monedas:146])
			KRL_UnloadReadOnly (->[xxACT_Monedas:146])
		End if 
		
	: ($vt_accion="AplicaCambioParidadManual")
		$vl_idMoneda:=$ptr1->
		$vd_fecha:=$ptr2->
		$vr_monto:=$ptr3->
		$vl_mes:=Month of:C24($vd_fecha)
		$vl_year:=Year of:C25($vd_fecha)
		
		If ($vl_idMoneda#-6)
			If (atACT_UFLabel#-1)
				If (KRL_GetBooleanFieldData (->[xxACT_Monedas:146]Id_Moneda:1;->$vl_idMoneda;->[xxACT_Monedas:146]Genera_Tabla_Diaria:7))
					$vt_moneda:=KRL_GetTextFieldData (->[xxACT_Monedas:146]Id_Moneda:1;->$vl_idMoneda;->[xxACT_Monedas:146]Nombre_Moneda:2)
					vtMsg:="Usted modificó manualmente el valor del día "+String:C10(Day of:C23($vd_fecha))+" de "+atACT_UFLabel{atACT_UFLabel}+" para la moneda "+$vt_moneda+"."+"\r\r"+"¿Para qué período desea aplicar el cambio?"
					vtBtn1:="Sólo para el día actual"
					vtBtn2:="Para el día actual y para todos los días anteriores"
					vtBtn3:="Para el día actual y para todos los días posteriores"
					vtDesc1:="El cambio será aplicado sólo para el día "+String:C10(Day of:C23($vd_fecha))+" de "+atACT_UFLabel{atACT_UFLabel}+"."
					vtDesc2:="El cambio será aplicado para todos los días hasta el "+String:C10(Day of:C23($vd_fecha))+" de "+atACT_UFLabel{atACT_UFLabel}+"."
					vtDesc3:="El cambio será aplicado para para todos los días desde el "+String:C10(Day of:C23($vd_fecha))+" de "+atACT_UFLabel{atACT_UFLabel}+" ."
					WDW_OpenDialogInDrawer (->[xxACT_MonedaParidad:147];"CambioDeParidad")
					If (Ok=1)
						Case of 
							: (ob_opcion1=1)
								ACTmon_ActualizaValor ($vl_idMoneda;$vl_year;$vl_mes;Day of:C23($vd_fecha);$vr_monto)
								
							: (ob_opcion2=1)
								$vt_CondBusqueda:="<="
								ACTcfgmyt_OpcionesGenerales ("AplicaCambioATablaParidad";->$vl_idMoneda;->$vr_monto;->$vd_fecha;->$vt_CondBusqueda)
								
							: (ob_opcion3=1)
								$vt_CondBusqueda:=">="
								ACTcfgmyt_OpcionesGenerales ("AplicaCambioATablaParidad";->$vl_idMoneda;->$vr_monto;->$vd_fecha;->$vt_CondBusqueda)
								
						End case 
					End if 
				Else 
					OK:=1
				End if 
				$vt_retorno:=String:C10(OK)
			Else 
				$vt_retorno:=String:C10(1)
				ACTmon_ActualizaValor ($vl_idMoneda;$vl_year;$vl_mes;Day of:C23($vd_fecha);$vr_monto)
			End if 
		End if 
		ACTcfgmyt_OpcionesGenerales ("LeeMonedas")
		ACTcfgmyt_OpcionesGenerales ("SeleccionaLineaForm";->$vl_idMoneda)
		
	: ($vt_accion="RecalculaUF")
		$vl_idUF:=-6
		AL_UpdateArrays (xALP_Divisas;0)
		ACTcfgmyt_OpcionesGenerales ("LeeMonedas")
		AL_UpdateArrays (xALP_Divisas;-2)
		ACTcfgmyt_OpcionesGenerales ("SeleccionaLineaForm";->$vl_idUF)
		
	: ($vt_accion="AplicaCambioATablaParidad")
		C_DATE:C307($vd_date)
		C_TEXT:C284($vt_condicion)
		$vl_idMoneda:=$ptr1->
		$vr_nuevoValor:=$ptr2->
		If (Not:C34(Is nil pointer:C315($ptr3)))
			$vd_date:=$ptr3->
		End if 
		If (Not:C34(Is nil pointer:C315($ptr4)))
			$vt_condicion:=$ptr4->
		End if 
		If ($vd_date=!00-00-00!)
			$vd_date:=Current date:C33(*)
		End if 
		If ($vt_condicion="")
			$vt_condicion:=">="
		End if 
		$proc:=IT_UThermometer (1;0;__ ("Aplicando cambio..."))
		READ WRITE:C146([xxACT_MonedaParidad:147])
		QUERY:C277([xxACT_MonedaParidad:147];[xxACT_MonedaParidad:147]Id_Moneda:2=$vl_idMoneda;*)
		QUERY:C277([xxACT_MonedaParidad:147]; & ;[xxACT_MonedaParidad:147]Fecha:12;$vt_condicion;$vd_date)
		APPLY TO SELECTION:C70([xxACT_MonedaParidad:147];[xxACT_MonedaParidad:147]Valor:6:=$vr_nuevoValor)
		If ((($vd_date>=Current date:C33(*)) & ($vt_condicion="<=")) | (($vd_date<=Current date:C33(*)) & ($vt_condicion=">=")))
			$vb_noActualizarTabla:=True:C214
			ACTcfgmyt_OpcionesGenerales ("ModificaValor";->$vl_idMoneda;->$vr_nuevoValor;->$vb_noActualizarTabla)
		End if 
		IT_UThermometer (-2;$proc)
		KRL_UnloadReadOnly (->[xxACT_MonedaParidad:147])
		
	: ($vt_accion="ModificaValor")
		$vl_idMoneda:=$ptr1->
		$vr_nuevoValor:=$ptr2->
		If (Not:C34(Is nil pointer:C315($ptr3)))
			$vb_noActualizarTabla:=$ptr3->
		End if 
		ACTcfgmyt_OpcionesGenerales ("ModificaCampoMoneda";->$vl_idMoneda;->[xxACT_Monedas:146]Valor:3;->$vr_nuevoValor)
		If (Not:C34($vb_noActualizarTabla))
			ACTcfgmyt_OpcionesGenerales ("AplicaCambioATablaParidad";->$vl_idMoneda;->$vr_nuevoValor)
		End if 
		KRL_UnloadReadOnly (->[xxACT_Monedas:146])
		
		
	: ($vt_accion="AgregaMoneda")
		CREATE RECORD:C68([xxACT_Monedas:146])
		$recs:=0
		SET QUERY DESTINATION:C396(Into variable:K19:4;$recs)
		$vl_index:=1
		$vt_nombre:="Nueva Moneda "+String:C10($vl_index)
		QUERY:C277([xxACT_Monedas:146];[xxACT_Monedas:146]Nombre_Moneda:2=$vt_nombre)
		While ($recs>0)
			$vl_index:=$vl_index+1
			$vt_nombre:="Nueva Moneda "+String:C10($vl_index)
			QUERY:C277([xxACT_Monedas:146];[xxACT_Monedas:146]Nombre_Moneda:2=$vt_nombre)
		End while 
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		[xxACT_Monedas:146]Nombre_Moneda:2:=$vt_nombre
		[xxACT_Monedas:146]Id_Moneda:1:=SQ_SeqNumber (->[xxACT_Monedas:146]Id_Moneda:1)
		[xxACT_Monedas:146]Valor:3:=1
		[xxACT_Monedas:146]Codigo_Pais:6:=<>gCountryCode
		$vt_retorno:=String:C10([xxACT_Monedas:146]Id_Moneda:1)
		SAVE RECORD:C53([xxACT_Monedas:146])
		KRL_UnloadReadOnly (->[xxACT_Monedas:146])
		ACTcfgmyt_OpcionesGenerales ("LeeMonedas")  //recargo moneda
		
	: ($vt_accion="CFG_EliminaMoneda")
		$vl_idMoneda:=$ptr1->
		KRL_FindAndLoadRecordByIndex (->[xxACT_Monedas:146]Id_Moneda:1;->$vl_idMoneda;True:C214)
		If (ok=1)
			$go:=True:C214
			If ([xxACT_Monedas:146]Moneda_X_Defecto_Base:11 | [xxACT_Monedas:146]Moneda_X_Defecto_Pais:9)
				CD_Dlog (0;__ ("La moneda ")+[xxACT_Monedas:146]Nombre_Moneda:2+__ (" no puede ser eliminada por ser una moneda por defecto del sistema."))
			Else 
				$resp:=CD_Dlog (0;__ ("¿Está seguro de querer eliminar la moneda ")+[xxACT_Monedas:146]Nombre_Moneda:2+__ (" y todos sus registros asociados?");__ ("");__ ("Si");__ ("No"))
				If ($resp=1)
					READ ONLY:C145([ACT_Cargos:173])
					SET QUERY LIMIT:C395(1)
					SET QUERY DESTINATION:C396(Into variable:K19:4;$recs)
					  //QUERY([ACT_Cargos];[ACT_Cargos]Moneda=[xxACT_Monedas]Nombre_Moneda;*)
					  //QUERY([ACT_Cargos]; & ;[ACT_Cargos]FechaEmision=!00-00-00!)
					QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]Moneda:28=[xxACT_Monedas:146]Nombre_Moneda:2)
					If ($recs>0)
						$go:=False:C215
					End if 
					READ ONLY:C145([ACT_Matrices:177])
					QUERY:C277([ACT_Matrices:177];[ACT_Matrices:177]Moneda:9=[xxACT_Monedas:146]Nombre_Moneda:2)
					If ($recs>0)
						$go:=False:C215
					End if 
					READ ONLY:C145([xxACT_Items:179])
					QUERY:C277([xxACT_Items:179];[xxACT_Items:179]Moneda:10=[xxACT_Monedas:146]Nombre_Moneda:2)
					If ($recs>0)
						$go:=False:C215
					End if 
					SET QUERY DESTINATION:C396(Into current selection:K19:1)
					SET QUERY LIMIT:C395(0)
					
					If ($go)
						READ WRITE:C146([xxACT_MonedaParidad:147])
						QUERY:C277([xxACT_MonedaParidad:147];[xxACT_MonedaParidad:147]Id_Moneda:2=[xxACT_Monedas:146]Id_Moneda:1)
						DELETE SELECTION:C66([xxACT_MonedaParidad:147])
						If (Records in set:C195("LockedSet")=0)
							LOG_RegisterEvt ("Eliminación de tabla de paridad para moneda "+[xxACT_Monedas:146]Nombre_Moneda:2+".")
							DELETE RECORD:C58([xxACT_Monedas:146])  //borro moneda
							LOG_RegisterEvt ("Eliminación de moneda "+[xxACT_Monedas:146]Nombre_Moneda:2+".")
							ACTcfgmyt_OpcionesGenerales ("LeeMonedas")  //recargo moneda
						Else 
							CD_Dlog (0;__ ("Existían registros en uso. La eliminación no pudo ser completada. Intente nuevamente."))
						End if 
						KRL_UnloadReadOnly (->[xxACT_MonedaParidad:147])
					Else 
						CD_Dlog (0;__ ("Existen cargos generados, items de cargo o matrices que ocupan esta moneda. La moneda no puede ser eliminada."))
					End if 
				End if 
			End if 
		Else 
			CD_Dlog (0;__ ("En este momento el registro está en uso. Por favor intente más tarde."))
		End if 
		
	: ($vt_accion="LeeMonedas")
		ARRAY TEXT:C222(atACT_NombreMoneda;0)
		ARRAY REAL:C219(arACT_ValorMoneda;0)
		ARRAY TEXT:C222(atACT_SimboloMoneda;0)
		
		ARRAY PICTURE:C279(apACT_GeneraTabla;0)
		ARRAY BOOLEAN:C223(abACT_GeneraTabla;0)
		ARRAY BOOLEAN:C223(abACT_MonedaXDef;0)
		ARRAY LONGINT:C221(alACT_IdRegistro;0)
		ARRAY BOOLEAN:C223(abACT_MonedaXDef_Base;0)
		ARRAY PICTURE:C279(apACT_PermitePago;0)
		ARRAY BOOLEAN:C223(abACT_PermitePago;0)
		
		If (Records in selection:C76([Colegio:31])=1)
			FIRST RECORD:C50([Colegio:31])
		Else 
			READ ONLY:C145([Colegio:31])
			ALL RECORDS:C47([Colegio:31])
			FIRST RECORD:C50([Colegio:31])
		End if 
		If ([Colegio:31]Codigo_Pais:31="")
			[Colegio:31]Codigo_Pais:31:="cl"
		End if 
		
		READ ONLY:C145([xxACT_Monedas:146])
		QUERY:C277([xxACT_Monedas:146];[xxACT_Monedas:146]Codigo_Pais:6=[Colegio:31]Codigo_Pais:31)
		ORDER BY:C49([xxACT_Monedas:146];[xxACT_Monedas:146]Nombre_Moneda:2;>)
		SELECTION TO ARRAY:C260([xxACT_Monedas:146]Nombre_Moneda:2;atACT_NombreMoneda;[xxACT_Monedas:146]Valor:3;arACT_ValorMoneda;[xxACT_Monedas:146]Simbolo:4;atACT_SimboloMoneda)
		SELECTION TO ARRAY:C260([xxACT_Monedas:146]Genera_Tabla_Diaria:7;abACT_GeneraTabla;[xxACT_Monedas:146]Moneda_X_Defecto_Pais:9;abACT_MonedaXDef;[xxACT_Monedas:146]Id_Moneda:1;alACT_IdRegistro)
		SELECTION TO ARRAY:C260([xxACT_Monedas:146]Moneda_X_Defecto_Base:11;abACT_MonedaXDef_Base;[xxACT_Monedas:146]Permite_Pago:12;abACT_PermitePago)
		ACTat_LLenaArregloPict (->abACT_GeneraTabla;->apACT_GeneraTabla)
		ACTat_LLenaArregloPict (->abACT_PermitePago;->apACT_PermitePago)
		
		  //orden de monedas
		  //primero moneda pais
		ARRAY LONGINT:C221($al_idsOrden;0)
		$el:=Find in array:C230(atACT_NombreMoneda;ST_GetWord (ACT_DivisaPais ;1;";"))
		If ($el#-1)
			APPEND TO ARRAY:C911($al_idsOrden;alACT_IdRegistro{$el})
		End if 
		  //segundo moneda por defecto
		$el:=Find in array:C230(atACT_NombreMoneda;<>vsACT_MonedaColegio)
		If ($el#-1)
			If (Find in array:C230($al_idsOrden;alACT_IdRegistro{$el})=-1)
				APPEND TO ARRAY:C911($al_idsOrden;alACT_IdRegistro{$el})
			End if 
		End if 
		  //tercero monedas pais
		abACT_MonedaXDef{0}:=True:C214
		ARRAY LONGINT:C221($DA_Return;0)
		AT_SearchArray (->abACT_MonedaXDef;"=";->$DA_Return)
		For ($i;1;Size of array:C274($DA_Return))
			If (Find in array:C230($al_idsOrden;alACT_IdRegistro{$DA_Return{$i}})=-1)
				APPEND TO ARRAY:C911($al_idsOrden;alACT_IdRegistro{$DA_Return{$i}})
			End if 
		End for 
		AT_OrderArraysByArray (MAXLONG:K35:2;->$al_idsOrden;->alACT_IdRegistro;->atACT_NombreMoneda;->arACT_ValorMoneda;->atACT_SimboloMoneda;->abACT_GeneraTabla;->abACT_MonedaXDef;->apACT_GeneraTabla;->abACT_MonedaXDef_Base;->abACT_PermitePago;->apACT_PermitePago)
		
	: ($vt_accion="ValidaMonedaXDefecto")
		TRACE:C157
		
	: ($vt_accion="ValidaMonedaUF")
		If (<>vtXS_CountryCode#"cl")
			$posUF:=Find in array:C230(atACT_NombreMoneda;"UF")
			If ($posUF#-1)
				AT_Delete ($posUF;1;->arACT_ValorMoneda;->atACT_NombreMoneda;->atACT_SimboloMoneda)
			End if 
		End if 
	: ($vt_accion="GuardaMonedas")
		  //se guarda al momento de hacer cambios
		ARRAY PICTURE:C279(apACT_GeneraTabla;0)
		ARRAY BOOLEAN:C223(abACT_GeneraTabla;0)
		ARRAY BOOLEAN:C223(abACT_MonedaXDef;0)
		  //ARRAY LONGINT(alACT_IdRegistro;0) `se utiliza...
		
		ARRAY BOOLEAN:C223(abACT_MonedaXDef_Base;0)
		
		ARRAY PICTURE:C279(apACT_PermitePago;0)
		ARRAY BOOLEAN:C223(abACT_PermitePago;0)
		
	: ($vt_accion="CargaListadoValores")
		ARRAY REAL:C219(arACT_ValorMonedaDia;0)
		ARRAY LONGINT:C221(alACT_MonedaDia;0)
		
		ARRAY TEXT:C222(atACT_UFReference;0)
		ARRAY TEXT:C222(atACT_UFLabel;0)
		
		If (Not:C34(Is nil pointer:C315($ptr1)))
			ARRAY LONGINT:C221($al_years;0)
			C_LONGINT:C283($i;$j)
			C_TEXT:C284($vt_currentRef)
			
			$vl_idMoneda:=$ptr1->
			READ ONLY:C145([xxACT_MonedaParidad:147])
			QUERY:C277([xxACT_MonedaParidad:147];[xxACT_MonedaParidad:147]Id_Moneda:2=$vl_idMoneda;*)
			QUERY:C277([xxACT_MonedaParidad:147]; & ;[xxACT_MonedaParidad:147]Agno:3<=(Year of:C25(Current date:C33(*))+1))
			AT_DistinctsFieldValues (->[xxACT_MonedaParidad:147]Agno:3;->$al_years)
			SORT ARRAY:C229($al_years;>)
			For ($i;1;Size of array:C274($al_years))
				For ($j;1;12)
					APPEND TO ARRAY:C911(atACT_UFLabel;<>atXS_MonthNames{$j}+" "+String:C10($al_years{$i}))
					APPEND TO ARRAY:C911(atACT_UFReference;String:C10($al_years{$i})+String:C10($j;"00"))
				End for 
			End for 
			$vt_currentRef:=<>atXS_MonthNames{Month of:C24(Current date:C33(*))}+" "+String:C10(Year of:C25(Current date:C33(*)))
			atACT_UFLabel:=Find in array:C230(atACT_UFLabel;$vt_currentRef)
			ACTcfgmyt_OpcionesGenerales ("CargaValoresTabla";->$vl_idMoneda)
		End if 
		
	: ($vt_accion="SeleccionaLineaForm")
		If (Not:C34(Is nil pointer:C315($ptr1)))
			$line:=Find in array:C230(alACT_IdRegistro;$ptr1->)
		Else 
			$line:=0
		End if 
		If ($line<=0)
			$line:=AL_GetLine (xALP_Divisas)
		Else 
			AL_SetLine (xALP_Divisas;$line)
			AL_UpdateArrays (xALP_Divisas;-1)
		End if 
		If ($line>0)
			vtACT_MonedaSel:="Tabla Paridad/"+atACT_NombreMoneda{$line}
			$vl_idMoneda:=alACT_IdRegistro{$line}
			AL_UpdateArrays (xALP_UF;0)
			$proc:=IT_UThermometer (1;0;__ ("Cargando tabla de paridades..."))
			ACTcfgmyt_OpcionesGenerales ("CargaListadoValores";->$vl_idMoneda)
			IT_UThermometer (-2;$proc)
			AL_UpdateArrays (xALP_UF;-2)
			If (Size of array:C274(alACT_MonedaDia)>0)
				_O_ENABLE BUTTON:C192(atACT_UFLabel)
				_O_ENABLE BUTTON:C192(xALP_UF)
				If ($vl_idMoneda#-6)
					AL_SetEnterable (xALP_UF;2;1)
				Else 
					AL_SetEnterable (xALP_UF;2;0)
				End if 
			Else 
				_O_DISABLE BUTTON:C193(atACT_UFLabel)
				_O_DISABLE BUTTON:C193(xALP_UF)
			End if 
		End if 
		ACTcfg_ColorUndelDivisas 
		
	: ($vt_accion="CargaValoresTabla")
		$vl_idMoneda:=$ptr1->
		If (atACT_UFLabel#-1)
			ARRAY REAL:C219(arACT_ValorMonedaDia;0)
			ARRAY LONGINT:C221(alACT_MonedaDia;0)
			
			$vl_mes:=Num:C11(Substring:C12(atACT_UFReference{atACT_UFLabel};5;2))
			$vl_year:=Num:C11(Substring:C12(atACT_UFReference{atACT_UFLabel};1;4))
			READ ONLY:C145([xxACT_MonedaParidad:147])
			QUERY:C277([xxACT_MonedaParidad:147];[xxACT_MonedaParidad:147]Id_Moneda:2=$vl_idMoneda;*)
			QUERY:C277([xxACT_MonedaParidad:147]; & ;[xxACT_MonedaParidad:147]Agno:3=$vl_year;*)
			QUERY:C277([xxACT_MonedaParidad:147]; & ;[xxACT_MonedaParidad:147]Mes:4=$vl_mes)
			ORDER BY:C49([xxACT_MonedaParidad:147];[xxACT_MonedaParidad:147]Dia:5;>)
			ARRAY LONGINT:C221($al_recNum;0)
			LONGINT ARRAY FROM SELECTION:C647([xxACT_MonedaParidad:147];$al_recNum;"")
			For ($i;1;Size of array:C274($al_recNum))
				GOTO RECORD:C242([xxACT_MonedaParidad:147];$al_recNum{$i})
				APPEND TO ARRAY:C911(arACT_ValorMonedaDia;[xxACT_MonedaParidad:147]Valor:6)
				APPEND TO ARRAY:C911(alACT_MonedaDia;[xxACT_MonedaParidad:147]Dia:5)
			End for 
		End if 
		REDRAW WINDOW:C456
		
	: ($vt_accion="CargaMonedasPago")
		READ ONLY:C145([xxACT_Monedas:146])
		QUERY:C277([xxACT_Monedas:146];[xxACT_Monedas:146]Codigo_Pais:6=<>gCountryCode;*)
		QUERY:C277([xxACT_Monedas:146]; & ;[xxACT_Monedas:146]Permite_Pago:12=True:C214)
		SELECTION TO ARRAY:C260([xxACT_Monedas:146]Nombre_Moneda:2;$ptr1->)
		SORT ARRAY:C229($ptr1->;>)
		
	: ($vt_accion="OpcionesFormulario")
		C_TEXT:C284($vt_moneda;$vt_formato)
		C_LONGINT:C283($vl_decimales)
		
		If (vtACTpgs_Moneda="")
			vtACTpgs_Moneda:=ST_GetWord (ACT_DivisaPais ;1;";")
		End if 
		$vt_formato:=ACTcfgmyt_OpcionesGenerales ("ObtieneFormato";->vtACTpgs_Moneda)
		OBJECT SET FORMAT:C236(vrACTpgs_MontoMoneda;$vt_formato)
		If (vtACTpgs_Moneda=ST_GetWord (ACT_DivisaPais ;1;";"))
			OBJECT SET VISIBLE:C603(*;"moneda_@";False:C215)
			OBJECT SET ENTERABLE:C238(*;"vrACT_MontoPago";True:C214)
		Else 
			OBJECT SET VISIBLE:C603(*;"moneda_@";True:C214)
			OBJECT SET ENTERABLE:C238(*;"vrACT_MontoPago";False:C215)
		End if 
		
		  //ACTcfgmyt_OpcionesGenerales ("SumaMontos")
		
	: ($vt_accion="CalculaMontoMoneda")
		vrACTpgs_MontoMoneda:=ACTut_retornaMontoEnMoneda (vrACT_MontoPago;ST_GetWord (ACT_DivisaPais ;1;";");vdACT_FechaPago;vtACTpgs_Moneda;vdACT_FechaPago;True:C214)
		
	: ($vt_accion="CalculaMontoPagadoMNacional")
		$key:=<>gCountryCode+"."+vtACTpgs_Moneda
		$vl_decimales:=KRL_GetNumericFieldData (->[xxACT_Monedas:146]Key:10;->$key;->[xxACT_Monedas:146]Numero_Decimales:8)
		vrACTpgs_MontoMoneda:=Round:C94(vrACTpgs_MontoMoneda;$vl_decimales)
		vrACT_MontoPago:=ACTut_retornaMontoEnMoneda (vrACTpgs_MontoMoneda;vtACTpgs_Moneda;vdACT_FechaPago;ST_GetWord (ACT_DivisaPais ;1;";");vdACT_FechaPago;True:C214)
		
	: ($vt_accion="SumaMontos")
		C_BOOLEAN:C305(vb_MontoModificado)
		If (Not:C34(vb_MontoModificado))
			vrACT_MontoPago:=vrACT_MontoSeleccionado+vrACT_MontoMulta+vrACT_MontoRecargo
			vrACTpgs_MontoAPagar:=vrACT_MontoSeleccionado+vrACT_MontoMulta+vrACT_MontoRecargo
		Else 
			vrACTpgs_MontoAPagar:=vrACT_MontoSeleccionado+vrACT_MontoMulta+vrACT_MontoRecargo
		End if 
		ACTcfgmyt_OpcionesGenerales ("CalculaMontoMoneda")
		ACTcfgmyt_OpcionesGenerales ("CalculaMontoPagadoMNacional")
		If (vbACTpgs_Ajustar)
			$key:=<>gCountryCode+"."+vtACTpgs_Moneda
			$vl_decimales:=KRL_GetNumericFieldData (->[xxACT_Monedas:146]Key:10;->$key;->[xxACT_Monedas:146]Numero_Decimales:8)
			$vr_montoAjuste:=Round:C94(vrACT_MontoPago-vrACTpgs_MontoAPagar;$vl_decimales)
			If (($vr_montoAjuste<10) | (Shift down:C543))
				vrACTpgs_MontoAjuste:=$vr_montoAjuste
			Else 
				BEEP:C151
			End if 
		Else 
			vrACTpgs_MontoAjuste:=0
		End if 
		ACTcfgmyt_OpcionesGenerales ("AplicaColorAjuste")
		
	: ($vt_accion="AplicaColorAjuste")
		Case of 
			: (vrACTpgs_MontoAjuste<0)
				OBJECT SET RGB COLORS:C628(vrACTpgs_MontoAjuste;0x00FF0000;0x00FFFFFF)
			Else 
				OBJECT SET RGB COLORS:C628(vrACTpgs_MontoAjuste;0x00FF;0x00FFFFFF)
		End case 
		
	: ($vt_accion="GeneraCargoDcto")
		C_REAL:C285(vrACTpgs_idCargoAjuste)
		vrACTpgs_idCargoAjuste:=-1
		If (vrACTpgs_MontoAjuste#0)
			ACTcfg_ItemsMatricula ("InicializaYLee")
			C_LONGINT:C283($recNumPersona)
			READ ONLY:C145([Personas:7])
			READ ONLY:C145([ACT_Terceros:138])
			READ ONLY:C145([ACT_CuentasCorrientes:175])
			$recNumPersona:=Record number:C243([Personas:7])
			$recNumTercero:=Record number:C243([ACT_Terceros:138])
			
			ARRAY LONGINT:C221($DA_Return;0)
			abACT_ASelectedCargo{0}:=True:C214
			AT_SearchArray (->abACT_ASelectedCargo;"=";->$DA_Return)
			If (Size of array:C274($DA_Return)>0)
				QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=alACT_CIDCtaCte{$DA_Return{1}})
			Else 
				QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Apoderado:9=[Personas:7]No:1;*)
				QUERY SELECTION:C341([ACT_CuentasCorrientes:175]; & ;[ACT_CuentasCorrientes:175]Estado:4=True:C214)
				FIRST RECORD:C50([ACT_CuentasCorrientes:175])
			End if 
			If (((Records in selection:C76([ACT_CuentasCorrientes:175])>0) & (Records in selection:C76([Personas:7])>0)) | (vbACTpgs_PagoXTercero))
				If (Size of array:C274($DA_Return)>0)
					$vl_idTercero:=0
					If (vbACTpgs_PagoXTercero)
						$vl_idTercero:=[ACT_Terceros:138]Id:1
					End if 
					$vb_avisoXCta:=False:C215
					
					$vl_idCargo:=alACT_CIdsCargos{$DA_Return{1}}
					KRL_GotoRecord (->[ACT_Cargos:173];alACT_RecNumsCargos{$DA_Return{1}})
					If (vrACTpgs_MontoAjuste>0)
						ACTcfg_LoadCargosEspeciales (6)
						  //vrACTpgs_idCargoAjuste:=ACTac_CreateCargoDocCargoImp (True;vl_idIE;vrACTpgs_MontoAjuste;Current date(*);False;[ACT_CuentasCorrientes]ID;[Personas]No;False;False;$vl_idTercero;$vb_avisoXCta;$vl_idCargo)
					Else 
						ACTcfg_LoadCargosEspeciales (5)
						  //vrACTpgs_idCargoAjuste:=ACTpgs_CreaCargo (True;[Personas]No;Abs(vrACTpgs_MontoAjuste);vl_idIE;True;[ACT_Cargos]Fecha_de_Vencimiento;[ACT_Cargos]No_Incluir_en_DocTrib;$vl_idTercero;[ACT_Cargos]ID)
					End if 
					vrACTpgs_idCargoAjuste:=ACTpgs_CreaCargo (True:C214;[Personas:7]No:1;Abs:C99(vrACTpgs_MontoAjuste);vl_idIE;True:C214;[ACT_Cargos:173]Fecha_de_Vencimiento:7;[ACT_Cargos:173]No_Incluir_en_DocTrib:50;$vl_idTercero;[ACT_Cargos:173]ID:1)
					If (vrACTpgs_idCargoAjuste=-1)
						LOG_RegisterEvt ("El cargo por ajuste no pudo ser creado.")
					End if 
					vlACT_idItemMulta:=0
					vrACTpgs_MontoAjuste:=0
					vb_multaGenerada:=True:C214
				Else 
					LOG_RegisterEvt ("El cargo por ajuste no pudo ser generado debido a que no fueron encontradas cargo"+"s a pagar.")
				End if 
			Else 
				LOG_RegisterEvt ("El cargo por ajuste no pudo ser generado debido a que no fueron encontradas cuent"+"as y/o apoderados a los cuales hacer el cargo.")
			End if 
			ACTcfg_ItemsMatricula ("ActualizaCampoDesdeEmitido")
			KRL_GotoRecord (->[Personas:7];$recNumPersona)
			KRL_GotoRecord (->[ACT_Terceros:138];$recNumTercero)
		End if 
		
		
	: ($vt_accion="InsertaCargo")
		If (vrACTpgs_idCargoAjuste#-1)
			ACTpgs_AppendCarToArray (vrACTpgs_idCargoAjuste)
			vrACTpgs_idCargoAjuste:=-1
		End if 
		
	: ($vt_accion="InicializaVars")
		C_TEXT:C284(vtACTpgs_Moneda)
		C_REAL:C285(vrACTpgs_MontoMoneda)
		C_REAL:C285(vrACTpgs_idCargoAjuste)
		
		C_BOOLEAN:C305(vbACTpgs_Ajustar)
		C_REAL:C285(vrACTpgs_MontoAjuste)
		
		vtACTpgs_Moneda:=""
		vrACTpgs_MontoMoneda:=0
		vbACTpgs_Ajustar:=False:C215
		vrACTpgs_MontoAjuste:=0
		vrACTpgs_idCargoAjuste:=-1
		
	: ($vt_accion="ObtieneFormato")
		C_TEXT:C284($vt_valor;$vt_moneda)
		C_LONGINT:C283($vl_decimales)
		$vt_moneda:=$ptr1->
		
		READ ONLY:C145([xxACT_Monedas:146])
		$vt_valor:=<>gCountryCode+"."+$vt_moneda
		$vl_decimales:=KRL_GetNumericFieldData (->[xxACT_Monedas:146]Key:10;->$vt_valor;->[xxACT_Monedas:146]Numero_Decimales:8)
		$vt_retorno:="###"+<>tXS_RS_ThousandsSeparator+"###"+<>tXS_RS_ThousandsSeparator+"###"+<>tXS_RS_ThousandsSeparator+"##0"
		If ($vl_decimales>0)
			$vt_retorno:=$vt_retorno+<>tXS_RS_DecimalSeparator+("0"*$vl_decimales)
		End if 
		
End case 


$0:=$vt_retorno