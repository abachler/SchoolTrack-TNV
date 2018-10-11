//%attributes = {}
  //UD_v20120910_ActuaDatosEditOpt
NIV_LoadArrays 
$proc:=IT_UThermometer (1;0;__ ("Añadiendo opción de edición en Actualización de Datos..."))
For ($i;1;Size of array:C274(<>al_NumeroNivelesSchoolNet))
	SN3_LoadDataReceptionSettings (<>al_NumeroNivelesSchoolNet{$i})
	COPY ARRAY:C226(SN3_PublicaAlumno;SN3_EditaAlumno)
	COPY ARRAY:C226(SN3_PublicaRF;SN3_EditaRF)
	SN3_SaveDataReceptionSettings (<>al_NumeroNivelesSchoolNet{$i})
End for 
IT_UThermometer (-2;$proc)