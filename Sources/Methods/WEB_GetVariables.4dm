//%attributes = {}
  //WEB_GetVariables
C_TEXT:C284($1;$t_url;$t_parameters)
C_POINTER:C301($2;$3)
C_BOOLEAN:C305($0)
C_TEXT:C284($t_method;$t_action;$t_parameterPair)
C_LONGINT:C283($countParameters;$i)
ARRAY TEXT:C222($aHeaderNames;0)
ARRAY TEXT:C222($aHeaderValues;0)
ARRAY TEXT:C222($aParameterNames;0)
ARRAY TEXT:C222($aParameterValues;0)
C_TEXT:C284($action)

$t_url:=$1

If (Count parameters:C259>=4)
	$action:=$4->
End if 

WEB GET HTTP HEADER:C697($aHeaderNames;$aHeaderValues)
$b_retorno:=True:C214
$t_method:=NV_GetValueFromPairedArrays (->$aHeaderNames;->$aHeaderValues;"X-METHOD")
Case of 
	: ($t_method="GET")
		If (Position:C15("?";$action)>0)
			$action:=Substring:C12($action;1;Position:C15("?";$action)-1)
		End if 
		$t_parameters:=ST_GetWord ($t_url;2;"?")
		If ($t_parameters#"")
			$t_action:=Substring:C12($t_action;1;Position:C15("?";$t_action)-1)
			$countParameters:=ST_CountWords ($t_parameters;0;"&")
			AT_RedimArrays ($countParameters;$2;$3)
			For ($i;1;$countParameters)
				$t_parameterPair:=ST_GetWord ($t_parameters;$i;"&")
				APPEND TO ARRAY:C911($aParameterNames;ST_GetWord ($t_parameterPair;1;"="))
				APPEND TO ARRAY:C911($aParameterValues;ST_GetWord ($t_parameterPair;2;"="))
			End for 
		End if 
	: ($t_method="POST")
		WEB GET VARIABLES:C683($aParameterNames;$aParameterValues)
	Else 
		$b_retorno:=False:C215
End case 

COPY ARRAY:C226($aParameterNames;$2->)
COPY ARRAY:C226($aParameterValues;$3->)

If ($action#"")
	$4->:=$action
End if 

$0:=$b_retorno