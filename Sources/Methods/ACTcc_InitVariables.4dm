//%attributes = {}
  //ACTcc_InitVariables

ARRAY TEXT:C222(atACT_TipoTransacciones;5)
atACT_TipoTransacciones{1}:=__ ("Cargos emitidos y pagos")
atACT_TipoTransacciones{2}:=__ ("Sólo cargos emitidos")
atACT_TipoTransacciones{3}:=__ ("Sólo cargos proyectados")
atACT_TipoTransacciones{4}:=__ ("Sólo pagos")
atACT_TipoTransacciones{5}:=__ ("Todas las transacciones")

If (atACT_TipoTransacciones=0)
	atACT_TipoTransacciones:=1
End if 

ARRAY TEXT:C222(atACT_TipoDocumentoCartera;2)
atACT_TipoDocumentoCartera{1}:="Cheques"
atACT_TipoDocumentoCartera{2}:="Letras"

If (atACT_TipoDocumentoCartera=0)
	atACT_TipoDocumentoCartera:=1
End if 

<>vbACT_NoCCTrigger:=False:C215