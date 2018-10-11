//%attributes = {}
  //ACTbol_validaInfo

  //20080509 RCH Ejecuta  opciones repetitivas en emisi—n de documentos

C_TEXT:C284($vt_accion;$vt_defecto)
C_LONGINT:C283($Pdefecto;$p;$g;$t;$id_catDocTrib;$identificador;$emitidas;$id_RazonSocial)
C_POINTER:C301($ptr1;$ptr2;$ptr3)
$vt_accion:=$1
Case of 
	: (Count parameters:C259=2)
		$ptr1:=$2
	: (Count parameters:C259=3)
		$ptr1:=$2
		$ptr2:=$3
	: (Count parameters:C259=4)
		$ptr1:=$2
		$ptr2:=$3
		$ptr3:=$4
End case 

READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
READ ONLY:C145([Personas:7])

Case of 
	: ($vt_accion="IdCatEnPersonasDesde@")
		ACTcfg_LoadConfigData (8)
		Case of 
			: ($vt_accion="IdCatEnPersonasDesdeAvisos")
				ACTbol_validaInfo ("buscaPersonasDesdeAvisos";$ptr1)
			: ($vt_accion="IdCatEnPersonasDesdePagos")
				ACTbol_validaInfo ("buscaPersonasDesdePagos";$ptr1)
		End case 
		ARRAY LONGINT:C221($aRecNumApdos;0)
		ARRAY LONGINT:C221($aRealCats;0)
		SELECTION TO ARRAY:C260([Personas:7];$aRecNumApdos;[Personas:7]ACT_DocumentoTributario:45;$aRealCats)
		ACTbol_validaInfo ("verificaIdCatEnPersonas";->$aRealCats;->$aRecNumApdos)
		CREATE SELECTION FROM ARRAY:C640([Personas:7];$aRecNumApdos;"")
		
	: ($vt_accion="buscaPersonasDesdeAvisos")
		CREATE SELECTION FROM ARRAY:C640([ACT_Avisos_de_Cobranza:124];$ptr1->)
		KRL_RelateSelection (->[Personas:7]No:1;->[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;"")
		ACTbol_validaInfo ("ACTbolOrdenaRegistros")
		
	: ($vt_accion="verificaIdCatEnPersonas")
		$Pdefecto:=Num:C11(ACTbol_validaInfo ("buscaCatPorDefecto"))
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Verificando documentos tributarios...."))
		For ($p;1;Size of array:C274($ptr1->))
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$p/Size of array:C274($ptr1->);__ ("Verificando documentos tributarios...."))
			  //If (($ptr1->{$p}=0) | (Find in array(alACT_IDsCats;$ptr1->{$p})=-1))
			If ($ptr1->{$p}=0) | (Find in array:C230(alACT_IDsCats;$ptr1->{$p})=-1) | ($ptr1->{$p}=-2) | ($ptr1->{$p}=-4)  //20140528 ASM ticket 130561
				KRL_GotoRecord (->[Personas:7];$ptr2->{$p};True:C214)
				[Personas:7]ACT_DocumentoTributario:45:=alACT_IDsCats{$Pdefecto}
				SAVE RECORD:C53([Personas:7])
			End if 
		End for 
		KRL_UnloadReadOnly (->[Personas:7])
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		
	: ($vt_accion="verificaIdCatEnTerceros")
		$Pdefecto:=Num:C11(ACTbol_validaInfo ("buscaCatPorDefecto"))
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Verificando documentos tributarios...."))
		For ($p;1;Size of array:C274($ptr1->))
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$p/Size of array:C274($ptr1->);__ ("Verificando documentos tributarios...."))
			  //If (($ptr1->{$p}=0) | (Find in array(alACT_IDsCats;$ptr1->{$p})=-1))
			If ($ptr1->{$p}=0) | (Find in array:C230(alACT_IDsCats;$ptr1->{$p})=-1) | ($ptr1->{$p}=-2) | ($ptr1->{$p}=-4)  //20140528 ASM ticket 130561
				KRL_GotoRecord (->[ACT_Terceros:138];$ptr2->{$p};True:C214)
				[ACT_Terceros:138]id_CatDocTrib:55:=alACT_IDsCats{$Pdefecto}
				SAVE RECORD:C53([ACT_Terceros:138])
			End if 
		End for 
		KRL_UnloadReadOnly (->[ACT_Terceros:138])
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		
	: ($vt_accion="buscaCatPorDefecto")
		$vt_defecto:=String:C10(Find in array:C230(abACT_PorDefecto;True:C214))
		$0:=$vt_defecto
		
	: ($vt_accion="buscaPersonasDesdePagos")
		CREATE SELECTION FROM ARRAY:C640([ACT_Pagos:172];$ptr1->)
		KRL_RelateSelection (->[Personas:7]No:1;->[ACT_Pagos:172]ID_Apoderado:3;"")
		ACTbol_validaInfo ("ACTbolOrdenaRegistros")
		
	: ($vt_accion="ACTbolOrdenaRegistros")
		If (cbOrdenaRegXFam=0)
			ORDER BY:C49([Personas:7];[Personas:7]Apellidos_y_nombres:30;>)
		Else 
			  //en las pruebas no funcion— el set automatics relations...
			ARRAY LONGINT:C221($al_recNumPersona;0)
			ARRAY LONGINT:C221($al_idsPersonas;0)
			ARRAY LONGINT:C221($al_idsPersonas2;0)
			ARRAY LONGINT:C221($al_idsFamiliaRelF;0)
			ARRAY LONGINT:C221($al_recNumsFamiliaRelF;0)
			ARRAY LONGINT:C221($al_idsFamilia;0)
			SELECTION TO ARRAY:C260([Personas:7]No:1;$al_idsPersonas;[Personas:7];$al_recNumPersona)
			KRL_RelateSelection (->[Familia_RelacionesFamiliares:77]ID_Persona:3;->[Personas:7]No:1;"")
			SELECTION TO ARRAY:C260([Familia_RelacionesFamiliares:77]ID_Familia:2;$al_idsFamiliaRelF;[Familia_RelacionesFamiliares:77];$al_recNumsFamiliaRelF)
			KRL_RelateSelection (->[Familia:78]Numero:1;->[Familia_RelacionesFamiliares:77]ID_Familia:2;"")
			ORDER BY:C49([Familia:78];[Familia:78]Nombre_de_la_familia:3;>)
			SELECTION TO ARRAY:C260([Familia:78]Numero:1;$al_idsFamilia)
			AT_OrderArraysByArray (MAXLONG:K35:2;->$al_idsFamilia;->$al_idsFamiliaRelF;->$al_recNumsFamiliaRelF)
			CREATE SELECTION FROM ARRAY:C640([Familia_RelacionesFamiliares:77];$al_recNumsFamiliaRelF;"")
			SELECTION TO ARRAY:C260([Familia_RelacionesFamiliares:77]ID_Persona:3;$al_idsPersonas2)
			AT_OrderArraysByArray (MAXLONG:K35:2;->$al_idsPersonas2;->$al_idsPersonas;->$al_recNumPersona)
			CREATE SELECTION FROM ARRAY:C640([Personas:7];$al_recNumPersona;"")
		End if 
		
	: ($vt_accion="ACTbolLlenaArreglos")
		ACTbol_validaInfo ("ACTbolDeclaraArreglosMetodo")
		ACTbol_validaInfo ("ACTbolDeclaraArreglosForm")
		  //CREATE SELECTION FROM ARRAY($ptr2->;$ptr1->;"")`daba error en compilado
		If (Table:C252($ptr2)=Table:C252(->[Personas:7]))
			CREATE SELECTION FROM ARRAY:C640([Personas:7];$ptr1->;"")
		Else 
			CREATE SELECTION FROM ARRAY:C640([ACT_Terceros:138];$ptr1->;"")
		End if 
		DISTINCT VALUES:C339($ptr3->;al_CatsDistintas)
		For ($g;1;Size of array:C274(al_CatsDistintas))
			For ($t;1;Size of array:C274(alACT_IDCat))
				If (alACT_IDCat{$t}=al_CatsDistintas{$g})
					INSERT IN ARRAY:C227(at_Documentos2Print;1;1)
					INSERT IN ARRAY:C227(al_HowMany;1;1)
					INSERT IN ARRAY:C227(al_IDDT;1;1)
					INSERT IN ARRAY:C227(al_DesdeDT;1;1)
					INSERT IN ARRAY:C227(al_HastaDT;1;1)
					INSERT IN ARRAY:C227(al_Cuantas;1;1)
					INSERT IN ARRAY:C227(at_Categorias;1;1)
					INSERT IN ARRAY:C227(at_SetsDT;1;1)
					at_Categorias{1}:=atACT_Categorias{Find in array:C230(alACT_IDsCats;al_CatsDistintas{$g})}
					If ((cb_UtilizaMultiNum=1) | (cs_MultiRazones=1))
						at_Documentos2Print{1}:=atACT_NombreDoc{$t}+" - "+atACT_idNumeracion{$t}
						at_SetsDT{1}:="Set/"+atACT_NombreDoc{$t}+" - "+atACT_idNumeracion{$t}
					Else 
						at_Documentos2Print{1}:=atACT_NombreDoc{$t}
						at_SetsDT{1}:="Set/"+atACT_NombreDoc{$t}
					End if 
					al_HowMany{1}:=0
					al_IDDT{1}:=alACT_IDDT{$t}
					CREATE EMPTY SET:C140([ACT_Boletas:181];at_SetsDT{1})
				End if 
			End for 
		End for 
		
	: ($vt_accion="ACTbolDeclaraArreglosMetodo")
		ARRAY LONGINT:C221(al_CatsDistintas;0)
		ARRAY TEXT:C222(at_Documentos2Print;0)
		ARRAY TEXT:C222(at_Categorias;0)
		ARRAY LONGINT:C221(al_HowMany;0)
		ARRAY LONGINT:C221(al_IDDT;0)
		ARRAY LONGINT:C221(al_DesdeDT;0)
		ARRAY LONGINT:C221(al_HastaDT;0)
		ARRAY LONGINT:C221(al_Cuantas;0)
		ARRAY TEXT:C222(at_SetsDT;0)
		
	: ($vt_accion="ACTbolDeclaraArreglosForm")
		ARRAY TEXT:C222(atCategorias;0)
		ARRAY TEXT:C222(atDocumentos2Print;0)
		ARRAY LONGINT:C221(alHowMany;0)
		ARRAY LONGINT:C221(aDesdeDT;0)
		ARRAY LONGINT:C221(aHastaDT;0)
		ARRAY BOOLEAN:C223(abDoPrint;0)
		ARRAY PICTURE:C279(apDoPrint;0)
		ARRAY TEXT:C222(aSetsDT;0)
		ARRAY LONGINT:C221(alIDDT;0)
		
	: ($vt_accion="ACTbolDeclaraVariables@")
		C_LONGINT:C283(vl_IndexAfecto;vl_IndexExento;vl_proximaAfecto;vl_proximaExento;vl_IDCat)
		C_TEXT:C284(vt_DocAfecto;vt_DocExento;vt_setafecto;vt_setExento)
		If ($vt_accion="ACTbolDeclaraVariablesInic")
			vl_IndexAfecto:=0
			vl_IndexExento:=0
			vl_proximaAfecto:=0
			vl_proximaExento:=0
			vl_IDCat:=0
			vt_DocAfecto:=""
			vt_DocExento:=""
			vt_setafecto:=""
			vt_setExento:=""
		End if 
		
	: ($vt_accion="ACTbolLlenaVariables")
		ACTbol_validaInfo ("ACTbolDeclaraVariablesInic")
		$id_catDocTrib:=$ptr1->
		$identificador:=$ptr2->
		$id_RazonSocial:=$ptr3->
		If ((($identificador>0) & (cb_UtilizaMultiNum=1)) | (cs_MultiRazones=1))
			ACTcfg_SearchCatDocsByIndex ($id_catDocTrib;$identificador;$id_RazonSocial)
			vl_IndexAfecto:=vlACT_IndexAfecta1
			vl_IndexExento:=vlACT_IndexExenta1
			vt_DocAfecto:=atACT_NombreDoc{vl_IndexAfecto}+" - "+atACT_idNumeracion{vl_IndexAfecto}
			vt_DocExento:=atACT_NombreDoc{vl_IndexExento}+" - "+atACT_idNumeracion{vl_IndexExento}
			vl_proximaAfecto:=alACT_Proxima{vl_IndexAfecto}
			vl_proximaExento:=alACT_Proxima{vl_IndexExento}
			  //vt_setafecto:=at_SetsDT{Find in array(at_Documentos2Print;vt_DocAfecto)}
			  //vt_setExento:=at_SetsDT{Find in array(at_Documentos2Print;vt_DocExento)}
			  //ASM 20140903 Ticket 136027
			If (<>vtXS_CountryCode="mx")
				If (Find in array:C230(at_Documentos2Print;vt_DocAfecto)#-1)
					vt_setafecto:=at_SetsDT{Find in array:C230(at_Documentos2Print;vt_DocAfecto)}
				End if 
				If (Find in array:C230(at_Documentos2Print;vt_DocExento)#-1)
					vt_setExento:=at_SetsDT{Find in array:C230(at_Documentos2Print;vt_DocExento)}
				End if 
			Else 
				  // Modificado por: Saúl Ponce (16-05-2017) Ticket 178308, añadí los if para evitar error de verificación en el rango array cuando la definición del tipo de documento está incompleta.
				If (Find in array:C230(at_Documentos2Print;vt_DocAfecto)#-1)
					vt_setafecto:=at_SetsDT{Find in array:C230(at_Documentos2Print;vt_DocAfecto)}
				End if 
				  // Modificado por: Saúl Ponce (16-05-2017) Ticket 178308
				If (Find in array:C230(at_Documentos2Print;vt_DocExento)#-1)
					vt_setExento:=at_SetsDT{Find in array:C230(at_Documentos2Print;vt_DocExento)}
				End if 
			End if 
		Else 
			ACTcfg_SearchCatDocs ($id_catDocTrib)
			
			  //20120420 RCH Se obtiene indice impreso o electronico
			ACTcfg_AsignaCatElect ($id_RazonSocial)
			
			vl_IndexAfecto:=vlACT_IndexAfecta1
			vl_IndexExento:=vlACT_IndexExenta1
			
			  // 20170807 ASM Ticket 185941 
			If ((cb_UtilizaMultiNum=1) | (cs_MultiRazones=1))
				vt_DocAfecto:=atACT_NombreDoc{vl_IndexAfecto}+" - "+atACT_idNumeracion{vl_IndexAfecto}
				vt_DocExento:=atACT_NombreDoc{vl_IndexExento}+" - "+atACT_idNumeracion{vl_IndexExento}
				vt_DocAfecto:=atACT_NombreDoc{vl_IndexAfecto}+" - "+atACT_idNumeracion{vl_IndexAfecto}
				vt_DocExento:=atACT_NombreDoc{vl_IndexExento}+" - "+atACT_idNumeracion{vl_IndexExento}
			Else 
				vt_DocAfecto:=atACT_NombreDoc{vl_IndexAfecto}
				vt_DocExento:=atACT_NombreDoc{vl_IndexExento}
				vt_DocAfecto:=atACT_NombreDoc{vl_IndexAfecto}
				vt_DocExento:=atACT_NombreDoc{vl_IndexExento}
			End if 
			
			  //vt_setafecto:=at_SetsDT{Find in array(at_Documentos2Print;vt_DocAfecto)}
			  //vt_setExento:=at_SetsDT{Find in array(at_Documentos2Print;vt_DocExento)}
			vl_proximaAfecto:=alACT_Proxima{vl_IndexAfecto}
			vl_proximaExento:=alACT_Proxima{vl_IndexExento}
			  //ASM 20140903 Ticket 136027
			If (<>vtXS_CountryCode="mx")
				If (Find in array:C230(at_Documentos2Print;vt_DocAfecto)#-1)
					vt_setafecto:=at_SetsDT{Find in array:C230(at_Documentos2Print;vt_DocAfecto)}
				End if 
				If (Find in array:C230(at_Documentos2Print;vt_DocExento)#-1)
					vt_setExento:=at_SetsDT{Find in array:C230(at_Documentos2Print;vt_DocExento)}
				End if 
			Else 
				  // Modificado por: Saúl Ponce (16-05-2017) Ticket 178308, añadí los if para evitar error de verificación en el rango array cuando la definición del tipo de documento está incompleta.
				If (Find in array:C230(at_Documentos2Print;vt_DocAfecto)#-1)
					vt_setafecto:=at_SetsDT{Find in array:C230(at_Documentos2Print;vt_DocAfecto)}
				End if 
				  // Modificado por: Saúl Ponce (16-05-2017) Ticket 178308
				If (Find in array:C230(at_Documentos2Print;vt_DocExento)#-1)
					vt_setExento:=at_SetsDT{Find in array:C230(at_Documentos2Print;vt_DocExento)}
				End if 
				
			End if 
			
		End if 
		vl_IDCat:=$id_catDocTrib
		
	: ($vt_accion="ACTbolLlenaArreglosForm")
		  //$emitidas:=$ptr1->
		
		C_OBJECT:C1216($ob_final)
		C_LONGINT:C283($i;$j)
		ARRAY LONGINT:C221($al_idsBoletasAfectasF;0)
		ARRAY LONGINT:C221($al_idsBoletasExentasF;0)
		For ($i;1;Size of array:C274($ptr1->))
			ARRAY LONGINT:C221($al_idsBoletasAfectas;0)
			ARRAY LONGINT:C221($al_idsBoletasExentas;0)
			OB GET ARRAY:C1229($ptr1->{$i};"ids_boletas_emitidas_afectas";$al_idsBoletasAfectas)
			OB GET ARRAY:C1229($ptr1->{$i};"ids_boletas_emitidas_exentas";$al_idsBoletasExentas)
			For ($j;1;Size of array:C274($al_idsBoletasAfectas))
				APPEND TO ARRAY:C911($al_idsBoletasAfectasF;$al_idsBoletasAfectas{$j})
			End for 
			For ($j;1;Size of array:C274($al_idsBoletasExentas))
				APPEND TO ARRAY:C911($al_idsBoletasExentasF;$al_idsBoletasExentas{$j})
			End for 
		End for 
		
		  //20171002 RCH. Cuando se emitían 2 tipos, no se llenaban ambos arreglos
		  //If ((Size of array($al_idsBoletasAfectasF)>0) | (Size of array($al_idsBoletasExentasF)>0))
		  //READ ONLY([ACT_Boletas])
		  //If (Size of array($al_idsBoletasAfectasF)>0)
		  //$WhichDoc2:=Find in array(at_Documentos2Print;vt_DocAfecto)
		  //al_HowMany{$WhichDoc2}:=Size of array($al_idsBoletasAfectasF)
		  //QUERY WITH ARRAY([ACT_Boletas]ID;$al_idsBoletasAfectasF)
		  //End if 
		
		  //If (Size of array($al_idsBoletasExentasF)>0)
		  //$WhichDoc2:=Find in array(at_Documentos2Print;vt_DocExento)
		  //al_HowMany{$WhichDoc2}:=Size of array($al_idsBoletasExentasF)
		  //QUERY WITH ARRAY([ACT_Boletas]ID;$al_idsBoletasExentasF)
		  //End if 
		  //ORDER BY([ACT_Boletas];[ACT_Boletas]Numero;>)
		  //al_DesdeDT{$WhichDoc2}:=[ACT_Boletas]Numero
		  //ORDER BY([ACT_Boletas];[ACT_Boletas]Numero;<)
		  //al_HastaDT{$WhichDoc2}:=[ACT_Boletas]Numero
		  //al_Cuantas{$WhichDoc2}:=Records in selection([ACT_Boletas])
		  //End if 
		READ ONLY:C145([ACT_Boletas:181])
		If (Size of array:C274($al_idsBoletasAfectasF)>0)
			$WhichDoc2:=Find in array:C230(at_Documentos2Print;vt_DocAfecto)
			al_HowMany{$WhichDoc2}:=Size of array:C274($al_idsBoletasAfectasF)
			QUERY WITH ARRAY:C644([ACT_Boletas:181]ID:1;$al_idsBoletasAfectasF)
			
			ORDER BY:C49([ACT_Boletas:181];[ACT_Boletas:181]Numero:11;>)
			al_DesdeDT{$WhichDoc2}:=[ACT_Boletas:181]Numero:11
			ORDER BY:C49([ACT_Boletas:181];[ACT_Boletas:181]Numero:11;<)
			al_HastaDT{$WhichDoc2}:=[ACT_Boletas:181]Numero:11
			al_Cuantas{$WhichDoc2}:=Records in selection:C76([ACT_Boletas:181])
		End if 
		
		If (Size of array:C274($al_idsBoletasExentasF)>0)
			$WhichDoc2:=Find in array:C230(at_Documentos2Print;vt_DocExento)
			al_HowMany{$WhichDoc2}:=Size of array:C274($al_idsBoletasExentasF)
			QUERY WITH ARRAY:C644([ACT_Boletas:181]ID:1;$al_idsBoletasExentasF)
			
			ORDER BY:C49([ACT_Boletas:181];[ACT_Boletas:181]Numero:11;>)
			al_DesdeDT{$WhichDoc2}:=[ACT_Boletas:181]Numero:11
			ORDER BY:C49([ACT_Boletas:181];[ACT_Boletas:181]Numero:11;<)
			al_HastaDT{$WhichDoc2}:=[ACT_Boletas:181]Numero:11
			al_Cuantas{$WhichDoc2}:=Records in selection:C76([ACT_Boletas:181])
		End if 
		
End case 