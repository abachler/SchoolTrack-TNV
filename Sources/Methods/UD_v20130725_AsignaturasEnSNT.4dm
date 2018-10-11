//%attributes = {}
  // UD_v20130725_AsignaturasEnSNT()
  // Por: Alberto Bachler: 25/07/13, 15:04:04
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_opcionPublicacion)


QUERY:C277([Asignaturas:18];[Asignaturas:18]En_InformesInternos:14=True:C214)
ARRAY LONGINT:C221($al_opcionPublicacion;Records in selection:C76([Asignaturas:18]))
$l_opcionPublicacion:=$l_opcionPublicacion ?+ 0
$l_opcionPublicacion:=$l_opcionPublicacion ?+ 1
$l_opcionPublicacion:=$l_opcionPublicacion ?+ 2
$l_opcionPublicacion:=$l_opcionPublicacion ?+ 3
AT_Populate (->$al_opcionPublicacion;->$l_opcionPublicacion)

KRL_Array2Selection (->$al_opcionPublicacion;->[Asignaturas:18]Publicar_en_SchoolNet:60)

