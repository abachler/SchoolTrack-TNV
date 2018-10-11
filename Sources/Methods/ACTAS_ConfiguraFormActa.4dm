//%attributes = {}
  // ACTAS_ConfiguraArea()
  // Por: Alberto Bachler K.: 26-02-14, 16:45:57
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_editable)
C_LONGINT:C283($el)

ARRAY TEXT:C222(aFonts;0)
FONT LIST:C460(aFonts)



ARRAY TEXT:C222(aBirthDateFormat;4)
aBirthDateFormat{1}:="000000"
aBirthDateFormat{2}:="00000000"
aBirthDateFormat{3}:="00/00/00"
aBirthDateFormat{4}:="00/00/0000"

$el:=Find in array:C230(aBirthDateFormat;vs_BirthDateFormat)
If ($el>0)
	aBirthDateFormat:=$el
Else 
	aBirthDateFormat:=1
	vs_BirthDateFormat:="000000"
End if 

$el:=Find in array:C230(aFonts;vs_ActaFont)
If ($el=-1)
	vs_ActaFont:=""
End if 
If (vs_ActaFont="")
	vs_ActaFont:="Arial"
End if 
aFonts:=$el

If (vs_ActaTitle="")
	vs_ActaTitle:="ACTA DE REGISTRO DE CALIFICACIONES Y PROMOCION ESCOLAR"
End if 
If (vs_ActaSubTitle="")
	Case of 
		: ([xxSTR_Niveles:6]NoNivel:5<9)
			vs_ActaSubTitle:="1º a 8º AÑO DE EDUCACION BASICA"
		: (([xxSTR_Niveles:6]NoNivel:5>=9) & ([xxSTR_Niveles:6]NoNivel:5<=10))
			vs_ActaSubTitle:="1º y 2º AÑO DE ENSEÑANZA MEDIA"
		: (([xxSTR_Niveles:6]NoNivel:5>=11) & ([xxSTR_Niveles:6]NoNivel:5<=12))
			vs_ActaSubTitle:="3º y 4º AÑO DE ENSEÑANZA MEDIA"
	End case 
	vs_ActaSubTitle:=vs_ActaSubTitle+"\r"+"(Calificaciones finales)"
End if 


If (vt_Menciones="")
	Case of 
		: ([xxSTR_Niveles:6]NoNivel:5<=2)
			vt_Menciones:=__ ("Reconocido Oficialmente por el Ministerio de Educación de la República de Chile, según Resolución Exenta de Educación Nº ^0, Rol Base de Datos Nº ^1, ")+__ ("PLan de Estudios aprobado por Decreto Exento Nº ^2 y del Reglamento de Evaluación y Promoción Escolar Decreto Exento Nº ^3")
			vt_Menciones:=Replace string:C233(vt_Menciones;"^0";<>gDecCoop)
			vt_Menciones:=Replace string:C233(vt_Menciones;"^1";<>gRolBD)
			vt_Menciones:=Replace string:C233(vt_Menciones;"^2";"545 del año 1996")
			vt_Menciones:=Replace string:C233(vt_Menciones;"^3";"511 del año 1997")
		: ([xxSTR_Niveles:6]NoNivel:5<=4)
			vt_Menciones:=__ ("Reconocido Oficialmente por el Ministerio de Educación de la República de Chile, según Resolución Exenta de Educación Nº ^0, Rol Base de Datos Nº ^1, ")+__ ("PLan de Estudios aprobado por Decreto Exento Nº ^2 y del Reglamento de Evaluación y Promoción Escolar Decreto Exento Nº ^3")
			vt_Menciones:=Replace string:C233(vt_Menciones;"^0";<>gDecCoop)
			vt_Menciones:=Replace string:C233(vt_Menciones;"^1";<>gRolBD)
			vt_Menciones:=Replace string:C233(vt_Menciones;"^2";"552 del año 1997")
			vt_Menciones:=Replace string:C233(vt_Menciones;"^3";"511 del año 1997")
		: ([xxSTR_Niveles:6]NoNivel:5=5)
			vt_Menciones:=__ ("Reconocido Oficialmente por el Ministerio de Educación de la República de Chile, según Resolución Exenta de Educación Nº ^0, Rol Base de Datos Nº ^1, ")+__ ("PLan de Estudios aprobado por Decreto Exento Nº ^2 y del Reglamento de Evaluación y Promoción Escolar Decreto Exento Nº ^3")
			vt_Menciones:=Replace string:C233(vt_Menciones;"^0";<>gDecCoop)
			vt_Menciones:=Replace string:C233(vt_Menciones;"^1";<>gRolBD)
			vt_Menciones:=Replace string:C233(vt_Menciones;"^2";"220 del año 1999")
			vt_Menciones:=Replace string:C233(vt_Menciones;"^3";"511 del año 1997")
		: ([xxSTR_Niveles:6]NoNivel:5<=8)
			vt_Menciones:=""
			vt_Menciones:=Replace string:C233(vt_Menciones;"^0";"146 de 1988")
			vt_Menciones:=Replace string:C233(vt_Menciones;"^1";"4002 de 1980")
			vt_Menciones:=Replace string:C233(vt_Menciones;"^2";<>gDecCoop)
		: ([xxSTR_Niveles:6]NoNivel:5=9)
			vt_Menciones:=__ ("Reconocido Oficialmente por el Ministerio de Educación de la República de Chile, según Resolución Exenta de Educación Nº ^0, Rol Base de Datos Nº ^1, ")+__ ("PLan de Estudios aprobado por Decreto Exento Nº ^2 y del Reglamento de Evaluación y Promoción Escolar Decreto Exento Nº ^3")
			vt_Menciones:=Replace string:C233(vt_Menciones;"^0";<>gDecCoop)
			vt_Menciones:=Replace string:C233(vt_Menciones;"^1";<>gRolBD)
			vt_Menciones:=Replace string:C233(vt_Menciones;"^2";"77 del año 1999")
			vt_Menciones:=Replace string:C233(vt_Menciones;"^3";"112 del año 1999")
		: ([xxSTR_Niveles:6]NoNivel:5<=12)
			vt_Menciones:=__ ("- Decreto Exento de Educación que reglamenta la Evaluación y Promoción de Alumnos º ^0\r- Decreto Exento que aprueba Plan y Programas de Estudio Nº ^1\r- Resolución Exenta que lo declara Cooperador de la Función Educacional del Estado Nº ^2")
			vt_Menciones:=Replace string:C233(vt_Menciones;"^0";"146 de 1988")
			vt_Menciones:=Replace string:C233(vt_Menciones;"^1";"4002 de 1980")
			vt_Menciones:=Replace string:C233(vt_Menciones;"^2";<>gDecCoop)
	End case 
End if 
ACTAS_EstiloFilasConfiguracion 
$b_editable:=(Record number:C243([Cursos:3])=No current record:K29:2) | [Cursos:3]ActaEspecificaAlCurso:35

OBJECT SET ENTERABLE:C238(*;"acta@";$b_editable)
OBJECT SET ENABLED:C1123(*;"acta@";$b_editable)

(OBJECT Get pointer:C1124(Object named:K67:5;"acta.imprimirAbreviaturas"))->:=vi_PrintCodes
(OBJECT Get pointer:C1124(Object named:K67:5;"acta.apellidosEnAltas"))->:=vi_UppercaseNames
(OBJECT Get pointer:C1124(Object named:K67:5;"acta.etiquetasEnAltas"))->:=vi_EtiquetasEnAltas
(OBJECT Get pointer:C1124(Object named:K67:5;"acta.firmaDirectorNivel"))->:=vi_FirmaDirectorNivel
(OBJECT Get pointer:C1124(Object named:K67:5;"acta.firmaDirectorColegio"))->:=vi_FirmaDirectorColegio

