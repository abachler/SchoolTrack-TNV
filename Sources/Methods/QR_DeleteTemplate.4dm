//%attributes = {}
  // QR_DeleteTemplate()
  // Por: Alberto Bachler K.: 17-08-14, 18:49:28
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_borrar)
C_LONGINT:C283($l_error;$l_idInformeActual;$l_recNum)
C_TEXT:C284($t_nombreInforme)

$b_borrar:=False:C215
GET LIST ITEM:C378(hl_informes;Selected list items:C379(hl_informes);$l_recNum;$t_nombreInforme)
KRL_GotoRecord (->[xShell_Reports:54];$l_recNum;True:C214)
$l_idInformeActual:=[xShell_Reports:54]ID:7

Case of 
	: (([xShell_Reports:54]IsStandard:38) & (<>lUSR_CurrentUserID<0))
		OK:=CD_Dlog (0;__ ("Este es un informe estándar. ¿Deseas eliminarlo también del repositorio?");__ ("");__ ("No. Solo de la librería");__ ("Si. Del repositorio");__ ("Cancelar"))
		Case of 
			: (OK=1)  //solo librería
				$b_borrar:=True:C214
				
			: (OK=2)  //repositorio
				
				$b_borrar:=True:C214
				  //$l_error:=QR_RIN_Remove_NU
				$l_error:=RIN_InformeObsoleto ([xShell_Reports:54]UUID:47)
				If ($l_error#0)
					CD_Dlog (0;__ ("El informe no pudo ser eliminado del repositorio pero fue eliminado de la librería local."))
				End if 
				
			: (OK=3)  //nada
		End case 
		
	: (([xShell_Reports:54]IsStandard:38) & (USR_IsGroupMember_by_GrpID (-15001)))
		OK:=CD_Dlog (0;__ ("El informe será eliminado de la librería local.\\Si usted lo desea podrá restaurarlo descargándolo desde el repositorio."))
		$b_borrar:=True:C214
		
	: ((Not:C34([xShell_Reports:54]IsStandard:38) & ((<>lUSR_CurrentUserID=[xShell_Reports:54]Propietary:9) | ([xShell_Reports:54]Propietary:9<0) | (USR_IsGroupMember_by_GrpID (-15001)))))
		OK:=CD_Dlog (0;Replace string:C233(__ ("¿Desea realmente eliminar el informe ˆ0?");__ ("ˆ0");[xShell_Reports:54]ReportName:26);__ ("");__ ("No");__ ("Si"))
		If (ok=2)
			$b_borrar:=True:C214
		End if 
		
End case 

If ($b_borrar)
	DELETE FROM LIST:C624(hl_informes;*)
	_O_REDRAW LIST:C382(hl_informes)
	Case of 
		: ([xShell_Reports:54]ReportType:2="4DFO")  // 4D Form
		: ([xShell_Reports:54]ReportType:2="gSR2")  // SuperReport
			DELETE FROM LIST:C624(hl_Reports_SRP;$l_recNum)
			_O_REDRAW LIST:C382(hl_Reports_SRP)
		: ([xShell_Reports:54]ReportType:2="4DSE")  //Quick Report
			DELETE FROM LIST:C624(hl_Reports_QR;$l_recNum)
			_O_REDRAW LIST:C382(hl_Reports_QR)
		: ([xShell_Reports:54]ReportType:2="4DET")  //Etiquetas
			DELETE FROM LIST:C624(hl_Reports_LB;$l_recNum)
			_O_REDRAW LIST:C382(hl_Reports_LB)
		: ([xShell_Reports:54]ReportType:2="4DWR")  //Write
			DELETE FROM LIST:C624(hl_Reports_WR;$l_recNum)
			_O_REDRAW LIST:C382(hl_Reports_WR)
		: ([xShell_Reports:54]ReportType:2="4DVW")  //View
			DELETE FROM LIST:C624(hl_Reports_VW;$l_recNum)
			_O_REDRAW LIST:C382(hl_Reports_VW)
		: ([xShell_Reports:54]ReportType:2="4DDW")  //Draw
			DELETE FROM LIST:C624(hl_Reports_DW;$l_recNum)
			_O_REDRAW LIST:C382(hl_Reports_DW)
		: ([xShell_Reports:54]ReportType:2="4DCR")  //Chart
			DELETE FROM LIST:C624(hl_Reports_CT;$l_recNum)
			_O_REDRAW LIST:C382(hl_Reports_CT)
			
	End case 
	DELETE RECORD:C58([xShell_Reports:54])
	
	
	READ ONLY:C145([xShell_Reports:54])
	READ WRITE:C146([xShell_FavoriteReports:183])
	QUERY:C277([xShell_FavoriteReports:183];[xShell_FavoriteReports:183]ReportId:2=$l_idInformeActual)
	DELETE SELECTION:C66([xShell_FavoriteReports:183])
	READ ONLY:C145([xShell_FavoriteReports:183])
	
	
	
	QR_LoadSelectedReport 
End if 

