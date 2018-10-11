Case of 
	: (Form event:C388=On Load:K2:1)
		C_BOOLEAN:C305(LlaveParaFechas)
		
		XS_SetInterface 
		IT_SetEnterable (False:C215;0;->vt_Fecha1;->vt_Fecha2)
		
		ARRAY BOOLEAN:C223(abACT_PrintItem;0)
		ARRAY PICTURE:C279(apACT_PrintItem;0)
		
		ARRAY TEXT:C222(at_cargos;0)
		ARRAY LONGINT:C221(al_refe_itemscargos;0)
		
		READ ONLY:C145([ACT_Cargos:173])
		
		QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]EsRelativo:10#True:C214)
		  //QUERY([ACT_Cargos]; & ;[ACT_Cargos]Monto_Neto>0)
		ORDER BY:C49([ACT_Cargos:173];[ACT_Cargos:173]Glosa:12;>)
		
		READ ONLY:C145([xxACT_Items:179])
		DISTINCT VALUES:C339([ACT_Cargos:173]Ref_Item:16;al_refe_itemscargos)
		ARRAY LONGINT:C221($a_idTemp;0)
		COPY ARRAY:C226(al_refe_itemscargos;$a_idTemp)
		ARRAY LONGINT:C221(al_refe_itemscargos;0)
		
		
		For ($i;1;Size of array:C274($a_idTemp))
			QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=$a_idTemp{$i})
			If ([xxACT_Items:179]Glosa:2#"")
				APPEND TO ARRAY:C911(al_refe_itemscargos;$a_idTemp{$i})
				APPEND TO ARRAY:C911(at_cargos;[xxACT_Items:179]Glosa:2)
			Else 
				  //20110819 AS Se estaban dejando fuera Cargos sin Item en la configuracion
				QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=$a_idTemp{$i})
				REDUCE SELECTION:C351([ACT_Cargos:173];1)
				APPEND TO ARRAY:C911(al_refe_itemscargos;$a_idTemp{$i})
				APPEND TO ARRAY:C911(at_cargos;[ACT_Cargos:173]Glosa:12)
			End if 
		End for 
		
		AT_RedimArrays (Size of array:C274(at_cargos);->abACT_PrintItem;->apACT_PrintItem)
		SORT ARRAY:C229(at_cargos;al_refe_itemscargos;apACT_PrintItem;abACT_PrintItem;>)
		
		C_PICTURE:C286(dummyPict)
		
		If (LlaveParaFechas=False:C215)
			dummyBoolean:=True:C214
			GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";dummyPict)
		Else 
			dummyBoolean:=False:C215
			GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";dummyPict)
		End if 
		
		AT_Populate (->apACT_PrintItem;->dummyPict)
		AT_Populate (->abACT_PrintItem;->dummyBoolean)
		
		$err:=ALP_DefaultColSettings (xALP_cargosInforme;1;"apACT_PrintItem";"";30;"1")
		  //$err:=ALP_DefaultColSettings (xALP_ItemsInforme;2;"at_anota_signos";"";20)
		$err:=ALP_DefaultColSettings (xALP_cargosInforme;2;"at_cargos";__ ("Cargos");290)
		$err:=ALP_DefaultColSettings (xALP_cargosInforme;3;"at_cargos";"";50)
		
		ALP_SetDefaultAppareance (xALP_cargosInforme;9;1;6;1;8)
		AL_SetColOpts (xALP_cargosInforme;1;1;1;1;0)
		AL_SetRowOpts (xALP_cargosInforme;0;1;0;0;1;1)
		AL_SetCellOpts (xALP_cargosInforme;0;1;1)
		AL_SetMiscOpts (xALP_cargosInforme;1;0;"\\";0;1)
		AL_SetMainCalls (xALP_cargosInforme;"";"")
		AL_SetScroll (xALP_cargosInforme;0;-3)
		AL_SetEntryCtls (xALP_cargosInforme;1;0)
		AL_SetEntryOpts (xALP_cargosInforme;1;0;0;0;0;<>tXS_RS_DecimalSeparator)
		AL_SetDrgOpts (xALP_cargosInforme;0;30;0)
		
		READ ONLY:C145([xxSTR_Periodos:100])
		ALL RECORDS:C47([xxSTR_Periodos:100])
		ARRAY DATE:C224($ad_ini;0)
		ARRAY DATE:C224($ad_end;0)
		C_DATE:C307(vd_fecha_ini_conf;vd_fecha_end_conf)
		
		ARRAY DATE:C224($ad_fechas;0)
		SELECTION TO ARRAY:C260([xxSTR_Periodos:100]Inicio_Ejercicio:4;$ad_ini;[xxSTR_Periodos:100]Fin_Ejercicio:5;$ad_end)
		AT_Union (->$ad_ini;->$ad_end;->$ad_fechas)
		SORT ARRAY:C229($ad_fechas;>)
		
		
		C_LONGINT:C283($width;$height;$Resizeby)
		_O_C_INTEGER:C282($i;$ind)
		
		  //If (LlaveParaFechas=False)
		  //SET VISIBLE(*;"gp@";True)
		  //SET VISIBLE(*;"gk@";False)
		
		For ($i;1;Size of array:C274($ad_fechas))
			
			$ind:=Find in array:C230($ad_fechas;!00-00-00!)
			If ($ind#-1)
				DELETE FROM ARRAY:C228($ad_fechas;$ind;1)
			End if 
		End for 
		
		If (Size of array:C274($ad_fechas)>0)
			
			If ($ad_fechas{1}#!00-00-00!)
				vd_Fecha1:=$ad_fechas{1}
				vd_fecha_ini_conf:=$ad_fechas{1}
			Else 
				vd_Fecha1:=Current date:C33(*)
				vd_fecha_ini_conf:=Current date:C33(*)
			End if 
			
			If ($ad_fechas{Size of array:C274($ad_fechas)}#!00-00-00!)
				vd_Fecha2:=$ad_fechas{Size of array:C274($ad_fechas)}
				vd_fecha_end_conf:=$ad_fechas{Size of array:C274($ad_fechas)}
			Else 
				vd_Fecha2:=Current date:C33(*)
				vd_fecha_end_conf:=Current date:C33(*)
			End if 
			
		Else 
			
			vd_Fecha1:=Current date:C33(*)
			vd_Fecha2:=Current date:C33(*)
			vd_fecha_ini_conf:=Current date:C33(*)
			vd_fecha_end_conf:=Current date:C33(*)
			
		End if 
		
		vt_Fecha1:=String:C10(vd_Fecha1;7)
		vt_Fecha2:=String:C10(vd_Fecha2;7)
		
		  //Else 
		  //SET VISIBLE(*;"gp@";False)
		  //SET VISIBLE(*;"gk@";True)
		  //
		  //vd_Fecha1:=Current date(*)
		  //vd_fecha_ini_conf:=Current date(*)
		  //vt_Fecha1:=String(vd_Fecha1;7)
		  //
		  //End if 
		
		If (LlaveParaFechas=True:C214)
			
			_O_C_INTEGER:C282(Sel1_Ctas_ina;Sel2_Categ;op2_apo;op1_ctas)
			
			OBJECT SET VISIBLE:C603(*;"det@";True:C214)
			
			READ ONLY:C145([xxACT_ItemsCategorias:98])
			READ ONLY:C145([xxACT_Items:179])
			QUERY WITH ARRAY:C644([xxACT_Items:179]ID:1;al_refe_itemscargos)
			KRL_RelateSelection (->[xxACT_ItemsCategorias:98]ID:2;->[xxACT_Items:179]ID_Categoria:8;"")
			
			If ((Records in selection:C76([xxACT_ItemsCategorias:98]))=0)
				OBJECT SET VISIBLE:C603(*;"det_Sel2";False:C215)
			Else 
				OBJECT SET VISIBLE:C603(*;"det_texto";False:C215)
			End if 
			Sel1_Cts_ina:=1
			Sel2_Categ:=0
			op2_apo:=1
			$width:=387
			$height:=480
			$Resizeby:=5
			WDW_AdjustWindowSize ($width;$height;$Resizeby)
			OBJECT MOVE:C664(*;"BT@";0;95)
			OBJECT MOVE:C664(*;"det@";0;-40)
			
		Else 
			OBJECT SET VISIBLE:C603(*;"det@";False:C215)
		End if 
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
End case 



