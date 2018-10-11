//%attributes = {}
  // QRY_PrePocesoValores()
  // Por: Alberto Bachler: 21/02/13, 08:33:05
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_POINTER:C301($1)
C_TEXT:C284($2)
C_TEXT:C284($3)

C_LONGINT:C283($l_dias)
C_POINTER:C301($y_Campo)
C_TEXT:C284($t_expresionDelimitador;$t_formula;$t_Valor_a_procesar)
If (False:C215)
	C_POINTER:C301(QRY_PrePocesoValores ;$1)
	C_TEXT:C284(QRY_PrePocesoValores ;$2)
	C_TEXT:C284(QRY_PrePocesoValores ;$3)
End if 
C_REAL:C285(vr_Real)

$y_Campo:=$1
$t_Valor_a_procesar:=$2
$t_expresionDelimitador:=$3

If (Type:C295($y_Campo->)=Is boolean:K8:9)
	Case of 
		: (($t_Valor_a_procesar="True") | ($t_Valor_a_procesar="Yes"))  // ingles
			$0:="True"
		: (($t_Valor_a_procesar="Si") | ($t_Valor_a_procesar="Verdadero"))  // español
			$0:="True"
		: (($t_Valor_a_procesar="Vrai") | ($t_Valor_a_procesar="Oui"))  //francés
			$0:="True"
		: (($t_Valor_a_procesar="Se") | ($t_Valor_a_procesar="Verdadeiro"))  // portugués
			$0:="True"
		: (($t_Valor_a_procesar="Wahr") | ($t_Valor_a_procesar="Ja"))  // aleman
			$0:="True"
		: (($t_Valor_a_procesar="Vero") | ($t_Valor_a_procesar="Sì"))  // italiano
			$0:="True"
		Else 
			$0:="False"
	End case 
	
Else 
	
	$0:=dhQRY_GetReferencedValue ($t_Valor_a_procesar)
	If ($0="")
		Case of 
			: ($t_Valor_a_procesar="==@")
				$t_formula:=Substring:C12($t_Valor_a_procesar;3)
				vr_Real:=0
				EXECUTE FORMULA:C63("vr_Real:="+$t_formula)
				$0:=String:C10(vr_Real)
			: (($t_Valor_a_procesar="Año actual") | ($t_Valor_a_procesar="Current year") | ($t_Valor_a_procesar="Année courante"))
				$0:=String:C10(<>gYear)
			: (($t_Valor_a_procesar="Año anterior") | ($t_Valor_a_procesar="Last Year") | ($t_Valor_a_procesar="Année précedente"))
				$0:=String:C10(<>gYear-1)
			: (($t_Valor_a_procesar="Año actual menos 2") | ($t_Valor_a_procesar="Año actual - 2") | ($t_Valor_a_procesar="Current year minus 2") | ($t_Valor_a_procesar="Current year- 2") | ($t_Valor_a_procesar="Année courante moins 2") | ($t_Valor_a_procesar="Anné courante - 2"))
				$0:=String:C10(<>gYear-2)
			: (($t_Valor_a_procesar="Año actual menos 3") | ($t_Valor_a_procesar="Año actual - 3") | ($t_Valor_a_procesar="Current year minus 3") | ($t_Valor_a_procesar="Current year- 3") | ($t_Valor_a_procesar="Année courante moins 3") | ($t_Valor_a_procesar="Anné courante - 3"))
				$0:=String:C10(<>gYear-3)
			: (($t_Valor_a_procesar="Año actual menos 4") | ($t_Valor_a_procesar="Año actual - 4") | ($t_Valor_a_procesar="Current year minus 4") | ($t_Valor_a_procesar="Current year- 4") | ($t_Valor_a_procesar="Année courante moins 4") | ($t_Valor_a_procesar="Anné courante - 4"))
				$0:=String:C10(<>gYear-4)
			: (($t_Valor_a_procesar="Hoy@") | ($t_Valor_a_procesar="Today@") | ($t_Valor_a_procesar="Aujourd'hui@"))
				Case of 
					: (Position:C15("-";$t_Valor_a_procesar)>0)
						$l_dias:=Num:C11(Substring:C12($t_Valor_a_procesar;Position:C15("-";$t_Valor_a_procesar)+1))
						$0:=String:C10(Current date:C33-$l_dias;dt_GetNullDateString )
					: (Position:C15("+";$t_Valor_a_procesar)>0)
						$l_dias:=Num:C11(Substring:C12($t_Valor_a_procesar;Position:C15("+";$t_Valor_a_procesar)+1))
						$0:=String:C10(Current date:C33+$l_dias;dt_GetNullDateString )
					Else 
						$0:=String:C10(Current date:C33;dt_GetNullDateString )
				End case 
			: (($t_Valor_a_procesar="Ahora") | ($t_Valor_a_procesar="Now") | ($t_Valor_a_procesar="Maintenant"))
				$0:=String:C10(Current time:C178;"00:00:00")
			Else 
				$0:=$t_Valor_a_procesar
		End case 
	End if 
End if 

If ((Type:C295($y_Campo->)=Is text:K8:3) | (Type:C295($y_Campo->)=Is alpha field:K8:1))
	Case of 
		: ($t_expresionDelimitador=aDelims{1})
			$0:=$t_Valor_a_procesar+"@"
		: ($t_expresionDelimitador=aDelims{8})
			$0:="@"+$t_Valor_a_procesar+"@"
		: ($t_expresionDelimitador=aDelims{9})
			$0:="@"+$t_Valor_a_procesar+"@"
	End case 
End if 