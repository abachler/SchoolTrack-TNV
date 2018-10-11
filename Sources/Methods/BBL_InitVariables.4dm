//%attributes = {}
  //BBL_InitVariables

C_LONGINT:C283(<>lPST_ExplorerPcsID;<>BwrPcsID;<>lMNG_ExplorerPcsID;<>lWbS_AdminPcsID;<>lBBL_BrowserPcsID)

C_BOOLEAN:C305(<>ws4D_IsRunnig;<>ws4D_IsFrontMost)
ARRAY LONGINT:C221(<>aWS4D_ITProcessNumbers;4)
ARRAY LONGINT:C221(<>aWS4D_ITProcessVisible;4)
ARRAY LONGINT:C221(<>aLBBL_Records;0)
ARRAY LONGINT:C221(<>aLBBL_Items;0)
ARRAY LONGINT:C221(<>aLBBL_ItemBarCode;0)
ARRAY LONGINT:C221(<>aLBBL_Patrons;0)
ARRAY LONGINT:C221(<>aLBBL_PatronBarCode;0)
ARRAY LONGINT:C221(<>aLBBL_Loans;0)
ARRAY LONGINT:C221(<>aLBBL_OutItemBCode;0)
ARRAY LONGINT:C221(<>aLBBL_PatronBCode;0)
ARRAY LONGINT:C221(<>aLBBL_LoansPatronRec;0)
ARRAY LONGINT:C221(<>aL_BBLReservationRec;0)
ARRAY LONGINT:C221(<>aL_BBLReservationItemID;0)
ARRAY LONGINT:C221(<>aL_BBLReservationUserId;0)

ARRAY TEXT:C222(aSbjctText;0)
<>sy_MediaTrackWebFolder:=True:C214
<>vsXS_CurrentModule:="MediaTrack"

vs_searchedHeader:=""