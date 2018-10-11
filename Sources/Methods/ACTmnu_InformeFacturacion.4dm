//%attributes = {}
  //ACTmnu_InformeFacturacion
C_TEXT:C284($document)

If (USR_GetMethodAcces (Current method name:C684))
	SRACT_SelFecha (8)
	If (ok=1)
		C_POINTER:C301($ptr)
		C_LONGINT:C283($r)
		$r:=CD_Dlog (0;__ ("¿Desea obtener el informe desde los cargos proyectados?");"";__ ("No");__ ("Si"))
		If ($r=1)
			$filedPtr:=->[ACT_Cargos:173]FechaEmision:22
		Else 
			$filedPtr:=->[ACT_Cargos:173]Fecha_de_generacion:4
		End if 
		$msg:=__ ("AccountTrack generará un archivo de texto con la emisión por item para")
		$msg2:=__ (" Esta operación puede ser larga. ¿Desea continuar?")
		
		Case of 
			: (vb_Hoy=1)
				$vd_fecha1:=Current date:C33(*)
				$vd_fecha2:=Current date:C33(*)
			: (vb_Mes=1)
				$lastday:=DT_GetLastDay (vl_Mes;vl_Año2)
				$vd_fecha1:=DT_GetDateFromDayMonthYear (1;vl_Mes;vl_Año2)
				$vd_fecha2:=DT_GetDateFromDayMonthYear ($lastday;vl_Mes;vl_Año2)
			: (vb_Año=1)
				$vd_fecha1:=DT_GetDateFromDayMonthYear (1;1;vl_Año)
				$vd_fecha2:=DT_GetDateFromDayMonthYear (31;12;vl_Año)
			: (vb_Rango=1)
				$vd_fecha1:=vd_Fecha1
				$vd_fecha2:=vd_Fecha2
		End case 
		
		QUERY:C277([ACT_Cargos:173];$filedPtr->>=$vd_fecha1;*)
		QUERY:C277([ACT_Cargos:173]; & ;$filedPtr-><=$vd_fecha2)
		
		If (KRL_isSameField ($filedPtr;->[ACT_Cargos:173]Fecha_de_generacion:4))
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22=!00-00-00!)
		End if 
		If (cs_todasRazones=0)
			If (atACTcfg_Razones=1)
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]RazonSocialAsociada:56=atACTcfg_Razones{atACTcfg_Razones};*)
				QUERY SELECTION:C341([ACT_Cargos:173]; | ;[ACT_Cargos:173]RazonSocialAsociada:56="")
			Else 
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]RazonSocialAsociada:56=atACTcfg_Razones{atACTcfg_Razones})
			End if 
		End if 
		
		QR_DeclareGenericArrays 
		AT_DistinctsFieldValues (->[ACT_Cargos:173]Moneda:28;->aQR_Text1)
		AT_DistinctsFieldValues (->[ACT_Cargos:173]Ref_Item:16;->aQR_LongInt1)
		READ ONLY:C145([xxACT_Items:179])
		QUERY WITH ARRAY:C644([xxACT_Items:179]ID:1;aQR_LongInt1)
		QUERY SELECTION:C341([xxACT_Items:179];[xxACT_Items:179]ID:1#-100)
		
		ARRAY TEXT:C222(atACT_xxGlosas;0)
		ARRAY LONGINT:C221(alACT_IDsxxItems;0)
		ARRAY REAL:C219(arACT_xxMontos;0)
		SELECTION TO ARRAY:C260([xxACT_Items:179]Glosa:2;atACT_xxGlosas;[xxACT_Items:179]ID:1;alACT_IDsxxItems)
		ARRAY REAL:C219(arACT_xxMontos;Size of array:C274(atACT_xxGlosas))
		ARRAY LONGINT:C221(aQR_Longint2;Size of array:C274(atACT_xxGlosas))
		
		For ($i;1;Size of array:C274(aQR_Text1))
			$ptr:=Get pointer:C304("aQR_Real"+String:C10($i))
			AT_Insert (0;Size of array:C274(atACT_xxGlosas);$ptr)
		End for 
		
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Calculando montos por item de cargo..."))
		Case of 
			: (vb_Hoy=1)
				$msg:=$msg+__ (" el día de hoy.")+$msg2
				$fileName:=String:C10(Year of:C25(Current date:C33(*)))+String:C10(Month of:C24(Current date:C33(*)))+String:C10(Day of:C23(Current date:C33(*)))
				$title:=__ ("Para el día ")+String:C10(Current date:C33(*);7)
			: (vb_Mes=1)
				$msg:=$msg+__ (" el mes de ")+aMeses{vl_Mes}+__ (" de ")+String:C10(vl_año2)+"."+$msg2
				$fileName:=String:C10(vl_Año2)+String:C10(vl_Mes)
				$title:=__ ("Para el mes de ")+aMeses{vl_Mes}+__ (" de ")+String:C10(vl_año2)
			: (vb_Año=1)
				$msg:=$msg+__ (" el año ")+String:C10(vl_Año)+"."+$msg2
				$fileName:=String:C10(vl_Año)
				$title:=__ ("Para el año ")+String:C10(vl_Año)
			: (vb_Rango=1)
				$vd_fecha1:=vd_Fecha1
				$vd_fecha2:=vd_Fecha2
				$msg:=$msg+__ (" el rango desde el ")+String:C10($vd_fecha1;7)+__ (" hasta el ")+String:C10($vd_fecha2;7)+"."+$msg2
				$fileName:=String:C10(Year of:C25($vd_fecha1))+String:C10(Month of:C24($vd_fecha1))+String:C10(Day of:C23($vd_fecha1))+__ ("al")+String:C10(Year of:C25($vd_fecha2))+String:C10(Month of:C24($vd_fecha2))+String:C10(Day of:C23($vd_fecha2))
				$title:=__ ("Para el período entre el ")+String:C10($vd_fecha1;7)+__ (" y el ")+String:C10($vd_fecha2)
		End case 
		
		If (cs_todasRazones=0)
			vtACT_RazonSocial:=__ ("Razón Social: ")+ST_Qte (atACTcfg_Razones{atACTcfg_Razones})
			$title:=$title+"\r\n"+__ ("Razón Social: ")+ST_Qte (atACTcfg_Razones{atACTcfg_Razones})
		Else 
			vtACT_RazonSocial:=""
		End if 
		
		For ($i;1;Size of array:C274(alACT_IDsxxItems))
			QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=alACT_IDsxxItems{$i};*)
			QUERY:C277([ACT_Cargos:173]; & ;$filedPtr->>=$vd_fecha1;*)
			QUERY:C277([ACT_Cargos:173]; & ;$filedPtr-><=$vd_fecha2)
			If (KRL_isSameField ($filedPtr;->[ACT_Cargos:173]Fecha_de_generacion:4))
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22=!00-00-00!)
			End if 
			If (cs_todasRazones=0)
				If (atACTcfg_Razones=1)
					QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]RazonSocialAsociada:56=atACTcfg_Razones{atACTcfg_Razones};*)
					QUERY SELECTION:C341([ACT_Cargos:173]; | ;[ACT_Cargos:173]RazonSocialAsociada:56="")
				Else 
					QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]RazonSocialAsociada:56=atACTcfg_Razones{atACTcfg_Razones})
				End if 
			End if 
			ARRAY LONGINT:C221($al_recNumsCargos;0)
			LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];$al_recNumsCargos;"")
			arACT_xxMontos{$i}:=ACTcar_CalculaMontos ("redondeadoFromRecNumArrayMCobro";->$al_recNumsCargos;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*))
			aQR_Longint2{$i}:=Records in selection:C76([ACT_Cargos:173])
			
			FIRST RECORD:C50([ACT_Cargos:173])
			While (Not:C34(End selection:C36([ACT_Cargos:173])))
				$el:=Find in array:C230(aQR_Text1;[ACT_Cargos:173]Moneda:28)
				$ptr:=Get pointer:C304("aQR_Real"+String:C10($el))
				If ([ACT_Cargos:173]EmitidoSegúnMonedaCargo:11)
					$ptr->{$i}:=$ptr->{$i}+[ACT_Cargos:173]Monto_Neto:5
				Else 
					$ptr->{$i}:=$ptr->{$i}+[ACT_Cargos:173]Monto_Moneda:9
				End if 
				NEXT RECORD:C51([ACT_Cargos:173])
			End while 
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(alACT_IDsxxItems))
		End for 
		vrACT_TotalItems:=AT_GetSumArray (->arACT_xxMontos)
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		ACTpgs_LoadInteresRecord 
		$glosaIntereses:=[xxACT_Items:179]Glosa:2
		UNLOAD RECORD:C212([xxACT_Items:179])
		QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=-100;*)
		QUERY:C277([ACT_Cargos:173]; & ;$filedPtr->>=$vd_fecha1;*)
		QUERY:C277([ACT_Cargos:173]; & ;$filedPtr-><=$vd_fecha2)
		If (KRL_isSameField ($filedPtr;->[ACT_Cargos:173]Fecha_de_generacion:4))
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22=!00-00-00!)
		End if 
		If (cs_todasRazones=0)
			If (atACTcfg_Razones=1)
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]RazonSocialAsociada:56=atACTcfg_Razones{atACTcfg_Razones};*)
				QUERY SELECTION:C341([ACT_Cargos:173]; | ;[ACT_Cargos:173]RazonSocialAsociada:56="")
			Else 
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]RazonSocialAsociada:56=atACTcfg_Razones{atACTcfg_Razones})
			End if 
		End if 
		ARRAY LONGINT:C221($al_recNumsCargos;0)
		LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];$al_recNumsCargos;"")
		$montoIntereses:=ACTcar_CalculaMontos ("redondeadoFromRecNumArrayMCobro";->$al_recNumsCargos;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*))
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Calculando montos por cargos sin definición de ítem de cargo...")
		ARRAY TEXT:C222(atACT_GlosasExtraInforme;0)
		ARRAY REAL:C219(arACT_MontosExtra;0)
		If (Size of array:C274(alACT_IDsxxItems)>0)
			$proc:=IT_UThermometer (1;0;"Buscando cargos sin definición...")
			QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16#alACT_IDsxxItems{1};*)
			QUERY:C277([ACT_Cargos:173]; & ;$filedPtr->>=$vd_fecha1;*)
			QUERY:C277([ACT_Cargos:173]; & ;$filedPtr-><=$vd_fecha2;*)
			For ($hj;2;Size of array:C274(alACT_IDsxxItems))
				QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Ref_Item:16#alACT_IDsxxItems{$hj};*)
			End for 
			QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Ref_Item:16#-100)
			If (KRL_isSameField ($filedPtr;->[ACT_Cargos:173]Fecha_de_generacion:4))
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22=!00-00-00!)
			End if 
			If (cs_todasRazones=0)
				If (atACTcfg_Razones=1)
					QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]RazonSocialAsociada:56=atACTcfg_Razones{atACTcfg_Razones};*)
					QUERY SELECTION:C341([ACT_Cargos:173]; | ;[ACT_Cargos:173]RazonSocialAsociada:56="")
				Else 
					QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]RazonSocialAsociada:56=atACTcfg_Razones{atACTcfg_Razones})
				End if 
			End if 
			CREATE SET:C116([ACT_Cargos:173];"Extras")
			AT_DistinctsFieldValues (->[ACT_Cargos:173]Glosa:12;->atACT_GlosasExtraInforme)
			IT_UThermometer (-2;$proc)
		End if 
		ARRAY REAL:C219(arACT_MontosExtra;Size of array:C274(atACT_GlosasExtraInforme))
		
		$PrevSize:=Size of array:C274(aQR_Real1)
		For ($i;1;Size of array:C274(aQR_Text1))
			$ptr:=Get pointer:C304("aQR_Real"+String:C10($i))
			AT_Insert (0;Size of array:C274(atACT_GlosasExtraInforme);$ptr)
		End for 
		
		For ($i;1;Size of array:C274(atACT_GlosasExtraInforme))
			USE SET:C118("Extras")
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Glosa:12=atACT_GlosasExtraInforme{$i})
			ARRAY LONGINT:C221($al_recNumsCargos;0)
			LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];$al_recNumsCargos;"")
			arACT_MontosExtra{$i}:=ACTcar_CalculaMontos ("redondeadoFromRecNumArrayMCobro";->$al_recNumsCargos;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*))
			FIRST RECORD:C50([ACT_Cargos:173])
			While (Not:C34(End selection:C36([ACT_Cargos:173])))
				$el:=Find in array:C230(aQR_Text1;[ACT_Cargos:173]Moneda:28)
				$ptr:=Get pointer:C304("aQR_Real"+String:C10($el))
				If ([ACT_Cargos:173]EmitidoSegúnMonedaCargo:11)
					$ptr->{$PrevSize+$i}:=$ptr->{$PrevSize+$i}+[ACT_Cargos:173]Monto_Neto:5
				Else 
					$ptr->{$PrevSize+$i}:=$ptr->{$PrevSize+$i}+[ACT_Cargos:173]Monto_Moneda:9
				End if 
				NEXT RECORD:C51([ACT_Cargos:173])
			End while 
			atACT_GlosasExtraInforme{$i}:="(*)"+atACT_GlosasExtraInforme{$i}
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(atACT_GlosasExtraInforme);"Calculando montos por cargos sin definición de ítem de cargo...")
		End for 
		vrACT_TotalExtras:=AT_GetSumArray (->arACT_MontosExtra)
		CLEAR SET:C117("Extras")
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		atACT_GlosasExtraInforme{0}:="(*)"
		ARRAY LONGINT:C221($DA_Return;0)
		AT_SearchArray (->atACT_GlosasExtraInforme;"=";->$DA_Return)
		For ($i;1;Size of array:C274($DA_Return))
			atACT_GlosasExtraInforme{$DA_Return{$i}}:="Glosa Vacía"
		End for 
		vtACT_Periodo:="Desde el "+String:C10($vd_fecha1;7)+" Hasta el "+String:C10($vd_fecha2;7)
		vrACT_TotalEmitido:=vrACT_TotalItems+vrACT_TotalExtras+$montoIntereses
		ARRAY TEXT:C222(atACT_Glosas;0)
		ARRAY REAL:C219(arACT_Montos;0)
		COPY ARRAY:C226(atACT_xxGlosas;atACT_Glosas)
		COPY ARRAY:C226(arACT_xxMontos;arACT_Montos)
		$PrevSize:=Size of array:C274(atACT_Glosas)
		AT_Insert (0;Size of array:C274(atACT_GlosasExtraInforme);->atACT_Glosas;->arACT_Montos;->aQR_Longint2)
		For ($i;1;Size of array:C274(atACT_GlosasExtraInforme))
			atACT_Glosas{$prevSize+$i}:=atACT_GlosasExtraInforme{$i}
			arACT_Montos{$prevSize+$i}:=arACT_MontosExtra{$i}
		End for 
		$line:="SORT ARRAY(atACT_Glosas;arACT_Montos;"
		For ($i;1;Size of array:C274(aQR_Text1))
			$line:=$line+"aQR_Real"+String:C10($i)+";"
		End for 
		$line:=$line+"aQR_Longint2;>)"
		EXECUTE FORMULA:C63($line)
		AT_Insert (0;1;->atACT_Glosas;->arACT_Montos;->aQR_Longint2)
		
		For ($i;1;Size of array:C274(aQR_Text1))
			$ptr:=Get pointer:C304("aQR_Real"+String:C10($i))
			AT_Insert (0;1;$ptr)
		End for 
		
		atACT_Glosas{Size of array:C274(atACT_Glosas)}:=$glosaIntereses
		arACT_Montos{Size of array:C274(arACT_Montos)}:=$montoIntereses
		If (cb_Archivo=1)
			$fileName:="InfoEmision_"+$fileName
			$r:=CD_Dlog (0;$msg;"";"Si";"No")
			If ($r=1)
				USE CHARACTER SET:C205("windows-1252";0)
				
				$ref:=ACTabc_CreaDocumento ("Informes de Emisión";$fileName)
				$document:=document
				
				$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Exportando montos emitidos...")
				IO_SendPacket ($ref;"Informe de Emisión"+"\r\n"+"\r\n"+$title+"\r\n"+"\r\n"+"Exportado el "+String:C10(Current date:C33(*);7)+" a las "+String:C10(Current time:C178(*);2)+" por "+<>tUSR_CurrentUser+"\r\n"+"\r\n"+"Las glosas que comienzan con (*) corresponden a cargos que ya no tienen una defin"+"ición de ítem de cargo."+"\r\n"+"\r\n"+"\r\n")
				$text:="Cantidad"+"\t"+"Glosa"+"\t"
				For ($i;1;Size of array:C274(aQR_Text1))
					$text:=$text+aQR_Text1{$i}+"\t"
				End for 
				$text:=$text+"Monto Total"+"\r\n"
				IO_SendPacket ($ref;$text)
				
				For ($i;1;Size of array:C274(atACT_Glosas))
					$text:=String:C10(aQR_Longint2{$i})+"\t"+atACT_Glosas{$i}+"\t"
					For ($j;1;Size of array:C274(aQR_Text1))
						$ptr:=Get pointer:C304("aQR_Real"+String:C10($j))
						$text:=$text+String:C10($ptr->{$i})+"\t"
					End for 
					$text:=$text+String:C10(arACT_Montos{$i})+"\r\n"
					IO_SendPacket ($ref;$text)
					$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(atACT_Glosas);"Exportando montos emitidos...")
				End for 
				
				$text:="\r\n"+"\t"+"Total"+"\t"
				For ($i;1;Size of array:C274(aQR_Text1))
					$ptr:=Get pointer:C304("aQR_Real"+String:C10($i))
					$text:=$text+String:C10(AT_GetSumArray ($ptr))+"\t"
				End for 
				$text:=$text+String:C10(vrACT_TotalEmitido)
				IO_SendPacket ($ref;$text)
				CLOSE DOCUMENT:C267($ref)
				
				$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
				USE CHARACTER SET:C205(*;0)
				ACTcd_DlogWithShowOnDisk ($document;0;__ ("La exportación de la emisión ha concluido. Le recomendamos abrirla con Microsoft Excel.")+"\r\r"+__ ("Ruta del archivo: ")+SYS_GetParentNme ($document))  //20170222 RCH
			End if 
		Else 
			ALL RECORDS:C47([xxACT_Items:179])
			ONE RECORD SELECT:C189([xxACT_Items:179])
			FORM SET OUTPUT:C54([xxACT_Items:179];"PrintFactReport")
			PRINT SELECTION:C60([xxACT_Items:179])
			FORM SET OUTPUT:C54([xxACT_Items:179];"Output")
		End if 
		QR_DeclareGenericArrays 
		AT_Initialize (->atACT_xxGlosas;->alACT_IDsxxItems;->arACT_xxMontos;->atACT_GlosasExtraInforme;->arACT_MontosExtra;->atACT_Glosas;->arACT_Montos)
	End if 
End if 