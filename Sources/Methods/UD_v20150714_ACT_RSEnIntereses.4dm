//%attributes = {}
  //UD_v20150714_ACT_RSEnIntereses

READ ONLY:C145([ACT_Cargos:173])
READ ONLY:C145([ACT_Transacciones:178])
READ ONLY:C145([ACT_Boletas:181])

ARRAY LONGINT:C221(aQR_Longint1;0)
ARRAY LONGINT:C221(aQR_Longint2;0)
ARRAY LONGINT:C221(aQR_Longint3;0)
ARRAY LONGINT:C221(aQR_Longint4;0)
ARRAY LONGINT:C221(aQR_Longint5;0)

C_LONGINT:C283($l_indice)
C_REAL:C285($r_idRS)
C_LONGINT:C283($l_proc)

$l_proc:=IT_UThermometer (1;0;"Buscando cargos...")
QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CargoRelacionado:47#0;*)
  //QUERY([ACT_Cargos]; & ;[ACT_Cargos]Saldo#0;*) //20150825 RCH Si el interés está pagado no se asignaría correctamente el id...
QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Ref_Item:16=-100)

  //filtro para que se haga solo para desde el año anterior
QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22>=DT_GetDateFromDayMonthYear (1;1;Year of:C25(Current date:C33(*))-1))

CREATE SET:C116([ACT_Cargos:173];"setCargos")

KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
KRL_RelateSelection (->[ACT_Boletas:181]ID:1;->[ACT_Transacciones:178]No_Boleta:9;"")

KRL_RelateSelection (->[ACT_Transacciones:178]No_Boleta:9;->[ACT_Boletas:181]ID:1;"")
KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")

CREATE SET:C116([ACT_Cargos:173];"setCargos2")

  //quito cargos en boletas
DIFFERENCE:C122("setCargos";"setCargos2";"setCargos")
USE SET:C118("setCargos")

  //quito boletas que tienen id razon social en 0
SELECTION TO ARRAY:C260([ACT_Cargos:173]ID:1;aQR_Longint3;[ACT_Cargos:173]ID_CargoRelacionado:47;aQR_Longint2)
QUERY WITH ARRAY:C644([ACT_Cargos:173]ID:1;aQR_Longint2)
QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_RazonSocial:57#0)
SELECTION TO ARRAY:C260([ACT_Cargos:173]ID:1;aQR_Longint4)
QUERY WITH ARRAY:C644([ACT_Cargos:173]ID_CargoRelacionado:47;aQR_Longint4)
SELECTION TO ARRAY:C260([ACT_Cargos:173]ID:1;aQR_Longint4)

AT_intersect (->aQR_Longint3;->aQR_Longint4;->aQR_Longint5)
QUERY WITH ARRAY:C644([ACT_Cargos:173]ID:1;aQR_Longint5)
SET_ClearSets ("setCargos";"setCargos2")

IT_UThermometer (-2;$l_proc)


$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Verificando id de Razón Social en cargos de intereses...")
LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];aQR_Longint1;"")
For ($l_indice;1;Size of array:C274(aQR_Longint1))
	READ WRITE:C146([ACT_Cargos:173])
	GOTO RECORD:C242([ACT_Cargos:173];aQR_Longint1{$l_indice})
	$r_idRS:=KRL_GetNumericFieldData (->[ACT_Cargos:173]ID:1;->[ACT_Cargos:173]ID_CargoRelacionado:47;->[ACT_Cargos:173]ID_RazonSocial:57)
	READ WRITE:C146([ACT_Cargos:173])
	GOTO RECORD:C242([ACT_Cargos:173];aQR_Longint1{$l_indice})
	If ([ACT_Cargos:173]ID_RazonSocial:57#$r_idRS)
		[ACT_Cargos:173]ID_RazonSocial:57:=$r_idRS
	End if 
	SAVE RECORD:C53([ACT_Cargos:173])
	KRL_UnloadReadOnly (->[ACT_Cargos:173])
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$l_indice/Size of array:C274(aQR_Longint1))
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)