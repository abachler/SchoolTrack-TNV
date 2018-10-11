  // [xShell_Reports].Repositorio()
  // Por: Alberto Bachler K.: 21-08-14, 00:39:24
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

C_TEXT:C284(vt_URL)

$y_expresion:=OBJECT Get pointer:C1124(Object named:K67:5;"expresionBusqueda")
$y_tipoComparacion:=OBJECT Get pointer:C1124(Object named:K67:5;"tipoComparacion")
$y_palabrasCompletas:=OBJECT Get pointer:C1124(Object named:K67:5;"palabrasCompletas")
$y_pais:=OBJECT Get pointer:C1124(Object named:K67:5;"codigoPais")
$y_Idioma:=OBJECT Get pointer:C1124(Object named:K67:5;"codigoIdioma")

Case of 
	: (Form event:C388=On Load:K2:1)
		vSearch:=""
		$y_tipoComparacion->:=0
		$y_palabrasCompletas->:=1
		
		
		WA SET PREFERENCE:C1041(x4DLiveWindow;WA enable JavaScript:K62:4;True:C214)
		WA SET PREFERENCE:C1041(x4DLiveWindow;WA enable Java applets:K62:3;True:C214)
		WA SET PREFERENCE:C1041(x4DLiveWindow;WA enable plugins:K62:5;True:C214)
		WA SET PREFERENCE:C1041(x4DLiveWindow;WA enable contextual menu:K62:6;True:C214)
		
		INSERT IN LIST:C625(hlRIN_Tipo;1;"Todos";-1)
		hlRIN_Paneles:=New list:C375
		APPEND TO LIST:C376(hlRIN_Paneles;"Todos";-1)
		SELECT LIST ITEMS BY POSITION:C381(hlRIN_Tipo;1)
		SELECT LIST ITEMS BY POSITION:C381(hlRIN_Modulos;1)
		SELECT LIST ITEMS BY REFERENCE:C630(hlRIN_Paneles;-1)
		hlRIN_Informes:=New list:C375
		
		
		$l_indexPais:=Find in array:C230(<>atXS_PaisesCodigos;"All")
		GET PICTURE FROM LIBRARY:C565(<>alXS_PaisesIconos{$l_indexPais};vBanderaPAIS)
		IT_PropiedadesBotonPopup ("pais";<>atXS_PaisesNombres{$l_indexPais};120)
		  //$y_pais->:=<>vtXS_CountryCode
		IT_PropiedadesBotonPopup ("pais";" ";120)
		
		$l_indexIdioma:=Find in array:C230(<>atXS_IdiomasCodigos;<>vtXS_langage)
		GET PICTURE FROM LIBRARY:C565(<>alXS_IdiomasIconos{$l_indexIdioma};vBanderaIdioma)
		IT_PropiedadesBotonPopup ("idioma";<>atXS_IdiomasNombres{$l_indexIdioma};120)
		$y_Idioma->:=<>vtXS_langage
		IT_PropiedadesBotonPopup ("idioma";" ";120)
		
		
		RIN_BuscaInformes ("")
		OBJECT SET VISIBLE:C603(*;"informe_@";False:C215)
		OBJECT SET FONT STYLE:C166(*;"informe_Boton@";0)
		
		
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		GET LIST ITEM:C378(HLRIN_Informes;Selected list items:C379(HLRIN_Informes);$id;$name)
		If ($id=0)
			vt_Description:=""
			vt_Historial:=""
			vt_Text0:=""
			OBJECT SET FONT STYLE:C166(*;"info_@";0)
			OBJECT SET COLOR:C271(vt_Text0;-15)
			OBJECT SET VISIBLE:C603(x4DLiveWindow;False:C215)
			_O_DISABLE BUTTON:C193(bDownload)
		Else 
			_O_ENABLE BUTTON:C192(bDownload)
		End if 
		
	: (Form event:C388=On Menu Selected:K2:14)
		
	: (Form event:C388=On After Keystroke:K2:26)
		If (OBJECT Get name:C1087(Object with focus:K67:3)="SearchText_@")
			Case of 
				: (Length:C16(Get edited text:C655)=0)
					$y_expresion->:=""
					HL_ClearList (hlRIN_Informes)
					
				: (Length:C16(Get edited text:C655)>2)
					$y_expresion->:=Get edited text:C655
					POST KEY:C465(Character code:C91("+");Command key mask:K16:1+Option key mask:K16:7)
			End case 
		End if 
		
		
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event:C388=On Unload:K2:2)
		HL_ClearList (hlRIN_Paneles;hlRIN_Tipo;hlRIN_Modulos;hlRIN_Informes)
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 
