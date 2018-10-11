//%attributes = {}
  // XSvs_nombreCampoLocal_puntero($y_Campo:puntero{; $t_codigoPais:T{; $t_codigoLenguaje:T}})
  //
  // ---------------------------------------------
  // Por: Alberto Bachler: 27/02/13, 09:22:09
  // ---------------------------------------------
C_TEXT:C284($0)
C_POINTER:C301($1)
C_TEXT:C284($2)
C_TEXT:C284($3)

C_LONGINT:C283($l_numeroCampo;$l_numeroTabla)
C_POINTER:C301($y_campo)
C_TEXT:C284($t_referenciaCampo;$t_codigoLenguaje;$t_codigoPais)
C_BOOLEAN:C305($b_leerNombreVirtual)

If (False:C215)
	C_TEXT:C284(XSvs_nombreCampoLocal_puntero ;$0)
	C_POINTER:C301(XSvs_nombreCampoLocal_puntero ;$1)
	C_TEXT:C284(XSvs_nombreCampoLocal_puntero ;$2)
	C_TEXT:C284(XSvs_nombreCampoLocal_puntero ;$3)
	C_BOOLEAN:C305(XSvs_nombreCampoLocal_puntero ;$4)
End if 


$y_campo:=$1
If (Not:C34(Is nil pointer:C315($y_campo)))
	RESOLVE POINTER:C394($y_campo;$t_variable;$l_numeroTabla;$l_numeroCampo)
	If (Is field number valid:C1000($l_numeroTabla;$l_numeroCampo))
		$t_codigoPais:=<>vtXS_CountryCode
		$t_codigoLenguaje:=<>vtXS_langage
		$b_leerNombreVirtual:=True:C214
		Case of 
			: (Count parameters:C259=4)
				$t_codigoPais:=$2
				$t_codigoLenguaje:=$3
				$b_leerNombreVirtual:=$4
			: (Count parameters:C259=3)
				$t_codigoPais:=$2
				$t_codigoLenguaje:=$3
			: (Count parameters:C259=2)
				$t_codigoPais:=$2
		End case 
		
		If ($b_leerNombreVirtual)
			$0:=API Get Virtual Field Name ($l_numeroTabla;$l_numeroCampo)
		End if 
		
		If ($0="")
			$t_referenciaCampo:=String:C10($l_numeroTabla)+"."+String:C10($l_numeroCampo)+"."+$t_codigoPais+"."+$t_codigoLenguaje
			$0:=KRL_GetTextFieldData (->[xShell_FieldAlias:198]FieldRef:5;->$t_referenciaCampo;->[xShell_FieldAlias:198]Alias:3)
			If ($0="")
				QUERY:C277([xShell_Fields:52];[xShell_Fields:52]NumeroTabla:1=$l_numeroTabla;*)
				QUERY:C277([xShell_Fields:52]; & [xShell_Fields:52]NumeroCampo:2=$l_numeroCampo)
				$0:=[xShell_Fields:52]Alias:4
				If ($0="")
					If (Is field number valid:C1000($l_numeroTabla;$l_numeroCampo))
						$0:=Field name:C257($l_numeroTabla;$l_numeroCampo)
					End if 
				End if 
			End if 
		End if 
	End if 
End if 
