//%attributes = {}
  //UFLD_Edit

If (False:C215)
	  //============================== IDENTIFICACION ==============================
	  // Procédure : DCUserFields
	  //Autor: Alberto Bachler
	  //Creada el 20/6/96 a 10:38 AM
	  //============================== DESCRIPCION ==============================
	  //Package:
	  //Descripción:
	  //Sintaxis:
	  //============================== MODIFICACIONES ==============================
	  //Fecha: 
	  //Autor:
	  //Descripción:
End if 


aUFid:=aUFname
$tempLoc:=aUFname
idxPtr:=->aUFid
QUERY:C277([xShell_Userfields:76];[xShell_Userfields:76]FieldID:7=aUFid{aUFName})
If (Records in selection:C76([xShell_Userfields:76])#0)
	sUFValue:=""
	$title:=__ ("Campo propio: ")+aUFName{aUFName}
	WDW_OpenFormWindow (->[xShell_Userfields:76];"Input";-1;Movable form dialog box:K39:8;$title)
	KRL_ModifyRecord (->[xShell_Userfields:76];"Input")
	AL_UpdateArrays (XALP_UserFields;0)
	UFLD_LoadArrays 
	AL_UpdateArrays (XALP_UserFields;-2)
	AL_SetSort (XALP_UserFields;2;1)
	If (Size of array:C274(aUFName)=0)
		AL_SetLine (XALP_UserFields;0)
		aUFName:=0
		IT_SetButtonState (aUFName#0;->bDelUF;->bEdit)
		tinfos:=""
	Else 
		Case of 
			: (Size of array:C274(aUFName)=1)
				AL_SetLine (XALP_UserFields;1)
				aUFName:=1
				IT_SetButtonState (aUFName#0;->bDelUF;->bEdit)
			: ($tempLoc>Size of array:C274(aUFName))
				AL_SetLine (XALP_UserFields;Size of array:C274(aUFName))
				aUFName:=Size of array:C274(aUFName)
				IT_SetButtonState (aUFName#0;->bDelUF;->bEdit)
			Else 
				AL_SetLine (XALP_UserFields;$tempLoc)
				aUFName:=$tempLoc
				IT_SetButtonState (aUFName#0;->bDelUF;->bEdit)
		End case 
		C_LONGINT:C283($f;$t)
		$id:=String:C10(aUFid{aUFname};"00000/"+"@")
		READ ONLY:C145([xShell_Userfields:76])
		QUERY:C277([xShell_Userfields:76];[xShell_Userfields:76]FieldID:7=aUFid{aUFname})
		vField:="["+Table name:C256([xShell_Userfields:76]FileNo:6)+"]Userfields'Value"
		EXECUTE FORMULA:C63("vPointer:=»"+vField)
		SET QUERY DESTINATION:C396(Into variable:K19:4;$f)
		QUERY:C277(Table:C252([xShell_Userfields:76]FileNo:6)->;vPointer->=$id)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		  //$f:=Records in selection(Table([xShell_Userfields]FileNo)->)
		If ($f>0)
			$t:=Records in table:C83(Table:C252([xShell_Userfields:76]FileNo:6)->)
			$ratio:=String:C10(Round:C94($f/$t*100;2);"##0,00%")
			tInfos:="Utilizado en un "+$ratio+" de los registros del archivo."
		Else 
			tInfos:="No utilizado."
		End if 
	End if 
	WDW_Close 
End if 
