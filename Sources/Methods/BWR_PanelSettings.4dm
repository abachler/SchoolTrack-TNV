//%attributes = {}
  // ` MÉTODO: BWR_PanelSettings
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 28/02/12, 16:07:06
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // BWR_PanelSettings()
  // ----------------------------------------------------




  // CODIGO PRINCIPAL
KRL_UnloadAll 
UFLD_LoadFileTplt (yBWR_currentTable)
dhBWR_TableInitialisations 
QRY_BuildQueryMenu 
BWR_LoadFormReportsArrays 

If (vlBWR_ALPColumns>0)
	AL_UpdateArrays (xALP_Browser;0)
	AL_RemoveArrays (xALP_Browser;1;vlBWR_ALPColumns)
End if 

BWR_InitArrays 
BWR_SetDataPointers 
BWR_SetBrowserArrays 
BWR_DefaultBrowserSettings 