(* Code automatically generated by 'PreSARAH' *) 
(* Expressions for amplitudes are obtained by FeynArts/FormCalc *) 
(* This file is supposed to be loaded and used by SARAH *) 
(* Created at 15:37 on 16.12.2015 *) 
 
 
PrintDebug["   ... ",TreeV4L]; 
NamesParticles =  {ChargedLepton, bar[ChargedLepton], ChargedLepton, bar[ChargedLepton]}; 
 NamesOperators =  {TVO4lSLL, TVO4lSRR, TVO4lSRL, TVO4lSLR, TVO4lVRR, TVO4lVLL, TVO4lVRL, TVO4lVLR, TVO4lTLL, TVO4lTLR, TVO4lTRL, TVO4lTRR}; 
 NeglectInsertionOrderTree[TreeV4L] =  {}; 
NeglectCrossedDiagrams[TreeV4L] = True; 
NameProcess = TreeV4L; 
 
Generate[TreeV4L][file_]:=Block[{i,j,k}, 
 

 (* Creating all possible processes; extract information about involved masses/couplings *) 


(* ------------------------------- *)
(* {ChargedLepton, bar[ChargedLepton], ChargedLepton, bar[ChargedLepton]} *)
(* ------------------------------- *)
 
GetInformtion4FermionProcess[ChargedLepton,bar[ChargedLepton],ChargedLepton,bar[ChargedLepton],TreeV4L,file]; 
NeededMassesAll=Intersection[NeededMasses];
NeededCouplingsAll=Intersection[NeededCouplings];
WriteCodeObservablePreSARAH[TreeV4L][NeededMassesAll,NeededCouplingsAll,TreeContributionsScalar,TreeContributionsVector,WaveContributionsScalar,WaveContributionsVector,WaveContributionsPhoton,PenguinContributionsScalar,PenguinContributionsVector,PenguinContributionsPhoton,BoxContributions,file]; 
NeededMassAllSaved[TreeV4L] = masses 
]; 

WriteCodeObservablePreSARAH[TreeV4L][masses_,couplings_,treeScalar_,treeVector_,waveScalar_,waveVector_,wavePhoton_,penguinScalar_,penguinVector_,penguinPhoton_,box_,file_] :=Block[{i,j,k,fermions,scalars}, 
 
NeededMassesAllSaved[TreeV4L] = masses; 
NeededCouplingsAllSaved[TreeV4L] = couplings; 
NeededCombinations[TreeV4L] = {{2, 1, 1, 1}, {3, 1, 1, 1}, {3, 2, 2, 2}, {3, 2, 1, 2}, {3, 1, 2, 1}}; 
PrintDebug["     writing SPheno code for ",TreeV4L]; 
MakeSubroutineTitle["CalculateTreeV4L",Flatten[{masses,couplings}],{"gt1","gt2","gt3","gt4","OnlySM"}, 
{"TVO4lSLL", "TVO4lSRR", "TVO4lSRL", "TVO4lSLR", "TVO4lVRR", "TVO4lVLL", "TVO4lVRL", "TVO4lVLR", "TVO4lTLL", "TVO4lTLR", "TVO4lTRL", "TVO4lTRR"},file]; 
WriteString[file,"! ---------------------------------------------------------------- \n"]; 
WriteString[file,"! Code based on automatically generated SARAH extensions by 'PreSARAH' \n"]; 
WriteString[file,"! Expressions for amplitudes are obtained by FeynArts/FormCalc \n"]; 
WriteString[file,"! Based on user input for process TreeV4L \n"]; 
WriteString[file,"! 'PreSARAH' output has been generated  at 15:37 on 16.12.2015 \n"]; 
WriteString[file,"! ---------------------------------------------------------------- \n \n"]; 
 
 
WriteString[file,"Implicit None \n"]; 
MakeVariableList[Flatten[{couplings,masses}],",Intent(in)",file];
WriteString[file,"Integer,Intent(in) :: gt1, gt2,gt3,gt4 \n"];
WriteString[file,"Logical, Intent(in) :: OnlySM \n"];
WriteString[file,"Integer :: iprop, i1, i2, i3, i4 \n"];
WriteString[file,"Real(dp) :: MassEx1,MassEx2,MassEx3,MassEx4, MassEx12,MassEx22,MassEx32,MassEx42 \n"];
WriteString[file,"Complex(dp), Intent(out) :: TVO4lSLL \n"]; 
WriteString[file,"Complex(dp), Intent(out) :: TVO4lSRR \n"]; 
WriteString[file,"Complex(dp), Intent(out) :: TVO4lSRL \n"]; 
WriteString[file,"Complex(dp), Intent(out) :: TVO4lSLR \n"]; 
WriteString[file,"Complex(dp), Intent(out) :: TVO4lVRR \n"]; 
WriteString[file,"Complex(dp), Intent(out) :: TVO4lVLL \n"]; 
WriteString[file,"Complex(dp), Intent(out) :: TVO4lVRL \n"]; 
WriteString[file,"Complex(dp), Intent(out) :: TVO4lVLR \n"]; 
WriteString[file,"Complex(dp), Intent(out) :: TVO4lTLL \n"]; 
WriteString[file,"Complex(dp), Intent(out) :: TVO4lTLR \n"]; 
WriteString[file,"Complex(dp), Intent(out) :: TVO4lTRL \n"]; 
WriteString[file,"Complex(dp), Intent(out) :: TVO4lTRR \n"]; 
WriteString[file,"Complex(dp) :: vertex1L, vertex1R, vertex2L, vertex2R \n"];
WriteString[file,"Real(dp) ::  MP, MP2, IMP2, IMP, MFin, MFin2, IMFin, IMFin2, Finite  \n"];
WriteString[file,"Real(dp) ::  MS1, MS12, MS2, MS22, MF1, MF12, MF2, MF22, MV1, MV12, MV2, MV22  \n"];
WriteString[file,"Complex(dp) ::  chargefactor  \n"];
WriteString[file,"Complex(dp) ::  coup1L, coup1R, coup2L, coup2R, coup3L, coup3R, coup3, coup4L, coup4R \n\n"];

WriteString[file,"Complex(dp) ::  int1,int2,int3,int4,int5,int6,int7,int8 \n\n"];

WriteString[file,"Iname=Iname+1 \n"];
WriteString[file,"NameOfUnit(Iname)='CalculateTreeV4L' \n
"];
 
AddCalcSquaredMasses[masses,file]; 
(* Initaliziation *)
WriteString[file,"Finite=1._dp \n"];
WriteString[file,"MassEx1="<>SPhenoMass[ChargedLepton,gt1]<>"  \n"];
WriteString[file,"MassEx12="<>SPhenoMassSq[ChargedLepton,gt1]<>" \n"];
WriteString[file,"MassEx2="<>SPhenoMass[bar[ChargedLepton],gt2]<>"  \n"];
WriteString[file,"MassEx22="<>SPhenoMassSq[bar[ChargedLepton],gt2]<>" \n"];
WriteString[file,"MassEx3="<>SPhenoMass[ChargedLepton,gt3]<>"  \n"];
WriteString[file,"MassEx32="<>SPhenoMassSq[ChargedLepton,gt3]<>" \n"];
WriteString[file,"MassEx4="<>SPhenoMass[bar[ChargedLepton],gt4]<>"  \n"];
WriteString[file,"MassEx42="<>SPhenoMassSq[bar[ChargedLepton],gt4]<>" \n"];
WriteString[file,"! ------------------------------ \n "];
WriteString[file,"! Amplitudes for external states \n "];
WriteString[file,"! {ChargedLepton, bar[ChargedLepton], ChargedLepton, bar[ChargedLepton]} \n "];
WriteString[file,"! ------------------------------ \n \n"];
WriteString[sphenoTeX,"\\section{External states: $"<>TeXOutput[{ChargedLepton[{gt1}], bar[ChargedLepton][{gt2}], ChargedLepton[{gt3}], bar[ChargedLepton][{gt4}]}]<>"$} \n"];
WriteString[file,"TVO4lSLL=0._dp \n"]; 
WriteString[file,"TVO4lSRR=0._dp \n"]; 
WriteString[file,"TVO4lSRL=0._dp \n"]; 
WriteString[file,"TVO4lSLR=0._dp \n"]; 
WriteString[file,"TVO4lVRR=0._dp \n"]; 
WriteString[file,"TVO4lVLL=0._dp \n"]; 
WriteString[file,"TVO4lVRL=0._dp \n"]; 
WriteString[file,"TVO4lVLR=0._dp \n"]; 
WriteString[file,"TVO4lTLL=0._dp \n"]; 
WriteString[file,"TVO4lTLR=0._dp \n"]; 
WriteString[file,"TVO4lTRL=0._dp \n"]; 
WriteString[file,"TVO4lTRR=0._dp \n"]; 
WriteDiagramsObservable[TreeV4L,{}, treeVector, {},  {}, {}, {}, {}, file];
WriteString[file,"Iname=Iname-1\n\n"]; 
WriteString[file,"End Subroutine CalculateTreeV4L \n\n"]; 
]; 
AddTreeResultPreSARAH[TreeV4L][prop_,top_,type_,file_]:=Block[{}, 

 (* This routine returns the generic expression for the amplitude of a given triangle diagram *) 
 
Switch[prop,
V, (* Vector penguins *) 
 Switch[top,  (* Check topology *) 
  1, 
	 	 WriteStringFLB[file,"  TVO4lSLL=TVO4lSLL+ 0.\n" ];
	 	 WriteString[sphenoTeX,"  TVO4lSLL= & "<> StringReplace["0",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {TVO4lSLL,0}, " ];
	 	 WriteStringFLB[file,"  TVO4lSRR=TVO4lSRR+ 0.\n" ];
	 	 WriteString[sphenoTeX,"  TVO4lSRR= & "<> StringReplace["0",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {TVO4lSRR,0}, " ];
	 	 WriteStringFLB[file,"  TVO4lSRL=TVO4lSRL+ 0.\n" ];
	 	 WriteString[sphenoTeX,"  TVO4lSRL= & "<> StringReplace["0",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {TVO4lSRL,0}, " ];
	 	 WriteStringFLB[file,"  TVO4lSLR=TVO4lSLR+ 0.\n" ];
	 	 WriteString[sphenoTeX,"  TVO4lSLR= & "<> StringReplace["0",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {TVO4lSLR,0} " ];
	 	 WriteStringFLB[file,"  TVO4lVRR=TVO4lVRR+ -1.*coup1R*coup2R*IMP2\n" ];
	 	 WriteString[sphenoTeX,"  TVO4lVRR= & "<> StringReplace["-(coup1R coup2R IMP2)",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {TVO4lVRR,-(coup1R*coup2R*IMP2)} " ];
	 	 WriteStringFLB[file,"  TVO4lVLL=TVO4lVLL+ -1.*coup1L*coup2L*IMP2\n" ];
	 	 WriteString[sphenoTeX,"  TVO4lVLL= & "<> StringReplace["-(coup1L coup2L IMP2)",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {TVO4lVLL,-(coup1L*coup2L*IMP2)} " ];
	 	 WriteStringFLB[file,"  TVO4lVRL=TVO4lVRL+ -1.*coup1R*coup2L*IMP2\n" ];
	 	 WriteString[sphenoTeX,"  TVO4lVRL= & "<> StringReplace["-(coup1R coup2L IMP2)",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {TVO4lVRL,-(coup1R*coup2L*IMP2)} " ];
	 	 WriteStringFLB[file,"  TVO4lVLR=TVO4lVLR+ -1.*coup1L*coup2R*IMP2\n" ];
	 	 WriteString[sphenoTeX,"  TVO4lVLR= & "<> StringReplace["-(coup1L coup2R IMP2)",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {TVO4lVLR,-(coup1L*coup2R*IMP2)} " ];
	 	 WriteStringFLB[file,"  TVO4lTLL=TVO4lTLL+ 0.\n" ];
	 	 WriteString[sphenoTeX,"  TVO4lTLL= & "<> StringReplace["0",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {TVO4lTLL,0} " ];
	 	 WriteStringFLB[file,"  TVO4lTLR=TVO4lTLR+ 0.\n" ];
	 	 WriteString[sphenoTeX,"  TVO4lTLR= & "<> StringReplace["0",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {TVO4lTLR,0} " ];
	 	 WriteStringFLB[file,"  TVO4lTRL=TVO4lTRL+ 0.\n" ];
	 	 WriteString[sphenoTeX,"  TVO4lTRL= & "<> StringReplace["0",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {TVO4lTRL,0} " ];
	 	 WriteStringFLB[file,"  TVO4lTRR=TVO4lTRR+ 0.\n" ];
	 	 WriteString[sphenoTeX,"  TVO4lTRR= & "<> StringReplace["0",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {TVO4lTRR,0} " ];
,
  2, 
	 	 WriteStringFLB[file,"  TVO4lSLL=TVO4lSLL+ 0.\n" ];
	 	 WriteString[sphenoTeX,"  TVO4lSLL= & "<> StringReplace["0",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {TVO4lSLL,0}, " ];
	 	 WriteStringFLB[file,"  TVO4lSRR=TVO4lSRR+ 0.\n" ];
	 	 WriteString[sphenoTeX,"  TVO4lSRR= & "<> StringReplace["0",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {TVO4lSRR,0}, " ];
	 	 WriteStringFLB[file,"  TVO4lSRL=TVO4lSRL+ -2.*coup1L*coup2L*IMP2\n" ];
	 	 WriteString[sphenoTeX,"  TVO4lSRL= & "<> StringReplace["-2 coup1L coup2L IMP2",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {TVO4lSRL,-2*coup1L*coup2L*IMP2}, " ];
	 	 WriteStringFLB[file,"  TVO4lSLR=TVO4lSLR+ -2.*coup1R*coup2R*IMP2\n" ];
	 	 WriteString[sphenoTeX,"  TVO4lSLR= & "<> StringReplace["-2 coup1R coup2R IMP2",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {TVO4lSLR,-2*coup1R*coup2R*IMP2} " ];
	 	 WriteStringFLB[file,"  TVO4lVRR=TVO4lVRR+ 0.\n" ];
	 	 WriteString[sphenoTeX,"  TVO4lVRR= & "<> StringReplace["0",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {TVO4lVRR,0} " ];
	 	 WriteStringFLB[file,"  TVO4lVLL=TVO4lVLL+ 0.\n" ];
	 	 WriteString[sphenoTeX,"  TVO4lVLL= & "<> StringReplace["0",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {TVO4lVLL,0} " ];
	 	 WriteStringFLB[file,"  TVO4lVRL=TVO4lVRL+ -1.*coup1L*coup2R*IMP2\n" ];
	 	 WriteString[sphenoTeX,"  TVO4lVRL= & "<> StringReplace["-(coup1L coup2R IMP2)",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {TVO4lVRL,-(coup1L*coup2R*IMP2)} " ];
	 	 WriteStringFLB[file,"  TVO4lVLR=TVO4lVLR+ -1.*coup1R*coup2L*IMP2\n" ];
	 	 WriteString[sphenoTeX,"  TVO4lVLR= & "<> StringReplace["-(coup1R coup2L IMP2)",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {TVO4lVLR,-(coup1R*coup2L*IMP2)} " ];
	 	 WriteStringFLB[file,"  TVO4lTLL=TVO4lTLL+ 0.\n" ];
	 	 WriteString[sphenoTeX,"  TVO4lTLL= & "<> StringReplace["0",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {TVO4lTLL,0} " ];
	 	 WriteStringFLB[file,"  TVO4lTLR=TVO4lTLR+ 0.\n" ];
	 	 WriteString[sphenoTeX,"  TVO4lTLR= & "<> StringReplace["0",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {TVO4lTLR,0} " ];
	 	 WriteStringFLB[file,"  TVO4lTRL=TVO4lTRL+ 0.\n" ];
	 	 WriteString[sphenoTeX,"  TVO4lTRL= & "<> StringReplace["0",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {TVO4lTRL,0} " ];
	 	 WriteStringFLB[file,"  TVO4lTRR=TVO4lTRR+ 0.\n" ];
	 	 WriteString[sphenoTeX,"  TVO4lTRR= & "<> StringReplace["0",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {TVO4lTRR,0} " ];
,
  3, 
	 	 WriteStringFLB[file,"  TVO4lSLL=TVO4lSLL+ 0.\n" ];
	 	 WriteString[sphenoTeX,"  TVO4lSLL= & "<> StringReplace["0",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {TVO4lSLL,0}, " ];
	 	 WriteStringFLB[file,"  TVO4lSRR=TVO4lSRR+ 0.\n" ];
	 	 WriteString[sphenoTeX,"  TVO4lSRR= & "<> StringReplace["0",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {TVO4lSRR,0}, " ];
	 	 WriteStringFLB[file,"  TVO4lSRL=TVO4lSRL+ 2.*coup1R*coup2L*IMP2\n" ];
	 	 WriteString[sphenoTeX,"  TVO4lSRL= & "<> StringReplace["2 coup1R coup2L IMP2",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {TVO4lSRL,2*coup1R*coup2L*IMP2}, " ];
	 	 WriteStringFLB[file,"  TVO4lSLR=TVO4lSLR+ 2.*coup1L*coup2R*IMP2\n" ];
	 	 WriteString[sphenoTeX,"  TVO4lSLR= & "<> StringReplace["2 coup1L coup2R IMP2",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {TVO4lSLR,2*coup1L*coup2R*IMP2} " ];
	 	 WriteStringFLB[file,"  TVO4lVRR=TVO4lVRR+ -1.*coup1R*coup2R*IMP2\n" ];
	 	 WriteString[sphenoTeX,"  TVO4lVRR= & "<> StringReplace["-(coup1R coup2R IMP2)",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {TVO4lVRR,-(coup1R*coup2R*IMP2)} " ];
	 	 WriteStringFLB[file,"  TVO4lVLL=TVO4lVLL+ -1.*coup1L*coup2L*IMP2\n" ];
	 	 WriteString[sphenoTeX,"  TVO4lVLL= & "<> StringReplace["-(coup1L coup2L IMP2)",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {TVO4lVLL,-(coup1L*coup2L*IMP2)} " ];
	 	 WriteStringFLB[file,"  TVO4lVRL=TVO4lVRL+ 0.\n" ];
	 	 WriteString[sphenoTeX,"  TVO4lVRL= & "<> StringReplace["0",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {TVO4lVRL,0} " ];
	 	 WriteStringFLB[file,"  TVO4lVLR=TVO4lVLR+ 0.\n" ];
	 	 WriteString[sphenoTeX,"  TVO4lVLR= & "<> StringReplace["0",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {TVO4lVLR,0} " ];
	 	 WriteStringFLB[file,"  TVO4lTLL=TVO4lTLL+ 0.\n" ];
	 	 WriteString[sphenoTeX,"  TVO4lTLL= & "<> StringReplace["0",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {TVO4lTLL,0} " ];
	 	 WriteStringFLB[file,"  TVO4lTLR=TVO4lTLR+ 0.\n" ];
	 	 WriteString[sphenoTeX,"  TVO4lTLR= & "<> StringReplace["0",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {TVO4lTLR,0} " ];
	 	 WriteStringFLB[file,"  TVO4lTRL=TVO4lTRL+ 0.\n" ];
	 	 WriteString[sphenoTeX,"  TVO4lTRL= & "<> StringReplace["0",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {TVO4lTRL,0} " ];
	 	 WriteStringFLB[file,"  TVO4lTRR=TVO4lTRR+ 0.\n" ];
	 	 WriteString[sphenoTeX,"  TVO4lTRR= & "<> StringReplace["0",SA`SPhenoTeXSub]<>" \\\\ \n" ];
	 	 WriteString[FKout,"  {TVO4lTRR,0} " ];
];,
S, (* Scalar penguins *) 
Return[]; (* not necessary *) ]; 
]; 


