//%attributes = {}
  //WIZ_STR_ImportacionNotas


If (USR_IsGroupMember_by_GrpID (-15001))
	ARRAY TEXT:C222($aProblemas;0)
	ARRAY TEXT:C222(aIdentificadores;0)
	ARRAY POINTER:C280(aIDFieldPointers;4)
	COPY ARRAY:C226(<>at_IDNacional_Names;aIdentificadores)
	ARRAY TEXT:C222(aIdentificadores;4)
	aIdentificadores{4}:="Código interno"
	aIDFieldPointers{1}:=->[Alumnos:2]RUT:5
	aIDFieldPointers{2}:=->[Alumnos:2]IDNacional_2:71
	aIDFieldPointers{3}:=->[Alumnos:2]IDNacional_3:70
	aIDFieldPointers{4}:=->[Alumnos:2]Codigo_interno:6
	Case of 
		: (<>vtXS_CountryCode="cl")
			aIdentificadores:=1
		: (<>vtXS_CountryCode="co")
			aIdentificadores:=4
		: (<>vtXS_CountryCode="ar")
			aIdentificadores:=4
	End case 
	
	WDW_OpenFormWindow (->[xxSTR_Constants:1];"STR_ImportNotasActuales";-1;4;__ ("Asistentes"))
	DIALOG:C40([xxSTR_Constants:1];"STR_ImportNotasActuales")
	CLOSE WINDOW:C154
	
	$keyFieldPointer:=aIDFieldPointers{aIdentificadores}
	If (ok=1)
		If (r1=1)
			$filePlatForm:="Mac"
		Else 
			$filePlatForm:="Win"
		End if 
		Case of 
			: (t1=1)
				SOPORTE_ImportaNotas ($keyFieldPointer;$filePlatForm;vt_g1)
			: (t2=1)
				SOPORTE_ImportaNotasConPromedio ($keyFieldPointer;$filePlatForm;vt_g1)
			: (t3=1)
				SOPORTE_ImportaObsAcademicas ($keyFieldPointer;$filePlatForm;vt_g1)
		End case 
	End if 
Else 
	CD_Dlog (0;__ ("Sólo los miembros del grupo Administración están autorizados a ejecutar esta acción."))
End if 
