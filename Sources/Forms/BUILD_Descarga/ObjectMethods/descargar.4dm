  // Build_Descarga.descargaAuto()
  // 
  //
  // creado por: Alberto Bachler Klein: 20-08-16, 18:00:55
  // -----------------------------------------------------------

If ((OBJECT Get pointer:C1124(Object named:K67:5;"descargar"))->=1)
	OBJECT SET ENABLED:C1123(*;"instalar@";True:C214)
	(OBJECT Get pointer:C1124(Object named:K67:5;"InstalarAuto"))->:=1
	(OBJECT Get pointer:C1124(Object named:K67:5;"InstalarProgramado"))->:=0
	OBJECT SET ENABLED:C1123(*;"Dia@";False:C215)
	OBJECT SET ENABLED:C1123(*;"hora";False:C215)
Else 
	(OBJECT Get pointer:C1124(Object named:K67:5;"InstalarAuto"))->:=0
	(OBJECT Get pointer:C1124(Object named:K67:5;"InstalarProgramado"))->:=0
	OBJECT SET ENABLED:C1123(*;"Dia@";False:C215)
	OBJECT SET ENABLED:C1123(*;"hora";False:C215)
	OBJECT SET ENABLED:C1123(*;"instalar@";False:C215)
End if 