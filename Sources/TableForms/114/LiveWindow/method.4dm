Case of 
	: (Form event:C388=On Load:K2:1)
		If (Application version:C493>="11@")
			
			C_TEXT:C284(vtWA_getContent;vtWA_currentURL;vtWA_title)
			C_BOOLEAN:C305(vbWA_GetContent)
			vtWA_getContent:=""
			vtWA_currentURL:=""
			vtWA_title:=""
			
			vb_Modificado_4Dv11:=True:C214
			  //activar este código en V11 y eliminar el código para version anterior o igual a 4D 2004
			  //el area plugin 4D Live window debe ser eliminada y reemplazada por el area nativa 4D Web Area
			
			WA OPEN URL:C1020(x4DLiveWindow;vt_URL)
			WA SET PREFERENCE:C1041(x4DLiveWindow;WA enable JavaScript:K62:4;True:C214)
			WA SET PREFERENCE:C1041(x4DLiveWindow;WA enable Java applets:K62:3;True:C214)
			WA SET PREFERENCE:C1041(x4DLiveWindow;WA enable plugins:K62:5;True:C214)
			WA SET PREFERENCE:C1041(x4DLiveWindow;WA enable contextual menu:K62:6;True:C214)
		Else 
			  //$err:=Web_SetURL (x4DLiveWindow;vt_URL;1)
			  //$err:=Web_SetPreferences (x4DLiveWindow;Web_kResize ;1)
		End if 
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
	: (Form event:C388=On Close Box:K2:21)
		If (vbWA_GetContent)
			vtWA_getContent:=WA Get page content:C1038(*;"x4DLiveWindow")
			vbWA_GetContent:=False:C215
		End if 
		vtWA_currentURL:=WA Get current URL:C1025(*;"x4DLiveWindow")
		vtWA_title:=WA Get page title:C1036(*;"x4DLiveWindow")
		CANCEL:C270
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 