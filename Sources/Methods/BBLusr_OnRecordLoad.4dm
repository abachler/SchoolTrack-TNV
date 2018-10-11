//%attributes = {}
  // BBLusr_OnRecordLoad()
  // Por: Alberto Bachler: 16/11/13, 17:48:44
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_LONGINT:C283(vlSTR_PaginaFormLectores)
If (vlSTR_PaginaFormLectores=0)
	vlSTR_PaginaFormLectores:=1
End if 


If ([BBL_Lectores:72]ID:1=0)
	vlSTR_PaginaFormLectores:=1
	[BBL_Lectores:72]ID:1:=SQ_SeqNumber (->[BBL_Lectores:72]ID:1)
	[BBL_Lectores:72]ID_GrupoLectores:37:=<>vlBBL_GrupoLectorPorDefecto
	[BBL_Lectores:72]Grupo:2:=<>atBBL_GruposLectores{Find in array:C230(<>alBBL_GruposLectores;[BBL_Lectores:72]ID_GrupoLectores:37)}
	READ ONLY:C145([xxBBL_ReglasParaUsuarios:64])
	QUERY:C277([xxBBL_ReglasParaUsuarios:64];[xxBBL_ReglasParaUsuarios:64]Default:12=True:C214)
	If (Records in selection:C76([xxBBL_ReglasParaUsuarios:64])>0)
		[BBL_Lectores:72]Regla:4:=[xxBBL_ReglasParaUsuarios:64]Codigo_regla:1
	Else 
		[BBL_Lectores:72]Regla:4:="GEN"
	End if 
End if 

PERIODOS_Init 
PERIODOS_LoadData (0;-2)


vbBBL_BarCodeEnterable:=False:C215
READ ONLY:C145([BBL_Prestamos:60])
READ ONLY:C145([BBL_Items:61])
READ ONLY:C145([BBL_Registros:66])
OBJECT SET ENTERABLE:C238([BBL_Lectores:72]Código_de_barra:10;False:C215)
OBJECT SET ENTERABLE:C238([BBL_Lectores:72]Barcode_Protegido:39;False:C215)
viBBL_BarCodeEnterable:=0
OBJECT SET VISIBLE:C603(*;"padlockUnlocked@";False:C215)
OBJECT SET VISIBLE:C603(*;"padlockLocked@";True:C214)

If (<>vtXS_CountryCode="cl")
	OBJECT SET FORMAT:C236([BBL_Lectores:72]RUT:7;"###.###.###-#")
End if 

Case of 
	: ((vlSTR_PaginaFormLectores=1) & (([BBL_Lectores:72]Número_de_alumno:6>0) | ([BBL_Lectores:72]Número_de_Profesor:30>0) | ([BBL_Lectores:72]Número_de_Persona:31>0)))
		FORM GOTO PAGE:C247(1)
	: ((vlSTR_PaginaFormLectores=1) & (([BBL_Lectores:72]Número_de_alumno:6=0) & ([BBL_Lectores:72]Número_de_Profesor:30=0) & ([BBL_Lectores:72]Número_de_Persona:31=0)))
		FORM GOTO PAGE:C247(2)
	: ((vlSTR_PaginaFormLectores=2) & (([BBL_Lectores:72]ID:1<0) | ([BBL_Lectores:72]ID_GrupoLectores:37=-6)))
		BBLusr_PrestamosTransacciones 
		FORM GOTO PAGE:C247(3)
		
	: ((vlSTR_PaginaFormLectores=2) & ([BBL_Lectores:72]ID:1>0))
		BBLusr_PrestamosTransacciones 
		FORM GOTO PAGE:C247(4)
End case 


SELECT LIST ITEMS BY REFERENCE:C630(hlTab_BBL_usersBiblio;vlSTR_PaginaFormLectores)


If (Record number:C243([BBL_Lectores:72])=-3)
	SET WINDOW TITLE:C213(__ ("Nuevo usuario"))
Else 
	SET WINDOW TITLE:C213(__ ("Lector: ")+[BBL_Lectores:72]NombreCompleto:3)
End if 


