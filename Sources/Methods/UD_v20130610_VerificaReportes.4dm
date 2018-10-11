//%attributes = {}
  //UD_v20130610_VerificaReportes

READ ONLY:C145([xShell_Reports:54])
ALL RECORDS:C47([xShell_Reports:54])

C_LONGINT:C283($l_mainTable;$l_relatedTable;$i)

C_TEXT:C284($t_Encabezado;$t_descripcion;$t_uuid;$t_mensajeFalla;$t_mensajeExito)

ARRAY LONGINT:C221($al_recNumsReports;0)
ARRAY TEXT:C222($at_reportName;0)
ARRAY TEXT:C222($at_reportType;0)
ARRAY INTEGER:C220($ai_mainTable;0)
ARRAY TEXT:C222($at_mainTable;0)
ARRAY BOOLEAN:C223($ab_estandar;0)
ARRAY TEXT:C222($at_estandar;0)
ARRAY INTEGER:C220($ai_relatedTable;0)
ARRAY TEXT:C222($at_relatedTable;0)

ARRAY LONGINT:C221($al_colores;0)
ARRAY LONGINT:C221($al_estilos;0)
ARRAY TEXT:C222($at_Errores;0)
ARRAY TEXT:C222($at_TitulosColumnas;0)

FIRST RECORD:C50([xShell_Reports:54])
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Verificando reportes...")
While (Not:C34(End selection:C36([xShell_Reports:54])))
	
	$l_mainTable:=Abs:C99([xShell_Reports:54]MainTable:3)
	$l_relatedTable:=Abs:C99([xShell_Reports:54]RelatedTable:14)
	
	If ((Not:C34(Is table number valid:C999($l_mainTable))) & ($l_mainTable#0))
		APPEND TO ARRAY:C911($al_recNumsReports;Record number:C243([xShell_Reports:54]))
	Else 
		If ($l_relatedTable#0)
			If (Not:C34(Is table number valid:C999($l_relatedTable)))
				APPEND TO ARRAY:C911($al_recNumsReports;Record number:C243([xShell_Reports:54]))
			End if 
		End if 
	End if 
	NEXT RECORD:C51([xShell_Reports:54])
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;Selected record number:C246([xShell_Reports:54])/Records in selection:C76([xShell_Reports:54]))
End while 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)

CREATE SELECTION FROM ARRAY:C640([xShell_Reports:54];$al_recNumsReports;"")
ORDER BY:C49([xShell_Reports:54];[xShell_Reports:54]IsStandard:38;<;[xShell_Reports:54]MainTable:3;>;[xShell_Reports:54]ReportType:2;>)

SELECTION TO ARRAY:C260([xShell_Reports:54]ReportName:26;$at_reportName;[xShell_Reports:54]ReportType:2;$at_reportType;[xShell_Reports:54]MainTable:3;$ai_mainTable;[xShell_Reports:54]IsStandard:38;$ab_estandar;[xShell_Reports:54]RelatedTable:14;$ai_relatedTable)
For ($i;1;Size of array:C274($ai_mainTable))
	
	If (Is table number valid:C999($ai_mainTable{$i}))
		APPEND TO ARRAY:C911($at_mainTable;Table name:C256($ai_mainTable{$i}))
	Else 
		APPEND TO ARRAY:C911($at_mainTable;"Tabla desconocida")
	End if 
	APPEND TO ARRAY:C911($at_estandar;Choose:C955($ab_estandar{$i};"Sí";"No"))
	APPEND TO ARRAY:C911($at_relatedTable;String:C10($ai_relatedTable{$i}))
	APPEND TO ARRAY:C911($at_Errores;__ ("Informe asociado a tabla inexistente"))
	APPEND TO ARRAY:C911($al_colores;Red:K11:4)
	APPEND TO ARRAY:C911($al_estilos;Plain:K14:1)
	Case of 
		: ($at_reportType{$i}="4DFO")  // 4D Form
			$at_reportType{$i}:="Formulario"
		: ($at_reportType{$i}="gSR2")  // SuperReport
			$at_reportType{$i}:="SuperReport"
		: ($at_reportType{$i}="4DSE")  //Quick Report
			$at_reportType{$i}:="Columna"
		: ($at_reportType{$i}="4DET")  //Quick Report
			$at_reportType{$i}:="Etiqueta"
		: ($at_reportType{$i}="4DWR")
			$at_reportType{$i}:="Write"
		: ($at_reportType{$i}="4DVW")
			$at_reportType{$i}:="View"
		: ($at_reportType{$i}="4DDW")
			$at_reportType{$i}:="Draw"
		: ($at_reportType{$i}="4DCT")
			$at_reportType{$i}:="Chart"
	End case 
	
End for 

C_LONGINT:C283($l_locked)
If (Size of array:C274($al_recNumsReports)>0)
	  //elimino reportes.
	READ WRITE:C146([xShell_Reports:54])
	CREATE SELECTION FROM ARRAY:C640([xShell_Reports:54];$al_recNumsReports;"")
	DELETE SELECTION:C66([xShell_Reports:54])
	KRL_UnloadReadOnly (->[xShell_Reports:54])
	$l_locked:=Records in set:C195("LockedSet")
	
	  //para agregar al centro de notificaciones
	$t_Encabezado:=__ ("Verificación de informes asociados a tablas inválidas")
	$t_descripcion:=__ ("Los informes deben estar relacionados a tablas válidas, de lo contrario no funcionarán adecuadamente y podrán mostrar errores o entregar información incorrecta.\r\r")
	$t_descripcion:=$t_descripcion+__ ("Los informes de la lista a continuación, estaban asociados a tablas inválidas, por lo tanto fueron eliminados.")+Choose:C955($l_locked>0;__ (" (¡¡¡Algunos informes no pudieron ser eliminados!!!)");"")+".\r\r"
	$t_descripcion:=$t_descripcion+__ ("En caso de que un usuario necesite alguno de los informes eliminados, se debe comunicar con la mesa de ayuda de Colegium o al mail soporte@colegium.com.")
	
	APPEND TO ARRAY:C911($at_TitulosColumnas;__ ("Advertencia o Error"))
	APPEND TO ARRAY:C911($at_TitulosColumnas;__ ("Nombre Informe"))
	APPEND TO ARRAY:C911($at_TitulosColumnas;__ ("Tipo"))
	APPEND TO ARRAY:C911($at_TitulosColumnas;__ ("Tabla de Origen"))
	APPEND TO ARRAY:C911($at_TitulosColumnas;__ ("Es Estándar"))
	APPEND TO ARRAY:C911($at_TitulosColumnas;__ ("Nº tabla relacionada"))
	
	$t_uuid:=NTC_CreaMensaje ("SchoolTrack";$t_Encabezado;$t_descripcion)
	NTC_Mensaje_Arreglos ($t_uuid;->$at_TitulosColumnas;->$at_errores;->$at_reportName;->$at_reportType;->$at_mainTable;->$at_estandar;->$at_relatedTable)
	NTC_Mensaje_EstilosColores ($t_uuid;->$al_estilos;->$al_Colores)
End if 