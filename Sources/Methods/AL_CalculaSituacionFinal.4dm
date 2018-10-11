//%attributes = {}
  //AL_CalculaSituacionFinal

C_BOOLEAN:C305($succes;$0)

$idAlumno:=$1

KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual:210]ID_Alumno:4;->$idAlumno;True:C214)
If (Not:C34([Alumnos_SintesisAnual:210]SitFinal_AsignadaManualmente:61))
	Case of 
		: (<>vtXS_CountryCode="cl")
			$succes:=AL_CalculaSituacionfinal_cl ($idAlumno)
			
			
		: (<>vtXS_CountryCode="ar")
			$succes:=AL_CalculaSituacionFinal_ar ($idAlumno)
			
			
		: (<>vtXS_CountryCode="co")
			$succes:=AL_CalculaSituacionFinal_co ($idAlumno)
			
			
		: (<>vtXS_CountryCode="mx")
			$succes:=AL_CalculaSituacionFinal_mx ($idAlumno)
			
			
		Else 
			$succes:=AL_CalculaSituacionfinal_xx ($idAlumno)
	End case 
	
Else 
	$succes:=True:C214
End if 

$0:=$succes



