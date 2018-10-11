//%attributes = {}
  // DT_ValidaFechaTexto (fecha:T; formatoFecha:L) -> fechaValida:B
  // fecha: texto
  // formatoFecha: 1: (MM/DD/YYYY) = DEFAULT, 2 (DD/MM/YYYY), 3 (YYYY/MM/DD)
  //
  // creado por: Alberto Bachler Klein: 20-12-16, 19:26:26
  // basado en codigo 4D KnowledgeBase
  // -----------------------------------------------------------

C_BOOLEAN:C305($0;$b_fechaValida)
C_TEXT:C284($t_fecha;$1)
C_LONGINT:C283($l_formatoFecha;$2)


C_LONGINT:C283($l_parametros)
C_TEXT:C284($t_patronRegex)

$l_parametros:=Count parameters:C259
$b_fechaValida:=False:C215

If ($l_parametros>=1)
	$t_fecha:=$1
	If ($l_parametros>1)
		If ($2<=3)
			$l_formatoFecha:=$2
		Else 
			$l_formatoFecha:=1
		End if 
	Else 
		$l_formatoFecha:=1
	End if 
	
	Case of 
		: ($l_formatoFecha=1)  // MM/DD/YYYY
			$t_patronRegex:="((0[13578]|1[02])[\\/|\\-|\\.](0[1-9]|[12][0-9]|3[01])[(\\/|\\-|\\.](18|19|20)[0-9]{2})|((0[469]|11)[\\/|\\-|\\.](0[1-9]|[12][0-9]|30)[(\\/|\\-|\\.](18|19|20)[0-9]{2})|((02)[(\\/|\\-|\\.](0[1-9]|1[0-9]|2[0-8])[(\\/|\\-|\\.](18|19|20)[0-9]{2})|((02)[(\\/|\\-|\\.]29[(\\/|\\-|"+"\\.](((18|19|20)(04|08|[2468][048]|[13579][26])"+")|2000))"
			
		: ($l_formatoFecha=2)  // DD/MM/YYYY
			$t_patronRegex:="(?:(?:31(\\/|\\-|\\.)(?:0?[13578]|1[02]))\\1|(?:(?:29|30)(\\/|\\-|\\.)(?:0?[1,3-9]|1[0-2])\\2))(?:(?:1[6-9]|[2-9]\\d)?\\d{2})|(?:29(\\/|\\-|\\.)0?2\\3(?:(?:(?:1[6-9]|[2-9]\\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))|(?:0?[1-9]|1\\d|2["+"0-8"+"])(\\/|\\-|\\.)(?:(?:0?[1-9])|(?:1[0-2]))\\4(?:(?:1[6-9]|[2-9]\\d)?\\d{2})"
			
		Else   // YYYY/MM/DD
			$t_patronRegex:="((18|19|20)[0-9]{2}[\\/|\\-|\\.](0[13578]|1[02])[\\/|\\-|\\.](0[1-9]|[12][0-9]|3[01]))|(18|19|20)[0-9]{2}[\\-.](0[469]|11)[\\/|\\-|\\.](0[1-9]|[12][0-9]|30)|(18|19|20)[0-9]{2}[\\/|\\-|\\.](02)[\\/|\\-|\\.](0[1-9]|1[0-9]|2[0-8])|(((18|19|20)(04|08|[2468][048]|[13579]["+"26]))|2000)[\\/|\\-|\\.](02)[\\/|\\-|\\.]29"
			
	End case 
	$b_fechaValida:=Match regex:C1019($t_patronRegex;$t_fecha;1)
	
End if 

$0:=$b_fechaValida
