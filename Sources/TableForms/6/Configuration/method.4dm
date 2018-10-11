Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetConfigInterface 
		
		$nivel_Seleccionado:=<>aNivel
		ARRAY TEXT:C222(at_AttendanceMode;4)
		at_AttendanceMode{1}:=__ ("Diario")
		at_AttendanceMode{2}:=__ ("Por Hora, detallado")
		at_AttendanceMode{3}:=__ ("Anual")
		at_AttendanceMode{4}:=__ ("Por Hora, acumulado")
		ARRAY TEXT:C222(at_LatesMode;3)
		at_LatesMode{1}:=__ ("Diario")
		at_LatesMode{2}:="-"
		at_LatesMode{3}:=__ ("Anual")
		READ ONLY:C145([xxSTR_Periodos:100])
		QUERY:C277([xxSTR_Periodos:100];[xxSTR_Periodos:100]ID:1>=-1)  //-2 reservado para MediaTrack
		hl_Configuraciones:=HL_Selection2List (->[xxSTR_Periodos:100]Nombre_Configuracion:2;->[xxSTR_Periodos:100]ID:1)
		CFG_STR_LoadConfiguration ("Niveles")
		vl_LastPageNiveles:=1
		ARRAY LONGINT:C221(aTextRGBColors;Size of array:C274(<>aNivel))
		ARRAY LONGINT:C221(aTextStyles;Size of array:C274(<>aNivel))
		For ($i;1;Size of array:C274(<>aNivel))
			$esInActivo:=(Find in array:C230(<>at_NombreNivelesActivos;<>aNivel{$i})=-1)
			$esRegular:=(Find in array:C230(<>at_NombreNivelesRegulares;<>aNivel{$i})>0)
			$esOficial:=(Find in array:C230(<>at_NombreNivelesOficiales;<>aNivel{$i})>0)
			Case of 
				: ($esOficial)
					aTextRGBColors{$i}:=0x0000
					aTextStyles{$i}:=5
				: ($esRegular)
					aTextRGBColors{$i}:=0x0000
					aTextStyles{$i}:=1
				: ($esInActivo)
					aTextRGBColors{$i}:=0x00969696
					aTextStyles{$i}:=0
				Else 
					aTextRGBColors{$i}:=0x0000
					aTextStyles{$i}:=0
			End case 
		End for 
		<>aNivel:=$nivel_Seleccionado
		<>aNivNo:=$nivel_Seleccionado
		LISTBOX SELECT ROW:C912(*;"lb_ListaNiveles";<>aNivel)
		
		
		
		Case of 
			: (<>vtXS_CountryCode="co")
				OBJECT SET VISIBLE:C603(*;"promocion@";False:C215)
				OBJECT GET COORDINATES:C663(*;"GroupBox_Evaluacion";$l;$t;$r;$b)
				OBJECT GET COORDINATES:C663(*;"co_TextoPromocion";$lText;$tText;$rText;$bText)
				$nLeft:=$l+20
				$nTop:=$b+30
				$nRigth:=$nLeft+($rText-$lText)
				$nBottom:=$nTop+($bText-$tText)
				IT_SetNamedObjectRect ("co_TextoPromocion";$nLeft;$nTop;$nRigth;$nBottom)
				
				
			: (<>vtXS_CountryCode="pe")
				OBJECT SET VISIBLE:C603(*;"promocion@";False:C215)
			Else 
				
		End case 
		
		  //157382
		ARRAY TEXT:C222(at_EvtCalTipo;0)
		ARRAY LONGINT:C221(al_EvtCalMaxDay;0)
		ARRAY LONGINT:C221(al_EvtCalMaxWeek;0)
		BLOB_Blob2Vars (->[xxSTR_Niveles:6]xEventoCalendario:53;0;->at_EvtCalTipo;->al_EvtCalMaxDay;->al_EvtCalMaxWeek)
		OBJECT SET TITLE:C194(*;"EvtAsigbloqueo_titulo1";__ ("Tipo de Evento"))
		OBJECT SET TITLE:C194(*;"EvtAsigbloqueo_titulo2";__ ("Diario"))
		OBJECT SET TITLE:C194(*;"EvtAsigbloqueo_titulo3";__ ("Semanal"))
		LISTBOX SET LOCKED COLUMNS:C1151(*;"EvtAsigbloqueo_LB";3)
		
	: (Form event:C388=On Close Box:K2:21)
		vbCFG_CloseWindow:=True:C214
		CFG_STR_SaveConfiguration ("Niveles")
		CANCEL:C270
		
	: (Form event:C388=On Unload:K2:2)
		CLEAR LIST:C377(hl_Configuraciones)
	: (Form event:C388=On Clicked:K2:4)
		
End case 


If ([xxSTR_Niveles:6]EsNIvelActivo:30)
	OBJECT SET ENTERABLE:C238([xxSTR_Niveles:6]EsNivelOficial:15;True:C214)
	OBJECT SET ENTERABLE:C238([xxSTR_Niveles:6]EsNivelRegular:4;True:C214)
	OBJECT SET ENTERABLE:C238([xxSTR_Niveles:6]EsNivelSchoolNet:14;True:C214)
	OBJECT SET ENTERABLE:C238([xxSTR_Niveles:6]EsNivelSchoolCenter:12;True:C214)
	OBJECT SET ENTERABLE:C238([xxSTR_Niveles:6]EsPostulable:45;True:C214)
Else 
	OBJECT SET ENTERABLE:C238([xxSTR_Niveles:6]EsNivelOficial:15;False:C215)
	OBJECT SET ENTERABLE:C238([xxSTR_Niveles:6]EsNivelRegular:4;False:C215)
	OBJECT SET ENTERABLE:C238([xxSTR_Niveles:6]EsNivelSchoolNet:14;False:C215)
	OBJECT SET ENTERABLE:C238([xxSTR_Niveles:6]EsNivelSchoolCenter:12;False:C215)
	OBJECT SET ENTERABLE:C238([xxSTR_Niveles:6]EsPostulable:45;False:C215)
	[xxSTR_Niveles:6]EsNivelOficial:15:=False:C215
	[xxSTR_Niveles:6]EsNivelRegular:4:=False:C215
	[xxSTR_Niveles:6]EsNivelSchoolNet:14:=False:C215
	[xxSTR_Niveles:6]EsNivelSchoolCenter:12:=False:C215
	[xxSTR_Niveles:6]EsPostulable:45:=False:C215
End if 
If ([xxSTR_Niveles:6]EsNivelRegular:4)
	OBJECT SET ENTERABLE:C238([xxSTR_Niveles:6]EsNivelOficial:15;True:C214)
Else 
	OBJECT SET ENTERABLE:C238([xxSTR_Niveles:6]EsNivelOficial:15;False:C215)
	[xxSTR_Niveles:6]EsNivelOficial:15:=False:C215
End if 