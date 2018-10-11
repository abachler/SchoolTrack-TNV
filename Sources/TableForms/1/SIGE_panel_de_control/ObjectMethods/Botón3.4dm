Case of 
	: (Form event:C388=On Clicked:K2:4)
		If (te_1=1)
			ARRAY TEXT:C222($at_cod_ens;0)
			For ($i;1;Size of array:C274(al_cod_tipo_ens))
				APPEND TO ARRAY:C911($at_cod_ens;String:C10(al_cod_tipo_ens{$i}))
			End for 
			SIGE_TipoEnseñanza (->$at_cod_ens)
		Else 
			
			ARRAY TEXT:C222($at_CodTipoEns_P;0)
			If (Size of array:C274(LB_SIGE)>0)
				For ($i;1;Size of array:C274(LB_SIGE))
					If (LB_SIGE{$i})
						APPEND TO ARRAY:C911($at_CodTipoEns_P;at_CodTipoEns_P{$i})
					End if 
				End for 
				SIGE_TipoEnseñanza (->$at_CodTipoEns_P)
			End if 
			
		End if 
		
End case 