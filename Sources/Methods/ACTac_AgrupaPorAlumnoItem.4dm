//%attributes = {}
  //ACTac_AgrupaPorAlumnoItem

ARRAY LONGINT:C221($alACT_idsCtas;0)
ARRAY LONGINT:C221($alACT_idsItems;0)
ARRAY LONGINT:C221($alACT_idsCtasT;0)
ARRAY LONGINT:C221($alACT_idsItemsT;0)
ARRAY LONGINT:C221($al_idAl;0)

  //obtengo valores unicos para ctas
COPY ARRAY:C226(alACT_CIDCtaCte;$alACT_idsCtasT)
AT_DistinctsArrayValues (->$alACT_idsCtasT)


For ($i;1;Size of array:C274($alACT_idsCtasT))
	
	  //creo arreglo para acumular las posiciones a eliminar
	ARRAY LONGINT:C221($al_posiciones2Del;0)
	
	  //busco los arreglos asociados a la cuenta
	ARRAY LONGINT:C221($alACT_idsItemsT;0)
	alACT_CIDCtaCte{0}:=$alACT_idsCtasT{$i}
	AT_SearchArray (->alACT_CIDCtaCte;"=";->$alACT_idsCtas)
	For ($j;1;Size of array:C274($alACT_idsCtas))
		  //lleno arreglo con valores de refs items
		APPEND TO ARRAY:C911($alACT_idsItemsT;alACT_CRefs{$alACT_idsCtas{$j}})
	End for 
	AT_DistinctsArrayValues (->$alACT_idsItemsT)
	  //busco refs items en los arreglos
	ARRAY LONGINT:C221($al_posicionesFinales;0)
	For ($j;1;Size of array:C274($alACT_idsItemsT))
		alACT_CRefs{0}:=$alACT_idsItemsT{$j}
		AT_SearchArray (->alACT_CRefs;"=";->$alACT_idsItems)
		  //saco los refs items asociados al alumno
		AT_intersect (->$alACT_idsCtas;->$alACT_idsItems;->$al_posicionesFinales)
		  //lleno los mismos arreglos de ACTac_AgrupaCargos
		For ($r;Size of array:C274($al_posicionesFinales);2;-1)
			  //atACT_CGlosaImpresion// esta queda igual que la primera
			arACT_CMontoNeto{$al_posicionesFinales{1}}:=arACT_CMontoNeto{$al_posicionesFinales{1}}+arACT_CMontoNeto{$al_posicionesFinales{$r}}
			If (Position:C15(asACT_Afecto{$al_posicionesFinales{1}};asACT_Afecto{$al_posicionesFinales{$r}})=0)
				asACT_Afecto{$al_posicionesFinales{1}}:=asACT_Afecto{$al_posicionesFinales{1}}+"-"+asACT_Afecto{$al_posicionesFinales{$r}}
			End if 
			arACT_MontoPagado{$al_posicionesFinales{1}}:=arACT_MontoPagado{$al_posicionesFinales{1}}+arACT_MontoPagado{$al_posicionesFinales{$r}}
			arACT_CTotalDesctos{$al_posicionesFinales{1}}:=arACT_CTotalDesctos{$al_posicionesFinales{1}}+arACT_CTotalDesctos{$al_posicionesFinales{$r}}
			If (Position:C15(atACT_MesCargo{$al_posicionesFinales{$r}};atACT_MesCargo{$al_posicionesFinales{1}})=0)
				atACT_MesCargo{$al_posicionesFinales{1}}:=atACT_MesCargo{$al_posicionesFinales{1}}+"-"+atACT_MesCargo{$al_posicionesFinales{$r}}
			End if 
			APPEND TO ARRAY:C911($al_posiciones2Del;$al_posicionesFinales{$r})
		End for 
	End for 
	  //ordeno las posiciones y elimino lo de la cuenta...
	SORT ARRAY:C229($al_posiciones2Del;>)
	For ($j;Size of array:C274($al_posiciones2Del);1;-1)
		  //20130626 RCH NF CANTIDAD
		AT_Delete ($al_posiciones2Del{$j};1;->adACT_CFechaEmision;->adACT_CFechaVencimiento;->atACT_CAlumno;->atACT_CAlumnoCurso;->atACT_CAlumnoNivelNombre;->atACT_CAlumnoPCurso;->atACT_CAlumnoPNivelNombre;->atACT_CGlosa;->arACT_CMontoNeto;->arACT_CIntereses;->arACT_CSaldo;->alACT_RecNumsCargos;->alACT_CRefs;->alACT_CIDCtaCte;->asACT_Marcas;->arACT_MontoMoneda;->atACT_MonedaCargo;->atACT_MonedaSimbolo;->atACT_CGlosaImpresion;->asACT_Afecto;->arACT_TasaIVA;->arACT_MontoPagado;->arACT_MontoIVA;->arACT_CTotalDesctos;->aIDCta;->arACT_Cantidad;->arACT_Unitario;->atACT_MesCargo;->alACT_AñoCargo;->atACT_AñoCargo)
	End for 
End for 


