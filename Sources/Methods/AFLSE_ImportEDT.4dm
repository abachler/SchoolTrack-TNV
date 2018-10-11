//%attributes = {}
  //AFLSE_ImportEDT

  //C_TEXT($1;$2;$message;$doc)
  //If (Count parameters=0)
  //$message:=""
  //Else 
  //$message:=$1
  //End if 
  //ARRAY LONGINT($aAlumnosAsignados;0)
  //
  //If (Application type=4D Client )
  //$p:=Execute on server("AFLSE_importEDT";128*1024;"ImportHorario")
  //$ignore:=CD_Dlog (0;"La importación se está ejecutando en el servidor."+◊cr+"Si indicó una dirección de correo, recibirá un mensaje avisándole del término "+"del proceso de importación.")
  //Else 
  //Case of 
  //: ($message="")
  //◊vb_ImportingTMT:=True
  //TMT_ImportHorarios ("GetPrefs")
  //TMT_ImportHorarios ("OpenLogFile")
  //TMT_ImportHorarios ("TestFolders")
  //TMT_ImportHorarios ("InitTimeTable")
  //AFLSE_ImportEDT ("ProcessFolderDocuments")
  //AFLSE_ImportEDT ("CloseLogFile")
  //AFLSE_ImportEDT ("CleanUp")
  //AFLSE_ImportEDT ("CreateSesions")
  //
  //: ($message="GetPrefs")
  //xBlob:=PREF_fGetBlob (0;"Importacion Horarios")
  //BLOB_Blob2Vars (->xBlob;0;->atTMT_MetodoHorario;->vtTMT_Email;->vtTMT_EmailServer)
  //
  //: (($message="TestFolders") & (Application type#4D Client ))
  //$mainfolderName:=◊syT_DDPath+"ImportHorario"
  //If (Test path name($mainfolderName)#0)
  //CREATE FOLDER($mainfolderName)
  //End if 
  //
  //$processedFolder:=◊syT_DDPath+"ImportHorario"+SYS_FolderDelimiter +"Procesados"
  //If (Test path name($processedFolder)#0)
  //CREATE FOLDER($processedFolder)
  //End if 
  //
  //$errorfolder:=◊syT_DDPath+"ImportHorario"+SYS_FolderDelimiter +"Archivos con errores"
  //If (Test path name($errorfolder)#0)
  //CREATE FOLDER($errorfolder)
  //End if 
  //
  //$logFolder:=◊syT_DDPath+"ImportHorario"+SYS_FolderDelimiter +"Logs"
  //If (Test path name($logFolder)#0)
  //CREATE FOLDER($logFolder)
  //End if 
  //
  //
  //: ($message="OpenLogFile")
  //$logFolder:=◊syT_DDPath+"ImportHorario"+SYS_FolderDelimiter +"Logs"
  //$logName:=$logFolder+SYS_FolderDelimiter +"Log_Import_"+String(Year of(Current date(*));"0000")+String(Month of(Current date(*));"00")+String(Day of(Current date(*));"00")+".txt"
  //If (Test path name($logName)=1)
  //vh_logRef:=Append document($logName)
  //Else 
  //vh_logRef:=Create document($logName)
  //End if 
  //
  //
  //: ($message="InitTimeTable")
  //READ WRITE([TMT_Horario])
  //ALL RECORDS([TMT_Horario])
  //DELETE SELECTION([TMT_Horario])
  //
  //
  //: ($message="ProcessFolderDocuments")
  //$mainfolderName:=◊syT_DDPath+"ImportHorario"
  //$processedFolder:=◊syT_DDPath+"ImportHorario"+SYS_FolderDelimiter +"Procesados"
  //$errorfolder:=◊syT_DDPath+"ImportHorario"+SYS_FolderDelimiter +"Archivos con errores"
  //$logFolder:=◊syT_DDPath+"ImportHorario"+SYS_FolderDelimiter +"Logs"
  //
  //ARRAY TEXT($aDocuments;0)
  //DOCUMENT LIST($mainfolderName;$aDocuments)
  //If (Size of array($aDocuments)>0)
  //  ` lectura de archivo con semanas A y B
  //  `$weeksFile:=<>syT_DDPath+"ImportHorario"+SYS_FolderDelimiter +"Semaines.txt"
  //  `If (Test path name($weeksFile)=1)
  //  `ARRAY DATE(aWeeksA_From;0)
  //  `ARRAY DATE(aWeeksA_To;0)
  //  `ARRAY DATE(aWeeksB_From;0)
  //  `ARRAY DATE(aWeeksB_To;0)
  //  `$size:=0
  //  `$docRef:=Open document($weeksFile)
  //  `RECEIVE PACKET($docRef;$row;"\r")
  //  `While ((ok=1) & ($row#""))
  //  `$size:=$size+1
  //  `AT_Insert ($size;1;->aWeeksA_From;->aWeeksA_To;->aWeeksB_From;->aWeeksB_To)
  //  `aWeeksA_From{$size}:=Date(String(Date(ST_GetWord ($row;1;"\t"));7))
  //  `aWeeksA_To{$size}:=Date(String(Date(ST_GetWord ($row;2;"\t"));7))
  //  `aWeeksB_From{$size}:=Date(String(Date(ST_GetWord ($row;3;"\t"));7))
  //  `aWeeksB_To{$size}:=Date(String(Date(ST_GetWord ($row;4;"\t"));7))
  //  `RECEIVE PACKET($docRef;$row;"\r")
  //  `End while 
  //  `CLOSE DOCUMENT($docRef)
  //  `End if 
  //
  //For ($i;1;Size of array($aDocuments))
  //If (($aDocuments{$i}#".DS@") & ($aDocuments{$i}#"Semaines.txt"))
  //$doc:=$mainfolderName+SYS_FolderDelimiter +$aDocuments{$i}
  //If (Document type($doc)#"TEXT")
  //$logMessage:=(◊tb*4)+"ERROR GENERAL: "+"El documento "+$doc+" es de tipo incorrecto. No fue procesado (movido a la carpeta "+"Archivos con errores)."+◊cr
  //SEND PACKET(vh_logRef;Mac to Win($logMessage))
  //$file2Move:=$errorfolder+SYS_FolderDelimiter +$aDocuments{$i}
  //If (Test path name($file2Move)>0)
  //DELETE DOCUMENT($file2Move)
  //End if 
  //MOVE DOCUMENT($doc;$errorfolder+SYS_FolderDelimiter +$aDocuments{$i})
  //Else 
  //$docRef:=Open document($doc)
  //RECEIVE PACKET($docRef;$row;"\r")
  //If (ok=1)
  //$columns:=ST_CountWords ($row;0;"\t")
  //If ($columns#7)  ` estructura incorrecta
  //CLOSE DOCUMENT($docRef)
  //$file2Move:=$errorfolder+SYS_FolderDelimiter +$aDocuments{$i}
  //If (Test path name($file2Move)>0)
  //DELETE DOCUMENT($file2Move)
  //End if 
  //MOVE DOCUMENT($doc;$errorfolder+SYS_FolderDelimiter +$aDocuments{$i})
  //$logMessage:=(◊tb*4)+"ERROR GENERAL: "+"La estructura del documento "+$doc+" es incorrecta."+" No fue procesado (movido a la carpeta Archivos con errores)."+◊cr
  //SEND PACKET(vh_logRef;Mac to Win($logMessage))
  //Else 
  //$error:=False
  //Case of 
  //: (ST_GetWord ($row;1;"\t")#"CODEMAT@")
  //$error:=True
  //: (ST_GetWord ($row;2;"\t")#"CLASSE@")
  //$error:=True
  //: (ST_GetWord ($row;3;"\t")#"MATIERE@")
  //$error:=True
  //: (ST_GetWord ($row;4;"\t")#"DUREE@")
  //$error:=True
  //: (ST_GetWord ($row;5;"\t")#"JOUR@")
  //$error:=True
  //: (ST_GetWord ($row;6;"\t")#"HEURE@")
  //$error:=True
  //: (ST_GetWord ($row;7;"\t")#"FREQUENCE@")
  //$error:=True
  //End case 
  //If ($error)
  //CLOSE DOCUMENT($docRef)
  //$file2Move:=$errorfolder+SYS_FolderDelimiter +$aDocuments{$i}
  //If (Test path name($file2Move)>0)
  //DELETE DOCUMENT($file2Move)
  //End if 
  //MOVE DOCUMENT($doc;$errorfolder+SYS_FolderDelimiter +$aDocuments{$i})
  //$logMessage:=(◊tb*4)+"ERROR GENERAL: "+"La estructura del documento "+$doc+" es incorrecta."+" No fue procesado (movido a la carpeta Archivos con errores)."+◊cr
  //SEND PACKET(vh_logRef;Mac to Win($logMessage))
  //Else 
  //CLOSE DOCUMENT($docRef)
  //AFLSE_ImportEDT ("ProcessFile";$doc)
  //End if 
  //End if 
  //End if 
  //End if 
  //End if 
  //End for 
  //Else 
  //$logMessage:=(◊tb*4)+"ERROR GENERAL: "+"No hay documentos a importar"+◊cr
  //SEND PACKET(vh_logRef;Mac to Win($logMessage))
  //End if 
  //
  //
  //: ($message="ProcessFile")
  //$doc:=$2
  //$size:=SYS_GetFileSize ($doc)
  //$docRef:=Open document($doc)
  //$rowRefNum:=1
  //$length:=0
  //$msgOn:=◊vb_msgON
  //◊vb_msgON:=True
  //CD_THERMOMETRE (1;0;"Importando Horario EDT...")
  //RECEIVE PACKET($docRef;$row;"\r")
  //TRACE
  //While ((ok=1) & ($row#""))
  //$length:=$length+Length($row)+1
  //CD_THERMOMETRE (0;$length/$size*100;"Importando Horario EDT...")
  //RECEIVE PACKET($docRef;$row;"\r")
  //$rowRefNum:=$rowRefNum+1
  //If ($row#"")
  //ARRAY TEXT(aFileColumns;0)
  //AT_Text2Array (->aFileColumns;$row;"\t")
  //ARRAY TEXT(aFileColumns;7)
  //$codeMateria:=ST_GetCleanString (aFileColumns{1})
  //$curso:=ST_GetCleanString (aFileColumns{2})
  //$materia:=aFileColumns{3}
  //$duracion:=Substring(aFileColumns{4};1;2)
  //$dia:=AFLSE_ImportEDT ("GetDayNumber";ST_GetCleanString (aFileColumns{5}))
  //$horaInicio:=Replace string(ST_GetCleanString (aFileColumns{6});"h";":")
  //$tipoSemana:=ST_GetCleanString (aFileColumns{7})
  //QUERY([Cursos];[Cursos]Curso=$curso)
  //PERIODOS_LoadData ([Cursos]Nivel_Numero)
  //$Hora:=Find in array(alSTR_Horario_Desde;Time($horaInicio)*1)
  //If ($Hora>0)
  //$horaInicio:=String($hora)
  //If (Position("+";$curso)>0)
  //ARRAY TEXT(at_Classes;0)
  //AT_Text2Array (->at_Classes;$curso;"+")
  //For ($i_cursos;1;Size of array(at_Classes))
  //$curso:=at_Classes{$i_Cursos}
  //AFLSE_ImportEDT ("ImportTimeSlot";$codeMateria;$curso;$materia;$duracion;$dia;$horaInicio;$tipoSemana;String($rowRefNum))
  //End for 
  //Else 
  //AFLSE_ImportEDT ("ImportTimeSlot";$codeMateria;$curso;$materia;$duracion;$dia;$horaInicio;$tipoSemana;String($rowRefNum))
  //End if 
  //Else 
  //$horaInicio:="-1"
  //$logMessage:="Linea "+String($rowRefNum)+◊tb+$codeMateria+", "+$curso+", "+$materia+◊tb+"ERROR. No se importó por que el horario está fuera de rango"+◊cr
  //SEND PACKET(vh_logRef;Mac to Win($logMessage))
  //End if 
  //
  //End if 
  //
  //End while 
  //CLOSE DOCUMENT($docRef)
  //$processedFolder:=◊syT_DDPath+"ImportHorario"+SYS_FolderDelimiter +"Procesados"
  //$file2Move:=$processedFolder+SYS_FolderDelimiter +SYS_Path2FileName ($doc)
  //If (Test path name($file2Move)>0)
  //DELETE DOCUMENT($file2Move)
  //End if 
  //MOVE DOCUMENT($doc;$processedFolder+SYS_FolderDelimiter +SYS_Path2FileName ($doc))
  //CD_THERMOMETRE (-1)
  //◊vb_msgON:=$msgOn
  //
  //: ($message="ImportTimeSlot")
  //$codeMateria:=ST_GetCleanString ($2)
  //$curso:=ST_GetCleanString ($3)
  //$materia:=ST_GetCleanString ($4)
  //$duracionNum:=Num(ST_GetCleanString ($5))
  //$diaNum:=Num(ST_GetCleanString ($6))
  //$horaInicioNum:=Num(ST_GetCleanString ($7))
  //$tipoSemana:=ST_GetCleanString ($8)
  //$rowRefString:=ST_GetCleanString ($9)
  //$nivel:=Num(Substring($curso;1;1))
  //
  //Case of 
  //: ($nivel=0)
  //$nivel:=12
  //: ($nivel=1)
  //$nivel:=11
  //: ($nivel=2)
  //$nivel:=10
  //: ($nivel=3)
  //$nivel:=9
  //: ($nivel=4)
  //$nivel:=8
  //: ($nivel=5)
  //$nivel:=7
  //: ($nivel=6)
  //$nivel:=6
  //: ($nivel=8)
  //$nivel:=5
  //: ($nivel=9)
  //$nivel:=4
  //End case 
  //If (($curso="0@") & ($curso≤2≥#"/"))
  //$curso:=Replace string($curso;"0";"T";1)
  //End if 
  //If (Length($curso)<=3)
  //$curso:=Substring($curso;1;1)+"-"+Substring($curso;2)
  //End if 
  //QUERY([Asignaturas];[Asignaturas]Numero_del_Nivel=$nivel;*)
  //QUERY([Asignaturas]; & ;[Asignaturas]Abreviación=$codeMateria;*)
  //QUERY([Asignaturas]; & ;[Asignaturas]Incide_en_Asistencia=True;*)
  //QUERY([Asignaturas]; & ;[Asignaturas]Curso=$curso)
  //$idAsignatura:=[Asignaturas]Numero
  //$idTeacher:=[Asignaturas]Profesor_Numero
  //$recordTimeSlot:=True
  //PERIODOS_LoadData ($nivel)
  //
  //
  //Case of 
  //: (Records in selection([Asignaturas])=0)
  //$recordTimeSlot:=False
  //$logMessage:="Linea "+$rowRefString+◊tb+$2+", "+$3+", "+$4+◊tb+"ERROR. No se importó por que no se encontró la asignatura"+◊cr
  //SEND PACKET(vh_logRef;Mac to Win($logMessage))
  //: (Records in selection([Asignaturas])>1)
  //$recordTimeSlot:=False
  //$logMessage:="Linea "+$rowRefString+◊tb+$2+", "+$3+", "+$4+◊tb+"ERROR. No se importó porque más de una asignatura "+"corresponde a los códigos indicados."+◊cr
  //SEND PACKET(vh_logRef;Mac to Win($logMessage))
  //End case 
  //$endAt:=$duracionNum+$horaInicioNum-1
  //If (($duracionNum=0) | ($endAt>Size of array(alSTR_Horario_Desde)))
  //$recordTimeSlot:=False
  //$logMessage:="Linea "+$rowRefString+◊tb+$2+", "+$3+", "+$4+◊tb+"ERROR. No se importó por que el horario está fuera de rango"+◊cr
  //SEND PACKET(vh_logRef;Mac to Win($logMessage))
  //End if 
  //If ($diaNum=0)
  //$recordTimeSlot:=False
  //$logMessage:="Linea "+$rowRefString+◊tb+$2+", "+$3+", "+$4+◊tb+"ERROR. No se importó por que el dia no está indicado"+◊cr
  //SEND PACKET(vh_logRef;Mac to Win($logMessage))
  //
  //End if 
  //If ($recordTimeSlot)
  //Case of 
  //: ($tipoSemana="H")
  //$noCiclo:=1
  //For ($i_Horas;$horaInicioNum;$horaInicioNum+$duracionNum-1)
  //$logError:=AFLSE_ImportEDT ("VerifyTimeSlot";String($diaNum);String($i_Horas);String($idTeacher);String($idAsignatura);String($nivel);String($noCiclo))
  //If ($logError="")
  //CREATE RECORD([TMT_Horario])
  //[TMT_Horario]ID_Asignatura:=$idAsignatura
  //[TMT_Horario]ID_Teacher:=$idTeacher
  //[TMT_Horario]ID_Sala:=0
  //[TMT_Horario]Desde:=alSTR_Horario_Desde{$i_Horas}
  //[TMT_Horario]Hasta:=◊aHasta{$i_Horas}
  //[TMT_Horario]Nivel:=$nivel
  //[TMT_Horario]NumeroDia:=$diaNum
  //[TMT_Horario]NumeroHora:=$i_Horas
  //[TMT_Horario]Observaciones:="Importado desde EDT el "+String(Current date(*))
  //[TMT_Horario]SesionesDesde:=vdTMT_StartSesionsFrom
  //[TMT_Horario]SesionesHasta:=vdSTR_Periodos_FinEjercicio
  //[TMT_Horario]No_Ciclo:=1
  //SAVE RECORD([TMT_Horario])
  //TMT_CuentaHorasClases ([TMT_Horario]ID_Asignatura)
  //
  //$logMessage:="Linea "+$rowRefString+◊tb+"("+$2+", "+$3+", "+$4+")"+◊tb+"OK. Registro creado el dia "+String($diaNum)+" en hora "+String($i_Horas)+" entre el "+String([TMT_Horario]SesionesDesde;7)+" y el "+String([TMT_Horario]SesionesHasta;7)+◊cr
  //SEND PACKET(vh_logRef;Mac to Win($logMessage))
  //Else 
  //$logMessage:="Linea "+$rowRefString+◊tb+"("+$2+", "+$3+", "+$4+")"+◊tb+$logError+◊cr
  //SEND PACKET(vh_logRef;Mac to Win($logError))
  //End if 
  //End for 
  //: ($tipoSemana="Q1")
  //$noCiclo:=1
  //For ($i_Horas;$horaInicioNum;$horaInicioNum+$duracionNum-1)
  //$logError:=AFLSE_ImportEDT ("VerifyTimeSlot";String($diaNum);String($i_Horas);String($idTeacher);String($idAsignatura);String($nivel);String($noCiclo))
  //If ($logError="")
  //CREATE RECORD([TMT_Horario])
  //[TMT_Horario]ID_Asignatura:=$idAsignatura
  //[TMT_Horario]ID_Teacher:=$idTeacher
  //[TMT_Horario]ID_Sala:=0
  //[TMT_Horario]Desde:=alSTR_Horario_Desde{$i_Horas}
  //[TMT_Horario]Hasta:=◊aHasta{$i_Horas}
  //[TMT_Horario]Nivel:=$nivel
  //[TMT_Horario]NumeroDia:=$diaNum
  //[TMT_Horario]NumeroHora:=$i_Horas
  //[TMT_Horario]Observaciones:="Importado desde EDT el "+String(Current date(*))
  //[TMT_Horario]SesionesDesde:=vdTMT_StartSesionsFrom
  //[TMT_Horario]SesionesHasta:=vdSTR_Periodos_FinEjercicio
  //[TMT_Horario]No_Ciclo:=1
  //SAVE RECORD([TMT_Horario])
  //$logMessage:="Linea "+$rowRefString+◊tb+"("+$2+", "+$3+", "+$4+")"+◊tb+"OK. Registro creado el dia "+String($diaNum)+" en hora "+String($i_Horas)+" entre el "+String([TMT_Horario]SesionesDesde;7)+" y el "+String([TMT_Horario]SesionesHasta;7)+◊cr
  //SEND PACKET(vh_logRef;Mac to Win($logMessage))
  //TMT_CuentaHorasClases ([TMT_Horario]ID_Asignatura)
  //Else 
  //$logMessage:="Linea "+$rowRefString+◊tb+"("+$2+", "+$3+", "+$4+")"+◊tb+$logError+◊cr
  //SEND PACKET(vh_logRef;Mac to Win($logError))
  //End if 
  //End for 
  //: ($tipoSemana="Q2")
  //$noCiclo:=2
  //For ($i_Horas;$horaInicioNum;$horaInicioNum+$duracionNum-1)
  //$logError:=AFLSE_ImportEDT ("VerifyTimeSlot";String($diaNum);String($i_Horas);String($idTeacher);String($idAsignatura);String($nivel);String($noCiclo))
  //If ($logError="")
  //CREATE RECORD([TMT_Horario])
  //[TMT_Horario]ID_Asignatura:=$idAsignatura
  //[TMT_Horario]ID_Teacher:=$idTeacher
  //[TMT_Horario]ID_Sala:=0
  //[TMT_Horario]Desde:=alSTR_Horario_Desde{$i_Horas}
  //[TMT_Horario]Hasta:=◊aHasta{$i_Horas}
  //[TMT_Horario]Nivel:=$nivel
  //[TMT_Horario]NumeroDia:=$diaNum
  //[TMT_Horario]NumeroHora:=$i_Horas
  //[TMT_Horario]Observaciones:="Importado desde EDT el "+String(Current date(*))
  //[TMT_Horario]SesionesDesde:=vdTMT_StartSesionsFrom
  //[TMT_Horario]SesionesHasta:=vdSTR_Periodos_FinEjercicio
  //[TMT_Horario]No_Ciclo:=2
  //SAVE RECORD([TMT_Horario])
  //$logMessage:="Linea "+$rowRefString+◊tb+"("+$2+", "+$3+", "+$4+")"+◊tb+"OK. Registro creado el dia "+String($diaNum)+" en hora "+String($i_Horas)+" entre el "+String([TMT_Horario]SesionesDesde;7)+" y el "+String([TMT_Horario]SesionesHasta;7)+◊cr
  //SEND PACKET(vh_logRef;Mac to Win($logMessage))
  //TMT_CuentaHorasClases ([TMT_Horario]ID_Asignatura)
  //Else 
  //$logMessage:="Linea "+$rowRefString+◊tb+"("+$2+", "+$3+", "+$4+")"+◊tb+$logError+◊cr
  //SEND PACKET(vh_logRef;Mac to Win($logError))
  //End if 
  //End for 
  //Else 
  //For ($i_Horas;$horaInicioNum;$horaInicioNum+$duracionNum-1)
  //$logError:="Frecuencia desconocida."
  //$logMessage:="Linea "+$rowRefString+◊tb+"("+$2+", "+$3+", "+$4+")"+◊tb+$logError+◊cr
  //SEND PACKET(vh_logRef;Mac to Win($logError))
  //End for 
  //End case 
  //End if 
  //
  //: ($message="GetDayNumber")
  //$dia:=$2
  //Case of 
  //: ($dia="Lundi")
  //$dia:="1"
  //: ($dia="Mardi")
  //$dia:="2"
  //: ($dia="Mercredi")
  //$dia:="3"
  //: ($dia="Jeudi")
  //$dia:="4"
  //: ($dia="Vendredi")
  //$dia:="5"
  //: ($dia="Samedi")
  //$dia:="6"
  //End case 
  //$0:=$dia
  //
  //: ($message="VerifyTimeSlot")
  //$dayNumber:=Num($2)
  //$timeSlot:=Num($3)
  //$TeacherID:=Num($4)
  //$idSubsector:=Num($5)
  //$nivelNum:=Num($6)
  //$noCiclo:=Num($7)
  //$asigned:=False
  //$logMessage:=""
  //QUERY([TMT_Horario];[TMT_Horario]NumeroDia=$dayNumber;*)
  //QUERY([TMT_Horario]; & [TMT_Horario]NumeroHora=$timeSlot;*)
  //QUERY([TMT_Horario]; & [TMT_Horario]ID_Teacher=$teacherID;*)
  //QUERY([TMT_Horario]; & [TMT_Horario]No_Ciclo=$noCiclo)
  //If (Records in selection([TMT_Horario])>0)
  //While (Not(End selection([TMT_Horario])))
  //If ($fromDate<=[TMT_Horario]SesionesDesde)
  //If ($toDate>=[TMT_Horario]SesionesDesde)
  //$asigned:=True
  //End if 
  //Else 
  //If ($fromDate<=[TMT_Horario]SesionesHasta)
  //$asigned:=True
  //End if 
  //End if 
  //NEXT RECORD([TMT_Horario])
  //End while 
  //End if 
  //If ($asigned)
  //$logMessage:="ERROR. El profesor ya tiene una hora asignada en este horario."
  //End if 
  //If ($logMessage="")
  //QUERY([TMT_Horario];[TMT_Horario]NumeroDia=$dayNumber;*)
  //QUERY([TMT_Horario]; & [TMT_Horario]NumeroHora=$timeSlot;*)
  //QUERY([TMT_Horario]; & [TMT_Horario]ID_Asignatura#$idSubsector;*)
  //QUERY([TMT_Horario]; & [TMT_Horario]No_Ciclo=$noCiclo;*)
  //QUERY([TMT_Horario]; & [TMT_Horario]Nivel=[Asignaturas]Numero_del_Nivel)
  //If (Records in selection([TMT_Horario])>0)
  //While (Not(End selection([TMT_Horario])))
  //If ($fromDate<=[TMT_Horario]SesionesDesde)
  //If ($toDate>=[TMT_Horario]SesionesDesde)
  //$asigned:=True
  //End if 
  //Else 
  //If ($fromDate<=[TMT_Horario]SesionesHasta)
  //$asigned:=True
  //End if 
  //End if 
  //NEXT RECORD([TMT_Horario])
  //End while 
  //End if 
  //If ($asigned)
  //KRL_RelateSelection (->[Asignaturas]Numero;->[TMT_Horario]ID_Asignatura;"")
  //KRL_RelateSelection (->[Alumnos_Calificaciones]ID_Asignatura;->[Asignaturas]Numero;"")
  //QUERY SELECTION([Alumnos_Calificaciones];[Alumnos_Calificaciones]Año=◊gYear;*)
  //QUERY SELECTION([Alumnos_Calificaciones]; & ;[Alumnos_Calificaciones]ID_institucion=◊gInstitucion)
  //SELECTION TO ARRAY([Alumnos_Calificaciones]ID_Alumno;$aAlumnosAsignados)
  //For ($i;1;Size of array($aAlumnosNoAsignados))
  //$el:=Find in array($aAlumnosAsignados;$aAlumnosNoAsignados{$i})
  //If ($el>0)
  //$logMessage:="ERROR. Uno o más alumnos inscritos en el subsector que desea asignar ya tienen "+"hora asignada en este horario."
  //End if 
  //End for 
  //
  //End if 
  //End if 
  //$0:=$logMessage
  //
  //
  //: ($message="CloseLogFile")
  //CLOSE DOCUMENT(vh_logRef)
  //TMT_ImportHorarios ("GetPrefs")
  //TMT_ImportHorarios ("SendMail")
  //
  //: ($message="CleanUp")
  //vhlogRef:=†00:00:00†
  //ARRAY DATE(aWeeksA_From;0)
  //ARRAY DATE(aWeeksA_To;0)
  //ARRAY DATE(aWeeksB_From;0)
  //ARRAY DATE(aWeeksB_To;0)
  //◊vb_ImportingTMT:=False
  //
  //: ($message="CreateSesions")
  //dbu_CreaSesiones (True;vdTMT_StartSesionsFrom)
  //End case 
  //End if 
  //
  //
