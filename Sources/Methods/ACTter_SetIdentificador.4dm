//%attributes = {}
  //ACTter_SetIdentificador

  //opciones Identificadores nacionales
C_POINTER:C301($ptr1;$ptr2)
C_BOOLEAN:C305($vb_llenaVars;$vb_id1;$vb_id2;$vb_id3;$vb_Pasaporte)
If (Count parameters:C259=2)
	$ptr1:=$1
	$ptr2:=$2
	$vb_llenaVars:=True:C214
	$vb_id1:=False:C215
	$vb_id2:=False:C215
	$vb_id3:=False:C215
	$vb_Pasaporte:=False:C215
End if 

If ((<>ai_IDNacional_LimiteEdad{1}=0) | ([ACT_Terceros:138]Es_empresa:2))
	If (Not:C34($vb_llenaVars))
		OBJECT SET VISIBLE:C603(*;"IDa@";True:C214)
		OBJECT SET VISIBLE:C603(*;"IDb@";False:C215)
		OBJECT SET VISIBLE:C603(*;"IDc@";False:C215)
		OBJECT SET VISIBLE:C603(*;"IDd@";False:C215)
	Else 
		$vb_id1:=True:C214
	End if 
Else 
	$age:=Int:C8(DT_ReturnAgeInMonths ([ACT_Terceros:138]Fecha_de_Nacimiento:28)/12)
	Case of 
		: ((<>ai_IDNacional_LimiteEdad{1}>=$age) | (<>ai_IDNacional_LimiteEdad{2}=0))
			If (Not:C34($vb_llenaVars))
				OBJECT SET VISIBLE:C603(*;"IDa@";True:C214)
				OBJECT SET VISIBLE:C603(*;"IDb@";False:C215)
				OBJECT SET VISIBLE:C603(*;"IDc@";False:C215)
				OBJECT SET VISIBLE:C603(*;"IDd@";False:C215)
			Else 
				$vb_id1:=True:C214
			End if 
			
		: ((<>ai_IDNacional_LimiteEdad{2}>=$age) | (<>ai_IDNacional_LimiteEdad{2}=0))
			If (Not:C34($vb_llenaVars))
				OBJECT SET VISIBLE:C603(*;"IDa@";False:C215)
				OBJECT SET VISIBLE:C603(*;"IDb@";True:C214)
				OBJECT SET VISIBLE:C603(*;"IDc@";False:C215)
				OBJECT SET VISIBLE:C603(*;"IDd@";False:C215)
			Else 
				$vb_id2:=True:C214
			End if 
			
		: ((<>ai_IDNacional_LimiteEdad{3}>=$age) | (<>ai_IDNacional_LimiteEdad{3}=0))
			If (Not:C34($vb_llenaVars))
				OBJECT SET VISIBLE:C603(*;"IDa@";False:C215)
				OBJECT SET VISIBLE:C603(*;"IDb@";False:C215)
				OBJECT SET VISIBLE:C603(*;"IDc@";True:C214)
				OBJECT SET VISIBLE:C603(*;"IDd@";False:C215)
			Else 
				$vb_id3:=True:C214
			End if 
			
		Else 
			If (Not:C34($vb_llenaVars))
				OBJECT SET VISIBLE:C603(*;"IDa@";True:C214)
				OBJECT SET VISIBLE:C603(*;"IDb@";False:C215)
				OBJECT SET VISIBLE:C603(*;"IDc@";False:C215)
				OBJECT SET VISIBLE:C603(*;"IDd@";False:C215)
			End if 
	End case 
End if 




  //opciones según pais
Case of 
	: (<>vtXS_CountryCode="cl")
		If (([ACT_Terceros:138]RUT:4="") & ([ACT_Terceros:138]Nacionalidad:27#"Chilen@"))
			If (Not:C34($vb_llenaVars))
				OBJECT SET VISIBLE:C603(*;"IDa@";False:C215)
				OBJECT SET VISIBLE:C603(*;"IDb@";False:C215)
				OBJECT SET VISIBLE:C603(*;"IDc@";False:C215)
				OBJECT SET VISIBLE:C603(*;"IDd@";True:C214)
			Else 
				$vb_Pasaporte:=True:C214
			End if 
		End if 
		If (Num:C11(Substring:C12([ACT_Terceros:138]RUT:4;1;Length:C16([ACT_Terceros:138]RUT:4)-1))>0)
			OBJECT SET FORMAT:C236([ACT_Terceros:138]RUT:4;"###.###.###-#")
		Else 
			OBJECT SET FORMAT:C236([ACT_Terceros:138]RUT:4;"")
		End if 
		OBJECT SET FILTER:C235([ACT_Terceros:138]RUT:4;"&\"0-9;k;K\"")
		  //: (<>vtXS_CountryCode="co")
		  //$edadAgnos:=Int(DT_ReturnAgeInMonths ([ACT_Terceros]Fecha_de_Nacimiento)/12)
		  //Case of 
		  //: (<>ai_IDNacional_LimiteEdad{1}=0)
		  //Case of 
		  //: (([ACT_Terceros]RUT="") & ([ACT_Terceros]Pasaporte="") & ([ACT_Terceros]Identificador_Nacional2="") & ([ACT_Terceros]Identificador_Nacional3=""))
		  //If (Not($vb_llenaVars))
		  //OBJECT SET VISIBLE(*;"IDa@";True)
		  //OBJECT SET VISIBLE(*;"IDb@";False)
		  //OBJECT SET VISIBLE(*;"IDc@";False)
		  //OBJECT SET VISIBLE(*;"IDd@";False)
		  //Else 
		  //$vb_id1:=True
		  //End if 
		  //
		  //: (([ACT_Terceros]RUT#"") & ([ACT_Terceros]Pasaporte="") & ([ACT_Terceros]Identificador_Nacional2="") & ([ACT_Terceros]Identificador_Nacional3=""))
		  //If (Not($vb_llenaVars))
		  //OBJECT SET VISIBLE(*;"IDa@";True)
		  //OBJECT SET VISIBLE(*;"IDb@";False)
		  //OBJECT SET VISIBLE(*;"IDc@";False)
		  //OBJECT SET VISIBLE(*;"IDd@";False)
		  //Else 
		  //$vb_id1:=True
		  //End if 
		  //
		  //: (([ACT_Terceros]RUT="") & ([ACT_Terceros]Pasaporte#"") & ([ACT_Terceros]Identificador_Nacional2="") & ([ACT_Terceros]Identificador_Nacional3=""))
		  //If (Not($vb_llenaVars))
		  //OBJECT SET VISIBLE(*;"IDa@";False)
		  //OBJECT SET VISIBLE(*;"IDb@";False)
		  //OBJECT SET VISIBLE(*;"IDc@";False)
		  //OBJECT SET VISIBLE(*;"IDd@";True)
		  //Else 
		  //$vb_Pasaporte:=True
		  //End if 
		  //
		  //: (([ACT_Terceros]RUT="") & ([ACT_Terceros]Pasaporte="") & ([ACT_Terceros]Identificador_Nacional2#"") & ([ACT_Terceros]Identificador_Nacional3=""))
		  //If (Not($vb_llenaVars))
		  //OBJECT SET VISIBLE(*;"IDa@";False)
		  //OBJECT SET VISIBLE(*;"IDb@";True)
		  //OBJECT SET VISIBLE(*;"IDc@";False)
		  //OBJECT SET VISIBLE(*;"IDd@";False)
		  //Else 
		  //$vb_id2:=True
		  //End if 
		  //
		  //: (([ACT_Terceros]RUT="") & ([ACT_Terceros]Pasaporte="") & ([ACT_Terceros]Identificador_Nacional2="") & ([ACT_Terceros]Identificador_Nacional3#""))
		  //If (Not($vb_llenaVars))
		  //OBJECT SET VISIBLE(*;"IDa@";False)
		  //OBJECT SET VISIBLE(*;"IDb@";False)
		  //OBJECT SET VISIBLE(*;"IDc@";True)
		  //OBJECT SET VISIBLE(*;"IDd@";False)
		  //Else 
		  //$vb_id3:=True
		  //End if 
		  //End case 
		  //
		  //: (($edadAgnos<=<>ai_IDNacional_LimiteEdad{1}) | ([ACT_Terceros]RUT#"") & ([ACT_Terceros]Identificador_Nacional2="") & ([ACT_Terceros]Identificador_Nacional3=""))
		  //If (Not($vb_llenaVars))
		  //OBJECT SET VISIBLE(*;"IDa@";True)
		  //OBJECT SET VISIBLE(*;"IDb@";False)
		  //OBJECT SET VISIBLE(*;"IDc@";False)
		  //OBJECT SET VISIBLE(*;"IDd@";False)
		  //Else 
		  //$vb_id1:=True
		  //End if 
		  //
		  //: (($edadAgnos<=<>ai_IDNacional_LimiteEdad{2}) | ([ACT_Terceros]Identificador_Nacional2#"") & ([ACT_Terceros]RUT="") & ([ACT_Terceros]Identificador_Nacional3=""))
		  //If (Not($vb_llenaVars))
		  //OBJECT SET VISIBLE(*;"IDa@";False)
		  //OBJECT SET VISIBLE(*;"IDb@";True)
		  //OBJECT SET VISIBLE(*;"IDc@";False)
		  //OBJECT SET VISIBLE(*;"IDd@";False)
		  //Else 
		  //$vb_id2:=True
		  //End if 
		  //
		  //: (($edadAgnos<=<>ai_IDNacional_LimiteEdad{3}) | ([ACT_Terceros]Identificador_Nacional3#"") & ([ACT_Terceros]Identificador_Nacional2="") & ([ACT_Terceros]RUT=""))
		  //If (Not($vb_llenaVars))
		  //OBJECT SET VISIBLE(*;"IDa@";False)
		  //OBJECT SET VISIBLE(*;"IDb@";False)
		  //OBJECT SET VISIBLE(*;"IDc@";True)
		  //OBJECT SET VISIBLE(*;"IDd@";False)
		  //Else 
		  //$vb_id3:=True
		  //End if 
		  //
		  //: (([ACT_Terceros]RUT="") & ([ACT_Terceros]Pasaporte#"") & ([ACT_Terceros]Identificador_Nacional2="") & ([ACT_Terceros]Identificador_Nacional3=""))
		  //If (Not($vb_llenaVars))
		  //OBJECT SET VISIBLE(*;"IDa@";False)
		  //OBJECT SET VISIBLE(*;"IDb@";False)
		  //OBJECT SET VISIBLE(*;"IDc@";False)
		  //OBJECT SET VISIBLE(*;"IDd@";True)
		  //Else 
		  //$vb_Pasaporte:=True
		  //End if 
		  //End case 
End case 

If ($vb_llenaVars)
	Case of 
		: ($vb_id1)
			$ptr1->:=<>at_IDNacional_Names{1}
			$ptr2->:=[ACT_Terceros:138]RUT:4
			
		: ($vb_id2)
			$ptr1->:=<>at_IDNacional_Names{2}
			$ptr2->:=[ACT_Terceros:138]Identificador_Nacional2:20
			
		: ($vb_id3)
			$ptr1->:=<>at_IDNacional_Names{3}
			$ptr2->:=[ACT_Terceros:138]Identificador_Nacional3:21
			
		: ($vb_Pasaporte)
			$ptr1->:="Pasaporte"
			$ptr2->:=[ACT_Terceros:138]Pasaporte:25
			
	End case 
End if 


  //
  //