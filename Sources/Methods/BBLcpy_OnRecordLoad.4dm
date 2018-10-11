//%attributes = {}
  // BBLcpy_OnRecordLoad()
  // Por: Alberto Bachler: 17/09/13, 13:16:36
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_POINTER:C301($y_campoFuenteBarCode)


If (Is new record:C668([BBL_Registros:66]))
	[BBL_Registros:66]Número_de_item:1:=[BBL_Items:61]Numero:1
	[BBL_Registros:66]ID:3:=SQ_SeqNumber (->[BBL_Registros:66]ID:3)
	
	  //20170923 ASM Ticket 183183 verifico si el no de registro no existe
	$l_NoRegistro:=SQ_SeqNumber (->[BBL_Registros:66]No_Registro:25)
	$l_recNum:=Find in field:C653([BBL_Registros:66]No_Registro:25;$l_NoRegistro)
	
	If ($l_recNum#-1)
		While ($l_recNum#-1)
			$l_NoRegistro:=SQ_SeqNumber (->[BBL_Registros:66]No_Registro:25)
			$l_recNum:=Find in field:C653([BBL_Registros:66]No_Registro:25;$l_NoRegistro)
		End while 
		
	End if 
	[BBL_Registros:66]No_Registro:25:=$l_NoRegistro
	  //[BBL_Registros]No_Registro:=SQ_SeqNumber (->[BBL_Registros]No_Registro)
	$y_campoFuenteBarCode:=Field:C253(Table:C252(->[BBL_Registros:66]);<>lBBL_refCampoBarcodeDocumento)
	[BBL_Registros:66]Lugar:13:=<>gBBL_BibliotecaPrincipal
	BBLreg_GeneraCodigoBarra 
	
	SET QUERY DESTINATION:C396(Into variable:K19:4;$l_registros)
	QUERY:C277([BBL_Registros:66];[BBL_Registros:66]Barcode_SinFormato:26=[BBL_Registros:66]Barcode_SinFormato:26;*)
	QUERY:C277([BBL_Registros:66]; | ;[BBL_Registros:66]No_Registro:25=[BBL_Registros:66]No_Registro:25;*)
	QUERY:C277([BBL_Registros:66]; & ;[BBL_Registros:66]ID:3;#;[BBL_Registros:66]ID:3)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	While ($l_registros>0)
		[BBL_Registros:66]No_Registro:25:=SQ_SeqNumber (->[BBL_Registros:66]No_Registro:25)
		[BBL_Registros:66]Código_de_barra:20:=""
		BBLreg_GeneraCodigoBarra 
		SET QUERY DESTINATION:C396(Into variable:K19:4;$l_registros)
		QUERY:C277([BBL_Registros:66];[BBL_Registros:66]Barcode_SinFormato:26=[BBL_Registros:66]Barcode_SinFormato:26;*)
		QUERY:C277([BBL_Registros:66]; | ;[BBL_Registros:66]No_Registro:25=[BBL_Registros:66]No_Registro:25;*)
		QUERY:C277([BBL_Registros:66]; & ;[BBL_Registros:66]ID:3;#;[BBL_Registros:66]ID:3)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
	End while 
	
	SORT ARRAY:C229(aCpyNo;>)
	[BBL_Registros:66]Número_de_copia:2:=aCpyNo{Size of array:C274(aCpyNo)}+1
	[BBL_Registros:66]Fecha_de_ingreso:5:=Current date:C33
	[BBL_Registros:66]StatusID:34:=Disponible
	[BBL_Registros:66]Status:10:=<>aCpyStatus{[BBL_Registros:66]StatusID:34}
	[BBL_Registros:66]Número_de_volumen:19:=[BBL_Items:61]Volumen:30
	[BBL_Registros:66]Creado_por:16:=<>tUSR_CurrentUser
	
End if 


$l_numeroEnBarCode:=Num:C11([BBL_Registros:66]Código_de_barra:20)
Case of 
	: ([BBL_Registros:66]No_Registro:25=$l_numeroEnBarCode)
		OBJECT SET VISIBLE:C603([BBL_Registros:66]Barcode_Protegido:28;False:C215)
	: ([BBL_Registros:66]ID:3=$l_numeroEnBarCode)
		OBJECT SET VISIBLE:C603([BBL_Registros:66]Barcode_Protegido:28;False:C215)
	: ([BBL_Registros:66]Barcode_Protegido:28)
		OBJECT SET VISIBLE:C603([BBL_Registros:66]Barcode_Protegido:28;True:C214)
	Else 
		
End case 


OBJECT SET ENTERABLE:C238([BBL_Registros:66]Barcode_Protegido:28;False:C215)
OBJECT SET ENTERABLE:C238([BBL_Registros:66]Barcode_SinFormato:26;False:C215)
viBBL_BarCodeEnterable:=0
OBJECT SET VISIBLE:C603(*;"padlockUnlocked";False:C215)
OBJECT SET VISIBLE:C603(*;"padlockLocked";True:C214)

Case of 
	: (Is new record:C668([BBL_Registros:66]))
		vStatusMsg:=""
	: ([BBL_Registros:66]StatusID:34=Disponible)
		vStatusMsg:=[BBL_Registros:66]Status:10
		OBJECT SET COLOR:C271(vStatusMsg;-3078)
	: ([BBL_Registros:66]StatusID:34=Prestado)
		vStatusMsg:=[BBL_Registros:66]Status:10+" hasta el "+DT_Date2SpanishString ([BBL_Registros:66]Prestado_hasta:14)
		OBJECT SET COLOR:C271(vStatusMsg;-3075)
	: ([BBL_Registros:66]StatusID:34=Reservado)
		vStatusMsg:=[BBL_Registros:66]Status:10+" "+[BBL_Registros:66]Reserva:12
		OBJECT SET COLOR:C271(vStatusMsg;-3074)
	Else 
		vStatusMsg:=[BBL_Registros:66]Status:10
		OBJECT SET COLOR:C271(vStatusMsg;-3075)
End case 
If ([BBL_Registros:66]Número_de_préstamos:22>0)
	vStatusMsg2:="Este item (todas las copias) ha sido prestado en "+String:C10([BBL_Items:61]Use_number:40)+" ocasion(es), "+" durante un total de "+String:C10([BBL_Items:61]Días_de_utilización:39)+" días."+"\r"
	vStatusMsg2:=vStatusMsg2+"El último préstamo fue el "+String:C10([BBL_Items:61]Fecha_ultimo_prestamo:42)
Else 
	vStatusMsg2:=""
End if 

If (<>bBBL_NumeroRegistroEditable)
	OBJECT SET ENTERABLE:C238(*;"NoRegistro";True:C214)
	If (Is new record:C668([BBL_Registros:66]))
		HIGHLIGHT TEXT:C210([BBL_Registros:66]No_Registro:25;1;81)
	Else 
		HIGHLIGHT TEXT:C210([BBL_Registros:66]No_Registro:25;81;81)
	End if 
Else 
	OBJECT SET ENTERABLE:C238(*;"NoRegistro";False:C215)
	HIGHLIGHT TEXT:C210([BBL_Registros:66]Número_de_volumen:19;81;81)
End if 

If (<>gUsaMARC)
	OBJECT SET COLOR:C271(*;"MARC@";-6)
	OBJECT SET FONT STYLE:C166(*;"MARC@";Underline:K14:4)
	_O_ENABLE BUTTON:C192(*;"btnMARC@")
Else 
	_O_DISABLE BUTTON:C193(*;"btnMARC@")
End if 

If (Record number:C243([BBL_Registros:66])=-3)
	SET WINDOW TITLE:C213(__ ("Nueva copia")+", "+[BBL_Items:61]Primer_título:4)
Else 
	SET WINDOW TITLE:C213(__ ("Copia #")+String:C10([BBL_Registros:66]Número_de_copia:2)+", "+[BBL_Items:61]Primer_título:4)
End if 