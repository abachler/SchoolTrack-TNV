  // [ACT_IECV].ACT_Asistente_IEC_IEV.Variable8()
C_TEXT:C284($t_error)


vi_PageNumber:=FORM Get current page:C276
Case of 
	: (vi_PageNumber=1)
		_O_DISABLE BUTTON:C193(bPrev)
		_O_ENABLE BUTTON:C192(bNext)
		t_mensaje:=""
		
	: (vi_PageNumber=2)
		C_TEXT:C284(<>vt_rutaArchivo)
		If (<>vt_rutaArchivo#"")
			vt_rutaArchivo:=<>vt_rutaArchivo
		End if 
		
		ACTcfg_OpcionesRazonesSociales ("CargaByID";->alACTcfg_Razones{atACTcfg_Razones})
		
		OBJECT SET VISIBLE:C603(*;"estandar_@";((atACT_NombreFormato=2) & (l_compra=1)))
		
		If ((atACT_NombreFormato=1) & (l_venta=1))
			OBJECT SET VISIBLE:C603(*;"venta_noestandar_@";False:C215)
			vt_rutaArchivo:=""
		Else 
			OBJECT SET VISIBLE:C603(*;"venta_noestandar_@";True:C214)
		End if 
		
		If (l_venta=0)
			cs_totales:=0
		End if 
		
		OBJECT SET VISIBLE:C603(cs_totales;(l_venta=1))
		
		  // Modificado por: Saúl Ponce (05/10/2017), Ticket 187901 para que no se generen libros en periodos superiores a 2017-07
		C_REAL:C285($r_periodo)
		$r_periodo:=Num:C11(String:C10(vlACTdte_YearIE;"0000")+String:C10(vlACTdte_MesIE;"00"))
		
		_O_ENABLE BUTTON:C192(bPrev)
		_O_DISABLE BUTTON:C193(bNext)
		IT_MODIFIERS 
		Case of 
			: ((l_compra=0) & (l_venta=0))
				t_mensaje:="Seleccione el tipo de operación: Compra o Venta."
				
			: ((vt_rutaArchivo="") & (Not:C34((atACT_NombreFormato=1) & (l_venta=1))))
				t_mensaje:="Seleccione el archivo a procesar."
				
			: ((r_mac=0) & (r_win=0))
				t_mensaje:="Seleccione si el archivo fue creado en Mac o Windows."
				
			: (atACT_NombreFormato=0)
				t_mensaje:="Seleccione previamente el modelo de generación a utilizar."
				
			: (Not:C34([ACT_RazonesSociales:279]emisor_electronico:30) & (<>gRolBD#"90468"))  //20140829 RCH Grange envia solo el libro de ventas con nosotros
				t_mensaje:="La Razón social no está configurada como emisior electrónico."
				
			: (($r_periodo>201707) & (Not:C34(<>Option)))  // 20180911 RCH Ticket 216438
				t_mensaje:=__ ("Efectúe el registro de compras y ventas en el sitio www.sii.cl.")
				
			: (KRL_GetTextFieldData (->[Profesores:4]Numero:1;->[ACT_RazonesSociales:279]encargadoDTE_id:31;->[Profesores:4]RUT:27)="")  //20180813 RCH. Ticket 213166.
				t_mensaje:=__ ("No existe rut del encargado DTE. Favor verificar la configuración de los Documentos Tributarios/Dte")
				
			Else 
				_O_ENABLE BUTTON:C192(bNext)
				t_mensaje:=""
				<>vt_rutaArchivo:=vt_rutaArchivo
		End case 
		
		ACTdte_OpcionesGeneralesIE ("ValidaPeriodoLibroElectronico")
		
	: (vi_PageNumber=3)
		
		ACTdte_OpcionesGeneralesIE ("ValidaPeriodoLibroElectronico")
		
		If (l_compra=1)
			PREF_Set (0;"ACT_PreferenciaCompra";String:C10(atACT_ReferenciaPref))
		Else 
			PREF_Set (0;"ACT_PreferenciaVenta";String:C10(atACT_ReferenciaPref))
		End if 
		OBJECT SET VISIBLE:C603(*;"compra@";l_compra=1)
		
		ACTmnu_OpcionesGeneracionIECV ("ConfiguraALP")
		
		  //If (cs_totales=0)
		  //20120303 RCH No se buscaba el proveedor
		  //ACTdte_OpcionesGenerales ("BuscaProveedoresPrefs")
		C_TEXT:C284($vt_nombrePref)
		$vt_nombrePref:=atACT_ReferenciaPref{atACT_ReferenciaPref}
		
		READ ONLY:C145([xShell_Prefs:46])
		QUERY:C277([xShell_Prefs:46];[xShell_Prefs:46]User:9=0;*)
		QUERY:C277([xShell_Prefs:46]; & [xShell_Prefs:46]Reference:1=$vt_nombrePref)
		
		$b_validar:=False:C215
		
		If (Records in selection:C76([xShell_Prefs:46])=1)
			C_LONGINT:C283($l_proc)
			$l_proc:=IT_UThermometer (1;0;"Recopilando información...")
			
			If (r_mac=1)
				USE CHARACTER SET:C205("MacRoman";1)
			Else 
				USE CHARACTER SET:C205("windows-1252";1)
			End if 
			$vtCode:=Convert to text:C1012([xShell_Prefs:46]_blob:10;"MacRoman")
			If (ACTtrf_IsValidTransferFile ($vtCode))
				$vtCode:=ACTtrf_RemoveCheckCode ($vtCode)
				  //$t_error:=FRAppendChecksum ($vtCode)
				  //ACTiecv_cTranstecnia (vt_rutaArchivo)
				  //ACTiecv_vEstandar 
				  //ACTiecv_cTranstecnia (vt_rutaArchivo)
				  //ACTiecv_vEstandar 
				$t_error:=""
				
				  //20141121 RCH Problema en compilado
				  //$t_error:=SR_ExecuteScript ($vtCode;vt_rutaArchivo)
				If ($vtCode="")
					ARRAY TEXT:C222($at_proveedores;0)
					ARRAY TEXT:C222($at_proveedoresMethod;0)
					ACTmnu_OpcionesGeneracionIECV ("CargaProveedoresXDefecto";->$at_proveedores;->$at_proveedoresMethod)
					$l_existe:=Find in array:C230($at_proveedores;atACT_NombreFormato{atACT_NombreFormato})
					If ($l_existe#-1)
						If (API Does Method Exist ($at_proveedoresMethod{$l_existe})=1)
							EXECUTE FORMULA:C63($at_proveedoresMethod{$l_existe})
						End if 
					End if 
				Else 
					$t_error:=EXE_Execute ($vtCode;False:C215;"";->vt_rutaArchivo)
				End if 
				
				If ($t_error#"")
					CD_Dlog (0;__ ("Error al ejecutar código:\r")+$t_error)
				Else 
					$b_validar:=True:C214
				End if 
				
			Else 
				
				ARRAY TEXT:C222($at_proveedores;0)
				ARRAY TEXT:C222($at_proveedoresMethod;0)
				ACTmnu_OpcionesGeneracionIECV ("CargaProveedoresXDefecto";->$at_proveedores;->$at_proveedoresMethod)
				$l_existe:=Find in array:C230($at_proveedores;atACT_NombreFormato{atACT_NombreFormato})
				If ($l_existe#-1)
					If (API Does Method Exist ($at_proveedoresMethod{$l_existe})=1)
						EXECUTE FORMULA:C63($at_proveedoresMethod{$l_existe})
						$b_validar:=True:C214
					End if 
				Else 
					CD_Dlog (0;"Código no válido")
				End if 
			End if 
			
			IT_UThermometer (-2;$l_proc)
			
			If ($b_validar)
				  //valida datos
				$l_proc:=IT_UThermometer (1;0;"Validando datos...")
				ACTmnu_OpcionesGeneracionIECV ("ValidaDatos")
				IT_UThermometer (-2;$l_proc)
			End if 
			
			USE CHARACTER SET:C205(*;1)
		Else 
			vi_PageNumber:=vi_PageNumber-1
			FORM GOTO PAGE:C247(vi_PageNumber)
		End if 
		  //End if 
End case 