//%attributes = {}
  //UD_v20140423_ActuaDatosNewField
  //nuevo campo de dietas [Alumnos]Sector_domicilio para los alumnos
NIV_LoadArrays 
$proc:=IT_UThermometer (1;0;__ ("Actualización de Datos..."))
For ($i;1;Size of array:C274(<>al_NumeroNivelesSchoolNet))
	SN3_LoadDataReceptionSettings (<>al_NumeroNivelesSchoolNet{$i})
	ARRAY BOOLEAN:C223(SN3_PublicaAlumno;36)
	ARRAY BOOLEAN:C223(SN3_EditaAlumno;36)
	SN3_SaveDataReceptionSettings (<>al_NumeroNivelesSchoolNet{$i})
End for 
IT_UThermometer (-2;$proc)