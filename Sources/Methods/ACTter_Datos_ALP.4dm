//%attributes = {}
  //ACTter_Datos_ALP

C_TEXT:C284($vt_accion;$key)
C_LONGINT:C283($vl_idItem;$vl_idCuenta;$vl_idCtaCte;$vl_idAlumno)
C_POINTER:C301(${2})
C_POINTER:C301($ptr1;$ptr2;$ptr3;$ptr4;$ptr5;$ptr6;$ptr7)
$vt_accion:=$1

If (Count parameters:C259>1)
	$ptr1:=$2
End if 
If (Count parameters:C259>2)
	$ptr2:=$3
End if 
If (Count parameters:C259>3)
	$ptr3:=$4
End if 
If (Count parameters:C259>4)
	$ptr4:=$5
End if 
If (Count parameters:C259>5)
	$ptr5:=$6
End if 
If (Count parameters:C259>6)
	$ptr6:=$7
End if 
If (Count parameters:C259>7)
	$ptr7:=$8
End if 
If (Count parameters:C259>8)
	$ptr8:=$9
End if 
If (Count parameters:C259>9)
	$ptr9:=$10
End if 
If (Count parameters:C259>10)
	$ptr10:=$11
End if 
READ ONLY:C145([ACT_Terceros_Pactado:139])
Case of 
	: ($vt_accion="LeeItems")
		If ($ptr1->>0)
			QUERY:C277([ACT_Terceros_Pactado:139];[ACT_Terceros_Pactado:139]Id_Tercero:2=$ptr1->)
			If (Records in selection:C76([ACT_Terceros_Pactado:139])>0)
				QUERY SELECTION:C341([ACT_Terceros_Pactado:139];[ACT_Terceros_Pactado:139]Id_CuentaCorriente:3=0)
				SELECTION TO ARRAY:C260([ACT_Terceros_Pactado:139]Id_ItemDeCargo:4;$ptr2->)
				ACTter_Datos_ALP ("ValidaIdsItems";$ptr1;$ptr2;$ptr3;$ptr4;$ptr5)
			End if 
		End if 
		
	: ($vt_accion="EliminaRegistrosItems")
		READ WRITE:C146([ACT_Terceros_Pactado:139])
		QUERY:C277([ACT_Terceros_Pactado:139];[ACT_Terceros_Pactado:139]Id_Tercero:2=[ACT_Terceros:138]Id:1;*)
		QUERY:C277([ACT_Terceros_Pactado:139]; & ;[ACT_Terceros_Pactado:139]Id_ItemDeCargo:4=$ptr1->)
		DELETE SELECTION:C66([ACT_Terceros_Pactado:139])
		If (Records in selection:C76([ACT_Terceros_Pactado:139])>0)
			LOG_RegisterEvt ("Ítem de cargo "+ST_Qte (KRL_GetTextFieldData (->[xxACT_Items:179]ID:1;$ptr1;->[xxACT_Items:179]Glosa:2))+" desasociado del tercero "+[ACT_Terceros:138]Nombre_Completo:9)
		End if 
		KRL_UnloadReadOnly (->[ACT_Terceros_Pactado:139])
		
	: ($vt_accion="ValidaIdsItems")
		READ ONLY:C145([xxACT_Items:179])
		If (Not:C34(Is nil pointer:C315($ptr4)) & (Not:C34(Is nil pointer:C315($ptr5))))
			AT_RedimArrays (Size of array:C274($ptr2->);$ptr3;$ptr4;$ptr5)
		Else 
			AT_RedimArrays (Size of array:C274($ptr2->);$ptr3)
		End if 
		For ($i;Size of array:C274($ptr2->);1;-1)
			$vl_idItem:=$ptr2->{$i}
			KRL_FindAndLoadRecordByIndex (->[xxACT_Items:179]ID:1;->$vl_idItem)
			If (Records in selection:C76([xxACT_Items:179])=0)
				AT_Delete ($i;1;$ptr2;$ptr3)
				If (Not:C34(Is nil pointer:C315($ptr4)) & (Not:C34(Is nil pointer:C315($ptr5))))
					AT_Delete ($i;1;$ptr2;$ptr3;$ptr4;$ptr5)
				End if 
				If ($vl_idItem>0)
					ACTter_Datos_ALP ("EliminaRegistrosItems";->$vl_idItem)
				End if 
			Else 
				$ptr3->{$i}:=[xxACT_Items:179]Glosa:2
				If (Not:C34(Is nil pointer:C315($ptr4)) & (Not:C34(Is nil pointer:C315($ptr5))))
					$ptr4->{$i}:=[xxACT_Items:179]Monto:7
					$ptr5->{$i}:=[xxACT_Items:179]Moneda:10
				End if 
			End if 
		End for 
		
	: ($vt_accion="LeeCargas")
		If ($ptr1->>0)
			QUERY:C277([ACT_Terceros_Pactado:139];[ACT_Terceros_Pactado:139]Id_Tercero:2=$ptr1->)
			If (Records in selection:C76([ACT_Terceros_Pactado:139])>0)
				QUERY SELECTION:C341([ACT_Terceros_Pactado:139];[ACT_Terceros_Pactado:139]Id_ItemDeCargo:4=0)
				SELECTION TO ARRAY:C260([ACT_Terceros_Pactado:139]Id_CuentaCorriente:3;$ptr2->)
				If (Find in array:C230($ptr2->;0)#-1)
					DELETE FROM ARRAY:C228($ptr2->;Find in array:C230($ptr2->;0);1)
				End if 
				ACTter_Datos_ALP ("ValidaIdsCargas";$ptr1;$ptr2;$ptr3;$ptr4)
			End if 
		End if 
		
	: ($vt_accion="ValidaIdsCargas")
		READ ONLY:C145([ACT_CuentasCorrientes:175])
		If ((Not:C34(Is nil pointer:C315($ptr3))) & (Not:C34(Is nil pointer:C315($ptr4))))
			ARRAY LONGINT:C221($al_nivelNumero;0)
			AT_RedimArrays (Size of array:C274($ptr2->);$ptr3;$ptr4;->$al_nivelNumero)
		End if 
		For ($i;Size of array:C274($ptr2->);1;-1)
			$vl_idCuenta:=$ptr2->{$i}
			KRL_FindAndLoadRecordByIndex (->[ACT_CuentasCorrientes:175]ID:1;->$vl_idCuenta)
			If (Records in selection:C76([ACT_CuentasCorrientes:175])=0)
				AT_Delete ($i;1;$ptr2)
				If ($vl_idCuenta>0)
					ACTter_Datos_ALP ("EliminaRegistrosCuentas";->$vl_idCuenta)
				End if 
			Else 
				If ((Not:C34(Is nil pointer:C315($ptr3))) & (Not:C34(Is nil pointer:C315($ptr4))))
					READ ONLY:C145([ACT_CuentasCorrientes:175])
					READ ONLY:C145([Alumnos:2])
					KRL_FindAndLoadRecordByIndex (->[ACT_CuentasCorrientes:175]ID:1;->$vl_idCuenta)
					$al_nivelNumero{$i}:=KRL_GetNumericFieldData (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3;->[Alumnos:2]nivel_numero:29)
					$vt_curso:=KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3;->[Alumnos:2]curso:20)
					$ptr3->{$i}:=$vt_curso
					QUERY:C277([Cursos:3];[Cursos:3]Curso:1=$vt_curso)
					If ([Cursos:3]Sede:19#"")
						$ptr3->{$i}:=$ptr3->{$i}+" - "+[Cursos:3]Sede:19
					End if 
					$ptr4->{$i}:=KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3;->[Alumnos:2]apellidos_y_nombres:40)
					  //End for 
				End if 
			End if 
		End for 
		  //If ((Not(Nil($ptr3))) & (Not(Nil($ptr4))))
		  //SORT ARRAY($al_nivelNumero;$ptr3->;$ptr4->;$ptr2->;>)
		  //Else 
		  //End if 
		
	: ($vt_accion="EliminaRegistrosCuentasCtes")
		READ ONLY:C145([ACT_Terceros:138])
		ARRAY LONGINT:C221($al_idsTerceros;0)
		QUERY:C277([ACT_Terceros_Pactado:139];[ACT_Terceros_Pactado:139]Id_CuentaCorriente:3=$ptr1->)
		AT_DistinctsFieldValues (->[ACT_Terceros_Pactado:139]Id_Tercero:2;->$al_idsTerceros)
		For ($i;1;Size of array:C274($al_idsTerceros))
			QUERY:C277([ACT_Terceros:138];[ACT_Terceros:138]Id:1=$al_idsTerceros{$i})
			ACTter_Datos_ALP ("EliminaRegistrosCuentas";$ptr1)
		End for 
		
	: ($vt_accion="EliminaRegistrosCuentas")
		READ WRITE:C146([ACT_Terceros_Pactado:139])
		QUERY:C277([ACT_Terceros_Pactado:139];[ACT_Terceros_Pactado:139]Id_Tercero:2=[ACT_Terceros:138]Id:1;*)
		QUERY:C277([ACT_Terceros_Pactado:139]; & ;[ACT_Terceros_Pactado:139]Id_CuentaCorriente:3=$ptr1->)
		If (Records in selection:C76([ACT_Terceros_Pactado:139])>0)
			DELETE SELECTION:C66([ACT_Terceros_Pactado:139])
			$vl_idAlumno:=KRL_GetNumericFieldData (->[ACT_CuentasCorrientes:175]ID:1;$ptr1;->[ACT_CuentasCorrientes:175]ID_Alumno:3)
			KRL_FindAndLoadRecordByIndex (->[Alumnos:2]numero:1;->$vl_idAlumno)
			LOG_RegisterEvt ("Cuenta Corriente "+ST_Qte ([Alumnos:2]apellidos_y_nombres:40)+" desasociada del tercero "+[ACT_Terceros:138]Nombre_Completo:9)
		End if 
		KRL_UnloadReadOnly (->[ACT_Terceros_Pactado:139])
		
	: ($vt_accion="BuscaCargaItemsXCta")
		QUERY:C277([ACT_Terceros_Pactado:139];[ACT_Terceros_Pactado:139]Id_Tercero:2=$ptr1->;*)
		QUERY:C277([ACT_Terceros_Pactado:139]; & ;[ACT_Terceros_Pactado:139]Id_CuentaCorriente:3>0;*)
		QUERY:C277([ACT_Terceros_Pactado:139]; & ;[ACT_Terceros_Pactado:139]Id_ItemDeCargo:4>0)
		ORDER BY:C49([ACT_Terceros_Pactado:139];[ACT_Terceros_Pactado:139]Id_CuentaCorriente:3;>;[ACT_Terceros_Pactado:139]Id_ItemDeCargo:4;>;[ACT_Terceros_Pactado:139]Monto_Pactado_Fijo:5;>;[ACT_Terceros_Pactado:139]Monto_Pactado_PCT:6;>)
		SELECTION TO ARRAY:C260([ACT_Terceros_Pactado:139]Id_CuentaCorriente:3;$ptr2->;[ACT_Terceros_Pactado:139]Id_ItemDeCargo:4;$ptr3->)
		
	: ($vt_accion="LeeCuentasXItems")
		If ($ptr1->>0)
			ARRAY LONGINT:C221($al_idsCtas;0)
			ARRAY LONGINT:C221($al_idsItems;0)
			ACTter_Datos_ALP ("BuscaCargaItemsXCta";$ptr1;->$al_idsCtas;->$al_idsItems)
			SELECTION TO ARRAY:C260([ACT_Terceros_Pactado:139]Monto_Pactado_Fijo:5;$ptr5->;[ACT_Terceros_Pactado:139]Monto_Pactado_PCT:6;$ptr6->)
			SELECTION TO ARRAY:C260([ACT_Terceros_Pactado:139]Id:1;$ptr7->;[ACT_Terceros_Pactado:139]Utilizar_Conf:10;$ptr10->)
			ACTter_Datos_ALP ("ValidaIdsItems";$ptr1;->$al_idsItems;$ptr2)
			ACTter_Datos_ALP ("ValidaIdsCargas";$ptr1;->$al_idsCtas;$ptr4;$ptr3)
			AT_RedimArrays (Size of array:C274($ptr5->);$ptr9;$ptr8)
			For ($i;1;Size of array:C274($al_idsItems))
				$ptr2->{$i}:=String:C10($al_idsItems{$i})+" - "+$ptr2->{$i}
				$vl_idItem:=$al_idsItems{$i}
				$ptr9->{$i}:=KRL_GetBooleanFieldData (->[xxACT_Items:179]ID:1;->$vl_idItem;->[xxACT_Items:179]EsRelativo:5)
				If ($ptr10->{$i})
					GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";$ptr8->{$i})
				Else 
					GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";$ptr8->{$i})
				End if 
			End for 
		End if 
	: ($vt_accion="AplicaMontos")
		If (btn_todas=1)
			For ($i;1;Size of array:C274(alACT_IdCXI))
				If (Not:C34(abACT_RelativoCXI{$i}))
					If ((vr_montoFijo>=0) & (cs_Fijo=1))
						arACT_MontoFijoCXI{$i}:=vr_montoFijo
					End if 
					If ((vr_montoPct>=0) & (cs_Pct=1))
						arACT_MontoPctCXI{$i}:=vr_montoPct
					End if 
					ACTter_Datos_ALP ("Guarda";->$i)
				End if 
			End for 
		Else 
			ARRAY LONGINT:C221($al_idsCXI;0)
			ARRAY INTEGER:C220($ai_lines;0)
			$line:=AL_GetSelect ($ptr1->;$ai_lines)
			For ($i;1;Size of array:C274($ai_lines))
				QUERY:C277([ACT_Terceros_Pactado:139];[ACT_Terceros_Pactado:139]Id_Tercero:2=[ACT_Terceros:138]Id:1;*)
				QUERY:C277([ACT_Terceros_Pactado:139]; & ;$ptr2->=$ptr3->{$ai_lines{$i}})
				While (Not:C34(End selection:C36([ACT_Terceros_Pactado:139])))
					APPEND TO ARRAY:C911($al_idsCXI;[ACT_Terceros_Pactado:139]Id:1)
					NEXT RECORD:C51([ACT_Terceros_Pactado:139])
				End while 
			End for 
			For ($i;1;Size of array:C274($al_idsCXI))
				$pos:=Find in array:C230(alACT_IdCXI;$al_idsCXI{$i})
				If ($pos>0)
					If (Not:C34(abACT_RelativoCXI{$pos}))
						If ((vr_montoFijo>=0) & (cs_Fijo=1))
							arACT_MontoFijoCXI{$pos}:=vr_montoFijo
						End if 
						If ((vr_montoPct>=0) & (cs_Pct=1))
							arACT_MontoPctCXI{$pos}:=vr_montoPct
						End if 
					End if 
				End if 
				ACTter_Datos_ALP ("Guarda";->$pos)
			End for 
		End if 
		
	: ($vt_accion="CreaRegistro")
		$key:=String:C10($ptr1->)+"."+String:C10($ptr2->)+"."+String:C10($ptr3->)
		$existe:=Find in field:C653([ACT_Terceros_Pactado:139]Key:7;$key)
		If ($existe=-1)
			READ WRITE:C146([ACT_Terceros_Pactado:139])
			CREATE RECORD:C68([ACT_Terceros_Pactado:139])
			[ACT_Terceros_Pactado:139]Id:1:=SQ_SeqNumber (->[ACT_Terceros_Pactado:139]Id:1)
			[ACT_Terceros_Pactado:139]Id_CuentaCorriente:3:=$ptr1->
			[ACT_Terceros_Pactado:139]Id_ItemDeCargo:4:=$ptr2->
			[ACT_Terceros_Pactado:139]Id_Tercero:2:=$ptr3->
			[ACT_Terceros_Pactado:139]Key:7:=String:C10([ACT_Terceros_Pactado:139]Id_CuentaCorriente:3)+"."+String:C10([ACT_Terceros_Pactado:139]Id_ItemDeCargo:4)+"."+String:C10([ACT_Terceros_Pactado:139]Id_Tercero:2)
			[ACT_Terceros_Pactado:139]Utilizar_Conf:10:=True:C214
			SAVE RECORD:C53([ACT_Terceros_Pactado:139])
			KRL_UnloadReadOnly (->[ACT_Terceros_Pactado:139])
			Case of 
				: (($ptr1->#0) & ($ptr2->=0))
					$vl_idAlumno:=KRL_GetNumericFieldData (->[ACT_CuentasCorrientes:175]ID:1;$ptr1;->[ACT_CuentasCorrientes:175]ID_Alumno:3)
					KRL_FindAndLoadRecordByIndex (->[Alumnos:2]numero:1;->$vl_idAlumno)
					LOG_RegisterEvt ("Cuenta Corriente "+ST_Qte ([Alumnos:2]apellidos_y_nombres:40)+" asociada del tercero "+[ACT_Terceros:138]Nombre_Completo:9)
					
				: (($ptr1->=0) & ($ptr2->#0))
					LOG_RegisterEvt ("Ítem de cargo "+ST_Qte (KRL_GetTextFieldData (->[xxACT_Items:179]ID:1;$ptr2;->[xxACT_Items:179]Glosa:2))+" asociado del tercero "+[ACT_Terceros:138]Nombre_Completo:9)
					
			End case 
		End if 
		
	: ($vt_accion="AsociaItems")
		QUERY:C277([ACT_Terceros_Pactado:139];[ACT_Terceros_Pactado:139]Id_Tercero:2=[ACT_Terceros:138]Id:1;*)
		QUERY:C277([ACT_Terceros_Pactado:139]; & ;[ACT_Terceros_Pactado:139]Id_CuentaCorriente:3>0)
		If (Records in selection:C76([ACT_Terceros_Pactado:139])>0)
			ARRAY LONGINT:C221($al_idsCtas;0)
			$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Asociando Items..."))
			AT_DistinctsFieldValues (->[ACT_Terceros_Pactado:139]Id_CuentaCorriente:3;->$al_idsCtas)
			For ($i;1;Size of array:C274($al_idsCtas))
				$vl_idCtaCte:=$al_idsCtas{$i}
				ACTter_Datos_ALP ("CreaRegistro";->$vl_idCtaCte;$ptr1;->[ACT_Terceros:138]Id:1)
				$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($al_idsCtas);__ ("Asociando Items..."))
			End for 
			$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		End if 
		$vl_idCtaCte:=0
		ACTter_Datos_ALP ("CreaRegistro";->$vl_idCtaCte;$ptr1;->[ACT_Terceros:138]Id:1)
		  //End if 
		
	: ($vt_accion="AsociaCuentas")
		QUERY:C277([ACT_Terceros_Pactado:139];[ACT_Terceros_Pactado:139]Id_Tercero:2=[ACT_Terceros:138]Id:1;*)
		QUERY:C277([ACT_Terceros_Pactado:139]; & ;[ACT_Terceros_Pactado:139]Id_ItemDeCargo:4>0)
		If (Records in selection:C76([ACT_Terceros_Pactado:139])>0)
			ARRAY LONGINT:C221($al_idsItems;0)
			AT_DistinctsFieldValues (->[ACT_Terceros_Pactado:139]Id_ItemDeCargo:4;->$al_idsItems)
			For ($i;1;Size of array:C274($al_idsItems))
				$vl_idItem:=$al_idsItems{$i}
				ACTter_Datos_ALP ("CreaRegistro";$ptr1;->$vl_idItem;->[ACT_Terceros:138]Id:1)
			End for 
		End if 
		  //cuando se crean registros de cuentas ctes y no hay ítems asociados al tercero, se crea el registro con id de ítem 0
		$vl_idItem:=0
		ACTter_Datos_ALP ("CreaRegistro";$ptr1;->$vl_idItem;->[ACT_Terceros:138]Id:1)
		  //End if 
		
	: ($vt_accion="Guarda")
		If ($ptr1->>0)
			$vl_idRecord:=alACT_IdCXI{$ptr1->}
			REDUCE SELECTION:C351([ACT_Terceros_Pactado:139];0)
			KRL_FindAndLoadRecordByIndex (->[ACT_Terceros_Pactado:139]Id:1;->$vl_idRecord;True:C214)
			If (ok=1)
				$vr_montoFijo:=[ACT_Terceros_Pactado:139]Monto_Pactado_Fijo:5
				$vr_montoPct:=[ACT_Terceros_Pactado:139]Monto_Pactado_PCT:6
				$vb_utilizar:=[ACT_Terceros_Pactado:139]Utilizar_Conf:10
				[ACT_Terceros_Pactado:139]Monto_Pactado_Fijo:5:=arACT_MontoFijoCXI{$ptr1->}
				[ACT_Terceros_Pactado:139]Monto_Pactado_PCT:6:=arACT_MontoPctCXI{$ptr1->}
				[ACT_Terceros_Pactado:139]Utilizar_Conf:10:=abACT_ActivoCXI{$ptr1->}
				SAVE RECORD:C53([ACT_Terceros_Pactado:139])
				If (($vr_montoFijo#0) | ($vr_montoPct#0))
					If (($vr_montoPct#[ACT_Terceros_Pactado:139]Monto_Pactado_PCT:6) & ($vr_montoPct#0))
						$vl_idAlumno:=KRL_GetNumericFieldData (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Terceros_Pactado:139]Id_CuentaCorriente:3;->[ACT_CuentasCorrientes:175]ID_Alumno:3)
						LOG_RegisterEvt ("Cambio en monto pactado porcentaje para el ítem "+KRL_GetTextFieldData (->[xxACT_Items:179]ID:1;->[ACT_Terceros_Pactado:139]Id_ItemDeCargo:4;->[xxACT_Items:179]Glosa:2)+" del alumno: "+KRL_GetTextFieldData (->[Alumnos:2]numero:1;->$vl_idAlumno;->[Alumnos:2]apellidos_y_nombres:40)+". Cambió de "+String:C10($vr_montoPct)+" a "+String:C10([ACT_Terceros_Pactado:139]Monto_Pactado_PCT:6))
					End if 
					If (($vr_montoFijo#[ACT_Terceros_Pactado:139]Monto_Pactado_Fijo:5) & ($vr_montoFijo#0))
						$vl_idAlumno:=KRL_GetNumericFieldData (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Terceros_Pactado:139]Id_CuentaCorriente:3;->[ACT_CuentasCorrientes:175]ID_Alumno:3)
						LOG_RegisterEvt ("Cambio en monto pactado fijo para el ítem "+KRL_GetTextFieldData (->[xxACT_Items:179]ID:1;->[ACT_Terceros_Pactado:139]Id_ItemDeCargo:4;->[xxACT_Items:179]Glosa:2)+" del alumno: "+KRL_GetTextFieldData (->[Alumnos:2]numero:1;->$vl_idAlumno;->[Alumnos:2]apellidos_y_nombres:40)+". Cambió de "+String:C10($vr_montoFijo;"|Despliegue_ACT_Pagos")+" a "+String:C10([ACT_Terceros_Pactado:139]Monto_Pactado_Fijo:5;"|Despliegue_ACT_Pagos"))
					End if 
				End if 
				If (($vb_utilizar#[ACT_Terceros_Pactado:139]Utilizar_Conf:10))
					$vl_idAlumno:=KRL_GetNumericFieldData (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Terceros_Pactado:139]Id_CuentaCorriente:3;->[ACT_CuentasCorrientes:175]ID_Alumno:3)
					LOG_RegisterEvt ("Terceros: Ítem "+KRL_GetTextFieldData (->[xxACT_Items:179]ID:1;->[ACT_Terceros_Pactado:139]Id_ItemDeCargo:4;->[xxACT_Items:179]Glosa:2)+" del alumno: "+KRL_GetTextFieldData (->[Alumnos:2]numero:1;->$vl_idAlumno;->[Alumnos:2]apellidos_y_nombres:40)+". Cambió de "+ST_Boolean2Str ($vb_utilizar;ST_Qte ("Utlizada");ST_Qte ("No Utlizada"))+" a "+ST_Boolean2Str ([ACT_Terceros_Pactado:139]Utilizar_Conf:10;ST_Qte ("Utlizada");ST_Qte ("No Utlizada")))
				End if 
			End if 
			KRL_UnloadReadOnly (->[ACT_Terceros_Pactado:139])
		End if 
		
	: ($vt_accion="SetColoresArea")
		For ($i;1;Size of array:C274($ptr2->))
			READ ONLY:C145([xxACT_Items:179])
			$vl_idItem:=$ptr2->{$i}
			KRL_FindAndLoadRecordByIndex (->[xxACT_Items:179]ID:1;->$vl_idItem)
			If ([xxACT_Items:179]EsDescuento:6)
				AL_SetRowColor ($ptr1->;$i;"Red";0)
				If ([xxACT_Items:179]EsRelativo:5)
					AL_SetRowStyle ($ptr1->;$i;2;"")
				End if 
			Else 
				AL_SetRowColor ($ptr1->;$i;"Black";0)
				If ([xxACT_Items:179]EsRelativo:5)
					AL_SetRowStyle ($ptr1->;$i;2;"")
				End if 
			End if 
		End for 
		AL_UpdateArrays ($ptr1->;-1)
		
	: ($vt_accion="SetColoresAreaCtaXItem")
		ARRAY LONGINT:C221($al_idsCtas;0)
		ARRAY LONGINT:C221($al_idsItems;0)
		ACTter_Datos_ALP ("BuscaCargaItemsXCta";->[ACT_Terceros:138]Id:1;->$al_idsCtas;->$al_idsItems)
		ACTter_Datos_ALP ("SetColoresArea";$ptr1;->$al_idsItems)
		
	: ($vt_accion="DeclaraArraysAreaInscAlumnos")
		ARRAY TEXT:C222(atACT_CCAlumno;0)
		ARRAY TEXT:C222(atACT_CCCurso;0)
		ARRAY LONGINT:C221(aIDsAlumnos;0)
		
End case 