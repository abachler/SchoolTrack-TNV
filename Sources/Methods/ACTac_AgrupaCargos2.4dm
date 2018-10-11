//%attributes = {}
  //ACTac_AgrupaCargos2

ARRAY TEXT:C222(atACT_GlosaImpAvisos;0)
ARRAY REAL:C219(arACT_MontosAvisos;0)
_O_ARRAY STRING:C218(2;asACT_AfectoAvisos;0)
ARRAY REAL:C219(arACT_MontosPagadosAvisos;0)
ARRAY LONGINT:C221($aProcessedRefs;0)
ARRAY TEXT:C222($aProcessedGlosas;0)
  //20130626 RCH NF CANTIDAD
ARRAY LONGINT:C221(alACT_Cantidad;0)
ARRAY REAL:C219(arACT_Cantidad;0)
ARRAY REAL:C219(arACT_Unitario;0)
$ProcessedEspeciales:=False:C215
$ProcessedExcedentes:=False:C215
$monto:=0
$montoPagado:=0

For ($i;1;Size of array:C274(alACT_CRefs))
	Case of 
		: (alACT_CRefs{$i}=-1)
			If (Not:C34($ProcessedEspeciales))
				alACT_CRefs{0}:=alACT_CRefs{$i}
				ARRAY LONGINT:C221($DA_Return;0)
				AT_SearchArray (->alACT_CRefs;"=";->$DA_Return)
				ARRAY TEXT:C222(aEspecialesGlosa;Size of array:C274($DA_Return))
				ARRAY REAL:C219($aEspecialesMonto;Size of array:C274($DA_Return))
				_O_ARRAY STRING:C218(2;$aEspecialesAfecto;Size of array:C274($DA_Return))
				ARRAY REAL:C219($aEspecialesMontosPagados;Size of array:C274($DA_Return))
				For ($j;1;Size of array:C274($DA_Return))
					aEspecialesGlosa{$j}:=atACT_CGlosaImpresion{$DA_Return{$j}}
					$aEspecialesMonto{$j}:=arACT_CMontoNeto{$DA_Return{$j}}
					$aEspecialesAfecto{$j}:=asACT_Afecto{$DA_Return{$j}}
					$aEspecialesMontosPagados{$j}:=arACT_MontoPagado{$DA_Return{$j}}
				End for 
				For ($k;1;Size of array:C274(aEspecialesGlosa))
					$Processed:=Find in array:C230($aProcessedGlosas;aEspecialesGlosa{$k})
					If ($Processed=-1)
						aEspecialesGlosa{0}:=aEspecialesGlosa{$k}
						ARRAY LONGINT:C221($DA_Return;0)
						AT_SearchArray (->aEspecialesGlosa;"=";->$DA_Return)
						For ($j;1;Size of array:C274($DA_Return))
							$monto:=$monto+$aEspecialesMonto{$DA_Return{$j}}
							$montoPagado:=$montoPagado+$aEspecialesMontosPagados{$DA_Return{$j}}
						End for 
						INSERT IN ARRAY:C227($aProcessedGlosas;1;1)
						$aProcessedGlosas{1}:=aEspecialesGlosa{$k}
						AT_Insert (0;1;->atACT_GlosaImpAvisos;->arACT_MontosAvisos;->asACT_AfectoAvisos;->arACT_MontosPagadosAvisos;->arACT_Cantidad;->arACT_Unitario)
						atACT_GlosaImpAvisos{Size of array:C274(atACT_GlosaImpAvisos)}:=aEspecialesGlosa{$k}
						arACT_MontosAvisos{Size of array:C274(arACT_MontosAvisos)}:=$monto
						asACT_AfectoAvisos{Size of array:C274(asACT_AfectoAvisos)}:=$aEspecialesAfecto{$k}
						arACT_MontosPagadosAvisos{Size of array:C274(arACT_MontosPagadosAvisos)}:=$montoPagado
						arACT_Cantidad{Size of array:C274(arACT_Cantidad)}:=Size of array:C274($DA_Return)
						arACT_Unitario{Size of array:C274(arACT_Unitario)}:=arACT_CMontoNeto{$DA_Return{1}}
					End if 
					$monto:=0
					$montoPagado:=0
				End for 
			End if 
		: (alACT_CRefs{$i}=-2)
			If (Not:C34($ProcessedExcedentes))
				alACT_CRefs{0}:=alACT_CRefs{$i}
				ARRAY LONGINT:C221($DA_Return;0)
				AT_SearchArray (->alACT_CRefs;"=";->$DA_Return)
				For ($j;1;Size of array:C274($DA_Return))
					$monto:=$monto+arACT_CMontoNeto{$DA_Return{$j}}
					$montoPagado:=$montoPagado+arACT_MontoPagado{$DA_Return{$j}}
				End for 
				AT_Insert (0;1;->atACT_GlosaImpAvisos;->arACT_MontosAvisos;->asACT_AfectoAvisos;->arACT_MontosPagadosAvisos;->arACT_Cantidad;->arACT_Unitario)
				atACT_GlosaImpAvisos{Size of array:C274(atACT_GlosaImpAvisos)}:=atACT_CGlosaImpresion{$i}
				arACT_MontosAvisos{Size of array:C274(arACT_MontosAvisos)}:=$monto
				asACT_AfectoAvisos{Size of array:C274(asACT_AfectoAvisos)}:=asACT_Afecto{$i}
				arACT_MontosPagadosAvisos{Size of array:C274(arACT_MontosPagadosAvisos)}:=$montoPagado
				arACT_Cantidad{Size of array:C274(arACT_Cantidad)}:=Size of array:C274($DA_Return)
				arACT_Unitario{Size of array:C274(arACT_Unitario)}:=arACT_CMontoNeto{$DA_Return{1}}
			End if 
			$monto:=0
			$montoPagado:=0
		Else 
			$Processed:=Find in array:C230($aProcessedRefs;alACT_CRefs{$i})
			If ($Processed=-1)
				alACT_CRefs{0}:=alACT_CRefs{$i}
				AT_SearchArray (->alACT_CRefs;"=")
				For ($j;1;Size of array:C274($DA_Return))
					$monto:=$monto+arACT_CMontoNeto{$DA_Return{$j}}
					$montoPagado:=$montoPagado+arACT_MontoPagado{$DA_Return{$j}}
				End for 
				INSERT IN ARRAY:C227($aProcessedRefs;1;1)
				$aProcessedRefs{1}:=alACT_CRefs{$i}
				AT_Insert (0;1;->atACT_GlosaImpAvisos;->arACT_MontosAvisos;->asACT_AfectoAvisos;->arACT_MontosPagadosAvisos;->arACT_Cantidad;->arACT_Unitario)
				atACT_GlosaImpAvisos{Size of array:C274(atACT_GlosaImpAvisos)}:=atACT_CGlosaImpresion{$i}
				arACT_MontosAvisos{Size of array:C274(arACT_MontosAvisos)}:=$monto
				asACT_AfectoAvisos{Size of array:C274(asACT_AfectoAvisos)}:=asACT_Afecto{$i}
				arACT_MontosPagadosAvisos{Size of array:C274(arACT_MontosPagadosAvisos)}:=$montoPagado
				arACT_Cantidad{Size of array:C274(arACT_Cantidad)}:=Size of array:C274($DA_Return)
				arACT_Unitario{Size of array:C274(arACT_Unitario)}:=arACT_CMontoNeto{$DA_Return{1}}
			End if 
			$monto:=0
			$montoPagado:=0
	End case 
End for 
AT_Initialize (->atACT_CGlosaImpresion;->arACT_CMontoNeto;->asACT_Afecto;->arACT_MontoPagado)
COPY ARRAY:C226(atACT_GlosaImpAvisos;atACT_CGlosaImpresion)
COPY ARRAY:C226(arACT_MontosAvisos;arACT_CMontoNeto)
COPY ARRAY:C226(asACT_AfectoAvisos;asACT_Afecto)
COPY ARRAY:C226(arACT_MontosPagadosAvisos;arACT_MontoPagado)