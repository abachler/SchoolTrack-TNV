//%attributes = {}
  //ACTbol_EMasivaDocTrib2

  //If (Records in set("Selection")>0)
  //START TRANSACTION
  //ACTcfg_LoadConfigData (8)
  //USE SET("Selection")
  //KRL_RelateSelection (->[Personas]No;->[ACT_Avisos_de_Cobranza]ID_Apoderado;"")
  //ARRAY LONGINT($aRecNumApdos;0)
  //LONGINT ARRAY FROM SELECTION([Personas];$aRecNumApdos)
  //SELECTION TO ARRAY([Personas]ACT_DocumentoTributario;$aRealCats)
  //$Pdefecto:=Find in array(abACT_PorDefecto;True)
  //$found:=False
  //CD_THERMOMETRE (1;0;"Comprobando documento tributarios....")
  //For ($p;1;Size of array($aRealCats))
  //If (($aRealCats{$p}=0) | (Find in array(alACT_IDsCats;$aRealCats{$p})=-1))
  //CD_THERMOMETRE (1;$p/Size of array($aRealCats)*100;"Comprobando documento tributarios....")
  //READ WRITE([Personas])
  //GOTO RECORD([Personas];$aRecNumApdos)
  //[Personas]ACT_DocumentoTributario:=alACT_IDsCats{$Pdefecto}
  //SAVE RECORD([Personas])
  //End if 
  //End for 
  //CD_THERMOMETRE (-1)
  //UNLOAD RECORD([Personas])
  //READ ONLY([Personas])
  //
  //ARRAY LONGINT($aCatsDistintas;0)
  //DISTINCT VALUES([Personas]ACT_DocumentoTributario;$aCatsDistintas)
  //ARRAY TEXT($atDocumentos2Print;0)
  //ARRAY TEXT($atCategorias;0)
  //ARRAY LONGINT($alHowMany;0)
  //ARRAY LONGINT($alIDCat;0)
  //ARRAY BOOLEAN($abTaxable;0)
  //ARRAY LONGINT($alProxima;0)
  //ARRAY LONGINT($alIDDT;0)
  //ARRAY LONGINT($aDesdeDT;0)
  //ARRAY LONGINT($aHastaDT;0)
  //ARRAY LONGINT($aCuantas;0)
  //ARRAY TEXT($aSetsDT;0)
  //ARRAY TEXT(atCategorias;0)
  //ARRAY TEXT(atDocumentos2Print;0)
  //ARRAY LONGINT(alHowMany;0)
  //ARRAY LONGINT(aDesdeDT;0)
  //ARRAY LONGINT(aHastaDT;0)
  //ARRAY BOOLEAN(abDoPrint;0)
  //ARRAY PICTURE(apDoPrint;0)
  //ARRAY TEXT(aSetsDT;0)
  //For ($g;1;Size of array($aCatsDistintas))
  //For ($t;1;Size of array(alACT_IDCat))
  //If (alACT_IDCat{$t}=$aCatsDistintas{$g})
  //Insert in Array($atDocumentos2Print;1;1)
  //Insert in Array($alHowMany;1;1)
  //Insert in Array($alIDCat;1;1)
  //Insert in Array($abTaxable;1;1)
  //Insert in Array($alProxima;1;1)
  //Insert in Array($alIDDT;1;1)
  //Insert in Array($aDesdeDT;1;1)
  //Insert in Array($aHastaDT;1;1)
  //Insert in Array($aCuantas;1;1)
  //Insert in Array($atCategorias;1;1)
  //Insert in Array($aSetsDT;1;1)
  //$atCategorias{1}:=atACT_Categorias{Find in array(alACT_IDsCats;$aCatsDistintas{$g})}
  //$atDocumentos2Print{1}:=atACT_NombreDoc{$t}
  //$alHowMany{1}:=0
  //$alIDCat{1}:=$aCatsDistintas{$g}
  //$abTaxable{1}:=abACT_Afecta{$t}
  //$alProxima{1}:=alACT_Proxima{$t}
  //$alIDDT{1}:=alACT_IDDT{$t}
  //$aSetsDT{1}:="Set/"+atACT_NombreDoc{$t}
  //CREATE EMPTY SET([ACT_Boletas];$aSetsDT{1})
  //End if 
  //End for 
  //End for 
  //CD_THERMOMETRE (1;0;"Generado documentos para ")
  //For ($i;1;Size of array($aRecNumApdos))
  //USE SET("Selection")
  //GOTO RECORD([Personas];$aRecNumApdos{$i})
  //CD_THERMOMETRE (0;$i/Size of array($aRecNumApdos)*100;"Generado documentos para "+[Personas]Apellidos_y_nombres)
  //QUERY SELECTION([ACT_Avisos_de_Cobranza];[ACT_Avisos_de_Cobranza]ID_Apoderado=[Personas]No)
  //CREATE SET([ACT_Avisos_de_Cobranza];"AvisosApdo")
  //$whichCat:=Find in array(alACT_IDsCats;[Personas]ACT_DocumentoTributario)
  //$whichDoc:=Find in array(alACT_IDCat;alACT_IDsCats{$whichCat})
  //$afecta:=False
  //$excenta:=False
  //While (($whichDoc#-1) & ((Not($afecta)) | (Not($excenta))))
  //If ((abACT_Afecta{$whichDoc}) & (Not($afecta)))
  //$DocAfecto:=atACT_NombreDoc{$whichDoc}
  //$proximaAfecto:=alACT_Proxima{$whichDoc}
  //$IndexAfecto:=$whichDoc
  //$afecta:=True
  //$setafecto:=$aSetsDT{Find in array($atDocumentos2Print;$DocAfecto)}
  //Else 
  //If ((Not(abACT_Afecta{$whichDoc})) & (Not($excenta)))
  //$DocExcento:=atACT_NombreDoc{$whichDoc}
  //$proximaExcento:=alACT_Proxima{$whichDoc}
  //$IndexExcento:=$whichDoc
  //$excenta:=True
  //$setExcento:=$aSetsDT{Find in array($atDocumentos2Print;$DocExcento)}
  //End if 
  //End if 
  //$whichDoc:=Find in array(alACT_IDCat;alACT_IDsCats{$whichCat};$whichDoc+1)
  //End while 
  //Case of 
  //: (h1=1)
  //Case of 
  //: (s1=1)
  //ARRAY LONGINT($aAñosAvisos;0)
  //DISTINCT VALUES([ACT_Avisos_de_Cobranza]Agno;$aAñosAvisos)
  //For ($r;1;Size of array($aAñosAvisos))
  //USE SET("AvisosApdo")
  //QUERY SELECTION([ACT_Avisos_de_Cobranza];[ACT_Avisos_de_Cobranza]Agno=$aAñosAvisos{$r})
  //CREATE SET([ACT_Avisos_de_Cobranza];"Año")
  //ARRAY INTEGER($aMesesAvisos;0)
  //DISTINCT VALUES([ACT_Avisos_de_Cobranza]Mes;$aMesesAvisos)
  //For ($y;1;Size of array($aMesesAvisos))
  //USE SET("Año")
  //QUERY SELECTION([ACT_Avisos_de_Cobranza];[ACT_Avisos_de_Cobranza]Mes=$aMesesAvisos{$y})
  //CREATE SET([ACT_Avisos_de_Cobranza];"Mes "+String($aMesesAvisos{$r})+" "+String($aAñosAvisos{$r}))
  //$emitidas:=ACTbol_EmitirDocumentos ("Mes "+String($aMesesAvisos{$r})+" "+String($aAñosAvisos{$r});$DocAfecto;$DocExcento;$proximaAfecto;$proximaExcento;$IndexAfecto;$IndexExcento;$setAfecto;$setExcento)
  //Case of 
  //: ($emitidas=1)
  //$WhichDoc2:=Find in array($atDocumentos2Print;$DocAfecto)
  //$alHowMany{$WhichDoc2}:=$alHowMany{$WhichDoc2}+1
  //If ($aDesdeDT{$WhichDoc2}=0)
  //$aDesdeDT{$WhichDoc2}:=$proximaAfecto
  //End if 
  //$proximaAfecto:=alACT_Proxima{$IndexAfecto}
  //$aHastaDT{$WhichDoc2}:=alACT_Proxima{$IndexAfecto}-1
  //$aCuantas{$WhichDoc2}:=$aHastaDT{$WhichDoc2}-$aDesdeDT{$WhichDoc2}+1
  //: ($emitidas=2)
  //$WhichDoc2:=Find in array($atDocumentos2Print;$DocExcento)
  //$alHowMany{$WhichDoc2}:=$alHowMany{$WhichDoc2}+1
  //If ($aDesdeDT{$WhichDoc2}=0)
  //$aDesdeDT{$WhichDoc2}:=$proximaExcento
  //End if 
  //$proximaExcento:=alACT_Proxima{$IndexExcento}
  //$aHastaDT{$WhichDoc2}:=alACT_Proxima{$IndexExcento}-1
  //$aCuantas{$WhichDoc2}:=$aHastaDT{$WhichDoc2}-$aDesdeDT{$WhichDoc2}+1
  //: ($emitidas=3)
  //$WhichDoc2:=Find in array($atDocumentos2Print;$DocAfecto)
  //$alHowMany{$WhichDoc2}:=$alHowMany{$WhichDoc2}+1
  //If ($aDesdeDT{$WhichDoc2}=0)
  //$aDesdeDT{$WhichDoc2}:=$proximaAfecto
  //End if 
  //$proximaAfecto:=alACT_Proxima{$IndexAfecto}
  //$aHastaDT{$WhichDoc2}:=alACT_Proxima{$IndexAfecto}-1
  //$aCuantas{$WhichDoc2}:=$aHastaDT{$WhichDoc2}-$aDesdeDT{$WhichDoc2}+1
  //$WhichDoc2:=Find in array($atDocumentos2Print;$DocExcento)
  //$alHowMany{$WhichDoc2}:=$alHowMany{$WhichDoc2}+1
  //If ($aDesdeDT{$WhichDoc2}=0)
  //$aDesdeDT{$WhichDoc2}:=$proximaExcento
  //End if 
  //$proximaExcento:=alACT_Proxima{$IndexExcento}
  //$aHastaDT{$WhichDoc2}:=alACT_Proxima{$IndexExcento}-1
  //$aCuantas{$WhichDoc2}:=$aHastaDT{$WhichDoc2}-$aDesdeDT{$WhichDoc2}+1
  //End case 
  //CLEAR SET("Mes "+String($aMesesAvisos{$r})+" "+String($aAñosAvisos{$r}))
  //End for 
  //End for 
  //CLEAR SET("Año")
  //: (s2=1)
  //ARRAY LONGINT($aAñosAvisos;0)
  //DISTINCT VALUES([ACT_Avisos_de_Cobranza]Agno;$aAñosAvisos)
  //For ($r;1;Size of array($aAñosAvisos))
  //USE SET("AvisosApdo")
  //QUERY SELECTION([ACT_Avisos_de_Cobranza];[ACT_Avisos_de_Cobranza]Agno=$aAñosAvisos{$r})
  //CREATE SET([ACT_Avisos_de_Cobranza];"Año "+String($aAñosAvisos{$r}))
  //$emitidas:=ACTbol_EmitirDocumentos ("Año "+String($aAñosAvisos{$r});$DocAfecto;$DocExcento;$proximaAfecto;$proximaExcento;$IndexAfecto;$IndexExcento;$setAfecto;$setExcento)
  //Case of 
  //: ($emitidas=1)
  //$WhichDoc2:=Find in array($atDocumentos2Print;$DocAfecto)
  //$alHowMany{$WhichDoc2}:=$alHowMany{$WhichDoc2}+1
  //If ($aDesdeDT{$WhichDoc2}=0)
  //$aDesdeDT{$WhichDoc2}:=$proximaAfecto
  //End if 
  //$proximaAfecto:=alACT_Proxima{$IndexAfecto}
  //$aHastaDT{$WhichDoc2}:=alACT_Proxima{$IndexAfecto}-1
  //$aCuantas{$WhichDoc2}:=$aHastaDT{$WhichDoc2}-$aDesdeDT{$WhichDoc2}+1
  //: ($emitidas=2)
  //$WhichDoc2:=Find in array($atDocumentos2Print;$DocExcento)
  //$alHowMany{$WhichDoc2}:=$alHowMany{$WhichDoc2}+1
  //If ($aDesdeDT{$WhichDoc2}=0)
  //$aDesdeDT{$WhichDoc2}:=$proximaExcento
  //End if 
  //$proximaExcento:=alACT_Proxima{$IndexExcento}
  //$aHastaDT{$WhichDoc2}:=alACT_Proxima{$IndexExcento}-1
  //$aCuantas{$WhichDoc2}:=$aHastaDT{$WhichDoc2}-$aDesdeDT{$WhichDoc2}+1
  //: ($emitidas=3)
  //$WhichDoc2:=Find in array($atDocumentos2Print;$DocAfecto)
  //$alHowMany{$WhichDoc2}:=$alHowMany{$WhichDoc2}+1
  //If ($aDesdeDT{$WhichDoc2}=0)
  //$aDesdeDT{$WhichDoc2}:=$proximaAfecto
  //End if 
  //$proximaAfecto:=alACT_Proxima{$IndexAfecto}
  //$aHastaDT{$WhichDoc2}:=alACT_Proxima{$IndexAfecto}-1
  //$aCuantas{$WhichDoc2}:=$aHastaDT{$WhichDoc2}-$aDesdeDT{$WhichDoc2}+1
  //$WhichDoc2:=Find in array($atDocumentos2Print;$DocExcento)
  //$alHowMany{$WhichDoc2}:=$alHowMany{$WhichDoc2}+1
  //If ($aDesdeDT{$WhichDoc2}=0)
  //$aDesdeDT{$WhichDoc2}:=$proximaExcento
  //End if 
  //$proximaExcento:=alACT_Proxima{$IndexExcento}
  //$aHastaDT{$WhichDoc2}:=alACT_Proxima{$IndexExcento}-1
  //$aCuantas{$WhichDoc2}:=$aHastaDT{$WhichDoc2}-$aDesdeDT{$WhichDoc2}+1
  //End case 
  //CLEAR SET("Año "+String($aAñosAvisos{$r}))
  //End for 
  //End case 
  //: (h2=1)
  //CREATE SET([ACT_Avisos_de_Cobranza];"UnDocumento")
  //$emitidas:=ACTbol_EmitirDocumentos ("UnDocumento";$DocAfecto;$DocExcento;$proximaAfecto;$proximaExcento;$IndexAfecto;$IndexExcento;$setAfecto;$setExcento)
  //Case of 
  //: ($emitidas=1)
  //$WhichDoc2:=Find in array($atDocumentos2Print;$DocAfecto)
  //$alHowMany{$WhichDoc2}:=$alHowMany{$WhichDoc2}+1
  //If ($aDesdeDT{$WhichDoc2}=0)
  //$aDesdeDT{$WhichDoc2}:=$proximaAfecto
  //End if 
  //$proximaAfecto:=alACT_Proxima{$IndexAfecto}
  //$aHastaDT{$WhichDoc2}:=alACT_Proxima{$IndexAfecto}-1
  //$aCuantas{$WhichDoc2}:=$aHastaDT{$WhichDoc2}-$aDesdeDT{$WhichDoc2}+1
  //: ($emitidas=2)
  //$WhichDoc2:=Find in array($atDocumentos2Print;$DocExcento)
  //$alHowMany{$WhichDoc2}:=$alHowMany{$WhichDoc2}+1
  //If ($aDesdeDT{$WhichDoc2}=0)
  //$aDesdeDT{$WhichDoc2}:=$proximaExcento
  //End if 
  //$proximaExcento:=alACT_Proxima{$IndexExcento}
  //$aHastaDT{$WhichDoc2}:=alACT_Proxima{$IndexExcento}-1
  //$aCuantas{$WhichDoc2}:=$aHastaDT{$WhichDoc2}-$aDesdeDT{$WhichDoc2}+1
  //: ($emitidas=3)
  //$WhichDoc2:=Find in array($atDocumentos2Print;$DocAfecto)
  //$alHowMany{$WhichDoc2}:=$alHowMany{$WhichDoc2}+1
  //If ($aDesdeDT{$WhichDoc2}=0)
  //$aDesdeDT{$WhichDoc2}:=$proximaAfecto
  //End if 
  //$proximaAfecto:=alACT_Proxima{$IndexAfecto}
  //$aHastaDT{$WhichDoc2}:=alACT_Proxima{$IndexAfecto}-1
  //$aCuantas{$WhichDoc2}:=$aHastaDT{$WhichDoc2}-$aDesdeDT{$WhichDoc2}+1
  //$WhichDoc2:=Find in array($atDocumentos2Print;$DocExcento)
  //$alHowMany{$WhichDoc2}:=$alHowMany{$WhichDoc2}+1
  //If ($aDesdeDT{$WhichDoc2}=0)
  //$aDesdeDT{$WhichDoc2}:=$proximaExcento
  //End if 
  //$proximaExcento:=alACT_Proxima{$IndexExcento}
  //$aHastaDT{$WhichDoc2}:=alACT_Proxima{$IndexExcento}-1
  //$aCuantas{$WhichDoc2}:=$aHastaDT{$WhichDoc2}-$aDesdeDT{$WhichDoc2}+1
  //End case 
  //CLEAR SET("UnDocumento")
  //: (h3=1)
  //LONGINT ARRAY FROM SELECTION([ACT_Avisos_de_Cobranza];$aRecNums)
  //For ($u;1;Size of array($aRecNums))
  //GOTO RECORD([ACT_Avisos_de_Cobranza];$aRecNums{$u})
  //CREATE SET([ACT_Avisos_de_Cobranza];"Aviso")
  //$emitidas:=ACTbol_EmitirDocumentos ("Aviso";$DocAfecto;$DocExcento;$proximaAfecto;$proximaExcento;$indexAfecto;$IndexExcento;$setAfecto;$setExcento)
  //Case of 
  //: ($emitidas=1)
  //$WhichDoc2:=Find in array($atDocumentos2Print;$DocAfecto)
  //$alHowMany{$WhichDoc2}:=$alHowMany{$WhichDoc2}+1
  //If ($aDesdeDT{$WhichDoc2}=0)
  //$aDesdeDT{$WhichDoc2}:=$proximaAfecto
  //End if 
  //$proximaAfecto:=alACT_Proxima{$IndexAfecto}
  //$aHastaDT{$WhichDoc2}:=alACT_Proxima{$IndexAfecto}-1
  //$aCuantas{$WhichDoc2}:=$aHastaDT{$WhichDoc2}-$aDesdeDT{$WhichDoc2}+1
  //: ($emitidas=2)
  //$WhichDoc2:=Find in array($atDocumentos2Print;$DocExcento)
  //$alHowMany{$WhichDoc2}:=$alHowMany{$WhichDoc2}+1
  //If ($aDesdeDT{$WhichDoc2}=0)
  //$aDesdeDT{$WhichDoc2}:=$proximaExcento
  //End if 
  //$proximaExcento:=alACT_Proxima{$IndexExcento}
  //$aHastaDT{$WhichDoc2}:=alACT_Proxima{$IndexExcento}-1
  //$aCuantas{$WhichDoc2}:=$aHastaDT{$WhichDoc2}-$aDesdeDT{$WhichDoc2}+1
  //: ($emitidas=3)
  //$WhichDoc2:=Find in array($atDocumentos2Print;$DocAfecto)
  //$alHowMany{$WhichDoc2}:=$alHowMany{$WhichDoc2}+1
  //If ($aDesdeDT{$WhichDoc2}=0)
  //$aDesdeDT{$WhichDoc2}:=$proximaAfecto
  //End if 
  //$proximaAfecto:=alACT_Proxima{$IndexAfecto}
  //$aHastaDT{$WhichDoc2}:=alACT_Proxima{$IndexAfecto}-1
  //$aCuantas{$WhichDoc2}:=$aHastaDT{$WhichDoc2}-$aDesdeDT{$WhichDoc2}+1
  //$WhichDoc2:=Find in array($atDocumentos2Print;$DocExcento)
  //$alHowMany{$WhichDoc2}:=$alHowMany{$WhichDoc2}+1
  //If ($aDesdeDT{$WhichDoc2}=0)
  //$aDesdeDT{$WhichDoc2}:=$proximaExcento
  //End if 
  //$proximaExcento:=alACT_Proxima{$IndexExcento}
  //$aHastaDT{$WhichDoc2}:=alACT_Proxima{$IndexExcento}-1
  //$aCuantas{$WhichDoc2}:=$aHastaDT{$WhichDoc2}-$aDesdeDT{$WhichDoc2}+1
  //End case 
  //End for 
  //CLEAR SET("Aviso")
  //End case 
  //End for 
  //CD_THERMOMETRE (-1)
  //COPY ARRAY($atCategorias;atCategorias)
  //COPY ARRAY($atDocumentos2Print;atDocumentos2Print)
  //COPY ARRAY($alHowMany;alHowMany)
  //COPY ARRAY($aDesdeDT;aDesdeDT)
  //COPY ARRAY($aHastaDT;aHastaDT)
  //COPY ARRAY($aSetsDT;aSetsDT)
  //$Zero:=Find in array(alHowMany;0)
  //While ($Zero#-1)
  //CLEAR SET(aSetsDT{$Zero})
  //AT_Delete ($Zero;1;->atCategorias;->atDocumentos2Print;->alHowMany;->aDesdeDT;->aHastaDT;->aSetsDT)
  //$Zero:=Find in array(alHowMany;0)
  //End while 
  //ARRAY BOOLEAN(abDoPrint;Size of array(alHowMany))
  //ARRAY PICTURE(apDoPrint;Size of array(alHowMany))
  //For ($i;1;Size of array(alHowMany))
  //abDoPrint{$i}:=True
  //GET PICTURE FROM LIBRARY("XS_EntryAccept";apDoPrint{$i})
  //End for 
  //xALP_Set_ACT_Docs2Print 
  //CLEAR SET("AvisosApdo")
  //End if 
