//%attributes = {}
  //dhBWR_LoadLists

If (Count parameters:C259=1)
	$currentModule:=$1
Else 
	$currentModule:=vsBWR_CurrentModule
End if 
Case of 
	: ($currentModule="SchoolTrack")
		hlTab_STR_Alumnos:=AT_Array2ReferencedList (-><>atSTR_PaginaAlumnos;-><>alSTR_PaginaAlumnosRefs;0;False:C215;True:C214)
		hlTab_STR_Familias:=AT_Array2ReferencedList (-><>atSTR_PaginaFamilias;-><>alSTR_PaginaFamilias;0;False:C215;True:C214)
		hlTab_STR_Cursos:=AT_Array2ReferencedList (-><>atSTR_PaginaCursos;-><>alSTR_PaginaCursos;0;False:C215;True:C214)
		hlTab_STR_Profesores:=AT_Array2ReferencedList (-><>atSTR_PaginaProfesores;-><>alSTR_PaginaProfesores;0;False:C215;True:C214)
		hlTab_STR_Asignaturas:=AT_Array2ReferencedList (-><>atSTR_PaginaAsignaturas;-><>alSTR_PaginaAsignaturas;0;False:C215;True:C214)
		hlTab_STR_Activities:=AT_Array2ReferencedList (-><>atSTR_PaginaActividades;-><>alSTR_PaginaActividades;0;False:C215;True:C214)
		hlTab_STR_Personas:=AT_Array2ReferencedList (-><>atSTR_PaginaPersonas;-><>alSTR_PaginaPersonas;0;False:C215;True:C214)
		hlTab_STR_alumnosHistorico:=AT_Array2ReferencedList (-><>atSTR_PaginaAlHistorico;-><>alSTR_PaginaAlHistorico;0;False:C215;True:C214)
		hlTab_STR_alumnosComentarios:=AT_Array2ReferencedList (-><>atSTR_PaginaAlComentarios;-><>alSTR_PaginaAlComentarios;0;False:C215;True:C214)
		vltab_Conducta:=AT_Array2ReferencedList (-><>atSTR_PaginaAlConducta;-><>alSTR_PaginaAlConducta;0;False:C215;True:C214)
		
		hl_PaginasConductaAsistencia:=AT_Array2ReferencedList (-><>atSTR_CFGConducta;-><>alSTR_CFGConducta;0;False:C215;True:C214)
		hl_PaginasNiveles:=AT_Array2ReferencedList (-><>atSTR_CFGNiveles;-><>alSTR_CFGNiveles;0;False:C215;True:C214)
		hl_ModoPromedioInterno:=AT_Array2ReferencedList (-><>atSTR_ModoCalcPromGrales;-><>alSTR_ModoCalcPromGrales;0;False:C215;True:C214)
		hl_ModoPromedioOficial:=AT_Array2ReferencedList (-><>atSTR_ModoCalcPromGrales;-><>alSTR_ModoCalcPromGrales;0;False:C215;True:C214)
		hl_PaginasOpciones:=AT_Array2ReferencedList (-><>atSTR_OpcionesCalcAprendizajes;-><>alSTR_OpcionesCalcAprendizajes;0;False:C215;True:C214)
		hl_paginasColegio:=AT_Array2ReferencedList (-><>atSTR_PaginasColegio;-><>alSTR_PaginasColegio;0;False:C215;True:C214)
		hl_configPeriodos:=AT_Array2ReferencedList (-><>atSTR_PaginasConfPeriodos;-><>alSTR_PaginasConfPeriodos;0;False:C215;True:C214)
		tabSalud:=AT_Array2ReferencedList (-><>atSTR_PaginaSalud;-><>alSTR_PaginaSalud;0;False:C215;True:C214)
		hl_TipoPeriodos:=AT_Array2ReferencedList (-><>atSTR_PeriodosExtendidos;-><>alSTR_PeriodosExtendidos;0;False:C215;True:C214)
		
		hlTab_STR_Tutorias:=AT_Array2ReferencedList (-><>atSTR_Tutorias;-><>alSTR_Tutorias;0;False:C215;True:C214)
		vTab_Programas:=AT_Array2ReferencedList (-><>atSTR_TabPlanes;-><>alSTR_TabPlanes;0;False:C215;True:C214)
		
		aHL_schedule:=AT_Array2ReferencedList (-><>atCT_UPD_Intervalos;-><>alCT_UPD_Intervalos;0;False:C215;True:C214)  //commtrack intervalos de actualización
		
		
		Case of 
			: (<>vtXS_CountryCode#"cl")
				DELETE FROM LIST:C624(hlTab_STR_Cursos;7)
				DELETE FROM LIST:C624(hlTab_STR_Cursos;8)
		End case 
		
		
		
	: ($currentModule="AccountTrack")
		hlTab_STR_Personas:=AT_Array2ReferencedList (-><>atACT_PaginaPersonas;-><>alACT_PaginaPersonas;0;False:C215;True:C214)
		hlTab_ACT_CuentaCorriente:=AT_Array2ReferencedList (-><>atACT_PaginaCuentas;-><>alACT_PaginaCuentas;0;False:C215;True:C214)
		hlTab_STR_Familias:=AT_Array2ReferencedList (-><>atSTR_PaginaFamilias;-><>alSTR_PaginaFamilias;0;False:C215;True:C214)
		hlTab_ACT_Transacciones:=AT_Array2ReferencedList (-><>atACT_TipoTransacciones;-><>alACT_TipoTransacciones;0;False:C215;True:C214)
		HLTAB_ACTpp_Asociados:=AT_Array2ReferencedList (-><>atACT_AsociadosApdos;-><>alACT_AsociadosApdos;0;False:C215;True:C214)
		HLTAB_ACTcc_Asociados:=AT_Array2ReferencedList (-><>atACT_AsociadosCtas;-><>alACT_AsociadosCtas;0;False:C215;True:C214)
		
		  //20160720 RCH
		HLTAB_ACTcc_Dctos:=AT_Array2ReferencedList (-><>atACT_DctosCtas;-><>alACT_DctosCtas;0;False:C215;True:C214)
		
		hlTab_ACT_Terceros:=AT_Array2ReferencedList (-><>atACT_PaginaTerceros;-><>alACT_PaginaTerceros;0;False:C215;True:C214)
		hlTab_ACT_TercerosGen:=AT_Array2ReferencedList (-><>atACT_PaginaTercerosGen;-><>alACT_PaginaTercerosGen;0;False:C215;True:C214)
		hl_ACT_cfgDocTrib:=AT_Array2ReferencedList (-><>atACT_ConfigBoletas;-><>alACT_ConfigBoletas;0;False:C215;True:C214)
		vlACT_ConfigGenerales:=AT_Array2ReferencedList (-><>atACT_PaginaConfigGrales;-><>alACT_PaginaConfigGrales;0;False:C215;True:C214)
		vlACTcfg_Recargos:=AT_Array2ReferencedList (-><>atACT_ConfigRecargos;-><>alACT_ConfigRecargos;0;False:C215;True:C214)
		hl_PaginasBolSub:=AT_Array2ReferencedList (-><>atACT_ConfigSubvencionados;-><>alACT_ConfigSubvencionados;0;False:C215;True:C214)
		hl_DatosBol:=AT_Array2ReferencedList (-><>atACT_PaginaBoletas;-><>alACT_PaginaBoletas;0;False:C215;True:C214)
		hlTab_STR_Pagares:=AT_Array2ReferencedList (-><>atACT_PaginaPagares;-><>alACT_PaginaPagares;0;False:C215;True:C214)
		
	: ($currentModule="MediaTrack")
		hlTab_BBL_items:=AT_Array2ReferencedList (-><>atBBL_PaginaItems;-><>alBBL_PaginaItems;0;False:C215;True:C214)
		hlTab_BBL_usersBiblio:=AT_Array2ReferencedList (-><>atBBL_PaginaLectores;-><>alBBL_PaginaLectores;0;False:C215;True:C214)
		hlTab_BBL_AlphaThesaurus:=AT_Array2ReferencedList (-><>atBBL_Alfabeto;-><>alBBL_Alfabeto;0;False:C215;True:C214)
		hlTab_BBL_SpecialQF:=AT_Array2ReferencedList (-><>atBBL_PaginaQF;-><>alBBL_PaginaQF;0;False:C215;True:C214)
		
		
		
	: ($currentModule="AdmissionTrack")
		hlTab_ADT_Postulantes:=AT_Array2ReferencedList (-><>atADT_PaginaPostulantes;-><>alADT_PaginaPostulantes;0;False:C215;True:C214)
		hlTab_STR_Profesores:=AT_Array2ReferencedList (-><>atADT_Entrevistadores;-><>alADT_Entrevistadores;0;False:C215;True:C214)
		hlTab_STR_Personas:=AT_Array2ReferencedList (-><>atSTR_PaginaPersonas;-><>alSTR_PaginaPersonas;0;False:C215;True:C214)
		vl_TabMetaDatos:=AT_Array2ReferencedList (-><>atADT_MetaDatos;-><>alADT_MetaDatos;0;False:C215;True:C214)
End case 