//%attributes = {}
  // XSstat_EnviaUsoSchoolTrack()
  // Por: Alberto Bachler: 30/04/13, 12:54:23
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_DATE:C307($1)

C_DATE:C307($d_fecha)


If (False:C215)
	C_DATE:C307(XSstat_EnviaUsoSchoolTrack ;$1)
End if 

$d_fecha:=$1

XSstat_UsuariosDocentes_out (True:C214)
XSstat_Mensuales_out ($d_fecha)
XSstat_Anuales_out ($d_fecha)

