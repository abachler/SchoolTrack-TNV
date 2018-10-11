  //`xShell, Alberto Bachler
  //Metodo: Método de Objeto: bSave
  //Por abachler
  //Creada el 21/01/2004, 23:08:35
  //Modificaciones:
C_BOOLEAN:C305($b_crear;$b_guardar)
C_LONGINT:C283($l_registros;$OK)
C_TEXT:C284($newName)
If ("DESCRIPCION"="")
	  //
End if 


$OK:=2

$newName:=Replace string:C233(Replace string:C233(Replace string:C233(vtQR_CurrentReportName;"(";"[");")";"]");"/";"_")
$newName:=Replace string:C233($newName;"\\";"_")

CUT NAMED SELECTION:C334([xShell_Reports:54];"$informes")

QUERY:C277([xShell_Reports:54];[xShell_Reports:54]ReportName:26=$newName;*)
QUERY:C277([xShell_Reports:54]; & ;[xShell_Reports:54]ReportType:2=vtQR_CurrentReportType;*)
QUERY:C277([xShell_Reports:54]; & ;[xShell_Reports:54]MainTable:3=vlQR_SRMainTable)
$l_registros:=Records in selection:C76([xShell_Reports:54])

Case of 
	: ($l_registros>0)
		If (([xShell_Reports:54]Propietary:9#<>lUSR_CurrentUserID) & (Not:C34(USR_IsGroupMember_by_GrpID (-15001))))
			CD_Dlog (0;__ ("Lo siento...\r\rUsted no está autorizado para guardar un informe con el mismo nombre de un informe creado por otro usuario."))
		Else 
			If ([xShell_Reports:54]Propietary:9#<>lUSR_CurrentUserID)
				$OK:=CD_Dlog (0;__ ("El usuario ")+USR_GetUserName ([xShell_Reports:54]Propietary:9)+__ (" es propietario de un informe con el mismo nombre.\r¿Está usted seguro de querer reemplazarlo?");__ ("");__ ("No");__ ("Si, reemplazar"))
			Else 
				$OK:=CD_Dlog (0;__ ("Ya existe un informe con el mismo nombre.\r¿Desea reemplazarlo?");__ ("");__ ("No");__ ("Si, reemplazar"))
			End if 
		End if 
		$b_guardar:=($ok=2)
	: (vlQR_ReportRecNum=No current record:K29:2)
		$b_crear:=True:C214
	: ($l_registros=0)
		$b_crear:=True:C214
End case 

If ($b_crear)
	CREATE RECORD:C68([xShell_Reports:54])
	[xShell_Reports:54]ReportName:26:=$newName
	[xShell_Reports:54]ReportType:2:=vtQR_CurrentReportType
	[xShell_Reports:54]RegistrosXPagina:44:=vlSR_RegXPagina
	[xShell_Reports:54]mSeconds:6:=SYS_DateTime2Secs (Current date:C33(*);Current time:C178(*))
	[xShell_Reports:54]Creacion_Usuario:34:=<>tUSR_CurrentUser
	[xShell_Reports:54]Propietary:9:=<>lUSR_CurrentUserID
	[xShell_Reports:54]Modulo:41:=vsBWR_CurrentModule
	If (<>lUSR_CurrentUserID<0)
		[xShell_Reports:54]Public:8:=True:C214
	End if 
	[xShell_Reports:54]Modificacion_Usuario:39:=<>tUSR_CurrentUser
	If (Not:C34(Undefined:C82(vlQR_SRMainTable)))
		If (vlQR_SRMainTable<0)
			[xShell_Reports:54]MainTable:3:=vlQR_SRMainTable
		Else 
			[xShell_Reports:54]MainTable:3:=Table:C252(yBWR_currentTable)
		End if 
	Else 
		[xShell_Reports:54]MainTable:3:=Table:C252(yBWR_currentTable)
	End if 
	If (bIsOneRecordReport=1)
		[xShell_Reports:54]isOneRecordReport:11:=True:C214
	End if 
	SAVE RECORD:C53([xShell_Reports:54])
	USR_RegisterUserEvent (UE_ReportCreation;vlBWR_SelectedTableRef;[xShell_Reports:54]ReportName:26+";"+[xShell_Reports:54]ReportType:2)
	$b_Guardar:=True:C214
	vlQR_ReportRecNum:=Record number:C243([xShell_Reports:54])
End if 


If ($b_Guardar)
	READ WRITE:C146([xShell_Reports:54])
	GOTO RECORD:C242([xShell_Reports:54];vlQR_ReportRecNum)
	
	Case of 
		: ([xShell_Reports:54]ReportType:2="gSR2")
			If (bIsOneRecordReport=1)
				[xShell_Reports:54]isOneRecordReport:11:=True:C214
			End if 
			SRP_GuardaDatosInforme 
			
		: ([xShell_Reports:54]ReportType:2="4DSE")
			If (Table:C252(yBWR_currentTable)#vlQR_MainTable)
				[xShell_Reports:54]RelatedTable:14:=QR Get report table:C758(xQR_ReportArea)
			End if 
			QR REPORT TO BLOB:C770(xQR_ReportArea;[xShell_Reports:54]xReportData_:29)
	End case 
	SAVE RECORD:C53([xShell_Reports:54])
	
	USR_RegisterUserEvent (UE_ReportCreation;vlBWR_SelectedTableRef;[xShell_Reports:54]ReportName:26+";"+[xShell_Reports:54]ReportType:2)
	
	ACCEPT:C269
End if 


USE NAMED SELECTION:C332("$informes")