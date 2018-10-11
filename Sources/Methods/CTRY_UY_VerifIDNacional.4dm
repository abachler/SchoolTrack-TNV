//%attributes = {}
  // Método: CTRY_UY_VerifIDNacional
  // código original de: Roberto Catalan
  // modificado por Alberto Bachler Klein el 16/02/18, 17:31:51
  // - corrección de errores de sintáxis no toleradas por 4D v16R6
  // - normalización, declaración de variables, limpieza
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
C_TEXT:C284($0)
C_TEXT:C284($1)
C_BOOLEAN:C305($2)

C_BOOLEAN:C305($b_MostrarAlerta)
C_LONGINT:C283($i;$l_largo;$sum)
C_TEXT:C284($r;$t_digitoVerificador;$t_DNI_uy;$t_modulo;$t_DNI_uy;$t_string)


If (False:C215)
	C_TEXT:C284(CTRY_UY_VerifIDNacional ;$0)
	C_TEXT:C284(CTRY_UY_VerifIDNacional ;$1)
	C_BOOLEAN:C305(CTRY_UY_VerifIDNacional ;$2)
End if 

$t_DNI_uy:=$1
If (Count parameters:C259>=2)
	$b_MostrarAlerta:=$2
End if 

$t_DNI_uy:=$t_DNI_uy
$l_largo:=7

If (<>vtXS_CountryCode="uy")
	If ($t_DNI_uy#"")
		$t_DNI_uy:=Uppercase:C13($t_DNI_uy)
		$t_digitoVerificador:=$t_DNI_uy[[Length:C16($t_DNI_uy)]]
		$t_DNI_uy:=Substring:C12(Replace string:C233(Replace string:C233($t_DNI_uy;".";"");"-";"");1;Length:C16($t_DNI_uy)-1)
		
		If (Length:C16($t_DNI_uy)<=$l_largo)
			
			If (Length:C16($t_DNI_uy)<$l_largo)
				$t_DNI_uy:=ST_RigthChars (("0"*$l_largo)+$t_DNI_uy;$l_largo)
			End if 
			
			$sum:=0
			For ($i;1;$l_largo)
				$t_string:="8123476"
				$sum:=(Num:C11($t_DNI_uy[[$i]])*Num:C11($t_string[[$i]]))+$sum
			End for 
			
			$t_modulo:=String:C10(Mod:C98($sum;10))
			If ($t_digitoVerificador=$t_modulo)
				$t_DNI_uy:=$t_DNI_uy+$t_digitoVerificador
			Else 
				If ($b_MostrarAlerta)
					CD_Dlog (0;__ ("Identificador Nacional incorrecto."))
				End if 
				$t_DNI_uy:=""
			End if 
			$t_DNI_uy:=ST_DeleteCharsLeft ($t_DNI_uy;"0")
		Else 
			If ($b_MostrarAlerta)
				CD_Dlog (0;__ ("Los identificadores con más de "+String:C10($l_largo)+" cifras (más el dígito verificador) no son validados."))
			Else 
				BEEP:C151
			End if 
		End if 
	End if 
End if 
$0:=$t_DNI_uy