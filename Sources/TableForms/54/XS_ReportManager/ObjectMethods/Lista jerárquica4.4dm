  // [xShell_Reports].XS_ReportManager.Lista jerárquica4()
  // 
  //
  // creado por: Alberto Bachler Klein: 31-03-16, 16:34:24
  // -----------------------------------------------------------



C_LONGINT:C283($l_recNum;$vlButton;$vlMouseX;$vlMouseY)
C_TEXT:C284($t_nombreInforme;$t_parametro;$t_ref)

ARRAY TEXT:C222($at_nombreItems;0)
ARRAY TEXT:C222($at_refMenus;0)
C_LONGINT:C283(vlQR_ReportType)

Case of 
	: (Form event:C388=On Data Change:K2:15)
		GET LIST ITEM:C378(Self:C308->;Selected list items:C379(Self:C308->);$l_recNum;$t_nombreInforme)
		KRL_GotoRecord (->[xShell_Reports:54];$l_recNum;True:C214)
		$t_nombreInforme:=Replace string:C233(Replace string:C233(Replace string:C233($t_nombreInforme;"(";"[");")";"]");"/";"_")
		$t_nombreInforme:=Replace string:C233($t_nombreInforme;"\\";"_")
		[xShell_Reports:54]ReportName:26:=$t_nombreInforme
		SAVE RECORD:C53([xShell_Reports:54])
		QUERY:C277([xShell_FavoriteReports:183];[xShell_FavoriteReports:183]ReportId:2=[xShell_Reports:54]ID:7)
		READ WRITE:C146([xShell_FavoriteReports:183])
		APPLY TO SELECTION:C70([xShell_FavoriteReports:183];[xShell_FavoriteReports:183]ReportName:4:=[xShell_Reports:54]ReportName:26)
		UNLOAD RECORD:C212([xShell_FavoriteReports:183])
		SET LIST ITEM:C385(Self:C308->;$l_recNum;$t_nombreInforme;$l_recNum)
		KRL_ReloadAsReadOnly (->[xShell_Reports:54])
		Case of 
			: ([xShell_Reports:54]ReportType:2="4DFO")  // 4D Form
				SET LIST ITEM:C385(hl_Reports_4DFORMS;[xShell_Reports:54]ID:7;[xShell_Reports:54]ReportName:26;[xShell_Reports:54]ID:7)
				SORT LIST:C391(hl_Reports_4DFORMS;>)
				
			: ([xShell_Reports:54]ReportType:2="gSR2")  // SuperReport
				SET LIST ITEM:C385(hl_Reports_SRP;[xShell_Reports:54]ID:7;[xShell_Reports:54]ReportName:26;[xShell_Reports:54]ID:7)
				SORT LIST:C391(hl_Reports_SRP;>)
				
			: ([xShell_Reports:54]ReportType:2="4DSE")  //Quick Report
				SET LIST ITEM:C385(hl_Reports_QR;[xShell_Reports:54]ID:7;[xShell_Reports:54]ReportName:26;[xShell_Reports:54]ID:7)
				SORT LIST:C391(hl_Reports_QR;>)
				
			: ([xShell_Reports:54]ReportType:2="4DET")  //Etiquetas
				SET LIST ITEM:C385(hl_Reports_LB;[xShell_Reports:54]ID:7;[xShell_Reports:54]ReportName:26;[xShell_Reports:54]ID:7)
				SORT LIST:C391(hl_Reports_LB;>)
				
		End case 
		QR_LoadSelectedReport 
		GOTO OBJECT:C206(Self:C308->)
		
	: (Form event:C388=On Double Clicked:K2:5)
		QR_LoadSelectedReport 
		If ([xShell_Reports:54]ReportType:2#"4DFO")
			QR_EditTemplate 
		End if 
		
		
	: (Form event:C388=On Clicked:K2:4)
		QR_LoadSelectedReport 
		If (Contextual click:C713)
			$t_ref:=Get menu bar reference:C979(Frontmost process:C327)
			GET MENU ITEMS:C977($t_ref;$at_nombreItems;$at_refMenus)
			$t_parametro:=Dynamic pop up menu:C1006($at_refMenus{1})
			
			QR_EjecutaItemMenu ($t_parametro)
		End if 
		
End case 

