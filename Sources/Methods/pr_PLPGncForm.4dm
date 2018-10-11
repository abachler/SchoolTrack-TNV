//%attributes = {}
  //pr_PLPGncForm

prtCode:=$1
sTitle:=$2
sSubTitle:=$3
dDate:=Current date:C33
hHeure:=Current time:C178
READ ONLY:C145([xxSTR_Constants:1])
ALL RECORDS:C47([xxSTR_Constants:1])
FIRST RECORD:C50([xxSTR_Constants:1])
FORM SET OUTPUT:C54([xxSTR_Constants:1];"STR_PLPForm")
PRINT RECORD:C71([xxSTR_Constants:1])
FORM SET OUTPUT:C54([xxSTR_Constants:1];"Output")