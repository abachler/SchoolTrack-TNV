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
		
		ARRAY TEXT:C222($at_nombrePrefs;0)
		ARRAY LONGINT:C221($alACT_idsTerceros;0)
		For ($i;1;Size of array:C274($alACT_ids))
			$l_posOrg:=Find in array:C230(atACT_Text;$atACT_TextOrg{$i})
			$vt_pref:=atACT_Text{$l_posOrg}
			APPEND TO ARRAY:C911($at_nombrePrefs;$vt_pref)
			
			ACTdte_setPruebasOpcionesGen ("DesarmaBlob";->$vt_pref)
			
			APPEND TO ARRAY:C911($alACT_idsTerceros;vlACT_terceroID)
		End for 
		
		READ ONLY:C145([xShell_Prefs:46])
		QUERY WITH ARRAY:C644([xShell_Prefs:46]Reference:1;$at_nombrePrefs)
		  //IO_ExportRecordsFromOneTable (->[xShell_Prefs])
		
		READ ONLY:C145([ACT_Terceros:138])
		QUERY WITH ARRAY:C644([ACT_Terceros:138]Id:1;$alACT_idsTerceros)
		
		ARRAY POINTER:C280($ay_tablas;0)
		APPEND TO ARRAY:C911($ay_tablas;->[xShell_Prefs:46])
		APPEND TO ARRAY:C911($ay_tablas;->[ACT_Terceros:138])
		
		C_BOOLEAN:C305($b_usarSeleccionActual)
		C_LONGINT:C283($i;$j;$l_numeroTabla;$l_registros;$l_tablas_a_exportar)
		C_POINTER:C301($y_tabla)
		C_TEXT:C284($t_nombreTabla;$t_rutaDocumento)
		
		$b_usarSeleccionActual:=True:C214
		$t_rutaDocumento:=""
		
		  //MAIN CODE
		SET CHANNEL:C77(12;$t_rutaDocumento)
		If (ok=1)
			$l_tablas_a_exportar:=Size of array:C274($ay_tablas)
			SEND VARIABLE:C80($l_tablas_a_exportar)
			For ($j;1;$l_tablas_a_exportar)
				$y_tabla:=$ay_tablas{$j}
				If (Not:C34($b_usarSeleccionActual))
					ALL RECORDS:C47($y_tabla->)
				End if 
				FIRST RECORD:C50($y_tabla->)
				If (ok=1)
					If ($j=1)
						$t_casos:=AT_array2text (->$at_nombrePrefs)
					Else 
						$t_casos:=""
					End if 
					$l_registros:=Records in selection:C76($y_tabla->)
					$t_nombreTabla:=Table name:C256($y_tabla)
					$l_numeroTabla:=Table:C252($y_tabla)
					SEND VARIABLE:C80($l_numeroTabla)
					SEND VARIABLE:C80($t_nombreTabla)
					SEND VARIABLE:C80($l_registros)
					SEND VARIABLE:C80($t_casos)
					$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Exportando registros del archivo ")+$t_nombreTabla)
					For ($i;1;$l_registros)
						SEND RECORD:C78($y_tabla->)
						NEXT RECORD:C51($y_tabla->)
						If (Dec:C9($i/50)=0)
							$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/$l_registros)
						End if 
					End for 
					$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
				End if 
			End for 
			SET CHANNEL:C77(11)
		End if 
		
		
		
		
	Else 
		CD_Dlog (0;"Los casos a exportar deben tener el mismo Número.")
	End if 
End if 