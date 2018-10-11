  //ARRAY TEXT($aText;0)
  //INSERT IN ARRAY($aText;Size of array($aText)+1;10)
  //AT_Inc (0)
  //$aText{AT_Inc }:="ARRAY LONGINT($aFields;0)"
  //$aText{AT_Inc }:="ARRAY LONGINT($aTables;0)"
  //$aText{AT_Inc }:="ARRAY TEXT($aNames;0)"
  //$aText{AT_Inc }:="ARRAY LONGINT($aTypes;0)"
  //$aText{AT_Inc }:="ARRAY LONGINT($aPosition;0)"
  //$aText{AT_Inc }:="ARRAY TEXT($aTags;0)"
  //$aText{AT_Inc }:="AT_RedimArrays ("+String(Size of array(alADT_DefRecNums))+";->$aFields;->$aTables;->$aNames;->$aTypes;->$aPosition;->$aTags)"
  //$aText{AT_Inc }:="READ WRITE([xxADT_MetaDataDefinition])"
  //$aText{AT_Inc }:="QUERY([xxADT_MetaDataDefinition];[xxADT_MetaDataDefinition]ID<0)"
  //$aText{AT_Inc }:="DELETE SELECTION([xxADT_MetaDataDefinition])"
  //For ($i;1;Size of array(alADT_DefRecNums))
  //asADT_DefName{$i}:=Replace string(asADT_DefName{$i};"Postulante";"Candidato")
  //INSERT IN ARRAY($aText;Size of array($aText)+1;6)
  //$aText{AT_Inc }:="$aPosition{"+String($i)+"}:="+String($i)
  //$aText{AT_Inc }:="$aFields{"+String($i)+"}:="+String(alADT_DefFieldNum{$i})
  //$aText{AT_Inc }:="$aTables{"+String($i)+"}:="+String(alADT_DefTableNum{$i})
  //$aText{AT_Inc }:="$aNames{"+String($i)+"}:="+ST_Qte (asADT_DefName{$i})
  //$aText{AT_Inc }:="$aTypes{"+String($i)+"}:="+String(alADT_DefType{$i})
  //$aText{AT_Inc }:="$aTags{"+String($i)+"}:="+ST_Qte (atADT_DefHTMLTags{$i})
  //End for 
  //INSERT IN ARRAY($aText;Size of array($aText)+1;14)
  //$aText{AT_Inc }:="READ ONLY([xxADT_MetaDataDefinition])"
  //$aText{AT_Inc }:="For ($i;1;Size of array($aFields))"
  //$aText{AT_Inc }:="CREATE RECORD([xxADT_MetaDataDefinition])"
  //$aText{AT_Inc }:="[xxADT_MetaDataDefinition]ID:=SQ_SeqNumber (->[xxADT_MetaDataDefinition]ID;True)"
  //$aText{AT_Inc }:="[xxADT_MetaDataDefinition]Category:=1"
  //$aText{AT_Inc }:="[xxADT_MetaDataDefinition]Tipo:=$aTypes{$i}"
  //$aText{AT_Inc }:="[xxADT_MetaDataDefinition]FieldNum:=$aFields{$i}"
  //$aText{AT_Inc }:="[xxADT_MetaDataDefinition]TableNum:=$aTables{$i}"
  //$aText{AT_Inc }:="[xxADT_MetaDataDefinition]Posicion:=$aPosition{$i}"
  //$aText{AT_Inc }:="[xxADT_MetaDataDefinition]Name:=$aNames{$i}"
  //$aText{AT_Inc }:="[xxADT_MetaDataDefinition]Tag:=$aTags{$i}"
  //$aText{AT_Inc }:="SAVE RECORD([xxADT_MetaDataDefinition])"
  //$aText{AT_Inc }:="End for "
  //$aText{AT_Inc }:="KRL_UnloadReadOnly (->[xxADT_MetaDataDefinition])"
  //$text:=AT_array2text (->$aText;"\r")
  //4D_SaveMethodText ("UD_v20070618_ADTMetaData";$text)
ADT_SaveMetadatos 
