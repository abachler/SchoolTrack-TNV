C_TEXT:C284($vt_MenuImpresion;$vt_ToolsMenu)

RELEASE MENU:C978($vt_ToolsMenu)
RELEASE MENU:C978($vt_MenuImpresion)

$vt_ToolsMenu:=Create menu:C408
$vt_MenuImpresion:=Create menu:C408
APPEND MENU ITEM:C411($vt_MenuImpresion;__ ("Por orden de creación…"))
APPEND MENU ITEM:C411($vt_MenuImpresion;"-")
APPEND MENU ITEM:C411($vt_MenuImpresion;__ ("Por subsector…"))
APPEND MENU ITEM:C411($vt_MenuImpresion;__ ("Por sector…"))
APPEND MENU ITEM:C411($vt_MenuImpresion;__ ("Por departamento…"))
APPEND MENU ITEM:C411($vt_MenuImpresion;__ ("Por número de orden…"))
SET MENU ITEM PARAMETER:C1004($vt_MenuImpresion;1;"creacion")
SET MENU ITEM PARAMETER:C1004($vt_MenuImpresion;3;"subsector")
SET MENU ITEM PARAMETER:C1004($vt_MenuImpresion;4;"sector")
SET MENU ITEM PARAMETER:C1004($vt_MenuImpresion;5;"departamento")
SET MENU ITEM PARAMETER:C1004($vt_MenuImpresion;6;"orden")
APPEND MENU ITEM:C411($vt_ToolsMenu;__ ("Impresión");$vt_MenuImpresion)
$choice:=Dynamic pop up menu:C1006($vt_ToolsMenu)
If ($choice#"")
	ddate:=Current date:C33
	hheure:=Current time:C178
	READ ONLY:C145([xxSTR_Materias:20])
	ALL RECORDS:C47([xxSTR_Materias:20])
	Case of 
		: ($choice="creacion")
			  //nada... tal como los entregra all records
		: ($choice="subsector")
			ORDER BY:C49([xxSTR_Materias:20];[xxSTR_Materias:20]Materia:2;>)
		: ($choice="sector")
			ORDER BY:C49([xxSTR_Materias:20];[xxSTR_Materias:20]Area:12;>)
		: ($choice="departamento")
			ORDER BY:C49([xxSTR_Materias:20];[xxSTR_Materias:20]Departamento:3;>)
		: ($choice="orden")
			ORDER BY:C49([xxSTR_Materias:20];[xxSTR_Materias:20]Orden interno:9;>)
	End case 
	FORM SET OUTPUT:C54([xxSTR_Materias:20];"Print")
	PRINT SELECTION:C60([xxSTR_Materias:20])
	RELEASE MENU:C978($vt_MenuImpresion)
	RELEASE MENU:C978($vt_ToolsMenu)
	Case of 
		: (TituloOrden#0)
			If (TituloOrden=1)
				ORDER BY:C49([xxSTR_Materias:20];[xxSTR_Materias:20]NoSector:11;>)
			Else 
				ORDER BY:C49([xxSTR_Materias:20];[xxSTR_Materias:20]NoSector:11;<)
			End if 
		: (TituloSector#0)
			If (TituloSector=1)
				ORDER BY:C49([xxSTR_Materias:20];[xxSTR_Materias:20]Area:12;>)
			Else 
				ORDER BY:C49([xxSTR_Materias:20];[xxSTR_Materias:20]Area:12;<)
			End if 
		: (TituloSubsector#0)
			If (TituloSubsector=1)
				ORDER BY:C49([xxSTR_Materias:20];[xxSTR_Materias:20]Materia:2;>)
			Else 
				ORDER BY:C49([xxSTR_Materias:20];[xxSTR_Materias:20]Materia:2;<)
			End if 
	End case 
	OBJECT SET SCROLL POSITION:C906(*;"lb_Materias")
End if 