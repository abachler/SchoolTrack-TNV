//%attributes = {}
  //ACTpgs_LoadDesgloseArrays

ACTcfg_OpcionesDetallePagos ("LeeBlob")

ARRAY DATE:C224(aACT_ApdosDPFecha;0)
ARRAY TEXT:C222(aACT_ApdosDPPeriodo;0)
ARRAY TEXT:C222(aACT_ApdosDPAlumno;0)
ARRAY REAL:C219(aACT_ApdosDPMonto;0)
ARRAY REAL:C219(aACT_ApdosDPSaldoCargo;0)
ARRAY REAL:C219(aACT_ApdosDPPagadoCargo;0)
ARRAY LONGINT:C221(aACT_ApdosDPIDItem;0)
ARRAY TEXT:C222(aACT_ApdosDPGlosaCargo;0)
ARRAY LONGINT:C221(aIDCta;0)
ARRAY PICTURE:C279(aACT_ApdosDPAfectoPict;0)
ARRAY LONGINT:C221(aACT_ApdosDPRefItem;0)
READ ONLY:C145([ACT_Transacciones:178])

If (csACTcfg_MostrarDctos=0)
	QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4=[ACT_Pagos:172]ID:1;*)
	QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4#0;*)
	  //20110812 RCH Cuando se tiene una forma de pago "Descuento por planilla", las transacciones no son encontradas y 
	  //el despliegue del pago no es correcto dentro de la ficha.
	  //QUERY([ACT_Transacciones]; & ;[ACT_Transacciones]Glosa#"Pago con Des@") 
	QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]Glosa:8#"Pago con Descuento")
Else 
	QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4=[ACT_Pagos:172]ID:1;*)
	QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4#0)
End if 

ORDER BY:C49([ACT_Transacciones:178];[ACT_Transacciones:178]Debito:6;<)
SELECTION TO ARRAY:C260([ACT_Transacciones:178]Fecha:5;aACT_ApdosDPFecha;[ACT_Transacciones:178]RefPeriodo:12;aACT_ApdosDPPeriodo;[ACT_Transacciones:178]Debito:6;aACT_ApdosDPMonto;[ACT_Transacciones:178]ID_CuentaCorriente:2;aIDCta;[ACT_Transacciones:178]ID_Item:3;aACT_ApdosDPIDItem)
ARRAY TEXT:C222(aACT_ApdosDPAlumno;Size of array:C274(aIDCta))
ARRAY REAL:C219(aACT_ApdosDPSaldoCargo;Size of array:C274(aIDCta))
ARRAY REAL:C219(aACT_ApdosDPPagadoCargo;Size of array:C274(aIDCta))
ARRAY TEXT:C222(aACT_ApdosDPGlosaCargo;Size of array:C274(aIDCta))
ARRAY PICTURE:C279(aACT_ApdosDPAfectoPict;Size of array:C274(aIDCta))
ARRAY LONGINT:C221(aACT_ApdosDPRefItem;Size of array:C274(aIDCta))
READ ONLY:C145([Alumnos:2])
For ($i;1;Size of array:C274(aIDCta))
	QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=aIDCta{$i})
	QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
	aACT_ApdosDPAlumno{$i}:=[Alumnos:2]apellidos_y_nombres:40
	QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID:1=aACT_ApdosDPIDItem{$i})
	aACT_ApdosDPSaldoCargo{$i}:=[ACT_Cargos:173]Saldo:23
	aACT_ApdosDPPagadoCargo{$i}:=[ACT_Cargos:173]MontosPagados:8
	aACT_ApdosDPGlosaCargo{$i}:=[ACT_Cargos:173]Glosa:12
	aACT_ApdosDPRefItem{$i}:=[ACT_Cargos:173]Ref_Item:16
	If ([ACT_Cargos:173]TasaIVA:21>0)
		GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";aACT_ApdosDPAfectoPict{$i})
	Else 
		GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";aACT_ApdosDPAfectoPict{$i})
	End if 
	If ([ACT_Cargos:173]Monto_Neto:5<0)
		aACT_ApdosDPGlosaCargo{$i}:="Pago con Descuento"
		If ([ACT_Cargos:173]TasaIVA:21>0)
			aACT_ApdosDPGlosaCargo{$i}:=aACT_ApdosDPGlosaCargo{$i}+" "+__ ("afecto")
		Else 
			aACT_ApdosDPGlosaCargo{$i}:=aACT_ApdosDPGlosaCargo{$i}+" "+__ ("exento")
		End if 
		If (csACTcfg_MostrarDctos=1)
			aACT_ApdosDPMonto{$i}:=aACT_ApdosDPMonto{$i}*-1
		End if 
	End if 
End for 

If (csACTcfg_MostrarDctos=1)
	  //***** INICIO AGRUPA CARGOS MISMO ID ITEM MISMO PERIODO *****
	ARRAY LONGINT:C221($aACT_pos2Delete;0)
	ARRAY LONGINT:C221($alACT_pos1;0)
	ARRAY LONGINT:C221($alACT_pos2;0)
	ARRAY LONGINT:C221($alACT_pos3;0)
	For ($i;1;Size of array:C274(aACT_ApdosDPFecha))
		If (Find in array:C230($aACT_pos2Delete;$i)=-1)
			aACT_ApdosDPIDItem{0}:=aACT_ApdosDPIDItem{$i}
			AT_SearchArray (->aACT_ApdosDPIDItem;"=";->$alACT_pos1)
			aACT_ApdosDPPeriodo{0}:=aACT_ApdosDPPeriodo{$i}
			AT_SearchArray (->aACT_ApdosDPPeriodo;"=";->$alACT_pos2)
			AT_intersect (->$alACT_pos1;->$alACT_pos2;->$alACT_pos3)
			If (Size of array:C274($alACT_pos3)>1)
				For ($j;2;Size of array:C274($alACT_pos3))
					APPEND TO ARRAY:C911($aACT_pos2Delete;$alACT_pos3{$j})
					aACT_ApdosDPMonto{$i}:=aACT_ApdosDPMonto{$i}+aACT_ApdosDPMonto{$alACT_pos3{$j}}
				End for 
			End if 
		End if 
	End for 
	SORT ARRAY:C229($aACT_pos2Delete;>)
	For ($i;Size of array:C274($aACT_pos2Delete);1;-1)
		AT_Delete ($aACT_pos2Delete{$i};1;->aACT_ApdosDPFecha;->aACT_ApdosDPPeriodo;->aACT_ApdosDPAlumno;->aACT_ApdosDPMonto;->aACT_ApdosDPSaldoCargo;->aACT_ApdosDPPagadoCargo;->aACT_ApdosDPIDItem;->aACT_ApdosDPGlosaCargo;->aIDCta;->aACT_ApdosDPAfectoPict;->aACT_ApdosDPRefItem)
	End for 
	  //***** FIN AGRUPA CARGOS MISMO ID ITEM MISMO PERIODO *****
End if 

  //***** INICIO AGRUPA CARGOS  *****
ARRAY LONGINT:C221($aACT_pos2Delete;0)
ARRAY LONGINT:C221($alACT_pos1;0)
ARRAY LONGINT:C221($alACT_idsCargos;0)
ACTpgs_LoadInteresRecord 
If ([xxACT_Items:179]AgruparInteresesDT:34)
	APPEND TO ARRAY:C911($alACT_idsCargos;[xxACT_Items:179]ID:1)
End if 
If ((csACTcfg_MostrarDctos=1) & (csACTcfg_AgruparDctosEnCaja=1))
	APPEND TO ARRAY:C911($alACT_idsCargos;-1)
	APPEND TO ARRAY:C911($alACT_idsCargos;-10)
End if 
For ($i;1;Size of array:C274($alACT_idsCargos))
	aACT_ApdosDPRefItem{0}:=$alACT_idsCargos{$i}
	AT_SearchArray (->aACT_ApdosDPRefItem;"=";->$alACT_pos1)
	If (Size of array:C274($alACT_pos1)>1)
		For ($j;2;Size of array:C274($alACT_pos1))
			APPEND TO ARRAY:C911($aACT_pos2Delete;$alACT_pos1{$j})
			aACT_ApdosDPMonto{$alACT_pos1{1}}:=aACT_ApdosDPMonto{$alACT_pos1{1}}+aACT_ApdosDPMonto{$alACT_pos1{$j}}
			aACT_ApdosDPPagadoCargo{$alACT_pos1{1}}:=aACT_ApdosDPPagadoCargo{$alACT_pos1{1}}+aACT_ApdosDPPagadoCargo{$alACT_pos1{$j}}
			
			  //20170124 RCH No se estaba sumando correctamente.
			  //aACT_ApdosDPSaldoCargo{$alACT_pos1{1}}:=aACT_ApdosDPSaldoCargo{$alACT_pos1{1}}+aACT_ApdosDPSaldoCargo{$i}
			aACT_ApdosDPSaldoCargo{$alACT_pos1{1}}:=aACT_ApdosDPSaldoCargo{$alACT_pos1{1}}+aACT_ApdosDPSaldoCargo{$alACT_pos1{$j}}
			
		End for 
		aACT_ApdosDPAlumno{$alACT_pos1{1}}:=""
		aACT_ApdosDPAfectoPict{$alACT_pos1{1}}:=aACT_ApdosDPAfectoPict{$alACT_pos1{1}}*0
	End if 
End for 

SORT ARRAY:C229($aACT_pos2Delete;>)
For ($i;Size of array:C274($aACT_pos2Delete);1;-1)
	AT_Delete ($aACT_pos2Delete{$i};1;->aACT_ApdosDPFecha;->aACT_ApdosDPPeriodo;->aACT_ApdosDPAlumno;->aACT_ApdosDPMonto;->aACT_ApdosDPSaldoCargo;->aACT_ApdosDPPagadoCargo;->aACT_ApdosDPIDItem;->aACT_ApdosDPGlosaCargo;->aIDCta;->aACT_ApdosDPAfectoPict;->aACT_ApdosDPRefItem)
End for 
  //***** FIN AGRUPA CARGOS  *****