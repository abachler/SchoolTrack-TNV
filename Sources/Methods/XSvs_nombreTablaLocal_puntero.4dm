//%attributes = {}
  // XSvs_nombreTablaLocal_Puntero($y_Tabla:puntero{; $t_codigoPais:T{; $t_codigoLenguaje:T}})
  //devuelve el nombre localizado del campo pasado en $y_Tabla
  //$t_codigoPais y $t_codigoLenguaje son opcionales (si no se pasan se usa la configuración de la BD)

  //  ---------------------------------------------
  // Por: Alberto Bachler: 27/02/13, 11:02:22
  //  ---------------------------------------------

C_POINTER:C301($1)
C_TEXT:C284($2)
C_TEXT:C284($3)
C_TEXT:C284($0)

C_LONGINT:C283($l_numeroCampo;$l_numeroTabla)
C_POINTER:C301($y_campo;$y_Tabla)
C_TEXT:C284($t_referenciaTabla;$t_codigoLenguaje;$t_codigoPais)
C_BOOLEAN:C305($b_leerNombreVirtual)

If (False:C215)
	C_POINTER:C301(XSvs_nombreTablaLocal_puntero ;$1)
	C_TEXT:C284(XSvs_nombreTablaLocal_puntero ;$2)
	C_TEXT:C284(XSvs_nombreTablaLocal_puntero ;$3)
	C_TEXT:C284(XSvs_nombreTablaLocal_puntero ;$0)
End if 

$y_Tabla:=$1


If (Not:C34(Is nil pointer:C315($y_Tabla)))
	RESOLVE POINTER:C394($y_Tabla;$t_NombreVariable;$l_numeroTabla;$l_numeroCampo)
	If (Is table number valid:C999($l_numeroTabla))
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
			$0:=API Get Virtual Table Name ($l_numeroTabla)
		End if 
		
		If ($0="")
			$t_referenciaTabla:=String:C10($l_numeroTabla)+"."+$t_codigoPais+"."+$t_codigoLenguaje
			$0:=KRL_GetTextFieldData (->[xShell_TableAlias:199]TableRef:1;->$t_referenciaTabla;->[xShell_TableAlias:199]Alias:2)
			If ($0="")
				QUERY:C277([xShell_Tables:51];[xShell_Tables:51]NumeroDeTabla:5=$l_numeroTabla)
				$0:=[xShell_Tables:51]NombreDeTabla:1
				If ($0="")
					If (Is table number valid:C999($l_numeroTabla))
						$0:=Table name:C256($l_numeroTabla)
					End if 
				End if 
			End if 
		End if 
	End if 
End if 