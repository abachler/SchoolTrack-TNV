//%attributes = {}
  //ACTcfg_LoadTransBancData

ACTcfg_OpcionesArchivoBancario ("DeclaraArreglosFrom")
ARRAY TEXT:C222($atACT_ABArchivoBancoCod;0)

READ ONLY:C145([xxACT_ArchivosBancarios:118])
QUERY:C277([xxACT_ArchivosBancarios:118];[xxACT_ArchivosBancarios:118]Rol_BD:8=<>gRolBD;*)
QUERY:C277([xxACT_ArchivosBancarios:118]; & ;[xxACT_ArchivosBancarios:118]Codigo_Pais:7=<>vtXS_CountryCode)
SELECTION TO ARRAY:C260([xxACT_ArchivosBancarios:118]ID:1;alACT_ABArchivoID;[xxACT_ArchivosBancarios:118]Nombre:3;atACT_ABArchivoNombre;[xxACT_ArchivosBancarios:118]ImpExp:5;abACT_ABArchivoImpExp;[xxACT_ArchivosBancarios:118]Tipo:6;atACT_ABArchivoTipo)
SELECTION TO ARRAY:C260([xxACT_ArchivosBancarios:118]CodBancoAsociado:12;$atACT_ABArchivoBancoCod)

ARRAY TEXT:C222(atACT_ABArchivoBanco;Size of array:C274($atACT_ABArchivoBancoCod))
For ($i;1;Size of array:C274($atACT_ABArchivoBancoCod))
	$vt_codBanco:=$atACT_ABArchivoBancoCod{$i}
	atACT_ABArchivoBanco{$i}:=ACTcfg_OpcionesArchivoBancario ("RetornaNombreBanco";->$vt_codBanco)
End for 