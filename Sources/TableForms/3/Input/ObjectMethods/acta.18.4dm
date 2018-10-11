  // [Cursos].Input.Variable50()
  // Por: Alberto Bachler K.: 28-02-14, 21:01:21
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


C_LONGINT:C283($l_recNum)
  //agrego recnum
  //depseus de cerrar formulario se pierde selección y se genera error en metodo que guarda acta..
  //TICKET 183744
$l_recNum:=Record number:C243([Cursos:3])

ACTAS_LeeConfiguracion ([Cursos:3]Nivel_Numero:7;[Cursos:3]Curso:1)

WDW_OpenFormWindow (->[xxSTR_Niveles:6];"Certificado";-1;8;__ ("Certificado")+[xxSTR_Niveles:6]Nivel:1;"")
QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5=[Cursos:3]Nivel_Numero:7)
DIALOG:C40([xxSTR_Niveles:6];"Certificado")
CLOSE WINDOW:C154

GOTO RECORD:C242([Cursos:3];$l_recNum)
  //ACTAS_GuardaConfiguracion ([Cursos]Nivel_Numero;[Cursos]Curso)//no es necesario ya que la configuracion se guarda cuando se cierra el formulario.

CU_PgActas 
UNLOAD RECORD:C212([xxSTR_Niveles:6])
READ ONLY:C145([xxSTR_Niveles:6])
