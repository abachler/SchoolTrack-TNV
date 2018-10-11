$copyTo:=""
$resultado:=SOPORTE_EnviaMailIncidente ($copyTo;vt_Msg;"D";vx_Blob)
If ($resultado=0)
	CD_Dlog (0;$errorString+__ (".\r\rPor favor guarde el reporte y envíelo por otro medio al departamento técnico de Colegium"))
End if 