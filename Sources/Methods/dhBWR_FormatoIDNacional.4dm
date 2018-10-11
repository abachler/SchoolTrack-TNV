//%attributes = {}
  // dhBWR_FormatoIDNacional()
  //
  //
  // creado por: Alberto Bachler Klein: 14-03-16, 10:15:06
  // -----------------------------------------------------------
C_TEXT:C284($0)
C_DATE:C307($1)
C_TEXT:C284($2)
C_TEXT:C284($3)
C_TEXT:C284($4)
C_TEXT:C284($5)

C_DATE:C307($d_fechaNacimiento)
C_LONGINT:C283($l_edad)
C_TEXT:C284($t_documento;$t_IdNacional1;$t_IdNacional2;$t_IdNacional3;$t_pasaporte;$t_Resultado)


If (False:C215)
	C_TEXT:C284(dhBWR_FormatoIDNacional ;$0)
	C_DATE:C307(dhBWR_FormatoIDNacional ;$1)
	C_TEXT:C284(dhBWR_FormatoIDNacional ;$2)
	C_TEXT:C284(dhBWR_FormatoIDNacional ;$3)
	C_TEXT:C284(dhBWR_FormatoIDNacional ;$4)
	C_TEXT:C284(dhBWR_FormatoIDNacional ;$5)
End if 

$d_fechaNacimiento:=$1
$t_IdNacional1:=$2
Case of 
	: (Count parameters:C259=3)
		$t_IdNacional2:=$3
	: (Count parameters:C259=4)
		$t_IdNacional2:=$3
		$t_IdNacional3:=$4
	: (Count parameters:C259=5)
		$t_IdNacional2:=$3
		$t_IdNacional3:=$4
		$t_pasaporte:=$5
End case 

If (<>vtXS_CountryCode="cl")
	Case of 
		: ($t_IdNacional1#"")
			  //$t_Resultado:=String(Num(Substring($t_IdNacional1;1;Length($t_IdNacional1)-1));"##.###.###")+"-"+Substring($t_IdNacional1;Length($t_IdNacional1))
			$t_Resultado:=String:C10(Num:C11(Substring:C12($t_IdNacional1;1;Length:C16($t_IdNacional1)-1));"###"+<>tXS_RS_ThousandsSeparator+"###"+<>tXS_RS_ThousandsSeparator+"###")+"-"+Substring:C12($t_IdNacional1;Length:C16($t_IdNacional1))  //20170703 RCH Cuando el separador decimal era ".", había problemas con el despligue.
		: ($t_IdNacional2#"")
			$t_Resultado:=$t_IdNacional2
		: ($t_IdNacional3#"")
			$t_Resultado:=$t_IdNacional2
		: ($t_pasaporte#"")
			$t_Resultado:="P "+$t_pasaporte
	End case 
Else 
	If (($d_fechaNacimiento#!00-00-00!) & (<>ai_IDNacional_LimiteEdad{1}#0))  //20170727 RCH
		$l_edad:=Int:C8(DT_ReturnAgeInMonths ($d_fechaNacimiento)/12)
		Case of 
			: ((<>ai_IDNacional_LimiteEdad{1}>=$l_edad) | (<>ai_IDNacional_LimiteEdad{1}=0))
				$t_documento:=<>at_IDNacional_Names{1}
				$t_Resultado:=$t_documento+" "+$t_IdNacional1
			: ((<>ai_IDNacional_LimiteEdad{2}>=$l_edad) | (<>ai_IDNacional_LimiteEdad{2}=0))
				$t_documento:=<>at_IDNacional_Names{2}
				$t_Resultado:=$t_documento+" "+$t_IdNacional2
			: ((<>ai_IDNacional_LimiteEdad{3}>=$l_edad) | (<>ai_IDNacional_LimiteEdad{3}=0))
				$t_documento:=<>at_IDNacional_Names{3}
				$t_Resultado:=$t_documento+" "+$t_IdNacional3
			: ($t_pasaporte#"")
				$t_Resultado:="P "+$t_pasaporte
			Else 
				$t_documento:=<>at_IDNacional_Names{1}
				$t_Resultado:=$t_documento+" "+$t_IdNacional1
		End case 
		
		If (($t_resultado="") & ($t_pasaporte#""))
			$t_resultado:="P "+$t_pasaporte
		End if 
	Else 
		Case of 
			: ($t_IdNacional1#"")
				$t_documento:=<>at_IDNacional_Names{1}
				$t_Resultado:=$t_documento+" "+$t_IdNacional1
			: ($t_IdNacional2#"")
				$t_documento:=<>at_IDNacional_Names{2}
				$t_Resultado:=$t_documento+" "+$t_IdNacional2
			: ($t_IdNacional3#"")
				$t_documento:=<>at_IDNacional_Names{3}
				$t_Resultado:=$t_documento+" "+$t_IdNacional3
			: ($t_pasaporte#"")
				$t_Resultado:="P "+$t_pasaporte
		End case 
	End if 
End if 

$0:=$t_Resultado