  //READ ONLY([BBL_Lectores])
  //QUERY([BBL_Lectores];[BBL_Lectores]Regla="SYS";*)
  //QUERY([BBL_Lectores]; | ;[BBL_Lectores]ID<0)
  //
  //ARRAY LONGINT(al_id_usr_sys;0)
  //ARRAY TEXT(at_nom_usr_sys;0)
  //
  //If (Records in selection([BBL_Lectores])=0)
  //BBLsys_LoadSystemUsers 
  //READ ONLY([BBL_Lectores])
  //QUERY([BBL_Lectores];[BBL_Lectores]Regla="SYS";*)
  //QUERY([BBL_Lectores]; | ;[BBL_Lectores]ID<0)
  //End if 
  //SELECTION TO ARRAY([BBL_Lectores]ID;al_id_usr_sys;[BBL_Lectores]NombreCompleto;at_nom_usr_sys)
  //SRtbl_ShowChoiceList (0;"Seleccione el usuario";2;->btn_usr;False;->at_nom_usr_sys)
  //If (choiceidx>0)
  //vt_usr_name:=at_nom_usr_sys{choiceidx}
  //vl_id_usr:=al_id_usr_sys{choiceidx}
  //Else 
  //vt_usr_name:=""
  //vl_id_usr:=0
  //End if 