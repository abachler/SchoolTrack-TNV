//%attributes = {}
  //AL_OnLoad

C_LONGINT:C283(vlSTR_PaginaFormAlumnos;vl_IdAlumnoSeleccionado)
C_LONGINT:C283($left;$top;$right;$bottom;$bestWidth;$bestHeight)
vlEVS_CurrentEvStyleID:=0
vi_ALevViewMode:=1
vb_ConnectionsModified:=False:C215
vi_SoloPromedioOficial:=0
vi_SoloPromedioInterno:=0
vl_referenciaCiclo:=0
vl_referenciaCicloCompleto:=0
vl_NivelSeleccionado:=0
vl_periodoSeleccionado:=0
vl_IdAlumnoSeleccionado:=0

GET LIST ITEM:C378(hlTab_STR_Alumnos;4;$itenRef;$text)


<>aEvStyleType:=3
AL_initialize 
xAlSet_AL_AreaConexiones 
xALSet_AreasCamposUsuario (xALP_UFields)
xALSet_AreasCamposUsuario (xALP_FamUFields)
xALSet_AL_AreasSalud 
xALSet_AL_AreasOrientación 
xALSet_AL_AreaEventosPostEgreso 
xALSet_Al_AreasObservaciones 
xALSet_AL_AreasFamilia 
xALSet_AL_ActividadesExtra 

ARRAY TEXT:C222(asSTK_DVVacunas;0)
For ($i;1;Size of array:C274(<>atSTK_Vacunas))
	APPEND TO ARRAY:C911(asSTK_DVVacunas;Substring:C12(<>atSTK_Vacunas{$i};1;80))
End for 
AT_DistinctsArrayValues (->asSTK_DVVacunas)



vl_Year:=<>gYear

  // Modificado por: Saul Ponce (29/01/2018) Ticket Nº 198268, para almacenar los cambios en los registros de campos propios
C_BOOLEAN:C305(vb_guardarCambios)