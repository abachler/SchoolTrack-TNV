//%attributes = {}
  // SRP_FijaDiseñoPorOmision()
  //
  //
  // creado por: Alberto Bachler Klein: 10-04-16, 13:02:25
  // -----------------------------------------------------------
C_LONGINT:C283($i;$l_altoPagina;$l_bordeInferior;$l_idSeccion_body;$l_idSeccion_Footer;$l_idSeccion_header;$l_idSeccion_Total;$l_idSeccion1;$l_idSeccion2;$l_idSeccion3)
C_LONGINT:C283($l_idSeccion4;$l_margenInferior;$l_margenSuperior;$l_refDataSource)
C_TEXT:C284($t_script;$t_tipoSeccion)

ARRAY LONGINT:C221($al_idObjetosSRP;0)

Case of 
	: (vlQR_SRMainTable=(Table:C252(->[ACT_Boletas:181])*-1))
		$l_altoPagina:=SR_GetLongProperty (xReportData;1;SRP_Report_PageHeight)
		$l_margenInferior:=SR_GetLongProperty (xReportData;1;SRP_Report_MarginBottom)
		$l_margenSuperior:=SR_GetLongProperty (xReportData;1;SRP_Report_MarginTop)
		$l_bordeInferior:=$l_altoPagina-$l_margenInferior-$l_margenSuperior-10
		  // obtengo los id de las secciones
		SR_GetObjects (xReportData;1;SRP_ReportSections;$al_idObjetosSRP)
		For ($i;1;Size of array:C274($al_idObjetosSRP))
			$t_tipoSeccion:=SR_GetTextProperty (xReportData;$al_idObjetosSRP{$i};SRP_Section_Type)
			Case of 
				: ($t_tipoSeccion=SRP_SectionType_Header)
					$l_idSeccion_header:=$al_idObjetosSRP{$i}
				: ($t_tipoSeccion=SRP_SectionType_Body)
					$l_idSeccion_body:=$al_idObjetosSRP{$i}
				: ($t_tipoSeccion=SRP_SectionType_BreakFooter)
					$l_idSeccion_Total:=$al_idObjetosSRP{$i}
				: ($t_tipoSeccion=SRP_SectionType_Footer)
					$l_idSeccion_Footer:=$al_idObjetosSRP{$i}
			End case 
		End for 
		  // asigno la posición de la seccion encabezado principal
		SR_SetLongProperty (xReportData;$l_idSeccion_header;SRP_Section_Height;0)
		SR_SetLongProperty (xReportData;$l_idSeccion_header;SRP_Section_LabelPos;50)
		
		  // creacion de secciones según numero de documentos por pagina
		Case of 
			: (vlSR_RegXPagina=4)
				$l_idSeccion1:=SRP_CreaSeccion (xReportData;SRP_BreakHeader;__ ("Primer documento");$l_bordeInferior/4;100)
				$l_idSeccion2:=SRP_CreaSeccion (xReportData;SRP_BreakHeader;__ ("Segundo documento");$l_bordeInferior/4;100)
				$l_idSeccion3:=SRP_CreaSeccion (xReportData;SRP_BreakHeader;__ ("Tercer documento");$l_bordeInferior/4;100)
				$l_idSeccion4:=SRP_CreaSeccion (xReportData;SRP_BreakHeader;__ ("Cuarto documento");$l_bordeInferior/4;100)
			: (vlSR_RegXPagina=3)
				$l_idSeccion1:=SRP_CreaSeccion (xReportData;SRP_BreakHeader;__ ("Primer documento");$l_bordeInferior/3;100)
				$l_idSeccion2:=SRP_CreaSeccion (xReportData;SRP_BreakHeader;__ ("Segundo documento");$l_bordeInferior/3;100)
				$l_idSeccion3:=SRP_CreaSeccion (xReportData;SRP_BreakHeader;__ ("Tercer documento");$l_bordeInferior/3;100)
			: (vlSR_RegXPagina=2)
				$l_idSeccion1:=SRP_CreaSeccion (xReportData;SRP_BreakHeader;__ ("Primer documento");$l_bordeInferior/2;100)
				$l_idSeccion2:=SRP_CreaSeccion (xReportData;SRP_BreakHeader;__ ("Segundo documento");$l_bordeInferior/2;100)
			: (vlSR_RegXPagina=1)
				$l_idSeccion1:=SRP_CreaSeccion (xReportData;SRP_BreakHeader;__ ("Primer documento");$l_bordeInferior/1;100)
		End case 
		  // fijo la posición de las demás secciones (cuerpo, total y pie)
		SR_SetLongProperty (xReportData;$l_idSeccion_body;SRP_Section_Height;0)
		SR_SetLongProperty (xReportData;$l_idSeccion_body;SRP_Section_LabelPos;500)
		SR_SetLongProperty (xReportData;$l_idSeccion_Total;SRP_Section_Height;0)
		SR_SetLongProperty (xReportData;$l_idSeccion_Total;SRP_Section_LabelPos;550)
		SR_SetLongProperty (xReportData;$l_idSeccion_Footer;SRP_Section_Height;0)
		SR_SetLongProperty (xReportData;$l_idSeccion_Footer;SRP_Section_LabelPos;600)
		
		
	: (vlQR_SRMainTable=Table:C252(->[ACT_Boletas:181]))
		  // obtengo el id del objeto Datasource
		$l_refDataSource:=SR_GetLongProperty (xReportData;1;SRP_DataSource)
		  //Asigno los scripts necesarios al objeto DataSource
		SR_SetTextProperty (xReportData;$l_refDataSource;SRP_DataSource_StartScript;"SRACTbol_CargaCargos")
		SR_SetTextProperty (xReportData;$l_refDataSource;SRP_DataSource_EndScript;"SRACTbol_Endboleta")
		
		
	: (vlQR_SRMainTable=(Table:C252(->[ACT_Avisos_de_Cobranza:124])*-1))
		$l_altoPagina:=SR_GetLongProperty (xReportData;1;SRP_Report_PageHeight)
		$l_margenInferior:=SR_GetLongProperty (xReportData;1;SRP_Report_MarginBottom)
		$l_margenSuperior:=SR_GetLongProperty (xReportData;1;SRP_Report_MarginTop)
		$l_bordeInferior:=$l_altoPagina-$l_margenInferior-$l_margenSuperior-10
		
		  // obtengo los id de las secciones
		SR_GetObjects (xReportData;1;SRP_ReportSections;$al_idObjetosSRP)
		For ($i;1;Size of array:C274($al_idObjetosSRP))
			$t_tipoSeccion:=SR_GetTextProperty (xReportData;$al_idObjetosSRP{$i};SRP_Section_Type)
			Case of 
				: ($t_tipoSeccion=SRP_SectionType_Header)
					$l_idSeccion_header:=$al_idObjetosSRP{$i}
				: ($t_tipoSeccion=SRP_SectionType_Body)
					$l_idSeccion_body:=$al_idObjetosSRP{$i}
				: ($t_tipoSeccion=SRP_SectionType_BreakFooter)
					$l_idSeccion_Total:=$al_idObjetosSRP{$i}
				: ($t_tipoSeccion=SRP_SectionType_Footer)
					$l_idSeccion_Footer:=$al_idObjetosSRP{$i}
			End case 
		End for 
		  // asigno la posición de la seccion encabezado principal
		SR_SetLongProperty (xReportData;$l_idSeccion_header;SRP_Section_Height;0)
		SR_SetLongProperty (xReportData;$l_idSeccion_header;SRP_Section_LabelPos;50)
		
		  // creacion de secciones según numero de documentos por pagina
		Case of 
			: (vlSR_RegXPagina=4)
				$l_idSeccion1:=SRP_CreaSeccion (xReportData;SRP_BreakHeader;__ ("Primer aviso de cobranza");$l_bordeInferior/4;100)
				$l_idSeccion2:=SRP_CreaSeccion (xReportData;SRP_BreakHeader;__ ("Segundo aviso de cobranza");$l_bordeInferior/4;100)
				$l_idSeccion3:=SRP_CreaSeccion (xReportData;SRP_BreakHeader;__ ("Tercer aviso de cobranza");$l_bordeInferior/4;100)
				$l_idSeccion4:=SRP_CreaSeccion (xReportData;SRP_BreakHeader;__ ("Cuarto aviso de cobranza");$l_bordeInferior/4;100)
			: (vlSR_RegXPagina=3)
				$l_idSeccion1:=SRP_CreaSeccion (xReportData;SRP_BreakHeader;__ ("Primer aviso de cobranza");$l_bordeInferior/3;100)
				$l_idSeccion2:=SRP_CreaSeccion (xReportData;SRP_BreakHeader;__ ("Segundo aviso de cobranza");$l_bordeInferior/3;100)
				$l_idSeccion3:=SRP_CreaSeccion (xReportData;SRP_BreakHeader;__ ("Tercer aviso de cobranza");$l_bordeInferior/3;100)
			: (vlSR_RegXPagina=2)
				$l_idSeccion1:=SRP_CreaSeccion (xReportData;SRP_BreakHeader;__ ("Primer aviso de cobranza");$l_bordeInferior/2;100)
				$l_idSeccion2:=SRP_CreaSeccion (xReportData;SRP_BreakHeader;__ ("Segundo aviso de cobranza");$l_bordeInferior/2;100)
			: (vlSR_RegXPagina=1)
				$l_idSeccion1:=SRP_CreaSeccion (xReportData;SRP_BreakHeader;__ ("Primer aviso de cobranza");$l_bordeInferior/1;100)
		End case 
		  // fijo la posición de las dema´s secciones (cuerpo, total y pie)
		SR_SetLongProperty (xReportData;$l_idSeccion_body;SRP_Section_Height;0)
		SR_SetLongProperty (xReportData;$l_idSeccion_body;SRP_Section_LabelPos;500)
		SR_SetLongProperty (xReportData;$l_idSeccion_Total;SRP_Section_Height;0)
		SR_SetLongProperty (xReportData;$l_idSeccion_Total;SRP_Section_LabelPos;550)
		SR_SetLongProperty (xReportData;$l_idSeccion_Footer;SRP_Section_Height;0)
		SR_SetLongProperty (xReportData;$l_idSeccion_Footer;SRP_Section_LabelPos;600)
		
		  // obtengo el id del objeto Datasource
		$l_refDataSource:=SR_GetLongProperty (xReportData;1;SRP_DataSource)
		  //Asigno los scripts necesarios al objeto DataSource
		$t_script:="vEtiquetaColGlosa:=\"Glosa\"\rvEtiquetaColCta:=\"Cuenta Corriente\"\rvEtiquetaColCurso:=\"Curso\"\rvEtiquetaColNivel:=\"Nivel\"\rvEtiquetaColMonto:=\"Monto\"\rvEtiquetaColAfecto:=\"Afecto a IVA\""
		SR_SetTextProperty (xReportData;$l_refDataSource;SRP_DataSource_StartScript;$t_script)
		
		
		
		
	: (vlQR_SRMainTable=Table:C252(->[ACT_Avisos_de_Cobranza:124]))
		  // obtengo el id del objeto DataSource
		$l_refDataSource:=SR_GetLongProperty (xReportData;1;SRP_DataSource)
		  //Asigno los scripts necesarios al objeto DataSource
		$t_script:="SRACTac_InitPrintingVariables\rSRACTac_CargaCargos\rvEtiquetaColGlosa:=\"Glosa\"\rvEtiquetaColCta:=\"Cuenta Corriente\"\rvEtiquetaColCurso:=\"Curso\"\rvEtiquetaColNivel:=\"Nivel\"\rvEtiquetaColMonto:=\"Monto\"\rvEtiquetaColAfecto:=\"Afecto a IVA\""
		SR_SetTextProperty (xReportData;$l_refDataSource;SRP_DataSource_StartScript;$t_script)
		SR_SetTextProperty (xReportData;$l_refDataSource;SRP_DataSource_EndScript;"SRACTac_EndAviso")
End case 