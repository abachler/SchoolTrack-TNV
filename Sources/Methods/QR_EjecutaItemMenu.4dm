//%attributes = {}
  // QR_EjecutaItemMenu()
  //
  //
  // creado por: Alberto Bachler Klein: 25-03-16, 11:14:13
  // -----------------------------------------------------------
C_TEXT:C284($1)

C_TEXT:C284($t_parametro)


If (False:C215)
	C_TEXT:C284(QR_EjecutaItemMenu ;$1)
End if 

$t_parametro:=$1

Case of 
	: ($t_parametro="nuevo")
		QR_NewTemplate 
		
	: ($t_parametro="4dview")
		QR_Report_a_4DView 
		
	: (($t_parametro="printer") | ($t_parametro="preview") | ($t_parametro="pdf") | ($t_parametro="txt") | ($t_parametro="xml") | ($t_parametro="html") | ($t_parametro="4dview") | ($t_parametro="pict"))
		QR_ImprimeInforme (Record number:C243([xShell_Reports:54]);$t_parametro)
	: ($t_parametro="editar")
		QR_EditTemplate 
	: ($t_parametro="duplicar")
		QR_DuplicateTemplate 
	: ($t_parametro="renombrar")
		QR_RenameTemplate 
	: ($t_parametro="retirarFavorito")
		QR_RemoveFromFavorites 
	: ($t_parametro="eliminar")
		QR_DeleteTemplate 
	: ($t_parametro="estandar")
		QR_MakeTemplateStandard 
	: ($t_parametro="publico")
		QR_MakeTemplatePublic 
	: ($t_parametro="consulta")
		QR_AssociateQuery 
	: ($t_parametro="propiedades")
		QR_ReportProperties 
	: ($t_parametro="archivar")
		QR_ArchiveReport 
	: ($t_parametro="restaurar")
		QR_RestoreFromArchive 
	: ($t_parametro="repositorio")
		RIN_SubirAlRepositorio 
		
End case 
QR_AjustesMenu 