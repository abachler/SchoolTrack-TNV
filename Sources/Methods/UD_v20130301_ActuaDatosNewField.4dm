//%attributes = {}
  //UD_v20130301_ActuaDatosNewField 
  //nuevos campos de contacto de emergencia para los alumnos en actualización de datos

C_LONGINT:C283($vl_proc)
NIV_LoadArrays 
$vl_proc:=IT_UThermometer (1;0;__ ("Actualización de Datos..."))
For ($i;1;Size of array:C274(<>al_NumeroNivelesSchoolNet))
	SN3_LoadDataReceptionSettings (<>al_NumeroNivelesSchoolNet{$i})
	ARRAY BOOLEAN:C223(SN3_PublicaAlumno;34)
	ARRAY BOOLEAN:C223(SN3_EditaAlumno;34)
	SN3_SaveDataReceptionSettings (<>al_NumeroNivelesSchoolNet{$i})
End for 
IT_UThermometer (-2;$vl_proc)