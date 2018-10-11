//%attributes = {}
  //ACTmnu_OpcionesGeneracionIECV

  //CAMBIOS
  //20150227 RCH Se cambian validaciones a un mismo for para IEC e IEV...

C_TEXT:C284($t_accion;$1;$t_retorno;$0)
C_POINTER:C301($y_pointer1;$y_pointer2)
C_TEXT:C284($t_prefName)
C_POINTER:C301(${2})
C_BLOB:C604($x_blob)

$t_accion:=$1
If (Count parameters:C259>=2)
	$y_pointer1:=$2
End if 
If (Count parameters:C259>=3)
	$y_pointer2:=$3
End if 

Case of 
	: ($t_accion="CreaPrefModeloImportacion")
		$t_nombre:=$y_pointer1->
		  //$x_blob:=$y_pointer2-> //20150205 RCH. Ya no se ejecuta el código con exe_execute. ahora se hace ejecutando el método.
		
		PREF_SetBlob (0;$t_nombre;$x_blob)
		
	: ($t_accion="GeneraPreferenciaPrincipal")
		  //inicio transtecnia
		ARRAY TEXT:C222($at_proveedores;0)
		ARRAY TEXT:C222($at_proveedoresMethod;0)
		
		C_LONGINT:C283($l_compra;$l_venta)
		$l_compra:=l_compra
		$l_venta:=l_venta
		For ($j;1;2)
			If ($j=1)
				l_compra:=1
				l_venta:=0
			Else 
				l_compra:=0
				l_venta:=1
			End if 
			$t_prefName:=ACTmnu_OpcionesGeneracionIECV ("GetNombrePreferencia")
			ACTmnu_OpcionesGeneracionIECV ("CargaProveedoresXDefecto";->$at_proveedores;->$at_proveedoresMethod)
			$t_prefNameOrg:=$t_prefName
			For ($i;1;Size of array:C274($at_proveedores))
				  //$t_codigo:=4D_GetMethodText ($at_proveedoresMethod{$i}) //20150205 RCH ahora se ejecuta el código de los proveedores por defecto
				  //$t_codigo:=ACTtrf_AddCheckCode ($t_codigo)
				  //CONVERT FROM TEXT($t_codigo;"MacRoman";$x_blob)
				
				$t_prefName:=$t_prefNameOrg+"_"+$at_proveedores{$i}
				ACTmnu_OpcionesGeneracionIECV ("CreaPrefModeloImportacion";->$t_prefName;->$x_blob)
			End for 
		End for 
		l_compra:=$l_compra
		l_venta:=$l_venta
		
	: ($t_accion="GetNombrePreferencia")
		$t_retorno:="ACT_ModeloIECV"
		If (l_compra=1)
			$t_retorno:=$t_retorno+"_Compra"
		Else 
			$t_retorno:=$t_retorno+"_Venta"
		End if 
		
	: ($t_accion="DeclaraVarsForm")
		C_TEXT:C284(vt_g2;vt_rutaArchivo)
		ARRAY TEXT:C222(atACT_ReferenciaPref;0)
		ARRAY TEXT:C222(atACT_NombreFormato;0)
		C_REAL:C285(r_mac;r_win)
		C_REAL:C285(cb_TieneEncabezado)
		C_LONGINT:C283(l_compra;l_venta)
		C_LONGINT:C283(l_compraConf;l_ventaConf;l_totalesConf)
		C_LONGINT:C283(l_prefCompra;l_prefVenta)
		C_TEXT:C284(vt_Motivo)
		C_REAL:C285(vrACT_Total;vrACT_Aprobado;vrACT_Proporcionalidad)
		C_LONGINT:C283(vlACTdte_YearIE)
		C_TEXT:C284(vtACTdte_MesIE)
		C_REAL:C285(cs_totales)
		C_TEXT:C284(vtACT_CodAut)
		C_REAL:C285(vrACT_folioNotif)
		
	: ($t_accion="InicializaVarsForm")
		vt_g2:=""
		vt_rutaArchivo:=""
		AT_Initialize (->atACT_ReferenciaPref;->atACT_NombreFormato)
		r_mac:=0
		r_win:=1
		cb_TieneEncabezado:=1
		vrACT_Total:=0
		vrACT_Aprobado:=0
		vrACT_Rechazado:=0
		l_compra:=1
		l_venta:=0
		vt_Motivo:=""
		vrACT_Total:=0
		vrACT_Aprobado:=0
		vrACT_Rechazado:=0
		  //vrACT_Proporcionalidad:=Num(PREF_fGet (0;"ACT_DTE_FactorPropIVA";String(vrACT_Proporcionalidad)))
		vrACT_Proporcionalidad:=0  //20160123 RCH 
		  //vlACTdte_YearIE
		  //vtACTdte_MesIE:=""
		vlACTdte_MesIE:=Month of:C24(Current date:C33(*))-1
		If (vlACTdte_MesIE=0)  //si es diciembre se asume que es para el año anterior
			vlACTdte_MesIE:=12
			vlACTdte_YearIE:=Year of:C25(Current date:C33(*))-1
		Else 
			vlACTdte_YearIE:=Year of:C25(Current date:C33(*))
		End if 
		vtACTdte_MesIE:=<>atXS_MonthNames{vlACTdte_MesIE}
		
		l_prefCompra:=1
		l_prefVenta:=1
		
		  //para valida cambio en conf de listbox de compra o venta
		l_compraConf:=0
		l_ventaConf:=0
		l_totalesConf:=0
		
		cs_totales:=0
		
		C_BLOB:C604($blob)
		C_TEXT:C284($t_fileName)
		$t_fileName:=Get 4D folder:C485(Current resources folder:K5:16)+"Help Docs"+Folder separator:K24:12+"ACT_TextIECV.txt"
		USE CHARACTER SET:C205("Latin1";1)
		DOCUMENT TO BLOB:C525($t_fileName;$blob)
		vt_g2:=Convert to text:C1012($blob;"Latin1")
		USE CHARACTER SET:C205(*;1)
		
		vtACT_CodAut:=""
		vrACT_folioNotif:=0
		
	: ($t_accion="CargaProveedoresXDefecto")
		Case of 
			: (l_compra=1)
				AT_Initialize ($y_pointer1)
				APPEND TO ARRAY:C911($y_pointer1->;"Transtecnia")
				APPEND TO ARRAY:C911($y_pointer1->;"Plantilla Estándar")
				APPEND TO ARRAY:C911($y_pointer1->;"Softland")  //20150826 RCH
				APPEND TO ARRAY:C911($y_pointer1->;"Softland modelo 2")  //20150826 RCH
				APPEND TO ARRAY:C911($y_pointer1->;"Softland 29 columnas")  //20160521 RCH
				APPEND TO ARRAY:C911($y_pointer1->;"Manager")  //20160907 JVP
				APPEND TO ARRAY:C911($y_pointer1->;"FlexLine")  //20161102 Saúl Ponce, Ticket Nº 169748
				APPEND TO ARRAY:C911($y_pointer1->;"Transtecnia modelo 2")  //20161111 Saúl Ponce, Ticket 168111
				APPEND TO ARRAY:C911($y_pointer1->;"Nubox")  //20170729  AB Ticket 173430 
				
				
				AT_Initialize ($y_pointer2)
				APPEND TO ARRAY:C911($y_pointer2->;"ACTiecv_cTranstecnia")
				APPEND TO ARRAY:C911($y_pointer2->;"ACTiecv_cEstandar")
				APPEND TO ARRAY:C911($y_pointer2->;"ACTiecv_cSoftland")  //20150826 RCH
				APPEND TO ARRAY:C911($y_pointer2->;"ACTiecv_cKent")  //20150828 RCH
				APPEND TO ARRAY:C911($y_pointer2->;"ACTiecv_cSoftland29Col")  //20150826 RCH
				APPEND TO ARRAY:C911($y_pointer2->;"ACTiecv_cManager")  //20160907 JVP
				APPEND TO ARRAY:C911($y_pointer2->;"ACTiecv_cFlexLine")  //20161102 Saúl Ponce, Ticket Nº 169748
				APPEND TO ARRAY:C911($y_pointer2->;"ACTiecv_cTranstecnia2")  //20161111 Saúl Ponce, Ticket 168111
				APPEND TO ARRAY:C911($y_pointer2->;"ACTiecv_cNubox")  //20170729  AB Ticket 173430 
				
				
			: (l_venta=1)
				AT_Initialize ($y_pointer1)
				APPEND TO ARRAY:C911($y_pointer1->;"Plantilla Estándar")
				
				AT_Initialize ($y_pointer2)
				APPEND TO ARRAY:C911($y_pointer2->;"ACTiecv_vEstandar")
		End case 
		
	: ($t_accion="CargaModelosImportacion")
		ACTmnu_OpcionesGeneracionIECV ("DeclaraVarsForm")
		$t_prefName:=ACTmnu_OpcionesGeneracionIECV ("GetNombrePreferencia")+"@"
		READ ONLY:C145([xShell_Prefs:46])
		QUERY:C277([xShell_Prefs:46];[xShell_Prefs:46]Reference:1=$t_prefName)
		SELECTION TO ARRAY:C260([xShell_Prefs:46]Reference:1;atACT_ReferenciaPref)
		For ($i;1;Size of array:C274(atACT_ReferenciaPref))
			APPEND TO ARRAY:C911(atACT_NombreFormato;ST_GetWord (atACT_ReferenciaPref{$i};4;"_"))
		End for 
		If (l_compra=1)
			atACT_NombreFormato:=Num:C11(PREF_fGet (0;"ACT_PreferenciaCompra";String:C10(l_prefCompra)))
		Else 
			atACT_NombreFormato:=Num:C11(PREF_fGet (0;"ACT_PreferenciaVenta";String:C10(l_prefVenta)))
		End if 
		If (Size of array:C274(atACT_ReferenciaPref)>0)
			atACT_ReferenciaPref:=atACT_NombreFormato
		Else 
			atACT_NombreFormato:=0
			atACT_ReferenciaPref:=0
		End if 
		
	: ($t_accion="ConfiguraALP")
		
		ARRAY TEXT:C222($aHeaders;0)
		C_TEXT:C284($t_tipo)
		C_LONGINT:C283($l_cols)
		
		$l_cols:=LISTBOX Get number of columns:C831(*;"lb_IECV")
		
		If (($l_cols=0) | (l_compraConf#l_compra) | (l_ventaConf#l_venta) | (l_totalesConf#cs_totales))
			
			LISTBOX DELETE COLUMN:C830(*;"lb_IECV";1;$l_cols)
			
			$l_cols:=LISTBOX Get number of columns:C831(*;"lb_IECV")
			
			Case of 
				: (cs_totales=1)
					$t_tipo:="IEV_Resumen"
				: (l_compra=1)
					$t_tipo:="IEC"
				: (l_venta=1)
					$t_tipo:="IEV"
					
			End case 
			l_compraConf:=l_compra
			l_ventaConf:=l_venta
			l_totalesConf:=cs_totales
			ACTdte_OpcionesGeneralesIE ("CargaArchivoConfiguracion";->$t_tipo;->$aHeaders)
			
			C_LONGINT:C283(l_Titulo)
			For ($i;1;Size of array:C274($aHeaders))
				$y_pointer2Var:=Get pointer:C304("atACTie_COLUMNA"+String:C10($i))
				$vt_title:="vTitle"+String:C10($i)
				LISTBOX INSERT COLUMN:C829(*;"lb_IECV";$i;String:C10($i);$y_pointer2Var->;$vt_title;l_Titulo)
				OBJECT SET TITLE:C194(*;$vt_title;$aHeaders{$i})
			End for 
			LISTBOX SET COLUMN WIDTH:C833(*;"lb_IECV";100)  //20170221 RCH
			
			  //para manejar errores
			  //$i:=$i+1
			$vt_title:="vTitle"+String:C10($i)
			LISTBOX INSERT COLUMN:C829(*;"lb_IECV";$i;String:C10($i);abACTie_Error;$vt_title;l_Titulo)
			OBJECT SET TITLE:C194(*;$vt_title;"errorbool")
			OBJECT SET VISIBLE:C603(*;String:C10($i);False:C215)
			
			$i:=$i+1
			$vt_title:="vTitle"+String:C10($i)
			LISTBOX INSERT COLUMN:C829(*;"lb_IECV";$i;String:C10($i);atACTie_ErrorDetalle;$vt_title;l_Titulo)
			OBJECT SET TITLE:C194(*;$vt_title;"errorText")
			OBJECT SET VISIBLE:C603(*;String:C10($i);False:C215)
			
		End if 
		
	: ($t_accion="ValidaDatos")
		
		AT_Initialize (->abACTie_Error;->atACTie_ErrorDetalle)
		AT_RedimArrays (Size of array:C274(atACTie_COLUMNA1);->abACTie_Error;->atACTie_ErrorDetalle)
		vrACT_Rechazado:=0
		
		vt_Motivo:=""  //20150827 RCH
		
		Case of 
			: (cs_totales=1)
				
				  //VALIDA montos
				  //atACTie_COLUMNA5 // exento
				  //atACTie_COLUMNA6 // neto
				  //atACTie_COLUMNA7 // iva
				  //atACTie_COLUMNA18 // total
				ARRAY POINTER:C280($ap_punteros;0)
				APPEND TO ARRAY:C911($ap_punteros;->atACTie_COLUMNA5)
				APPEND TO ARRAY:C911($ap_punteros;->atACTie_COLUMNA6)
				APPEND TO ARRAY:C911($ap_punteros;->atACTie_COLUMNA7)
				APPEND TO ARRAY:C911($ap_punteros;->atACTie_COLUMNA18)
				
				For ($i;1;Size of array:C274($ap_punteros))
					For ($j;1;Size of array:C274($ap_punteros{$i}->))
						  //quito caracteres que pudieron ser pegados desde, por ejemplo, excel
						$ap_punteros{$i}->{$j}:=ST_GetCleanString ($ap_punteros{$i}->{$j})
						If ($ap_punteros{$i}->{$j}="")
							$ap_punteros{$i}->{$j}:="0"
						End if 
						$ap_punteros{$i}->{$j}:=String:C10(Num:C11($ap_punteros{$i}->{$j});"|Despliegue_ACT_Pagos")
					End for 
				End for 
				  //VALIDA montos
				
				  //valida datos vacios
				ARRAY POINTER:C280($ap_arreglos;0)
				ARRAY LONGINT:C221($al_DAReturn;0)
				APPEND TO ARRAY:C911($ap_arreglos;->atACTie_COLUMNA1)  //tipo documento
				APPEND TO ARRAY:C911($ap_arreglos;->atACTie_COLUMNA2)  //cantidad de documentos
				APPEND TO ARRAY:C911($ap_arreglos;->atACTie_COLUMNA5)  // total exento
				APPEND TO ARRAY:C911($ap_arreglos;->atACTie_COLUMNA6)  // total neto
				APPEND TO ARRAY:C911($ap_arreglos;->atACTie_COLUMNA7)  // total iva
				APPEND TO ARRAY:C911($ap_arreglos;->atACTie_COLUMNA18)  //total
				
				For ($i;1;Size of array:C274($ap_arreglos))
					$ap_array:=$ap_arreglos{$i}
					$ap_array->{0}:=""
					AT_SearchArray ($ap_array;"=";->$al_DAReturn)
					For ($j;1;Size of array:C274($al_DAReturn))
						If (Not:C34(abACTie_Error{$al_DAReturn{$j}}))
							vrACT_Rechazado:=vrACT_Rechazado+1
						End if 
						abACTie_Error{$al_DAReturn{$j}}:=True:C214
						atACTie_ErrorDetalle{$al_DAReturn{$j}}:="Dato obligatorio vacío. Para totales debe ser 0."
					End for 
				End for 
				  //valida datos vacios
				
				  //valida montos documentos
				For ($i;1;Size of array:C274(atACTie_COLUMNA29))
					If (Num:C11(atACTie_COLUMNA18{$i})#(Num:C11(atACTie_COLUMNA5{$i})+Num:C11(atACTie_COLUMNA6{$i})+Num:C11(atACTie_COLUMNA7{$i})))
						If (Not:C34(abACTie_Error{$i}))
							vrACT_Rechazado:=vrACT_Rechazado+1
						End if 
						abACTie_Error{$i}:=True:C214
						atACTie_ErrorDetalle{$i}:="Error en validación de montos. Monto total no corresponde a desglose."
					End if 
				End for 
				
				  //tipo no puede ser 0
				For ($i;1;Size of array:C274(atACTie_COLUMNA1))
					If (Num:C11(atACTie_COLUMNA1{$i})=0)
						If (Not:C34(abACTie_Error{$i}))
							vrACT_Rechazado:=vrACT_Rechazado+1
						End if 
						abACTie_Error{$i}:=True:C214
						atACTie_ErrorDetalle{$i}:="Error en validación de tipos de documentos. El tipo de documento no puede ser vacío ni 0."
					End if 
				End for 
				  //tipo no puede ser 0
				
				  //validar que los tipo 35 tengan monto iva
				For ($i;1;Size of array:C274(atACTie_COLUMNA1))
					If ((atACTie_COLUMNA1{$i}="38") & (Num:C11(atACTie_COLUMNA7{$i})#0))
						If (Not:C34(abACTie_Error{$i}))
							vrACT_Rechazado:=vrACT_Rechazado+1
						End if 
						abACTie_Error{$i}:=True:C214
						atACTie_ErrorDetalle{$i}:="Error en validación de montos. Los totales tipo 38 no pueden tener monto IVA."
					End if 
				End for 
				  //validar que los tipo 35 tengan monto iva
				
				  //validar que los tipo 38 no tengan monto iva
				For ($i;1;Size of array:C274(atACTie_COLUMNA1))
					If ((atACTie_COLUMNA1{$i}="35") & ((Num:C11(atACTie_COLUMNA7{$i})=0) & (Num:C11(atACTie_COLUMNA18{$i})>=3)))
						If (Not:C34(abACTie_Error{$i}))
							vrACT_Rechazado:=vrACT_Rechazado+1
						End if 
						abACTie_Error{$i}:=True:C214
						atACTie_ErrorDetalle{$i}:="Error en validación de montos. Los totales tipo 35 deben tener monto IVA distinto de 0."
					End if 
				End for 
				  //validar que los tipo 38 no tengan monto iva
				
				  //valida monto IVA
				For ($i;1;Size of array:C274(atACTie_COLUMNA1))
					If (Num:C11(atACTie_COLUMNA2{$i})=1)  //20170119 RCH cuando se agrupa no se debe calcular el IVA sobre el neto ya que se provocan diferencias
						$t_moneda:=ST_GetWord (ACT_DivisaPais ;1;";")
						$l_decimales:=Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->$t_moneda))
						$r_montoIVA:=Round:C94(Num:C11(atACTie_COLUMNA6{$i})*(<>vrACT_TasaIVA/100);$l_decimales)
						$r_diferencia:=Num:C11(atACTie_COLUMNA7{$i})-$r_montoIVA
						
						If (($r_diferencia>=2) | ($r_diferencia<=-2))  // se aceptan hasta 2 pesos de diferencia
							If (Not:C34(abACTie_Error{$i}))
								vrACT_Rechazado:=vrACT_Rechazado+1
							End if 
							abACTie_Error{$i}:=True:C214
							atACTie_ErrorDetalle{$i}:="Error en monto IVA. Monto afecto: "+atACTie_COLUMNA6{$i}+", monto IVA: "+atACTie_COLUMNA7{$i}+", monto calculado: "+String:C10($r_montoIVA)+"."
						End if 
					End if 
				End for 
				  //valida monto IVA
				
				
			: (l_compra=1)
				
				  //20150831 RCH valida largo razon social. Máximo 50
				For ($i;1;Size of array:C274(atACTie_COLUMNA12))
					atACTie_COLUMNA12{$i}:=Substring:C12(atACTie_COLUMNA12{$i};1;50)
				End for 
				
				  //valida datos vacios
				ARRAY POINTER:C280($ap_arreglos;0)
				ARRAY LONGINT:C221($al_DAReturn;0)
				APPEND TO ARRAY:C911($ap_arreglos;->atACTie_COLUMNA1)  //tipo documento
				APPEND TO ARRAY:C911($ap_arreglos;->atACTie_COLUMNA3)  //folio
				APPEND TO ARRAY:C911($ap_arreglos;->atACTie_COLUMNA7)  // tasa IVA
				APPEND TO ARRAY:C911($ap_arreglos;->atACTie_COLUMNA9)  // Fecha Del documento
				APPEND TO ARRAY:C911($ap_arreglos;->atACTie_COLUMNA11)  // RUT Proveedor
				APPEND TO ARRAY:C911($ap_arreglos;->atACTie_COLUMNA12)  //Razon social proveedor
				APPEND TO ARRAY:C911($ap_arreglos;->atACTie_COLUMNA20)  //Monto total
				
				For ($i;1;Size of array:C274($ap_arreglos))
					$ap_array:=$ap_arreglos{$i}
					$ap_array->{0}:=""
					AT_SearchArray ($ap_array;"=";->$al_DAReturn)
					For ($j;1;Size of array:C274($al_DAReturn))
						If (Not:C34(abACTie_Error{$al_DAReturn{$j}}))
							vrACT_Rechazado:=vrACT_Rechazado+1
						End if 
						abACTie_Error{$al_DAReturn{$j}}:=True:C214
						atACTie_ErrorDetalle{$al_DAReturn{$j}}:="Dato obligatorio vacío."
					End for 
				End for 
				  //valida datos vacios
				
				  //VALIDA montos
				  //atACTie_COLUMNA13 // exento
				  //atACTie_COLUMNA14 // neto
				  //atACTie_COLUMNA15 // iva
				For ($i;1;Size of array:C274(atACTie_COLUMNA13))
					If (atACTie_COLUMNA13{$i}="")
						atACTie_COLUMNA13{$i}:="0"
					End if 
					If (atACTie_COLUMNA14{$i}="")
						atACTie_COLUMNA14{$i}:="0"
					End if 
					If (atACTie_COLUMNA15{$i}="")
						atACTie_COLUMNA15{$i}:="0"
					End if 
					If (atACTie_COLUMNA18{$i}="")
						atACTie_COLUMNA18{$i}:="0"
					End if 
					If (atACTie_COLUMNA19{$i}="")
						atACTie_COLUMNA19{$i}:="0"
					End if 
					If (atACTie_COLUMNA20{$i}="")
						atACTie_COLUMNA20{$i}:="0"
					End if 
				End for 
				  //VALIDA montos
				
				  //20150226 RCH valida folio duplicado
				ARRAY TEXT:C222($at_tipo_folio;0)
				For ($i;1;Size of array:C274(atACTie_COLUMNA1))
					  //APPEND TO ARRAY($at_tipo_folio;String(Num(atACTie_COLUMNA1{$i}))+String(Num(atACTie_COLUMNA3{$i})))
					APPEND TO ARRAY:C911($at_tipo_folio;String:C10(Num:C11(atACTie_COLUMNA1{$i}))+String:C10(Num:C11(atACTie_COLUMNA3{$i}))+atACTie_COLUMNA11{$i})  //20160121 RCH
				End for 
				
				  //20150227 RCH para quitar puntos
				ARRAY LONGINT:C221($alACT_numCol;0)
				APPEND TO ARRAY:C911($alACT_numCol;1)
				APPEND TO ARRAY:C911($alACT_numCol;3)
				APPEND TO ARRAY:C911($alACT_numCol;13)
				APPEND TO ARRAY:C911($alACT_numCol;14)
				APPEND TO ARRAY:C911($alACT_numCol;15)
				APPEND TO ARRAY:C911($alACT_numCol;16)
				APPEND TO ARRAY:C911($alACT_numCol;17)
				APPEND TO ARRAY:C911($alACT_numCol;18)
				APPEND TO ARRAY:C911($alACT_numCol;19)
				APPEND TO ARRAY:C911($alACT_numCol;20)
				APPEND TO ARRAY:C911($alACT_numCol;21)
				APPEND TO ARRAY:C911($alACT_numCol;27)
				APPEND TO ARRAY:C911($alACT_numCol;30)
				
				  //valida montos netos e iva
				For ($i;1;Size of array:C274(atACTie_COLUMNA13))
					If (((Num:C11(atACTie_COLUMNA14{$i}))<(Num:C11(atACTie_COLUMNA16{$i}))) | ((Num:C11(atACTie_COLUMNA15{$i}))<(Num:C11(atACTie_COLUMNA17{$i}))))
						If ((Num:C11(atACTie_COLUMNA18{$i}))<(Num:C11(atACTie_COLUMNA17{$i})))  //se valida con el el activo fijo no solo con el iva
							If (Not:C34(abACTie_Error{$i}))
								vrACT_Rechazado:=vrACT_Rechazado+1
							End if 
							abACTie_Error{$i}:=True:C214
							atACTie_ErrorDetalle{$i}:="Error en validación de montos. El monto IVA o Neto ACTIVO FIJO es mayor al IVA (recuperable) o monto Neto respectivamente."
						End if 
					End if 
				End for 
				  //valida montos netos e iva
				
				  //valida montos documentos
				For ($i;1;Size of array:C274(atACTie_COLUMNA13))
					  //If (Num(atACTie_COLUMNA20{$i})#(Num(atACTie_COLUMNA13{$i})+Num(atACTie_COLUMNA14{$i})+Num(atACTie_COLUMNA15{$i})+Num(atACTie_COLUMNA19{$i})+Num(atACTie_COLUMNA18{$i})))
					  //If (Num(atACTie_COLUMNA20{$i})#(Num(atACTie_COLUMNA13{$i})+Num(atACTie_COLUMNA14{$i})+Num(atACTie_COLUMNA15{$i})+Num(atACTie_COLUMNA19{$i})+Num(atACTie_COLUMNA18{$i})+Num(atACTie_COLUMNA27{$i})))  //20140926 RCH sumo iva no recuperable
					  //If (Num(atACTie_COLUMNA20{$i})#(Num(atACTie_COLUMNA13{$i})+Num(atACTie_COLUMNA14{$i})+Num(atACTie_COLUMNA15{$i})+Num(atACTie_COLUMNA19{$i})+Num(atACTie_COLUMNA18{$i})+Num(atACTie_COLUMNA27{$i})-Num(atACTie_COLUMNA30{$i})-Choose(Num(atACTie_COLUMNA19{$i})=0;0;Num(atACTie_COLUMNA19{$i}))))  //20141112 RCH sumo iva no recuperable
					If (Num:C11(atACTie_COLUMNA20{$i})#(Num:C11(atACTie_COLUMNA13{$i})+Num:C11(atACTie_COLUMNA14{$i})+Num:C11(atACTie_COLUMNA15{$i})+Num:C11(atACTie_COLUMNA19{$i})+Num:C11(atACTie_COLUMNA18{$i})+Num:C11(atACTie_COLUMNA27{$i})))  //20170415 RCH
						If (Not:C34(abACTie_Error{$i}))
							vrACT_Rechazado:=vrACT_Rechazado+1
						End if 
						abACTie_Error{$i}:=True:C214
						atACTie_ErrorDetalle{$i}:="Error en validación de montos. Monto total no corresponde a desglose."
					End if 
					
					  //valida formato de fechas
					$t_fecha:=DT_StrDateIsOK (String:C10(DT_GetDateFromDayMonthYear (Num:C11(Substring:C12(atACTie_COLUMNA9{$i};9;2));Num:C11(Substring:C12(atACTie_COLUMNA9{$i};6;2));Num:C11(Substring:C12(atACTie_COLUMNA9{$i};1;4))));False:C215)
					If ($t_fecha=dt_GetNullDateString )
						If (Not:C34(abACTie_Error{$i}))
							vrACT_Rechazado:=vrACT_Rechazado+1
						End if 
						abACTie_Error{$i}:=True:C214
						atACTie_ErrorDetalle{$i}:="Error en validación de fechas. La fecha no tiene el formato AAAA-MM-DD o no es una fecha válida."
					End if 
					  //valida formato de fechas
					
					
					  //valida codigos de iva no recuperable
					  //For ($i;1;Size of array(atACTie_COLUMNA19))
					  //If (atACTie_COLUMNA19{$i}#"0")
					  //  //If ((atACTie_COLUMNA26{$i}="") | (atACTie_COLUMNA27{$i}#atACTie_COLUMNA19{$i}))
					  //If (((atACTie_COLUMNA26{$i}="") | (atACTie_COLUMNA27{$i}#atACTie_COLUMNA19{$i})) & ((atACTie_COLUMNA28{$i}="") | (atACTie_COLUMNA30{$i}#atACTie_COLUMNA19{$i})))  //20140830 RCH
					  //If (Not(abACTie_Error{$i}))
					  //vrACT_Rechazado:=vrACT_Rechazado+1
					  //End if 
					  //abACTie_Error{$i}:=True
					  //atACTie_ErrorDetalle{$i}:="Error en validación de montos IVA no recuperables. Revise si ingresó códigos y montos de IVA no recuperable."
					  //End if 
					  //End if 
					  //End for
					  //20170415 RCH SE valida IVANoRec
					If (((atACTie_COLUMNA26{$i}="") & (atACTie_COLUMNA27{$i}#"")) | ((atACTie_COLUMNA26{$i}#"") & (atACTie_COLUMNA27{$i}="")))
						If (Not:C34(abACTie_Error{$i}))
							vrACT_Rechazado:=vrACT_Rechazado+1
						End if 
						abACTie_Error{$i}:=True:C214
						atACTie_ErrorDetalle{$i}:="Error en validación de montos IVA no recuperables. Revise si ingresó códigos y montos de IVA no recuperable."
					End if 
					
					  //20150226 RCH valida largo folio
					  //For ($i;1;Size of array(atACTie_COLUMNA3))
					If (Num:C11(atACTie_COLUMNA3{$i})#0)
						If (Length:C16(atACTie_COLUMNA3{$i})>10)
							If (Not:C34(abACTie_Error{$i}))
								vrACT_Rechazado:=vrACT_Rechazado+1
							End if 
							abACTie_Error{$i}:=True:C214
							atACTie_ErrorDetalle{$i}:="Error en validación de largo de folio. Largo máximo 10, largo del folio: "+String:C10(Length:C16(atACTie_COLUMNA3{$i}))+"."
						End if 
					End if 
					  //End for 
					
					  //  //20150226 RCH valida folio duplicado
					  //ARRAY TEXT($at_tipo_folio;0)
					  //For ($i;1;Size of array(atACTie_COLUMNA1))
					  //APPEND TO ARRAY($at_tipo_folio;String(Num(atACTie_COLUMNA1{$i}))+String(Num(atACTie_COLUMNA3{$i})))
					  //End for 
					  //For ($i;1;Size of array(atACTie_COLUMNA1))
					  //$t_tipoFolio:=String(Num(atACTie_COLUMNA1{$i}))+String(Num(atACTie_COLUMNA3{$i}))
					$t_tipoFolio:=String:C10(Num:C11(atACTie_COLUMNA1{$i}))+String:C10(Num:C11(atACTie_COLUMNA3{$i}))+atACTie_COLUMNA11{$i}  //20160121 RCH
					$l_veces:=Count in array:C907($at_tipo_folio;$t_tipoFolio)
					If ($l_veces>1)
						If (Not:C34(abACTie_Error{$i}))
							vrACT_Rechazado:=vrACT_Rechazado+1
						End if 
						abACTie_Error{$i}:=True:C214
						atACTie_ErrorDetalle{$i}:="Error en validación de documentos. Documento duplicado. tipo: "+atACTie_COLUMNA1{$i}+", folio: "+atACTie_COLUMNA3{$i}+"."
					End if 
					  //End for 
					
					  //20150227 RCH para quitar puntos
					For ($j;1;Size of array:C274($alACT_numCol))
						$y_puntero:=Get pointer:C304("atACTie_COLUMNA"+String:C10($alACT_numCol{$j}))
						
						If ($y_puntero->{$i}#"")
							$y_puntero->{$i}:=String:C10(Num:C11($y_puntero->{$i}))
						End if 
					End for 
					
				End for 
				
			: (l_venta=1)
				
				  //valida datos vacios
				ARRAY POINTER:C280($ap_arreglos;0)
				ARRAY LONGINT:C221($al_DAReturn;0)
				APPEND TO ARRAY:C911($ap_arreglos;->atACTie_COLUMNA1)  //tipo documento
				APPEND TO ARRAY:C911($ap_arreglos;->atACTie_COLUMNA3)  //folio
				APPEND TO ARRAY:C911($ap_arreglos;->atACTie_COLUMNA6)  // tasa IVA
				APPEND TO ARRAY:C911($ap_arreglos;->atACTie_COLUMNA10)  // Fecha Del documento
				APPEND TO ARRAY:C911($ap_arreglos;->atACTie_COLUMNA12)  // RUT cliente
				APPEND TO ARRAY:C911($ap_arreglos;->atACTie_COLUMNA13)  //Razon social
				APPEND TO ARRAY:C911($ap_arreglos;->atACTie_COLUMNA29)  //Monto total
				
				For ($i;1;Size of array:C274($ap_arreglos))
					$ap_array:=$ap_arreglos{$i}
					$ap_array->{0}:=""
					AT_SearchArray ($ap_array;"=";->$al_DAReturn)
					For ($j;1;Size of array:C274($al_DAReturn))
						If (atACTie_COLUMNA4{$al_DAReturn{$j}}#"A")
							If (ACTdte_EnviaDetalleLibro (atACTie_COLUMNA1{$al_DAReturn{$j}}))  //20150831 Si no informa detalle, el dato no es obligatorio
								
								If (Not:C34(abACTie_Error{$al_DAReturn{$j}}))
									vrACT_Rechazado:=vrACT_Rechazado+1
								End if 
								abACTie_Error{$al_DAReturn{$j}}:=True:C214
								atACTie_ErrorDetalle{$al_DAReturn{$j}}:="Dato obligatorio vacío."
								
							End if 
						End if 
					End for 
				End for 
				  //valida datos vacios
				
				  //VALIDA montos
				  //atACTie_COLUMNA18 // exento
				  //atACTie_COLUMNA19 // neto
				  //atACTie_COLUMNA20 // iva
				For ($i;1;Size of array:C274(atACTie_COLUMNA18))
					If (atACTie_COLUMNA18{$i}="")
						atACTie_COLUMNA18{$i}:="0"
					End if 
					If (atACTie_COLUMNA19{$i}="")
						atACTie_COLUMNA19{$i}:="0"
					End if 
					If (atACTie_COLUMNA20{$i}="")
						atACTie_COLUMNA20{$i}:="0"
					End if 
					If (atACTie_COLUMNA29{$i}="")
						atACTie_COLUMNA29{$i}:="0"
					End if 
				End for 
				  //VALIDA montos
				
				  //20150227 RCH Se cambian validaciones a un mismo for...
				  //valida montos documentos
				For ($i;1;Size of array:C274(atACTie_COLUMNA29))
					If (Num:C11(atACTie_COLUMNA29{$i})#(Num:C11(atACTie_COLUMNA18{$i})+Num:C11(atACTie_COLUMNA19{$i})+Num:C11(atACTie_COLUMNA20{$i})))
						If (atACTie_COLUMNA4{$i}#"A")
							If (Not:C34(abACTie_Error{$i}))
								vrACT_Rechazado:=vrACT_Rechazado+1
							End if 
							abACTie_Error{$i}:=True:C214
							atACTie_ErrorDetalle{$i}:="Error en validación de montos. Monto total no corresponde a desglose."
						End if 
					End if 
					
					  //valida formato de fechas
					  //For ($i;1;Size of array(atACTie_COLUMNA10))
					$t_fecha:=DT_StrDateIsOK (String:C10(DT_GetDateFromDayMonthYear (Num:C11(Substring:C12(atACTie_COLUMNA10{$i};9;2));Num:C11(Substring:C12(atACTie_COLUMNA10{$i};6;2));Num:C11(Substring:C12(atACTie_COLUMNA10{$i};1;4))));False:C215)
					If ($t_fecha=dt_GetNullDateString )
						If (atACTie_COLUMNA4{$i}#"A")
							If (Not:C34(abACTie_Error{$i}))
								vrACT_Rechazado:=vrACT_Rechazado+1
							End if 
							abACTie_Error{$i}:=True:C214
							atACTie_ErrorDetalle{$i}:="Error en validación de fechas. La fecha no tiene el formato AAAA-MM-DD o no es una fecha válida."
						End if 
					End if 
					  //End for 
					  //valida formato de fechas
					
					  //folio no puede ser 0
					  //For ($i;1;Size of array(atACTie_COLUMNA1))
					If (Num:C11(atACTie_COLUMNA1{$i})=0)
						If (Not:C34(abACTie_Error{$i}))
							vrACT_Rechazado:=vrACT_Rechazado+1
						End if 
						abACTie_Error{$i}:=True:C214
						atACTie_ErrorDetalle{$i}:="Error en validación de tipos de documentos. El tipo de documento no puede ser vacío ni 0."
					End if 
					  //End for 
					  //folio no puede ser 0
					
					  //folio no puede ser 0
					  //For ($i;1;Size of array(atACTie_COLUMNA3))
					If (Num:C11(atACTie_COLUMNA3{$i})=0)
						If (Not:C34(abACTie_Error{$i}))
							vrACT_Rechazado:=vrACT_Rechazado+1
						End if 
						abACTie_Error{$i}:=True:C214
						atACTie_ErrorDetalle{$i}:="Error en validación de folios. El folio no puede ser vacío ni 0."
					End if 
					  //End for 
					  //folio no puede ser 0
					
					  //largo de razon social no puede ser mayor a 50
					$l_largoRS:=50
					  //For ($i;1;Size of array(atACTie_COLUMNA13))
					If (Length:C16(atACTie_COLUMNA13{$i})>$l_largoRS)
						If (Not:C34(abACTie_Error{$i}))
							vrACT_Rechazado:=vrACT_Rechazado+1
						End if 
						abACTie_Error{$i}:=True:C214
						atACTie_ErrorDetalle{$i}:="Error en validación de Razón Social. La Razón Social no puede ser mayor a "+String:C10($l_largoRS)+" caracteres."
					End if 
					  //End for 
					  //largo de razon social no puede ser mayor a 50
					
					  //largo del comprobante no puede ser mayor a 10
					$l_largoRS:=10
					  //For ($i;1;Size of array(atACTie_COLUMNA7))
					If (Length:C16(atACTie_COLUMNA7{$i})>$l_largoRS)
						If (Not:C34(abACTie_Error{$i}))
							vrACT_Rechazado:=vrACT_Rechazado+1
						End if 
						abACTie_Error{$i}:=True:C214
						atACTie_ErrorDetalle{$i}:="Error en validación de Comprobante interno. El largo del comprobante no puede ser mayor a "+String:C10($l_largoRS)+" caracteres."
					End if 
					  //End for 
					  //largo del comprobante no puede ser mayor a 10
					
				End for 
				
		End case 
		
		vrACT_Total:=Size of array:C274(atACTie_COLUMNA13)
		vrACT_Aprobado:=vrACT_Total-vrACT_Rechazado
		
		
		  //colorea Listbox
		AT_RedimArrays (Size of array:C274(atACTie_ErrorDetalle);->alACT_coloresLB)
		For ($i;1;Size of array:C274(atACTie_ErrorDetalle))
			If (abACTie_Error{$i})
				alACT_coloresLB{$i}:=16711680  //rojo
			Else 
				alACT_coloresLB{$i}:=0
			End if 
		End for 
		
		
End case 

$0:=$t_retorno