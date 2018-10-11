//%attributes = {}
  // QR_BuildReportHList()
  // Por: Alberto Bachler K.: 18-08-14, 12:10:12
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_icono4DChart;$l_icono4DView;$l_icono4DWrite;$l_iconoCarpeta;$l_iconoEtiquetas;$l_iconoFormulario;$l_iconoInformeEnColumnas;$l_iconoSuperReport)
C_POINTER:C301($y_expresion;$y_Idioma;$y_pais)
C_LONGINT:C283($i)

ARRAY BOOLEAN:C223($ab_EsEstandar;0)
ARRAY LONGINT:C221($al_PropietaryID;0)
ARRAY LONGINT:C221($al_ReportRecNums;0)
ARRAY TEXT:C222($at_ReportName;0)



C_LONGINT:C283(hl_Reports)


$y_pais:=OBJECT Get pointer:C1124(Object named:K67:5;"codigoPais")
$y_Idioma:=OBJECT Get pointer:C1124(Object named:K67:5;"codigoIdioma")



$l_iconoCarpeta:=Use PicRef:K28:4+27511
$l_iconoSuperReport:=Use PicRef:K28:4+27512
$l_iconoFormulario:=Use PicRef:K28:4+27513
$l_iconoInformeEnColumnas:=Use PicRef:K28:4+27514
$l_iconoEtiquetas:=Use PicRef:K28:4+27516
$l_icono4DWrite:=Use PicRef:K28:4+12041


If (Is a list:C621(hl_Reports))
	CLEAR LIST:C377(hl_Reports)
End if 
hl_Reports:=New list:C375
APPEND TO LIST:C376(hl_Reports;"Informes no editables";-1;0;True:C214)
APPEND TO LIST:C376(hl_Reports;"Informes SuperReport";-2;0;True:C214)
APPEND TO LIST:C376(hl_Reports;"Informes semi-automáticos";-3;0;True:C214)
APPEND TO LIST:C376(hl_Reports;"Etiquetas standard";-5)
APPEND TO LIST:C376(hl_Reports;"4D Write";-4;0;True:C214)

SET LIST ITEM PROPERTIES:C386(hl_Reports;-1;False:C215;1;$l_iconoCarpeta)
SET LIST ITEM PROPERTIES:C386(hl_Reports;-2;False:C215;1;$l_iconoCarpeta)
SET LIST ITEM PROPERTIES:C386(hl_Reports;-3;False:C215;1;$l_iconoCarpeta)
SET LIST ITEM PROPERTIES:C386(hl_Reports;-4;False:C215;1;$l_iconoCarpeta)
SET LIST ITEM PROPERTIES:C386(hl_Reports;-5;False:C215;1;$l_iconoCarpeta)

OBJECT SET ENTERABLE:C238(hl_Reports;True:C214)

  //ABC187033 
C_OBJECT:C1216($ob_pref)
C_OBJECT:C1216($ob)
C_BOOLEAN:C305($b_titulo;$b_tags;$b_Descripcion)
QR_filtroBusqueda ("CreaObjeto";->$ob;->$ob)
$ob_pref:=PREF_fGetObject (<>lUSR_CurrentUserID;"MenuBusquedaInformes";$ob)
OB_GET ($ob_pref;->$b_titulo;"Titulo")
OB_GET ($ob_pref;->$b_Descripcion;"Descripcion")
OB_GET ($ob_pref;->$b_tags;"Tag")


$y_expresion:=OBJECT Get pointer:C1124(Object named:K67:5;"expresionBusqueda")




CREATE EMPTY SET:C140([xShell_Reports:54];"$resultado")
If ($y_expresion->#"")
	If ($b_titulo)
		QRY_BusquedaPorPalabrasClave (->[xShell_Reports:54];->[xShell_Reports:54]ReportName:26;$y_expresion->)
		CREATE SET:C116([xShell_Reports:54];"porNombre")
		UNION:C120("$resultado";"porNombre";"$resultado")
		CLEAR SET:C117("porTag")
	End if 
	If ($b_Descripcion)
		QRY_BusquedaPorPalabrasClave (->[xShell_Reports:54];->[xShell_Reports:54]Descripción:16;$y_expresion->)
		CREATE SET:C116([xShell_Reports:54];"porDescripcion")
		UNION:C120("$resultado";"porDescripcion";"$resultado")
		CLEAR SET:C117("porTag")
	End if 
	If ($b_tags)
		QRY_BusquedaPorPalabrasClave (->[xShell_Reports:54];->[xShell_Reports:54]Tags:43;$y_expresion->)
		CREATE SET:C116([xShell_Reports:54];"porTag")
		UNION:C120("$resultado";"porTag";"$resultado")
		CLEAR SET:C117("porTag")
	End if 
	USE SET:C118("$resultado")
	QUERY SELECTION:C341([xShell_Reports:54];[xShell_Reports:54]MainTable:3=(Table:C252(yBWR_currentTable)))
Else 
	QUERY:C277([xShell_Reports:54];[xShell_Reports:54]MainTable:3=(Table:C252(yBWR_currentTable)))
End if 

QUERY SELECTION:C341([xShell_Reports:54];[xShell_Reports:54]Modulo:41=vsBWR_CurrentModule;*)
QUERY SELECTION:C341([xShell_Reports:54]; | [xShell_Reports:54]Modulo:41="";*)
QUERY SELECTION:C341([xShell_Reports:54]; | [xShell_Reports:54]Modulo:41="Todos")


QUERY SELECTION:C341([xShell_Reports:54];[xShell_Reports:54]ReportType:2="4DSE";*)
QUERY SELECTION:C341([xShell_Reports:54]; | [xShell_Reports:54]ReportType:2="4DFO";*)
QUERY SELECTION:C341([xShell_Reports:54]; | [xShell_Reports:54]ReportType:2="gSR2";*)
QUERY SELECTION:C341([xShell_Reports:54]; | [xShell_Reports:54]ReportType:2="4DWR";*)
QUERY SELECTION:C341([xShell_Reports:54]; | [xShell_Reports:54]ReportType:2="4DCT";*)
QUERY SELECTION:C341([xShell_Reports:54]; | [xShell_Reports:54]ReportType:2="4DET";*)
QUERY SELECTION:C341([xShell_Reports:54]; | [xShell_Reports:54]ReportType:2="4DVW")

If ($y_pais->#"")
	QUERY SELECTION:C341([xShell_Reports:54];[xShell_Reports:54]CountryCode:1=$y_pais->)
End if 
If ($y_Idioma->#"")
	QUERY SELECTION:C341([xShell_Reports:54];[xShell_Reports:54]LangageCode:10=$y_Idioma->;*)
	QUERY SELECTION:C341([xShell_Reports:54]; | [xShell_Reports:54]LangageCode:10="")
End if 



CREATE SET:C116([xShell_Reports:54];"tableReports")


  //informes no editables (formularios)
USE SET:C118("tableReports")
QUERY SELECTION:C341([xShell_Reports:54];[xShell_Reports:54]ReportType:2="4DFO")
QR_FilterTemplates 
hl_Reports_4DFORMS:=New list:C375
If (Records in selection:C76([xShell_Reports:54])>0)
	SELECTION TO ARRAY:C260([xShell_Reports:54];$al_ReportRecNums;[xShell_Reports:54]ReportName:26;$at_ReportName;[xShell_Reports:54]Propietary:9;$al_PropietaryID;[xShell_Reports:54]IsStandard:38;$ab_EsEstandar)
	SORT ARRAY:C229($at_ReportName;$al_ReportRecNums;$al_PropietaryID;$ab_EsEstandar;>)
	For ($i;1;Size of array:C274($at_ReportName))
		APPEND TO LIST:C376(hl_Reports_4DFORMS;$at_ReportName{$i};$al_ReportRecNums{$i})
		Case of 
			: ($ab_EsEstandar{$i})
				SET LIST ITEM PROPERTIES:C386(hl_Reports_4DFORMS;0;False:C215;Bold:K14:2;$l_iconoFormulario)
			: ($al_PropietaryID{$i}=<>lUSR_CurrentUserID)
				SET LIST ITEM PROPERTIES:C386(hl_Reports_4DFORMS;0;True:C214;Plain:K14:1;$l_iconoFormulario)
			Else 
				SET LIST ITEM PROPERTIES:C386(hl_Reports_4DFORMS;0;False:C215;Italic:K14:3;$l_iconoFormulario)
		End case 
	End for 
End if 
SET LIST PROPERTIES:C387(hl_Reports_4DFORMS;2;0;16)


  //informes SuperReport
USE SET:C118("tableReports")
QUERY SELECTION:C341([xShell_Reports:54];[xShell_Reports:54]ReportType:2="gSR2")
QR_FilterTemplates 
hl_Reports_SRP:=New list:C375
If (Records in selection:C76([xShell_Reports:54])>0)
	SELECTION TO ARRAY:C260([xShell_Reports:54];$al_ReportRecNums;[xShell_Reports:54]ReportName:26;$at_ReportName;[xShell_Reports:54]Propietary:9;$al_PropietaryID;[xShell_Reports:54]IsStandard:38;$ab_EsEstandar)
	SORT ARRAY:C229($at_ReportName;$al_ReportRecNums;$al_PropietaryID;$ab_EsEstandar;>)
	For ($i;1;Size of array:C274($at_ReportName))
		APPEND TO LIST:C376(hl_Reports_SRP;$at_ReportName{$i};$al_ReportRecNums{$i})
		Case of 
			: ($ab_EsEstandar{$i})
				SET LIST ITEM PROPERTIES:C386(hl_Reports_SRP;0;False:C215;Bold:K14:2;$l_iconoSuperReport)
			: ($al_PropietaryID{$i}=<>lUSR_CurrentUserID)
				SET LIST ITEM PROPERTIES:C386(hl_Reports_SRP;0;True:C214;Plain:K14:1;$l_iconoSuperReport)
			Else 
				SET LIST ITEM PROPERTIES:C386(hl_Reports_SRP;0;False:C215;Italic:K14:3;$l_iconoSuperReport)
		End case 
	End for 
End if 
SET LIST PROPERTIES:C387(hl_Reports_SRP;2;0;18)


  //informes QuickReports
USE SET:C118("tableReports")
QUERY SELECTION:C341([xShell_Reports:54];[xShell_Reports:54]ReportType:2="4DSE")
QR_FilterTemplates 
hl_Reports_QR:=New list:C375
If (Records in selection:C76([xShell_Reports:54])>0)
	SELECTION TO ARRAY:C260([xShell_Reports:54];$al_ReportRecNums;[xShell_Reports:54]ReportName:26;$at_ReportName;[xShell_Reports:54]Propietary:9;$al_PropietaryID;[xShell_Reports:54]IsStandard:38;$ab_EsEstandar)
	SORT ARRAY:C229($at_ReportName;$al_ReportRecNums;$al_PropietaryID;$ab_EsEstandar;>)
	For ($i;1;Size of array:C274($at_ReportName))
		APPEND TO LIST:C376(hl_Reports_QR;$at_ReportName{$i};$al_ReportRecNums{$i})
		Case of 
			: ($ab_EsEstandar{$i})
				SET LIST ITEM PROPERTIES:C386(hl_Reports_QR;0;False:C215;Bold:K14:2;$l_iconoInformeEnColumnas)
			: ($al_PropietaryID{$i}=<>lUSR_CurrentUserID)
				SET LIST ITEM PROPERTIES:C386(hl_Reports_QR;0;True:C214;Plain:K14:1;$l_iconoInformeEnColumnas)
			Else 
				SET LIST ITEM PROPERTIES:C386(hl_Reports_QR;0;False:C215;Italic:K14:3;$l_iconoInformeEnColumnas)
		End case 
	End for 
End if 
SET LIST PROPERTIES:C387(hl_Reports_QR;2;0;18)


  //informes 4D Write
USE SET:C118("tableReports")
QUERY SELECTION:C341([xShell_Reports:54];[xShell_Reports:54]ReportType:2="4DWR")
QR_FilterTemplates 
hl_Reports_WR:=New list:C375
If (Records in selection:C76([xShell_Reports:54])>0)
	SELECTION TO ARRAY:C260([xShell_Reports:54];$al_ReportRecNums;[xShell_Reports:54]ReportName:26;$at_ReportName;[xShell_Reports:54]Propietary:9;$al_PropietaryID;[xShell_Reports:54]IsStandard:38;$ab_EsEstandar)
	SORT ARRAY:C229($at_ReportName;$al_ReportRecNums;$al_PropietaryID;$ab_EsEstandar;>)
	For ($i;1;Size of array:C274($at_ReportName))
		APPEND TO LIST:C376(hl_Reports_WR;$at_ReportName{$i};$al_ReportRecNums{$i})
		Case of 
			: ($ab_EsEstandar{$i})
				SET LIST ITEM PROPERTIES:C386(hl_Reports_WR;0;False:C215;Bold:K14:2;$l_icono4DWrite)
			: ($al_PropietaryID{$i}=<>lUSR_CurrentUserID)
				SET LIST ITEM PROPERTIES:C386(hl_Reports_WR;0;True:C214;Plain:K14:1;$l_icono4DWrite)
			Else 
				SET LIST ITEM PROPERTIES:C386(hl_Reports_WR;0;False:C215;Italic:K14:3;$l_icono4DWrite)
		End case 
	End for 
End if 
SET LIST PROPERTIES:C387(hl_Reports_WR;2;0;18)


  //Informes 4D View
USE SET:C118("tableReports")
QUERY SELECTION:C341([xShell_Reports:54];[xShell_Reports:54]ReportType:2="4DVW")
QR_FilterTemplates 
hl_Reports_VW:=New list:C375
If (Records in selection:C76([xShell_Reports:54])>0)
	SELECTION TO ARRAY:C260([xShell_Reports:54];$al_ReportRecNums;[xShell_Reports:54]ReportName:26;$at_ReportName;[xShell_Reports:54]Propietary:9;$al_PropietaryID;[xShell_Reports:54]IsStandard:38;$ab_EsEstandar)
	SORT ARRAY:C229($at_ReportName;$al_ReportRecNums;$al_PropietaryID;$ab_EsEstandar;>)
	For ($i;1;Size of array:C274($at_ReportName))
		APPEND TO LIST:C376(hl_Reports_VW;$at_ReportName{$i};$al_ReportRecNums{$i})
		Case of 
			: ($ab_EsEstandar{$i})
				SET LIST ITEM PROPERTIES:C386(hl_Reports_VW;0;False:C215;Bold:K14:2;$l_icono4DView)
			: ($al_PropietaryID{$i}=<>lUSR_CurrentUserID)
				SET LIST ITEM PROPERTIES:C386(hl_Reports_VW;0;True:C214;Plain:K14:1;$l_icono4DView)
			Else 
				SET LIST ITEM PROPERTIES:C386(hl_Reports_VW;0;False:C215;Italic:K14:3;$l_icono4DView)
		End case 
	End for 
End if 
SET LIST PROPERTIES:C387(hl_Reports_VW;2;0;18)


  //Informes 4D Chart
USE SET:C118("tableReports")
QUERY SELECTION:C341([xShell_Reports:54];[xShell_Reports:54]ReportType:2="4DCT")
QR_FilterTemplates 
hl_Reports_CT:=New list:C375
If (Records in selection:C76([xShell_Reports:54])>0)
	SELECTION TO ARRAY:C260([xShell_Reports:54];$al_ReportRecNums;[xShell_Reports:54]ReportName:26;$at_ReportName;[xShell_Reports:54]Propietary:9;$al_PropietaryID;[xShell_Reports:54]IsStandard:38;$ab_EsEstandar)
	SORT ARRAY:C229($at_ReportName;$al_ReportRecNums;$al_PropietaryID;$ab_EsEstandar;>)
	For ($i;1;Size of array:C274($at_ReportName))
		APPEND TO LIST:C376(hl_Reports_CT;$at_ReportName{$i};$al_ReportRecNums{$i})
		Case of 
			: ($ab_EsEstandar{$i})
				SET LIST ITEM PROPERTIES:C386(hl_Reports_CT;0;False:C215;Bold:K14:2;$l_icono4DChart)
			: ($al_PropietaryID{$i}=<>lUSR_CurrentUserID)
				SET LIST ITEM PROPERTIES:C386(hl_Reports_CT;0;True:C214;Plain:K14:1;$l_icono4DChart)
			Else 
				SET LIST ITEM PROPERTIES:C386(hl_Reports_CT;0;False:C215;Italic:K14:3;$l_icono4DChart)
		End case 
	End for 
End if 
SET LIST PROPERTIES:C387(hl_Reports_CT;2;0;18)


  //Informes Etiquetas
USE SET:C118("tableReports")
QUERY SELECTION:C341([xShell_Reports:54];[xShell_Reports:54]ReportType:2="4DET")
QR_FilterTemplates 
hl_Reports_LB:=New list:C375
If (Records in selection:C76([xShell_Reports:54])>0)
	SELECTION TO ARRAY:C260([xShell_Reports:54];$al_ReportRecNums;[xShell_Reports:54]ReportName:26;$at_ReportName;[xShell_Reports:54]Propietary:9;$al_PropietaryID;[xShell_Reports:54]IsStandard:38;$ab_EsEstandar)
	SORT ARRAY:C229($at_ReportName;$al_ReportRecNums;$al_PropietaryID;$ab_EsEstandar;>)
	For ($i;1;Size of array:C274($at_ReportName))
		APPEND TO LIST:C376(hl_Reports_LB;$at_ReportName{$i};$al_ReportRecNums{$i})
		Case of 
			: ($ab_EsEstandar{$i})
				SET LIST ITEM PROPERTIES:C386(hl_Reports_LB;0;False:C215;Bold:K14:2;$l_iconoEtiquetas)
			: ($al_PropietaryID{$i}=<>lUSR_CurrentUserID)
				SET LIST ITEM PROPERTIES:C386(hl_Reports_LB;0;True:C214;Plain:K14:1;$l_iconoEtiquetas)
			Else 
				SET LIST ITEM PROPERTIES:C386(hl_Reports_LB;0;False:C215;Italic:K14:3;$l_iconoEtiquetas)
		End case 
	End for 
End if 
SET LIST PROPERTIES:C387(hl_Reports_LB;2;0;18)


SET LIST PROPERTIES:C387(hl_informes;2;0;18)


QR_GetReportsByType (vtQR_CurrentReportType)


$t_filtro:=PREF_fGet (<>lUSR_CurrentUserID;"universoInformes";"todos")

Case of 
	: ($t_filtro="publicos")
		$t_title:=__ ("Públicos o creados por mí")
		
	: ($t_filtro="todos")
		$t_title:=__ ("Todos")
		
	: ($t_filtro="estandar")
		$t_title:=__ ("Estándar")
		
	: ($t_filtro="delColegio")
		$t_title:=__ ("Creados en el colegio")
		
	: ($t_filtro="mios")
		$t_title:=__ ("Creados por mí")
		
	: ($t_filtro="estandarDelColegio")
		$t_title:=__ ("Creados para el colegio")
		
	: ($t_filtro="estandarOtrosColegios")
		$t_title:=__ ("Creados para otros colegios")
		
End case 
IT_PropiedadesBotonPopup ("filtro";$t_title;168)
