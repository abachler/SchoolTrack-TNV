C_LONGINT:C283($proc;$i)

ARRAY LONGINT:C221($al_recnum;0)
ARRAY DATE:C224($ad_fecha;0)
ARRAY TEXT:C222($at_time;0)
ARRAY TEXT:C222($at_selector;0)
$proc:=IT_UThermometer (1;0;__ ("Leyendo registro de actividades"))

READ ONLY:C145([XShell_FatObjects:86])
QUERY:C277([XShell_FatObjects:86];[XShell_FatObjects:86]FatObjectName:1="TMT_AsistImport_@")
ORDER BY:C49([XShell_FatObjects:86];[XShell_FatObjects:86]DateObject:7;<;[XShell_FatObjects:86]TextObject:3;<)
SELECTION TO ARRAY:C260([XShell_FatObjects:86];$al_recnum;[XShell_FatObjects:86]DateObject:7;$ad_fecha;[XShell_FatObjects:86]TextObject:3;$at_time)

For ($i;1;Size of array:C274($ad_fecha))
	APPEND TO ARRAY:C911($at_selector;String:C10($ad_fecha{$i})+" "+$at_time{$i})
End for 

If (Size of array:C274($at_selector)>0)
	SRtbl_ShowChoiceList (0;"Seleccione un registro para imprimir";2;->btnlog;False:C215;->$at_selector)
	
	If (CHOICEIDX>0)
		ARRAY BOOLEAN:C223($ab_importado;0)
		ARRAY TEXT:C222($at_importado;0)
		ARRAY TEXT:C222($at_detalle;0)
		ARRAY TEXT:C222($at_encabezado;0)
		APPEND TO ARRAY:C911($at_encabezado;"Importado")
		APPEND TO ARRAY:C911($at_encabezado;"Detalle")
		ARRAY POINTER:C280($ay_data;0)
		GOTO RECORD:C242([XShell_FatObjects:86];$al_recnum{CHOICEIDX})
		BLOB_Blob2Vars (->[XShell_FatObjects:86]BlobObject:2;0;->$ab_importado;->$at_detalle)
		
		For ($i;1;Size of array:C274($ab_importado))
			APPEND TO ARRAY:C911($at_importado;String:C10($ab_importado{$i}))
		End for 
		
		APPEND TO ARRAY:C911($ay_data;->$at_importado)
		APPEND TO ARRAY:C911($ay_data;->$at_detalle)
		
		$ruta:=xfGetDirName 
		If ($ruta#"")
			$ruta:=$ruta+"Log"+Replace string:C233($at_selector{CHOICEIDX};":";"")+".xls"
			XLS_GeneraArchivo ($ruta;"Log"+$at_selector{CHOICEIDX};"";->$at_encabezado;->$ay_data)
		End if 
	End if 
	
Else 
	CD_Dlog (0;"No existen registros de importaciones de horario")
End if 
IT_UThermometer (-2;$proc)
