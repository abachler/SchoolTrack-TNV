//%attributes = {}
  //ACTter_CreateRecord

C_TEXT:C284($vt_rut;$vt_rs;$vt_direccion;$vt_comuna;$vt_ciudad;$vt_giro)
C_BOOLEAN:C305($vb_esEmpresa)
C_TEXT:C284($t_paterno;$t_materno;$t_nombres)

$vt_rut:=Replace string:C233(Replace string:C233($1;".";"");"-";"")
$vt_rs:=$2
$vb_esEmpresa:=$3
If (Count parameters:C259>=4)
	$vt_direccion:=$4
End if 
If (Count parameters:C259>=5)
	$vt_comuna:=$5
End if 
If (Count parameters:C259>=6)
	$vt_ciudad:=$6
End if 
If (Count parameters:C259>=7)
	$vt_giro:=$7
End if 
If (Count parameters:C259>=8)
	$t_paterno:=$8
End if 
If (Count parameters:C259>=9)
	$t_materno:=$9
End if 
If (Count parameters:C259>=10)
	$t_nombres:=$10
End if 
  //$vt_rut:=""
  //$vt_rs:=""
  //$vb_esEmpresa:=false
  //$vt_direccion:=""
  //$vt_comuna:=""
  //$vt_ciudad:=""
  //$vt_giro:=""
  //ACTter_CreateRecord ($vt_rut;$vt_rs;$vb_esEmpresa;$vt_direccion;$vt_comuna;$vt_ciudad;$vt_giro)

CREATE RECORD:C68([ACT_Terceros:138])
[ACT_Terceros:138]Id:1:=SQ_SeqNumber (->[ACT_Terceros:138]Id:1)
[ACT_Terceros:138]RUT:4:=$vt_rut
[ACT_Terceros:138]Razon_Social:3:=$vt_rs
[ACT_Terceros:138]Es_empresa:2:=$vb_esEmpresa
[ACT_Terceros:138]Direccion:5:=$vt_direccion
[ACT_Terceros:138]Comuna:6:=$vt_comuna
[ACT_Terceros:138]Ciudad:7:=$vt_ciudad
[ACT_Terceros:138]Giro:8:=$vt_giro
  //20160607 RCH
[ACT_Terceros:138]Apellido_Paterno:16:=$t_paterno
[ACT_Terceros:138]Apellido_Materno:17:=$t_materno
[ACT_Terceros:138]Nombres:18:=$t_nombres
  //TRACE
$0:=ACTter_fSave (True:C214)