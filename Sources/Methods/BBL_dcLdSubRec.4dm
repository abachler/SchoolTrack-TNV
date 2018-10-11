//%attributes = {}
  //BBL_dcLdSubRec

QUERY:C277([BBL_RegistrosAnaliticos:74];[BBL_RegistrosAnaliticos:74]ID:1=[BBL_Items:61]Numero:1)
SELECTION TO ARRAY:C260([BBL_RegistrosAnaliticos:74]ID_sub:8;aSubID;[BBL_RegistrosAnaliticos:74]Nivel:2;aSubNiv;[BBL_RegistrosAnaliticos:74]Titulos:3;aSubTitle;[BBL_RegistrosAnaliticos:74]Autores:5;aSubAut)
AL_UpdateArrays (xALP_SubRec;-2)
ALP_SetDefaultAppareance (xALP_SubRec)
ALP_SetAlternateLigneColor (xALP_SubRec;Size of array:C274(aSubID))
AL_SetLine (xALP_SubRec;0)