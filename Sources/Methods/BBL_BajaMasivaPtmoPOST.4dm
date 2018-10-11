//%attributes = {}

BBLdbu_RebuildStatistics 
If ((<>bXS_esServidorOficial) & (LICENCIA_esModuloAutorizado (1;SchoolNet)))
	SN3_SendObsoletosXML (False:C215)
	SN3_FTP_SendFiles 
End if 