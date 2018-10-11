//%attributes = {}
  //CU_LoadDelegados

READ ONLY:C145([Cursos_Delegados:110])
QUERY:C277([Cursos_Delegados:110];[Cursos_Delegados:110]curso:1=[Cursos:3]Curso:1)
SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
SELECTION TO ARRAY:C260([Cursos_Delegados:110]no_apoderado:2;al_CUIdDelegado;[Personas:7]Apellidos_y_nombres:30;at_CUNameDelegado;[Cursos_Delegados:110]delegacion:3;at_CUDelegaciónDelegado;[Personas:7]Telefono_domicilio:19;at_CUHomePhoneDelegado;[Personas:7]Telefono_profesional:29;at_CUWorkPhoneDelegado;[Personas:7]eMail:34;at_CUeMailDelegado)
SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
vb_modDelegados:=False:C215
