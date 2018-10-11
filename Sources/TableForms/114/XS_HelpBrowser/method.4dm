C_BOOLEAN:C305(vbWEB_executeJavaScript;vbWEB_ShowURL)

Case of 
	: (Form event:C388=On Load:K2:1)
		
		If (vt_HTML#"")
			WebArea_URL:="about:blank"  // para windows es obligatorio cargar primero una página antes de asignar un contenido
			WA SET PAGE CONTENT:C1037(*;"xWebArea";vt_HTML;"")
		End if 
		
		WA SET PREFERENCE:C1041(xWebArea;WA enable JavaScript:K62:4;vbWEB_executeJavaScript)
		WA SET PREFERENCE:C1041(xWebArea;WA enable Java applets:K62:3;True:C214)
		WA SET PREFERENCE:C1041(xWebArea;WA enable plugins:K62:5;True:C214)
		WA SET PREFERENCE:C1041(xWebArea;WA enable contextual menu:K62:6;True:C214)
		
		OBJECT SET VISIBLE:C603(*;"url@";vbWEB_ShowURL)
		OBJECT SET ENTERABLE:C238(WebArea_URL;vbWEB_URLEditable)
		
		
		
	: (Form event:C388=On Begin URL Loading:K2:45)
		OBJECT SET VISIBLE:C603(WebArea_progress;True:C214 & vbWEB_ShowURL)
		
	: (Form event:C388=On End URL Loading:K2:47)
		OBJECT SET VISIBLE:C603(WebArea_progress;False:C215)
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
		
	: (Form event:C388=On Unload:K2:2)
		vb_executeJavaScript:=False:C215
End case 
