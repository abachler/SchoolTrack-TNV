//%attributes = {}
  //UD_v20110630_STR_DelSaPOST


C_LONGINT:C283($vl_proc)

$vl_proc:=IT_UThermometer (1;0;"Verificando Datos...")
READ WRITE:C146([Alumnos_SintesisAnual:210])
QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]NumeroNivel:6<=-1000)
KRL_DeleteSelection (->[Alumnos_SintesisAnual:210])

KRL_ReloadAsReadOnly (->[Alumnos_SintesisAnual:210])
IT_UThermometer (-2;$vl_proc)

