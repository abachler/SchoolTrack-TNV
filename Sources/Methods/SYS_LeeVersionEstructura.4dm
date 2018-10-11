//%attributes = {}
  // Método: SYS_LeeVersionEstructura

C_TEXT:C284($1)
C_POINTER:C301($2;$y_pointer)
C_LONGINT:C283($l_versionPrincipal;$l_revision;$l_Build)
C_TEXT:C284($t_Aplicacion_y_version;$t_versionCompleta;$t_tipoVersion;$t_versionCompleta;$t_DTS_Generacion)
C_TEXT:C284($0)

ARRAY TEXT:C222($aVersionData;0)
LIST TO ARRAY:C288("XS_ApplicationVersion";$aVersionData)

$t_Aplicacion_y_version:=$aVersionData{1}
$l_versionPrincipal:=Num:C11($aVersionData{2})
$l_revision:=Num:C11($aVersionData{3})
$l_Build:=Num:C11($aVersionData{4})
$t_tipoVersion:=$aVersionData{5}
$t_DTS_Generacion:=$aVersionData{6}
$l_marcadorCodigo:=Num:C11($aVersionData{7})

  //If ($aVersionData{5}="@Beta@")
  //$t_tipoVersion:=" beta"
  //Else 
  //$t_tipoVersion:=""
  //End if 

$t_versionCompleta:=String:C10($l_versionPrincipal;"00")+"."+String:C10($l_revision;"00")+"."+String:C10($l_Build;"00000")  //+$t_tipoVersion
$0:=$t_versionCompleta


If (Count parameters:C259=2)
	$y_variable:=$2
	Case of 
		: ($1="aplicacion")
			$y_variable->:=$t_Aplicacion_y_version
			
		: ($1="principal")  // version principal
			$y_variable->:=$l_versionPrincipal
			
		: ($1="revision")  // revision
			$y_variable->:=$l_revision
			
		: ($1="build")  // build
			$y_variable->:=$l_Build
			
		: ($1="tipo")  // tipo version
			$y_variable->:=$t_tipoVersion
			
		: ($1="dts")  // dts generacion
			$y_variable->:=$t_DTS_Generacion
			
		: ($1="marcadorCodigo")  // dts generacion
			$y_variable->:=$l_marcadorCodigo
	End case 
End if 