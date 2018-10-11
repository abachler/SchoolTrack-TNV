  //If (vlACT_apoderadoID#0)

ARRAY TEXT:C222($atACT_TextOrg;0)

ARRAY LONGINT:C221($alACT_ids;0)
lb_listadoSet{0}:=True:C214
AT_SearchArray (->lb_listadoSet;"=";->$alACT_ids)
C_LONGINT:C283(l_sinDT)

If (Size of array:C274($alACT_ids)>0)
	$vt_atencion:=atACT_NumAtencion{$alACT_ids{1}}
	
	APPEND TO ARRAY:C911($atACT_TextOrg;atACT_Text{$alACT_ids{1}})
	
	$vb_continuar:=True:C214
	For ($i;2;Size of array:C274($alACT_ids))
		
		APPEND TO ARRAY:C911($atACT_TextOrg;atACT_Text{$alACT_ids{$i}})
		
		If ($vt_atencion#atACT_NumAtencion{$alACT_ids{1}})
			$vb_continuar:=False:C215
		End if 
	End for 
	If ($vb_continuar)
		$vt_numCaso:=CD_Request (__ ("Ingrese número de caso a asignar");__ ("Ok");__ ("Cancelar");"";"")
		If (ok=1)
			$vl_resp:=CD_Dlog (0;__ ("Se duplicarán ")+String:C10(Size of array:C274($alACT_ids))+__ (" casos y se les asignará el número de atención: ")+$vt_numCaso+"."+"\r\r"+__ ("¿Desea continuar?");"";__ ("Si");__ ("No"))
			If ($vl_resp=1)
				START TRANSACTION:C239
				For ($i;1;Size of array:C274($alACT_ids))
					
					$l_posOrg:=Find in array:C230(atACT_Text;$atACT_TextOrg{$i})
					
					  //$vt_pref:=atACT_Text{$alACT_ids{$i}}
					  //$vt_casoOrg:=ST_GetWord (atACT_Text{$alACT_ids{$i}};4;"_")
					
					$vt_pref:=atACT_Text{$l_posOrg}
					$vt_casoOrg:=ST_GetWord (atACT_Text{$l_posOrg};4;"_")
					
					ACTdte_setPruebasOpcionesGen ("DesarmaBlob";->$vt_pref)
					vt_numeroAtencion:=Replace string:C233(vt_numeroAtencion;$vt_casoOrg;$vt_numCaso)
					vt_descripcionAtencion:=Replace string:C233(vt_descripcionAtencion;$vt_casoOrg;$vt_numCaso)
					vt_variableCaso:=Replace string:C233(vt_variableCaso;$vt_casoOrg;$vt_numCaso)
					vt_referencia:=Replace string:C233(vt_referencia;$vt_casoOrg;$vt_numCaso)
					vlACT_idBoleta:=0
					
					ARRAY TEXT:C222($atACT_Text;0)
					ACTdte_setPruebasOpcionesGen ("CargaReferencias";->$atACT_Text)
					ARRAY TEXT:C222($atACT_Caso2;0)
					For ($j;1;Size of array:C274($atACT_Text))
						APPEND TO ARRAY:C911($atACT_Caso2;ST_GetWord ($atACT_Text{$j};6;"_"))
					End for 
					
					
					COPY ARRAY:C226($atACT_Caso2;atACT_Caso2)
					If (vt_referencia="")
						atACT_Caso2:=0
					Else 
						atACT_Caso2:=Find in array:C230(atACT_Caso2;vt_referencia)
					End if 
					
					$vt_retorno:=ACTdte_setPruebasOpcionesGen ("GuardaCaso")
					If ($vt_retorno="0")
						$i:=Size of array:C274($alACT_ids)
						$vb_continuar:=False:C215
					End if 
				End for 
				If ($vb_continuar)
					VALIDATE TRANSACTION:C240
					ACTdte_setPruebasOpcionesGen ("CargaListado")
					CD_Dlog (0;"Script ejecutado.")
				Else 
					CANCEL TRANSACTION:C241
					CD_Dlog (0;"Script no ejecutado.")
				End if 
			End if 
		End if 
	Else 
		CD_Dlog (0;"Los casos a duplicar deben tener el mismo Número.")
	End if 
End if 