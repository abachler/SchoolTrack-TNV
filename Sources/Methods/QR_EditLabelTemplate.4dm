//%attributes = {}
  // QR_EditLabelTemplate()
  //
  //
  // creado por: Alberto Bachler Klein: 08-04-16, 16:33:52
  // -----------------------------------------------------------
C_BOOLEAN:C305($b_reconstruirLista)
C_LONGINT:C283($l_SegundosModificacion)
C_TIME:C306($h_refDocumento)
C_POINTER:C301($y_tabla)
C_TEXT:C284($t_mensaje;$t_nombreArchivo;$t_rutaArchivo;$t_rutaInforme)

$b_reconstruirLista:=False:C215

$t_rutaEtiquetas:=SYS_CarpetaAplicacion (CLG_DocumentosLocal)+"Modelos Etiquetas"+Folder separator:K24:12
CREATE FOLDER:C475($t_rutaEtiquetas;*)

  //$t_mensaje:=Replace string(__ ("No es posible abrir automáticamente un modelo de etiquetas.\r\rPara abrir el informe seleccione "+__ ("Archivo / Abrir ")+"\rBusque el informe en ˆ0, selecciónelo y haga clic en el botón Abrir.");"ˆ0";$t_rutaEtiquetas)
  //$t_mensaje:=Replace string(__ ("No es posible abrir automáticamente un modelo de etiquetas.\r\rEn el Editor de etiquetas haga clic en el botó Cargar y seleccione el modelo de etiquetas en ^0");"^0";$t_rutaEtiquetas)
$t_mensaje:=__ ("No es posible abrir automáticamente un modelo de etiquetas.\r\rEn el Editor de Etiquetas haga clic en el botón Cargar y seleccione el modelo de etiquetas en ^0";$t_rutaEtiquetas)  //20180611 RCH Ticket 207253
ModernUI_Notificacion (__ ("Edición de un modelo de etiquetas");$t_mensaje;"OK")


USE CHARACTER SET:C205("macRoman";0)

[xShell_Reports:54]ReportName:26:=Replace string:C233([xShell_Reports:54]ReportName:26;".4LB";"")

$t_nombreArchivo:=[xShell_Reports:54]ReportName:26+".4LB"
$t_rutaArchivo:=$t_rutaEtiquetas+$t_nombreArchivo
$h_refDocumento:=Create document:C266($t_rutaArchivo;"4DET")
$t_rutaInforme:=document
SEND PACKET:C103($h_refDocumento;[xShell_Reports:54]Texto:5)
CLOSE DOCUMENT:C267($h_refDocumento)
$l_SegundosModificacion:=SYS_GetFileMSecs ($t_rutaArchivo)


ok:=1
If (([xShell_Reports:54]RelatedTable:14#0) & (Table:C252(->[xShell_Reports:54]RelatedTable:14)#Table:C252(yBWR_currentTable)))
	$y_tabla:=Table:C252([xShell_Reports:54]RelatedTable:14)
Else 
	$y_tabla:=Table:C252([xShell_Reports:54]MainTable:3)
End if 
OK:=QR_SetUnivers ([xShell_Reports:54]MainTable:3;[xShell_Reports:54]RelatedTable:14)


If ([xShell_Reports:54]ExecuteBeforePrinting:4#"")
	EXE_Execute ([xShell_Reports:54]ExecuteBeforePrinting:4)
End if 


USE CHARACTER SET:C205("macRoman";1)

SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
PRINT LABEL:C39($y_tabla->;Char:C90(1))
SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
vt_LastEditedReport:=$t_nombreArchivo

$b_reconstruirLista:=QR_UpdateTemplatesFromFolder ($t_rutaEtiquetas;vlQR_ReportRecNum;$l_SegundosModificacion)
If ($b_reconstruirLista)
	QR_BuildReportHList 
	REDUCE SELECTION:C351([xShell_Reports:54];0)
End if 

USE CHARACTER SET:C205(*;0)
