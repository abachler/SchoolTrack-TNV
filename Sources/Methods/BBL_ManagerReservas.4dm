//%attributes = {}
  //BBL_ManagerReservas

SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
READ WRITE:C146([BBL_Reservas:115])
ALL RECORDS:C47([BBL_Reservas:115])
ORDER BY:C49([BBL_Reservas:115];[BBL_Reservas:115]From:5;>)

WDW_OpenFormWindow (->[BBL_Reservas:115];"Manager";-1;8)
DIALOG:C40([BBL_Reservas:115];"Manager")
CLOSE WINDOW:C154

SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)