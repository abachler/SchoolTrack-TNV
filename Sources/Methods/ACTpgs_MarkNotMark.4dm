//%attributes = {}
  //ACTpgs_MarkNotMark

C_TEXT:C284($vt_accion;$1)
C_BOOLEAN:C305($vb_mark)
ARRAY LONGINT:C221($al_arrayResult;0)

$vt_accion:=$1
If (Count parameters:C259>=2)
	$ptr:=$2
End if 

If (Count parameters:C259>=3)
	$ptr2:=$3
End if 

If (Count parameters:C259>=4)
	$ptr3:=$4
End if 

If (Count parameters:C259>=5)
	$ptr4:=$5
End if 

If (Count parameters:C259>=6)
	$ptr5:=$6
End if 

If (Count parameters:C259>=7)
	$ptr6:=$7
End if 

Case of 
	: ($vt_accion="DesdeAvisos")
		For ($i;1;Size of array:C274($ptr->))
			alACT_CIdsAvisos{0}:=alACT_AIDAviso{$ptr->{$i}}
			AT_SearchArray (->alACT_CIdsAvisos;"=";->$al_arrayResult)
			For ($j;1;Size of array:C274($al_arrayResult))
				If (abACT_ASelectedAvisos{$ptr->{$i}})
					abACT_ASelectedCargo{$al_arrayResult{$j}}:=True:C214
					GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_ASelectedCargo{$al_arrayResult{$j}})
				Else 
					abACT_ASelectedCargo{$al_arrayResult{$j}}:=False:C215
					GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";apACT_ASelectedCargo{$al_arrayResult{$j}})
				End if 
			End for 
		End for 
		PROCESS PROPERTIES:C336(Current process:C322;$ProcName;$ProcState;$ProcTime)
		If ($ProcName="Documentar Deudas")
			ACTpgs_MarkNotMark ("MarcaArreglosTemp";$ptr;->abACT_ASelectedAvisos;->alACT_CIdsAvisosTemp;->alACT_AIDAviso)
		End if 
		ACTpgs_MarkNotMark ("RecalculaDeuda";$ptr)
	: ($vt_accion="DesdeItems")
		For ($i;1;Size of array:C274($ptr->))
			alACT_CRefs{0}:=alACT_RefItem{$ptr->{$i}}
			AT_SearchArray (->alACT_CRefs;"=";->$al_arrayResult)
			For ($j;1;Size of array:C274($al_arrayResult))
				If (abACT_ASelectedItem{$ptr->{$i}})
					abACT_ASelectedCargo{$al_arrayResult{$j}}:=True:C214
					GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_ASelectedCargo{$al_arrayResult{$j}})
				Else 
					abACT_ASelectedCargo{$al_arrayResult{$j}}:=False:C215
					GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";apACT_ASelectedCargo{$al_arrayResult{$j}})
				End if 
			End for 
		End for 
		PROCESS PROPERTIES:C336(Current process:C322;$ProcName;$ProcState;$ProcTime)
		If ($ProcName="Documentar Deudas")
			ACTpgs_MarkNotMark ("MarcaArreglosTemp";$ptr;->abACT_ASelectedItem;->alACT_CRefsTemp;->alACT_RefItem)
		End if 
		ACTpgs_MarkNotMark ("RecalculaDeuda";$ptr)
	: ($vt_accion="DesdeAlumnos")
		For ($i;1;Size of array:C274($ptr->))
			alACT_CIDCtaCte{0}:=alACT_AIdsCtas{$ptr->{$i}}
			AT_SearchArray (->alACT_CIDCtaCte;"=";->$al_arrayResult)
			For ($j;1;Size of array:C274($al_arrayResult))
				If (abACT_ASelectedAlumno{$ptr->{$i}})
					abACT_ASelectedCargo{$al_arrayResult{$j}}:=True:C214
					GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_ASelectedCargo{$al_arrayResult{$j}})
				Else 
					abACT_ASelectedCargo{$al_arrayResult{$j}}:=False:C215
					GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";apACT_ASelectedCargo{$al_arrayResult{$j}})
				End if 
			End for 
		End for 
		PROCESS PROPERTIES:C336(Current process:C322;$ProcName;$ProcState;$ProcTime)
		If ($ProcName="Documentar Deudas")
			ACTpgs_MarkNotMark ("MarcaArreglosTemp";$ptr;->abACT_ASelectedAlumno;->alACT_CIDCtaCteTemp;->alACT_AIdsCtas)
		End if 
		ACTpgs_MarkNotMark ("RecalculaDeuda";$ptr)
		
	: ($vt_accion="DesdeAgrupado")
		PROCESS PROPERTIES:C336(Current process:C322;$ProcName;$ProcState;$ProcTime)
		ARRAY LONGINT:C221($alACT_AIDAviso;0)
		For ($i;1;Size of array:C274($ptr->))
			$vt_valorABuscar:=atACT_YearMonthAgrupado{$ptr->{$i}}
			ACTat_SearchArrayByRange ("DesdeAAAAMM";->$vt_valorABuscar;->adACT_CFechaEmision;->$al_arrayResult)
			For ($j;1;Size of array:C274($al_arrayResult))
				If (abACT_ASelectedAgrupado{$ptr->{$i}})
					abACT_ASelectedCargo{$al_arrayResult{$j}}:=True:C214
					GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_ASelectedCargo{$al_arrayResult{$j}})
				Else 
					abACT_ASelectedCargo{$al_arrayResult{$j}}:=False:C215
					GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";apACT_ASelectedCargo{$al_arrayResult{$j}})
				End if 
				APPEND TO ARRAY:C911($alACT_AIDAviso;alACT_CIdsAvisos{$al_arrayResult{$j}})
			End for 
		End for 
		If ($ProcName="Documentar Deudas")
			ACTpgs_MarkNotMark ("MarcaArreglosTemp";$ptr;->abACT_ASelectedAgrupado;->adACT_CFechaEmisionTemp;->atACT_YearMonthAgrupado)
		End if 
		ACTpgs_MarkNotMark ("RecalculaDeuda";$ptr)
		
		
	: ($vt_accion="DesdeCargosDeDocumentar")
		If (Size of array:C274($ptr->)>0)
			abACT_ASelectedCargo{0}:=True:C214
			AT_SearchArray (->abACT_ASelectedCargo;"=";->$al_arrayResult)
			$el:=Find in array:C230($ptr2->;$ptr3->{1})
			If (Size of array:C274($al_arrayResult)>0)
				$ptr4->{$el}:=True:C214
				GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";$ptr5->{$el})
			Else 
				$ptr4->{$el}:=False:C215
				GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";$ptr5->{$el})
			End if 
		End if 
		ARRAY LONGINT:C221($al_pos2Marck;0)
		For ($i;1;Size of array:C274($ptr->))
			APPEND TO ARRAY:C911($al_pos2Marck;Find in array:C230(alACT_RecNumsCargosTemp;alACT_RecNumsCargos{$ptr->{$i}}))
		End for 
		ACTpgs_MarkNotMark ("MarcaArreglosTempDesdeExpandido";->$al_pos2Marck;$ptr6)
		
	: ($vt_accion="MarcaArreglosTempDesdeExpandido")
		PROCESS PROPERTIES:C336(Current process:C322;$ProcName;$ProcState;$ProcTime)
		Case of 
			: ($ProcName="Ingreso de Pagos")
				
			Else 
				For ($i;1;Size of array:C274($ptr->))
					If ($ptr2->)
						abACT_ASelectedCargoTemp{$ptr->{$i}}:=True:C214
						GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_ASelectedCargoTemp{$ptr->{$i}})
					Else 
						abACT_ASelectedCargoTemp{$ptr->{$i}}:=False:C215
						GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";apACT_ASelectedCargoTemp{$ptr->{$i}})
					End if 
				End for 
				ACTpgs_MarkNotMark ("RecalculaDeuda";$ptr)
		End case 
		
	: ($vt_accion="MarcaArreglosTemp")
		For ($i;1;Size of array:C274($ptr->))
			$vb_mark:=$ptr2->{$ptr->{$i}}
			
			If (vbACT_CargosDesdeAgrupado)
				$vt_valorABuscar:=$ptr4->{$ptr->{$i}}
				ACTat_SearchArrayByRange ("DesdeAAAAMM";->$vt_valorABuscar;$ptr3;->$al_arrayResult)
			Else 
				$ptr3->{0}:=$ptr4->{$ptr->{$i}}
				AT_SearchArray ($ptr3;"=";->$al_arrayResult)
			End if 
			ACTpgs_MarkNotMark ("MarcaArreglosTempDesdeExpandido";->$al_arrayResult;->$vb_mark)
		End for 
		
	: ($vt_accion="RecalculaDeuda")
		If (Size of array:C274($ptr->)>0)
			ACTpgs_RecalculaDeuda ("recalculoSeleccionado";vdACT_FechaPago)
		End if 
		
	: ($vt_accion="InitArrays")
		  //ARRAY REAL(arACT_AMontoSeleccionado;0)
		For ($i;1;Size of array:C274(abACT_ASelectedCargo))
			abACT_ASelectedCargo{$i}:=$ptr2->
			If (abACT_ASelectedCargo{$i})
				GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_ASelectedCargo{$i})
			Else 
				GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";apACT_ASelectedCargo{$i})
			End if 
		End for 
		
		For ($i;1;Size of array:C274(abACT_ASelectedCargoTemp))
			abACT_ASelectedCargoTemp{$i}:=$ptr2->
			If (abACT_ASelectedCargoTemp{$i})
				GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_ASelectedCargoTemp{$i})
			Else 
				GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";apACT_ASelectedCargoTemp{$i})
			End if 
		End for 
		
		For ($i;1;Size of array:C274(abACT_ASelectedAvisos))
			abACT_ASelectedAvisos{$i}:=$ptr2->
			If (abACT_ASelectedAvisos{$i})
				GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_ASelectedAvisos{$i})
			Else 
				GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";apACT_ASelectedAvisos{$i})
			End if 
		End for 
		For ($i;1;Size of array:C274(abACT_ASelectedItem))
			abACT_ASelectedItem{$i}:=$ptr2->
			If (abACT_ASelectedItem{$i})
				GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_ASelectedItem{$i})
			Else 
				GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";apACT_ASelectedItem{$i})
			End if 
		End for 
		For ($i;1;Size of array:C274(abACT_ASelectedAlumno))
			abACT_ASelectedAlumno{$i}:=$ptr2->
			If (abACT_ASelectedAlumno{$i})
				GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_ASelectedAlumnos{$i})
			Else 
				GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";apACT_ASelectedAlumnos{$i})
			End if 
		End for 
		For ($i;1;Size of array:C274(abACT_ASelectedAgrupado))
			abACT_ASelectedAgrupado{$i}:=$ptr2->
			If (abACT_ASelectedAgrupado{$i})
				GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_ASelectedAgrupado{$i})
			Else 
				GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";apACT_ASelectedAgrupado{$i})
			End if 
		End for 
		C_BOOLEAN:C305(vbACT_CargosDesdeAviso;vbACT_CargosDesdeItems;vbACT_CargosDesdeAlumnos;vbACT_CargosDesdeAgrupado)
		vbACT_CargosDesdeAviso:=False:C215
		vbACT_CargosDesdeItems:=False:C215
		vbACT_CargosDesdeAlumnos:=False:C215
		vbACT_CargosDesdeAgrupado:=False:C215
		Case of 
			: ($ptr->=1)
				vbACT_CargosDesdeAviso:=True:C214
			: ($ptr->=2)
				vbACT_CargosDesdeItems:=True:C214
			: ($ptr->=3)
				vbACT_CargosDesdeAlumnos:=True:C214
			: ($ptr->=4)
				vbACT_CargosDesdeAgrupado:=True:C214
		End case 
		
End case 