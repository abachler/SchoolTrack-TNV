//%attributes = {}
  // dhBWR_PanelSettings()
  // 
  //
  // creado por: Alberto Bachler Klein: 28-12-15, 16:41:26
  // -----------------------------------------------------------


C_BOOLEAN:C305($b_ajustesConsolidables;$b_ajustesNoPromediables)
C_LONGINT:C283($i;$i_alumnos;$i_asignaturas;$j;$l_posicion;$l_nivelJerarquico;$recs)
C_POINTER:C301($y_arreglo)
C_POINTER:C301($arrPointer_AbrevAsignatura;$arrPointer_Consolidantes;$arrPointer_NombreAsignatura;$arrPointer_Promediable)


Case of 
	: (vsBWR_CurrentModule="SchoolTrack")
		Case of 
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[Alumnos:2]))
				STRal_OnExplorerLoad 
				
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[Personas:7]))
				STRpp_OnExplorerLoad (ayBWR_ArrayPointers{$i})
				
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[Profesores:4]))
				STRpf_OnExplorerLoad 
				
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[Asignaturas:18]))
				STRas_OnExplorerLoad 
		End case 
		  //
		
	: (vsBWR_CurrentModule="AccountTrack")
		Case of 
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Pagos:172]))
				ACTpgs_OnExplorerLoad 
				
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_CuentasCorrientes:175]))
				ACTcc_OnExplorerLoad 
				
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[Personas:7]))
				ACTpp_OnExplorerLoad 
				
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Terceros:138]))
				ACTter_OnExplorerLoad 
				
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Boletas:181]))
				ACTbol_OnExplorerLoad 
				
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Avisos_de_Cobranza:124]))
				ACTac_OnExplorerLoad 
				
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Documentos_en_Cartera:182]))
				ACTdc_OnExplorerLoad (xALP_Browser;->alBWR_recordNumber)
				
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Documentos_de_Pago:176]))
				ACTdp_OnExplorerLoad 
				
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Pagares:184]))
				ACTpagares_OnExplorerLoad 
				
		End case 
		  //
		
	: (vsBWR_CurrentModule="AdmissionTrack")
		Case of 
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ADT_Candidatos:49]))
				ADTcdd_OnExplorerLoad 
				
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[Profesores:4]))
				ACTpf_OnExplorerLoad 
		End case 
		
	: (vsBWR_CurrentModule="MediaTrack")
		Case of 
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[Alumnos:2]))
				BBLusr_OnExplorerLoad 
		End case 
		
End case 

