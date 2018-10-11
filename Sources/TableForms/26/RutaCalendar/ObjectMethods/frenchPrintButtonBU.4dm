
vt_PLunes:=vt_Lunes
vt_PMartes:=vt_Martes
vt_PMiercoles:=vt_Miercoles
vt_PJueves:=vt_Jueves
vt_PViernes:=vt_Viernes
vt_PSabado:=vt_Sabado
vt_PDomingo:=vt_Domingo
vt_PNombreRuta:=vt_NombreRuta
vd_FechaPrint:=Current date:C33

FORM SET OUTPUT:C54([BU_Rutas:26];"PrintCalendar")
PRINT SELECTION:C60([BU_Rutas:26])
