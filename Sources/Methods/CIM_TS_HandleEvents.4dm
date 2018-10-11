//%attributes = {}
  // MÉTODO: CIM_TS_HandleEvents
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 13/05/11, 09:23:25
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // CSM_TS_HandleEvents()
  // ----------------------------------------------------


  // DECLARACIONES E INICIALIZACIONES
C_TEXT:C284($method;$1;$parameters;$3)
C_POINTER:C301($objectPointer;$2;$noTable)
C_LONGINT:C283($Error;$tableNum;$fieldNum)
_O_C_STRING:C293(255;$varName)
C_BLOB:C604($0)
C_POINTER:C301($nil)
C_LONGINT:C283($otRef;$i;$positionInList;$l_column;$l_Line)
C_BLOB:C604($blob)
ARRAY DATE:C224(adTS_DocDate;0)
ARRAY TEXT:C222(atTS_DocType;0)
ARRAY TEXT:C222(atTS_DocTitle;0)
ARRAY LONGINT:C221(alTS_DocID;0)
  // CODIGO PRINCIPAL
Case of 
	: (Count parameters:C259=1)
		$method:=$1
	: (Count parameters:C259=2)
		$method:=$1
		$ObjectPointer:=$2
	: (Count parameters:C259=3)
		$method:=$1
		$ObjectPointer:=$2
		$parameters:=$3
End case 

If (Not:C34(Is nil pointer:C315($objectPointer)))
	RESOLVE POINTER:C394($objectPointer;$varName;$tableNum;$fieldNum)
	If ($tableNum>0) & ($fieldNum>0)
		$fieldName:="["+Table name:C256($tableNum)+"]"+Field name:C257($tableNum;$fieldNum)
	End if 
End if 


Case of 
	: ($method="GetTicketList")
		ARRAY DATE:C224(adTS_Fecha;0)
		ARRAY TEXT:C222($atUserName;0)
		ARRAY TEXT:C222(atTS_Asunto;0)
		ARRAY TEXT:C222(atTS_SupportEvents;0)
		ARRAY LONGINT:C221(alTS_TicketNumber;0)
		
		vlTS_UltimoIncidente:=0
		  //OBJECT SET RGB COLORS(*;"lb_Tickets";0;0x00FFFFFF;(222 << 16)+(228 << 8)+234)
		
		$blob:=WSget_SupportEvents (<>gRolBD;<>vtXS_CountryCode;vtTS_UserName)
		$otRef:=OT BLOBToObject ($blob)
		OT GetArray ($otRef;"Fecha";adTS_Fecha)
		OT GetArray ($otRef;"Asunto";atTS_Asunto)
		OT GetArray ($otRef;"Ticket";alTS_TicketNumber)
		OT Clear ($otRef)
		
		AT_MultiLevelSort ("<<";->adTS_Fecha;->alTS_TicketNumber;->atTS_Asunto)
		SORT ARRAY:C229(alTS_TicketNumber;atTS_SupportEvents;<)
		If (Size of array:C274(alTS_TicketNumber)>0)
			vlTS_UltimoIncidente:=alTS_TicketNumber{1}
			alTS_TicketNumber:=1
			LISTBOX SELECT ROW:C912(lb_Tickets;1;lk replace selection:K53:1)
			CIM_TS_HandleEvents ("GetTicket")
			GOTO OBJECT:C206(lb_Tickets)
		Else 
			vtTS_Asunto:=""
			vtTS_Detalles:=""
			ARRAY LONGINT:C221(alTS_AttachID;0)
			ARRAY TEXT:C222(atTS_AttachDocName;0)
		End if 
		
		
		
		
		
		
	: ($method="GetTicket")
		C_TIME:C306($time)
		C_LONGINT:C283($l_Line;$otRef)
		C_BLOB:C604($blob)
		
		ARRAY LONGINT:C221(alTS_Id;0)
		ARRAY LONGINT:C221(alTS_Time;0)
		ARRAY TEXT:C222(atTS_dateTime;0)
		ARRAY DATE:C224(adTS_date;0)
		ARRAY TEXT:C222(atTS_from;0)
		ARRAY TEXT:C222(atTS_fromAddr;0)
		ARRAY TEXT:C222(atTS_To;0)
		ARRAY TEXT:C222(atTS_Tipo;0)
		ARRAY TEXT:C222(atTS_Content;0)
		ARRAY LONGINT:C221(alTS_AttachID;0)
		ARRAY TEXT:C222(atTS_AttachDocName;0)
		
		  //CUERPO
		vlTS_UltimoIncidente:=alTS_TicketNumber{alTS_TicketNumber}
		$blob:=WSget_SupportEventRecord (vlTS_UltimoIncidente;vtTS_UserName)
		$otRef:=OT BLOBToObject ($blob)
		vtTS_TipoProblema:=OT GetText ($otRef;"TipoProblema")
		vtTS_Detalles:=ST_ClrWildChars (OT GetText ($otRef;"Detalles"))
		vdTS_FechaRespuesta:=OT GetDate ($otRef;"Fecha")
		vtTS_Asunto:=OT GetText ($otRef;"Asunto")
		vtTS_Respuesta:=OT GetText ($otRef;"Respuesta")
		vtTS_Estado:=OT GetText ($otRef;"Estado")
		vtTS_Usuario:=OT GetText ($otRef;"Usuario")
		
		OT GetArray ($otRef;"Historia_Id";alTS_Id)
		OT GetArray ($otRef;"Historia_from";atTS_from)
		OT GetArray ($otRef;"Historia_FromAddr";atTS_fromAddr)
		OT GetArray ($otRef;"Historia_to";atTS_To)
		OT GetArray ($otRef;"Historia_date";adTS_date)
		OT GetArray ($otRef;"Historia_time";alTS_Time)
		OT GetArray ($otRef;"Historia_subject";atTS_Tipo)
		OT GetArray ($otRef;"Historia_reply";atTS_Content)
		
		OT GetArray ($otRef;"Adjuntos_ID";alTS_AttachID)
		OT GetArray ($otRef;"Adjuntos_NombreArchivo";atTS_AttachDocName)
		
		OT Clear ($otRef)
		
		Case of 
			: (vtTS_TipoProblema="D")
				vtTS_TipoProblema:="Defecto"
			: (vtTS_TipoProblema="C")
				vtTS_TipoProblema:="Consulta"
			: (vtTS_TipoProblema="R")
				vtTS_TipoProblema:="Requerimientro"
			: (vtTS_TipoProblema="K")
				vtTS_TipoProblema:="Comentario"
		End case 
		
		If (vdTS_FechaRespuesta#!00-00-00!)
			vtTS_Estado:=vtTS_Estado+" el "+String:C10(vdTS_FechaRespuesta)
		End if 
		
		ARRAY TEXT:C222(atTS_dateTime;Size of array:C274(alTS_Id))
		For ($i;1;Size of array:C274(alTS_Id))
			If (atTS_tipo{$i}="Email")
				$time:=alTS_Time{$i}*1
				atTS_dateTime{$i}:=String:C10(adTS_date{$i};7)+" "+String:C10($time;2)+" (GMT)"
			Else 
				$time:=alTS_Time{$i}*1
				atTS_dateTime{$i}:=String:C10(adTS_date{$i};7)+" "+String:C10($time;2)
			End if 
		End for 
		
		
		
		
	: ($method="CommentSelection")
		vtTS_EventID:=String:C10(alTS_Id{alTS_Id})
		Case of 
			: (Form event:C388=On Clicked:K2:4)
				LISTBOX GET CELL POSITION:C971(lb_ComentariosTicket;$l_column;$l_line)
				If ($l_line>0)
					vtTS_EventID:=String:C10(alTS_TicketNumber{$l_Line})
					vtTS_Topic:=atTS_Asunto{$l_Line}
					$time:=alTS_Time{$l_Line}*1
					$DTS:=String:C10(adTS_fecha{$l_Line})+", "+String:C10($time)
					$FROM:=atTS_From{$l_Line}
					vtTS_DetalleComentario:=atTS_Content{$l_Line}
					vtTS_ComentarioOriginalDE:="El "+$DTS+" "+$FROM+" escribió"
					vtTS_Comentarios:=HTML_Html2Text (atTS_Content{$l_Line})
					
					If ((<>tUSR_CurrentUserName#"") & (<>tUSR_CurrentUserEmail#""))
						$DTS:=String:C10(adTS_Date{$l_Line})+", "+String:C10($time)
						$FROM:=atTS_From{$l_Line}
						vtEM4D_To:=atTS_FromAddr{$l_Line}
						vtEM4D_Subject:="RE: "+vtTS_Topic
						  //vtTS_Comentarios:=atTS_Content{$l_Line}
						vtTS_Comentarios:=HTML_Html2Text (atTS_Content{$l_Line})
						vtTS_ComentarioOriginal:=HTML_Html2Text (atTS_Content{$l_Line})
						vtTS_ComentarioOriginalDE:="El "+$DTS+" "+$FROM+" escribió"
						vtEM4D_CC:=""
						  //WDW_OpenFormWindow (->[xxSTR_Constants];"TS_EnviaIncidente";-1;8;__ ("Comentario para ticket N˚ ")+vtTS_EventID)
						  //DIALOG([xxSTR_Constants];"TS_EnviaIncidente")
						  //CLOSE WINDOW
					Else 
						CD_Dlog (0;__ ("Debe haber completado su nombre y dirección de correo personal en la página Configuración antes de registrar un ticket."))
						  //FORM GOTO PAGE(1)
					End if 
					
				End if 
				
				
			: (Form event:C388=On Double Clicked:K2:5)
				If (alTS_TicketNumber>0)
					  //$DTS:=String(adTS_Date{alTS_TicketNumber})+", "+String($time)
					$FROM:=atTS_From{alTS_Id}
					If (atTS_tipo{alTS_Id}="Email")
						$doctitle:="Correo en Incidente N˚ "+vtTS_EventID
						$msgHeader:="<HTML><Title>"+$doctitle+"</title"
						$title:="Correo de "+$FROM+" enviado el "+atTS_dateTime{alTS_Id}
						$msgHeader:=$msgHeader+"<body bgcolor=\"#ffffff\" text=\"#000000\" onload=window.resizeTo(735,screen.height-1"+"00)>"+"\r"
						$msgHeader:=$msgHeader+"<img src=\"https://intranet.colegium.com/imagenes/DeptoTecnico.jpg\" width=\"730\" hei"+"ght=\"98"+"\"><P></p>"+"\r"
						$msgHeader:=$msgHeader+"<h3>"+_O_Mac to ISO:C519($title)+"</h3>"+"\r"
						$text:=$msgHeader+atTS_Content{alTS_Id}+"</BODY><HTML>"
					Else 
						$doctitle:="Comentario en Incidente N˚ "+vtTS_EventID
						$msgHeader:="<HTML><Title>"+$doctitle+"</title"
						$title:="Comentario de "+$FROM+" registrado el "+atTS_dateTime{alTS_Id}
						$msgHeader:=$msgHeader+"<body bgcolor=\"#ffffff\" text=\"#000000\" onload=window.resizeTo(735,screen.height-1"+"00)>"+"\r"
						$msgHeader:=$msgHeader+"<img src=\"https://intranet.colegium.com/imagenes/DeptoTecnico.jpg\" width=\"730\" hei"+"ght=\"98"+"\"><P></p>"+"\r"
						$msgHeader:=$msgHeader+"<h3>"+_O_Mac to ISO:C519($title)+"</h3>"+"\r"
						$text:=$msgHeader+HTML_Style (atTS_Content{alTS_Id};2)+"</BODY><HTML>"
					End if 
					If (SYS_IsMacintosh )
						USE CHARACTER SET:C205("windows-1252";0)
					Else 
						USE CHARACTER SET:C205("MacRoman";0)
					End if 
					
					$ref:=Create document:C266(Temporary folder:C486+"IncidenteSTR3.html";"HTML")
					$link:="<a href=\"VerDetalleEnvioIncidente.a4d"
					$text:=Replace string:C233($text;$link;"<a href=https://intranet.colegium.com/VerDetalleEnvioIncidente.a4d")
					$link:="<a href='VerDetalleEnvioIncidente.a4d"
					$text:=Replace string:C233($text;$link;"<a href=https://intranet.colegium.com/VerDetalleEnvioIncidente.a4d")
					SEND PACKET:C103($ref;$text)
					CLOSE DOCUMENT:C267($ref)
					$url:="file:///"+document
					OPEN URL:C673(document;*)
					
					USE CHARACTER SET:C205(*;0)
				End if 
		End case 
		
		
	: ($method="GetAttachment")
		$URL:="https://intranet.colegium.com/VerArchivo.a4d?idArchivo="+String:C10(alTS_AttachID{atTS_AttachDocName})
		OPEN URL:C673($url;*)
		
		
	: ($method="WriteAnswer")
		
		
End case 

