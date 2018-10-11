//%attributes = {}
  // AS_xALP_MenuContextualNotas()
  // Por: Alberto Bachler K.: 04-02-14, 13:05:11
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BLOB:C604($x_RecNumsArray)
C_BOOLEAN:C305($b_calificacionesEditables;$b_columnaIngresable;$b_columnaSinDatos;$b_edicionPropiedadesPermitida;$b_GuardarRegistro;$b_PromediosEditables;$b_recalcular;$b_usuarioSinRestriccion)
C_LONGINT:C283($i_alumnos;$l_columna;$l_Error;$l_itemSeleccionado;$l_recNumAsignatura;$l_recNumCalificaciones)
C_POINTER:C301($y_arregloLiterales;$y_arregloReales;$y_campoCalificaciones_literal;$y_campoCalificaciones_nota;$y_campoCalificaciones_puntos;$y_campoCalificaciones_real;$y_campoCalificaciones_simbolo)
C_REAL:C285($r_valorEditadoReal)
C_TEXT:C284($t_arregloLiterales;$t_itemsPopupMenu)

ARRAY LONGINT:C221($al_RecNumsAsignaturas;0)
ARRAY LONGINT:C221($al_filasSeleccionadas;0)
ARRAY POINTER:C280($ay_Columnas;0)
ARRAY REAL:C219($ar_copiaReales;0)
ARRAY TEXT:C222($at_copiaLiterales;0)
ARRAY TEXT:C222($at_arrayNames;0)
ARRAY TEXT:C222($at_Arreglos;0)
ARRAY TEXT:C222($at_encabezados;0)

$l_Error:=AL_GetObjects (xALP_ASNotas;ALP_Object_Columns;$ay_Columnas)
$l_Error:=AL_GetObjects (xALP_ASNotas;ALP_Object_Source;$at_Arreglos)
$l_Error:=AL_GetObjects (xALP_ASNotas;ALP_Object_HeaderText;$at_encabezados)
$l_error:=AL_GetObjects (xALP_ASNotas;ALP_Object_Selection;$al_filasSeleccionadas)
$l_columna:=AL_GetAreaLongProperty (xALP_ASNotas;ALP_Area_ClickedCol)

$t_arregloLiterales:=$at_Arreglos{$l_columna}
$y_arregloLiterales:=$ay_Columnas{$l_columna}
If ($t_arregloLiterales="aNtaOf")
	$y_arregloReales:=->aRealNtaOficial
Else 
	$y_arregloReales:=Get pointer:C304(Replace string:C233($t_arregloLiterales;"aNta";"aRealNta"))
End if 

$b_recalcular:=False:C215

  // obtengo punteros sobre los campos en los que almacenarán las calificaciones
$y_campoCalificaciones_real:=ASev2_punteroReal ($at_Arreglos{$l_columna};aiSTR_Periodos_Numero{atSTR_Periodos_Nombre})
$y_campoCalificaciones_nota:=ASev2_punteroNota ($at_Arreglos{$l_columna};aiSTR_Periodos_Numero{atSTR_Periodos_Nombre})
$y_campoCalificaciones_puntos:=ASev2_punteroPuntos ($at_Arreglos{$l_columna};aiSTR_Periodos_Numero{atSTR_Periodos_Nombre})
$y_campoCalificaciones_simbolo:=ASev2_punteroSimbolo ($at_Arreglos{$l_columna};aiSTR_Periodos_Numero{atSTR_Periodos_Nombre})
$y_campoCalificaciones_literal:=ASev2_punteroLiteral ($at_Arreglos{$l_columna};aiSTR_Periodos_Numero{atSTR_Periodos_Nombre})



  // construyo el popupmenu según los privilegios del usuario y el contexto:
  // - los items Copiar Planilla y Copiar selección se inactivan si no hay datos
  // - los items Cortar y Borrar se inactivan si el usuario no tiene derechos de edición o si el click derecho fue
  //   sobre las columnas Nº, Alumno o Curso
  // - el item Pegar está activo sólo si el usuario tiene derechos de edición.
  //   si no está autorizado a modificar notas ya registradas solo se habilita si la columna no tiene ninguna nota
  // - Los items de ordenamiento se habilitan solo si hay datos
  // - El item que permite establecer propiedades de evaluación de la columna se habilita solo si el usuario
  //   tiene derecho de edición de las propiedades de la asignatura
$b_usuarioSinRestricciones:=(USR_checkRights ("M";->[Alumnos_Calificaciones:208]))
$b_edicionAutorizada:=vb_calificacionesEditables & (<>viSTR_NoModificarNotas=0)
$b_PromediosEditables:=AS_PromediosSonEditables ([Asignaturas:18]Numero:1)

  //20130614 ASM para cuando no se selecciona columnas en las evaluaciones
If ($l_columna>0)
	$b_columnaSinDatos:=Not:C34(AT_ArrayHasNonNulValues ($y_arregloLiterales))
	$b_columnaConCalificaciones:=AT_ArrayHasNonNulValues ($y_arregloLiterales)
Else 
	$b_columnaConCalificaciones:=False:C215
	$b_columnaSinDatos:=True:C214
	$b_calificacionesEditables:=False:C215
	vb_calificacionesEditables:=False:C215
End if 

If (($l_Columna-vi_PrimeraColumnaParciales+1)>=1)
	$b_edicionAutorizada:=(aiAS_EvalPropEnterable{$l_Columna-vi_PrimeraColumnaParciales+1}=1)
End if 

$t_itemsPopupMenu:=__ ("Cortar columna")+";"+__ ("Copiar columna")+";"+__ ("Pegar columna")+";"+__ ("Borrar columna")+";(-;"+__ ("Propiedades de la columna…")
Case of 
	: (($l_columna>Find in array:C230($at_Arreglos;"aNtaOf")) & (Not:C34($b_edicionAutorizada)))
		$t_itemsPopupMenu:=Replace string:C233($t_itemsPopupMenu;__ ("Cortar Columna");"("+__ ("Cortar Columna"))
		$t_itemsPopupMenu:=Replace string:C233($t_itemsPopupMenu;__ ("Copiar Columna");"("+__ ("Copiar Columna"))
		$t_itemsPopupMenu:=Replace string:C233($t_itemsPopupMenu;__ ("Borrar Columna");"("+__ ("Borrar Columna"))
		$t_itemsPopupMenu:=Replace string:C233($t_itemsPopupMenu;__ ("Pegar Columna");"("+__ ("Pegar Columna"))
		
	: ((($l_Columna>=4) & ($l_columna<=Find in array:C230($at_Arreglos;"aNtaOf"))) & (Not:C34($b_PromediosEditables)))
		$t_itemsPopupMenu:=Replace string:C233($t_itemsPopupMenu;__ ("Cortar Columna");"("+__ ("Cortar Columna"))
		$t_itemsPopupMenu:=Replace string:C233($t_itemsPopupMenu;__ ("Copiar Columna");"("+__ ("Copiar Columna"))
		$t_itemsPopupMenu:=Replace string:C233($t_itemsPopupMenu;__ ("Borrar Columna");"("+__ ("Borrar Columna"))
		$t_itemsPopupMenu:=Replace string:C233($t_itemsPopupMenu;__ ("Pegar Columna");"("+__ ("Pegar Columna"))
		
	: ((Not:C34($b_edicionAutorizada)) & (Not:C34($b_usuarioSinRestricciones)))
		$t_itemsPopupMenu:=Replace string:C233($t_itemsPopupMenu;__ ("Cortar Columna");"("+__ ("Cortar Columna"))
		$t_itemsPopupMenu:=Replace string:C233($t_itemsPopupMenu;__ ("Copiar Columna");"("+__ ("Copiar Columna"))
		$t_itemsPopupMenu:=Replace string:C233($t_itemsPopupMenu;__ ("Borrar Columna");"("+__ ("Borrar Columna"))
		$t_itemsPopupMenu:=Replace string:C233($t_itemsPopupMenu;__ ("Pegar Columna");"("+__ ("Pegar Columna"))
		
	: (Not:C34($b_columnaConCalificaciones))
		$t_itemsPopupMenu:=Replace string:C233($t_itemsPopupMenu;__ ("Cortar Columna");"("+__ ("Cortar Columna"))
		$t_itemsPopupMenu:=Replace string:C233($t_itemsPopupMenu;__ ("Copiar Columna");"("+__ ("Copiar Columna"))
		$t_itemsPopupMenu:=Replace string:C233($t_itemsPopupMenu;__ ("Borrar Columna");"("+__ ("Borrar Columna"))
		If (Size of array:C274(aNtaCopyCol)=0)
			$t_itemsPopupMenu:=Replace string:C233($t_itemsPopupMenu;__ ("Pegar Columna");"("+__ ("Pegar Columna"))
		End if 
		
		
	Else 
		If (Size of array:C274(aNtaCopyCol)=0)
			$t_itemsPopupMenu:=Replace string:C233($t_itemsPopupMenu;__ ("Pegar Columna");"("+__ ("Pegar Columna"))
		End if 
End case 




  //$b_edicionPropiedadesPermitida:=(USR_checkRights ("M";->[Asignaturas])) | (USR_GetMethodAcces ("Propiedades de evaluación";0)) | ([Asignaturas]Profesor_Numero=<>lUSR_RelatedTableUserID)
  //ARRAY TEXT($at_itemsMenu;12)
  //$at_itemsMenu{1}:="("*Num(Size of array(aNtaOrden)=0)+__ ("Copiar planilla al portapapeles")
  //$at_itemsMenu{2}:="("*Num(Size of array($al_filasSeleccionadas)=0)+__ ("Copiar selección al portapapeles...")
  //$at_itemsMenu{3}:="(-"
  //$at_itemsMenu{4}:=__ ("Cortar Columna")
  //$at_itemsMenu{5}:=__ ("Copiar Columna")
  //$at_itemsMenu{6}:=__ ("Pegar Columna")
  //$at_itemsMenu{7}:=__ ("Borrar Columna")
  //$at_itemsMenu{8}:="(-"
  //$at_itemsMenu{9}:="("*Num((Size of array(aNtaOrden)=0) | ($b_columnaSinDatos))+__ ("Orden ascendente")
  //$at_itemsMenu{10}:="("*Num((Size of array(aNtaOrden)=0) | ($b_columnaSinDatos))+__ ("Orden descendente")
  //$at_itemsMenu{11}:="(-"
  //$at_itemsMenu{12}:="("*Num($b_edicionPropiedadesPermitida=False)+__ ("Propiedades de la columna…")

  //If (Size of array(aNtaCopyCol)=0)
  //$at_itemsMenu{6}:="("+$at_itemsMenu{6}
  //End if 

  //If ($b_columnaSinDatos)
  //$at_itemsMenu{4}:="("+$at_itemsMenu{4}
  //$at_itemsMenu{5}:="("+$at_itemsMenu{5}
  //$at_itemsMenu{7}:="("+$at_itemsMenu{7}
  //End if 

  //If ($l_columna<vi_PrimeraColumnaParciales)
  //$at_itemsMenu{12}:="("+$at_itemsMenu{12}
  //End if 

  //Case of 
  //: ((vb_calificacionesEditables=False) | ($t_arregloLiterales="aNtaOrden") | ($t_arregloLiterales="aNtaStdNme") | ($t_arregloLiterales="aNtaOf") | ($t_arregloLiterales="aNtaCurso"))
  //$at_itemsMenu{4}:="("+$at_itemsMenu{4}
  //$at_itemsMenu{5}:="("+$at_itemsMenu{5}
  //$at_itemsMenu{6}:="("+$at_itemsMenu{6}
  //$at_itemsMenu{7}:="("+$at_itemsMenu{7}

  //: (($t_arregloLiterales="aNtaP@") | ($t_arregloLiterales="aNtaF") | ($t_arregloLiterales="aNtaOf"))
  //$y_arregloReales:=Get pointer(Replace string($t_arregloLiterales;"aNta";"aRealNta"))
  //If (Not($b_PromediosEditables))
  //$at_itemsMenu{4}:="("+$at_itemsMenu{4}
  //$at_itemsMenu{5}:="("+$at_itemsMenu{5}
  //$at_itemsMenu{6}:="("+$at_itemsMenu{6}
  //$at_itemsMenu{7}:="("+$at_itemsMenu{7}
  //End if 

  //: ($t_arregloLiterales="aNtaEsfuerzo")
  //$at_itemsMenu{4}:="("+$at_itemsMenu{4}
  //$at_itemsMenu{5}:="("+$at_itemsMenu{5}
  //$at_itemsMenu{6}:="("+$at_itemsMenu{6}
  //If (Not($b_calificacionesEditables))
  //$at_itemsMenu{7}:="("+$at_itemsMenu{7}
  //End if 

  //Else 
  //$y_arregloReales:=Get pointer(Replace string($t_arregloLiterales;"aNta";"aRealNta"))
  //If (($b_calificacionesEditables=False) & ($b_usuarioSinRestriccion=False))
  //$at_itemsMenu{4}:="("+$at_itemsMenu{4}
  //$at_itemsMenu{7}:="("+$at_itemsMenu{7}
  //End if 

  //If (vb_calificacionesEditables)
  //$b_columnaIngresable:=(aiAS_EvalPropEnterable{$l_Columna-vi_PrimeraColumnaParciales+1}=1)
  //If ((Size of array(aNtaCopyCol)>0) & ($b_columnaIngresable=True) & (($b_columnaSinDatos) | (<>viSTR_NoModificarNotas=0) | ($b_usuarioSinRestriccion=True)))
  //$at_itemsMenu{6}:=__ ("Pegar Columna")
  //Else 
  //$at_itemsMenu{6}:="("+$at_itemsMenu{6}
  //End if 
  //Else 
  //$at_itemsMenu{6}:="("+$at_itemsMenu{6}
  //End if 
  //End case 

  //$t_itemsPopupMenu:=Replace string(AT_array2text (->$at_itemsMenu;";");"((";"(")

  // Modificado por: Alexis Bustamante (28-07-2017)
  //TICKET 186299 
  // valido que la columna sea una parcial paras deslegar Menu
  //siempre la parcial 1 es columna 18 aunque esten configurados control de periodo,bonificacion etc.

If (($l_columna>=18) & ($l_columna<=29))
	
	
	$b_recalcular:=False:C215
	$l_itemSeleccionado:=Pop up menu:C542($t_itemsPopupMenu)
	If ($l_itemSeleccionado>0)
		Case of 
			: ($l_itemSeleccionado=1)  //cortar columna
				COPY ARRAY:C226($y_arregloLiterales->;aNtaCopyCol)
				COPY ARRAY:C226($y_arregloReales->;aRealNtaCopyCol)
				For ($i_alumnos;1;Size of array:C274(aNtaIdAlumno))
					$r_valorEditadoReal:=-10
					$b_GuardarRegistro:=True:C214
					$l_recNumCalificaciones:=aNtaRecNum{$i_alumnos}
					ASev2_RegistraCalificacion ($l_recNumCalificaciones;$r_valorEditadoReal;$y_campoCalificaciones_literal;$y_campoCalificaciones_real;$y_campoCalificaciones_nota;$y_campoCalificaciones_puntos;$y_campoCalificaciones_simbolo;$b_GuardarRegistro)
				End for 
				$b_recalcular:=True:C214
				modNotas:=True:C214
				
				
			: ($l_itemSeleccionado=2)  //copiar columna
				COPY ARRAY:C226($y_arregloLiterales->;aNtaCopyCol)
				COPY ARRAY:C226($y_arregloReales->;aRealNtaCopyCol)
				
				
			: (($l_itemSeleccionado=3) & (Size of array:C274(aNtaCopyCol)>0))  //pegar columna
				AL_UpdateArrays (xALP_ASNotas;0)
				For ($i_alumnos;1;Size of array:C274(aNtaIdAlumno))
					$r_valorEditadoReal:=aRealNtaCopyCol{$i_alumnos}
					$b_GuardarRegistro:=True:C214
					$l_recNumCalificaciones:=aNtaRecNum{$i_alumnos}
					ASev2_RegistraCalificacion ($l_recNumCalificaciones;$r_valorEditadoReal;$y_campoCalificaciones_literal;$y_campoCalificaciones_real;$y_campoCalificaciones_nota;$y_campoCalificaciones_puntos;$y_campoCalificaciones_simbolo;$b_GuardarRegistro)
				End for 
				$b_recalcular:=True:C214
				modNotas:=True:C214
				
				
			: ($l_itemSeleccionado=4)  //borrar columna
				For ($i_alumnos;1;Size of array:C274(aNtaIdAlumno))
					$r_valorEditadoReal:=-10
					$b_GuardarRegistro:=True:C214
					$l_recNumCalificaciones:=aNtaRecNum{$i_alumnos}
					ASev2_RegistraCalificacion ($l_recNumCalificaciones;$r_valorEditadoReal;$y_campoCalificaciones_literal;$y_campoCalificaciones_real;$y_campoCalificaciones_nota;$y_campoCalificaciones_puntos;$y_campoCalificaciones_simbolo;$b_GuardarRegistro)
				End for 
				$b_recalcular:=True:C214
				modNotas:=True:C214
				ARRAY TEXT:C222(aNtaCopyCol;0)
				ARRAY REAL:C219(aRealNtaCopyCol;0)
				modNotas:=True:C214
				
			: ($l_itemSeleccionado=6)  //prefs
				If ((USR_checkRights ("M";->[Asignaturas:18])) | (USR_GetMethodAcces ("Propiedades de evaluación";0)) | ([Asignaturas:18]profesor_numero:4=<>lUSR_RelatedTableUserID))
					$l_parcialNumero:=$l_columna-vi_PrimeraColumnaParciales+1
					AS_SetGradeOptions ($l_parcialNumero)
				End if 
				
		End case 
		
		
		
		
		  //20131126 ASM ticket 127170 . No se refrescaban los datos en la pagina de evaluación cuando estaba marcada la opción de no calcular promedios.
		  //If (($b_recalcular) & (AS_PromediosSonCalculados ) & (vb_calificacionesEditables))
		If (($b_recalcular) & (vb_calificacionesEditables))
			If (AS_PromediosSonCalculados )
				  // conservo una copia de la eventual copia de la columna cortada (los arreglos aNtaCopyCol y aRealNtaCopyCol son inicializados en AS_PaginaEvaluacion)
				COPY ARRAY:C226(aNtaCopyCol;$at_copiaLiterales)
				COPY ARRAY:C226(aRealNtaCopyCol;$ar_copiaReales)
				
				$l_recNumAsignatura:=Record number:C243([Asignaturas:18])
				SAVE RECORD:C53([Asignaturas:18])
				
				APPEND TO ARRAY:C911($al_RecNumsAsignaturas;$l_recNumAsignatura)
				BLOB_Variables2Blob (->$x_RecNumsArray;0;->$al_RecNumsAsignaturas)
				EV2dbu_Recalculos ($x_RecNumsArray;False:C215)
				KRL_GotoRecord (->[Asignaturas:18];$l_recNumAsignatura)
				AS_PaginaEvaluacion 
				
				  // restablezco la columna cortada para permitir pegar en un paso posterior
				COPY ARRAY:C226($at_copiaLiterales;aNtaCopyCol)
				COPY ARRAY:C226($ar_copiaReales;aRealNtaCopyCol)
			Else 
				AS_PaginaEvaluacion 
			End if 
		End if 
		
	End if 
	
	
End if 

