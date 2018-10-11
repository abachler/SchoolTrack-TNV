//%attributes = {}
  //ACTcfg_opcionesDTE

C_TEXT:C284($vt_accion;$0;$vt_return)
C_DATE:C307($vd_fecha)
C_POINTER:C301(${2})
C_POINTER:C301($vy_pointer1;$vy_pointer2;$vy_pointer3;$vy_pointer4)
C_LONGINT:C283($i)
C_BLOB:C604($xBlob)
$vt_accion:=$1
If (Count parameters:C259>=2)
	$vy_pointer1:=$2
End if 
If (Count parameters:C259>=3)
	$vy_pointer2:=$3
End if 
If (Count parameters:C259>=4)
	$vy_pointer3:=$4
End if 
If (Count parameters:C259>=5)
	$vy_pointer4:=$5
End if 

Case of 
	: ($vt_accion="DeclaraArreglosConf")
		TRACE:C157
		  //ARRAY TEXT(atRS_nombre;0)
		  //ARRAY TEXT(atRS_rut;0)
		  //ARRAY TEXT(atRS_estado;0)
		  //ARRAY DATE(adRS_fechaVFirma;0)
		  //ARRAY LONGINT(alRS_idRazonSocial;0)
		
	: ($vt_accion="OnLoadConf")
		C_LONGINT:C283(cs_emisorElectronico)
		cs_emisorElectronico:=0
		  //ACTcfg_opcionesDTE ("DeclaraArreglosConf")
		  //ARRAY BOOLEAN($abRS_enrolado;0)
		
		  //READ ONLY([ACT_RazonesSociales])
		  //ALL RECORDS([ACT_RazonesSociales])
		  //SELECTION TO ARRAY([ACT_RazonesSociales]razon_social;atRS_nombre;[ACT_RazonesSociales]RUT;atRS_rut;[ACT_RazonesSociales]enrolado_dte;$abRS_enrolado;[ACT_RazonesSociales]firma_fecha_vencimiento;adRS_fechaVFirma;[ACT_RazonesSociales]id;alRS_idRazonSocial)
		  //For ($i;1;Size of array($abRS_enrolado))
		  //If ($abRS_enrolado{$i})
		  //APPEND TO ARRAY(atRS_estado;__ ("Enrolado"))
		  //Else 
		  //APPEND TO ARRAY(atRS_estado;__ ("NO Enrolado"))
		  //End if 
		  //atRS_rut{$i}:=SR_FormatoRUT2 (atRS_rut{$i})
		  //End for 
		
		  // libros contables
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
		
		  //LISTBOX SELECT ROW(lb_razones;1)
		  //ACTcfg_opcionesDTE ("CargaDatosEncargado")
		
		ACTcfg_opcionesDTE ("EsEmisorElectronico";->alACTcfg_Razones{atACTcfg_Razones})  //20130903 RCH
		
		  //READ ONLY([ACT_RazonesSociales])//20130903 RCH
		  //QUERY([ACT_RazonesSociales];[ACT_RazonesSociales]id=alACTcfg_Razones{atACTcfg_Razones})
		  //cs_emisorElectronico:=Num([ACT_RazonesSociales]emisor_electronico)
		
		  //20150401 RCH carga opciones dte
		ACTdte_OpcionesManeja ("LeeBlob";->vlACT_RSSel)
		
	: ($vt_accion="EsEmisorElectronico")  //20130903 RCH
		C_REAL:C285($r_idRazonSocial)
		$r_idRazonSocial:=$vy_pointer1->
		If ($r_idRazonSocial=0)
			$r_idRazonSocial:=-1
		End if 
		
		READ ONLY:C145([ACT_RazonesSociales:279])
		QUERY:C277([ACT_RazonesSociales:279];[ACT_RazonesSociales:279]id:1=$r_idRazonSocial)
		cs_emisorElectronico:=Num:C11([ACT_RazonesSociales:279]emisor_electronico:30)
		
	: ($vt_accion="CargaDatosEncargado")
		TRACE:C157
		  //If (Not(Nil($vy_pointer1)))
		  //$vl_id:=$vy_pointer1->
		  //Else 
		  //READ WRITE([ACT_RazonesSociales])
		  //QUERY([ACT_RazonesSociales];[ACT_RazonesSociales]id=alACTcfg_Razones{atACTcfg_Razones})
		  //$vl_id:=[ACT_RazonesSociales]encargadoDTE_id
		  //End if 
		  //KRL_FindAndLoadRecordByIndex (->[Profesores]Número;->$vl_id)
		  //vtACTcaf_Nombre:=[Profesores]Apellidos_y_nombres
		
	: ($vt_accion="GetFormatoFechaWS")
		$vd_fecha:=$vy_pointer1->
		$vt_return:=String:C10(Year of:C25($vd_fecha))+"-"+String:C10(Month of:C24($vd_fecha);"00")+"-"+String:C10(Day of:C23($vd_fecha);"00")
		
	: ($vt_accion="GetFormatoRUT")
		$vt_rut:=$vy_pointer1->
		If ($vt_rut#"")
			$vt_rut:=Replace string:C233($vt_rut;".";"")
			$vt_rut:=Replace string:C233($vt_rut;"-";"")
			$vt_return:=ST_Uppercase (Insert string:C231($vt_rut;"-";Length:C16($vt_rut)))
		End if 
		
	: ($vt_accion="DeclaraArreglosPropiedadesXD")
		ARRAY TEXT:C222(atRS_Propiedad;0)
		ARRAY TEXT:C222(atRS_ValorXDefecto;0)
		ARRAY TEXT:C222(atRS_UtilizadoEn;0)
		
	: ($vt_accion="DeclaraArreglosPropiedadesRS")
		ARRAY TEXT:C222(atRS_Propiedad_RS;0)
		ARRAY TEXT:C222(atRS_Valor_RS;0)
		
	: ($vt_accion="OnLoadPropiedades")
		
		$vl_idRS:=$vy_pointer1->
		If ($vl_idRS=0)
			$vl_idRS:=-1
		End if 
		
		ACTcfg_opcionesDTE ("DeclaraArreglosPropiedadesXD")
		ACTcfg_opcionesDTE ("DeclaraArreglosPropiedadesRS")
		
		$xBlob:=KRL_GetBlobFieldData (->[ACT_RazonesSociales:279]id:1;->$vl_idRS;->[ACT_RazonesSociales:279]dte_propiedades:34)
		
		If (BLOB size:C605($xBlob)>0)
			ACTcfg_opcionesDTE ("ObtieneArreglosDesdeBlob";->$xBlob;->atRS_Propiedad;->atRS_ValorXDefecto;->atRS_UtilizadoEn)
		Else 
			CD_Dlog (0;__ ("No existe archivo con propiedades cargado en el sistema."))  //se debe cargar uno desde un archivo...
		End if 
		
	: ($vt_accion="ObtieneArreglosDesdeBlob")
		Case of 
			: (Count parameters:C259=4)
				BLOB_Blob2Vars ($vy_pointer1;0;$vy_pointer2;$vy_pointer3)
			: (Count parameters:C259=5)
				BLOB_Blob2Vars ($vy_pointer1;0;$vy_pointer2;$vy_pointer3;$vy_pointer4)
		End case 
		
	: ($vt_accion="GuardaCamposACT")
		$vb_insertar:=(Size of array:C274(atRS_Propiedad_RS)=0)
		For ($i;1;Size of array:C274(atRS_Propiedad))
			If (atRS_UtilizadoEn{$i}="3")  //configurable en ACT
				If ($vb_insertar)
					APPEND TO ARRAY:C911(atRS_Propiedad_RS;atRS_Propiedad{$i})
				End if 
				$vl_existe:=Find in array:C230($vy_pointer1->;atRS_Propiedad{$i})
				If ($vl_existe>0)
					atRS_ValorXDefecto{$i}:=$vy_pointer2->{$vl_existe}
				End if 
				If ($vb_insertar)
					APPEND TO ARRAY:C911(atRS_Valor_RS;atRS_ValorXDefecto{$i})
				End if 
			End if 
		End for 
		
		KRL_ReloadInReadWriteMode (->[ACT_RazonesSociales:279])
		BLOB_Variables2Blob (->$xBlob;0;->atRS_Propiedad;->atRS_ValorXDefecto;->atRS_UtilizadoEn)
		[ACT_RazonesSociales:279]propiedades:27:=$xBlob
		SAVE RECORD:C53([ACT_RazonesSociales:279])
		
		
	: ($vt_accion="CallWSIntranet")
		  //si es que hay cambios en las propiedades se llama al ws de la intranet.
		$vt_return:="1"
		  //If (([ACT_RazonesSociales]actualizar_propiedades) | (BLOB size([ACT_RazonesSociales]propiedades)=0))
		  //cargo arreglos de propiedades con la info de la intranet...
		$xBlob:=WSact_GetPropiedadesCont ("Especificos";[ACT_RazonesSociales:279]RUT:3)
		If (BLOB size:C605($xBlob)#0)
			KRL_ReloadInReadWriteMode (->[ACT_RazonesSociales:279])
			[ACT_RazonesSociales:279]actualizar_propiedades:28:=False:C215
			[ACT_RazonesSociales:279]propiedades:27:=$xBlob
			SAVE RECORD:C53([ACT_RazonesSociales:279])
			
			ARRAY TEXT:C222($atRS_Propiedad;0)
			ARRAY TEXT:C222($atRS_Valor;0)
			
			ACTcfg_opcionesDTE ("ObtieneArreglosDesdeBlob";->$xBlob;->$atRS_Propiedad;->$atRS_Valor)
			  //For ($i;1;Size of array(atRS_Propiedad))
			  //  //actualiza datos para envio
			  //$vl_existe:=Find in array($atRS_Propiedad;atRS_Propiedad{$i})
			  //If ($vl_existe>0)
			  //atRS_ValorXDefecto{$i}:=$atRS_Valor{$vl_existe}
			  //End if 
			  //End for 
			
			For ($i;1;Size of array:C274($atRS_Propiedad))
				  //actualiza datos para envio
				$vl_existe:=Find in array:C230(atRS_Propiedad;$atRS_Propiedad{$i})
				If ($vl_existe>0)
					atRS_ValorXDefecto{$vl_existe}:=$atRS_Valor{$i}
				End if 
			End for 
			
			  //ACTcfg_opcionesDTE ("GuardaCamposACT";->atRS_Propiedad;->atRS_ValorXDefecto)
			
		Else 
			$vt_return:="0"
		End if 
		  //End if 
		
	: ($vt_accion="ReemplazaValores")
		$vt_return:=$vy_pointer1->
		$vt_return:=Replace string:C233($vt_return;"VT_RS_RUT_COL";$vy_pointer2->)
		
End case 


$0:=$vt_return