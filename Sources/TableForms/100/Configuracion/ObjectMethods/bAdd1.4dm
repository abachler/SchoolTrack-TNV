  //[xxSTR_Periodos]configuracion.badd

GET LIST ITEM:C378(hl_TipoPeriodos;Selected list items:C379(hl_TipoPeriodos);$tipoPeriodos;$itemText)
DUPLICATE RECORD:C225([xxSTR_Periodos:100])
[xxSTR_Periodos:100]ID:1:=SQ_SeqNumber (->[xxSTR_Periodos:100]ID:1)
[xxSTR_Periodos:100]Nombre_Configuracion:2:=__ ("Configuración N° ")+String:C10([xxSTR_Periodos:100]ID:1)
[xxSTR_Periodos:100]Tipo_de_Periodos:3:=$tipoPeriodos
[xxSTR_Periodos:100]Auto_UUID:13:=Generate UUID:C1066  //20140107 ASM al duplicar los registros, tambien se duplicaban los UUID
SAVE RECORD:C53([xxSTR_Periodos:100])
vlSTR_Periodos_CurrentConfigRef:=[xxSTR_Periodos:100]ID:1
vt_NombreConfig:=[xxSTR_Periodos:100]Nombre_Configuracion:2
APPEND TO LIST:C376(hl_Configuraciones;[xxSTR_Periodos:100]Nombre_Configuracion:2;vlSTR_Periodos_CurrentConfigRef)
_O_REDRAW LIST:C382(hl_Configuraciones)
SELECT LIST ITEMS BY REFERENCE:C630(hl_Configuraciones;vlSTR_Periodos_CurrentConfigRef)
CFG_STR_PeriodosEscolares_NEW ("SaveConfig")
CFG_STR_PeriodosEscolares_NEW ("LoadConfig")
CFG_STR_CreaPeriodosEscolares (1;[xxSTR_Periodos:100]ID:1;<>ginstitucion)
SELECT LIST ITEMS BY POSITION:C381(hl_TipoPeriodos;2)