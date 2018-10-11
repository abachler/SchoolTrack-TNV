//%attributes = {}
  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda
  // Fecha y hora: 19-10-17, 11:43:46
  // ----------------------------------------------------
  // Método: WIZ_STR_CargaDatosEncabezadotxt
  // Descripción
  //
  //
  // Parámetros
  // ----------------------------------------------------

C_LONGINT:C283($l_field;$l_noTabla)
C_POINTER:C301($y_arrayCampo;$y_arrayNombreCampo;$y_pointerCampo;$y_pointerTabla)
C_TEXT:C284($t_accion;$t_nombreCampo)
C_OBJECT:C1216($ob_objeto;$2;$0;$ob_retorno)

$t_accion:=$1

If (Count parameters:C259>=2)
	$ob_objeto:=$2
End if 

$b_cargarArreglos:=True:C214
Case of 
	: ($t_accion="CargaCamposAlumno")
		ARRAY TEXT:C222(at_nombreCampoAlumno;0)
		ARRAY TEXT:C222(at_nombreCampoAlumnotxt;0)
		ARRAY POINTER:C280(ay_CampoAlumno;0)
		ARRAY BOOLEAN:C223(ab_seleccionadoAlumno;0)
		
		$y_arrayNombreCampo:=->at_nombreCampoAlumno
		$y_arrayCampo:=->ay_CampoAlumno
		$y_arraySeleccionado:=->ab_seleccionadoAlumno
		$y_arrayCampotxt:=->at_nombreCampoAlumnotxt
		$y_pointerTabla:=->[Alumnos:2]
		
	: ($t_accion="CargaCamposApoderadoAcademico")
		ARRAY TEXT:C222(at_nombreCampoApoAca;0)
		ARRAY TEXT:C222(at_nombreCampoApoAcatxt;0)
		ARRAY POINTER:C280(ay_CampoApoAca;0)
		ARRAY BOOLEAN:C223(ab_seleccionadoApoAca;0)
		
		$y_arrayNombreCampo:=->at_nombreCampoApoAca
		$y_arrayCampo:=->ay_CampoApoAca
		$y_arraySeleccionado:=->ab_seleccionadoApoAca
		$y_arrayCampotxt:=->at_nombreCampoApoAcatxt
		$y_pointerTabla:=->[Personas:7]
		
	: ($t_accion="CargaCamposApoderadoCuenta")
		ARRAY TEXT:C222(at_nombreCampoApoCta;0)
		ARRAY TEXT:C222(at_nombreCampoApoCtatxt;0)
		ARRAY POINTER:C280(ay_CampoApoCta;0)
		ARRAY BOOLEAN:C223(ab_seleccionadoApoCta;0)
		
		$y_arrayNombreCampo:=->at_nombreCampoApoCta
		$y_arrayCampo:=->ay_CampoApoCta
		$y_arraySeleccionado:=->ab_seleccionadoApoCta
		$y_arrayCampotxt:=->at_nombreCampoApoCtatxt
		$y_pointerTabla:=->[Personas:7]
		
	: ($t_accion="CargaCamposPadre")
		ARRAY TEXT:C222(at_nombreCampoPadre;0)
		ARRAY TEXT:C222(at_nombreCampoPadretxt;0)
		ARRAY POINTER:C280(ay_CampoPadre;0)
		ARRAY BOOLEAN:C223(ab_seleccionadoPadre;0)
		
		$y_arrayNombreCampo:=->at_nombreCampoPadre
		$y_arrayCampo:=->ay_CampoPadre
		$y_arraySeleccionado:=->ab_seleccionadoPadre
		$y_arrayCampotxt:=->at_nombreCampoPadretxt
		$y_pointerTabla:=->[Personas:7]
		
	: ($t_accion="CargaCamposMadre")
		ARRAY TEXT:C222(at_nombreCampoMadre;0)
		ARRAY TEXT:C222(at_nombreCampoMadretxt;0)
		ARRAY POINTER:C280(ay_CampoMadre;0)
		ARRAY BOOLEAN:C223(ab_seleccionadoMadre;0)
		
		$y_arrayNombreCampo:=->at_nombreCampoMadre
		$y_arrayCampo:=->ay_CampoMadre
		$y_arraySeleccionado:=->ab_seleccionadoMadre
		$y_arrayCampotxt:=->at_nombreCampoMadretxt
		$y_pointerTabla:=->[Personas:7]
		
	: ($t_accion="CargaCamposFamilia")
		ARRAY TEXT:C222(at_nombreCampoFamilia;0)
		ARRAY TEXT:C222(at_nombreCampoFamiliatxt;0)
		ARRAY POINTER:C280(ay_CampoFamilia;0)
		ARRAY BOOLEAN:C223(ab_seleccionadoFamilia;0)
		
		$y_arrayNombreCampo:=->at_nombreCampoFamilia
		$y_arrayCampo:=->ay_CampoFamilia
		$y_arraySeleccionado:=->ab_seleccionadoFamilia
		$y_arrayCampotxt:=->at_nombreCampoFamiliatxt
		$y_pointerTabla:=->[Familia:78]
		
	: ($t_accion="cargaFichaMedica")
		ARRAY TEXT:C222(at_nombreCampoFicha;0)
		ARRAY TEXT:C222(at_nombreCampoFichatxt;0)
		ARRAY POINTER:C280(ay_CampoFicha;0)
		ARRAY BOOLEAN:C223(ab_seleccionadoFicha;0)
		
		$y_arrayNombreCampo:=->at_nombreCampoFicha
		$y_arrayCampo:=->ay_CampoFicha
		$y_arraySeleccionado:=->ab_seleccionadoFicha
		$y_arrayCampotxt:=->at_nombreCampoFichatxt
		$y_pointerTabla:=->[Alumnos_FichaMedica:13]
		
	: ($t_accion="camposPropios")
		$b_cargarArreglos:=False:C215
		C_POINTER:C301($y_campo;$y_Nil)
		C_TEXT:C284($t_nombre)
		
		ARRAY TEXT:C222($at_nombreCampo;0)
		ARRAY TEXT:C222($at_nombreCampotxt;0)
		ARRAY POINTER:C280($ay_Campo;0)
		ARRAY BOOLEAN:C223($ab_seleccionado;0)
		
		$y_campo:=OB Get:C1224($ob_objeto;"tabla";Is pointer:K8:14)
		$t_nombre:=OB Get:C1224($ob_objeto;"campo";Is text:K8:3)
		OB GET ARRAY:C1229($ob_objeto;"nombres";$at_nombreCampo)
		OB GET ARRAY:C1229($ob_objeto;"campotxt";$at_nombreCampotxt)
		OB GET ARRAY:C1229($ob_objeto;"campo_puntero";$ay_Campo)
		OB GET ARRAY:C1229($ob_objeto;"seleccionado";$ab_seleccionado)
		
		READ ONLY:C145([xShell_Userfields:76])
		QUERY:C277([xShell_Userfields:76];[xShell_Userfields:76]FileNo:6=Table:C252($y_campo))
		While (Not:C34(End selection:C36([xShell_Userfields:76])))
			APPEND TO ARRAY:C911($at_nombreCampo;"["+$t_nombre+"]"+[xShell_Userfields:76]UserFieldName:1)
			APPEND TO ARRAY:C911($at_nombreCampotxt;"["+$t_nombre+"]"+[xShell_Userfields:76]UserFieldName:1)
			APPEND TO ARRAY:C911($ab_seleccionado;False:C215)
			APPEND TO ARRAY:C911($ay_Campo;$y_Nil)
			NEXT RECORD:C51([xShell_Userfields:76])
		End while 
		
		OB SET ARRAY:C1227($ob_retorno;"nombres";$at_nombreCampo)
		OB SET ARRAY:C1227($ob_retorno;"campotxt";$at_nombreCampotxt)
		OB SET ARRAY:C1227($ob_retorno;"campo_puntero";$ay_Campo)
		OB SET ARRAY:C1227($ob_retorno;"seleccionado";$ab_seleccionado)
		
End case 
If ($b_cargarArreglos)
	For ($l_field;1;Get last field number:C255($y_pointerTabla))
		$l_noTabla:=Table:C252($y_pointerTabla)
		$y_pointerCampo:=Field:C253($l_noTabla;$l_field)
		$t_nombreCampo:=Field name:C257($y_pointerCampo)
		
		QUERY:C277([xShell_Fields:52];[xShell_Fields:52]NumeroTabla:1=$l_noTabla;*)
		QUERY:C277([xShell_Fields:52]; & ;[xShell_Fields:52]NumeroCampo:2=$l_field)
		If (([xShell_Fields:52]EsImportable:13=1) | ($t_nombreCampo="Auto_UUID"))
			APPEND TO ARRAY:C911($y_arrayNombreCampo->;$t_nombreCampo)
			APPEND TO ARRAY:C911($y_arrayCampo->;$y_pointerCampo)
			
			Case of 
				: ($t_nombreCampo="RUT")
					$y_arrayNombreCampo->{Size of array:C274($y_arrayNombreCampo->)}:="Identificador Nacional"
				: ($t_nombreCampo="IDNacional_2")
					$y_arrayNombreCampo->{Size of array:C274($y_arrayNombreCampo->)}:="Identificador Nacional 2"
				: ($t_nombreCampo="IDNacional_3")
					$y_arrayNombreCampo->{Size of array:C274($y_arrayNombreCampo->)}:="Identificador Nacional 3"
			End case 
			
			Case of 
				: (Table:C252($y_pointerTabla)=Table:C252(->[Alumnos:2]))
					Case of 
						: (($t_nombreCampo="Curso") & (Not:C34(b_conexionWeb)))
							APPEND TO ARRAY:C911($y_arrayCampotxt->;"[Alumno]Curso")
						: (($t_nombreCampo="Nivel_Numero") & (Not:C34(b_conexionWeb)))
							APPEND TO ARRAY:C911($y_arrayCampotxt->;"[Alumno]Nivel_Numero")
						Else 
							APPEND TO ARRAY:C911($y_arrayCampotxt->;"[Alumno]"+$y_arrayNombreCampo->{Size of array:C274($y_arrayNombreCampo->)})
					End case 
					
				: (Table:C252($y_pointerTabla)=Table:C252(->[Personas:7]))
					Case of 
						: ($t_accion="CargaCamposMadre")
							APPEND TO ARRAY:C911($y_arrayCampotxt->;"[Madre]"+$y_arrayNombreCampo->{Size of array:C274($y_arrayNombreCampo->)})
						: ($t_accion="CargaCamposPadre")
							APPEND TO ARRAY:C911($y_arrayCampotxt->;"[Padre]"+$y_arrayNombreCampo->{Size of array:C274($y_arrayNombreCampo->)})
						: ($t_accion="CargaCamposApoderadoCuenta")
							APPEND TO ARRAY:C911($y_arrayCampotxt->;"[Apoderado de cuenta]"+$y_arrayNombreCampo->{Size of array:C274($y_arrayNombreCampo->)})
						: ($t_accion="CargaCamposApoderadoAcademico")
							APPEND TO ARRAY:C911($y_arrayCampotxt->;"[Apoderado académico]"+$y_arrayNombreCampo->{Size of array:C274($y_arrayNombreCampo->)})
					End case 
				: (Table:C252($y_pointerTabla)=Table:C252(->[Familia:78]))
					APPEND TO ARRAY:C911($y_arrayCampotxt->;"[familia]"+$y_arrayNombreCampo->{Size of array:C274($y_arrayNombreCampo->)})
				: (Table:C252($y_pointerTabla)=Table:C252(->[Alumnos_FichaMedica:13]))
					APPEND TO ARRAY:C911($y_arrayCampotxt->;"[Alumno]"+$y_arrayNombreCampo->{Size of array:C274($y_arrayNombreCampo->)})
			End case 
			
		End if 
		
	End for 
End if 
Case of 
	: ($t_accion="CargaCamposApoderadoCuenta")
		APPEND TO ARRAY:C911($y_arrayNombreCampo->;"Parentesco")
		APPEND TO ARRAY:C911($y_arrayCampo->;->vt_ParentescoApCuentas)
		APPEND TO ARRAY:C911($y_arrayCampotxt->;"[Apoderado de cuenta]"+$y_arrayNombreCampo->{Size of array:C274($y_arrayNombreCampo->)})
		
		  //carga campos propios
		OB SET:C1220($ob_objeto;"tabla";->[Personas:7])
		OB SET:C1220($ob_objeto;"campo";"Apoderado de cuentas")
		OB SET ARRAY:C1227($ob_objeto;"nombres";at_nombreCampoApoCta)
		OB SET ARRAY:C1227($ob_objeto;"campotxt";at_nombreCampoApoCtatxt)
		OB SET ARRAY:C1227($ob_objeto;"campo_puntero";ay_CampoApoCta)
		OB SET ARRAY:C1227($ob_objeto;"seleccionado";ab_seleccionadoApoCta)
		$ob_objeto:=WIZ_STR_CargaDatosEncabezadotxt ("camposPropios";$ob_objeto)
		OB GET ARRAY:C1229($ob_objeto;"nombres";at_nombreCampoApoCta)
		OB GET ARRAY:C1229($ob_objeto;"campotxt";at_nombreCampoApoCtatxt)
		OB GET ARRAY:C1229($ob_objeto;"campo_puntero";ay_CampoApoCta)
		OB GET ARRAY:C1229($ob_objeto;"seleccionado";ab_seleccionadoApoCta)
		
	: ($t_accion="CargaCamposApoderadoAcademico")
		APPEND TO ARRAY:C911($y_arrayNombreCampo->;"Parentesco")
		APPEND TO ARRAY:C911($y_arrayCampo->;->vt_ParentescoApAcademico)
		APPEND TO ARRAY:C911($y_arrayCampotxt->;"[Apoderado académico]"+$y_arrayNombreCampo->{Size of array:C274($y_arrayNombreCampo->)})
		
		  //carga campos propios
		OB SET:C1220($ob_objeto;"tabla";->[Personas:7])
		OB SET:C1220($ob_objeto;"campo";"Apoderado académico")
		OB SET ARRAY:C1227($ob_objeto;"nombres";at_nombreCampoApoAca)
		OB SET ARRAY:C1227($ob_objeto;"campotxt";at_nombreCampoApoAcatxt)
		OB SET ARRAY:C1227($ob_objeto;"campo_puntero";ay_CampoApoAca)
		OB SET ARRAY:C1227($ob_objeto;"seleccionado";ab_seleccionadoApoAca)
		$ob_objeto:=WIZ_STR_CargaDatosEncabezadotxt ("camposPropios";$ob_objeto)
		OB GET ARRAY:C1229($ob_objeto;"nombres";at_nombreCampoApoAca)
		OB GET ARRAY:C1229($ob_objeto;"campotxt";at_nombreCampoApoAcatxt)
		OB GET ARRAY:C1229($ob_objeto;"campo_puntero";ay_CampoApoAca)
		OB GET ARRAY:C1229($ob_objeto;"seleccionado";ab_seleccionadoApoAca)
		
	: ($t_accion="CargaCamposAlumno")
		  //sumo en alumnos los datos de ficha medica
		WIZ_STR_CargaDatosEncabezadotxt ("cargaFichaMedica")
		
		For ($i;1;Size of array:C274(at_nombreCampoFicha))
			APPEND TO ARRAY:C911(at_nombreCampoAlumno;at_nombreCampoFicha{$i})
			APPEND TO ARRAY:C911(at_nombreCampoAlumnotxt;at_nombreCampoFichatxt{$i})
			APPEND TO ARRAY:C911(ay_CampoAlumno;ay_CampoFicha{$i})
			APPEND TO ARRAY:C911(ab_seleccionadoAlumno;ab_seleccionadoFicha{$i})
		End for 
		
		  //MONO TICKET 198128 Apoderado de Cuentas y academico P(padre) o M(madre) para asociarlos al alumno 
		APPEND TO ARRAY:C911(at_nombreCampoAlumno;"[Alumno]Apoderado Académico")
		APPEND TO ARRAY:C911(at_nombreCampoAlumnotxt;"[Alumno]Apoderado Académico")
		APPEND TO ARRAY:C911(ay_CampoAlumno;->vt_ApoderadoAcademico)
		APPEND TO ARRAY:C911(ab_seleccionadoAlumno;True:C214)
		
		APPEND TO ARRAY:C911(at_nombreCampoAlumno;"[Alumno]Apoderado de Cuentas")
		APPEND TO ARRAY:C911(at_nombreCampoAlumnotxt;"[Alumno]Apoderado de Cuentas")
		APPEND TO ARRAY:C911(ay_CampoAlumno;->vt_ApoderadoCuentas)
		APPEND TO ARRAY:C911(ab_seleccionadoAlumno;True:C214)
		
		  //carga campos propios
		OB SET:C1220($ob_objeto;"tabla";->[Alumnos:2])
		OB SET:C1220($ob_objeto;"campo";"Alumnos")
		OB SET ARRAY:C1227($ob_objeto;"nombres";at_nombreCampoAlumno)
		OB SET ARRAY:C1227($ob_objeto;"campotxt";at_nombreCampoAlumnotxt)
		OB SET ARRAY:C1227($ob_objeto;"campo_puntero";ay_CampoAlumno)
		OB SET ARRAY:C1227($ob_objeto;"seleccionado";ab_seleccionadoAlumno)
		$ob_objeto:=WIZ_STR_CargaDatosEncabezadotxt ("camposPropios";$ob_objeto)
		OB GET ARRAY:C1229($ob_objeto;"nombres";at_nombreCampoAlumno)
		OB GET ARRAY:C1229($ob_objeto;"campotxt";at_nombreCampoAlumnotxt)
		OB GET ARRAY:C1229($ob_objeto;"campo_puntero";ay_CampoAlumno)
		OB GET ARRAY:C1229($ob_objeto;"seleccionado";ab_seleccionadoAlumno)
		
		  //
		
	: ($t_accion="CargaCamposPadre")
		
		  //carga campos propios
		OB SET:C1220($ob_objeto;"tabla";->[Personas:7])
		OB SET:C1220($ob_objeto;"campo";"Padre")
		OB SET ARRAY:C1227($ob_objeto;"nombres";at_nombreCampoPadre)
		OB SET ARRAY:C1227($ob_objeto;"campotxt";at_nombreCampoPadretxt)
		OB SET ARRAY:C1227($ob_objeto;"campo_puntero";ay_CampoPadre)
		OB SET ARRAY:C1227($ob_objeto;"seleccionado";ab_seleccionadoPadre)
		$ob_objeto:=WIZ_STR_CargaDatosEncabezadotxt ("camposPropios";$ob_objeto)
		OB GET ARRAY:C1229($ob_objeto;"nombres";at_nombreCampoPadre)
		OB GET ARRAY:C1229($ob_objeto;"campotxt";at_nombreCampoPadretxt)
		OB GET ARRAY:C1229($ob_objeto;"campo_puntero";ay_CampoPadre)
		OB GET ARRAY:C1229($ob_objeto;"seleccionado";ab_seleccionadoPadre)
		
	: ($t_accion="CargaCamposMadre")
		  //carga campos propios
		OB SET:C1220($ob_objeto;"tabla";->[Personas:7])
		OB SET:C1220($ob_objeto;"campo";"Madre")
		OB SET ARRAY:C1227($ob_objeto;"nombres";at_nombreCampoMadre)
		OB SET ARRAY:C1227($ob_objeto;"campotxt";at_nombreCampoMadretxt)
		OB SET ARRAY:C1227($ob_objeto;"campo_puntero";ay_CampoMadre)
		OB SET ARRAY:C1227($ob_objeto;"seleccionado";ab_seleccionadoMadre)
		$ob_objeto:=WIZ_STR_CargaDatosEncabezadotxt ("camposPropios";$ob_objeto)
		OB GET ARRAY:C1229($ob_objeto;"nombres";at_nombreCampoMadre)
		OB GET ARRAY:C1229($ob_objeto;"campotxt";at_nombreCampoMadretxt)
		OB GET ARRAY:C1229($ob_objeto;"campo_puntero";ay_CampoMadre)
		OB GET ARRAY:C1229($ob_objeto;"seleccionado";ab_seleccionadoMadre)
		
	: ($t_accion="CargaCamposFamilia")
		  //carga campos propios
		OB SET:C1220($ob_objeto;"tabla";->[Familia:78])
		OB SET:C1220($ob_objeto;"campo";"Familia")
		OB SET ARRAY:C1227($ob_objeto;"nombres";at_nombreCampoFamilia)
		OB SET ARRAY:C1227($ob_objeto;"campotxt";at_nombreCampoFamiliatxt)
		OB SET ARRAY:C1227($ob_objeto;"campo_puntero";ay_CampoFamilia)
		OB SET ARRAY:C1227($ob_objeto;"seleccionado";ab_seleccionadoFamilia)
		$ob_objeto:=WIZ_STR_CargaDatosEncabezadotxt ("camposPropios";$ob_objeto)
		OB GET ARRAY:C1229($ob_objeto;"nombres";at_nombreCampoFamilia)
		OB GET ARRAY:C1229($ob_objeto;"campotxt";at_nombreCampoFamiliatxt)
		OB GET ARRAY:C1229($ob_objeto;"campo_puntero";ay_CampoFamilia)
		OB GET ARRAY:C1229($ob_objeto;"seleccionado";ab_seleccionadoFamilia)
		
End case 

If ($b_cargarArreglos)
	ARRAY BOOLEAN:C223($y_arraySeleccionado->;Size of array:C274($y_arrayNombreCampo->))
End if 

$0:=$ob_retorno
