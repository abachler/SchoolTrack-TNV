//%attributes = {}
  //ACTpgs_ReciboDocAgrupado

C_LONGINT:C283($idApo0;$idApo1)
C_LONGINT:C283($noapo)
C_TEXT:C284($fpago0;$fpago1)
C_LONGINT:C283($x;$j;$i)
C_TEXT:C284(t_aACT_chNosSerie)
C_TEXT:C284(vt_aACT_chFecha)
C_TEXT:C284(vt_aACT_ApdosDPPagadoCargo)
C_TEXT:C284(vt_aACT_chBanco)
C_TEXT:C284(vt_aACT_chTitular)
C_TEXT:C284(vt_MontoPagado)

READ ONLY:C145([ACT_Transacciones:178])
READ ONLY:C145([Personas:7])
READ ONLY:C145([ACT_CuentasCorrientes:175])
READ ONLY:C145([ACT_Pagos:172])
READ ONLY:C145([ACT_Cargos:173])
READ ONLY:C145([Alumnos:2])
READ ONLY:C145([ACT_Documentos_de_Pago:176])
READ ONLY:C145([ACT_CuentasCorrientes:175])

If (Records in selection:C76([ACT_Pagos:172])>0)
	SELECTION TO ARRAY:C260([ACT_Pagos:172];$at_Pagos)
	For ($i;1;Size of array:C274($at_Pagos))  //valido que hayan pagos de sólo un apoderado
		GOTO RECORD:C242([ACT_Pagos:172];$at_Pagos{$i})
		QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_Pagos:172]ID_Apoderado:3)
		If ($i=1)
			$idApo0:=[Personas:7]No:1
			$noapo:=0
		Else 
			$idApo1:=[Personas:7]No:1
			If ($idApo0#$idApo1)
				$noapo:=1
				$i:=Size of array:C274($at_Pagos)
			End if 
		End if 
	End for 
	
	If ($noapo=0)  //valido que hayan sólo pagos con Cheque
		For ($i;1;Size of array:C274($at_Pagos))
			GOTO RECORD:C242([ACT_Pagos:172];$at_Pagos{$i})
			If ($i=1)
				$fpago0:=[ACT_Pagos:172]forma_de_pago_new:31
				$fpa:=0
			Else 
				$fpago1:=[ACT_Pagos:172]forma_de_pago_new:31
				If ($fpago0#$fpago1)
					$fpa:=1
					$i:=Size of array:C274($at_Pagos)
				End if 
			End if 
		End for 
		
		If ($fpa=0)
			ARRAY DATE:C224(aACT_ApdosDPFecha;0)
			ARRAY TEXT:C222(aACT_ApdosDPPeriodo;0)
			ARRAY TEXT:C222(aACT_ApdosDPAlumno;0)
			ARRAY REAL:C219(aACT_ApdosDPMonto;0)
			ARRAY REAL:C219(aACT_ApdosDPSaldoCargo;0)
			ARRAY TEXT:C222(aACT_ApdosDPGlosaCargo;0)
			ARRAY LONGINT:C221(aACT_ApdosDPIDItem;0)
			ARRAY REAL:C219(aACT_ApdosDPPagadoCargo;0)
			ARRAY TEXT:C222(aACT_chNosSerie;0)
			ARRAY DATE:C224(aACT_chFecha;0)
			ARRAY TEXT:C222(aACT_chTitular;0)
			ARRAY TEXT:C222(aACT_chBanco;0)
			
			$size:=Size of array:C274($at_Pagos)
			
			ARRAY TEXT:C222(aACT_chBanco;$size)
			ARRAY TEXT:C222(aACT_chTitular;$size)
			ARRAY DATE:C224(aACT_chFecha;$size)
			ARRAY TEXT:C222(aACT_chNosSerie;$size)
			ARRAY REAL:C219(aACT_ApdosDPPagadoCargo;$size)
			
			ARRAY LONGINT:C221($al_trIDCta;0)
			ARRAY LONGINT:C221($al_trItem;0)
			vMontoPagado:=0
			For ($j;1;Size of array:C274($at_Pagos))
				GOTO RECORD:C242([ACT_Pagos:172];$at_Pagos{$j})
				QUERY:C277([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]ID:1=[ACT_Pagos:172]ID_DocumentodePago:6)
				aACT_chNosSerie{$j}:=[ACT_Documentos_de_Pago:176]NoSerie:12
				aACT_chFecha{$j}:=[ACT_Documentos_de_Pago:176]Fecha:13
				aACT_ApdosDPPagadoCargo{$j}:=[ACT_Documentos_de_Pago:176]MontoPago:6
				aACT_chTitular{$j}:=[ACT_Documentos_de_Pago:176]Titular:9
				aACT_chBanco{$j}:=[ACT_Documentos_de_Pago:176]Ch_BancoNombre:7
				vMontoPagado:=vMontoPagado+[ACT_Documentos_de_Pago:176]MontoPago:6
				
				QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4=[ACT_Pagos:172]ID:1;*)
				QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4#0)
				SELECTION TO ARRAY:C260([ACT_Transacciones:178];$al_IDtr)
				For ($i;1;Size of array:C274($al_IDtr))
					AT_Insert (0;1;->aACT_ApdosDPFecha;->aACT_ApdosDPPeriodo;->aACT_ApdosDPMonto;->aACT_ApdosDPAlumno;->aACT_ApdosDPSaldoCargo;->aACT_ApdosDPGlosaCargo)
					INSERT IN ARRAY:C227($al_trIDCta;Size of array:C274($al_trIDCta)+1;1)
					INSERT IN ARRAY:C227($al_trItem;Size of array:C274($al_trItem)+1;1)
					GOTO RECORD:C242([ACT_Transacciones:178];$al_IDtr{$i})
					aACT_ApdosDPFecha{Size of array:C274(aACT_ApdosDPFecha)}:=[ACT_Transacciones:178]Fecha:5
					aACT_ApdosDPPeriodo{Size of array:C274(aACT_ApdosDPPeriodo)}:=[ACT_Transacciones:178]RefPeriodo:12
					aACT_ApdosDPMonto{Size of array:C274(aACT_ApdosDPMonto)}:=[ACT_Transacciones:178]Debito:6
					$al_trIDCta{Size of array:C274($al_trIDCta)}:=[ACT_Transacciones:178]ID_CuentaCorriente:2
					$al_trItem{Size of array:C274($al_trItem)}:=[ACT_Transacciones:178]ID_Item:3
					
					QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=$al_trIDCta{Size of array:C274($al_trIDCta)})
					QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
					aACT_ApdosDPAlumno{Size of array:C274(aACT_ApdosDPAlumno)}:=[Alumnos:2]apellidos_y_nombres:40
					
					QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID:1=$al_trItem{Size of array:C274($al_trItem)})
					aACT_ApdosDPSaldoCargo{Size of array:C274(aACT_ApdosDPSaldoCargo)}:=[ACT_Cargos:173]Saldo:23
					aACT_ApdosDPGlosaCargo{Size of array:C274(aACT_ApdosDPGlosaCargo)}:=[ACT_Cargos:173]Glosa:12
				End for 
			End for 
			
			AT_DistinctsArrayValues (->aACT_chBanco)
			AT_DistinctsArrayValues (->aACT_chTitular)
			vt_aACT_ApdosDPPagadoCargo:=""
			For ($v;1;Size of array:C274(aACT_ApdosDPPagadoCargo))
				vt_aACT_ApdosDPPagadoCargo:=vt_aACT_ApdosDPPagadoCargo+String:C10(aACT_ApdosDPPagadoCargo{$v};"|Despliegue_ACT")+" - "
			End for 
			vt_aACT_ApdosDPPagadoCargo:=Substring:C12(vt_aACT_ApdosDPPagadoCargo;1;Length:C16(vt_aACT_ApdosDPPagadoCargo)-3)
			
			vt_aACT_chNosSerie:=AT_array2text (->aACT_chNosSerie;" - ")
			vt_aACT_chFecha:=AT_array2text (->aACT_chFecha;" - ")
			vt_aACT_chBanco:=AT_array2text (->aACT_chBanco;" - ")
			vt_aACT_chTitular:=AT_array2text (->aACT_chTitular;" - ")
		Else 
			CD_Dlog (1;__ ("No todos los pagos tienen la forma de pago Cheque."))
		End if 
	Else 
		CD_Dlog (1;__ ("Hay Pagos para más de un apoderado."))
	End if 
Else 
	CD_Dlog (0;__ ("No hay Pagos seleccionados."))
End if 
ok:=1