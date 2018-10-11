//%attributes = {}

  // XCR_OnRecordLoad()
  // Por: Alberto Bachler K.: 22-04-14, 17:35:58
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($1)

C_BOOLEAN:C305($b_usuarioAutorizado;$permiso)
C_LONGINT:C283($l_periodo)

If (False:C215)
	C_LONGINT:C283(XCR_OnRecordLoad ;$1)
End if 

C_LONGINT:C283(vlSTR_PaginaFormActividades)
C_BOOLEAN:C305(modXCR;$permiso;$b_modXCRCondorActivo)
C_LONGINT:C283(viBWR_RecordWasSaved)

If (vlSTR_PaginaFormActividades#0)
	
	Case of 
		: (vlSTR_PaginaFormActividades=1)
			viBWR_RecordWasSaved:=XCR_fSave 
			
		: (vlSTR_PaginaFormActividades=2)
			If (modXCR)
				XCR_SaveEval 
			End if 
			AL_UpdateArrays (xALP_ActividadesExtra;0)
			AL_RemoveArrays (xALP_ActividadesExtra;0)
			
	End case 
	SET LIST ITEM PROPERTIES:C386(hlTab_STR_Activities;1;False:C215;1;0)
	
Else 
	XCR_Before 
	viBWR_RecordWasSaved:=0
End if 

$b_usuarioAutorizado:=((<>lUSR_RelatedTableUserID=[Actividades:29]No_Profesor:3) | (<>lUSR_CurrentUserID<0))
SET LIST ITEM PROPERTIES:C386(hlTab_STR_Activities;1;(USR_checkRights ("L";->[Actividades:29]) | (<>lUSR_CurrentUserID<0));1;0)
SET LIST ITEM PROPERTIES:C386(hlTab_STR_Activities;2;(USR_checkRights ("L";->[Actividades:29]) | ($b_usuarioAutorizado));1;0)
SET LIST ITEM PROPERTIES:C386(hlTab_STR_Activities;3;False:C215;1;0)

$l_periodo:=PERIODOS_PeriodosActuales (Current date:C33(*);True:C214)
vl_PeriodoSeleccionadoActividad:=$l_periodo
vt_nomb_per_sel:=atSTR_Periodos_Nombre{vl_PeriodoSeleccionadoActividad}

If (Count parameters:C259=1)
	vlSTR_PaginaFormActividades:=$1
Else 
	If (vlSTR_PaginaFormActividades=0)
		vlSTR_PaginaFormActividades:=1
	End if 
End if 

If (Record number:C243([Alumnos:2])=-3)
	vlSTR_PaginaFormActividades:=1
End if 

If (viBWR_RecordWasSaved>=0)
	Case of 
		: (vlSTR_PaginaFormActividades=1)
			  //MONO TICKET 179875
			$b_modXCRCondorActivo:=LICENCIA_VerificaModCondorAct ("Extracurriculares")
			
			If ($b_modXCRCondorActivo)
				$permiso:=False:C215
				CD_Dlog (0;__ ("El Colegio tiene activo el módulo Web Extracurriculares. Las acciones dentro de la ficha de las actividades están bloqueadas"))
			Else 
				$permiso:=USR_checkRights ("M";->[Actividades:29])
			End if 
			
			OBJECT SET ENABLED:C1123(*;"Champ1";$permiso)
			OBJECT SET ENABLED:C1123(*;"profesorJefe";$permiso)
			OBJECT SET ENABLED:C1123(*;"desdeNivel";$permiso)
			OBJECT SET ENABLED:C1123(*;"hastaNivel";$permiso)
			OBJECT SET ENABLED:C1123(*;"restriccionSexo";$permiso)
			OBJECT SET ENABLED:C1123(*;"Champ2";$permiso)
			OBJECT SET ENABLED:C1123(*;"configuracionPeriodos";$permiso)
			OBJECT SET ENABLED:C1123(*;"seleccionAlumnos";$permiso)
			OBJECT SET ENABLED:C1123(*;"retirar";$permiso)
			OBJECT SET ENABLED:C1123(*;"inscribir";$permiso)
			
			If (USR_checkRights ("L";->[Actividades:29]))
				vl_PeriodoSeleccionadoActividad:=atSTR_Periodos_Nombre
				XCR_Before 
				FORM GOTO PAGE:C247(vlSTR_PaginaFormActividades)
			Else 
				If ((USR_checkRights ("L";->[Alumnos_Actividades:28])) | (<>lUSR_RelatedTableUserID=[Actividades:29]No_Profesor:3))
					vl_PeriodoSeleccionadoActividad:=atSTR_Periodos_Nombre
					XCR_LoadEval 
					vlSTR_PaginaFormActividades:=2
					FORM GOTO PAGE:C247(vlSTR_PaginaFormActividades)
				Else 
					CANCEL:C270
				End if 
			End if 
			
		: (vlSTR_PaginaFormActividades=2)
			If ((USR_checkRights ("L";->[Alumnos_Actividades:28])) | (<>lUSR_RelatedTableUserID=[Actividades:29]No_Profesor:3))
				vl_PeriodoSeleccionadoActividad:=atSTR_Periodos_Nombre
				XCR_LoadEval 
				FORM GOTO PAGE:C247(vlSTR_PaginaFormActividades)
			Else 
				CANCEL:C270
			End if 
		: (vlSTR_PaginaFormActividades=3)
			CD_Dlog (0;__ ("No Implementado."))
	End case 
	SELECT LIST ITEMS BY POSITION:C381(hlTab_STR_Activities;vlSTR_PaginaFormActividades)
End if 

READ ONLY:C145([Profesores:4])
RELATE ONE:C42([Actividades:29]No_Profesor:3)
If (Record number:C243([Actividades:29])=-3)
	SET WINDOW TITLE:C213(__ ("Nueva actividad"))
Else 
	SET WINDOW TITLE:C213(__ ("Actividades: ")+[Actividades:29]Nombre:2+", "+[Profesores:4]Nombre_comun:21)
End if 

