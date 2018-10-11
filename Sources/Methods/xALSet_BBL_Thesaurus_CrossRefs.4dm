//%attributes = {}
  //xALSet_BBL_Thesaurus_CrossRefs

C_LONGINT:C283($Error)

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_CrossRefs;1;1;"at_CrossRefType")
$Error:=AL_SetArraysNam (xALP_CrossRefs;2;1;"at_CrossRefWord")

  //column 1 settings
AL_SetHeaders (xALP_CrossRefs;1;1;__ ("Tipo"))
AL_SetWidths (xALP_CrossRefs;1;1;120)
AL_SetFormat (xALP_CrossRefs;1;"";1;0;0;0)
AL_SetHdrStyle (xALP_CrossRefs;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_CrossRefs;1;"Tahoma";9;0)
AL_SetStyle (xALP_CrossRefs;1;"Tahoma";9;0)
AL_SetForeColor (xALP_CrossRefs;1;"Black";0;"Blue";0;"Black";0)
AL_SetBackColor (xALP_CrossRefs;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_CrossRefs;1;2;at_popCrossRefType)
AL_SetEntryCtls (xALP_CrossRefs;1;0)

  //column 2 settings
AL_SetHeaders (xALP_CrossRefs;2;1;__ ("Término"))
AL_SetWidths (xALP_CrossRefs;2;1;246)
AL_SetFormat (xALP_CrossRefs;2;"";0;0;0;0)
AL_SetHdrStyle (xALP_CrossRefs;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_CrossRefs;2;"Tahoma";9;0)
AL_SetStyle (xALP_CrossRefs;2;"Tahoma";9;0)
AL_SetForeColor (xALP_CrossRefs;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_CrossRefs;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_CrossRefs;2;1)
AL_SetEntryCtls (xALP_CrossRefs;2;0)

  //general options
ALP_SetDefaultAppareance (xALP_CrossRefs;9;1;1;1;2)
AL_SetColOpts (xALP_CrossRefs;1;1;0;0;0)
AL_SetRowOpts (xALP_CrossRefs;0;1;0;0;1;0)
AL_SetCellOpts (xALP_CrossRefs;0;1;1)
AL_SetMiscOpts (xALP_CrossRefs;0;0;"\\";0;1)
AL_SetMainCalls (xALP_CrossRefs;"";"")
AL_SetScroll (xALP_CrossRefs;0;0)
AL_SetEntryOpts (xALP_CrossRefs;3;0;0;0;0;<>tXS_RS_DecimalSeparator;1)
AL_SetDrgOpts (xALP_CrossRefs;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_CrossRefs;1;"";"";"")
AL_SetDrgSrc (xALP_CrossRefs;2;"";"";"")
AL_SetDrgSrc (xALP_CrossRefs;3;"";"";"")
AL_SetDrgDst (xALP_CrossRefs;1;"";"";"")
AL_SetDrgDst (xALP_CrossRefs;1;"";"";"")
AL_SetDrgDst (xALP_CrossRefs;1;"";"";"")

