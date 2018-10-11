//%attributes = {}
  // dhBWR_OnSaveRecord()
  // Por: Alberto Bachler: 17/09/13, 13:38:30
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($0)
C_POINTER:C301($1)

C_BOOLEAN:C305($b_EventoEjecutado)
C_POINTER:C301($y_tabla)

If (False:C215)
	C_BOOLEAN:C305(dhBWR_OnSaveRecord ;$0)
	C_POINTER:C301(dhBWR_OnSaveRecord ;$1)
End if 

If ("INSTRUCCIONES"="")
	  //llamado desde: BWR_OnSaveRecord
	  //utilizar para desviar el procesamiento estandar del evento en xShell
	  //En el Case of poner las instrucciones necesarias para procesar el evento para cada tabla en que se requiera
	  //Asignar True a $b_EventoEjecutado si el evento es procesado
End if 

If (Count parameters:C259=1)
	$y_tabla:=$1
Else 
	$y_tabla:=yBWR_currentTable
End if 
$b_EventoEjecutado:=False:C215

Case of 
	: (Table:C252($y_tabla)=Table:C252(->[Alumnos:2]))
		Case of 
			: (vlSTR_PaginaFormAlumnos=1)
				viBWR_RecordWasSaved:=AL_fSave 
			: (vlSTR_PaginaFormAlumnos=2)
				viBWR_RecordWasSaved:=AL_fSaveCdta 
			: (vlSTR_PaginaFormAlumnos=5)
				viBWR_RecordWasSaved:=AL_fSaveSalud 
			: (vlSTR_PaginaFormAlumnos=6)
				
			: (vlSTR_PaginaFormAlumnos=7)
				viBWR_RecordWasSaved:=AL_fSave 
			: (vlSTR_PaginaFormAlumnos=9)
				viBWR_RecordWasSaved:=KRL_SaveRecord (->[Familia:78])
				KRL_ReloadAsReadOnly (->[Familia:78])
			: (vlSTR_PaginaFormAlumnos=10)
				viBWR_RecordWasSaved:=KRL_SaveRecord (->[Alumnos_Historico:25])
			: (vlSTR_PaginaFormAlumnos=11)
				viBWR_RecordWasSaved:=KRL_SaveRecord (->[Alumnos_ResultadosEgreso:130])
		End case 
		$b_EventoEjecutado:=True:C214
		
	: (Table:C252($y_tabla)=Table:C252(->[Cursos:3]))
		Case of 
			: (vlSTR_PaginaFormCursos=7)
				If ([Cursos:3]ActaEspecificaAlCurso:35)
					vi_PrintCodes:=(OBJECT Get pointer:C1124(Object named:K67:5;"acta.imprimirAbreviaturas"))->
					vi_UppercaseNames:=(OBJECT Get pointer:C1124(Object named:K67:5;"acta.apellidosEnAltas"))->
					vi_EtiquetasEnAltas:=(OBJECT Get pointer:C1124(Object named:K67:5;"acta.etiquetasEnAltas"))->
					vi_FirmaDirectorNivel:=(OBJECT Get pointer:C1124(Object named:K67:5;"acta.firmaDirectorNivel"))->
					vi_FirmaDirectorColegio:=(OBJECT Get pointer:C1124(Object named:K67:5;"acta.firmaDirectorColegio"))->
					ACTAS_GuardaConfiguracion ([Cursos:3]Nivel_Numero:7;[Cursos:3]Curso:1)
				End if 
				
			: (vlSTR_PaginaFormCursos=3)
				viBWR_RecordWasSaved:=CU_fSaveEvVal 
			Else 
				viBWR_RecordWasSaved:=CU_fSave 
		End case 
		$b_EventoEjecutado:=True:C214
		
	: (Table:C252($y_tabla)=Table:C252(->[Profesores:4]))
		viBWR_RecordWasSaved:=PF_fSave 
		$b_EventoEjecutado:=True:C214
		
	: (Table:C252($y_tabla)=Table:C252(->[Personas:7]))
		viBWR_RecordWasSaved:=PP_fSave 
		$b_EventoEjecutado:=True:C214
		
	: (Table:C252($y_tabla)=Table:C252(->[Asignaturas:18]))
		viBWR_RecordWasSaved:=AS_fSave 
		$b_EventoEjecutado:=True:C214
		
	: (Table:C252($y_tabla)=Table:C252(->[Actividades:29]))
		viBWR_RecordWasSaved:=XCR_fSave 
		$b_EventoEjecutado:=True:C214
		
	: (Table:C252($y_tabla)=Table:C252(->[BBL_Items:61]))
		viBWR_RecordWasSaved:=BBL_dcSave 
		$b_EventoEjecutado:=True:C214
		
	: (Table:C252($y_tabla)=Table:C252(->[BBL_Registros:66]))
		viBWR_RecordWasSaved:=BBLreg_guardar 
		$b_EventoEjecutado:=True:C214
		
	: (Table:C252($y_tabla)=Table:C252(->[BBL_Lectores:72]))
		viBWR_RecordWasSaved:=BBLpat_fSave 
		$b_EventoEjecutado:=True:C214
		
	: (Table:C252($y_tabla)=Table:C252(->[BBL_Subscripciones:117]))
		viBWR_RecordWasSaved:=BBLss_fSave 
		$b_EventoEjecutado:=True:C214
		
	: (Table:C252($y_tabla)=Table:C252(->[Familia:78]))
		viBWR_RecordWasSaved:=FM_fSave 
		$b_EventoEjecutado:=True:C214
		
	: (Table:C252($y_tabla)=Table:C252(->[ACT_CuentasCorrientes:175]))
		viBWR_RecordWasSaved:=ACTcc_fSave 
		$b_EventoEjecutado:=True:C214
		
	: (Table:C252($y_tabla)=Table:C252(->[ADT_Candidatos:49]))
		viBWR_RecordWasSaved:=ADTcdd_fSave 
		$b_EventoEjecutado:=True:C214
		
	: (Table:C252($y_tabla)=Table:C252(->[ACT_Pagos:172]))
		viBWR_RecordWasSaved:=ACTpgs_fSave 
		$b_EventoEjecutado:=True:C214
		
	: (Table:C252($y_tabla)=Table:C252(->[ACT_Documentos_en_Cartera:182]))
		viBWR_RecordWasSaved:=ACTpgs_fSave 
		$b_EventoEjecutado:=True:C214
		
	: (Table:C252($y_tabla)=Table:C252(->[ACT_Documentos_de_Pago:176]))  //docs. depositados
		viBWR_RecordWasSaved:=ACTpgs_fSave 
		$b_EventoEjecutado:=True:C214
		
	: (Table:C252($y_tabla)=Table:C252(->[ADT_Contactos:95]))
		viBWR_RecordWasSaved:=ADTcon_fSave 
		$b_EventoEjecutado:=True:C214
		
	: (Table:C252($y_tabla)=Table:C252(->[ACT_Terceros:138]))
		viBWR_RecordWasSaved:=ACTter_fSave 
		$b_EventoEjecutado:=True:C214
		
	: (Table:C252($y_tabla)=Table:C252(->[ACT_Pagares:184]))
		viBWR_RecordWasSaved:=ACTpagares_fSave 
		$b_EventoEjecutado:=True:C214
		
End case 

$0:=$b_EventoEjecutado