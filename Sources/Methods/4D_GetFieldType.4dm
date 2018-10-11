//%attributes = {}
  // 4D_GetFieldType()
  //
  //
  // creado por: Alberto Bachler Klein: 19-01-16, 18:11:21
  // -----------------------------------------------------------
C_LONGINT:C283($l_largoAlpha;$l_tipoCampo)
C_TEXT:C284($t_tipoDeCampo)

$l_tipoCampo:=$1

Case of 
	: (($l_tipoCampo=Is alpha field:K8:1) & ($l_largoAlpha=0))
		$t_tipoDeCampo:="UUID"
	: ($l_tipoCampo=Is alpha field:K8:1)
		$t_tipoDeCampo:="Alpha "+String:C10($l_largoAlpha)
	: ($l_tipoCampo=Is text:K8:3)
		$t_tipoDeCampo:="Text"
	: ($l_tipoCampo=Is real:K8:4)
		$t_tipoDeCampo:="Real"
	: ($l_tipoCampo=Is longint:K8:6)
		$t_tipoDeCampo:="Longint"
	: ($l_tipoCampo=Is integer 64 bits:K8:25)
		$t_tipoDeCampo:="Int64"
	: ($l_tipoCampo=Is integer:K8:5)
		$t_tipoDeCampo:="Integer"
	: ($l_tipoCampo=Is date:K8:7)
		$t_tipoDeCampo:="Date"
	: ($l_tipoCampo=Is time:K8:8)
		$t_tipoDeCampo:="Time"
	: ($l_tipoCampo=Is boolean:K8:9)
		$t_tipoDeCampo:="Boolean"
	: ($l_tipoCampo=Is picture:K8:10)
		$t_tipoDeCampo:="Picture"
	: ($l_tipoCampo=Is subtable:K8:11)
		$t_tipoDeCampo:="Subtable"
	: ($l_tipoCampo=Is BLOB:K8:12)
		$t_tipoDeCampo:="Blob"
End case 

$0:=$t_tipoDeCampo