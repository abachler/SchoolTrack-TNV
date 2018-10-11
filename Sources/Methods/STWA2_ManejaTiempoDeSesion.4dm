//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda 
  // Fecha y hora: 11-09-18, 15:54:48
  // ----------------------------------------------------
  // Método: STWA2_ManejaTiempoDeSesion
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------


C_TEXT:C284($1)
C_LONGINT:C283($2;$0)
C_OBJECT:C1216($o_raiz;$o_detalle)
C_LONGINT:C283($l_posicionArreglo;$l_minConfPrincipal;$userID;$l_minutos)
C_POINTER:C301($y_TimeOutSTWA2)

$t_accion:=$1
If (Count parameters:C259=2)
	$userID:=$2
End if 

$l_minConfPrincipal:=Num:C11(PREF_fGet (0;"TimeoutSTWA"))


Case of 
	: ($t_accion="setArrayListbox")
		
		ARRAY TEXT:C222(atSTWA2_grupos;0)
		ARRAY LONGINT:C221(alSTWA2_minutos;0)
		ARRAY LONGINT:C221(alSTWA2_grupoID;0)
		ARRAY TEXT:C222(atSTWA2_Propietario;0)
		ARRAY BOOLEAN:C223(abSTWA2_GrupoActivo;0)
		C_BOOLEAN:C305($b_activarCheck)
		
		$o_raiz:=PREF_fGetObject (0;"TimeoutSTWA")
		
		ALL RECORDS:C47([xShell_UserGroups:17])
		ORDER BY:C49([xShell_UserGroups:17];[xShell_UserGroups:17]GroupName:2;>)
		SELECTION TO ARRAY:C260([xShell_UserGroups:17]GroupName:2;atSTWA2_grupos;[xShell_UserGroups:17]IDGroup:1;alSTWA2_grupoID;[xShell_UserGroups:17]PropietaryName:9;atSTWA2_Propietario)
		For ($l_indice;1;Size of array:C274(atSTWA2_grupos))
			$o_detalle:=OB Get:C1224($o_raiz;String:C10(alSTWA2_grupoID{$l_indice});Is object:K8:27)
			If (OB Is defined:C1231($o_detalle))
				APPEND TO ARRAY:C911(alSTWA2_minutos;(OB Get:C1224($o_detalle;"timeoutSTWA";Is longint:K8:6)/60))
				APPEND TO ARRAY:C911(abSTWA2_GrupoActivo;True:C214)
				$b_activarCheck:=True:C214
			Else 
				APPEND TO ARRAY:C911(alSTWA2_minutos;vlSTWA2_Timeout)
				APPEND TO ARRAY:C911(abSTWA2_GrupoActivo;False:C215)
			End if 
		End for 
		
		$y_activarTodos:=OBJECT Get pointer:C1124(Object named:K67:5;"activarTodos")
		$y_activarTodos->:=Choose:C955($b_activarCheck;1;0)
		If ($b_activarCheck)
			OBJECT SET TITLE:C194(*;"activarTodos";__ ("Desactivar todos los grupos"))
		Else 
			OBJECT SET TITLE:C194(*;"activarTodos";__ ("Activar todos los grupos"))
		End if 
		
	: ($t_accion="SetTimeOut")
		
		
		$y_TimeOutSTWA2:=OBJECT Get pointer:C1124(Object named:K67:5;"lb_TimeOutSTWA2")
		$l_posicionArreglo:=$y_TimeOutSTWA2->
		
		$o_raiz:=PREF_fGetObject (0;"TimeoutSTWA")
		$o_detalle:=OB Get:C1224($o_raiz;String:C10(alSTWA2_grupoID{$l_posicionArreglo});Is object:K8:27)
		
		If (OB Is defined:C1231($o_detalle))
			OB SET:C1220($o_detalle;"timeoutSTWA";(alSTWA2_minutos{$l_posicionArreglo}*60))
			OB SET:C1220($o_raiz;String:C10(alSTWA2_grupoID{$l_posicionArreglo});$o_detalle)
		Else 
			abSTWA2_GrupoActivo{$l_posicionArreglo}:=True:C214
			OB SET:C1220($o_detalle;"nombreGrupo";atSTWA2_grupos{$l_posicionArreglo})
			OB SET:C1220($o_detalle;"propietario";atSTWA2_Propietario{$l_posicionArreglo})
			OB SET:C1220($o_detalle;"timeoutSTWA";(alSTWA2_minutos{$l_posicionArreglo}*60))
			OB SET:C1220($o_raiz;String:C10(alSTWA2_grupoID{$l_posicionArreglo});$o_detalle)
		End if 
		PREF_SetObject (0;"TimeoutSTWA";$o_raiz)
		
	: ($t_accion="cambioTimeOutGeneral")
		
		For ($l_posicionArreglo;1;Size of array:C274(abSTWA2_GrupoActivo))
			If (abSTWA2_GrupoActivo{$l_posicionArreglo}=False:C215)
				alSTWA2_minutos{$l_posicionArreglo}:=vlSTWA2_Timeout
			End if 
		End for 
		
	: ($t_accion="update")
		
		$y_TimeOutSTWA2:=OBJECT Get pointer:C1124(Object named:K67:5;"lb_TimeOutSTWA2")
		$l_posicionArreglo:=$y_TimeOutSTWA2->
		
		$o_raiz:=PREF_fGetObject (0;"TimeoutSTWA")
		
		If (abSTWA2_GrupoActivo{$l_posicionArreglo})
			OB SET:C1220($o_detalle;"nombreGrupo";atSTWA2_grupos{$l_posicionArreglo})
			OB SET:C1220($o_detalle;"propietario";atSTWA2_Propietario{$l_posicionArreglo})
			OB SET:C1220($o_detalle;"timeoutSTWA";(alSTWA2_minutos{$l_posicionArreglo}*60))
			OB SET:C1220($o_raiz;String:C10(alSTWA2_grupoID{$l_posicionArreglo});$o_detalle)
		Else 
			OB REMOVE:C1226($o_raiz;String:C10(alSTWA2_grupoID{$l_posicionArreglo}))
			alSTWA2_minutos{$l_posicionArreglo}:=vlSTWA2_Timeout
		End if 
		
		PREF_SetObject (0;"TimeoutSTWA";$o_raiz)
		
		
	: ($t_accion="activarTodos")
		$y_activarTodos:=OBJECT Get pointer:C1124(Object named:K67:5;"activarTodos")
		$o_raiz:=PREF_fGetObject (0;"timeOutSTWA")
		
		If ($y_activarTodos->=1)
			OBJECT SET TITLE:C194(*;"activarTodos";__ ("Desactivar todos los grupos"))
			For ($l_indice;1;Size of array:C274(alSTWA2_grupoID))
				$o_detalle:=OB Get:C1224($o_raiz;String:C10(alSTWA2_grupoID{$l_indice});Is object:K8:27)
				abSTWA2_GrupoActivo{$l_indice}:=True:C214
				OB SET:C1220($o_detalle;"nombreGrupo";atSTWA2_grupos{$l_indice})
				OB SET:C1220($o_detalle;"propietario";atSTWA2_Propietario{$l_indice})
				OB SET:C1220($o_detalle;"timeoutSTWA";$l_minConfPrincipal)
				OB SET:C1220($o_raiz;String:C10(alSTWA2_grupoID{$l_indice});$o_detalle)
			End for 
		Else 
			OBJECT SET TITLE:C194(*;"activarTodos";__ ("Activar todos los grupos"))
			For ($l_indice;1;Size of array:C274(alSTWA2_grupoID))
				abSTWA2_GrupoActivo{$l_indice}:=False:C215
				alSTWA2_minutos{$l_indice}:=$l_minConfPrincipal/60
				OB REMOVE:C1226($o_raiz;String:C10(alSTWA2_grupoID{$l_indice}))
			End for 
		End if 
		PREF_SetObject (0;"TimeoutSTWA";$o_raiz)
		
	: ($t_accion="cargaVariableTimeout")
		C_TEXT:C284(vsUSR_UserName;vsUSR_StartUpMethod;vsUSR_Password)
		C_REAL:C285(vlUSR_NbLogin)
		C_DATE:C307(vdUSR_LastLogin)
		ARRAY LONGINT:C221(alUSR_Membership;0)
		ARRAY LONGINT:C221($al_minutosUser;0)
		$o_raiz:=PREF_fGetObject (0;"timeOutSTWA")
		If ($userID>0)
			USR_GetUserProperties ($userID;->vsUSR_UserName;->vsUSR_StartUpMethod;->vsUSR_Password;->vlUSR_NbLogin;->vdUSR_LastLogin;->alUSR_Membership)
			
			For ($l_indice;1;Size of array:C274(alUSR_Membership))
				$o_detalle:=OB Get:C1224($o_raiz;String:C10(alUSR_Membership{$l_indice});Is object:K8:27)
				If (OB Is defined:C1231($o_detalle))
					$l_minutos:=OB Get:C1224($o_detalle;"timeoutSTWA";Is longint:K8:6)
					APPEND TO ARRAY:C911($al_minutosUser;$l_minutos)
				End if 
			End for 
			If (Size of array:C274($al_minutosUser)>0)
				SORT ARRAY:C229($al_minutosUser;<)
				$0:=$al_minutosUser{1}
			Else 
				$0:=(Num:C11(PREF_fGet (0;"TimeoutSTWA")))
			End if 
		Else 
			$0:=(Num:C11(PREF_fGet (0;"TimeoutSTWA")))
		End if 
		
	: ($t_accion="actualizarDesdeGeneral")
		For ($l_indice;1;Size of array:C274(alSTWA2_grupoID))
			$o_detalle:=OB Get:C1224($o_raiz;String:C10(alSTWA2_grupoID{$l_indice});Is object:K8:27)
			If (abSTWA2_GrupoActivo{$l_indice}=False:C215)
				alSTWA2_minutos{$l_indice}:=vlSTWA2_Timeout
			End if 
		End for 
		
	: ($t_accion="delete")
		$GropID:=$2
		$o_raiz:=PREF_fGetObject (0;"TimeoutSTWA")
		OB REMOVE:C1226($o_raiz;String:C10($GropID))
		PREF_SetObject (0;"TimeoutSTWA";$o_raiz)
End case 



