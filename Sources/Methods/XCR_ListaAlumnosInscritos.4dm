//%attributes = {}
  // XCR_ListaAlumnosInscritos()
  // Por: Alberto Bachler K.: 03-06-14, 09:05:17
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_periodo)
C_POINTER:C301($y_alumnosCurso_at;$y_alumnosFoto_ap;$y_alumnosNombre_at;$y_idAlumnos_al)


$y_idAlumnos_al:=OBJECT Get pointer:C1124(Object named:K67:5;"alumnosId")
$y_alumnosNombre_at:=OBJECT Get pointer:C1124(Object named:K67:5;"alumnosNombre")
$y_alumnosCurso_at:=OBJECT Get pointer:C1124(Object named:K67:5;"alumnosCurso")
$y_alumnosFoto_ap:=OBJECT Get pointer:C1124(Object named:K67:5;"alumnosFoto")
$l_periodo:=(OBJECT Get pointer:C1124(Object named:K67:5;"periodo"))->

QUERY:C277([Alumnos_Actividades:28];[Alumnos_Actividades:28]Actividad_numero:2=[Actividades:29]ID:1;*)
QUERY:C277([Alumnos_Actividades:28]; & [Alumnos_Actividades:28]Año:3=<>gYear)
Case of 
	: ($l_periodo=-1)
		  // se muestran todos los alumnos inscritos, en cualquier periodo
		
	: ($l_periodo=0)
		  // se muestran los alumnos inscritos en todos los periodos
		QUERY SELECTION BY FORMULA:C207([Alumnos_Actividades:28];([Alumnos_Actividades:28]Periodos_Inscritos:44 ?? 0))
		
	: ($l_periodo>0)
		QUERY SELECTION BY FORMULA:C207([Alumnos_Actividades:28];(([Alumnos_Actividades:28]Periodos_Inscritos:44 ?? 0) | ([Alumnos_Actividades:28]Periodos_Inscritos:44 ?? $l_periodo)))
		
End case 

SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
ORDER BY:C49([Alumnos_Actividades:28];[Alumnos:2]nivel_numero:29;>;[Alumnos:2]curso:20;>;[Alumnos:2]apellidos_y_nombres:40;>)
SELECTION TO ARRAY:C260([Alumnos_Actividades:28]Alumno_Numero:1;$y_idAlumnos_al->;[Alumnos:2]apellidos_y_nombres:40;$y_alumnosNombre_at->;[Alumnos:2]curso:20;$y_alumnosCurso_at->;[Alumnos:2]Fotografía:78;$y_alumnosFoto_ap->)
SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)

OBJECT SET ENABLED:C1123(*;"botonInscribir";[Actividades:29]Nombre:2#"")
OBJECT SET ENABLED:C1123(*;"botonRetirar";False:C215)

OBJECT SET TITLE:C194(*;"totalAlumnos";String:C10([Actividades:29]NumeroAlumnosInscritos:14)+__ (" alumnos inscritos"))
Case of 
	: ($l_periodo=1)
		OBJECT SET TITLE:C194(*;"alumnosEnPeriodo";String:C10([Actividades:29]Inscritos_P1:15)+__ (" en ")+atSTR_Periodos_Nombre{$l_periodo})
	: ($l_periodo=2)
		OBJECT SET TITLE:C194(*;"alumnosEnPeriodo";String:C10([Actividades:29]Inscritos_P2:16)+__ (" en ")+atSTR_Periodos_Nombre{$l_periodo})
	: ($l_periodo=3)
		OBJECT SET TITLE:C194(*;"alumnosEnPeriodo";String:C10([Actividades:29]Inscritos_P3:17)+__ (" en ")+atSTR_Periodos_Nombre{$l_periodo})
	: ($l_periodo=4)
		OBJECT SET TITLE:C194(*;"alumnosEnPeriodo";String:C10([Actividades:29]Inscritos_P4:18)+__ (" en ")+atSTR_Periodos_Nombre{$l_periodo})
	: ($l_periodo=5)
		OBJECT SET TITLE:C194(*;"alumnosEnPeriodo";String:C10([Actividades:29]Inscritos_P5:19)+__ (" en ")+atSTR_Periodos_Nombre{$l_periodo})
End case 


OBJECT SET VISIBLE:C603(*;"alumnosEnPeriodo@";$l_periodo>0)