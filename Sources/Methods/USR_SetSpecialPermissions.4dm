//%attributes = {}
  //USR_SetSpecialPermissions

C_TEXT:C284($reference;$method;$winTitle;$1;$2;$3)
$reference:=$1
$groupAllowed:=-15001

Case of 
	: (Count parameters:C259=4)
		$groupAllowed:=$4
		If ($3#"")
			$winTitle:=__ ("Permisos Especiales para ")+$3
		End if 
		$method:=$2
	: (Count parameters:C259>=3)
		$winTitle:=__ ("Permisos Especiales para ")+$3
		$method:=$2
	Else 
		$method:=$2
End case 

If ((USR_IsGroupMember_by_GrpID ($groupAllowed)) | ($groupAllowed=0))
	Case of 
		: (($reference#"") & ($method#""))
			QUERY:C277([xShell_SpecialPermissions:119];[xShell_SpecialPermissions:119]Reference:1=$reference;*)
			QUERY:C277([xShell_SpecialPermissions:119]; & ;[xShell_SpecialPermissions:119]MethodName:2=$method)
			If (Records in selection:C76([xShell_SpecialPermissions:119])=0)
				QUERY:C277([xShell_SpecialPermissions:119];[xShell_SpecialPermissions:119]MethodName:2=$method)
			End if 
		: (($reference="") & ($method#""))
			QUERY:C277([xShell_SpecialPermissions:119];[xShell_SpecialPermissions:119]MethodName:2=$method)
		: (($reference#"") & ($method=""))
			QUERY:C277([xShell_SpecialPermissions:119];[xShell_SpecialPermissions:119]Reference:1=$reference)
	End case 
	
	If (Records in selection:C76([xShell_SpecialPermissions:119])=0)
		CREATE RECORD:C68([xShell_SpecialPermissions:119])
		If ($reference="")
			$reference:=$method
		End if 
		[xShell_SpecialPermissions:119]Reference:1:=$reference
		[xShell_SpecialPermissions:119]MethodName:2:=$method
		SAVE RECORD:C53([xShell_SpecialPermissions:119])
	End if 
	If (Records in selection:C76([xShell_SpecialPermissions:119])=1)
		WDW_OpenFormWindow (->[xShell_SpecialPermissions:119];"Permissions";-1;Movable form dialog box:K39:8;$winTitle)
		KRL_ModifyRecord (->[xShell_SpecialPermissions:119];"Permissions")
		CLOSE WINDOW:C154
	Else 
		CD_Dlog (0;__ ("Error. Hay más de un registro de permisos especiales.\r\rLos permisos especiales no pueden ser utilizados."))
	End if 
Else 
	CD_Dlog (0;__ ("Usted no está habilitado a otorgar permisos especiales para este objeto o función."))
End if 