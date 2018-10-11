//%attributes = {}
  //WS_SubmitSupportRequest

C_BLOB:C604($blob)

$otRef:=OT BLOBToObject ($blob)
$schoolCode:=Num:C11(OT GetText ($otRef;"ID_Colegio"))
$fecha:=Date:C102(OT GetText ($otRef;"FECHA"))
$hora:=Time:C179(OT GetText ($otRef;"HORA"))
$email:=OT GetText ($otRef;"EMAIL")
$asunto:=OT GetText ($otRef;"ASUNTO")
$detalles:=OT GetText ($otRef;"DETALLES")
$incidente:=OT GetText ($otRef;"INCIDENTE")
$aplicacion:=OT GetText ($otRef;"APLICACION")
$OS:=OT GetText ($otRef;"OS")
$plataforma:=OT GetText ($otRef;"PLATAFORMA")
$telefono:=OT GetText ($otRef;"TELEFONO")
$nombre:=OT GetText ($otRef;"NOMBRE")
$prioridad:=OT GetText ($otRef;"PRIORIDAD")
$infoSistema:=OT GetText ($otRef;"SYS_infos")
OT Clear ($otRef)


