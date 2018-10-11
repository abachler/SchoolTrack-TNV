Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		ARRAY LONGINT:C221(alACT_WDTRecNums;0)
		ARRAY LONGINT:C221(alACT_WDTNumero;0)
		ARRAY TEXT:C222(atACT_WDTApdo;0)
		ARRAY TEXT:C222(atACT_WDTEstado;0)
		ARRAY DATE:C224(adACT_WDTFecha;0)
		ARRAY REAL:C219(arACT_WDTAfecto;0)
		ARRAY REAL:C219(arACT_WDTIVA;0)
		ARRAY REAL:C219(arACT_WDTTotal;0)
		ARRAY BOOLEAN:C223(abACT_WDTNulas;0)
		_O_ARRAY STRING:C218(2;asACT_WDT_Duplis;0)
		_O_ARRAY STRING:C218(2;asACT_WDT_Dates;0)
		_O_ARRAY STRING:C218(2;asACT_WDT_Sincro;0)
		ARRAY LONGINT:C221(alACT_WDTAnular;0)
		ARRAY BOOLEAN:C223(abACT_WDTModificada;0)
		ARRAY LONGINT:C221(alACT_WDTEliminar;0)
		xALP_Set_ACT_ModDocTrib 
		ACTcfg_LoadConfigData (8)
		
		ARRAY TEXT:C222($atACT_Unico;0)
		ARRAY TEXT:C222($at_idsDT;0)
		For ($i;1;Size of array:C274(aiACT_Tipo))
			  //1 id categoria (boleta, factura); 
			  //2 tipo documento (impreso, digital); 
			  //3 Afecto a IVA (1=Afecto, 0 = Exento); 
			  //4 nombre categoria (boleta, factura, etc); 
			  //5 razon social nombre
			$vt_valor:=String:C10(alACT_IDCat{$i})+";"+String:C10(aiACT_Tipo{$i})+";"+String:C10(Num:C11(abACT_Afecta{$i}))+";"+atACT_Cats{$i}+";"+atACT_RazonSocial{$i}
			$pos:=Find in array:C230($atACT_Unico;$vt_valor)
			If ($pos=-1)
				APPEND TO ARRAY:C911($atACT_Unico;$vt_valor)
				APPEND TO ARRAY:C911($at_idsDT;String:C10(alACT_IDDT{$i}))
			Else 
				$at_idsDT{$pos}:=$at_idsDT{$pos}+";"+String:C10(alACT_IDDT{$i})
			End if 
		End for 
		
		ARRAY TEXT:C222(atACT_DocsPopup;0)
		  //ARRAY LONGINT(alACT_DocsIDs;0)
		ARRAY TEXT:C222(atACT_DocsIDs;0)
		ARRAY LONGINT:C221(alACT_DocsCatsIDs;0)
		ARRAY BOOLEAN:C223(abACT_DocsAfectos;0)
		  //For ($i;1;Size of array(aiACT_Tipo))
		  //If (aiACT_Tipo{$i}=1)
		  //AT_Insert (0;1;->atACT_DocsPopup;->alACT_DocsIDs;->alACT_DocsCatsIDs;->abACT_DocsAfectos)
		  //atACT_DocsPopup{Size of array(atACT_DocsPopup)}:=atACT_NombreDoc{$i}
		  //alACT_DocsIDs{Size of array(alACT_DocsIDs)}:=alACT_IDDT{$i}
		  //alACT_DocsCatsIDs{Size of array(alACT_DocsCatsIDs)}:=alACT_IDCat{$i}
		  //abACT_DocsAfectos{Size of array(abACT_DocsAfectos)}:=abACT_Afecta{$i}
		  //End if 
		  //End for 
		
		For ($i;1;Size of array:C274($atACT_Unico))
			$vl_tipo:=Num:C11(ST_GetWord ($atACT_Unico{$i};2;";"))
			$vl_idDT:=$at_idsDT{$i}
			$vl_idCat:=Num:C11(ST_GetWord ($atACT_Unico{$i};1;";"))
			$vb_afecto:=(Num:C11(ST_GetWord ($atACT_Unico{$i};3;";"))=1)
			$vt_razonSocial:=ST_GetWord ($atACT_Unico{$i};5;";")
			$vt_nombre:=ST_GetWord ($atACT_Unico{$i};4;";")+ST_Boolean2Str ($vb_afecto;" Afecta";" Exenta")+ST_Boolean2Str ($vt_razonSocial="";"";" "+$vt_razonSocial)
			If ($vl_tipo=1)
				AT_Insert (0;1;->atACT_DocsPopup;->atACT_DocsIDs;->alACT_DocsCatsIDs;->abACT_DocsAfectos)
				atACT_DocsPopup{Size of array:C274(atACT_DocsPopup)}:=$vt_nombre
				atACT_DocsIDs{Size of array:C274(atACT_DocsIDs)}:=$vl_idDT
				alACT_DocsCatsIDs{Size of array:C274(alACT_DocsCatsIDs)}:=$vl_idCat
				abACT_DocsAfectos{Size of array:C274(abACT_DocsAfectos)}:=$vb_afecto
			End if 
		End for 
		
		vtACT_WDTDesde:="0"
		vdACT_WDDesde:=!00-00-00!
		vtACT_WDTHasta:="0"
		vdACT_WDTHasta:=!00-00-00!
		vtACT_WTipoBusqueda:="Número"
		vlACT_WTipoBusqueda:=1
		If (Size of array:C274(atACT_DocsPopup)>0)
			vtACT_WTipoDoc:=atACT_DocsPopup{1}
			  //vlACT_WTipoDoc:=alACT_DocsIDs{1}
			vtACT_WTipoDocID:=atACT_DocsIDs{1}
			vlACT_WCatDoc:=alACT_DocsCatsIDs{1}
			vbACT_WAfectaDoc:=abACT_DocsAfectos{1}
		Else 
			vtACT_WTipoDoc:=""
			  //vlACT_WTipoDoc:=0
			vtACT_WTipoDocID:=""
			vlACT_WCatDoc:=0
			vbACT_WAfectaDoc:=False:C215
		End if 
		OBJECT SET VISIBLE:C603(*;"fecha@";False:C215)
		IT_SetButtonState (False:C215;->bDelWBol;->bRellenar;->bAnular)
		modbol:=False:C215
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
End case 
