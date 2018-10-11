WDW_OpenFormWindow (->[xxSTR_Constants:1];"ACT_IngresaValor";-1;4;__ ("Ingreso Porcentaje"))
DIALOG:C40([xxSTR_Constants:1];"ACT_IngresaValor")
CLOSE WINDOW:C154

AL_UpdateArrays (xALP_Familia;0)
AL_LoadFamRels 
AL_UpdateArrays (xALP_Familia;-2)
