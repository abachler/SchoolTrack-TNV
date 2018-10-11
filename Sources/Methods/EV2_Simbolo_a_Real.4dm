//%attributes = {}
  // MÉTODO: EV2_Simbolo_a_Real
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 24/03/11, 10:13:33
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // EV2_Simbolo_a_Real()
  // ----------------------------------------------------


  // DECLARACIONES E INICIALIZACIONES
C_REAL:C285($0)
C_TEXT:C284($simbolo)
$0:=-10
$simbolo:=$1

  // CODIGO PRINCIPAL

Case of 
	: ($1="")
		$0:=-10
		
	: ($1="P")
		$0:=-2
		
	: ($1="X")
		$0:=-3
		
	: ($1="*")
		$0:=-4
		
	: ($1=">>>")
		$0:=-5
		
		
	Else 
		$el:=Find in array:C230(aSymbol;$1)
		If ($el>0)
			$0:=aSymbPctEqu{$el}
		End if 
		
		
End case 
