//%attributes = {}
  // MÉTODO: EV2_Real_a_Literal
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 24/03/11, 06:37:36
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // EV2_Real_a_LiteralAplicacion()
  // ----------------------------------------------------


  // DECLARACIONES E INICIALIZACIONES

C_LONGINT:C283($2;$3;$4;$5;$convertTo;$evStyleID;$decimales)
C_REAL:C285($nota;$puntos;$percent;$1)
C_TEXT:C284($result;$0)

$result:=""
$decimales:=0
$percent:=$1
$trunc:=0
Case of 
	: (Count parameters:C259=5)
		$evStyleID:=$5
		$trunc:=$4
		$decimales:=$3
		$convertTo:=$2
	: (Count parameters:C259=4)
		$trunc:=$4
		$decimales:=$3
		$convertTo:=$2
	: (Count parameters:C259=3)
		$decimales:=$3
		$convertTo:=$2
	: (Count parameters:C259>=2)
		$convertTo:=$2
		Case of 
			: ($convertTo=Notas)
				$decimales:=iGradesDec
			: ($convertTo=Puntos)
				$decimales:=iPointsDec
		End case 
	: (Count parameters:C259=1)
End case 
  //MONO 05/09/16: Comento esto debido a que el valor de 0 decimales es válido.
  //If ($decimales=0)
  //Case of 
  //: ($convertTo=Notas)
  //$decimales:=iGradesDec
  //: ($convertTo=Puntos)
  //$decimales:=iPointsDec
  //Else 
  //$decimales:=1
  //End case 
  //End if 

  // CODIGO PRINCIPAL
If ($evStyleID#0)
	EVS_ReadStyleData ($evStyleID)
End if 

If ($convertTo=0)
	$convertTo:=iEvaluationMode
End if 

If ($decimales>0)
	$format:="####0"+<>tXS_RS_DecimalSeparator+("0"*$decimales)
Else 
	$format:="####0"
End if 
Case of 
		  //: (($percent=0) | ($percent=-1))
		  //: (($percent=-10) | ($percent=0))  // 26-04-2011 AS. se agrega  ($percent=0)  ya que se estaba guardando en el final literal un -10
	: ($percent=-10)  // cero es un porcentaje posible en escalas de evaluación donde está considerado como nota
		$result:=""
		
	: ($percent=-4)
		$result:="*"
		
	: ($percent=-3)
		$result:="X"
		
	: ($percent=-2)
		$result:="P"
		
	: ($convertTo=Notas)
		$nota:=EV2_Real_a_Nota ($percent;$trunc;$decimales)
		$result:=String:C10($nota;$format)
		$result:=EV2_Literal_Aplicacion ($result)
		
		
	: ($convertTo=Puntos)
		$puntos:=EV2_Real_a_Puntos ($percent;$trunc;$decimales)
		$result:=String:C10($puntos;$format)
		$result:=EV2_Literal_Aplicacion ($result)
		
		
	: ($convertTo=Porcentaje)
		$decimales:=1
		If ($trunc=0)
			$value:=Round:C94($percent;$decimales)
		Else 
			$value:=Trunc:C95($percent;$decimales)
		End if 
		$result:=String:C10($value;$format)
		$result:=EV2_Literal_Aplicacion ($result)
		
	: ($convertTo=Simbolos)
		$result:=EV2_Real_a_Simbolo ($percent)
		
End case 




$0:=$result
