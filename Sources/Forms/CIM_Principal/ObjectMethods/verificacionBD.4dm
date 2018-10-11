  // CIM_Principal.Botón4()
  // Por: Alberto Bachler K.: 03-11-14, 17:02:04
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

C_LONGINT:C283($l_abajo;$l_arriba;$l_bdValida;$l_derecha;$l_izquierda)

OBJECT SET VISIBLE:C603(*;"resultadoVerificacion";True:C214)
OBJECT SET TITLE:C194(*;"resultadoVerificacion";"")
If (Application type:C494=4D Remote mode:K5:5)
	vl_ClientProgressProcessID:=IT_Progress (1;0;0;"Verificando base de datos...")
End if 
$l_bdValida:=CIM_VerifyDataFile (<>RegisteredName;vl_ClientProgressProcessID;->at_DataFileError)
If (Application type:C494=4D Remote mode:K5:5)
	vl_ClientProgressProcessID:=IT_Progress (-1;vl_ClientProgressProcessID)
End if 

If ($l_bdValida=0)
	OBJECT GET COORDINATES:C663(*;"lb_infoBD";$l_izquierda;$l_arriba;$l_derecha;$l_abajo)
	IT_SetNamedObjectRect ("lb_errores";$l_izquierda;$l_arriba;$l_derecha;$l_abajo)
	OBJECT SET VISIBLE:C603(*;"lb_infoBD";False:C215)
	OBJECT SET VISIBLE:C603(*;"lb_errores";True:C214)
	OBJECT SET TITLE:C194(*;"resultadoVerificacion";"La  base de datos está dañada")
	OBJECT SET COLOR:C271(*;"resultadoVerificacion";-Red:K11:4)
	OBJECT SET TITLE:C194(*;"infoBD";"Problemas detectados")
	OBJECT SET COLOR:C271(*;"infoBD";-Red:K11:4)
	
Else 
	ModernUI_Notificacion (__ ("Verificación de la base de datos");__ ("La verifificación de la base de datos concluyó exitosamente."))
	
	OBJECT SET VISIBLE:C603(*;"lb_infoBD";True:C214)
	OBJECT SET VISIBLE:C603(*;"lb_errores";False:C215)
	OBJECT SET TITLE:C194(*;"resultadoVerificacion";"La base de datos es válida")
	OBJECT SET COLOR:C271(*;"resultadoVerificacion";-Dark green:K11:10)
	OBJECT SET TITLE:C194(*;"infoBD";"Información de la base de datos")
	OBJECT SET COLOR:C271(*;"infoBD";-Black:K11:16)
End if 


USR_RegisterUserEvent (UE_SIM_VerifyDB;0)