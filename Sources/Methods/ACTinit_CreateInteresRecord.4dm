//%attributes = {}
  //ACTinit_CreateInteresRecord

CREATE RECORD:C68([xxACT_Items:179])
[xxACT_Items:179]ID:1:=-100
[xxACT_Items:179]Glosa:2:="Intereses"
[xxACT_Items:179]Glosa_de_Impresión:20:="Intereses"
[xxACT_Items:179]Monto:7:=0
[xxACT_Items:179]EsDescuento:6:=False:C215
[xxACT_Items:179]EsRelativo:5:=False:C215
[xxACT_Items:179]Afecto_a_descuentos:4:=False:C215
[xxACT_Items:179]Moneda:10:=ST_GetWord (ACT_DivisaPais ;1;";")
[xxACT_Items:179]Meses_de_cargo:9:=0
[xxACT_Items:179]Afecto_IVA:12:=False:C215
[xxACT_Items:179]AfectoDsctoIndividual:17:=False:C215
[xxACT_Items:179]No_de_Cuenta_Contable:15:=""
[xxACT_Items:179]Centro_de_Costos:21:=""
[xxACT_Items:179]No_CCta_contable:22:=""
[xxACT_Items:179]CCentro_de_costos:23:=""
[xxACT_Items:179]Imputacion_Unica:24:=False:C215
[xxACT_Items:179]CodAuxCta:27:=""
[xxACT_Items:179]CodAuxCCta:28:=""
[xxACT_Items:179]AfectoInteres:26:=False:C215
[xxACT_Items:179]TasaInteresMensual:25:=0
[xxACT_Items:179]TipoInteres:29:=False:C215
[xxACT_Items:179]UbicacionInteresGenerado:30:=[xxACT_Items:179]UbicacionInteresGenerado:30 ?+ 2
[xxACT_Items:179]No_incluir_en_DocTributario:31:=False:C215
[xxACT_Items:179]AgruparInteresesAC:33:=False:C215
[xxACT_Items:179]AgruparInteresesDT:34:=False:C215
[xxACT_Items:179]Auto_UUID:44:=Generate UUID:C1066  //ASM 20141222 Ticket: 140199
SAVE RECORD:C53([xxACT_Items:179])