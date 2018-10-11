//%attributes = {}
  //SIGE_Check_Niveles_en_Nivel
C_LONGINT:C283($1;$vl_noNivel)
C_POINTER:C301($2;$vptr_array)
C_TEXT:C284($vt_log_verif_niv;$0)

Case of 
	: (Count parameters:C259=2)
		$vl_noNivel:=$1
		$vptr_array:=$2
	: (Count parameters:C259=1)
		$vl_noNivel:=$1
End case 

C_LONGINT:C283($n;$fia;$vi_mes_ini;$vi_mes_fin)
C_TEXT:C284($vt_log_verif_niv;$vt_log)

$vt_log_verif_niv:=""

ARRAY TEXT:C222($at_key_nivel;0)

ARRAY LONGINT:C221($al_tipo_ens;0)
_O_ARRAY STRING:C218(21;$as_codgrado;0)
_O_ARRAY STRING:C218(21;$as_rolbd;0)
_O_ARRAY STRING:C218(21;$as_curso;0)

READ ONLY:C145([Cursos:3])
QUERY:C277([Cursos:3];[Cursos:3]Nivel_Numero:7=$vl_noNivel)
QUERY SELECTION:C341([Cursos:3];[Cursos:3]Numero_del_curso:6>0)
SELECTION TO ARRAY:C260([Cursos:3]cl_CodigoTipoEnseñanza:21;$al_tipo_ens;[Cursos:3]cl_CodigoNivelEspecial:36;$as_codgrado;[Cursos:3]cl_RolBaseDatos:20;$as_rolbd;[Cursos:3]Curso:1;$as_curso)

  //dentro de un nivel en ST pueden haber varios cursos con distintos Roles, disitnos tipo de enseñanza y a su vez distintos códigos de nivel
  //cada uno de estos va de manera separada al sige

For ($n;1;Size of array:C274($al_tipo_ens))
	
	If ($al_tipo_ens{$n}=0)
		$vt_log_verif_niv:="Sin código de enseñanza."+"\r"
	End if 
	If ($as_codgrado{$n}="")
		$vt_log_verif_niv:=$vt_log_verif_niv+"Sin código de Grado."+"\r"
	End if 
	If ($as_rolbd{$n}="")
		$as_rolbd{$n}:=$vt_log_verif_niv+"Sin Rol."+"\r"
	End if 
	
	If ($vt_log_verif_niv#"")
		$vt_log_verif_niv:=$as_curso{$n}+"\r"+$vt_log_verif_niv
	Else 
		$fia:=Find in array:C230($at_key_nivel;$as_rolbd{$n}+"."+String:C10($al_tipo_ens{$n})+"."+$as_codgrado{$n})
		If ($fia=-1)
			APPEND TO ARRAY:C911($at_key_nivel;$as_rolbd{$n}+"."+String:C10($al_tipo_ens{$n})+"."+$as_codgrado{$n})
		End if 
	End if 
	
End for 

COPY ARRAY:C226($at_key_nivel;$vptr_array->)

$0:=$vt_log_verif_niv