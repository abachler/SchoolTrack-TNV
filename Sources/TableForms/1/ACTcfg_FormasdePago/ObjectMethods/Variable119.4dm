C_LONGINT:C283($el;$i;$l_Registros;$l_totalRegistros)
C_POINTER:C301($y_campo)
C_TEXT:C284($t_valorLiteral)
C_LONGINT:C283($line)

$line:=AL_GetLine (xALP_FormasdePago)
If ($line>0)
	  //[ACT_Pagos]
	  //[Personas]
	  //[xxACT_ArchivosBancarios]
	  //[ACT_Documentos_en_Cartera]
	  //[ACT_CuentasCorrientes]
	ARRAY POINTER:C280($alACT_fields;0)
	APPEND TO ARRAY:C911($alACT_fields;->[ACT_Pagos:172]id_forma_de_pago:30)
	APPEND TO ARRAY:C911($alACT_fields;->[Personas:7]ACT_id_modo_de_pago:94)
	APPEND TO ARRAY:C911($alACT_fields;->[xxACT_ArchivosBancarios:118]id_forma_de_pago:13)
	APPEND TO ARRAY:C911($alACT_fields;->[ACT_Documentos_en_Cartera:182]id_forma_de_pago:19)
	APPEND TO ARRAY:C911($alACT_fields;->[ACT_CuentasCorrientes:175]id_modo_de_pago:32)
	
	ARRAY TEXT:C222($atACT_nombres;0)
	APPEND TO ARRAY:C911($atACT_nombres;"Pagos")
	APPEND TO ARRAY:C911($atACT_nombres;"Apoderados")
	APPEND TO ARRAY:C911($atACT_nombres;"Archivos bancarios")
	APPEND TO ARRAY:C911($atACT_nombres;"Documentos en cartera")
	APPEND TO ARRAY:C911($atACT_nombres;"Cuentas")
	
	_O_ARRAY STRING:C218(35;aInfos1;0)
	ARRAY LONGINT:C221(aInfos2;0)
	ARRAY LONGINT:C221(aInfos3;0)
	ARRAY REAL:C219(aInfos4;0)
	For ($i;1;Size of array:C274($alACT_fields))
		C_POINTER:C301($vy_punteroTabla;$vy_pointer2Field)
		$vy_pointer2Field:=$alACT_fields{$i}
		$vy_punteroTabla:=Table:C252(Table:C252($vy_pointer2Field))
		
		READ ONLY:C145($vy_punteroTabla->)
		  //SET QUERY DESTINATION(Into variable;$l_Registros) //se necesita filtrar los apdos
		
		QUERY:C277($vy_punteroTabla->;$alACT_fields{$i}->;=;alACT_FormasdePagoID{$line})
		Case of 
			: (KRL_isSameField (->[Personas:7]ACT_id_modo_de_pago:94;$vy_pointer2Field))
				QUERY SELECTION:C341([Personas:7];[Personas:7]ES_Apoderado_de_Cuentas:42=True:C214)
				$l_Registros:=Records in selection:C76($vy_punteroTabla->)
				QUERY:C277([Personas:7];[Personas:7]ES_Apoderado_de_Cuentas:42=True:C214)
				$l_totalRegistros:=Records in selection:C76($vy_punteroTabla->)
				  //: (KRL_isSameField (->[ACT_CuentasCorrientes]id_modo_de_pago;$vy_pointer2Field))
				  //QUERY SELECTION([ACT_CuentasCorrientes];[ACT_CuentasCorrientes]Estado=True)
				  //$l_Registros:=Records in selection($vy_punteroTabla->)
				  //QUERY([ACT_CuentasCorrientes];[ACT_CuentasCorrientes]Estado=True)
				  //$l_totalRegistros:=Records in selection($vy_punteroTabla->)
				
			: (KRL_isSameField (->[xxACT_ArchivosBancarios:118]id_forma_de_pago:13;$vy_pointer2Field))
				QUERY SELECTION:C341([xxACT_ArchivosBancarios:118];[xxACT_ArchivosBancarios:118]Rol_BD:8=<>gRolBD)
				$l_Registros:=Records in selection:C76($vy_punteroTabla->)
				QUERY:C277([xxACT_ArchivosBancarios:118];[xxACT_ArchivosBancarios:118]Rol_BD:8=<>gRolBD)
				$l_totalRegistros:=Records in selection:C76($vy_punteroTabla->)
				
			Else 
				$l_Registros:=Records in selection:C76($vy_punteroTabla->)
				$l_totalRegistros:=Records in table:C83($vy_punteroTabla->)
		End case 
		
		APPEND TO ARRAY:C911(aInfos1;$atACT_nombres{$i})
		APPEND TO ARRAY:C911(aInfos2;$l_Registros)
		APPEND TO ARRAY:C911(aInfos3;$l_totalRegistros)
		APPEND TO ARRAY:C911(aInfos4;Round:C94((($l_Registros/$l_totalRegistros)*100);2))
		
		  //SET QUERY DESTINATION(Into current selection)
	End for 
	
	$vt_formaDePago:=ACTcfg_OpcionesFormasDePago ("GetFormaDePagoXID";->alACT_FormasdePagoID{$line})
	
	WDW_OpenFormWindow (->[ACT_Formas_de_Pago:287];"Info";7;Palette form window:K39:9;$vt_formaDePago)
	DIALOG:C40([ACT_Formas_de_Pago:287];"Info")
	CLOSE WINDOW:C154
	AT_Initialize (->aInfos1;->aInfos2;->aInfos3;->aInfos4)
	
	
End if 
