  // CIM_Principal.lb_UsersConex()
  // Por: Alberto Bachler K.: 23-09-15, 15:45:47
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_columna;$l_orden;$l_posicion;$l_recNum)
C_POINTER:C301($y_current;$y_UsuariosNombre;$y_UsuariosNombre_H;$y_usuariosRecNum;$y_UsuariosSesiones;$y_UsuariosSesiones_H;$y_usuariosTiempo;$y_usuariosTiempo_H)

Case of 
	: (Form event:C388=On Header Click:K2:40)
		$y_current:=OBJECT Get pointer:C1124(Object current:K67:2)
		$l_posicion:=LB_GetSelectedRows (->lb_UsersConex)
		
		$y_UsuariosNombre_H:=OBJECT Get pointer:C1124(Object named:K67:5;"usuariosNombre_H")
		$y_UsuariosSesiones_H:=OBJECT Get pointer:C1124(Object named:K67:5;"usuariosSesiones_H")
		$y_usuariosTiempo_H:=OBJECT Get pointer:C1124(Object named:K67:5;"usuariosTiempo_H")
		$y_UsuariosNombre:=OBJECT Get pointer:C1124(Object named:K67:5;"usuariosNombre")
		$y_UsuariosSesiones:=OBJECT Get pointer:C1124(Object named:K67:5;"usuariosSesiones")
		$y_usuariosTiempo:=OBJECT Get pointer:C1124(Object named:K67:5;"usuariosTiempo")
		$y_usuariosRecNum:=OBJECT Get pointer:C1124(Object named:K67:5;"usuariosRecNum")
		If ($l_posicion>0)
			$l_recNum:=$y_usuariosRecNum->{$l_posicion}
		End if 
		Case of 
			: ($y_current=$y_UsuariosNombre_H)
				$l_columna:=1
				$l_orden:=Choose:C955($y_current->=1;2;1)
				$y_current->:=$l_orden
				
			: ($y_current=$y_UsuariosSesiones_H)
				$l_columna:=2
				$l_orden:=Choose:C955($y_current->=1;2;1)
				$y_current->:=$l_orden
				
			: ($y_current=$y_UsuariosTiempo_H)
				$l_columna:=5
				$l_orden:=Choose:C955($y_current->=1;2;1)
				$y_current->:=$l_orden
		End case 
		
		If ($l_orden=1)
			LISTBOX SORT COLUMNS:C916(*;"lb_UsersConex";$l_columna;>)
		Else 
			LISTBOX SORT COLUMNS:C916(*;"lb_UsersConex";$l_columna;<)
		End if 
		
		If ($l_posicion>0)
			$l_posicion:=Find in array:C230($y_usuariosRecNum->;$l_recNum)
			OBJECT SET SCROLL POSITION:C906(*;"lb_UsersConex";$l_posicion)
		End if 
		
	: (Form event:C388=On Selection Change:K2:29)
		XS_CIM_ObjetMethods ("ShowUserTasks")
End case 

