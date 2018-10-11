C_LONGINT:C283($styles;$icon)
C_BOOLEAN:C305($enterable)
C_PICTURE:C286(prefIcon;vp_FondoConfig)

Case of 
	: (Form event:C388=On Load:K2:1)
		vbCFG_CloseWindow:=False:C215
		vtXS_PrefTitle:=<>vsXS_CurrentModule
		XS_SetConfigInterface (False:C215)
		
		
		
		READ ONLY:C145([XShell_ExecutableObjects:280])
		QUERY:C277([XShell_ExecutableObjects:280];[XShell_ExecutableObjects:280]Class:1="ConfigPanel";*)
		QUERY:C277([XShell_ExecutableObjects:280]; & ;[XShell_ExecutableObjects:280]ModuleRef:8=<>vlXS_CurrentModuleRef;*)
		QUERY:C277([XShell_ExecutableObjects:280]; & ;[XShell_ExecutableObjects:280]CountryCode:6=<>vtXS_CountryCode;*)
		QUERY:C277([XShell_ExecutableObjects:280]; & ;[XShell_ExecutableObjects:280]LangageCode:7=<>vtXS_langage)
		ORDER BY:C49([XShell_ExecutableObjects:280];[XShell_ExecutableObjects:280]Order:11;>;[XShell_ExecutableObjects:280]Object_Alias:5)
		
		SELECTION TO ARRAY:C260([XShell_ExecutableObjects:280];alXS_ExecObjects_RecNum;[XShell_ExecutableObjects:280]Object_Alias:5;atXS_ExecObjects_Alias;[XShell_ExecutableObjects:280]Object_Name:2;atXS_ExecObjects_RefName;[XShell_ExecutableObjects:280]Object_MethodName:3;atXS_ExecObjects_Method;[XShell_ExecutableObjects:280]IconRef:10;alXS_ExecObjects_IconRef)
		ARRAY TEXT:C222(atXS_ConfigMethods;28)
		For ($i;1;28)
			$pictPointer:=Get pointer:C304("bCFG_Panel"+String:C10($i))
			$textPointer:=Get pointer:C304("vtXS_Config"+String:C10($i))
			$button:="bCFG_Panel"+String:C10($i)
			$textPointer->:=""
			atXS_ConfigMethods{$i}:=""
			OBJECT SET FORMAT:C236(*;$button;"1;4;?"+String:C10(0)+";240;0")
		End for 
		
		$items:=Size of array:C274(alXS_ExecObjects_RecNum)
		Case of 
			: ($items<=7)
				GET WINDOW RECT:C443($left;$top;$right;$bottom)
				SET WINDOW RECT:C444($left;$top;$right;$top+358)
				vp_FondoConfig:=vp_FondoConfig*0.554
			: ($items<=14)
				GET WINDOW RECT:C443($left;$top;$right;$bottom)
				SET WINDOW RECT:C444($left;$top;$right;$top+458)
				vp_FondoConfig:=vp_FondoConfig*0.696
			: ($items<=21)
				GET WINDOW RECT:C443($left;$top;$right;$bottom)
				SET WINDOW RECT:C444($left;$top;$right;$top+558)
				vp_FondoConfig:=vp_FondoConfig*0.848
			: ($items<=22)
				GET WINDOW RECT:C443($left;$top;$right;$bottom)
				SET WINDOW RECT:C444($left;$top;$right;$bottom)
		End case 
		
		For ($i;1;Size of array:C274(alXS_ExecObjects_RecNum))
			$pictPointer:=Get pointer:C304("vpXS_Config"+String:C10($i))
			$textPointer:=Get pointer:C304("vtXS_Config"+String:C10($i))
			$button:="bCFG_Panel"+String:C10($i)
			$textPointer->:=atXS_ExecObjects_Alias{$i}
			OBJECT SET FORMAT:C236(*;$button;"1;4;?"+String:C10(alXS_ExecObjects_IconRef{$i})+";240;0")
		End for 
		
		For ($i;$items+1;28)
			$pictPointer:=Get pointer:C304("bCFG_Panel"+String:C10($i))
			$textPointer:=Get pointer:C304("vtXS_Config"+String:C10($i))
			OBJECT SET VISIBLE:C603($pictPointer->;False:C215)
			OBJECT SET VISIBLE:C603($textPointer->;False:C215)
		End for 
		
		
		CFG_SetMenuBar 
		
		
	: (Form event:C388=On Activate:K2:9)
		CFG_SetMenuBar 
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
		PrefIcon:=PrefIcon*0
		vp_FondoConfig:=vp_FondoConfig*0
End case 