//%attributes = {}
  //CMT_Transferencia

C_TEXT:C284($vt_accion;$1;$0;$vt_retorno)
C_TEXT:C284($vt_accion;$vt_app)
C_POINTER:C301($ptr1;$ptr2;$ptr3)
ARRAY INTEGER:C220(al_PosCampos;0)
ARRAY INTEGER:C220(al_PosTablas;0)

If (Count parameters:C259>=1)
	$vt_accion:=$1
End if 
If (Count parameters:C259>=2)
	$ptr1:=$2
End if 
If (Count parameters:C259>=3)
	$ptr2:=$3
End if 
If (Count parameters:C259>=4)
	$ptr3:=$4
End if 

Case of 
	: ($vt_accion="")
		If (USR_GetUserID <0)
			WDW_OpenFormWindow (->[CMT_Transferencia:158];"ConfiguracionCampos2Actualizar";-1;4;__ ("Asistente"))
			DIALOG:C40([CMT_Transferencia:158];"ConfiguracionCampos2Actualizar")
			CLOSE WINDOW:C154
		End if 
		
	: ($vt_accion="DeclaraArreglosInterfaz")
		ARRAY LONGINT:C221(alCM_id;0)
		ARRAY TEXT:C222(atCM_Aplicacion;0)
		ARRAY TEXT:C222(atCM_Tabla;0)
		ARRAY TEXT:C222(atCM_Campo;0)
		ARRAY TEXT:C222(atCM_Alias;0)
		ARRAY TEXT:C222(atCM_TextAliasCampo;0)
		ARRAY TEXT:C222(atCM_Formula;0)
		ARRAY LONGINT:C221(alCM_Tabla;0)
		ARRAY LONGINT:C221(alCM_Campo;0)
		ARRAY LONGINT:C221(alCM_idVSAlias;0)
		ARRAY BOOLEAN:C223(abCM_GuardaModificaciones;0)
		ARRAY BOOLEAN:C223(abCM_EnviarCampoSiempre;0)
		ARRAY TEXT:C222(atCM_TablaBase;0)
		ARRAY LONGINT:C221(alCM_TablaBase;0)
		
		
		ARRAY TEXT:C222(atCMTabla_Tabla;0)
		ARRAY TEXT:C222(atCMTabla_AliasRaiz;0)
		ARRAY TEXT:C222(atCMTabla_AliasElemento;0)
		ARRAY LONGINT:C221(alCMTabla_idTabla;0)
		ARRAY TEXT:C222(atCMTabla_Aplicacion;0)
		ARRAY LONGINT:C221(alCMTabla_ID;0)
		ARRAY TEXT:C222(atCMTabla_Formula;0)
		ARRAY TEXT:C222(atCMTabla_IDCampo;0)
		ARRAY LONGINT:C221(alCMTabla_IDCampo;0)
		
	: ($vt_accion="EliminarElemento")
		$line:=AL_GetLine (xALP_AreaTransferencia)
		If ($line#0)
			$resp:=CD_Dlog (0;__ ("Está seguro de que desea eliminar el campo seleccionado. Esta acción eliminará todas las referencias asociadas...");__ ("");__ ("Si");__ ("No"))
			If ($resp=1)
				$vl_idTransferencia:=alCM_id{$line}
				CMT_RegistrosMarcados ("EliminarElemento";->$vl_idTransferencia)
				READ WRITE:C146([CMT_Transferencia:158])
				QUERY:C277([CMT_Transferencia:158];[CMT_Transferencia:158]Id:1=$vl_idTransferencia)
				DELETE RECORD:C58([CMT_Transferencia:158])
				KRL_UnloadReadOnly (->[CMT_Transferencia:158])
				$vl_idTabla:=alCM_TablaBase{$line}
				AL_UpdateArrays (xALP_AreaTransferencia;0)
				AT_Delete ($line;1;->alCM_id;->atCM_Aplicacion;->atCM_Tabla;->atCM_Campo;->atCM_Alias;->atCM_TextAliasCampo;->atCM_Formula;->alCM_Tabla;->alCM_Campo;->alCM_idVSAlias;->abCM_GuardaModificaciones;->abCM_EnviarCampoSiempre;->atCM_TablaBase;->alCM_TablaBase)
				AL_UpdateArrays (xALP_AreaTransferencia;-2)
				If (Find in array:C230(alCM_TablaBase;$vl_idTabla)=-1)
					$el:=Find in array:C230(alCMTabla_idTabla;$vl_idTabla)
					If ($el#-1)
						AL_UpdateArrays (xALP_AreaTransferenciaTablas;0)
						AT_Delete ($el;1;->atCMTabla_Tabla;->atCMTabla_AliasRaiz;->atCMTabla_AliasElemento;->alCMTabla_idTabla;->atCMTabla_Aplicacion;->alCMTabla_ID;->atCMTabla_Formula;->alCMTabla_IDCampo;->atCMTabla_IDCampo)
						AL_UpdateArrays (xALP_AreaTransferenciaTablas;-2)
					End if 
				End if 
			End if 
		End if 
		
	: ($vt_accion="AgregarElemento")
		If (vtCM_Aplicacion#"")
			WDW_OpenFormWindow (->[xShell_Dialogs:114];"SelectFieldOrdenado";0;5)
			DIALOG:C40([xShell_Dialogs:114];"SelectFieldOrdenado")
			CLOSE WINDOW:C154
			If ((ok=1) & (at_TablaPop>0) & (at_CamposPop>0))
				C_POINTER:C301($file;$field)
				C_LONGINT:C283($vl_file;$vl_field)
				
				$file:=Table:C252(al_PosTablas{at_TablaPop})
				$field:=Field:C253(al_PosTablas{at_TablaPop};al_PosCampos{at_CamposPop})
				$vl_file:=Table:C252($file)
				$vl_field:=Field:C253($field)
				
				ARRAY LONGINT:C221($al_posTabla;0)
				ARRAY LONGINT:C221($al_posCampo;0)
				ARRAY LONGINT:C221($al_resultado;0)
				alCM_TablaBase{0}:=$vl_file
				AT_SearchArray (->alCM_TablaBase;"=";->$al_posTabla)
				alCM_Campo{0}:=$vl_field
				AT_SearchArray (->alCM_Campo;"=";->$al_posCampo)
				AT_intersect (->$al_posTabla;->$al_posCampo;->$al_resultado)
				
				If (Size of array:C274($al_resultado)=0)
					AL_UpdateArrays (xALP_AreaTransferencia;0)
					APPEND TO ARRAY:C911(alCM_id;SQ_SeqNumber (->[CMT_Transferencia:158]Id:1))
					APPEND TO ARRAY:C911(atCM_Aplicacion;vtCM_Aplicacion)
					APPEND TO ARRAY:C911(atCM_Tabla;Table name:C256($vl_file))
					APPEND TO ARRAY:C911(atCM_Campo;Field name:C257($vl_file;$vl_field))
					APPEND TO ARRAY:C911(alCM_Tabla;$vl_file)
					APPEND TO ARRAY:C911(alCM_Campo;$vl_field)
					READ ONLY:C145([xShell_Fields:52])
					QUERY:C277([xShell_Fields:52];[xShell_Fields:52]NumeroTabla:1=$vl_file;*)
					QUERY:C277([xShell_Fields:52]; & ;[xShell_Fields:52]NumeroCampo:2=$vl_field)
					APPEND TO ARRAY:C911(alCM_idVSAlias;[xShell_Fields:52]ID:24)
					APPEND TO ARRAY:C911(atCM_Alias;XSvs_nombreCampoLocal_Numero (alCM_Tabla{Size of array:C274(alCM_Tabla)};alCM_idVSAlias{Size of array:C274(alCM_idVSAlias)};<>vtXS_CountryCode;<>vtXS_langage))
					APPEND TO ARRAY:C911(atCM_TextAliasCampo;"")
					APPEND TO ARRAY:C911(atCM_Formula;"")
					APPEND TO ARRAY:C911(abCM_GuardaModificaciones;True:C214)
					APPEND TO ARRAY:C911(abCM_EnviarCampoSiempre;False:C215)
					
					APPEND TO ARRAY:C911(alCM_TablaBase;alCM_Tabla{Size of array:C274(alCM_Tabla)})
					APPEND TO ARRAY:C911(atCM_TablaBase;atCM_Alias{Size of array:C274(atCM_Tabla)})
					
					AL_UpdateArrays (xALP_AreaTransferencia;-2)
					CMT_Transferencia ("ValidaRegistroTabla")
				Else 
					CD_Dlog (0;__ ("El campo ya existe en la lista..."))
				End if 
			End if 
		Else 
			CD_Dlog (0;__ ("Ingrese para qué aplicación quiere seleccionar campos..."))
		End if 
		
	: ($vt_accion="ActualizaBool")
		If (alProEvt=1)
			$line:=AL_GetLine (xALP_AreaTransferencia)
			$col:=AL_GetColumn (xALP_AreaTransferencia)
			If ($line>0)
				Case of 
					: ($col=9)
						abCM_GuardaModificaciones{$line}:=Not:C34(abCM_GuardaModificaciones{$line})
					: ($col=10)
						abCM_EnviarCampoSiempre{$line}:=Not:C34(abCM_EnviarCampoSiempre{$line})
						
				End case 
				AL_UpdateArrays (xALP_AreaTransferencia;-1)
			End if 
		End if 
		REDRAW WINDOW:C456
		
	: ($vt_accion="InicializaArreglos")
		AT_Initialize (->alCM_id;->atCM_Aplicacion;->atCM_Tabla;->atCM_Campo;->atCM_Alias;->atCM_TextAliasCampo;->atCM_Formula;->alCM_Tabla;->alCM_Campo;->alCM_idVSAlias;->abCM_GuardaModificaciones;->abCM_EnviarCampoSiempre;->atCM_TablaBase;->alCM_TablaBase)
		AT_Initialize (->atCMTabla_Tabla;->atCMTabla_AliasRaiz;->atCMTabla_AliasElemento;->alCMTabla_idTabla;->atCMTabla_Aplicacion;->alCMTabla_ID;->atCMTabla_Formula;->alCMTabla_IDCampo;->atCMTabla_IDCampo)
		
	: ($vt_accion="LlenaPopUp")
		READ ONLY:C145([CMT_Transferencia:158])
		ALL RECORDS:C47([CMT_Transferencia:158])
		AT_Initialize ($ptr1)
		AT_DistinctsFieldValues (->[CMT_Transferencia:158]Aplicacion:2;$ptr1)
		
		
	: ($vt_accion="CargaRegistrosExistentes")
		$vl_pos:=$ptr1->
		CMT_Transferencia ("InicializaArreglos")
		AL_UpdateArrays (xALP_AreaTransferencia;0)
		READ ONLY:C145([CMT_Transferencia:158])
		QUERY:C277([CMT_Transferencia:158];[CMT_Transferencia:158]Aplicacion:2=$ptr1->{$vl_pos};*)
		QUERY:C277([CMT_Transferencia:158]; & ;[CMT_Transferencia:158]LlaveTabla:13="")
		SELECTION TO ARRAY:C260([CMT_Transferencia:158]Id:1;alCM_id;[CMT_Transferencia:158]Aplicacion:2;atCM_Aplicacion;[CMT_Transferencia:158]FormulaAAplicar:7;atCM_Formula)
		SELECTION TO ARRAY:C260([CMT_Transferencia:158]Id_Campo:4;alCM_Campo;[CMT_Transferencia:158]Id_Tabla:3;alCM_Tabla;[CMT_Transferencia:158]ID_VS_Alias:8;alCM_idVSAlias)
		SELECTION TO ARRAY:C260([CMT_Transferencia:158]TextoAliasCampoXML:5;atCM_TextAliasCampo;[CMT_Transferencia:158]TablaBase:12;alCM_TablaBase)
		SELECTION TO ARRAY:C260([CMT_Transferencia:158]GuardarModificaciones:9;abCM_GuardaModificaciones;[CMT_Transferencia:158]EnviarSiempre:10;abCM_EnviarCampoSiempre)
		For ($i;1;Size of array:C274(alCM_id))
			APPEND TO ARRAY:C911(atCM_Tabla;Table name:C256(alCM_Tabla{$i}))
			APPEND TO ARRAY:C911(atCM_Campo;Field name:C257(alCM_Tabla{$i};alCM_Campo{$i}))
			APPEND TO ARRAY:C911(atCM_Alias;XSvs_nombreCampoLocal_Numero (alCM_Tabla{$i};alCM_idVSAlias{$i};<>vtXS_CountryCode;<>vtXS_langage))
			APPEND TO ARRAY:C911(atCM_TablaBase;Table name:C256(alCM_TablaBase{$i}))
		End for 
		AL_UpdateArrays (xALP_AreaTransferencia;-2)
		
		
		AL_UpdateArrays (xALP_AreaTransferenciaTablas;0)
		READ ONLY:C145([CMT_Transferencia:158])
		QUERY:C277([CMT_Transferencia:158];[CMT_Transferencia:158]Aplicacion:2=$ptr1->{$vl_pos};*)
		QUERY:C277([CMT_Transferencia:158]; & ;[CMT_Transferencia:158]LlaveTabla:13#"")
		SELECTION TO ARRAY:C260([CMT_Transferencia:158]Id_Tabla:3;alCMTabla_idTabla;[CMT_Transferencia:158]Aplicacion:2;atCMTabla_Aplicacion)
		SELECTION TO ARRAY:C260([CMT_Transferencia:158]TextoAliasCampoXML:5;atCMTabla_AliasElemento;[CMT_Transferencia:158]Id:1;alCMTabla_ID)
		SELECTION TO ARRAY:C260([CMT_Transferencia:158]TextoAliasTablaXML:6;atCMTabla_AliasRaiz;[CMT_Transferencia:158]FormulaAAplicar:7;atCMTabla_Formula)
		SELECTION TO ARRAY:C260([CMT_Transferencia:158]Id_Campo:4;alCMTabla_IDCampo)
		
		For ($i;1;Size of array:C274(alCMTabla_idTabla))
			APPEND TO ARRAY:C911(atCMTabla_Tabla;Table name:C256(alCMTabla_idTabla{$i}))
			APPEND TO ARRAY:C911(atCMTabla_IDCampo;Field name:C257(alCMTabla_idTabla{$i};alCMTabla_IDCampo{$i}))
		End for 
		  //AT_RedimArrays (1;->atCMTabla_Tabla;->atCMTabla_IDCampo)
		AL_UpdateArrays (xALP_AreaTransferenciaTablas;-2)
		
	: ($vt_accion="ValidaRegistroTabla")
		AL_UpdateArrays (xALP_AreaTransferenciaTablas;0)
		ARRAY LONGINT:C221($al_idsTablas;0)
		COPY ARRAY:C226(alCM_TablaBase;$al_idsTablas)
		AT_DistinctsArrayValues (->$al_idsTablas)
		For ($i;1;Size of array:C274($al_idsTablas))
			If (Find in array:C230(alCMTabla_idTabla;$al_idsTablas{$i})=-1)
				APPEND TO ARRAY:C911(alCMTabla_idTabla;$al_idsTablas{$i})
				APPEND TO ARRAY:C911(atCMTabla_Tabla;Table name:C256($al_idsTablas{$i}))
				APPEND TO ARRAY:C911(atCMTabla_AliasRaiz;ST_Lowercase (Table name:C256($al_idsTablas{$i})))
				APPEND TO ARRAY:C911(atCMTabla_AliasElemento;ST_Lowercase (Substring:C12(Table name:C256($al_idsTablas{$i});1;Length:C16(Table name:C256($al_idsTablas{$i}))-1)))
				APPEND TO ARRAY:C911(atCMTabla_Aplicacion;vtCM_Aplicacion)
				APPEND TO ARRAY:C911(alCMTabla_ID;SQ_SeqNumber (->[CMT_Transferencia:158]Id:1))
				APPEND TO ARRAY:C911(atCMTabla_Formula;"")
				APPEND TO ARRAY:C911(alCMTabla_IDCampo;0)
				APPEND TO ARRAY:C911(atCMTabla_IDCampo;"")
			End if 
		End for 
		For ($i;Size of array:C274(alCMTabla_idTabla);1;-1)
			If (Find in array:C230(alCM_TablaBase;alCMTabla_idTabla{$i})=-1)
				AT_Delete ($i;1;->atCMTabla_Tabla;->atCMTabla_AliasRaiz;->atCMTabla_AliasElemento;->alCMTabla_idTabla;->atCMTabla_Aplicacion;->alCMTabla_ID;->atCMTabla_Formula;->alCMTabla_IDCampo;->atCMTabla_IDCampo)
			End if 
		End for 
		AL_UpdateArrays (xALP_AreaTransferenciaTablas;-2)
		
	: ($vt_accion="Guardar")
		$vb_continuar:=False:C215
		atCM_TextAliasCampo{0}:=""
		ARRAY LONGINT:C221($DA_Return;0)
		AT_SearchArray (->atCM_TextAliasCampo;"=";->$DA_Return)
		If (Size of array:C274($DA_Return)=0)
			atCMTabla_AliasRaiz{0}:=""
			ARRAY LONGINT:C221($DA_Return;0)
			AT_SearchArray (->atCMTabla_AliasRaiz;"=";->$DA_Return)
			If (Size of array:C274($DA_Return)=0)
				atCMTabla_AliasElemento{0}:=""
				ARRAY LONGINT:C221($DA_Return;0)
				AT_SearchArray (->atCMTabla_AliasElemento;"=";->$DA_Return)
				If (Size of array:C274($DA_Return)=0)
					If (CMT_Transferencia ("ValidaIdsXTabla")="1")
						If (CMT_Transferencia ("ValidaEtiquetas")="1")
							$vb_continuar:=True:C214
						Else 
							CD_Dlog (0;__ ("Existen etiquetas duplicadas para una misma tabla."))
						End if 
					Else 
						CD_Dlog (0;__ ("Defina al menos un identificador por cada tabla."))
					End if 
				Else 
					CD_Dlog (0;__ ("La columna Elemento no puede tener valores vacíos."))
				End if 
			Else 
				CD_Dlog (0;__ ("La columna Raiz no puede tener valores vacíos."))
			End if 
		Else 
			CD_Dlog (0;__ ("La columna Alias XML Campo no puede tener valores vacíos."))
		End if 
		If ($vb_continuar)
			READ WRITE:C146([CMT_Transferencia:158])
			For ($i;1;Size of array:C274(alCM_idVSAlias))
				$vt_key:=vtCM_Aplicacion+"."+String:C10(alCM_TablaBase{$i})+"."+String:C10(alCM_Tabla{$i})+"."+String:C10(alCM_Campo{$i})
				$index:=Find in field:C653([CMT_Transferencia:158]Key:11;$vt_key)
				If ($index=-1)
					CREATE RECORD:C68([CMT_Transferencia:158])
					[CMT_Transferencia:158]Id:1:=alCM_id{$i}
				Else 
					GOTO RECORD:C242([CMT_Transferencia:158];$index)
				End if 
				[CMT_Transferencia:158]Aplicacion:2:=atCM_Aplicacion{$i}
				[CMT_Transferencia:158]FormulaAAplicar:7:=atCM_Formula{$i}
				[CMT_Transferencia:158]Id_Campo:4:=alCM_Campo{$i}
				[CMT_Transferencia:158]Id_Tabla:3:=alCM_Tabla{$i}
				[CMT_Transferencia:158]ID_VS_Alias:8:=alCM_idVSAlias{$i}
				[CMT_Transferencia:158]TextoAliasCampoXML:5:=atCM_TextAliasCampo{$i}
				[CMT_Transferencia:158]GuardarModificaciones:9:=abCM_GuardaModificaciones{$i}
				[CMT_Transferencia:158]EnviarSiempre:10:=abCM_EnviarCampoSiempre{$i}
				[CMT_Transferencia:158]TablaBase:12:=alCM_TablaBase{$i}
				[CMT_Transferencia:158]LlaveTabla:13:=""
				[CMT_Transferencia:158]Key:11:=[CMT_Transferencia:158]Aplicacion:2+"."+String:C10([CMT_Transferencia:158]TablaBase:12)+"."+String:C10([CMT_Transferencia:158]Id_Tabla:3)+"."+String:C10([CMT_Transferencia:158]Id_Campo:4)
				SAVE RECORD:C53([CMT_Transferencia:158])
			End for 
			For ($i;1;Size of array:C274(alCMTabla_idTabla))
				$llave_Tabla:=vtCM_Aplicacion+"."+String:C10(alCMTabla_idTabla{$i})
				$index:=Find in field:C653([CMT_Transferencia:158]LlaveTabla:13;$llave_Tabla)
				If ($index=-1)
					CREATE RECORD:C68([CMT_Transferencia:158])
					[CMT_Transferencia:158]Id:1:=alCMTabla_ID{$i}
				Else 
					GOTO RECORD:C242([CMT_Transferencia:158];$index)
				End if 
				[CMT_Transferencia:158]Aplicacion:2:=atCMTabla_Aplicacion{$i}
				[CMT_Transferencia:158]Id_Tabla:3:=alCMTabla_idTabla{$i}
				[CMT_Transferencia:158]TablaBase:12:=alCMTabla_idTabla{$i}
				[CMT_Transferencia:158]TextoAliasTablaXML:6:=atCMTabla_AliasRaiz{$i}
				[CMT_Transferencia:158]TextoAliasCampoXML:5:=atCMTabla_AliasElemento{$i}
				[CMT_Transferencia:158]FormulaAAplicar:7:=atCMTabla_Formula{$i}
				[CMT_Transferencia:158]Id_Campo:4:=alCMTabla_IDCampo{$i}
				[CMT_Transferencia:158]LlaveTabla:13:=[CMT_Transferencia:158]Aplicacion:2+"."+String:C10([CMT_Transferencia:158]TablaBase:12)
				[CMT_Transferencia:158]Key:11:=""
				SAVE RECORD:C53([CMT_Transferencia:158])
			End for 
			KRL_UnloadReadOnly (->[CMT_Transferencia:158])
			  //ACTwtrf_SaveLibrary 
			  //se guarda solo lo de commtrack por defecto. Lo demás que quiera guardarse se debe hacer a través del botón del formulario
			If (Not:C34(Is nil pointer:C315($ptr1)))
				$vt_app:=$ptr1->
			Else 
				$vt_app:=String:C10(CommTrack)
			End if 
			CMT_Transferencia ("GuardaLibreria";->$vt_app)
			CMT_Transferencia ("InicializaArreglos")
			ACCEPT:C269
		End if 
		
	: ($vt_accion="GuardaLibreria")
		CMT_GuardaLibreria 
		
	: ($vt_accion="CargaLibreria")
		CMT_CargaLibreria 
		
	: ($vt_accion="LimpiaTabla")
		$l_borrado:=CMT_LimpiaConfiguracion 
		$vt_retorno:=String:C10($l_borrado)
		
	: ($vt_accion="ObtieneDatoFormatoTexto")
		$vl_type:=Type:C295($ptr1->)
		Case of 
			: (($vl_type=1) | ($vl_type=8) | ($vl_type=9))
				$ptr2->:=String:C10($ptr1->)
			: ($vl_type=4)
				$ptr2->:=String:C10($ptr1->)
			: (($vl_type=24) | ($vl_type=2) | ($vl_type=0))
				$ptr2->:=$ptr1->
			: ($vl_type=6)
				$ptr2->:=String:C10(Num:C11($ptr1->))
			Else 
				$ptr2->:=""
		End case 
		
	: ($vt_accion="ValidaIdsXTabla")
		ARRAY LONGINT:C221($al_tablas;0)
		COPY ARRAY:C226(alCM_TablaBase;$al_tablas)
		AT_DistinctsArrayValues (->$al_tablas)
		For ($i;1;Size of array:C274($al_tablas))
			$vb_validado:=False:C215
			alCM_TablaBase{0}:=$al_tablas{$i}
			ARRAY LONGINT:C221($DA_Return;0)
			AT_SearchArray (->alCM_TablaBase;"=";->$DA_Return)
			For ($j;1;Size of array:C274($DA_Return))
				If (abCM_EnviarCampoSiempre{$DA_Return{$j}})
					$j:=Size of array:C274($DA_Return)
					$vb_validado:=True:C214
				End if 
			End for 
			If (Not:C34($vb_validado))
				$i:=Size of array:C274($al_tablas)
			End if 
		End for 
		$vt_retorno:=String:C10(Num:C11($vb_validado))
		
	: ($vt_accion="AgregarIdentificador")
		$line:=AL_GetLine (xALP_AreaTransferenciaTablas)
		If ($line>0)
			AL_UpdateArrays (xALP_AreaTransferenciaTablas;0)
			ARRAY TEXT:C222(atCMT_NombreCampos;0)
			ARRAY LONGINT:C221(alCMT_NombreCampos;0)
			For ($i;1;Get last field number:C255(alCMTabla_idTabla{$line}))
				  //20130321 RCH
				If (Is field number valid:C1000(alCMTabla_idTabla{$line};$i))
					APPEND TO ARRAY:C911(atCMT_NombreCampos;Field name:C257(alCMTabla_idTabla{$line};$i))
					APPEND TO ARRAY:C911(alCMT_NombreCampos;$i)
				End if 
			End for 
			If (Size of array:C274(atCMT_NombreCampos)>50)
				ARRAY POINTER:C280(<>aChoicePtrs;0)
				APPEND TO ARRAY:C911(<>aChoicePtrs;->atCMT_NombreCampos)
				APPEND TO ARRAY:C911(<>aChoicePtrs;->alCMT_NombreCampos)
				TBL_ShowChoiceList (0;"Seleccione el campo llave...";0)
				If (choiceIdx>0)
					$choice:=alCMT_NombreCampos{choiceIdx}
				Else 
					$choice:=0
				End if 
			Else 
				$choice:=Pop up menu:C542(AT_array2text (->atCMT_NombreCampos;";"))
			End if 
			If ($choice#0)
				alCMTabla_IDCampo{$line}:=$choice
				atCMTabla_IDCampo{$line}:=Field name:C257(alCMTabla_idTabla{$line};alCMTabla_IDCampo{$line})
				  //alCMTabla_idTabla
			End if 
			AL_UpdateArrays (xALP_AreaTransferenciaTablas;-2)
		End if 
		
	: ($vt_accion="ValidaEtiquetas")
		C_LONGINT:C283($line)
		If (Not:C34(Is nil pointer:C315($ptr1)))
			$line:=$ptr1->
		End if 
		ARRAY LONGINT:C221($al_tablas;0)
		ARRAY TEXT:C222($at_etiquetas;0)
		ARRAY LONGINT:C221($al_line;0)
		If ($line=0)
			COPY ARRAY:C226(alCM_TablaBase;$al_tablas)
			AT_DistinctsArrayValues (->$al_tablas)
		Else 
			APPEND TO ARRAY:C911($al_tablas;alCM_TablaBase{$line})
			APPEND TO ARRAY:C911($al_line;$line)
		End if 
		For ($i;1;Size of array:C274($al_tablas))
			ARRAY TEXT:C222($at_etiquetas;0)
			If ($line=0)
				ARRAY LONGINT:C221($al_line;0)
			End if 
			alCM_TablaBase{0}:=$al_tablas{$i}
			ARRAY LONGINT:C221($DA_Return;0)
			AT_SearchArray (->alCM_TablaBase;"=";->$DA_Return)
			For ($j;1;Size of array:C274($DA_Return))
				APPEND TO ARRAY:C911($at_etiquetas;atCM_TextAliasCampo{$DA_Return{$j}})
				If ($line=0)
					APPEND TO ARRAY:C911($al_line;$DA_Return{$j})
				End if 
			End for 
			For ($j;1;Size of array:C274($al_line))
				$vb_validado:=False:C215
				$at_etiquetas{0}:=atCM_TextAliasCampo{$al_line{$j}}
				ARRAY LONGINT:C221($DA_Return;0)
				AT_SearchArray (->$at_etiquetas;"=";->$DA_Return)
				If (Size of array:C274($DA_Return)=1)
					$vb_validado:=True:C214
				Else 
					$j:=Size of array:C274($al_line)
				End if 
			End for 
			If (Not:C34($vb_validado))
				$i:=Size of array:C274($al_tablas)
			End if 
		End for 
		$vt_retorno:=String:C10(Num:C11($vb_validado))
		
	: ($vt_accion="OnLoad")
		If (Not:C34(Is nil pointer:C315($ptr1)))
			$vt_app:=$ptr1->
		Else 
			ARRAY TEXT:C222(atCM_PopUp;0)
			CMT_Transferencia ("LlenaPopUp";->atCM_PopUp)
			$vt_app:=""
		End if 
		If ($vt_app="")
			If (Size of array:C274(atCM_PopUp)>0)
				atCM_PopUp:=1
			End if 
		Else 
			atCM_PopUp:=Find in array:C230(atCM_PopUp;$vt_app)
			If (atCM_PopUp=-1)
				atCM_PopUp:=0
			End if 
		End if 
		vtCM_Aplicacion:=atCM_PopUp{atCM_PopUp}
		CMT_Transferencia ("CargaRegistrosExistentes";->atCM_PopUp)
		
End case 
$0:=$vt_retorno