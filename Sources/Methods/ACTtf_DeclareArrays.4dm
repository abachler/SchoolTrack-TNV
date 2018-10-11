//%attributes = {}
  //ACTtf_DeclareArrays

ARRAY LONGINT:C221(al_Numero;0)
ARRAY TEXT:C222(at_Descripcion;0)
ARRAY LONGINT:C221(al_PosIni;0)
ARRAY LONGINT:C221(al_Largo;0)
ARRAY LONGINT:C221(al_PosFinal;0)
ARRAY TEXT:C222(at_formato;0)
ARRAY TEXT:C222(at_Alineado;0)
ARRAY TEXT:C222(at_Relleno;0)
ARRAY LONGINT:C221(al_Decimales;0)
ARRAY TEXT:C222(at_TextoFijo;0)


ARRAY TEXT:C222(atACT_FillExp;0)
ARRAY TEXT:C222(atACT_AlinExp;0)
ARRAY TEXT:C222(atACT_FormatExp;0)
  //ARRAY TEXT(at_DescripcionExp;0)

ARRAY TEXT:C222(at_DescripcionExpTemp;0)

ARRAY TEXT:C222(at_DescripcionExp;0)
ARRAY POINTER:C280(aRecordFieldPointersExp;0)

ARRAY INTEGER:C220(aRecordFieldPointersExpTemp;0)
ARRAY INTEGER:C220(aRecordTablePointersExpTemp;0)
ARRAY INTEGER:C220(aRecordFieldPointersExpTempAll;0)
ARRAY INTEGER:C220(aRecordTablePointersExpTempAll;0)

ARRAY POINTER:C280(aRecordPointers;0)  //se utiliza en  master import

ARRAY TEXT:C222(at_FileName;0)  //Leer archivo
ARRAY LONGINT:C221(al_idsBankFiles;0)  //Leer archivo

C_LONGINT:C283(vI_RecordNumber)

ARRAY LONGINT:C221(al_NumeroFo;0)
ARRAY TEXT:C222(at_DescripcionFo;0)
ARRAY LONGINT:C221(al_PosIniFo;0)
ARRAY LONGINT:C221(al_LargoFo;0)
ARRAY LONGINT:C221(al_PosFinalFo;0)
ARRAY TEXT:C222(at_formatoFo;0)
ARRAY TEXT:C222(at_AlineadoFo;0)
ARRAY TEXT:C222(at_RellenoFo;0)
ARRAY TEXT:C222(at_TextoFijoFo;0)

ARRAY LONGINT:C221(al_NumeroHe;0)
ARRAY TEXT:C222(at_DescripcionHe;0)
ARRAY LONGINT:C221(al_PosIniHe;0)
ARRAY LONGINT:C221(al_LargoHe;0)
ARRAY LONGINT:C221(al_PosFinalHe;0)
ARRAY TEXT:C222(at_formatoHe;0)
ARRAY TEXT:C222(at_AlineadoHe;0)
ARRAY TEXT:C222(at_RellenoHe;0)
ARRAY TEXT:C222(at_TextoFijoHe;0)

ARRAY LONGINT:C221(al_recordTablePointersExpTemp;0)
ARRAY LONGINT:C221(al_recordFieldPointersExpTemp;0)

ARRAY TEXT:C222(at_HeaderAC;0)

ARRAY TEXT:C222(at_idsTextos;0)