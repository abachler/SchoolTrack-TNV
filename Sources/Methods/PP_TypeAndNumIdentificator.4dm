//%attributes = {}
  //PP_TypeAndNumIdentificator

  //Define identificador
  //parametro 1 devuelve Tipo de id
  //parametro 2 devuelve N?mero de id

C_TEXT:C284($vt_Identificador)
C_TEXT:C284($vt_noIde)

$entrada:=$1

  //Define identificador
Case of 
	: (<>vtXS_CountryCode="cl")
		If (([Personas:7]RUT:6="") & ([Personas:7]Nacionalidad:7#"Chilen@"))
			$vt_Identificador:="Pasaporte"
			$vt_noIde:=[Personas:7]Pasaporte:59
		End if 
		If (Num:C11(Substring:C12([Personas:7]RUT:6;1;Length:C16([Personas:7]RUT:6)-1))>0)
			$vt_Identificador:="RUT"
			$vt_noIde:=SR_FormatoRUT2 ([Personas:7]RUT:6)
			
		Else 
			$vt_Identificador:="RUT"
			$vt_noIde:=SR_FormatoRUT2 ([Personas:7]RUT:6)
			OBJECT SET FORMAT:C236([Personas:7]RUT:6;"")
		End if 
		
	: (<>vtXS_CountryCode="co")
		$edadAgnos:=Int:C8(DT_ReturnAgeInMonths ([Personas:7]Fecha_de_nacimiento:5)/12)
		Case of 
			: (<>ai_IDNacional_LimiteEdad{1}=0)
				Case of 
					: (([Personas:7]RUT:6="") & ([Personas:7]Pasaporte:59="") & ([Personas:7]IDNacional_2:37="") & ([Personas:7]IDNacional_3:38=""))
						$vt_Identificador:=<>vt_IDNacional1_name
						$vt_noIde:=[Personas:7]RUT:6
					: (([Personas:7]RUT:6#"") & ([Personas:7]Pasaporte:59="") & ([Personas:7]IDNacional_2:37="") & ([Personas:7]IDNacional_3:38=""))
						$vt_Identificador:="RUT"
						$vt_noIde:=[Personas:7]RUT:6
					: (([Personas:7]RUT:6="") & ([Personas:7]Pasaporte:59#"") & ([Personas:7]IDNacional_2:37="") & ([Personas:7]IDNacional_3:38=""))
						$vt_Identificador:="Pasaporte"
						$vt_noIde:=[Personas:7]Pasaporte:59
					: (([Personas:7]RUT:6="") & ([Personas:7]Pasaporte:59="") & ([Personas:7]IDNacional_2:37#"") & ([Personas:7]IDNacional_3:38=""))
						$vt_Identificador:=<>vt_IDNacional2_name
						$vt_noIde:=[Personas:7]IDNacional_2:37
					: (([Personas:7]RUT:6="") & ([Personas:7]Pasaporte:59="") & ([Personas:7]IDNacional_2:37="") & ([Personas:7]IDNacional_3:38#""))
						$vt_Identificador:=<>vt_IDNacional3_name
						$vt_noIde:=[Personas:7]IDNacional_3:38
					Else 
						$age:=Int:C8(DT_ReturnAgeInMonths ([Personas:7]Fecha_de_nacimiento:5)/12)
						Case of 
							: ((<>ai_IDNacional_LimiteEdad{1}>=$age) | (<>ai_IDNacional_LimiteEdad{2}=0))
								$vt_Identificador:=<>vt_IDNacional1_name
								$vt_noIde:=[Personas:7]RUT:6
							: ((<>ai_IDNacional_LimiteEdad{2}>=$age) | (<>ai_IDNacional_LimiteEdad{2}=0))
								$vt_Identificador:=<>vt_IDNacional2_name
								$vt_noIde:=[Personas:7]IDNacional_2:37
							: ((<>ai_IDNacional_LimiteEdad{3}>=$age) | (<>ai_IDNacional_LimiteEdad{3}=0))
								$vt_Identificador:=<>vt_IDNacional3_name
								$vt_noIde:=[Personas:7]IDNacional_3:38
							Else 
								$vt_Identificador:=<>vt_IDNacional1_name
								$vt_noIde:=[Personas:7]RUT:6
						End case 
				End case 
				
			: (($edadAgnos<=<>ai_IDNacional_LimiteEdad{1}) | ([Personas:7]RUT:6#"") & ([Personas:7]IDNacional_2:37="") & ([Personas:7]IDNacional_3:38=""))
				$vt_Identificador:=<>vt_IDNacional1_name
				$vt_noIde:=[Personas:7]RUT:6
			: (($edadAgnos<=<>ai_IDNacional_LimiteEdad{2}) | ([Personas:7]IDNacional_2:37#"") & ([Personas:7]RUT:6="") & ([Personas:7]IDNacional_3:38=""))
				$vt_Identificador:=<>vt_IDNacional2_name
				$vt_noIde:=[Personas:7]IDNacional_2:37
			: (($edadAgnos<=<>ai_IDNacional_LimiteEdad{3}) | ([Personas:7]IDNacional_3:38#"") & ([Personas:7]IDNacional_2:37="") & ([Personas:7]RUT:6=""))
				$vt_Identificador:=<>vt_IDNacional3_name
				$vt_noIde:=[Personas:7]IDNacional_3:38
			: (([Personas:7]RUT:6="") & ([Personas:7]Pasaporte:59#"") & ([Personas:7]IDNacional_2:37="") & ([Personas:7]IDNacional_3:38=""))
				$vt_Identificador:="Pasaporte"
				$vt_noIde:=[Personas:7]Pasaporte:59
		End case 
		
End case 

If ($entrada=1)
	$0:=$vt_Identificador
End if 
If ($entrada=2)
	$0:=$vt_noIde
End if 
