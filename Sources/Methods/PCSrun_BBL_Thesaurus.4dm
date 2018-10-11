//%attributes = {}
  // PCSrun_BBL_Thesaurus()
  // Por: Alberto Bachler: 05/03/13, 09:59:41
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


DISABLE MENU ITEM:C150(1;5)
DISABLE MENU ITEM:C150(2;0)
DISABLE MENU ITEM:C150(3;0)
DISABLE MENU ITEM:C150(4;0)
ARRAY TEXT:C222(at_CrossRefType;0)
ARRAY TEXT:C222(at_CrossRefWord;0)
ARRAY TEXT:C222(aKw;0)
ARRAY LONGINT:C221(aKwNumber;0)

vsBWR_CurrentModule:="MediaTrack"
GET PICTURE FROM LIBRARY:C565("Module "+vsBWR_CurrentModule;vpXS_IconModule)


BBL_LeeConfiguracion 
WDW_OpenFormWindow (->[BBL_Thesaurus:68];"Asignador";-1;4;__ ("Thesaurus"))
<>flAsigKW:=False:C215
vs_SearchedHeader:=""
DIALOG:C40([BBL_Thesaurus:68];"Asignador")
CLOSE WINDOW:C154
ARRAY TEXT:C222(at_CrossRefType;0)
ARRAY TEXT:C222(at_CrossRefWord;0)
ARRAY TEXT:C222(aKw;0)
ARRAY LONGINT:C221(aKwNumber;0)
REDUCE SELECTION:C351([BBL_Thesaurus:68];0)
SET_ClearSets ("InList")
