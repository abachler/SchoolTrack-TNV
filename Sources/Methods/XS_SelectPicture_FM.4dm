//%attributes = {}
  // Método: XS_SelectPicture_FM
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 02/07/10, 16:27:31
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones
C_TEXT:C284($method;$1;$parameters;$3)
C_POINTER:C301($objectPointer;$2;$noTable)
C_LONGINT:C283($tableNum;$fieldNum)
_O_C_STRING:C293(255;$varName)

C_PICTURE:C286($pict;$thumb;vp_Picture)
C_TEXT:C284(vs_Find;vt_PictureDims;vt_PictureName)
C_LONGINT:C283(vl_PictureRef;vl_PictureSize;vl_SelectPictRef)


  // Código principal
Case of 
	: (Count parameters:C259=1)
		$method:=$1
	: (Count parameters:C259=2)
		$method:=$1
		$ObjectPointer:=$2
	: (Count parameters:C259=3)
		$method:=$1
		$ObjectPointer:=$2
		$parameters:=$3
End case 

If (Not:C34(Is nil pointer:C315($objectPointer)))
	RESOLVE POINTER:C394($objectPointer;$varName;$tableNum;$fieldNum)
End if 


Case of 
	: ($method="")
		vl_PictureRef:=0
		If ($parameters#"")
			vl_PictureRef:=Num:C11($parameters)
		End if 
		XS_SelectPicture_FM ("LoadPictLibrary")
		
		
		
		vl_ModoComparacion:=0
		vs_Find:=""
		$wRef:=WDW_OpenFormWindow ($noTable;"SelectPicture";8;8;__ ("Selector de imágenes"))
		DIALOG:C40("SelectPicture")
		CLOSE WINDOW:C154
		
		If ((OK=1) & (vl_PictureRef#0))
			$0:=vl_PictureRef
		Else 
			$0:=0
		End if 
		
	: ($method="FormMethod")
		Case of 
			: (Form event:C388=On Load:K2:1)
				If (vl_PictureRef#0)
					$found:=Find in array:C230(al_PictRefs;vl_PictureRef)
					If ($found>0)
						LISTBOX SELECT ROW:C912(lb_Pictures;$found)
						OBJECT SET SCROLL POSITION:C906(lb_Pictures;$found)
						XS_SelectPicture_FM ("LoadPicture")
					End if 
				End if 
		End case 
		
	: ($method="LoadPictLibrary")
		ARRAY LONGINT:C221(al_PictRefs;0)
		_O_ARRAY STRING:C218(255;at_PictNames;0)
		ARRAY PICTURE:C279(ap_Pictures;0)
		
		PICTURE LIBRARY LIST:C564(al_PictRefs;at_PictNames)
		ARRAY PICTURE:C279(ap_Pictures;Size of array:C274(al_PictRefs))
		For ($i;1;Size of array:C274(al_PictRefs))
			GET PICTURE FROM LIBRARY:C565(al_PictRefs{$i};$pict)
			CREATE THUMBNAIL:C679($pict;$thumb;64;64;Scaled to fit prop centered:K6:6)
			ap_Pictures{$i}:=$thumb
		End for 
		SORT ARRAY:C229(at_PictNames;al_PictRefs;ap_Pictures;>)
		
	: ($method="LoadPicture")
		If (ap_Pictures>0)
			GET PICTURE FROM LIBRARY:C565(al_PictRefs{ap_Pictures};vp_Picture)
			vl_PictureRef:=al_PictRefs{ap_Pictures}
			vt_PictureName:=at_PictNames{ap_Pictures}
			PICTURE PROPERTIES:C457(vp_Picture;$width;$height)
			vt_PictureDims:=String:C10($width;"w# ###")+" x "+String:C10($height;"h# ###")
			vl_PictureSize:=Picture size:C356(vp_Picture)
		Else 
			LISTBOX SELECT ROW:C912(lb_Pictures;0;lk remove from selection:K53:3)
			vp_Picture:=vp_Picture*0
			vl_PictureRef:=0
			vt_PictureDims:=""
			vl_PictureSize:=0
			vt_PictureName:=""
		End if 
		
		
	: ($method="FindPicture")
		C_POINTER:C301($nil)
		IT_Clairvoyance ($objectPointer;->at_PictNames;"";True:C214;$nil;vl_ModoComparacion)
		If (Form event:C388=On Losing Focus:K2:8)
			
			$l_Numero:=ST_String_IsNumber ($objectPointer->)
			If ($l_numero>0)
				$el:=Find in array:C230(al_PictRefs;$l_numero)
			Else 
				$el:=Find in array:C230(at_PictNames;$objectPointer->)
			End if 
			If ($el>0)
				LISTBOX SELECT ROW:C912(lb_Pictures;$el)
				OBJECT SET SCROLL POSITION:C906(lb_Pictures;$el)
				XS_SelectPicture_FM ("LoadPicture")
				  //vs_Find:=""
			Else 
				If (vs_Find#"")
					LISTBOX SELECT ROW:C912(lb_Pictures;0;lk remove from selection:K53:3)
					vp_Picture:=vp_Picture*0
					vl_PictureRef:=0
					vt_PictureDims:=""
					vl_PictureSize:=0
					vt_PictureName:=""
				End if 
			End if 
		End if 
		
		
	: ($method="FindMode")
		Case of 
			: (vl_ModoComparacion=0)
				$result:=Pop up menu:C542("!•<BComienza con la expresión;Contiene la expresión completa;Contiene cualquier palabra;Contiene todas las palabras";0)
			: (vl_ModoComparacion=1)
				$result:=Pop up menu:C542("Comienza con la expresión;!•<BContiene la expresión completa;Contiene cualquier palabra;Contiene todas las palabras";0)
			: (vl_ModoComparacion=2)
				$result:=Pop up menu:C542("Comienza con la expresión;Contiene la expresión completa;!•<BContiene cualquier palabra;Contiene todas las palabras";0)
			: (vl_ModoComparacion=3)
				$result:=Pop up menu:C542("Comienza con la expresión;Contiene la expresión completa;Contiene cualquier palabra;!•<BContiene todas las palabras";0)
		End case 
		If ($result>0)
			vl_ModoComparacion:=$result-1
			If (vs_Find#"")
				C_POINTER:C301($nil)
				$objectPointer:=->vs_Find
				vs_Find:=IT_ShowChoices (->at_PictNames;$objectPointer;"";$nil;$nil;vl_ModoComparacion)
				
				$l_Numero:=ST_String_IsNumber ($objectPointer->)
				If ($l_numero>0)
					$el:=Find in array:C230(al_PictRefs;$l_numero)
				Else 
					$el:=Find in array:C230(at_PictNames;$objectPointer->)
				End if 
				If ($el>0)
					LISTBOX SELECT ROW:C912(lb_Pictures;$el)
					OBJECT SET SCROLL POSITION:C906(lb_Pictures;$el)
					XS_SelectPicture_FM ("LoadPicture")
				End if 
				GOTO OBJECT:C206(vs_Find)
			End if 
		End if 
		
		
		
		
		
	: ($method="DoTask")
		$choice:=Pop up menu:C542("Añadir a libreria desde portapapeles;Añadir a librería desde archivo...;(-;"+("("*Num:C11(ap_Pictures=0))+"Eliminar Imagen...")
		Case of 
			: ($choice=1)
				GET PICTURE FROM PASTEBOARD:C522($pict)
				
			: ($choice=2)
				READ PICTURE FILE:C678("";$pict)
				
		End case 
		
		Case of 
			: ((Picture size:C356($pict)>0) & (($choice=1) | ($choice=2)))
				$pictRef:=1
				Repeat 
					$pictRef:=1+Abs:C99(Random:C100)
				Until (Find in array:C230(al_PictRefs;$pictRef)<0)
				$pictureName:="Picture #"+String:C10($pictRef)
				SET PICTURE TO LIBRARY:C566($pict;$pictRef;$pictureName)
				CREATE THUMBNAIL:C679($pict;$thumb;64;64;Scaled to fit prop centered:K6:6)
				APPEND TO ARRAY:C911(al_PictRefs;$pictRef)
				APPEND TO ARRAY:C911(at_PictNames;$pictureName)
				APPEND TO ARRAY:C911(ap_Pictures;$thumb)
				
				LISTBOX SELECT ROW:C912(lb_Pictures;Size of array:C274(at_PictNames))
				OBJECT SET SCROLL POSITION:C906(lb_Pictures;Size of array:C274(at_PictNames))
				XS_SelectPicture_FM ("LoadPicture")
				
			: ($choice=4)
				$result:=CD_Dlog (0;__ ("Esta imagen podría estar siendo utilizada en algún formulario.\r\r¿Estás seguro de que puede ser eliminada?");__ ("");__ ("No");__ ("Eliminar"))
				If ($result=2)
					$item:=ap_Pictures
					REMOVE PICTURE FROM LIBRARY:C567(al_PictRefs{al_PictRefs})
					DELETE FROM ARRAY:C228(al_PictRefs;ap_Pictures)
					DELETE FROM ARRAY:C228(at_PictNames;ap_Pictures)
					DELETE FROM ARRAY:C228(ap_Pictures;ap_Pictures)
					LISTBOX SELECT ROW:C912(lb_Pictures;0;lk remove from selection:K53:3)
					vp_Picture:=vp_Picture*0
					vl_PictureRef:=0
					vt_PictureDims:=""
					vl_PictureSize:=0
					vt_PictureName:=""
				End if 
				
		End case 
End case 