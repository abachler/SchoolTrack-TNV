//%attributes = {}
  //CFG_XS_OpenPanel

  // ===============================================================================
  // Usuario (OS): abachler
  // Fecha y Hora: 15/08/03, 15:47:23
  // -------------------------------------------------------------------------------
  // Metodo: CFG_XS_OpenPanel
  // Descripcion
  // 
  //
  // Parametros
  //
  // ===============================================================================



  // DECLARACIONES
  // -------------------------------------------------------------------------------
C_TEXT:C284($1;$methodName)

  // INICIALIZACIONES
  // -------------------------------------------------------------------------------
$methodName:=$1


  // CUERPO DEL METODO
  // -------------------------------------------------------------------------------
If ((USR_IsGroupMember_by_GrpID (-15001)) | (USR_GetMethodAcces ($methodName;0)))
	GET WINDOW RECT:C443($left;$top;$right;$bottom)
	OBJECT SET VISIBLE:C603(*;"bCFG_Panel@";False:C215)
	KRL_ExecuteMethod ($methodName)
	If (vbCFG_CloseWindow)
		CANCEL:C270
		vp_FondoConfig:=vp_FondoConfig*0
	Else 
		SET WINDOW TITLE:C213(__ ("Configuración de la Aplicación"))
		OBJECT SET VISIBLE:C603(*;"bCFG_Panel@";True:C214)
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
				vp_FondoConfig:=vp_FondoConfig*0.554
			: ($items<=14)
				vp_FondoConfig:=vp_FondoConfig*0.696
			: ($items<=21)
				vp_FondoConfig:=vp_FondoConfig*0.848
			: ($items<=22)
		End case 
		SET WINDOW RECT:C444($left;$top;$right;$bottom)
		GET PICTURE FROM LIBRARY:C565("Config_Back_"+vsBWR_CurrentModule;vp_FondoConfig)
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
	End if 
Else 
	CD_Dlog (0;__ ("Usted no dispone de los derechos necesarios para utilizar esta función."))
End if 


  // LIBERACION DE MEMORIA
  // -------------------------------------------------------------------------------


  // FIN DEL METODO
