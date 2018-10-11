//%attributes = {}
  //ACTpgs_CreateCargoIntInArrays

C_LONGINT:C283($location)
C_REAL:C285($monto;$1)
C_BOOLEAN:C305($createNew;$ok)
C_LONGINT:C283(vl_cargosEliminados)
C_BOOLEAN:C305(vb_interesBorrado)
C_BOOLEAN:C305(vbACTpgs_PagoXTercero)
C_BOOLEAN:C305($b_afecto)  //20170410 RCH

$monto:=$1
$idcargo:=$2
$fecha:=$3
If (Count parameters:C259>=4)
	$b_afecto:=$4
End if 

$ok:=True:C214
If ($monto>0)
	
	If (vb_interesBorrado)
		$el1:=Find in array:C230(adACT_fInteresBorrado;$fecha)
		$el2:=Find in array:C230(alACT_idInteresBorrado;$idcargo)
		$el3:=Find in array:C230(arACT_mInteresBorrado;$monto)
		
		If (($el1#-1) & ($el2#-1) & ($el3#-1))
			Case of 
				: (($el1>=$el2) & ($el1>=$el3))
					$ok:=Not:C34((adACT_fInteresBorrado{$el1}=$fecha) & (alACT_idInteresBorrado{$el1}=$idcargo) & (arACT_mInteresBorrado{$el1}=$monto))
				: (($el2>=$el1) & ($el2>=$el3))
					$ok:=Not:C34((adACT_fInteresBorrado{$el2}=$fecha) & (alACT_idInteresBorrado{$el2}=$idcargo) & (arACT_mInteresBorrado{$el2}=$monto))
				: (($el3>=$el2) & ($el3>=$el2))
					$ok:=Not:C34((adACT_fInteresBorrado{$el3}=$fecha) & (alACT_idInteresBorrado{$el3}=$idcargo) & (arACT_mInteresBorrado{$el3}=$monto))
			End case 
			If (Not:C34($ok))
				vl_cargosEliminados:=vl_cargosEliminados+1
				If (vl_cargosEliminados<=Size of array:C274(adACT_fInteresBorrado))
					$ok:=False:C215
				Else 
					$ok:=True:C214
				End if 
			End if 
		End if 
	End if 
	If ($ok)
		$createNew:=False:C215
		ACTpgs_LoadInteresRecord 
		$location:=[xxACT_Items:179]UbicacionInteresGenerado:30
		Case of 
			: ($location ?? 1)
				QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1;*)
				QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]No_Comprobante:10#0)
				QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Aviso:1=[ACT_Transacciones:178]No_Comprobante:10)
				If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])#1)
					$createNew:=True:C214
				End if 
			: ($location ?? 2)
				CREATE SELECTION FROM ARRAY:C640([ACT_Avisos_de_Cobranza:124];alACT_RecNumsAvisos;"")
				If (vbACTpgs_PagoXTercero)
					QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Tercero:26=[ACT_Terceros:138]Id:1)  //al crear un aviso para intereses, se crea un recnum 0 y para ese recnum0 se intentaban ir los intereses. Se filtro por el numero de apdo.
				Else 
					QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3=[Personas:7]No:1)  //al crear un aviso para intereses, se crea un recnum 0 y para ese recnum0 se intentaban ir los intereses. Se filtro por el numero de apdo.
				End if 
				QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3=[Personas:7]No:1)  //al crear un aviso para intereses, se crea un recnum 0 y para ese recnum0 se intentaban ir los intereses. Se filtro por el numero de apdo.
				ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Agno:7;>;[ACT_Avisos_de_Cobranza:124]Mes:6;>;[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14;>)
				If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])>0)
					FIRST RECORD:C50([ACT_Avisos_de_Cobranza:124])
					While (([ACT_Avisos_de_Cobranza:124]Fecha_Emision:4<=[ACT_Cargos:173]FechaEmision:22) & (Not:C34(End selection:C36([ACT_Avisos_de_Cobranza:124]))))
						NEXT RECORD:C51([ACT_Avisos_de_Cobranza:124])
					End while 
					While (([ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14=0) & (Not:C34(End selection:C36([ACT_Avisos_de_Cobranza:124]))))
						NEXT RECORD:C51([ACT_Avisos_de_Cobranza:124])
					End while 
					If (Not:C34(End selection:C36([ACT_Avisos_de_Cobranza:124])))
						ONE RECORD SELECT:C189([ACT_Avisos_de_Cobranza:124])
					Else 
						$createNew:=True:C214
					End if 
				Else 
					$createNew:=True:C214
				End if 
			: ($location ?? 3)
				CREATE SELECTION FROM ARRAY:C640([ACT_Avisos_de_Cobranza:124];alACT_RecNumsAvisos;"")
				If (vbACTpgs_PagoXTercero)
					QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Tercero:26=[ACT_Terceros:138]Id:1)  //al crear un aviso para intereses, se crea un recnum 0 y para ese recnum0 se intentaban ir los intereses. Se filtro por el numero de apdo.
				Else 
					QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3=[Personas:7]No:1)  //al crear un aviso para intereses, se crea un recnum 0 y para ese recnum0 se intentaban ir los intereses. Se filtro por el numero de apdo.
				End if 
				QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3=[Personas:7]No:1)  //al crear un aviso para intereses, se crea un recnum 0 y para ese recnum0 se intentaban ir los intereses. Se filtro por el numero de apdo.
				ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Agno:7;<;[ACT_Avisos_de_Cobranza:124]Mes:6;<;[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14;>)
				If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])>0)
					FIRST RECORD:C50([ACT_Avisos_de_Cobranza:124])
					While (([ACT_Avisos_de_Cobranza:124]Fecha_Emision:4<=[ACT_Cargos:173]FechaEmision:22) & (Not:C34(End selection:C36([ACT_Avisos_de_Cobranza:124]))))
						NEXT RECORD:C51([ACT_Avisos_de_Cobranza:124])
					End while 
					While (([ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14=0) & (Not:C34(End selection:C36([ACT_Avisos_de_Cobranza:124]))))
						NEXT RECORD:C51([ACT_Avisos_de_Cobranza:124])
					End while 
					If (Not:C34(End selection:C36([ACT_Avisos_de_Cobranza:124])))
						ONE RECORD SELECT:C189([ACT_Avisos_de_Cobranza:124])
					Else 
						$createNew:=True:C214
					End if 
				Else 
					$createNew:=True:C214
				End if 
			: ($location ?? 4)
				$createNew:=True:C214
			Else 
				$createNew:=True:C214
		End case 
		C_LONGINT:C283($el)
		If ($createNew)
			
			alACT_AIDAviso{0}:=0
			ARRAY LONGINT:C221($DA_Return;0)
			AT_SearchArray (->alACT_AIDAviso;"<";->$DA_Return)
			If (Size of array:C274($DA_Return)=0)
				$date:=Current date:C33(*)
				$fechaVencimiento:=ACTut_fFechaValida ($date+viACT_DiaVencimiento)
				$fechaPago2:=ACTut_fFechaValida ($fechaVencimiento+viACT_DiaVencimiento2)
				$fechaPago3:=ACTut_fFechaValida ($fechaPago2+viACT_DiaVencimiento3)
				$fechaPago4:=ACTut_fFechaValida ($fechaPago3+viACT_DiaVencimiento4)
				
				  //AT_Insert (0;1;->alACT_AIDAviso;->adACT_AFechaEmision;->adACT_AFechaVencimiento;->arACT_ASaldoAnterior;->arACT_AIntereses;->arACT_AMontoaPagar;->atACT_AMoneda;->arACT_AMontoMoneda;->alACT_RecNumsAvisos;->alACT_AIDAvisoOrder;->abACT_ASelectedAvisos;->apACT_ASelectedAvisos;->arACT_AMontoAfecto;->arACT_AMontoBruto;->arACT_AMontoIVA;->arACT_AMontoNeto)
				$vl_donde:=0
				ACTpgs_ArreglosAvisos ("InsertaElemento";->$vl_donde)
				
				For ($i;-1;-1000;-1)
					$el:=Find in array:C230(alACT_AIDAviso;$i)
					If ($el=-1)
						alACT_AIDAviso{Size of array:C274(alACT_AIDAviso)}:=$i
						$i:=-1000
					End if 
				End for 
				adACT_AFechaEmision{Size of array:C274(adACT_AFechaEmision)}:=$date
				adACT_AFechaVencimiento{Size of array:C274(adACT_AFechaVencimiento)}:=$fechaVencimiento
				atACT_AMoneda{Size of array:C274(atACT_AMoneda)}:=<>vsACT_MonedaColegio
				If (Size of array:C274(alACT_AIDAviso)>1)
					arACT_ASaldoAnterior{Size of array:C274(arACT_ASaldoAnterior)}:=arACT_ASaldoAnterior{Size of array:C274(arACT_ASaldoAnterior)-1}
				End if 
				abACT_ASelectedAvisos{Size of array:C274(arACT_AMontoMoneda)}:=False:C215
				GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";apACT_ASelectedAvisos{Size of array:C274(arACT_AMontoMoneda)})
				$el:=Size of array:C274(alACT_AIDAviso)
			Else 
				$el:=$DA_Return{1}
			End if 
		Else 
			$el:=Find in array:C230(alACT_AIDAviso;[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
		End if 
		For ($i;1;Size of array:C274(ap_arrays2Pay))
			AT_Insert (0;1;ap_arrays2Pay{$i})
		End for 
		READ ONLY:C145([ACT_CuentasCorrientes:175])
		READ ONLY:C145([Alumnos:2])
		QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=[ACT_Cargos:173]ID_CuentaCorriente:2)
		alACT_CIDCtaCte{Size of array:C274(alACT_CIDCtaCte)}:=[ACT_CuentasCorrientes:175]ID:1
		QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
		atACT_CAlumno{Size of array:C274(atACT_CAlumno)}:=[Alumnos:2]apellidos_y_nombres:40
		alACT_CidCargoGenInt{Size of array:C274(alACT_CidCargoGenInt)}:=$idcargo
		adACT_CfechaInteres{Size of array:C274(adACT_CfechaInteres)}:=$fecha
		alACT_CRefs{Size of array:C274(alACT_CRefs)}:=[xxACT_Items:179]ID:1
		atACT_CGlosa{Size of array:C274(atACT_CGlosa)}:=[xxACT_Items:179]Glosa:2
		arACT_MontoMoneda{Size of array:C274(arACT_MontoMoneda)}:=Abs:C99($monto)
		arACT_CMontoNeto{Size of array:C274(arACT_CMontoNeto)}:=Abs:C99($monto)
		arACT_CSaldo{Size of array:C274(arACT_CSaldo)}:=$monto*-1
		abACT_ASelectedCargo{Size of array:C274(abACT_ASelectedCargo)}:=False:C215
		GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";apACT_ASelectedCargo{Size of array:C274(apACT_ASelectedCargo)})
		For ($i;-1;-1000;-1)
			$le:=Find in array:C230(alACT_RecNumsCargos;$i)
			If ($le=-1)
				alACT_RecNumsCargos{Size of array:C274(alACT_RecNumsCargos)}:=$i
				$i:=-1000
			End if 
		End for 
		$afecto:=arACT_CMontoNeto{Size of array:C274(arACT_CMontoNeto)}/<>vrACT_FactorIVA
		  //If ([xxACT_Items]Afecto_IVA)
		If (((<>bint_AfectoExentoSegunCargo=1) & ($b_afecto)) | ((<>bint_AfectoExentoSegunCargo=0) & ([xxACT_Items:179]Afecto_IVA:12)))
			arACT_MontoIVA{Size of array:C274(arACT_MontoIVA)}:=Round:C94($afecto*<>vrACT_TasaIVA/100;<>vlACT_Decimales)
			arACT_CMontoAfecto{Size of array:C274(arACT_CMontoAfecto)}:=arACT_CMontoNeto{Size of array:C274(arACT_CMontoNeto)}-arACT_MontoIVA{Size of array:C274(arACT_MontoIVA)}
		End if 
		
		atACT_MonedaCargo{Size of array:C274(atACT_MonedaCargo)}:=[xxACT_Items:179]Moneda:10
		atACT_MonedaSimbolo{Size of array:C274(atACT_MonedaSimbolo)}:=""
		ACTpgs_SimboloMoneda 
		
		If ($el>0)
			adACT_CFechaEmision{Size of array:C274(adACT_CFechaEmision)}:=adACT_AFechaEmision{$el}
			adACT_CFechaVencimiento{Size of array:C274(adACT_CFechaVencimiento)}:=adACT_AFechaVencimiento{$el}
			alACT_CIdsAvisos{Size of array:C274(alACT_CIdsAvisos)}:=alACT_AIDAviso{$el}
		End if 
	End if 
End if 