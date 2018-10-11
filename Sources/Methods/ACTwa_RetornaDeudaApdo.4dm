//%attributes = {}
  //ACTwa_RetornaDeudaApdo 


C_LONGINT:C283($l_id)
C_DATE:C307($d_fecha)
C_TEXT:C284($t_tipo)
C_BOOLEAN:C305($b_continuar;$b_mesAbierto)
C_REAL:C285(RNApdo;RNCta)
C_LONGINT:C283(RNTercero)
C_TEXT:C284($json)
C_REAL:C285($r_fdp)

ACTcfg_LoadBancos 

RNApdo:=-1
RNCta:=-1
RNTercero:=-1
$b_continuar:=True:C214


$t_tipo:=$1
$l_id:=$2
$d_fecha:=$3
$r_fdp:=$4

If ($t_tipo="")
	$t_tipo:="apoderado"
End if 

If (Is compiled mode:C492)
	If (($l_id=0) | ($d_fecha=!00-00-00!))
		$b_continuar:=False:C215
	End if 
Else 
	If ($l_id=0)
		$l_id:=1112
	End if 
	If ($d_fecha=!00-00-00!)
		$d_fecha:=Current date:C33(*)
	End if 
End if 

READ ONLY:C145([ACT_CuentasCorrientes:175])
READ ONLY:C145([Alumnos:2])

If ($b_continuar)
	$b_mesAbierto:=ACTcm_IsMonthOpenFromDate ($d_fecha)
	If ($b_mesAbierto)
		Case of 
			: ($t_tipo="apoderado")
				RNApdo:=KRL_FindAndLoadRecordByIndex (->[Personas:7]No:1;->$l_id;False:C215)
			: ($t_tipo="cuenta")
				RNCta:=KRL_FindAndLoadRecordByIndex (->[ACT_CuentasCorrientes:175]ID:1;->$l_id;False:C215)
			: ($t_tipo="tercero")
				RNTercero:=KRL_FindAndLoadRecordByIndex (->[ACT_Terceros:138]Id:1;->$l_id;False:C215)
		End case 
		
		If ((RNApdo#-1) | (RNCta#-1) | (RNTercero#-1))
			ACTpgs_LimpiaVarsInterfaz ("SetVarsIngresoPago")
			
			Case of 
				: ($t_tipo="apoderado")
					ACTpgs_CargaDatosPagoApdo (False:C215;$d_fecha)
				: ($t_tipo="cuenta")
					ACTpgs_CargaDatosPagoCta (False:C215;$d_fecha)
				: ($t_tipo="tercero")
					ACTpgs_CargaDatosPagoTercero (False:C215;$d_fecha)
			End case 
			
			ARRAY TEXT:C222($atACT_AFechaEmision;0)
			ARRAY TEXT:C222($atACT_AFechaVencimiento;0)
			
			For ($i;1;Size of array:C274(adACT_AFechaEmision))
				APPEND TO ARRAY:C911($atACT_AFechaEmision;ACTwa_MakeDateWP (adACT_AFechaEmision{$i}))
				APPEND TO ARRAY:C911($atACT_AFechaVencimiento;ACTwa_MakeDateWP (adACT_AFechaVencimiento{$i}))
			End for 
			
			  //20151224 RCH Si viene fdp se calcula y agregan elementos a arreglo
			If ($r_fdp#0)
				ACTfdp_OpcionesRecargos ("CalculaMulaArreglosPago";->$r_fdp;->$d_fecha)
			End if 
			
			  //calculando deuda para actualizar arreglos neto, intereses y a pagar
			ARRAY LONGINT:C221($DA_Return;0)
			C_REAL:C285($vrACT_SeleccionadoExento;$vrACT_SeleccionadoAfecto)
			
			For ($l_indiceAC;1;Size of array:C274(alACT_AIDAviso))
				alACT_CIdsAvisos{0}:=alACT_AIDAviso{$l_indiceAC}
				AT_SearchArray (->alACT_CIdsAvisos;"=";->$DA_Return)
				For ($l_indice;1;Size of array:C274($DA_Return))
					If (alACT_CRefs{$DA_Return{$l_indice}}#-100)
						abACT_ASelectedCargo{$DA_Return{$l_indice}}:=True:C214
					Else 
						abACT_ASelectedCargo{$DA_Return{$l_indice}}:=False:C215
					End if 
				End for 
				$vrACT_SeleccionadoExento:=0
				$vrACT_SeleccionadoAfecto:=0
				arACT_AMontoNeto{$l_indiceAC}:=ACTpgs_RetornaMontoXAviso ("MontoDesdeNoAvisos";True:C214;String:C10(alACT_AIDAviso{$l_indiceAC});$d_fecha;->$vrACT_SeleccionadoAfecto;->$vrACT_SeleccionadoExento)
				For ($l_indice;1;Size of array:C274($DA_Return))
					If (alACT_CRefs{$DA_Return{$l_indice}}=-100)
						abACT_ASelectedCargo{$DA_Return{$l_indice}}:=True:C214
					Else 
						abACT_ASelectedCargo{$DA_Return{$l_indice}}:=False:C215
					End if 
				End for 
				$vrACT_SeleccionadoExento:=0
				$vrACT_SeleccionadoAfecto:=0
				arACT_AIntereses{$l_indiceAC}:=ACTpgs_RetornaMontoXAviso ("MontoDesdeNoAvisos";True:C214;String:C10(alACT_AIDAviso{$l_indiceAC});$d_fecha;->$vrACT_SeleccionadoAfecto;->$vrACT_SeleccionadoExento)
				arACT_AMontoMoneda{$l_indiceAC}:=arACT_AMontoNeto{$l_indiceAC}+arACT_AIntereses{$l_indiceAC}
			End for 
			
			  //$deuda:=JSON New 
			  //$node:=JSON Append long array ($deuda;"ids";alACT_AIDAviso)
			  //$node:=JSON Append text array ($deuda;"emision";$atACT_AFechaEmision)
			  //$node:=JSON Append text array ($deuda;"vencimiento";$atACT_AFechaVencimiento)
			  //$node:=JSON Append real array ($deuda;"neto";arACT_AMontoNeto)
			  //$node:=JSON Append real array ($deuda;"intereses";arACT_AIntereses)
			  //$node:=JSON Append real array ($deuda;"anterior";arACT_ASaldoAnterior)
			  //$node:=JSON Append real array ($deuda;"apagar";arACT_AMontoMoneda)
			  //$node:=JSON Append text array ($deuda;"moneda";atACT_AMoneda)
			  //$json:=JSON Export to text ($deuda;JSON_WITHOUT_WHITE_SPACE)
			
			
			
			  // Modificado por: Alexis Bustamante (10-06-2017)
			  //TICKET Ticket 179869
			
			C_OBJECT:C1216($ob_raiz;$ob_estado)
			C_TEXT:C284($vt_descripcion)
			C_LONGINT:C283($vl_codigo)
			
			$ob_raiz:=OB_Create 
			$ob_estado:=OB_Create 
			$ob_avisos:=OB_Create 
			
			$vl_codigo:=0
			$vt_descripcion:=""
			
			OB_SET ($ob_estado;->$vl_codigo;"codigo")
			OB_SET ($ob_estado;->$vt_descripcion;"descripcion")
			OB_SET ($ob_raiz;->$ob_estado;"estado")
			
			OB_SET ($ob_avisos;->alACT_AIDAviso;"ids")
			OB_SET ($ob_avisos;->$atACT_AFechaEmision;"emision")
			OB_SET ($ob_avisos;->$atACT_AFechaVencimiento;"vencimiento")
			OB_SET ($ob_avisos;->arACT_AMontoNeto;"neto")
			OB_SET ($ob_avisos;->arACT_AIntereses;"intereses")
			OB_SET ($ob_avisos;->arACT_ASaldoAnterior;"anterior")
			OB_SET ($ob_avisos;->arACT_AMontoMoneda;"apagar")
			
			  //$t_principal:=JSON New 
			  //$t_err:=JSON Append node ($t_principal;"estado")
			  //$node:=JSON Append real ($t_err;"codigo";0)
			  //$node:=JSON Append text ($t_err;"descripcion";"")
			
			  //$t_avisos:=JSON Append node ($t_principal;"avisos")
			  //$node:=JSON Append long array ($t_avisos;"ids";alACT_AIDAviso)
			  //$node:=JSON Append text array ($t_avisos;"emision";$atACT_AFechaEmision)
			  //$node:=JSON Append text array ($t_avisos;"vencimiento";$atACT_AFechaVencimiento)
			  //$node:=JSON Append real array ($t_avisos;"neto";arACT_AMontoNeto)
			  //$node:=JSON Append real array ($t_avisos;"intereses";arACT_AIntereses)
			  //$node:=JSON Append real array ($t_avisos;"anterior";arACT_ASaldoAnterior)
			  //$node:=JSON Append real array ($t_avisos;"apagar";arACT_AMontoMoneda)
			
			  //20150303 RCH Los montos usados en SN siempre son en la moneda del pais. Se asigna siempre la moneda del pais para ser consistente con el despligue
			For ($i;1;Size of array:C274(atACT_AMoneda))
				atACT_AMoneda{$i}:=ST_GetWord (ACT_DivisaPais ;1;";")
			End for 
			OB_SET ($ob_avisos;->atACT_AMoneda;"moneda")
			
			  //$node:=JSON Append text array ($t_avisos;"moneda";atACT_AMoneda)
			
			  //20140908 RCH Detalle de pagos WP
			C_BOOLEAN:C305(vbACT_CargosDesdeAviso;vbACT_CargosDesdeItems;vbACT_CargosDesdeAlumnos;vbACT_CargosDesdeAgrupado)
			C_TEXT:C284($json2;$err)
			C_LONGINT:C283($l_indiceAvisos)
			vbACT_CargosDesdeAviso:=True:C214
			ACTpgs_CopiaArreglosCargos 
			
			
			C_OBJECT:C1216($ob_conceptos)
			ARRAY OBJECT:C1221($ao_conceptos;0)
			  //$json2:=JSON Append node ($t_avisos;"conceptos")
			
			For ($l_indiceAvisos;1;Size of array:C274(alACT_AIDAviso))
				ACTpgs_SeleccionaCargosAviso ($l_indiceAvisos)
				
				$ob_conceptos:=OB_Create 
				OB_SET ($ob_conceptos;->atACT_CAlumno;"alumnos")
				OB_SET ($ob_conceptos;->atACT_CGlosa;"cargos")
				OB_SET ($ob_conceptos;->arACT_CMontoNeto;"netos")
				OB_SET ($ob_conceptos;->arACT_CSaldo;"saldos")
				
				  //$err:=JSON Append node ($json2;"o2")
				  //$node:=JSON Append text array ($err;"alumnos";atACT_CAlumno)
				  //$node:=JSON Append text array ($err;"cargos";atACT_CGlosa)
				  //$node:=JSON Append real array ($err;"netos";arACT_CMontoNeto)
				  //$node:=JSON Append real array ($err;"saldos";arACT_CSaldo)
				
				  //20150303 RCH Se agrega moneda a detalle de cargos
				ARRAY TEXT:C222($atACT_moneda;0)
				
				  //  //20151203 RCH Ticket 151095 Numero de matricula
				ARRAY TEXT:C222($atACT_recNum;0)
				For ($l_indiceCargos;1;Size of array:C274(alACT_CIdsCargos))
					$b_emitidoEnMoneda:=KRL_GetBooleanFieldData (->[ACT_Cargos:173]ID:1;->alACT_CIdsCargos{$l_indiceCargos};->[ACT_Cargos:173]EmitidoSegúnMonedaCargo:11)
					APPEND TO ARRAY:C911($atACT_moneda;Choose:C955($b_emitidoEnMoneda;KRL_GetTextFieldData (->[ACT_Cargos:173]ID:1;->alACT_CIdsCargos{$l_indiceCargos};->[ACT_Cargos:173]Moneda:28);ST_GetWord (ACT_DivisaPais ;1)))
					
					KRL_FindAndLoadRecordByIndex (->[ACT_CuentasCorrientes:175]ID:1;->alACT_CIDCtaCte{$l_indiceCargos})
					APPEND TO ARRAY:C911($atACT_recNum;KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3;->[Alumnos:2]numero_de_matricula:51))
					
				End for 
				  //$node:=JSON Append text array ($err;"monedas";$atACT_moneda)
				OB_SET ($ob_conceptos;->$atACT_moneda;"monedas")
				
				  //  //20151203 RCH Ticket 151095 Numero de matricula
				  //$node:=JSON Append text array ($err;"matricula";$atACT_recNum)
				OB_SET ($ob_conceptos;->$atACT_recNum;"matricula")
				
				
				APPEND TO ARRAY:C911($ao_conceptos;$ob_conceptos)
				CLEAR VARIABLE:C89($ob_conceptos)
			End for 
			OB_SET ($ob_avisos;->$ao_conceptos;"conceptos")
			OB_SET ($ob_raiz;->$ob_avisos;"avisos")
			  //20140908 RCH Detalle de pagos WP
			$json:=OB_Object2Json ($ob_raiz)
			
			  //20140908 RCH Limpio arreglos
			ACTpgs_DeclaraArreglosCargosT 
			ACTpgs_DeclareArraysAvisos 
			  //20140908 RCH Limpio arreglos
		Else 
			  //no fue encontrado el apoderado
			$json:=ACTwa_RespuestaError (-7)
		End if 
	Else 
		  //fecha cerrada
		$json:=ACTwa_RespuestaError (-8)
	End if 
Else 
	  //devolver json con error... Viene id en 0 o fecha vacia
	Case of 
		: ($l_id=0)
			$json:=ACTwa_RespuestaError (-9)
		: ($d_fecha=!00-00-00!)
			$json:=ACTwa_RespuestaError (-10)
	End case 
End if 
$0:=$json