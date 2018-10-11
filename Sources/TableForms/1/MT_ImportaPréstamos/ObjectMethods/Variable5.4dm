If (vi_PageNumber=2)
	If (vt_g1#"")
		If ((vt_g1#vt_g1Temp) | (IT_AltKeyIsDown ))
			vt_g1Temp:=vt_g1
			
			READ ONLY:C145([BBL_Lectores:72])
			READ ONLY:C145([BBL_Registros:66])
			
			  //C_TIME($ref)
			C_TEXT:C284($text;$delimiter)
			
			ARRAY TEXT:C222($aCodBarra;0)
			ARRAY DATE:C224($aDesde;0)  //es la misma fecha de transaccion
			ARRAY DATE:C224($aHasta;0)
			ARRAY TEXT:C222($aRUT;0)
			ARRAY LONGINT:C221($aNumLector;0)
			ARRAY LONGINT:C221($aNumItem;0)
			ARRAY LONGINT:C221($aNumRegistro;0)
			ARRAY INTEGER:C220($aDiasAtraso;0)
			ARRAY INTEGER:C220($aDuracion;0)
			ARRAY INTEGER:C220($aRenovacion;0)
			
			C_LONGINT:C283($size)
			_O_C_INTEGER:C282($index;$indexb)
			
			$delimiter:=ACTabc_DetectDelimiter (vt_g1)
			$ref:=Open document:C264(vt_g1;"";Read mode:K24:5)
			
			If (ok=1)
				$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Pre importando archivo..."))
				
				If (cb_TieneEncabezado=1)
					RECEIVE PACKET:C104($ref;$text;$delimiter)
				End if 
				
				RECEIVE PACKET:C104($ref;$text;$delimiter)
				
				If (r2=1)
					$text:=_O_Win to Mac:C464($text)
				End if 
				
				While ($text#"")
					
					APPEND TO ARRAY:C911($aCodBarra;(ST_DeleteCharsLeft (ST_GetWord ($text;1;"\t");" ")))
					APPEND TO ARRAY:C911($aDesde;Date:C102(ST_GetWord ($text;2;"\t")))
					APPEND TO ARRAY:C911($aHasta;Date:C102(ST_GetWord ($text;3;"\t")))
					APPEND TO ARRAY:C911($aRUT;(ST_GetWord ($text;4;"\t")+ST_GetWord ($text;5;"\t")))
					APPEND TO ARRAY:C911($aRenovacion;Num:C11(ST_GetWord ($text;6;"\t")))
					
					
					QUERY:C277([BBL_Lectores:72];[BBL_Lectores:72]RUT:7=$aRUT{Size of array:C274($aRUT)})
					
					APPEND TO ARRAY:C911($aNumLector;[BBL_Lectores:72]ID:1)
					
					QUERY:C277([BBL_Registros:66];[BBL_Registros:66]Código_de_barra:20="*"+$aCodBarra{Size of array:C274($aCodBarra)}+"*")
					APPEND TO ARRAY:C911($aNumItem;[BBL_Registros:66]Número_de_item:1)
					APPEND TO ARRAY:C911($aNumRegistro;[BBL_Registros:66]ID:3)
					
					$v_duracion:=0
					$v_duracion:=$aHasta{Size of array:C274($aHasta)}-$aDesde{Size of array:C274($aDesde)}
					
					APPEND TO ARRAY:C911($aDuracion;$v_duracion)
					
					$v_atraso:=0
					$v_atraso:=Current date:C33(*)-$aHasta{Size of array:C274($aHasta)}
					
					APPEND TO ARRAY:C911($aDiasAtraso;$v_atraso)
					
					RECEIVE PACKET:C104($ref;$text;$delimiter)
					
					If (r2=1)
						$text:=_O_Win to Mac:C464($text)
					End if 
					
					$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;Get document position:C481($ref)/Get document size:C479(vt_g1))
				End while 
				
				$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
				
				ARRAY TEXT:C222($aRegnoImport;0)
				C_LONGINT:C283($v_usuarioactual)
				
				$size:=Size of array:C274($aNumLector)
				$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Cargando Registros de Préstamos…"))
				
				$v_usuarioactual:=USR_GetUserID 
				
				For ($index;1;Size of array:C274($aNumLector))
					
					If (cb_TieneEncabezado=1)
						$indexb:=$index+1
					Else 
						$indexb:=$index
					End if 
					
					QUERY:C277([BBL_Prestamos:60];[BBL_Prestamos:60]Número_de_registro:1=$aNumregistro{$index};*)
					QUERY:C277([BBL_Prestamos:60]; & ;[BBL_Prestamos:60]Fecha_de_devolución:5=!00-00-00!)
					
					If (((Records in selection:C76([BBL_Prestamos:60]))>0) & ($aNumregistro{$index}#0))
						
						APPEND TO ARRAY:C911($aRegnoImport;"Línea n°("+String:C10($indexb)+") :  Item número de registro "+String:C10($aNumRegistro{$index})+", se encuentra actualmente préstado.")
						
					Else 
						
						If (($aNumLector{$index}#0) & ($aNumregistro{$index}#0))
							READ WRITE:C146([BBL_Prestamos:60])
							CREATE RECORD:C68([BBL_Prestamos:60])
							
							[BBL_Prestamos:60]Número_de_Transacción:8:=SQ_SeqNumber (->[BBL_Prestamos:60]Número_de_Transacción:8)
							[BBL_Prestamos:60]Número_de_registro:1:=$aNumRegistro{$index}
							[BBL_Prestamos:60]Número_de_lector:2:=$aNumLector{$index}
							[BBL_Prestamos:60]Número_de_Item:11:=$aNumItem{$index}
							[BBL_Prestamos:60]Desde:3:=$aDesde{$index}
							[BBL_Prestamos:60]Hasta:4:=$aHasta{$index}
							[BBL_Prestamos:60]Fecha_de_Transacción:13:=$aDesde{$index}
							[BBL_Prestamos:60]Número_de_registro:1:=$aNumRegistro{$index}
							[BBL_Prestamos:60]Días_de_atraso:15:=$aDiasAtraso{$index}
							[BBL_Prestamos:60]Duración:6:=$aDuracion{$index}
							[BBL_Prestamos:60]Préstamo_registrado_por:9:=$v_usuarioactual
							[BBL_Prestamos:60]Renovaciones:12:=$aRenovacion{$index}
							
							SAVE RECORD:C53([BBL_Prestamos:60])
							KRL_ReloadAsReadOnly (->[BBL_Prestamos:60])
							READ ONLY:C145([BBL_Prestamos:60])
							
							
						Else 
							
							APPEND TO ARRAY:C911($aRegnoImport;"Registro n°("+String:C10($indexb)+"):  Sin Lector y/ó sin Item.")
							
						End if 
						
					End if 
					
					$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$index/$size)
				End for 
				
				$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
				
				BBLdbu_RebuildStatistics 
				
				CLOSE DOCUMENT:C267($ref)
				vi_PageNumber:=3
				FORM GOTO PAGE:C247(vi_PageNumber)
				POST KEY:C465(Character code:C91("+");256)
				
				_O_C_INTEGER:C282($num_reg_malos;$resp)
				$num_reg_malos:=Size of array:C274($aRegnoImport)
				
				If ($num_reg_malos>0)
					
					  //$msg:="Hubo "+String($num_reg_malos)+" registros de préstamos, no importados, se creará un archivo con el detalle de lo"+"s registros no importados."
					ok:=CD_Dlog (0;__ ("Hubo ")+String:C10($num_reg_malos)+__ (" registros de préstamos, no importados, se creará un archivo con el detalle de los registros no importados."))
					
					$ref:=Create document:C266("")
					If (ok=1)
						
						For ($i;1;Size of array:C274($aRegnoImport))
							$line:=$aRegnoImport{$i}+"\r"
							IO_SendPacket ($ref;$line)
						End for 
						
						CLOSE DOCUMENT:C267($ref)
						
						$path:=document
						  //$text:=AT_array2text (->$aRegnoImport;"\r")
						  //IO_SendPacket ($ref;$text)
						  //CLOSE DOCUMENT($ref)
						
						  //$msg:="Archivo generado con éxito."+"\r"+"Podrá encontrarlo en "+"\r\r"+$path
						CD_Dlog (0;__ ("Archivo generado con éxito.\rPodrá encontrarlo en \r\r")+$path)
					End if 
					CANCEL:C270
				Else 
					
					  //$msg:="Todos los registros fueron importados con éxito"
					$resp:=CD_Dlog (0;__ ("Todos los registros fueron importados con éxito."))
					CANCEL:C270
				End if 
				
				
			Else 
				CD_Dlog (0;__ ("Imposible abrir el archivo para importar."))
				CANCEL:C270
			End if 
		Else 
			If (vt_g1=vt_g1Temp)
				  //vi_PageNumber:=3
				  //GOTO PAGE(vi_PageNumber)
				  //POST KEY(Character code("+");256)
			End if 
		End if 
	Else 
		CD_Dlog (0;__ ("No ha indicado la ruta del archivo a importar."))
	End if 
Else 
	vi_PageNumber:=2
	_O_ENABLE BUTTON:C192(bPrev)
	FORM GOTO PAGE:C247(vi_PageNumber)
	POST KEY:C465(Character code:C91("+");256)
End if 