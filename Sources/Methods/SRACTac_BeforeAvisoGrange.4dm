//%attributes = {}
  //SRACTac_BeforeAvisoGrange

C_POINTER:C301(Var1;Var2;Var3;Var4;Var5)
C_TEXT:C284(vCursos1;vCursos2;vCursos3;vCursos4;vFamilia1;vFamilia2;vFamilia3;vFamilia4)
C_TEXT:C284(vtACT_Glosa1;vtACT_Glosa2;vtACT_Glosa3;vtACT_Glosa4;vtACT_Glosa5;vtACT_Glosa6;vtACT_Glosa7;vtACT_Glosa8;vtACT_Glosa9;vtACT_Glosa10;vtACT_Glosa11;vtACT_Glosa12;vtACT_Glosa13;vtACT_Glosa14;vtACT_Glosa15;vtACT_Glosa16)
C_REAL:C285(vrACT_Monto1;vrACT_Monto2;vrACT_Monto3;vrACT_Monto4;vrACT_Monto5;vrACT_Monto6;vrACT_Monto7;vrACT_Monto8;vrACT_Monto9;vrACT_Monto10;vrACT_Monto11;vrACT_Monto12;vrACT_Monto13;vrACT_Monto14;vrACT_Monto15;vrACT_Monto16)
C_TEXT:C284(vtACT_Glosa17;vtACT_Glosa18;vtACT_Glosa19;vtACT_Glosa20;vtACT_Glosa21;vtACT_Glosa22;vtACT_Glosa23;vtACT_Glosa24;vtACT_Glosa25;vtACT_Glosa26;vtACT_Glosa27;vtACT_Glosa28;vtACT_Glosa29;vtACT_Glosa30;vtACT_Glosa31;vtACT_Glosa32)
C_REAL:C285(vrACT_Monto17;vrACT_Monto18;vrACT_Monto19;vrACT_Monto20;vrACT_Monto21;vrACT_Monto22;vrACT_Monto23;vrACT_Monto24;vrACT_Monto25;vrACT_Monto26;vrACT_Monto27;vrACT_Monto28;vrACT_Monto29;vrACT_Monto30;vrACT_Monto31;vrACT_Monto32)
C_TEXT:C284(vtACT_Glosa33;vtACT_Glosa34;vtACT_Glosa35;vtACT_Glosa36;vtACT_Glosa37;vtACT_Glosa38;vtACT_Glosa39;vtACT_Glosa40;vtACT_Glosa41;vtACT_Glosa42;vtACT_Glosa43;vtACT_Glosa44;vtACT_Glosa45;vtACT_Glosa46;vtACT_Glosa47;vtACT_Glosa48)
C_REAL:C285(vrACT_Monto33;vrACT_Monto34;vrACT_Monto35;vrACT_Monto36;vrACT_Monto37;vrACT_Monto38;vrACT_Monto39;vrACT_Monto40;vrACT_Monto41;vrACT_Monto42;vrACT_Monto43;vrACT_Monto44;vrACT_Monto45;vrACT_Monto46;vrACT_Monto47;vrACT_Monto48)
C_TEXT:C284(vtACT_Glosa49;vtACT_Glosa50;vtACT_Glosa51;vtACT_Glosa52;vtACT_Glosa53;vtACT_Glosa54;vtACT_Glosa55;vtACT_Glosa56;vtACT_Glosa57;vtACT_Glosa58;vtACT_Glosa59;vtACT_Glosa60;vtACT_Glosa61;vtACT_Glosa62;vtACT_Glosa63;vtACT_Glosa64)
C_REAL:C285(vrACT_Monto49;vrACT_Monto50;vrACT_Monto51;vrACT_Monto52;vrACT_Monto53;vrACT_Monto54;vrACT_Monto55;vrACT_Monto56;vrACT_Monto57;vrACT_Monto58;vrACT_Monto59;vrACT_Monto60;vrACT_Monto61;vrACT_Monto62;vrACT_Monto63;vrACT_Monto64)
C_REAL:C285(vTotal1;vTotal2;vTotal3;vTotal4)
ARRAY TEXT:C222(atACT_Cursos;0)
ARRAY TEXT:C222(atACT_Familia;0)
READ ONLY:C145([Personas:7])
READ ONLY:C145([ACT_CuentasCorrientes:175])
READ ONLY:C145([Familia:78])
READ ONLY:C145([Familia_RelacionesFamiliares:77])
READ ONLY:C145([Alumnos:2])
QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Apoderado:9=[Personas:7]No:1)
KRL_RelateSelection (->[Familia:78]Numero:1;->[ACT_CuentasCorrientes:175]ID_Familia:2;"")
SELECTION TO ARRAY:C260([Familia:78]Codigo_interno:14;atACT_CodigoFamilia;[Familia:78]Nombre_de_la_familia:3;atACT_Familia)
vCodigoFamilia:=AT_array2text (->atACT_CodigoFamilia;" - ")
vFamilias:=AT_array2text (->atACT_Familia;" - ")
ARRAY TEXT:C222(aMeses;0)
COPY ARRAY:C226(<>atXS_MonthNames;aMeses)
vt_MesAviso:=aMeses{[ACT_Avisos_de_Cobranza:124]Mes:6}
If ([Personas:7]ACT_CodPostalEC:70#"")
	vDirPostalFlia:=[Personas:7]ACT_DireccionEC:67+"\r"+[Personas:7]ACT_CodPostalEC:70+" "+[Personas:7]ACT_ComunaEC:68
Else 
	vDirPostalFlia:=[Personas:7]ACT_DireccionEC:67+"\r"+[Personas:7]ACT_ComunaEC:68
End if 
If ([ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2#0)
	QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2)
	QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
	vAlumno:=[Alumnos:2]apellidos_y_nombres:40
	vCurso:=[Alumnos:2]curso:20
End if 