$line:=AL_GetLine (xALP_CtasBancarias)
AL_UpdateArrays (xALP_CtasBancarias;0)
AT_Delete ($line;1;->atACT_CtaColegioCod;->atACT_CtaColegioBanco;->atACT_CtaColegioCta)
AL_UpdateArrays (xALP_CtasBancarias;-2)
AL_SetLine (xALP_CtasBancarias;0)
_O_DISABLE BUTTON:C193(bDelFP)