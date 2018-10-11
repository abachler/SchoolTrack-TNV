//%attributes = {}
  //CFG_ExecutePanel


C_LONGINT:C283($methodID)
$buttonPointer:=$1
RESOLVE POINTER:C394($buttonPointer;$buttonName;$Table;$field)
$index:=Num:C11($buttonName)
$method:=atXS_ExecObjects_Method{$index}
$textPointer:=Get pointer:C304("vtXS_Config"+String:C10($index))
If (Not:C34(Contextual click:C713))
	If (API Does Method Exist ($method)=1)
		If ((USR_IsGroupMember_by_GrpID (-15001)) | (USR_GetMethodAcces ($method;0)))
			OBJECT SET VISIBLE:C603(*;"bCFG_Panel@";False:C215)
			SET WINDOW TITLE:C213($textPointer->)
			GET WINDOW RECT:C443($left;$top;$right;$bottom)
			$error:=KRL_ExecuteMethod ($method)
			If ($error=-3)
				EXECUTE FORMULA:C63($method)
			End if 
			
			If (vbCFG_CloseWindow)
				CANCEL:C270
				vp_FondoConfig:=vp_FondoConfig*0
			Else 
				$title:="Configuración de "+vsBWR_CurrentModule
				SET WINDOW TITLE:C213($title)
				OBJECT SET VISIBLE:C603(*;"bCFG_Panel@";True:C214)
				  //$items:=Count list items(hl_configuration)
				$items:=Size of array:C274(alXS_ExecObjects_RecNum)
				For ($i;$items+1;28)
					$buttonPointer:=Get pointer:C304("bCFG_Panel"+String:C10($i))
					$textPointer:=Get pointer:C304("vtXS_Config"+String:C10($i))
					OBJECT SET VISIBLE:C603($buttonPointer->;False:C215)
					OBJECT SET VISIBLE:C603($textPointer->;False:C215)
				End for 
				SET WINDOW RECT:C444($left;$top;$right;$bottom)
				GET PICTURE FROM LIBRARY:C565("Config_Back_"+vsBWR_CurrentModule;vp_FondoConfig)
				Case of 
					: ($items<=7)
						vp_FondoConfig:=vp_FondoConfig*0.554
					: ($items<=14)
						vp_FondoConfig:=vp_FondoConfig*0.696
					: ($items<=21)
						vp_FondoConfig:=vp_FondoConfig*0.848
					: ($items<=22)
						
				End case 
			End if 
		Else 
			CD_Dlog (0;__ ("Lo siento. Usted no dispone de privilegios para acceder a este panel de configuración."))
		End if 
	Else 
		$ignore:=CD_Dlog (0;__ ("No se ha definido ninguna acción ejecutable para este panel de configuración."))
	End if 
Else 
	$r:=Pop up menu:C542("Establecer permisos...")
	If ($r=1)
		USR_SetSpecialPermissions ($buttonName;$method;$textPointer->)
	End if 
End if 

