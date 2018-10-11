//%attributes = {}
  //IT_PopUpMenu

  //Metodo que crea un popup en base a un arreglo pasado en el primer parámetro y deja marcado el elemento pasado en el segundo parámetro (si es que existe)
  //Parametros $1=Arreglo a desplegar en el popup. $2 {OPCIONAL} elemento a marcar (si es que existe en el arreglo)

C_LONGINT:C283($0;$i;$default;$type)
C_DATE:C307($vd_date)
C_TEXT:C284($vt_text)
C_LONGINT:C283($vl_long)
C_BOOLEAN:C305($vb_bool)
C_TEXT:C284($text)
C_POINTER:C301($1;$2;$ptr;$ptr2)

ARRAY DATE:C224($ad_arrayTemp;0)
ARRAY TEXT:C222($at_arrayTemp;0)
ARRAY REAL:C219($ar_arrayTemp;0)
ARRAY BOOLEAN:C223($ab_arrayTemp;0)

$type:=Type:C295($1->)
Case of 
	: (($type=LongInt array:K8:19) | ($type=Integer array:K8:18) | ($type=Real array:K8:17))
		For ($i;1;Size of array:C274($1->))
			APPEND TO ARRAY:C911($at_arrayTemp;String:C10($1->{$i}))
		End for 
		
	: ($type=Date array:K8:20)
		For ($i;1;Size of array:C274($1->))
			APPEND TO ARRAY:C911($at_arrayTemp;String:C10($1->{$i}))
		End for 
	: ($type=Boolean array:K8:21)
		For ($i;1;Size of array:C274($1->))
			APPEND TO ARRAY:C911($at_arrayTemp;String:C10(Num:C11($1->{$i})))
		End for 
		
	: (($type=String array:K8:15) | ($type=Text array:K8:16))
		For ($i;1;Size of array:C274($1->))
			APPEND TO ARRAY:C911($at_arrayTemp;$1->{$i})
		End for 
	Else 
		ALERT:C41("Type "+String:C10($type)+" is not supported by the IT_PopUpMenu function.")
End case 

Case of 
	: ((Count parameters:C259=2) & (Not:C34(Is nil pointer:C315($2))))
		$type2:=Type:C295($2->)
		Case of 
			: (($type2=Is real:K8:4) | ($type2=Is integer:K8:5) | ($type2=Is longint:K8:6))
				$vt_text:=String:C10($2->)
			: ($type2=Is date:K8:7)
				$vt_text:=String:C10($2->)
			: (($type2=Is alpha field:K8:1) | ($type2=Is string var:K8:2) | ($type2=Is text:K8:3))
				$vt_text:=$2->
			: ($type2=Is boolean:K8:9)
				$vt_text:=String:C10(Num:C11($2->))
			Else 
				ALERT:C41("Type "+String:C10($type)+" is not supported by the IT_PopUpMenu function.")
				$vt_text:=""
		End case 
		If ($vt_text#"")
			$default:=Find in array:C230($at_arrayTemp;$vt_text)
			If ($default=-1)
				$default:=0
			End if 
		End if 
End case 
If ($default#0)
	For ($i;1;Size of array:C274($at_arrayTemp))
		If ($i=$default)
			$at_arrayTemp{$i}:="!"+Char:C90(18)+$at_arrayTemp{$i}
			$i:=Size of array:C274($at_arrayTemp)
		End if 
	End for 
End if 
If (Size of array:C274($at_arrayTemp)>0)
	$text:=AT_array2text (->$at_arrayTemp)
	$0:=Pop up menu:C542($text;$default)
Else 
	$0:=0
End if 