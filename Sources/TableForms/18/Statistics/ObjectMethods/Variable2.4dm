<>ST_v461:=False:C215  //10/8/98 at 08:34:02 by: Alberto Bachler
  //implementación de bimestres
C_LONGINT:C283(vi_TipoEstadistica)

If (Form event:C388=On Load:K2:1)
	
	
	Case of 
		: (vi_TipoEstadistica<=1)
			  //$err:=AL_SetArraysNam (Self->;15;7;"<>aStatP1";"<>aStatP2";"<>aStatP3";"<>aStatP4";"<>aStatPF";"<>aStatEX";"<>aStatNF")
			Case of 
					
				: (Size of array:C274(atSTR_Periodos_Nombre)=5)
					$err:=AL_SetArraysNam (Self:C308->;1;9;"<>aStatItems";"<>aStatP1";"<>aStatP2";"<>aStatP3";"<>aStatP4";"<>aStatP5";"<>aStatPF";"<>aStatEX";"<>aStatNF")
					AL_SetHeaders (Self:C308->;1;9;__ ("Variables estadísticas");__ ("1B");__ ("2B");__ ("3B");__ ("4B");__ ("5B");__ ("PF");__ ("EX");__ ("NF"))
					AL_SetWidths (Self:C308->;1;1;120)
					For ($i;2;9)
						AL_SetFormat (Self:C308->;$i;"# ##0"+<>txs_rs_decimalseparator+"00")
						AL_SetWidths (Self:C308->;$i;1;65)
					End for 
					
				: (Size of array:C274(atSTR_Periodos_Nombre)=4)
					$err:=AL_SetArraysNam (Self:C308->;1;8;"<>aStatItems";"<>aStatP1";"<>aStatP2";"<>aStatP3";"<>aStatP4";"<>aStatPF";"<>aStatEX";"<>aStatNF")
					AL_SetHeaders (Self:C308->;1;8;__ ("Variables estadísticas");__ ("1B");__ ("2B");__ ("3B");__ ("4B");__ ("PF");__ ("EX");__ ("NF"))
					AL_SetWidths (Self:C308->;1;1;120)
					For ($i;2;8)
						AL_SetFormat (Self:C308->;$i;"# ##0"+<>txs_rs_decimalseparator+"00")
						AL_SetWidths (Self:C308->;$i;1;65)
					End for 
				: (Size of array:C274(atSTR_Periodos_Nombre)=3)
					$err:=AL_SetArraysNam (Self:C308->;1;7;"<>aStatItems";"<>aStatP1";"<>aStatP2";"<>aStatP3";"<>aStatPF";"<>aStatEX";"<>aStatNF")
					AL_SetHeaders (Self:C308->;1;7;__ ("Variables estadísticas");__ ("1T");__ ("2T");__ ("3T");__ ("PF");__ ("EX");__ ("NF"))
					AL_SetWidths (Self:C308->;1;1;120)
					For ($i;2;7)
						AL_SetFormat (Self:C308->;$i;"# ##0"+<>txs_rs_decimalseparator+"00")
						AL_SetWidths (Self:C308->;$i;1;76)
					End for 
				: (Size of array:C274(atSTR_Periodos_Nombre)=2)
					$err:=AL_SetArraysNam (Self:C308->;1;6;"<>aStatItems";"<>aStatP1";"<>aStatP2";"<>aStatPF";"<>aStatEX";"<>aStatNF")
					AL_SetHeaders (Self:C308->;1;6;__ ("Variables estadísticas");__ ("1S");__ ("2S");__ ("PF");__ ("EX");__ ("NF"))
					AL_SetWidths (Self:C308->;1;1;120)
					For ($i;2;6)
						AL_SetFormat (Self:C308->;$i;"# ##0"+<>txs_rs_decimalseparator+"00")
						AL_SetWidths (Self:C308->;$i;1;91)
					End for 
			End case 
		: (vi_TipoEstadistica=3)  // periodo
			$err:=AL_SetArraysNam (Self:C308->;1;14;"<>aStatItems";"<>aStat1";"<>aStat2";"<>aStat3";"<>aStat4";"<>aStat5";"<>aStat6";"<>aStat7";"<>aStat8";"<>aStat9";"<>aStat10";"<>aStat11";"<>aStat12";"<>aStatEP")
			AL_SetHeaders (Self:C308->;1;14;"Variables estadísticas";"1";"2";"3";"4";"5";"6";"7";"8";"9";"10";"11";"12";__ ("CP"))
			AL_SetWidths (Self:C308->;1;1;120)
			For ($i;2;14)
				AL_SetFormat (Self:C308->;$i;"# ##0"+<>txs_rs_decimalseparator+"00")
				AL_SetWidths (Self:C308->;$i;1;35)
			End for 
		: (vi_TipoEstadistica=4)  // columna
			AL_SetHeaders (Self:C308->;1;14;__ ("Variables estadísticas");"1")
			$err:=AL_SetArraysNam (Self:C308->;1;2;"<>aStatItems";"<>aStat1")
			AL_SetFormat (Self:C308->;2;"# ##0,00")
			AL_SetWidths (Self:C308->;1;1;35)
			AL_SetWidths (Self:C308->;2;1;35)
	End case 
	
	
	AL_SetHdrStyle (Self:C308->;0;"Tahoma";9;1)
	AL_SetStyle (Self:C308->;0;"Tahoma";9;0)
	AL_SetColLock (Self:C308->;1)
	AL_SetColOpts (Self:C308->;0;0;0;0;0;0;0)
	AL_SetMiscOpts (Self:C308->;0;0;"'";0)
	AL_SetSortOpts (Self:C308->;0;0;0;"";0)
	AL_SetDividers (Self:C308->;"Gray";"";7;"Gray";"";7)
	AL_SetRowOpts (Self:C308->;1;0;0;0;0)
	ALP_SetDefaultAppareance (Self:C308->;9;1;2;1;2)
	iCount:=Size of array:C274(aNtaF)
End if 
