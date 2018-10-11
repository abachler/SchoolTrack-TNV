C_LONGINT:C283(vTitFecha)
GET LIST ITEM:C378(hlTab_Menu;Selected list items:C379(hlTab_Menu);$itemRef;$itemText)
If ($itemRef#0)
	FORM GOTO PAGE:C247($itemRef)
	Case of 
		: ($itemRef=1)
			OBJECT SET VISIBLE:C603(bEnviar;True:C214)
			OBJECT SET ENABLED:C1123(bEnviar;True:C214)
		: ($itemRef=2)
			$p:=IT_UThermometer (1;0;__ ("Solicitando datos a SchoolNet…");-1)
			OBJECT SET VISIBLE:C603(bEnviar;False:C215)
			OBJECT SET ENABLED:C1123(bEnviar;False:C215)
			OBJECT SET ENABLED:C1123(bEliminarEvento;False:C215)
			OBJECT SET ENABLED:C1123(bEliminarRegistros;False:C215)
			ARRAY TEXT:C222(atQR_SNEnviosIDEvento;0)
			ARRAY DATE:C224(adQR_SNEnviosFecha;0)
			ARRAY LONGINT:C221(alQR_SNEnviosHora;0)
			ARRAY TEXT:C222(atQR_SNEnviosNombre;0)
			ARRAY DATE:C224(adQR_SNEnviosDisponibleDesde;0)
			ARRAY TEXT:C222(atQR_SNEnviosRegistros;0)
			ARRAY TEXT:C222(atQR_SNEnviosCursos;0)
			ARRAY LONGINT:C221(alQR_SNEnviosIDRegistros;0)
			ARRAY TEXT:C222(atQR_SNEnviosLinkDownload;0)
			
			C_TEXT:C284($resultadoJSON)
			$reportUUID:=[xShell_Reports:54]UUID:47
			WEB SERVICE SET PARAMETER:C777("rolbd";<>gRolBD)
			WEB SERVICE SET PARAMETER:C777("codpais";<>vtXS_CountryCode)
			WEB SERVICE SET PARAMETER:C777("idinforme";$reportUUID)
			$err:=SN3_CallWebService ("sn3ws_Informes_proceso.consulta_eventos_x_idinforme")
			IT_UThermometer (-2;$p)
			If ($err="")
				WEB SERVICE GET RESULT:C779($resultadoJSON;"resultado";*)
				
				
				C_OBJECT:C1216($ob)
				ARRAY OBJECT:C1221($oa_registros;0)
				$ob:=JSON Parse:C1218($resultadoJSON;Is object:K8:27)
				OB_GET ($ob;->$oa_registros;"registros")
				
				
				  // Modificado por: Alexis Bustamante (10-06-2017)
				  //TICKET Ticket 179869
				
				  //$root:=JSON Parse text ($resultadoJSON)
				  //$registros:=JSON Get child by position ($root;1)
				  //ARRAY TEXT($nodes1;0)
				  //ARRAY LONGINT($types1;0)
				  //ARRAY TEXT($names1;0)
				  //ARRAY TEXT($values1;0)
				  //JSON GET CHILD NODES ($registros;$nodes1;$types1;$names1)
				If (Size of array:C274($oa_registros)>0)
					
					For ($i;1;Size of array:C274($oa_registros))
						
						ARRAY TEXT:C222($nodes;0)
						ARRAY LONGINT:C221($types;0)
						ARRAY TEXT:C222($names;0)
						
						C_TEXT:C284($evento;$nombre;$year;$mes;$dia)
						C_DATE:C307($fecha;$fechaDisp)
						C_TIME:C306($hora)
						
						OB_GET ($oa_registros{$i};->$evento;"idevento")
						OB_GET ($oa_registros{$i};->$nombre;"nombre")
						OB_GET ($oa_registros{$i};->$year;"year_disponible_desde")
						OB_GET ($oa_registros{$i};->$mes;"month_disponible_desde")
						OB_GET ($oa_registros{$i};->$dia;"day_disponible_desde")
						
						$fecha:=DTS_GetDate ($evento)
						$hora:=DTS_GetTime ($evento)
						
						  //:=JSON Get text ($nodes{2})
						  //:=Num(JSON Get text ($nodes{3}))
						  //:=Num(JSON Get text ($nodes{4}))
						  //:=Num(JSON Get text ($nodes{5}))
						$fechaDisp:=DT_GetDateFromDayMonthYear (Num:C11($dia);Num:C11($mes);Num:C11($year))
						
						APPEND TO ARRAY:C911(atQR_SNEnviosIDEvento;$evento)
						APPEND TO ARRAY:C911(adQR_SNEnviosFecha;$fecha)
						APPEND TO ARRAY:C911(alQR_SNEnviosHora;$hora)
						APPEND TO ARRAY:C911(atQR_SNEnviosNombre;$nombre)
						APPEND TO ARRAY:C911(adQR_SNEnviosDisponibleDesde;$fechaDisp)
					End for 
					  //For ($j;1;Size of array($nodes1))
					  //ARRAY TEXT($nodes;0)
					  //ARRAY LONGINT($types;0)
					  //ARRAY TEXT($names;0)
					  //JSON GET CHILD NODES ($nodes1{$j};$nodes;$types;$names)
					
					  //$evento:=JSON Get text ($nodes{1})
					  //$fecha:=DTS_GetDate ($evento)
					  //$hora:=DTS_GetTime ($evento)
					  //$nombre:=JSON Get text ($nodes{2})
					  //$year:=Num(JSON Get text ($nodes{3}))
					  //$mes:=Num(JSON Get text ($nodes{4}))
					  //$dia:=Num(JSON Get text ($nodes{5}))
					  //$fechaDisp:=DT_GetDateFromDayMonthYear ($dia;$mes;$year)
					  //APPEND TO ARRAY(atQR_SNEnviosIDEvento;$evento)
					  //APPEND TO ARRAY(adQR_SNEnviosFecha;$fecha)
					  //APPEND TO ARRAY(alQR_SNEnviosHora;$hora)
					  //APPEND TO ARRAY(atQR_SNEnviosNombre;$nombre)
					  //APPEND TO ARRAY(adQR_SNEnviosDisponibleDesde;$fechaDisp)
					  //End for 
					
					
					
					LISTBOX SORT COLUMNS:C916(lbEventos;1;<;2;<)
					vTitFecha:=1
					LISTBOX SELECT ROW:C912(lbEventos;0;lk remove from selection:K53:3)
					ARRAY TEXT:C222(atQR_SNEnviosRegistros;0)
					LISTBOX DELETE COLUMN:C830(lbRegistros;2)
				End if 
				  //JSON CLOSE ($root)  //20150421 RCH Se agrega cierre
			Else 
				CD_Dlog (0;__ ("No se pudo establecer la conexión con SchoolNet."))
			End if 
	End case 
End if 