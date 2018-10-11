$vl_NumeroRuta:=[BU_Rutas:26]ID:12
$line:=AL_GetLine (xALP_Inscripciones)
vl_IdRec:=alBU_IdRec{$line}
WDW_OpenFormWindow (->[xxSTR_Constants:1];"BU_SelOpcion";-1;4)
DIALOG:C40([xxSTR_Constants:1];"BU_SelOpcion")
CLOSE WINDOW:C154
QUERY:C277([BU_Rutas:26];[BU_Rutas:26]ID:12;=;$vl_NumeroRuta)
AL_UpdateArrays (xalp_Inscripciones;0)
BU_Refresh_Inscripciones (0)
AL_UpdateArrays (xalp_Inscripciones;-2)