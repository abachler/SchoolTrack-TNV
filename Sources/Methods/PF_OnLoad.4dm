//%attributes = {}
  //PF_OnLoad

ARRAY TEXT:C222(aUFItmName;0)
ARRAY TEXT:C222(aUFItmVal;0)
xALSet_AreasCamposUsuario (xALP_pfUF)
Case of 
	: (vsBWR_CurrentModule="SchoolTrack")
		vlSTR_PaginaFormProfesores:=0
		vs_asignatura:=""
	: (vsBWR_CurrentModule="AdmissionTrack")
		ADTivws_OnLoad 
End case 

  // Modificado por: Saul Ponce (29/01/2018) Ticket Nº 198268, para almacenar los cambios en los registros de campos propios
C_BOOLEAN:C305(vb_guardarCambios)