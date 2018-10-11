//%attributes = {}
  //ACTbol_AgruparXCategoria

ARRAY TEXT:C222(atACT_NombreCategoria;0)
ARRAY REAL:C219(arACT_MontoCategoria;0)
ARRAY LONGINT:C221(arACT_CIDCtaCteTemp;0)  //RCH
ARRAY LONGINT:C221(arACT_CIDCtaCteTemp2;0)  //RCH
ARRAY LONGINT:C221(arACT_CIDCtaCteTemp3;1)  //RCH
ARRAY TEXT:C222(atACT_CIDCtaCteTemp;0)  //RCH
ARRAY LONGINT:C221($aIDCategoria;0)
ARRAY LONGINT:C221($aPosCategoria;0)
ARRAY TEXT:C222(atACT_RecNumsCargosCat;0)

  //C_TEXT($t_apellidos_y_nombres;$t_mes;$t_curso;$t_rut;$t_year;$t_nivel)
ARRAY TEXT:C222(atACTcat_Alumnos;0)
ARRAY TEXT:C222(atACTcat_mes;0)
ARRAY TEXT:C222(atACTcat_curso;0)
ARRAY TEXT:C222(atACTcat_rut;0)
ARRAY TEXT:C222(atACTcat_year;0)
ARRAY TEXT:C222(atACTcat_nivel;0)
ARRAY TEXT:C222($atACT_yearMonth;0)

  //20150912 RCH 
ARRAY TEXT:C222(atACTcat_unidadCargo;0)
ARRAY REAL:C219(arACTcat_TasaIVA;0)

  //20151005 RCH
ARRAY REAL:C219(arACTcat_cantidadCargo;0)

READ ONLY:C145([xxACT_Items:179])
READ ONLY:C145([xxACT_ItemsCategorias:98])
ALL RECORDS:C47([xxACT_ItemsCategorias:98])
SELECTION TO ARRAY:C260([xxACT_ItemsCategorias:98]ID:2;$aIDCategoria;[xxACT_ItemsCategorias:98]Posicion:3;$aPosCategoria;[xxACT_ItemsCategorias:98]Nombre:1;atACT_NombreCategoria)
AT_RedimArrays (Size of array:C274($aIDCategoria);->arACT_MontoCategoria)
AT_RedimArrays (Size of array:C274($aIDCategoria);->atACT_CIDCtaCteTemp;->arACT_CIDCtaCteTemp2)  //RCH
AT_RedimArrays (Size of array:C274($aIDCategoria);->atACT_RecNumsCargosCat)

AT_RedimArrays (Size of array:C274($aIDCategoria);->arACTcat_cantidadCargo)

  //AT_RedimArrays (Size of array($aIDCategoria);->atACTcat_Alumnos;->atACTcat_mes;->atACTcat_curso;->atACTcat_rut;->atACTcat_year;->atACTcat_nivel;->$atACT_yearMonth)
AT_RedimArrays (Size of array:C274($aIDCategoria);->atACTcat_Alumnos;->atACTcat_mes;->atACTcat_curso;->atACTcat_rut;->atACTcat_year;->atACTcat_nivel;->$atACT_yearMonth;->atACTcat_unidadCargo;->arACTcat_TasaIVA)


For ($i;Size of array:C274(alACT_CRefs);1;-1)
	QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=alACT_CRefs{$i})
	$cat:=Find in array:C230($aIDCategoria;[xxACT_Items:179]ID_Categoria:8)
	If ([xxACT_Items:179]ID_Categoria:8#0) & ($cat#-1)
		arACT_MontoCategoria{$cat}:=arACT_MontoCategoria{$cat}+arACT_MontoPagado{$i}
		atACT_CIDCtaCteTemp{$cat}:=atACT_CIDCtaCteTemp{$cat}+String:C10(alACT_CIDCtaCte{$i})+";"  //RCH
		
		  //20150727 RCH guardo datos que se podrian utilizar al imprimir dtenet
		If (Position:C15(atACT_CAlumno{$i};atACTcat_Alumnos{$cat})=0)
			atACTcat_Alumnos{$cat}:=Choose:C955(atACTcat_Alumnos{$cat}="";"";atACTcat_Alumnos{$cat}+",")+atACT_CAlumno{$i}
			atACTcat_curso{$cat}:=Choose:C955(atACTcat_curso{$cat}="";"";atACTcat_curso{$cat}+",")+atACT_CAlumnoCurso{$i}
			atACTcat_rut{$cat}:=Choose:C955(atACTcat_rut{$cat}="";"";atACTcat_rut{$cat}+",")+atACT_CAlumnoRUT{$i}
			atACTcat_nivel{$cat}:=Choose:C955(atACTcat_nivel{$cat}="";"";atACTcat_nivel{$cat}+",")+atACT_CAlumnoNivelNombre{$i}
		End if 
		
		$t_yearMonth:=atACT_AñoCargo{$i}+<>atXS_MonthNames{alACT_MesCargo{$i}}
		If (Position:C15($t_yearMonth;$atACT_yearMonth{$cat})=0)
			  //$atACT_yearMonth{$cat}:=Choose($atACT_yearMonth{$cat}="";"";"-")+$t_yearMonth
			$atACT_yearMonth{$cat}:=Choose:C955($atACT_yearMonth{$cat}="";"";$atACT_yearMonth{$cat}+", ")+$t_yearMonth  //20161214 RCH Se asignaba mal el valor al arreglo
			
			atACTcat_year{$cat}:=Choose:C955(atACTcat_year{$cat}="";"";atACTcat_year{$cat}+",")+atACT_AñoCargo{$i}
			atACTcat_mes{$cat}:=Choose:C955(atACTcat_mes{$cat}="";"";atACTcat_mes{$cat}+",")+<>atXS_MonthNames{alACT_MesCargo{$i}}
		End if 
		
		atACTcat_unidadCargo{$cat}:=atACT_unidadCargo{$i}
		arACTcat_TasaIVA{$cat}:=arACT_TasaIVA{$i}
		
		  //20151005 RCH cantidad
		arACTcat_cantidadCargo{$cat}:=arACTcat_cantidadCargo{$cat}+arACT_Cantidad{$i}
		
		$el:=Find in array:C230(alACT_RecNumsCargosT;alACT_RecNumsCargos{$i})
		  //20130626 RCH NF CANTIDAD
		  //AT_Delete ($i;1;->adACT_CFechaEmision;->adACT_CFechaVencimiento;->atACT_CAlumno;->atACT_CAlumnoCurso;->atACT_CAlumnoNivelNombre;->atACT_CAlumnoPCurso;->atACT_CAlumnoPNivelNombre;->atACT_CGlosa;->arACT_CMontoNeto;->arACT_CIntereses;->arACT_CSaldo;->alACT_RecNumsCargos;->alACT_CRefs;->alACT_CIDCtaCte;->asACT_Marcas;->arACT_MontoMoneda;->atACT_MonedaCargo;->atACT_MonedaSimbolo;->atACT_CGlosaImpresion;->asACT_Afecto;->arACT_TasaIVA;->arACT_MontoPagado;->arACT_MontoIVA;->arACT_CTotalDesctos;->aIDCta;->arACT_Cantidad;->arACT_Unitario;->alACT_MesCargo;->alACT_AñoCargo)
		  //20150727 RCH RUT
		  //AT_Delete ($i;1;->adACT_CFechaEmision;->adACT_CFechaVencimiento;->atACT_CAlumno;->atACT_CAlumnoCurso;->atACT_CAlumnoNivelNombre;->atACT_CAlumnoPCurso;->atACT_CAlumnoPNivelNombre;->atACT_CGlosa;->arACT_CMontoNeto;->arACT_CIntereses;->arACT_CSaldo;->alACT_RecNumsCargos;->alACT_CRefs;->alACT_CIDCtaCte;->asACT_Marcas;->arACT_MontoMoneda;->atACT_MonedaCargo;->atACT_MonedaSimbolo;->atACT_CGlosaImpresion;->asACT_Afecto;->arACT_TasaIVA;->arACT_MontoPagado;->arACT_MontoIVA;->arACT_CTotalDesctos;->aIDCta;->arACT_Cantidad;->arACT_Unitario;->alACT_MesCargo;->atACT_AñoCargo;->atACT_CAlumnoRUT)
		  //20150912 RCH unidad
		AT_Delete ($i;1;->adACT_CFechaEmision;->adACT_CFechaVencimiento;->atACT_CAlumno;->atACT_CAlumnoCurso;->atACT_CAlumnoNivelNombre;->atACT_CAlumnoPCurso;->atACT_CAlumnoPNivelNombre;->atACT_CGlosa;->arACT_CMontoNeto;->arACT_CIntereses;->arACT_CSaldo;->alACT_RecNumsCargos;->alACT_CRefs;->alACT_CIDCtaCte;->asACT_Marcas;->arACT_MontoMoneda;->atACT_MonedaCargo;->atACT_MonedaSimbolo;->atACT_CGlosaImpresion;->asACT_Afecto;->arACT_TasaIVA;->arACT_MontoPagado;->arACT_MontoIVA;->arACT_CTotalDesctos;->aIDCta;->arACT_Cantidad;->arACT_Unitario;->alACT_MesCargo;->atACT_AñoCargo;->atACT_CAlumnoRUT;->atACT_unidadCargo)
		atACT_RecNumsCargosCat{$cat}:=atACT_RecNumsCargosCat{$cat}+ST_Boolean2Str (atACT_RecNumsCargosCat{$cat}="";"";";")+String:C10(alACT_RecNumsCargosT{$i})
		If ($el#-1)
			AT_Delete ($el;1;->alACT_RecNumsCargosT)
		End if 
	End if 
End for 
For ($i;1;Size of array:C274($aIDCategoria))  //RCH
	AT_Initialize (->arACT_CIDCtaCteTemp3)  //RCH
	AT_Text2Array (->arACT_CIDCtaCteTemp3;Substring:C12(atACT_CIDCtaCteTemp{$i};1;Length:C16(atACT_CIDCtaCteTemp{$i})-1);";")  //RCH
	AT_DistinctsArrayValues (->arACT_CIDCtaCteTemp3)  //RCH
	arACT_CIDCtaCteTemp2{$i}:=Size of array:C274(arACT_CIDCtaCteTemp3)  //RCH
End for   //RCH
If (Size of array:C274(adACT_CFechaEmision)=0)
	vb_HideColsCtas:=True:C214
End if 

  //SORT ARRAY($aPosCategoria;atACT_NombreCategoria;arACT_MontoCategoria;arACT_CIDCtaCteTemp2;>)
  //SORT ARRAY($aPosCategoria;atACT_NombreCategoria;arACT_MontoCategoria;arACT_CIDCtaCteTemp2;atACTcat_Alumnos;atACTcat_mes;atACTcat_curso;atACTcat_rut;atACTcat_year;atACTcat_nivel;>)
  //SORT ARRAY($aPosCategoria;atACT_NombreCategoria;arACT_MontoCategoria;arACT_CIDCtaCteTemp2;atACTcat_Alumnos;atACTcat_mes;atACTcat_curso;atACTcat_rut;atACTcat_year;atACTcat_nivel;atACTcat_unidadCargo;arACTcat_TasaIVA;>)
SORT ARRAY:C229($aPosCategoria;atACT_NombreCategoria;arACT_MontoCategoria;arACT_CIDCtaCteTemp2;atACTcat_Alumnos;atACTcat_mes;atACTcat_curso;atACTcat_rut;atACTcat_year;atACTcat_nivel;atACTcat_unidadCargo;arACTcat_TasaIVA;arACTcat_cantidadCargo;>)

