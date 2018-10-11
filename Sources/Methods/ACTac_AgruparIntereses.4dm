//%attributes = {}
  //ACTac_AgruparIntereses

$index:=-1
For ($i;1;Size of array:C274(alACT_CRefs))
	If (alACT_CRefs{$i}=-100)
		$index:=$i
		$i:=Size of array:C274(alACT_CRefs)+1
	End if 
End for 
If ($index#-1)
	For ($i;Size of array:C274(alACT_CRefs);1;-1)
		If ($i#$index)
			If (alACT_CRefs{$i}=-100)
				arACT_CMontoNeto{$index}:=arACT_CMontoNeto{$index}+arACT_CMontoNeto{$i}
				arACT_MontoPagado{$index}:=arACT_MontoPagado{$index}+arACT_MontoPagado{$i}
				  //AT_Delete ($i;1;->atACT_CGlosaImpresion;->arACT_CMontoNeto;->asACT_Afecto;->arACT_MontoPagado;->arACT_CTotalDesctos;->alACT_CRefs)
				  //20130626 RCH NF CANTIDAD
				  //AT_Delete ($i;1;->adACT_CFechaEmision;->adACT_CFechaVencimiento;->atACT_CAlumno;->atACT_CAlumnoCurso;->atACT_CAlumnoNivelNombre;->atACT_CAlumnoPCurso;->atACT_CAlumnoPNivelNombre;->atACT_CGlosa;->arACT_CMontoNeto;->arACT_CIntereses;->arACT_CSaldo;->alACT_RecNumsCargos;->alACT_CRefs;->alACT_CIDCtaCte;->asACT_Marcas;->arACT_MontoMoneda;->atACT_MonedaCargo;->atACT_MonedaSimbolo;->atACT_CGlosaImpresion;->asACT_Afecto;->arACT_TasaIVA;->arACT_MontoPagado;->arACT_MontoIVA;->arACT_CTotalDesctos;->aIDCta;->arACT_Cantidad;->arACT_Unitario;->alACT_MesCargo;->alACT_AñoCargo;->atACT_MesCargo;->atACT_AñoCargo)
				  //20150912 RCH Unidad
				  //AT_Delete ($i;1;->adACT_CFechaEmision;->adACT_CFechaVencimiento;->atACT_CAlumno;->atACT_CAlumnoCurso;->atACT_CAlumnoNivelNombre;->atACT_CAlumnoPCurso;->atACT_CAlumnoPNivelNombre;->atACT_CGlosa;->arACT_CMontoNeto;->arACT_CIntereses;->arACT_CSaldo;->alACT_RecNumsCargos;->alACT_CRefs;->alACT_CIDCtaCte;->asACT_Marcas;->arACT_MontoMoneda;->atACT_MonedaCargo;->atACT_MonedaSimbolo;->atACT_CGlosaImpresion;->asACT_Afecto;->arACT_TasaIVA;->arACT_MontoPagado;->arACT_MontoIVA;->arACT_CTotalDesctos;->aIDCta;->arACT_Cantidad;->arACT_Unitario;->alACT_MesCargo;->atACT_AñoCargo;->atACT_CAlumnoRUT)
				AT_Delete ($i;1;->adACT_CFechaEmision;->adACT_CFechaVencimiento;->atACT_CAlumno;->atACT_CAlumnoCurso;->atACT_CAlumnoNivelNombre;->atACT_CAlumnoPCurso;->atACT_CAlumnoPNivelNombre;->atACT_CGlosa;->arACT_CMontoNeto;->arACT_CIntereses;->arACT_CSaldo;->alACT_RecNumsCargos;->alACT_CRefs;->alACT_CIDCtaCte;->asACT_Marcas;->arACT_MontoMoneda;->atACT_MonedaCargo;->atACT_MonedaSimbolo;->atACT_CGlosaImpresion;->asACT_Afecto;->arACT_TasaIVA;->arACT_MontoPagado;->arACT_MontoIVA;->arACT_CTotalDesctos;->aIDCta;->arACT_Cantidad;->arACT_Unitario;->alACT_MesCargo;->alACT_AñoCargo;->atACT_MesCargo;->atACT_AñoCargo;->atACT_CAlumnoRUT;->atACT_unidadCargo)
				
			End if 
			atACT_CAlumno{$index}:=""
			atACT_CAlumnoCurso{$index}:=""
			atACT_CAlumnoNivelNombre{$index}:=""
			atACT_CAlumnoPCurso{$index}:=""
			atACT_CAlumnoPNivelNombre{$index}:=""
		End if 
	End for 
End if 