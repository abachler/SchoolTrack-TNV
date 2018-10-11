C_LONGINT:C283(cb_LimitarBusquedas)
Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		If ([xShell_UserGroups:17]IDGroup:1=0)
			[xShell_UserGroups:17]IDGroup:1:=SQ_SeqNumber (->[xShell_UserGroups:17]IDGroup:1;True:C214)
			[xShell_UserGroups:17]Propietary:3:=<>lUSR_CurrentUserID
			ARRAY REAL:C219(<>aUserPriv;Size of array:C274(<>aPriv))
			For ($i;1;Size of array:C274(<>aPriv))
				<>aUserPriv{$i}:=<>aPriv{$i}+0.1
			End for 
			BLOB_Variables2Blob (->[xShell_UserGroups:17]xTableAcces:4;0;-><>aUserPriv)
			
			ARRAY TEXT:C222(<>aTools;0)
			BLOB_Variables2Blob (->[xShell_UserGroups:17]xCommands:5;0;-><>aTools)
			cb_LimitarBusquedas:=0
			cb_AccesoDashboards:=0
		Else 
			$err:=USR_GetGroupAppSpecificData ([xShell_UserGroups:17]IDGroup:1;"limitarbusquedas";->cb_LimitarBusquedas)
			$err:=USR_GetGroupAppSpecificData ([xShell_UserGroups:17]IDGroup:1;"dashboards";->cb_AccesoDashboards)
		End if 
		ARRAY REAL:C219(<>aUserPriv;0)
		BLOB_Blob2Vars (->[xShell_UserGroups:17]xTableAcces:4;0;-><>aUserPriv)
		ARRAY TEXT:C222(<>aTxtPriv;Size of array:C274(<>aUserPriv))
		ARRAY PICTURE:C279(<>aPictPriv;Size of array:C274(<>aUserPriv))
		For ($i;Size of array:C274(<>aUserPriv);1;-1)
			$n:=20000+(Dec:C9(<>aUserPriv{$i})*10)
			  //GET PICTURE RESOURCE($n;$pict)
			GET PICTURE FROM LIBRARY:C565($n;$pict)
			<>aPictPriv{$i}:=$pict
			$el:=Find in array:C230(<>aPriv;Int:C8(<>aUserPriv{$i}))
			If ($el>-1)
				<>aTxtPriv{$i}:=<>aPrivN{$el}
			Else 
				DELETE FROM ARRAY:C228(<>aUserPriv;$i)
				DELETE FROM ARRAY:C228(<>aTxtPriv;$i)
				DELETE FROM ARRAY:C228(<>aPictPriv;$i)
			End if 
		End for 
		For ($i;1;Size of array:C274(<>aPriv))
			If (Find in array:C230(<>aTxtPriv;<>aPrivN{$i})=-1)
				AT_Insert (Size of array:C274(<>aTxtPriv)+1;1;-><>aTxtPriv;-><>aUserPriv;-><>aPictPriv)
				<>aTxtPriv{Size of array:C274(<>aTxtPriv)}:=<>aPrivN{$i}
				<>aUserPriv{Size of array:C274(<>aTxtPriv)}:=Num:C11(String:C10(<>aPriv{$i})+<>tXS_RS_DecimalSeparator+"0")
				GET PICTURE FROM LIBRARY:C565(20000;$pict)
				<>aPictPriv{Size of array:C274(<>aTxtPriv)}:=$pict
			End if 
		End for 
		
		ARRAY TEXT:C222(<>aAuthMethodsAlias;0)
		ARRAY TEXT:C222(<>aAuthMethodsNames;0)
		If (BLOB size:C605([xShell_UserGroups:17]xCommands:5)=0)
			BLOB_Variables2Blob (->[xShell_UserGroups:17]xCommands:5;0;-><>aAuthMethodsAlias;-><>aAuthMethodsNames)
		Else 
			BLOB_Blob2Vars (->[xShell_UserGroups:17]xCommands:5;0;-><>aAuthMethodsAlias;-><>aAuthMethodsNames)
		End if 
		If (Size of array:C274(<>aAuthMethodsNames)>Size of array:C274(<>aAuthMethodsAlias))  //MONO Ticket 205178
			ARRAY TEXT:C222(<>aAuthMethodsAlias;Size of array:C274(<>aAuthMethodsNames))
		End if 
		$b_actualizar_xCommands:=False:C215
		For ($i;Size of array:C274(<>aAuthMethodsNames);1;-1)
			$l_recNum:=Find in field:C653([xShell_ExecutableCommands:19]MethodName:2;<>aAuthMethodsNames{$i})
			If ($l_recNum>No current record:K29:2)
				$alias:=ST_GetWord (XS_GetCommandAliasDescription ($l_recNum;<>vtXS_CountryCode;<>vtXS_Langage);1;"\t")
				If ($alias#<>aAuthMethodsAlias{$i})
					<>aAuthMethodsAlias{$i}:=$alias
					$b_actualizar_xCommands:=True:C214
				End if 
			Else 
				AT_Delete ($i;1;-><>aAuthMethodsAlias;-><>aAuthMethodsNames)
			End if 
		End for 
		If ($b_actualizar_xCommands)
			BLOB_Variables2Blob (->[xShell_UserGroups:17]xCommands:5;0;-><>aAuthMethodsAlias;-><>aAuthMethodsNames)
			SAVE RECORD:C53([xShell_UserGroups:17])
		End if 
		
		If ([xShell_UserGroups:17]GroupName:2="Administración")
			OBJECT SET ENTERABLE:C238([xShell_UserGroups:17]GroupName:2;False:C215)
		End if 
		SORT ARRAY:C229(<>aTxtPriv;<>aUserPriv;<>aPictPriv;>)
		SORT ARRAY:C229(<>aTools;>)
		
		
		LIST TO ARRAY:C288("XS_Modules";aModules)
		ARRAY TEXT:C222(<>atUSR_AuthModules;0)
		BLOB_Blob2Vars (->[xShell_UserGroups:17]Modules:11;0;-><>atUSR_AuthModules)
		If (Size of array:C274(<>atUSR_AuthModules)=0)
			INSERT IN ARRAY:C227(<>atUSR_AuthModules;1)
			<>atUSR_AuthModules{1}:="SchoolTrack"
			BLOB_Variables2Blob (->[xShell_UserGroups:17]Modules:11;0;-><>atUSR_AuthModules)
		End if 
		
		hl_AuthModules:=Load list:C383("XS_Modules")
		For ($i;1;Count list items:C380(hl_AuthModules))
			GET LIST ITEM:C378(hl_AuthModules;$i;$moduleRef;$moduleName)
			$el:=Find in array:C230(<>atUSR_AuthModules;$moduleName)
			If ($el>0)
				SET LIST ITEM PROPERTIES:C386(hl_AuthModules;$moduleRef;False:C215;0;Use PicRef:K28:4+2078)
			Else 
				SET LIST ITEM PROPERTIES:C386(hl_AuthModules;$moduleRef;False:C215;0;Use PicRef:K28:4+2077)
			End if 
		End for 
		SET LIST PROPERTIES:C387(hl_AuthModules;1;0;18)
		SELECT LIST ITEMS BY POSITION:C381(hl_AuthModules;1)
		_O_REDRAW LIST:C382(hl_AuthModules)
		
		USR_SetExecMethodsList 
		
		
		$pos:=Find in array:C230(<>alUSR_UserIds;[xShell_UserGroups:17]Propietary:3)
		If ($pos>0)
			[xShell_UserGroups:17]PropietaryName:9:=<>atUSR_UserNames{$pos}
		End if 
		
		If ([xShell_UserGroups:17]IDGroup:1=-15001)
			OBJECT SET ENTERABLE:C238([xShell_UserGroups:17]Timeout_Minutes:12;False:C215)
			cb_LimitarBusquedas:=0
			OBJECT SET ENABLED:C1123(cb_LimitarBusquedas;False:C215)
		End if 
		
		<>aTextPriv:=0
		<>aPictPriv:=0
		For ($i;1;Size of array:C274(lb_privilegios))
			lb_privilegios{$i}:=False:C215
		End for 
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
End case 
