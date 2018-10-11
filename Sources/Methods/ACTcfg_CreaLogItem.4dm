//%attributes = {}
  //ACTcfg_CreaLogItem
C_PICTURE:C286($vp_picture)
C_BLOB:C604($vx_blob)
C_TEXT:C284($vt_log;$vt_nuevoValor)
C_LONGINT:C283($i;$x;$result;$vl_type)
C_POINTER:C301($vy_table;$vy_fieldID;$vy_field;$vy_hijo;$vy_tramo;$vy_familia)
C_BOOLEAN:C305($vb_limpiar)

$vy_fieldID:=$1
$vy_table:=Table:C252(Table:C252($vy_fieldID))

For ($x;1;Get last field number:C255($vy_table))
	$vt_nuevoValor:=""
	
	If (Is table number valid:C999($x))
		  //20130321 RCH
		If (Is field number valid:C1000(Table:C252($vy_table);$x))
			$vy_field:=Field:C253(Table:C252($vy_table);$x)
			$vl_type:=Type:C295($vy_field->)
			Case of 
				: ($vl_type=Is BLOB:K8:12)
					Case of 
						: (Table:C252($vy_table)=Table:C252(->[xxACT_Items:179]))
							$vb_limpiar:=True:C214
							Case of 
								: (KRL_isSameField (->[xxACT_Items:179]Descuentos_hijos:14;$vy_field))
									$vt_nuevoValor:="Descuento por número de hijo"+"\r"
									For ($i;1;16)
										$vy_hijo:=Get pointer:C304("vr_Hijo"+String:C10($i+1))
										If ($vy_hijo->#arACT_DesctoPorHijo{$i})
											$vt_nuevoValor:=$vt_nuevoValor+__ ("Hijo")+String:C10(" ")+String:C10($i+1)+". Valor anterior: "+String:C10($vy_hijo->)+". Valor actual: "+String:C10(arACT_DesctoPorHijo{$i})+"\r"
											$vb_limpiar:=False:C215
										End if 
									End for 
									
								: (KRL_isSameField (->[xxACT_Items:179]Descuentos_Ingreso:16;$vy_field))
									$vt_nuevoValor:="Descuento por tramo de ingreso"+"\r"
									For ($i;1;16)
										$vy_tramo:=Get pointer:C304("vr_Tramo"+String:C10($i))
										If ($vy_tramo->#arACT_DesctoTramo{$i})
											$vt_nuevoValor:=$vt_nuevoValor+__ ("Tramo")+String:C10(" ")+String:C10($i+1)+". Valor anterior: "+String:C10($vy_tramo->)+". Valor actual: "+String:C10(arACT_DesctoTramo{$i})+"\r"
											$vb_limpiar:=False:C215
										End if 
									End for 
									
								: (KRL_isSameField (->[xxACT_Items:179]Descuento_Familia:32;$vy_field))
									$vt_nuevoValor:="Descto por hijos o cargas totales"+"\r"
									For ($i;1;16)
										$vy_familia:=Get pointer:C304("vr_Familia"+String:C10($i+1))
										If ($vy_familia->#arACT_DesctoPorFamilia{$i})
											$vt_nuevoValor:=$vt_nuevoValor+atACT_Familia{$i}+". Valor anterior: "+String:C10($vy_familia->)+". Valor actual: "+String:C10(arACT_DesctoPorFamilia{$i})+"\r"
											$vb_limpiar:=False:C215
										End if 
									End for 
									
							End case 
							
							If ($vb_limpiar)
								$vt_nuevoValor:=""
							End if 
						Else 
							$vx_blob:=Old:C35($vy_field->)
							$result:=API Compare Blobs ($vx_blob;$vy_field->;1)
							If ($result=0)
								$vt_nuevoValor:="Campo "+Field name:C257($vy_field)+" modificado."+"\r"
							End if 
							
					End case 
					
				: ($vl_type=Is picture:K8:10)
					Case of 
						: (Table:C252($vy_table)=Table:C252(->[xxACT_Items:179]))
							
						Else 
							$vp_picture:=Old:C35($vy_table->)
							If ($vp_picture#$vy_table->)
								$vt_nuevoValor:="Campo "+Field name:C257($vy_field)+" modificado"+"\r"
							End if 
							
					End case 
				Else 
					
					If (Old:C35($vy_field->)#$vy_field->)
						$vt_anteriorValor:=ST_Coerce_to_Text_Old ($vy_field;False:C215)
						$vt_nuevoValor:=ST_Coerce_to_Text ($vy_field;False:C215)
						$vt_nuevoValor:="Campo "+Field name:C257($vy_field)+" modificado. Valor anterior: "+$vt_anteriorValor+". Valor nuevo: "+$vt_nuevoValor+"\r"
					End if 
					
			End case 
			
			If ($vt_nuevoValor#"")
				If ($vt_log="")
					$vt_log:="Cambio en configuración de "+Table name:C256($vy_table)+", "+Field name:C257($vy_fieldID)+": "+ST_Coerce_to_Text ($vy_fieldID;False:C215)+"\r"
				End if 
				$vt_log:=$vt_log+$vt_nuevoValor
			End if 
		End if 
	End if 
End for 
  //SET TEXT TO PASTEBOARD($vt_log)
$0:=$vt_log