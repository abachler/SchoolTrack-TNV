//%attributes = {}
  //ADTcdd_AsignarGrupo

C_DATE:C307($1;$date)
_O_C_STRING:C293(80;$0)

$date:=$1

If ($date#!00-00-00!)
	If (Size of array:C274(adPST_FromDate)=0)
		$ignore:=CD_Dlog (0;__ ("Debe definir los grupos etarios para la asignación del postulante a un grupo."))
	Else 
		  //MONO 23/08/13:Los array debe siempre estar ordenado de esta forma para que funciones la asignación
		SORT ARRAY:C229(adPST_FromDate;adPST_ToDate;atPST_GroupName;aiPST_GroupID;aiPST_Candidates;aiPST_ExamTime;aiPST_maxpostulantes;aiPST_Cupos;>)
		Case of 
			: ($date<adPST_FromDate{1})
				CD_Dlog (0;Replace string:C233(__ ("La fecha de nacimiento ingresada es inferior al límite mínimo (^0).\rEl aspirante no puede ser aceptado");__ ("^0");String:C10(adPST_FromDate{1})))
			: ($date>adPST_ToDate{Size of array:C274(adPST_ToDate)})
				CD_Dlog (0;Replace string:C233(__ ("La fecha de nacimiento es superior al límite máximo (^0).\rEl aspirante no puede ser aceptado");__ ("^0");String:C10(adPST_ToDate{Size of array:C274(adPST_ToDate)})))
			Else 
				For ($i;1;Size of array:C274(adPST_FromDate))
					If (($date>=adPST_FromDate{$i}) & ($date<=adPST_ToDate{$i}))
						$0:=atPst_GroupName{$i}
						$i:=Size of array:C274(adPST_FromDate)
					End if 
				End for 
		End case 
	End if 
End if 