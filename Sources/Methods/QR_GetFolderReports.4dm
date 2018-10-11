//%attributes = {}
  // QR_GetFolderReports()
  // Por: Alberto Bachler K.: 18-08-14, 18:37:32
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_editable)
C_LONGINT:C283($l_estilo;$l_idCarpetaFavoritos;$l_IdInforme;$l_recNum;$l_refIcono;$l_refIcono4DChart;$l_refIcono4DView;$l_refIcono4DWrite;$l_refIconoCarpeta;$l_refIconoEtiqueta)
C_LONGINT:C283($l_refIconoFormulario;$l_refIconoInformeColumnas;$l_refIconoSuperReport)
C_TEXT:C284($t_nombreCarpetaFavoritos;$t_nombreInforme)

$l_refIconoCarpeta:=Use PicRef:K28:4+27511
$l_refIconoSuperReport:=Use PicRef:K28:4+27512
$l_refIconoFormulario:=Use PicRef:K28:4+27513
$l_refIconoInformeColumnas:=Use PicRef:K28:4+27514
$l_refIconoEtiqueta:=Use PicRef:K28:4+27516
$l_refIcono4DView:=Use PicRef:K28:4+12040
$l_refIcono4DWrite:=Use PicRef:K28:4+12041
$l_refIcono4DChart:=Use PicRef:K28:4+12038



If (Count parameters:C259=1)
	$l_idCarpetaFavoritos:=$1
	SELECT LIST ITEMS BY REFERENCE:C630(hl_FavoriteReports;$l_idCarpetaFavoritos)
Else 
	GET LIST ITEM:C378(hl_FavoriteReports;Selected list items:C379(hl_FavoriteReports);$l_idCarpetaFavoritos;$t_nombreCarpetaFavoritos)
End if 
GET LIST ITEM:C378(hl_FavoriteReports;Selected list items:C379(hl_FavoriteReports);$l_idCarpetaFavoritos;$t_nombreCarpetaFavoritos)
OBJECT SET TITLE:C194(*;"informes";"Favoritos: "+$t_nombreCarpetaFavoritos)

If (Is a list:C621(hl_Informes))
	CLEAR LIST:C377(hl_Informes)
End if 

hl_Informes:=New list:C375
READ WRITE:C146([xShell_FavoriteReports:183])
QUERY:C277([xShell_FavoriteReports:183];[xShell_FavoriteReports:183]UserID:1=<>lUSR_CurrentUserID;*)
QUERY:C277([xShell_FavoriteReports:183]; & ;[xShell_FavoriteReports:183]ReportParentListId:7=$l_idCarpetaFavoritos;*)
QUERY:C277([xShell_FavoriteReports:183]; & ;[xShell_FavoriteReports:183]ReportTable:5;=;Table:C252(vyQR_TablePointer);*)
QUERY:C277([xShell_FavoriteReports:183]; & ;[xShell_FavoriteReports:183]IsListDef:9=False:C215)



While (Not:C34(End selection:C36([xShell_FavoriteReports:183])))
	$l_recNum:=Find in field:C653([xShell_Reports:54]ID:7;[xShell_FavoriteReports:183]ReportId:2)
	If ($l_recNum<0)
		QUERY:C277([xShell_Reports:54];[xShell_Reports:54]ReportName:26;=;[xShell_FavoriteReports:183]ReportName:4;*)
		QUERY:C277([xShell_Reports:54]; & ;[xShell_Reports:54]MainTable:3;=;Table:C252(vyQR_TablePointer))
		If (Records in selection:C76([xShell_Reports:54])=1)
			[xShell_FavoriteReports:183]ReportId:2:=[xShell_Reports:54]ID:7
			SAVE RECORD:C53([xShell_FavoriteReports:183])
		End if 
	End if 
	
	
	
	$l_recNum:=Find in field:C653([xShell_Reports:54]ID:7;[xShell_FavoriteReports:183]ReportId:2)
	If ($l_recNum>=0)
		APPEND TO LIST:C376(hl_Informes;[xShell_FavoriteReports:183]ReportName:4;$l_recNum)
		Case of 
			: ([xShell_FavoriteReports:183]ReportType:8="4DFO")
				SET LIST ITEM PROPERTIES:C386(hl_Informes;$l_recNum;$b_editable;$l_estilo;$l_refIconoFormulario)
			: ([xShell_FavoriteReports:183]ReportType:8="4DSE")
				SET LIST ITEM PROPERTIES:C386(hl_Informes;$l_recNum;$b_editable;$l_estilo;$l_refIconoInformeColumnas)
			: ([xShell_FavoriteReports:183]ReportType:8="gSR2")
				SET LIST ITEM PROPERTIES:C386(hl_Informes;$l_recNum;$b_editable;$l_estilo;$l_refIconoSuperReport)
			: ([xShell_FavoriteReports:183]ReportType:8="4DET")
				SET LIST ITEM PROPERTIES:C386(hl_Informes;$l_recNum;$b_editable;$l_estilo;$l_refIconoEtiqueta)
			: ([xShell_FavoriteReports:183]ReportType:8="4DWR")
				SET LIST ITEM PROPERTIES:C386(hl_Informes;$l_recNum;$b_editable;$l_estilo;$l_refIcono4DWrite)
			: ([xShell_FavoriteReports:183]ReportType:8="4DVW")
				SET LIST ITEM PROPERTIES:C386(hl_Informes;$l_recNum;$b_editable;$l_estilo;$l_refIcono4DView)
			: ([xShell_FavoriteReports:183]ReportType:8="4DCT")
				SET LIST ITEM PROPERTIES:C386(hl_Informes;$l_recNum;$b_editable;$l_estilo;$l_refIcono4DChart)
		End case 
	End if 
	NEXT RECORD:C51([xShell_FavoriteReports:183])
End while 
READ ONLY:C145([xShell_FavoriteReports:183])
SET LIST PROPERTIES:C387(hl_Informes;2;0;18)

If (Count parameters:C259=2)
	$l_IdInforme:=$2
Else 
	If (Count list items:C380(hl_Informes)>0)
		GET LIST ITEM:C378(hl_Informes;1;$l_IdInforme;$t_nombreInforme)
	Else 
		$l_IdInforme:=0
	End if 
End if 

If ($l_IdInforme#0)
	SELECT LIST ITEMS BY REFERENCE:C630(hl_Informes;$l_IdInforme)
Else 
	REDUCE SELECTION:C351([xShell_Reports:54];0)
End if 



