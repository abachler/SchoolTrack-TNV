//%attributes = {}
  // UFLD_LoadFields()
  // Por: Alberto Bachler: 08/03/13, 19:41:24
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_POINTER:C301($1)
C_POINTER:C301($2)
C_POINTER:C301($3)
C_POINTER:C301($4)

C_LONGINT:C283($l_indiceCampos;$l_numero;$l_TipoCampo;$l_numeroDeCampos)
C_POINTER:C301(vy_CampoEnSubtabla;vy_Subtabla;$y_tabla)
C_REAL:C285($r_numero)
C_TEXT:C284($t_valorLiteral;$t_formato)
C_LONGINT:C283($l_numeroDeCampos)

If (False:C215)
	C_POINTER:C301(UFLD_LoadFields ;$1)
	C_POINTER:C301(UFLD_LoadFields ;$2)
	C_POINTER:C301(UFLD_LoadFields ;$3)
	C_POINTER:C301(UFLD_LoadFields ;$4)
End if 

$y_tabla:=$1
vy_Subtabla:=$2
vy_CampoEnSubtabla:=$3
If (Count parameters:C259=4)
	AL_UpdateArrays ($4->;0)
	vy_ReferenciaAreaList:=$4
End if 
ARRAY TEXT:C222(aUFItmName;0)
ARRAY TEXT:C222(aUFItmVal;0)
_O_ALL SUBRECORDS:C109(vy_Subtabla->)
_O_FIRST SUBRECORD:C61(vy_Subtabla->)

For ($l_indiceCampos;1;Size of array:C274(aUFID))
	$l_TipoCampo:=aUFType{$l_indiceCampos}
	AT_Insert (Size of array:C274(aUFItmName)+1;1;->aUFItmName;->aUFItmVal)
	$l_numeroDeCampos:=Size of array:C274(aUFItmName)
	aUFItmName{$l_numeroDeCampos}:=aUFList{$l_indiceCampos}
	_O_QUERY SUBRECORDS:C108(vy_Subtabla->;vy_CampoEnSubtabla->=String:C10(aUFId{$l_indiceCampos};"00000/@"))
	Case of 
		: (_O_Records in subselection:C7(vy_Subtabla->)=0)
			_O_CREATE SUBRECORD:C72(vy_Subtabla->)
			vy_CampoEnSubtabla->:=String:C10(aUFID{$l_indiceCampos};"00000/")
		: (_O_Records in subselection:C7(vy_Subtabla->)=1)
			$t_valorLiteral:=Substring:C12(vy_CampoEnSubtabla->;7)
			Case of 
				: ($l_TipoCampo=0)
					aUFItmVal{$l_numeroDeCampos}:=$t_valorLiteral
				: ($l_TipoCampo=Is real:K8:4)
					$r_numero:=Num:C11($t_valorLiteral)
					$t_formato:="###"+<>tXS_RS_ThousandsSeparator+"###"+<>tXS_RS_ThousandsSeparator+"###"+<>tXS_RS_ThousandsSeparator+"##0"+<>tXS_RS_DecimalSeparator+"00"
					aUFItmVal{$l_numeroDeCampos}:=String:C10($r_numero;$t_formato)
				: ($l_TipoCampo=Is date:K8:7)
					aUFItmVal{$l_numeroDeCampos}:=String:C10(DT_Num2date (Num:C11($t_valorLiteral));7)
				: ($l_TipoCampo=Is longint:K8:6)
					$t_formato:="###"+<>tXS_RS_ThousandsSeparator+"###"+<>tXS_RS_ThousandsSeparator+"###"+<>tXS_RS_ThousandsSeparator+"##0"
					$l_numero:=Num:C11($t_valorLiteral)
					aUFItmVal{$l_numeroDeCampos}:=String:C10($l_numero;$t_formato)
			End case 
		Else 
			_O_ORDER SUBRECORDS BY:C107(vy_Subtabla->;vy_CampoEnSubtabla->;>)
			While (Not:C34(_O_End subselection:C37(vy_Subtabla->)))
				$t_valorLiteral:=Substring:C12(vy_CampoEnSubtabla->;7)
				Case of 
					: ($l_TipoCampo=0)
						aUFItmVal{$l_numeroDeCampos}:=aUFItmVal{$l_numeroDeCampos}+"; "+$t_valorLiteral
					: ($l_TipoCampo=Is real:K8:4)
						$r_numero:=Num:C11($t_valorLiteral)
						$t_formato:="###"+<>tXS_RS_ThousandsSeparator+"###"+<>tXS_RS_ThousandsSeparator+"###"+<>tXS_RS_ThousandsSeparator+"##0"+<>tXS_RS_DecimalSeparator+"00"
						aUFItmVal{$l_numeroDeCampos}:=String:C10($r_numero;$t_formato)
					: ($l_TipoCampo=Is date:K8:7)
						aUFItmVal{$l_numeroDeCampos}:=String:C10(DT_Num2date (Num:C11($t_valorLiteral));7)
					: ($l_TipoCampo=Is longint:K8:6)
						$t_formato:="###"+<>tXS_RS_ThousandsSeparator+"###"+<>tXS_RS_ThousandsSeparator+"###"+<>tXS_RS_ThousandsSeparator+"##0"
						$l_numero:=Num:C11($t_valorLiteral)
						aUFItmVal{$l_numeroDeCampos}:=String:C10($l_numero;$t_formato)
				End case 
				aUFItmVal{$l_numeroDeCampos}:=ST_ClearSpaces (ST_StripPreceed (aUFItmVal{$l_numeroDeCampos};";"))
				_O_NEXT SUBRECORD:C62(vy_Subtabla->)
			End while 
	End case 
End for 

SORT ARRAY:C229(aUFItmName;aUFItmVal;>)

vUFValue:=""
aUFItmName:=0
aUFItmVal:=0
ttlInfo:=""
If (Count parameters:C259=4)
	AL_UpdateArrays (vy_ReferenciaAreaList->;-2)
	AL_SetLine (vy_ReferenciaAreaList->;0)
End if 


If (USR_checkRights ("M";$y_tabla)=False:C215)
	AL_SetEnterable (vy_ReferenciaAreaList->;2;0)
Else 
	AL_SetEnterable (vy_ReferenciaAreaList->;2;1)
End if 
