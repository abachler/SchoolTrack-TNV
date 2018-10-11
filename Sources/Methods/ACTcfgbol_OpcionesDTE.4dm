//%attributes = {}
  //ACTcfgbol_OpcionesDTE

C_TEXT:C284($vt_accion;$1)
C_POINTER:C301(${2})
C_POINTER:C301($vy_pointer1)
C_LONGINT:C283($vl_idRS)

$vt_accion:=$1
If (Count parameters:C259>=2)
	$vy_pointer1:=$2
End if 

Case of 
	: ($vt_accion="OnLoadForm")
		C_LONGINT:C283(hlACT_confDTE)
		C_TEXT:C284(vtACTcaf_Nombre)
		C_LONGINT:C283(cs_certificacion)
		
		hlACT_confDTE:=New list:C375
		APPEND TO LIST:C376(hlACT_confDTE;"Configuración";1)
		APPEND TO LIST:C376(hlACT_confDTE;"CAF";2)
		APPEND TO LIST:C376(hlACT_confDTE;"Alertas";3)
		APPEND TO LIST:C376(hlACT_confDTE;"Opciones";4)
		APPEND TO LIST:C376(hlACT_confDTE;"Impresión";5)
		
		REDUCE SELECTION:C351([Profesores:4];0)
		vtACTcaf_Nombre:=KRL_GetTextFieldData (->[Profesores:4]Numero:1;->[ACT_RazonesSociales:279]encargadoDTE_id:31;->[Profesores:4]Apellidos_y_nombres:28)
		ACTcfgbol_OpcionesDTE ("CargaArreglosCAF";->[ACT_RazonesSociales:279]id:1)
		
		ACTcfg_opcionesDTE ("OnLoadConf")
		
		C_LONGINT:C283(vlACTdte_MesIEV;vlACTdte_YearIEV;vlACTdte_MesIEC;vlACTdte_YearIEC)
		C_TEXT:C284(vtACTdte_MesIEV;vtACTdte_MesIEC)
		  // ventas
		vlACTdte_MesIEV:=Month of:C24(Current date:C33(*))
		vlACTdte_YearIEV:=Year of:C25(Current date:C33(*))
		vtACTdte_MesIEV:=<>atXS_MonthNames{vlACTdte_MesIEV}
		  // compras
		vlACTdte_MesIEC:=vlACTdte_MesIEV
		vlACTdte_YearIEC:=vlACTdte_YearIEV
		vtACTdte_MesIEC:=vtACTdte_MesIEV
		
		SELECT LIST ITEMS BY POSITION:C381(hlACT_confDTE;1)
		ACTcfgbol_OpcionesDTE ("SetVisibleConf")
		
		cs_certificacion:=1
		cs_certificacion:=Num:C11(PREF_fGet (0;"ACT_AMBIENTE_CERTIFICACION_SII";String:C10(cs_certificacion)))
		
	: ($vt_accion="DeclaraArreglosCAF")
		ARRAY LONGINT:C221(alACT_idCAF;0)
		ARRAY TEXT:C222(atACT_CAFestado;0)
		ARRAY LONGINT:C221(alACT_CAFdesde;0)
		ARRAY LONGINT:C221(alACT_CAFhasta;0)
		ARRAY LONGINT:C221(alACT_CAFdisponible;0)
		ARRAY TEXT:C222(atACT_CAFtipoDoc;0)
		
	: ($vt_accion="CargaArreglosCAF")
		ACTcfgbol_OpcionesDTE ("DeclaraArreglosCAF")
		ARRAY LONGINT:C221($al_id;0)
		ARRAY LONGINT:C221($al_idEstado;0)
		ARRAY LONGINT:C221($al_idTipoSII;0)
		
		READ ONLY:C145([ACT_FoliosDT:293])
		
		$vl_idRS:=$vy_pointer1->
		
		  //ALL RECORDS([ACT_FoliosDT])
		QUERY:C277([ACT_FoliosDT:293];[ACT_FoliosDT:293]id_razonSocial:8=$vl_idRS)
		ORDER BY:C49([ACT_FoliosDT:293];[ACT_FoliosDT:293]estado:3;>;[ACT_FoliosDT:293]tipo_dteSII:7;>;[ACT_FoliosDT:293]desde:4;>)
		SELECTION TO ARRAY:C260([ACT_FoliosDT:293]id:1;alACT_idCAF;[ACT_FoliosDT:293]estado:3;$al_idEstado;[ACT_FoliosDT:293]desde:4;alACT_CAFdesde;[ACT_FoliosDT:293]hasta:5;alACT_CAFhasta;[ACT_FoliosDT:293]folio_disponible:6;alACT_CAFdisponible;[ACT_FoliosDT:293]tipo_dteSII:7;$al_idTipoSII)
		
		For ($i;1;Size of array:C274(alACT_idCAF))
			  //20180117 RCH
			  //If ($al_idEstado{$i}=1)
			  //APPEND TO ARRAY(atACT_CAFestado;__ ("Disponible"))
			  //Else 
			  //APPEND TO ARRAY(atACT_CAFestado;__ ("Consumido"))
			  //End if 
			Case of 
				: ($al_idEstado{$i}=1)
					APPEND TO ARRAY:C911(atACT_CAFestado;__ ("Disponible"))
				: ($al_idEstado{$i}=3)
					APPEND TO ARRAY:C911(atACT_CAFestado;__ ("Vencido"))
				Else 
					APPEND TO ARRAY:C911(atACT_CAFestado;__ ("Consumido"))
			End case 
			APPEND TO ARRAY:C911(atACT_CAFtipoDoc;String:C10($al_idTipoSII{$i})+": "+ACTdte_GeneraArchivo ("RetornaNombreCatDesdeIDSII";->$al_idTipoSII{$i}))
		End for 
		
	: ($vt_accion="SetVisibleConf")
		C_LONGINT:C283($vl_ref)
		C_TEXT:C284($vt_text)
		GET LIST ITEM:C378(hlACT_confDTE;Selected list items:C379(hlACT_confDTE);$vl_ref;$vt_text)
		OBJECT SET VISIBLE:C603(*;"proveeColegium@";False:C215)
		If (at_proveedores{at_proveedores}="Colegium")
			OBJECT SET VISIBLE:C603(*;"proveeColegium";True:C214)
			OBJECT SET VISIBLE:C603(*;"proveeColegium0";True:C214)  //20150202 RCH para dejar visible siempre la variable ambiente certificación
			OBJECT SET VISIBLE:C603(*;"proveeColegium0_"+String:C10($vl_ref)+"@";True:C214)
		End if 
		If (cs_emitirCFDI=1)
			OBJECT SET ENABLED:C1123(*;"proveeColegium@";True:C214)
		Else 
			OBJECT SET ENABLED:C1123(*;"proveeColegium@";False:C215)
		End if 
		
	: ($vt_accion="ValidaInicioEmisionMasiva")
		READ ONLY:C145([ACT_RazonesSociales:279])
		$vl_idRS:=$vy_pointer1->
		REDUCE SELECTION:C351([ACT_RazonesSociales:279];0)
		KRL_FindAndLoadRecordByIndex (->[ACT_RazonesSociales:279]id:1;->$vl_idRS)
		ACTcfdi_OpcionesGenerales ("OnLoadConf";->$vl_idRS)
		If (cs_emitirCFDI=1)
			Case of 
					  // Modificado por: Saúl Ponce (05-04-2017) Ticket 168412, habilitación UY en la comparación
					  // : (<>gCountryCode="ar")
				: (<>gCountryCode="ar") | (<>gCountryCode="uy")
					ACTfear_OpcionesGenerales ("CargaConf";->$vl_idRS)
					If (vtACT_errorPHPExec="")
						$0:=1
					Else 
						$0:=0
					End if 
					
				: (<>gCountryCode="cl")
					If (at_proveedores{at_proveedores}="Colegium")
						If ([ACT_RazonesSociales:279]estadoConfiguracion:33 ?? 8)
							If (Current date:C33(*)<=[ACT_RazonesSociales:279]firma_fecha_vencimiento:23)
								$0:=1
							Else 
								$0:=0
								vbACT_noHayFDE:=True:C214
							End if 
						Else 
							$0:=0
							vbACT_noHayCAF:=True:C214
						End if 
					Else 
						$0:=1
					End if 
				Else 
					$0:=1
			End case 
		Else 
			$0:=1
		End if 
		
End case 