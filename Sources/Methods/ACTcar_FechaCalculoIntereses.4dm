//%attributes = {}
  //ACTcar_FechaCalculoIntereses

C_TEXT:C284($1;$t_accion)
C_DATE:C307($0;$d_fechaCalculo)
C_POINTER:C301($y_puntero1;$y_puntero2)
C_POINTER:C301(${2})

$t_accion:=$1

If (Count parameters:C259>=2)
	$y_puntero1:=$2
End if 

If (Count parameters:C259>=3)
	$y_puntero2:=$3
End if 

Case of 
	: ($t_accion="LeeConf")
		C_REAL:C285(cs_Emision;cs_Vencimiento;cs_UltimoDiaFEmision;cs_UltimoDiaFVencimiento)
		C_BLOB:C604(xBlob)
		SET BLOB SIZE:C606(xBlob;0)
		
		cs_Emision:=0
		cs_Vencimiento:=1
		cs_UltimoDiaFEmision:=0
		cs_UltimoDiaFVencimiento:=0
		
		ACTcar_FechaCalculoIntereses ("ArmaBlob";->xBlob)
		
		xBlob:=PREF_fGetBlob (0;"ACT_BlobConfiguracionFechaIntereses";xBlob)
		ACTcar_FechaCalculoIntereses ("DesarmaBlob";->xBlob)
		
	: ($t_accion="GuardaConf")
		C_BLOB:C604(xBlob)
		SET BLOB SIZE:C606(xBlob;0)
		
		If ((cs_Emision=0) & (cs_Vencimiento=0) & (cs_UltimoDiaFEmision=0) & (cs_UltimoDiaFVencimiento=0))
			cs_Vencimiento:=1
		End if 
		ACTcar_FechaCalculoIntereses ("ArmaBlob";->xBlob)
		PREF_SetBlob (0;"ACT_BlobConfiguracionFechaIntereses";xBlob)
		
	: ($t_accion="ArmaBlob")
		C_REAL:C285($r_offSet)
		$r_offSet:=BLOB_Variables2Blob ($y_puntero1;0;->cs_Emision;->cs_Vencimiento;->cs_UltimoDiaFEmision;->cs_UltimoDiaFVencimiento)
		
	: ($t_accion="DesarmaBlob")
		C_REAL:C285($r_offSet)
		$r_offSet:=BLOB_Blob2Vars ($y_puntero1;0;->cs_Emision;->cs_Vencimiento;->cs_UltimoDiaFEmision;->cs_UltimoDiaFVencimiento)
		
	: ($t_accion="ObtieneFecha")
		C_DATE:C307($d_fechaEmision;$d_fechaVencimiento)
		
		ACTcar_FechaCalculoIntereses ("LeeConf")
		
		$d_fechaEmision:=$y_puntero1->
		$d_fechaVencimiento:=$y_puntero2->
		
		If ($d_fechaVencimiento>!00-00-00!)  //20171117 RCH Para evitar error en interpretado
			Case of 
				: (cs_Emision=1)
					$d_fechaCalculo:=$d_fechaEmision
					
				: (cs_Vencimiento=1)
					$d_fechaCalculo:=$d_fechaVencimiento
					
				: (cs_UltimoDiaFEmision=1)
					If ($d_fechaEmision#!00-00-00!)  //20171102 RCH
						$d_fechaCalculo:=DT_GetDateFromDayMonthYear (DT_GetLastDay2 ($d_fechaEmision);Month of:C24($d_fechaEmision);Year of:C25($d_fechaEmision))
					End if 
					
				: (cs_UltimoDiaFVencimiento=1)
					If ($d_fechaVencimiento#!00-00-00!)  //20171102 RCH
						$d_fechaCalculo:=DT_GetDateFromDayMonthYear (DT_GetLastDay2 ($d_fechaVencimiento);Month of:C24($d_fechaVencimiento);Year of:C25($d_fechaVencimiento))
					End if 
					
			End case 
		End if 
		
	: ($t_accion="ModificarCargosEmitidos")
		
		ACTcar_FechaCalculoIntereses ("GuardaConf")
		LOG_RegisterChangeConf (OBJECT Get title:C1068(Self:C308->);Self:C308->)
		
		If (Shift down:C543)
			
			ARRAY LONGINT:C221($alACT_recNumCargos;0)
			C_LONGINT:C283($l_indice;$l_locked;$l_proc;$l_resp)
			
			$l_resp:=CD_Dlog (0;"La configuración de intereses fue cambiada presionando la tecla shift."+"\r\r"+"¿Desea aplicar la nueva configuración a todos los ítems de cargo no pagados?";"";__ ("Si");__ ("No"))
			If ($l_resp=1)
				
				READ ONLY:C145([xxACT_Items:179])
				READ WRITE:C146([ACT_Cargos:173])
				
				QUERY:C277([xxACT_Items:179];[xxACT_Items:179]AfectoInteres:26=True:C214;*)
				QUERY:C277([xxACT_Items:179]; & ;[xxACT_Items:179]TasaInteresMensual:25#0)
				
				$l_proc:=IT_UThermometer (1;0;"Actualizando campo para calcular intereses…")
				
				KRL_RelateSelection (->[ACT_Cargos:173]Ref_Item:16;->[xxACT_Items:179]ID:1;"")
				
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Monto_Neto:5>0;*)
				QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]MontosPagados:8=0;*)
				QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]LastInterestsUpdate:42#!00-00-00!)
				
				LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];$alACT_recNumCargos;"")
				
				$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Actualizando campo para calcular intereses…")
				For ($l_indice;1;Size of array:C274($alACT_recNumCargos))
					KRL_GotoRecord (->[ACT_Cargos:173];$alACT_recNumCargos{$l_indice};True:C214)
					If (ok=1)
						[ACT_Cargos:173]LastInterestsUpdate:42:=ACTcar_FechaCalculoIntereses ("ObtieneFecha";->[ACT_Cargos:173]FechaEmision:22;->[ACT_Cargos:173]Fecha_de_Vencimiento:7)  //20140825 RCH Intereses
						  //[ACT_Cargos]LastInterestsUpdate:=ACTcar_FechaCalculoIntereses ("ObtieneFechaSinLeerConf";->[ACT_Cargos]FechaEmision;->[ACT_Cargos]Fecha_de_Vencimiento)  //20140825 RCH Intereses
					Else 
						$l_locked:=$l_locked+1
					End if 
					KRL_SaveUnLoadReadOnly (->[ACT_Cargos:173])
					$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$l_indice/Size of array:C274($alACT_recNumCargos))
				End for 
				$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
				
				LOG_RegisterEvt ("Nueva configuración de intereses aplicada a los cargos no pagados ya emitidos.")
				
				IT_UThermometer (-2;$l_proc)
				
				
			Else 
				LOG_RegisterEvt ("Nueva configuración de intereses no aplicada a los cargos no pagados ya emitidos.")
			End if 
			
		End if 
		
End case 

$0:=$d_fechaCalculo