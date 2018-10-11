//%attributes = {}
  //CU_Delete

C_LONGINT:C283($r;$0)
If (USR_checkRights ("D";->[Cursos:3]))
	If (Size of array:C274(<>aStdID)>0)
		CD_Dlog (0;__ ("Este curso tiene alumnos.\rNo puede ser eliminado."))
	Else 
		$r:=CD_Dlog (2;__ ("¿ Desea Ud. realmente eliminar el curso ")+[Cursos:3]Curso:1+__ (" ?");__ ("");__ ("No");__ ("Eliminar"))
		If ($r=2)
			$0:=CU_DeleteRec (False:C215)
		End if 
	End if 
Else 
	USR_ALERT_UserHasNoRights (3)
End if 