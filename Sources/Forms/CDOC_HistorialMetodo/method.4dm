  // CDOC_HistorialMetodo()
  // Por: Alberto Bachler: 15/04/13, 19:25:39
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_DATE:C307($d_fecha)
C_TIME:C306($h_hora)
C_LONGINT:C283($error;$i;$l_alto;$l_ancho;$l_elemento;$l_IdMetodo)
C_TEXT:C284($t_codigo;$t_DTS_VersionActual;$t_html)

ARRAY LONGINT:C221($al_metodos_Ids;0)
ARRAY TEXT:C222($at_metodos_Nombres;0)
C_BLOB:C604(vx_blobHistorial)
C_TEXT:C284(vt_NombreMetodo)

If (Form event:C388=On Outside Call:K2:11)
	
End if 

Case of 
	: ((Form event:C388=On Load:K2:1) | (Form event:C388=On Outside Call:K2:11))
		ARRAY TEXT:C222(at_Modificaciones_DTS;0)
		ARRAY TEXT:C222(at_Modificaciones_Autor;0)
		ARRAY TEXT:C222(at_Modificaciones_Codigo;0)
		ARRAY TEXT:C222(at_Modificaciones_Descripcion;0)
		
		ARRAY LONGINT:C221(al_CodigoActual_linea;0)
		ARRAY TEXT:C222(at_CodigoActual_Codigo;0)
		
		ARRAY LONGINT:C221(al_CodigoAnterior_linea;0)
		ARRAY TEXT:C222(at_CodigoAnterior_Codigo;0)
		
		ARRAY LONGINT:C221(al_modificaciones_Estilo;0)
		ARRAY LONGINT:C221(al_modificaciones_Color_fondo;0)
		ARRAY LONGINT:C221(al_modificaciones_Color_texto;0)
		
		BLOB_Blob2Vars (->vx_blobHistorial;0;->at_Modificaciones_DTS;->at_Modificaciones_Autor;->at_Modificaciones_Descripcion;->at_Modificaciones_Codigo)
		
		$t_html:="<html>"
		$t_html:=$t_html+"<head>"
		$t_html:=$t_html+"<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\"/>"
		$t_html:=$t_html+"</head>"
		$t_html:=$t_html+"<body>$t_html</body></html>"
		
		If (Size of array:C274(at_modificaciones_DTS)>=1)
			4D_GetMethodList (->$at_metodos_Nombres;->$al_metodos_Ids)
			$l_elemento:=Find in array:C230($at_metodos_Nombres;vt_NombreMetodo)
			If ($l_elemento>0)
				$l_IdMetodo:=$al_metodos_Ids{$l_elemento}
				$t_codigo:=4D_GetMethodTextByID ($l_IdMetodo)
				$error:=API Get Resource Timestamp ("CC4D";$l_IdMetodo;$d_fecha;$h_hora)
				$t_DTS_VersionActual:=DTS_MakeFromDateTime ($d_fecha;$h_hora)
				APPEND TO ARRAY:C911(at_modificaciones_DTS;$t_DTS_VersionActual)
				APPEND TO ARRAY:C911(at_modificaciones_autor;USR_GetUserName (USR_GetUserID )+"(?)")
				APPEND TO ARRAY:C911(at_modificaciones_Descripcion;"")
				APPEND TO ARRAY:C911(at_modificaciones_Codigo;$t_codigo)
				SORT ARRAY:C229(at_Modificaciones_DTS;at_Modificaciones_Autor;at_Modificaciones_Codigo;at_Modificaciones_Descripcion;<)
				
			End if 
			
			ARRAY LONGINT:C221(al_modificaciones_Estilo;Size of array:C274(at_Modificaciones_DTS))
			ARRAY LONGINT:C221(al_modificaciones_Color_fondo;Size of array:C274(at_Modificaciones_DTS))
			ARRAY LONGINT:C221(al_modificaciones_Color_texto;Size of array:C274(at_Modificaciones_DTS))
			For ($i;1;Size of array:C274(at_Modificaciones_DTS))
				If (at_Modificaciones_DTS{$i}=$t_DTS_VersionActual)
					at_modificaciones_DTS{$i}:="Esta estructura: "+DTS_GetDateTimeString (at_Modificaciones_DTS{$i};Internal date short special:K1:4;HH MM SS:K7:1)
				Else 
					at_Modificaciones_DTS{$i}:="Repositorio: "+DTS_GetDateTimeString (at_Modificaciones_DTS{$i};Internal date short special:K1:4;HH MM SS:K7:1)
				End if 
				at_Modificaciones_Descripcion{$i}:=Replace string:C233(at_Modificaciones_Descripcion{$i};"$t_html";$t_html)
				al_modificaciones_Color_fondo{$i}:=0x00FFFFFF
				al_modificaciones_Color_Texto{$i}:=0
				al_modificaciones_Estilo{$i}:=0
			End for 
		End if 
		
		OBJECT SET TITLE:C194(*;"vl_tituloCodigo_Actual";at_modificaciones_DTS{1})
		$t_codigo:=at_modificaciones_Codigo{1}
		
		CDOC_ListaLineaCodigo ($t_codigo;->at_CodigoActual_Codigo;->al_CodigoActual_linea)
		vt_fechaAutor_Izquierda:=at_modificaciones_DTS{1}+" - "+at_modificaciones_Autor{1}
		vl_lineas_Izquierda:=Size of array:C274(al_CodigoActual_linea)
		vl_largo_Izquierda:=Length:C16($t_codigo)
		al_Modificaciones_estilo{1}:=Bold:K14:2
		al_modificaciones_color_texto{1}:=0
		al_modificaciones_color_fondo{1}:=0x00F3FFF3
		
		If (Size of array:C274(at_modificaciones_DTS)>=2)
			OBJECT SET TITLE:C194(*;"vl_tituloCodigo_Anterior";at_modificaciones_DTS{2})
			$t_codigo:=at_modificaciones_Codigo{2}
			CDOC_ListaLineaCodigo ($t_codigo;->at_CodigoAnterior_Codigo;->al_CodigoAnterior_linea)
			
			vt_fechaAutor_Derecha:=at_modificaciones_DTS{2}
			vl_lineas_Derecha:=Size of array:C274(al_CodigoAnterior_linea)
			vl_largo_Derecha:=Length:C16($t_codigo)
			al_Modificaciones_estilo{2}:=Bold:K14:2
			al_modificaciones_color_texto{2}:=0
			al_modificaciones_color_fondo{2}:=0x00FFEBEB
		End if 
		OBJECT GET BEST SIZE:C717(vt_testigo;$l_ancho;$l_alto)
		LISTBOX SET COLUMN WIDTH:C833(at_CodigoAnterior_Codigo;$l_ancho)
		
		vt_Diferencias:="Aquí podría mostrarse un resumen de las diferencias... :-)"
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 

