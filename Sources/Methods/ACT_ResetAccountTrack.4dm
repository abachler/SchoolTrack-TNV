//%attributes = {}
  // ACT_ResetAccountTrack()
  // 
  //
  // modificado por: Alberto Bachler Klein: 18-11-16, 06:14:17
  // -----------------------------------------------------------


C_BOOLEAN:C305($b_preservarConfig)
C_LONGINT:C283($l_opcion)

If ((Application type:C494=4D Remote mode:K5:5) & (Count users:C342=2)) | ((Application type:C494=4D Volume desktop:K5:2) | (Application type:C494=4D Local mode:K5:1))
	If (USR_IsGroupMember_by_GrpID (-15001))
		$l_opcion:=ModernUI_Notificacion (__ ("Inicialización de AccountTrack");__ ("Puede eliminar sólo los datos de operación o los datos de operación y configuración")+"\r\r"+__ ("¿Que desea hacer?");__ ("Abortar");__ ("Solo operación");__ ("Operación y Configuracion"))
		If ($l_opcion>1)
			  //$b_preservarConfig:=Choose($l_opcion;True;False)
			$b_preservarConfig:=Choose:C955(($l_opcion=2);True:C214;False:C215)  //20180507 RCH No se capturaba correctamente la opción para mantener la configuración.
			Notificacion_Mostrar (__ ("Inicializacion de AccountTrack");__ ("Se inició la inicialización de AccountTrack\rRecibirá una notificación cuando concluya."))
			OK:=ACT_ZeroData ($b_preservarConfig;<>RegisteredName)
		End if 
	Else 
		CD_Dlog (0;__ ("Usted no está autorizado para utilizar este comando."))
	End if 
Else 
	CD_Dlog (0;__ ("Este comando solo puede ser utilizado cuando no hay otros usuarios conectados al servidor"))
End if 



