Case of 
	: (Form event:C388=On Load:K2:1)
		C_PICTURE:C286(vPict;vPict2)
		vsBWR_CurrentModule:="SchoolTrack"
		XS_SetInterface 
		
		vl_Page:=1
		
		_O_DISABLE BUTTON:C193(bPrev)
		vlTableNumber:=0
		vt_PageNumber:="1 de 3"
		
		  //page 2
		ARRAY TEXT:C222(aPictureFormatName;0)
		PICTURE CODEC LIST:C992(aPictFormats)
		$pictureFormat:=".jpg"
		$el:=Find in array:C230(aPictFormats;$pictureFormat)
		If ($el>0)
			aPictFormats:=$el
		Else 
			aPictFormats:=0
		End if 
		vs_NewPictureFormat:=""
		vl_Calidad:=1000
		
		
		  //page 3
		hl_TablasFotos:=New list:C375
		APPEND TO LIST:C376(hl_TablasFotos;API Get Virtual Table Name (Table:C252(->[Alumnos:2]));Table:C252(->[Alumnos:2]))
		APPEND TO LIST:C376(hl_TablasFotos;API Get Virtual Table Name (Table:C252(->[Profesores:4]));Table:C252(->[Profesores:4]))
		APPEND TO LIST:C376(hl_TablasFotos;API Get Virtual Table Name (Table:C252(->[Personas:7]));Table:C252(->[Personas:7]))
		APPEND TO LIST:C376(hl_TablasFotos;API Get Virtual Table Name (Table:C252(->[Familia:78]));Table:C252(->[Familia:78]))
		APPEND TO LIST:C376(hl_TablasFotos;"Todas";-1)
		r1_EscalaRelativa:=0
		vl_escala:=100
		r2_EscalaFija:=0
		e1_Ancho:=0
		e2_Alto:=0
		vl_Ancho:=0
		vl_Alto:=0
		vt_ResizeMode:=""
		vl_ResizeValue:=0
		r3_SinCambios:=1
		OBJECT SET ENTERABLE:C238(vl_Escala;False:C215)
		OBJECT SET VISIBLE:C603(*;"escala@";False:C215)
		OBJECT SET ENTERABLE:C238(vl_Ancho;False:C215)
		OBJECT SET ENTERABLE:C238(vl_alto;False:C215)
		_O_DISABLE BUTTON:C193(e1_Ancho)
		_O_DISABLE BUTTON:C193(e2_Alto)
		
		OBJECT SET VISIBLE:C603(*;"respaldo@";False:C215)
		vt_DirectorioLocal:=""
		
		wref:=WDW_GetWindowID 
	: (Form event:C388=On Deactivate:K2:10)
		WDW_SetFrontmost (wref)
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		Case of 
			: (vl_Page=5)
				_O_DISABLE BUTTON:C193(bNext)
				_O_DISABLE BUTTON:C193(bPrev)
			: (vl_Page=4)
				_O_DISABLE BUTTON:C193(bNext)
			: (vl_Page=3)
				Case of 
					: (Selected list items:C379(hl_TablasFotos)=0)
						_O_DISABLE BUTTON:C193(bNext)
					: (r1_EscalaRelativa+r2_EscalaFija=0)
						vl_escala:=100
						_O_ENABLE BUTTON:C192(bNext)
					: ((vl_escala=0) & (r1_EscalaRelativa=1))
						_O_DISABLE BUTTON:C193(bNext)
					: ((vl_Alto+vl_Ancho=0) & (r2_EscalaFija=1))
						
					Else 
						_O_ENABLE BUTTON:C192(bNext)
				End case 
			Else 
				_O_ENABLE BUTTON:C192(bNext)
		End case 
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 