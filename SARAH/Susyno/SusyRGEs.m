(* ::Package:: *)

(************************************************************************)
(* This file was generated automatically by the Mathematica front end.  *)
(* It contains Initialization cells from a Notebook file, which         *)
(* typically will have the same name as this file except ending in      *)
(* ".nb" instead of ".m".                                               *)
(*                                                                      *)
(* This file is intended to be loaded into the Mathematica kernel using *)
(* the package loading commands Get or Needs.  Doing so is equivalent   *)
(* to using the Evaluate Initialization Cells menu command in the front *)
(* end.                                                                 *)
(*                                                                      *)
(* DO NOT EDIT THIS FILE.  This entire file is regenerated              *)
(* automatically each time the parent Notebook file is saved in the     *)
(* Mathematica front end.  Any changes you make to this file will be    *)
(* overwritten.                                                         *)
(************************************************************************)



BeginPackage["Susyno`SusyRGEs`"];

ImportData::usage = 
"Syntax: ImportData[y,\[Mu],L,h,b,s,m2,numberFlavs,dR,cR,sR,cG,numberNonU1groups,repMatrices]
Description: This is an internal initialization method."
CanonicalForm::usage ="Syntax: CanonicalForm[<expr>, <indices>(optional)]
Example: CanonicalForm[T[i,j]T[i,j]+T[k,i]T[k,i],{i,j,k,l,m,n,o,p}]
Description: Simplifies expressions in the Einstein convention. A list containing the indices used must be given (extra indices are ok ... see example above). Otherwise, they are assumed to be \[Alpha][1],\[Alpha][2],..."
ListContract::usage ="Sintax: ListContract[<list>,<positions>]
Example: A and B are two 3D tensors with apropriate dimentions. Suppose we want Aijk Bkij.  A.B contracts the k index so that ListContract[A.B,{{1,3},{2,4}}] will do the rest of the math (contracts the remaining 4 indices: the 1st with the 3rd and the 2nd with the 4th);
Description: This method efficiently contracts indices of tensors. list=tensor to contract; positions=list with pairs {index1,index2} to contract."

\[Beta]g1::usage ="Internal method"
\[Beta]g2::usage ="Internal method"
\[Beta]M1::usage ="Internal method"
\[Beta]M2::usage = "Internal method"
\[Beta]Y1::usage = "Internal method"
\[Beta]Y2::usage =  "Internal method"
\[Beta]\[Mu]1::usage = "Internal method"
\[Beta]\[Mu]2::usage =   "Internal method"
\[Beta]L1::usage =  "Internal method"
\[Beta]L2::usage = "Internal method"
\[Beta]H1::usage =  "Internal method"
\[Beta]H2::usage =  "Internal method"
\[Beta]B1::usage =  "Internal method"
\[Beta]B2::usage = "Internal method"
\[Beta]2M1::usage =  "Internal method"
\[Beta]2M2::usage  "Internal method"
\[Beta]S1::usage  "Internal method"
\[Beta]S2::usage  "Internal method"



g::usage::"The program uses this variable"
M::usage::"The program uses this variable"
\[Alpha]::usage::"The program uses this variable"
f1::usage::"The program uses this variable"
f2::usage::"The program uses this variable"
f3::usage::"The program uses this variable"

Begin["`Private`"]



(* XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX *)
flavVariables={f1,f2,f3}

(* Initialization method. After using this method, one can use the methods \[Beta]g1, \[Beta]g2, etc *)
ImportData[{y_, \[Mu]_, l_, h_, b_,s_, m2_, numberFlavours_, dRv_, cRv_, sRv_, cGv_, numberNonU1groups_, fullRepMatrices_}] := (
  
  oYMat = y;
  o\[Mu]Mat = \[Mu];
  oLMat = l;
  oHMat = h;
  oBMat = b;
  oM2Mat = m2;
oSMat=s;
  flavMat = numberFlavours;
  dRMat = dRv;
  cRMat = cRv;
  sRMat = sRv;
  cGMat = cGv;
  fullRepMat = fullRepMatrices;
  
  
  totalF = Length[oLMat];
  totalS = Length[fullRepMat];
totalSNU = numberNonU1groups;
totalSU=totalS-totalSNU;
 (* flavVariables = flavVar; *)
  
  
  Clear[oY, o\[Mu], oL, oH, oB, oM2, oS,oM2T, DMatrixCR, DMatrixSR];
  
(*Methods that give flavour to the tensors*)   
  oY[i_, j_, k_] := oY[i, j, k] = SparseArray[(oYMat // ArrayRules) /. {flavVariables[[1]] -> i, flavVariables[[2]] -> j, flavVariables[[3]] -> k}, {totalF, totalF, totalF}];
  o\[Mu][i_, j_] := o\[Mu][i, j] = SparseArray[(o\[Mu]Mat // ArrayRules) /. {flavVariables[[1]] -> i, flavVariables[[2]] -> j}, {totalF, totalF}];
  oL[i_] := oL[i] = SparseArray[(oLMat // ArrayRules) /. {flavVariables[[1]] -> i}, {totalF}];
  oH[i_, j_, k_] := oH[i, j, k] = SparseArray[(oHMat // ArrayRules) /. {flavVariables[[1]] -> i, flavVariables[[2]] -> j, flavVariables[[3]] -> k}, {totalF, totalF, totalF}];
  oB[i_, j_] := oB[i, j] = SparseArray[(oBMat // ArrayRules) /. {flavVariables[[1]] -> i, flavVariables[[2]] -> j}, {totalF, totalF}];
  oM2[i_, j_] := oM2[i, j] = SparseArray[(oM2Mat // ArrayRules) /. {flavVariables[[1]] -> i, flavVariables[[2]] -> j}, {totalF, totalF}];
  oM2T[i_, j_] := oM2T[i, j] = Transpose[oM2[j, i]];
oS[i_] := oS[i] = SparseArray[(oSMat // ArrayRules) /. {flavVariables[[1]] -> i}, {totalF}];
  
  DMatrixCR[ll_] := DMatrixCR[ll] = SparseArray[DiagonalMatrix[Table[cR[k, ll], {k,totalF}]]];
  DMatrixSR[ll_] := MatrixSR[ll] = SparseArray[DiagonalMatrix[Table[sR[k, ll], {k, totalF}]]];
  
  )

(* XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX *)


(* This method efficiently contracts indices of tensors. list=tensor to contract; positions=list with pairs {index1,index2} to contract;
E.g. : Aijk Bkij . A.B contracts the k index. So ListContract[A.B,{{1,3},{2,4}}] contracts the remaining 4 indices: the 1st with the 3rd and the 2nd with the 4th. *)

ListContract[list_, positions_] := Module[{n, n2, aux1, aux2, aux3, aux1Inv, i},
  n = Length[Dimensions[list]];
  n2 = Length[positions];
  aux1 = Flatten[positions];
  aux2 = Table[i, {i, n}];
  aux1 = Join[aux1, Complement[aux2, aux1]];
  
  (* Inverting the permutation aux1: if n is in posicao i, the inverse permutation has i in position n *)
  aux1Inv = 0 aux1;
  Do[
   aux1Inv[[aux1[[i]]]] = i;
   , {i, Length[aux1]}];
  (* /Inverting the permutation aux1: if n is in posicao i, the inverse permutation has i in position n *)
  
  aux3 = Transpose[list, aux1Inv];
  
  Do[
   aux3 = Tr[aux3, Plus, 2];
   , {i, n2}];
  
  Return[aux3];
  ]


(* XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX *)
(* FreeIndices and CanonicalForm are required in order to simply expressions in the Einstein convention *)

FreeIndices[x__] := Module[{res},
  res = {};
  Do[
   If[Count[x, \[Alpha][i], Infinity] == 1, res = Append[res, \[Alpha][i]];, Null];
   , {i, 20}];
  Return[res];]

(* XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX *)
(* FreeIndices and CanonicalForm are required in order to simply expressions in the Einstein convention *)

CanonicalForm[x_,indicesInX_List:{}] := Module[{substitution,result, indicesL, indicesNL, indicesT, indicesStandard, rules},
 
 substitution=Table[indicesInX[[counterI]]->\[Alpha][counterI],{counterI,Length[indicesInX]}];
result = MonomialList[x ]/.substitution/.{Power[y_,n_]:>If[NumericQ[y],Power[y,n],SpP@@Table[y,{ii,n}]]}  ; 

indicesL = FreeIndices[result[[1]]] ;
  Do[   
   indicesT = DeleteDuplicates[Cases[result[[counterJ]], \[Alpha][_] ,\[Infinity]]];
indicesNL=indicesT;
Do[
   indicesNL = DeleteCases[indicesNL, indicesL[[counterI]]];
,{counterI,Length[indicesL]}];
   indicesStandard = Take[Complement[Table[\[Alpha][counterI], {counterI, Length[indicesT]}], indicesL], Length[indicesNL]];

    rules = MapThread[Rule, {indicesNL, indicesStandard}];     
   
   result[[counterJ]] =result[[counterJ]] /. rules;

(*Second pass*)
   indicesT = DeleteDuplicates[Cases[result[[counterJ]], \[Alpha][_] ,\[Infinity]]];
indicesNL=indicesT;
Do[
   indicesNL = DeleteCases[indicesNL, indicesL[[counterI]]];
,{counterI,Length[indicesL]}];
  (*indicesStandard = Take[Complement[Table[\[Alpha][counterI], {counterI, Length[indicesT]}], indicesL], Length[indicesNL]]; *) (*Always the same?*)

    rules = MapThread[Rule, {indicesNL, indicesStandard}];     
   
   result[[counterJ]] =result[[counterJ]] /. rules;

   , {counterJ, Length[result]}];



 substitution=Table[\[Alpha][counterI]->indicesInX[[counterI]],{counterI,Length[indicesInX]}];
  result = Apply[Plus, result] /.substitution/.SpP->Times ;

  Return[result];]


(* XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX *)


Cj[x_] := Conjugate[x];


cG[l_] := cGMat[[l]];
dG[l_] := Length[fullRepMat[[l]]];

flav[i_] := flavMat[[i]];
dR[i_, l_] := dRMat[[i, l]]

cR[i_, l_] := cRMat[[i, l]];
sR[i_, l_] := sRMat[[i, l]];


Sym[f_, x1_, x2_] := f[x1, x2] + (f[x2, x1] /. {\[Alpha][1] -> \[Alpha][2], \[Alpha][2] -> \[Alpha][1]})
Sym[f_, x1_, x2_, x3_] := f[x1, x2, x3] + (f[x3, x2, x1] /. {\[Alpha][1] -> \[Alpha][3], \[Alpha][3] -> \[Alpha][1]}) + (f[x1, x3, x2] /. {\[Alpha][2] -> \[Alpha][3], \[Alpha][3] -> \[Alpha][2]})



(* XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX \[Beta]g XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX *)

\[Beta]g1[l2_] := Module[{l}, l = l2; Return[CanonicalForm[g[l]^3  (Sum[sR[i, l] flav[i]/dR[i, l], {i, totalF}] - 3 cG[l])]];]
\[Beta]g2[l2_] := Module[{l}, l = l2; Return[CanonicalForm[-6 cG[l]^2 g[l]^5 + 2 cG[l] Sum[sR[i, l] flav[i]/dR[i, l], {i, totalF}] g[l]^5 + 4  g[l]^3 Sum[g[j]^2 sR[i, l] flav[i] cR[i, j]/ dR[i, l], {i, totalF}, {j, totalS}] - g[l]^3  ListContract[oY[\[Alpha][1], \[Alpha][2], \[Alpha][3]].(Cj[oY[\[Alpha][3], \[Alpha][2], \[Alpha][1]]].DMatrixCR[l]), {{1, 4}, {2, 3}}]/dG[l]]];]

(* XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX \[Beta]M XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX *)

\[Beta]M1[l2_] := Module[{l}, l = l2; Return[CanonicalForm[g[l]^2  (2 Sum[sR[i, l] flav[i]/dR[i, l], {i, totalF}] - 6 cG[l]) M[l]]];]
\[Beta]M2[l2_] := Module[{l}, l = l2; Return[CanonicalForm[M[l] (-24 cG[l]^2 g[l]^4 + 8 cG[l] Sum[sR[i, l] flav[i]/dR[i, l], {i, totalF}] g[l]^4) + 8 g[l]^2 Sum[g[j]^2 (M[l] + M[j]) sR[i, l] flav[i] cR[i, j]/ dR[i, l], {i, totalF}, {j, totalS}] + 2 g[l]^2  ListContract[(oH[\[Alpha][1], \[Alpha][2], \[Alpha][3]] - M[l] oY[\[Alpha][1], \[Alpha][2], \[Alpha][3]]).(Cj[oY[\[Alpha][3], \[Alpha][2], \[Alpha][1]]].DMatrixCR[l]), {{1, 4}, {2, 3}}]/dG[l]]];]


(* XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX \[Beta]y XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX *)

fuctY1Q1[i1_, j1_, k1_] := Tr[(oY[\[Alpha][1], \[Alpha][2], \[Alpha][4]][[i1, j1]].Cj[oY[\[Alpha][4], \[Alpha][5], \[Alpha][6]]]).oY[\[Alpha][3], \[Alpha][6], \[Alpha][5]][[k1]]];
fuctY1Q2[i_, j_, k_] := oY[\[Alpha][1], \[Alpha][2], \[Alpha][3]][[i, j, k]] Sum[g[l]^2 cR[k, l], {l, totalS}];


fuctY2Q1[i_, j_, k_] := -1/2 ListContract[(oY[\[Alpha][1], \[Alpha][2], \[Alpha][4]][[i, j]].Cj[oY[\[Alpha][4], \[Alpha][5], \[Alpha][6]]].oY[\[Alpha][6], \[Alpha][7], \[Alpha][8]]).(Cj[oY[\[Alpha][8], \[Alpha][7], \[Alpha][10]]].oY[\[Alpha][3], \[Alpha][10], \[Alpha][5]][[k]]), {{1, 4}, {2, 3}}] + 2 Tr[oY[\[Alpha][1], \[Alpha][2], \[Alpha][4]][[i, j]].Cj[oY[\[Alpha][4], \[Alpha][5], \[Alpha][6]]].((Sum[g[l]^2 DMatrixCR[l], {l, 1, totalS}]).oY[\[Alpha][3], \[Alpha][6], \[Alpha][5]][[k]])] - Tr[(oY[\[Alpha][1], \[Alpha][2], \[Alpha][4]][[i, j]].(Sum[g[l]^2 DMatrixCR[l], {l, totalS}])).(Cj[oY[\[Alpha][4], \[Alpha][5], \[Alpha][6]]].oY[\[Alpha][3], \[Alpha][6], \[Alpha][5]][[k]])];
fuctY2Q2[i_, j_, k_] := 2 oY[\[Alpha][1], \[Alpha][2], \[Alpha][3]][[i, j, k]] (Sum[g[l]^4 cR[k, l] flav[i2] sR[i2, l]/dR[i2, l], {l, totalS}, {i2, totalF}]+ 2 Sum[g[l1]^2 g[l2]^2  cR[k, l1] cR[k, l2], {l1, totalS}, {l2, totalS}]- 3 Sum[g[l]^4 cG[l] cR[k, l], {l, totalS}]);

\[Beta]Y1[i_, j_, k_] := CanonicalForm[1/2 Sym[fuctY1Q1, i, j, k] - 2 Sym[fuctY1Q2, i, j, k]]  /.{\[Alpha][1]->flavVariables[[1]],\[Alpha][2]->flavVariables[[2]],\[Alpha][3]->flavVariables[[3]]} 
\[Beta]Y2[i_, j_, k_] := CanonicalForm[ Sym[fuctY2Q1, i, j, k] + Sym[fuctY2Q2, i, j, k]]/.{\[Alpha][1]->flavVariables[[1]],\[Alpha][2]->flavVariables[[2]],\[Alpha][3]->flavVariables[[3]]}



(* XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX \[Beta]\[Mu] XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX *)



fuct\[Mu]1Q1[i_, j_] := Tr[(o\[Mu][\[Alpha][1], \[Alpha][3]][[i]].Cj[oY[\[Alpha][3], \[Alpha][4], \[Alpha][5]]]).oY[\[Alpha][2], \[Alpha][5], \[Alpha][4]][[j]]];
fuct\[Mu]1Q2[i_, j_] := o\[Mu][\[Alpha][1], \[Alpha][2]][[i, j]] Sum[g[l]^2 cR[j, l], {l, totalS}];


fuct\[Mu]2Q1[i_, j_] := -1/2 ListContract[(o\[Mu][\[Alpha][1], \[Alpha][4]][[i]].Cj[oY[\[Alpha][4], \[Alpha][5], \[Alpha][6]]].oY[\[Alpha][6], \[Alpha][7], \[Alpha][8]]).(Cj[oY[\[Alpha][8], \[Alpha][7], \[Alpha][10]]].oY[\[Alpha][2], \[Alpha][10], \[Alpha][5]][[j]]), {{1, 4}, {2, 3}}] + 2 Tr[o\[Mu][\[Alpha][1], \[Alpha][3]][[i]].Cj[oY[\[Alpha][3], \[Alpha][4], \[Alpha][5]]].((Sum[g[l]^2 DMatrixCR[l], {l, totalS}]).oY[\[Alpha][2], \[Alpha][5], \[Alpha][4]][[j]])] -  Tr[(o\[Mu][\[Alpha][1], \[Alpha][3]][[i]].(Sum[g[l]^2 DMatrixCR[l], {l, totalS}])).(Cj[oY[\[Alpha][3], \[Alpha][4], \[Alpha][5]]].oY[\[Alpha][2], \[Alpha][5], \[Alpha][4]][[j]])];
fuct\[Mu]2Q2[i_, j_] := 2 o\[Mu][\[Alpha][1], \[Alpha][2]][[i, j]] (Sum[g[l]^4 cR[j, l] flav[i2] sR[i2, l]/dR[i2, l], {l, totalS}, {i2, totalF}]+ 2 Sum[g[l1]^2 g[l2]^2  cR[j, l1] cR[j, l2], {l1, totalS}, {l2, totalS}]- 3 Sum[g[l]^4 cG[l] cR[j, l], {l, totalS}]);

\[Beta]\[Mu]1[i_, j_] := CanonicalForm[1/2 Sym[fuct\[Mu]1Q1, i, j] - 2 Sym[fuct\[Mu]1Q2, i, j]]/.{\[Alpha][1]->flavVariables[[1]],\[Alpha][2]->flavVariables[[2]]}
\[Beta]\[Mu]2[i_, j_] := CanonicalForm[Sym[fuct\[Mu]2Q1, i, j] + Sym[fuct\[Mu]2Q2, i, j]]/.{\[Alpha][1]->flavVariables[[1]],\[Alpha][2]->flavVariables[[2]]}


(* XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX \[Beta]L XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX *)

fuctL1Q1[i_] := Tr[(oL[\[Alpha][2]].Cj[oY[\[Alpha][2], \[Alpha][3], \[Alpha][4]]]).oY[\[Alpha][1], \[Alpha][4], \[Alpha][3]][[i]]];
fuctL1Q2[i_] := oL[\[Alpha][1]][[i]] Sum[g[l]^2 cR[i, l], {l, 1, totalS}];


fuctL2Q1[i_] := -1/2 ListContract[(oL[\[Alpha][2]].Cj[oY[\[Alpha][2], \[Alpha][3], \[Alpha][4]]].oY[\[Alpha][4], \[Alpha][5], \[Alpha][6]]).(Cj[oY[\[Alpha][6], \[Alpha][5], \[Alpha][8]]].oY[\[Alpha][1], \[Alpha][8], \[Alpha][3]][[i]]), {{1, 4}, {2, 3}}] + 2 Tr[oL[\[Alpha][2]].Cj[oY[\[Alpha][2], \[Alpha][3], \[Alpha][4]]].((Sum[g[l]^2 DMatrixCR[l], {l, totalS}]).oY[\[Alpha][1], \[Alpha][4], \[Alpha][3]][[i]])] -  Tr[(oL[\[Alpha][2]].(Sum[g[l]^2 DMatrixCR[l], {l, totalS}])).(Cj[oY[\[Alpha][2], \[Alpha][3], \[Alpha][4]]].oY[\[Alpha][1], \[Alpha][4], \[Alpha][3]][[i]])];
fuctL2Q2[i_] := 2 oL[\[Alpha][1]][[i]] (Sum[g[l]^4 cR[i, l] flav[i2] sR[i2, l]/dR[i2, l], {l, totalS}, {i2, totalF}]+ 2 Sum[g[l1]^2 g[l2]^2  cR[i, l1] cR[i, l2], {l1, totalS}, {l2, totalS}]- 3 Sum[g[l]^4 cG[l] cR[i, l], {l, totalS}]);

\[Beta]L1[i_] := CanonicalForm[1/2 fuctL1Q1[i] - 2 fuctL1Q2[i]]/.{\[Alpha][1]->flavVariables[[1]]}
\[Beta]L2[i_] := CanonicalForm[fuctL2Q1[i] + fuctL2Q2[i]]/.{\[Alpha][1]->flavVariables[[1]]}


(* XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX \[Beta]H XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX *)

fuctH1Q1[i_, j_, k_] := 1/2 Tr[(oH[\[Alpha][1], \[Alpha][2], \[Alpha][4]][[i, j]].Cj[oY[\[Alpha][4], \[Alpha][5], \[Alpha][6]]]).oY[\[Alpha][3], \[Alpha][6], \[Alpha][5]][[k]]];
fuctH1Q2[i_, j_, k_] := Tr[(oY[\[Alpha][1], \[Alpha][2], \[Alpha][4]][[i, j]].Cj[oY[\[Alpha][4], \[Alpha][5], \[Alpha][6]]]).oH[\[Alpha][3], \[Alpha][6], \[Alpha][5]][[k]]];
fuctH1Q3[i_, j_, k_] := -2 Sum[g[l]^2 (oH[\[Alpha][1], \[Alpha][2], \[Alpha][3]][[i, j, k]] - 2 M[l] oY[\[Alpha][1], \[Alpha][2], \[Alpha][3]][[i, j, k]]) cR[k, l], {l, totalS}];

fuctH2Q1[i_, j_, k_] := -1/2 ListContract[(oH[\[Alpha][1], \[Alpha][2], \[Alpha][4]] [[i, j]].Cj[oY[\[Alpha][4], \[Alpha][5], \[Alpha][6]]].oY[\[Alpha][6], \[Alpha][7], \[Alpha][8]]).(Cj[oY[\[Alpha][8], \[Alpha][7], \[Alpha][10]]].oY[\[Alpha][3], \[Alpha][10], \[Alpha][5]][[k]]), {{1, 4}, {2, 3}}]
fuctH2Q2[i_, j_, k_] := -ListContract[(oY[\[Alpha][1], \[Alpha][2], \[Alpha][4]] [[i, j]].Cj[oY[\[Alpha][4], \[Alpha][5], \[Alpha][6]]].oY[\[Alpha][6], \[Alpha][7], \[Alpha][8]]).(Cj[oY[\[Alpha][8], \[Alpha][7], \[Alpha][10]]].oH[\[Alpha][3], \[Alpha][10], \[Alpha][5]][[k]]), {{1, 4}, {2, 3}}]
fuctH2Q3[i_, j_, k_] := -ListContract[(oY[\[Alpha][1], \[Alpha][2], \[Alpha][4]] [[i, j]].Cj[oY[\[Alpha][4], \[Alpha][5], \[Alpha][6]]].oH[\[Alpha][6], \[Alpha][7], \[Alpha][8]]).(Cj[oY[\[Alpha][8], \[Alpha][7], \[Alpha][10]]].oY[\[Alpha][3], \[Alpha][10], \[Alpha][5]][[k]]), {{1, 4}, {2, 3}}]
fuctH2Q4[i_, j_, k_] := Tr[(oH[\[Alpha][1], \[Alpha][2], \[Alpha][4]][[i, j]].Cj[oY[\[Alpha][4], \[Alpha][5], \[Alpha][6]]]).(Sum[2 g[l]^2 DMatrixCR[l], {l, totalS}].oY[\[Alpha][3], \[Alpha][6], \[Alpha][5]][[k]])] - Sum[g[l]^2 cR[k, l], {l, totalS}] Tr[(oH[\[Alpha][1], \[Alpha][2], \[Alpha][4]][[i, j]].Cj[oY[\[Alpha][4], \[Alpha][5], \[Alpha][6]]]).oY[\[Alpha][3], \[Alpha][6], \[Alpha][5]][[k]]]
fuctH2Q5[i_, j_, k_] := 2 (Tr[(oY[\[Alpha][1], \[Alpha][2], \[Alpha][4]][[i, j]].Cj[oY[\[Alpha][4], \[Alpha][5], \[Alpha][6]]]).(Sum[2 g[l]^2 DMatrixCR[l], {l, totalS}].oH[\[Alpha][3], \[Alpha][6], \[Alpha][5]][[k]])] - Sum[ g[l]^2 cR[k, l], {l, totalS}] Tr[(oY[\[Alpha][1], \[Alpha][2], \[Alpha][4]][[i, j]].Cj[oY[\[Alpha][4], \[Alpha][5], \[Alpha][6]]]).oH[\[Alpha][3], \[Alpha][6], \[Alpha][5]][[k]]])
fuctH2Q6[i_, j_, k_] := -2 (Tr[(oY[\[Alpha][1], \[Alpha][2], \[Alpha][4]][[i, j]].Cj[oY[\[Alpha][4], \[Alpha][5], \[Alpha][6]]]).(Sum[2 g[l]^2 M[l] DMatrixCR[l], {l, totalS}].oY[\[Alpha][3], \[Alpha][6], \[Alpha][5]][[k]])] - Sum[ g[l]^2  M[l] cR[k, l], {l, totalS}] Tr[(oY[\[Alpha][1], \[Alpha][2], \[Alpha][4]][[i, j]].Cj[oY[\[Alpha][4], \[Alpha][5], \[Alpha][6]]]).oY[\[Alpha][3], \[Alpha][6], \[Alpha][5]][[k]]])
fuctH2Q7[i_, j_, k_] := (aux1 = oH[\[Alpha][1], \[Alpha][2], \[Alpha][3]][[i, j, k]]; aux2 = oY[\[Alpha][1], \[Alpha][2], \[Alpha][3]][[i, j, k]]; Return[Sum[(2 aux1 - 8 M[l] aux2) g[l]^4 cR[k, l] flav[i2] sR[i2, l]/dR[i2, l], {l, totalS}, {i2, totalF}] +  2 Sum[(2 aux1 - 8 M[l1] aux2) g[l1]^2 g[l2]^2  cR[k, l1] cR[k, l2], {l1, totalS}, {l2, totalS}] - 3 Sum[(2 aux1 - 8 M[l] aux2) g[l]^4 cG[l] cR[k, l], {l, totalS}]];)


\[Beta]H1[i_, j_, k_] := CanonicalForm[ Sym[fuctH1Q1, i, j, k] + Sym[fuctH1Q2, i, j, k] + Sym[fuctH1Q3, i, j, k]]/.{\[Alpha][1]->flavVariables[[1]],\[Alpha][2]->flavVariables[[2]],\[Alpha][3]->flavVariables[[3]]}
\[Beta]H2[i_, j_, k_] := CanonicalForm[ Sym[fuctH2Q1, i, j, k] + Sym[fuctH2Q2, i, j, k] + Sym[fuctH2Q3, i, j, k] + Sym[fuctH2Q4, i, j, k] + Sym[fuctH2Q5, i, j, k] +  Sym[fuctH2Q6, i, j, k] + Sym[fuctH2Q7, i, j, k]]/.{\[Alpha][1]->flavVariables[[1]],\[Alpha][2]->flavVariables[[2]],\[Alpha][3]->flavVariables[[3]]}



(* XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX \[Beta]B XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX *)
fuctB1Q1[i_, j_] := 1/2 Tr[(oB[\[Alpha][1], \[Alpha][3]][[i]].Cj[oY[\[Alpha][3], \[Alpha][4], \[Alpha][5]]]).oY[\[Alpha][2], \[Alpha][5], \[Alpha][4]][[j]]];
fuctB1Q2[i_, j_] := 1/2 Tr[(oY[\[Alpha][1], \[Alpha][2], \[Alpha][3]][[i, j]].Cj[oY[\[Alpha][3], \[Alpha][4], \[Alpha][5]]]).oB[\[Alpha][5], \[Alpha][4]]];
fuctB1Q3[i_, j_] := Tr[(o\[Mu][\[Alpha][1], \[Alpha][3]][[i]].Cj[oY[\[Alpha][3], \[Alpha][4], \[Alpha][5]]]).oH[\[Alpha][2], \[Alpha][5], \[Alpha][4]][[j]]];
fuctB1Q4[i_, j_] := -2 Sum[(oB[\[Alpha][1], \[Alpha][2]][[i, j]] - 2 M[l] o\[Mu][\[Alpha][1], \[Alpha][2]][[i, j]]) g[l]^2 cR[i, l], {l, totalS}];


fuctB2Q1[i_, j_] := -1/2 ListContract[(oB[\[Alpha][1], \[Alpha][3]][[i]].Cj[oY[\[Alpha][3], \[Alpha][4], \[Alpha][5]]].oY[\[Alpha][5], \[Alpha][6], \[Alpha][7]]).(Cj[oY[\[Alpha][7], \[Alpha][6], \[Alpha][9]]].oY[\[Alpha][2], \[Alpha][9], \[Alpha][4]][[j]]), {{1, 4}, {2, 3}}]
fuctB2Q2[i_, j_] := -1/2 ListContract[(oY[\[Alpha][1], \[Alpha][2], \[Alpha][3]][[i, j]].Cj[oY[\[Alpha][3], \[Alpha][4], \[Alpha][5]]]).(oB[\[Alpha][5], \[Alpha][6]].Cj[oY[\[Alpha][6], \[Alpha][7], \[Alpha][8]]].oY[\[Alpha][8], \[Alpha][7], \[Alpha][4]]), {{1, 4}, {2, 3}}]
fuctB2Q3[i_, j_] := -1/2 ListContract[(oY[\[Alpha][1], \[Alpha][2], \[Alpha][3]][[i, j]].Cj[oY[\[Alpha][3], \[Alpha][4], \[Alpha][5]]]).(o\[Mu][\[Alpha][5], \[Alpha][6]].Cj[oY[\[Alpha][6], \[Alpha][7], \[Alpha][8]]].oH[\[Alpha][8], \[Alpha][7], \[Alpha][4]]), {{1, 4}, {2, 3}}]
fuctB2Q4[i_, j_] := -ListContract[(o\[Mu][\[Alpha][1], \[Alpha][3]][[i]].Cj[oY[\[Alpha][3], \[Alpha][4], \[Alpha][5]]].oH[\[Alpha][5], \[Alpha][6], \[Alpha][7]]).(Cj[oY[\[Alpha][7], \[Alpha][6], \[Alpha][9]]].oY[\[Alpha][2], \[Alpha][9], \[Alpha][4]][[j]]), {{1, 4}, {2, 3}}]
fuctB2Q5[i_, j_] := -ListContract[(o\[Mu][\[Alpha][1], \[Alpha][3]][[i]].Cj[oY[\[Alpha][3], \[Alpha][4], \[Alpha][5]]].oY[\[Alpha][5], \[Alpha][6], \[Alpha][7]]).(Cj[oY[\[Alpha][7], \[Alpha][6], \[Alpha][9]]].oH[\[Alpha][2], \[Alpha][9], \[Alpha][4]][[j]]), {{1, 4}, {2, 3}}]
fuctB2Q6[i_, j_] := 2 Tr[(oY[\[Alpha][1], \[Alpha][2], \[Alpha][3]][[i, j]].Cj[oY[\[Alpha][3], \[Alpha][4], \[Alpha][5]]]).Sum[(oB[\[Alpha][5], \[Alpha][4]] - o\[Mu][\[Alpha][5], \[Alpha][4]] M[l]).DMatrixCR[l] g[l]^2, {l, totalS}]];

fuctB2Q7[i_, j_] := Tr[(oB[\[Alpha][1], \[Alpha][3]][[i]].Cj[oY[\[Alpha][3], \[Alpha][4], \[Alpha][5]]]).(Sum[2 g[l]^2 DMatrixCR[l], {l, totalS}].oY[\[Alpha][2], \[Alpha][5], \[Alpha][4]][[j]])] - Sum[ g[l]^2 cR[i, l] Tr[(oB[\[Alpha][1], \[Alpha][3]][[i]].Cj[oY[\[Alpha][3], \[Alpha][4], \[Alpha][5]]]).oY[\[Alpha][2], \[Alpha][5], \[Alpha][4]][[j]]] , {l, totalS}]
fuctB2Q8[i_, j_] := 2 (Tr[(o\[Mu][\[Alpha][1], \[Alpha][3]][[i]].Cj[oY[\[Alpha][3], \[Alpha][4], \[Alpha][5]]]).(Sum[2 g[l]^2 DMatrixCR[l], {l, totalS}].oH[\[Alpha][2], \[Alpha][5], \[Alpha][4]][[j]])] - Sum[ g[l]^2 cR[i, l] Tr[(o\[Mu][\[Alpha][1], \[Alpha][3]][[i]].Cj[oY[\[Alpha][3], \[Alpha][4], \[Alpha][5]]]).oH[\[Alpha][2], \[Alpha][5], \[Alpha][4]][[j]]] , {l, totalS}])
fuctB2Q9[i_, j_] := -2 (Tr[(o\[Mu][\[Alpha][1], \[Alpha][3]][[i]].Cj[oY[\[Alpha][3], \[Alpha][4], \[Alpha][5]]]).(Sum[2 g[l] ^2 M[l] DMatrixCR[l], {l, totalS}].oY[\[Alpha][2], \[Alpha][5], \[Alpha][4]][[j]])] - Sum[ g[l]^2 M[l] cR[i, l] Tr[(o\[Mu][\[Alpha][1], \[Alpha][3]][[i]].Cj[oY[\[Alpha][3], \[Alpha][4], \[Alpha][5]]]).oY[\[Alpha][2], \[Alpha][5], \[Alpha][4]][[j]]] , {l, totalS}])

fuctB2Q10[i_, j_] := Sum[(2 oB[\[Alpha][1], \[Alpha][2]][[i, j]] - 8 M[l] o\[Mu][\[Alpha][1], \[Alpha][2]][[i, j]]) g[l]^4 cR[i, l] flav[i2] sR[i2, l]/dR[i2, l], {l, totalS}, {i2, totalF}] +  2 Sum[(2 oB[\[Alpha][1], \[Alpha][2]][[i, j]] - 8 M[l1] o\[Mu][\[Alpha][1], \[Alpha][2]][[i, j]]) g[l1]^2 g[l2]^2  cR[i, l1] cR[i, l2], {l1, totalS}, {l2, totalS}] - 3 Sum[(2 oB[\[Alpha][1], \[Alpha][2]][[i, j]] - 8 M[l] o\[Mu][\[Alpha][1], \[Alpha][2]][[i, j]]) g[l]^4 cG[l] cR[i, l], {l, totalS}];



\[Beta]B1[i_, j_] := CanonicalForm[Sym[fuctB1Q1, i, j] + Sym[fuctB1Q2, i, j] + Sym[fuctB1Q3, i, j] + Sym[fuctB1Q4, i, j]]/.{\[Alpha][1]->flavVariables[[1]],\[Alpha][2]->flavVariables[[2]]}
\[Beta]B2[i_, j_] := CanonicalForm[Sym[fuctB2Q1, i, j] + Sym[fuctB2Q2, i, j] + Sym[fuctB2Q3, i, j] + Sym[fuctB2Q4, i, j] + Sym[fuctB2Q5, i, j] + Sym[fuctB2Q6, i, j] + Sym[fuctB2Q7, i, j] + Sym[fuctB2Q8, i, j] + Sym[fuctB2Q9, i, j] + Sym[fuctB2Q10, i, j]]/.{\[Alpha][1]->flavVariables[[1]],\[Alpha][2]->flavVariables[[2]]}

(* XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX \[Beta]2M XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX *)

fuct2M1Q1[j_, i_] := 1/2 Tr[Cj[oY[\[Alpha][2], \[Alpha][3], \[Alpha][4]][[i]]].(oY[\[Alpha][4], \[Alpha][3], \[Alpha][6]].oM2[\[Alpha][1], \[Alpha][6]][[j]])];
fuct2M1Q2[j_, i_] := 1/2 Tr[oY[\[Alpha][1], \[Alpha][3], \[Alpha][4]][[j]].(Cj[oY[\[Alpha][4], \[Alpha][3], \[Alpha][6]]].oM2T[\[Alpha][2], \[Alpha][6]][[i]])];
fuct2M1Q3[j_, i_] := 2 Tr[Cj[oY[\[Alpha][2], \[Alpha][3], \[Alpha][4]][[i]]].(oY[\[Alpha][1], \[Alpha][4], \[Alpha][5]][[j]].oM2T[\[Alpha][5], \[Alpha][3]])];

fuct2M1Q4[j_, i_] := Tr[Cj[oH[\[Alpha][2], \[Alpha][3], \[Alpha][4]][[i]]].oH[\[Alpha][1], \[Alpha][4], \[Alpha][3]][[j]]];
fuct2M1Q5[j_, i_] := -8 KroneckerDelta[i, j]KroneckerDelta[\[Alpha][1], \[Alpha][2]] Sum[g[l]^2 Cj[M[l]] M[l] cR[i, l], {l, totalS}];
fuct2M1Q6[j_, i_] := 2 Sum[g[l]^2 fullRepMat[[l, a, j, i]] KroneckerDelta[\[Alpha][1], \[Alpha][2]] Tr[fullRepMat[[l, a]].oM2[\[Alpha][3], \[Alpha][3]]], {l, totalS}, {a,dG[l]}];


fuct2M2Q1[j_, i_] := -1/2 ListContract[(oM2T[\[Alpha][2], \[Alpha][3]][[i]].Cj[oY[\[Alpha][3], \[Alpha][4], \[Alpha][5]]].oY[\[Alpha][5], \[Alpha][6], \[Alpha][7]]).(Cj[oY[\[Alpha][7], \[Alpha][6], \[Alpha][9]]].oY[\[Alpha][1], \[Alpha][9], \[Alpha][4]][[j]]), {{1, 4}, {2, 3}}]
fuct2M2Q2[j_, i_] := -1/2 ListContract[(oM2[\[Alpha][1], \[Alpha][3]] [[j]].oY[\[Alpha][3], \[Alpha][4], \[Alpha][5]].Cj[oY[\[Alpha][5], \[Alpha][6], \[Alpha][7]]]).(oY[\[Alpha][7], \[Alpha][6], \[Alpha][9]].Cj[oY[\[Alpha][2], \[Alpha][9], \[Alpha][4]][[i]]]), {{1, 4}, {2, 3}}]
fuct2M2Q3[j_, i_] := -ListContract[(Cj[oY[\[Alpha][2], \[Alpha][3], \[Alpha][4]][[i]]].oY[\[Alpha][1], \[Alpha][4], \[Alpha][5]][[j]].Cj[oY[\[Alpha][5], \[Alpha][6], \[Alpha][7]]]).(oY[\[Alpha][7], \[Alpha][6], \[Alpha][9]].oM2T[\[Alpha][9], \[Alpha][3]]), {{1, 4}, {2, 3}}]
fuct2M2Q4[j_, i_] := -ListContract[(oY[\[Alpha][1], \[Alpha][3], \[Alpha][4]][[j]].Cj[oY[\[Alpha][2], \[Alpha][4], \[Alpha][5]][[i]]].oY[\[Alpha][5], \[Alpha][6], \[Alpha][7]]).(Cj[oY[\[Alpha][7], \[Alpha][6], \[Alpha][9]]].oM2[\[Alpha][9], \[Alpha][3]]), {{1, 4}, {2, 3}}]
fuct2M2Q5[j_, i_] := -ListContract[(Cj[oY[\[Alpha][2], \[Alpha][3], \[Alpha][4]][[i]]].oY[\[Alpha][4], \[Alpha][5], \[Alpha][6]]).(Cj[oY[\[Alpha][6], \[Alpha][5], \[Alpha][8]]].oY[\[Alpha][1], \[Alpha][8], \[Alpha][9]][[j]].oM2T[\[Alpha][9], \[Alpha][3]]), {{1, 4}, {2, 3}}]
fuct2M2Q6[j_, i_] := -2 ListContract[(Cj[oY[\[Alpha][2], \[Alpha][3], \[Alpha][4]][[i]]].oY[\[Alpha][1], \[Alpha][4], \[Alpha][5]][[j]].Cj[oY[\[Alpha][5], \[Alpha][6], \[Alpha][7]]]).(oY[\[Alpha][7], \[Alpha][3], \[Alpha][9]].oM2T[\[Alpha][9], \[Alpha][6]]), {{1, 3}, {2, 4}}]
fuct2M2Q7[j_, i_] := -ListContract[(oY[\[Alpha][1], \[Alpha][3], \[Alpha][4]][[j]].Cj[oH[\[Alpha][4], \[Alpha][5], \[Alpha][6]]]).(oH[\[Alpha][6], \[Alpha][5], \[Alpha][8]].Cj[oY[\[Alpha][2], \[Alpha][8], \[Alpha][3]][[i]]]), {{1, 4}, {2, 3}}]
fuct2M2Q8[j_, i_] := -ListContract[(oH[\[Alpha][1], \[Alpha][3], \[Alpha][4]][[j]].Cj[oY[\[Alpha][4], \[Alpha][5], \[Alpha][6]]]).(oY[\[Alpha][6], \[Alpha][5], \[Alpha][8]].Cj[oH[\[Alpha][2], \[Alpha][8], \[Alpha][3]][[i]]]), {{1, 4}, {2, 3}}]
fuct2M2Q9[j_, i_] := -ListContract[(oY[\[Alpha][1], \[Alpha][3], \[Alpha][4]][[j]].Cj[oY[\[Alpha][4], \[Alpha][5], \[Alpha][6]]]).(oH[\[Alpha][6], \[Alpha][5], \[Alpha][8]].Cj[oH[\[Alpha][2], \[Alpha][8], \[Alpha][3]][[i]]]), {{1, 4}, {2, 3}}]
fuct2M2Q10[j_, i_] := -ListContract[(oH[\[Alpha][1], \[Alpha][3], \[Alpha][4]][[j]].Cj[oH[\[Alpha][4], \[Alpha][5], \[Alpha][6]]]).(oY[\[Alpha][6], \[Alpha][5], \[Alpha][8]].Cj[oY[\[Alpha][2], \[Alpha][8], \[Alpha][3]][[i]]]), {{1, 4}, {2, 3}}]



(* Some unexpected factors 2 show up because having c (p) or c (q) gives the same result*)

fuct2M2Q11[j_, i_] := Tr[(oM2T[\[Alpha][2], \[Alpha][3]][[i]].Cj[oY[\[Alpha][3], \[Alpha][4], \[Alpha][5]]]).(Sum[2 g[l]^2 DMatrixCR[l], {l, totalS}].oY[\[Alpha][1], \[Alpha][5], \[Alpha][4]][[j]])] - Sum[g[l]^2 cR[i, l], {l, totalS}] Tr[(oM2T[\[Alpha][2], \[Alpha][3]][[i]].Cj[oY[\[Alpha][3], \[Alpha][4], \[Alpha][5]]]).oY[\[Alpha][1], \[Alpha][5], \[Alpha][4]][[j]]];
fuct2M2Q12[j_, i_] := Tr[(Cj[oY[\[Alpha][2], \[Alpha][3], \[Alpha][4]][[i]]].Sum[2 g[l]^2 DMatrixCR[l], {l, totalS}]).(oY[\[Alpha][4], \[Alpha][3], \[Alpha][6]].oM2[\[Alpha][1], \[Alpha][6]][[j]])] - Sum[g[l]^2 cR[i, l], {l, totalS}] Tr[Cj[oY[\[Alpha][2], \[Alpha][3], \[Alpha][4]][[i]]].(oY[\[Alpha][4], \[Alpha][3], \[Alpha][6]].oM2[\[Alpha][1], \[Alpha][6]][[j]])];
fuct2M2Q13[j_, i_] := 4 (Tr[(Cj[oY[\[Alpha][2], \[Alpha][3], \[Alpha][4]][[i]]].Sum[ g[l]^2 DMatrixCR[l], {l, totalS}]).(oY[\[Alpha][1], \[Alpha][4], \[Alpha][5]][[j]].oM2T[\[Alpha][5], \[Alpha][3]])] + Tr[(Sum[ g[l]^2 DMatrixCR[l], {l, totalS}].Cj[oY[\[Alpha][2], \[Alpha][3], \[Alpha][4]][[i]]]).(oY[\[Alpha][1], \[Alpha][4], \[Alpha][5]][[j]].oM2T[\[Alpha][5], \[Alpha][3]])] - Sum[g[l]^2 cR[i, l], {l, totalS}] Tr[Cj[oY[\[Alpha][2], \[Alpha][3], \[Alpha][4]][[i]]].(oY[\[Alpha][1], \[Alpha][4], \[Alpha][5]][[j]].oM2T[\[Alpha][5], \[Alpha][3]])]);
fuct2M2Q14[j_, i_] := 2 (Tr[Cj[oH[\[Alpha][2], \[Alpha][3], \[Alpha][4]][[i]]].Sum[2 g[l]^2 DMatrixCR[l], {l, totalS}].oH[\[Alpha][1], \[Alpha][4], \[Alpha][3]][[j]]] - Sum[g[l]^2 cR[i, l], {l, totalS}] Tr[Cj[oH[\[Alpha][2], \[Alpha][3], \[Alpha][4]][[i]]].oH[\[Alpha][1], \[Alpha][4], \[Alpha][3]][[j]]]);
fuct2M2Q15[j_, i_] := -2 (Tr[Cj[oH[\[Alpha][2], \[Alpha][3], \[Alpha][4]][[i]]].Sum[2 M[l] g[l]^2 DMatrixCR[l], {l, totalS}].oY[\[Alpha][1], \[Alpha][4], \[Alpha][3]][[j]]] - Sum[M[l] g[l]^2 cR[i, l], {l, totalS}] Tr[Cj[oH[\[Alpha][2], \[Alpha][3], \[Alpha][4]][[i]]].oY[\[Alpha][1], \[Alpha][4], \[Alpha][3]][[j]]]);
fuct2M2Q16[j_, i_] := -2 (Tr[Cj[oY[\[Alpha][2], \[Alpha][3], \[Alpha][4]][[i]]].Sum[2 Cj[M[l]] g[l]^2 DMatrixCR[l], {l, totalS}].oH[\[Alpha][1], \[Alpha][4], \[Alpha][3]][[j]]] - Sum[Cj[M[l]] g[l]^2 cR[i, l], {l, totalS}] Tr[Cj[oY[\[Alpha][2], \[Alpha][3], \[Alpha][4]][[i]]].oH[\[Alpha][1], \[Alpha][4], \[Alpha][3]][[j]]]);
fuct2M2Q17[j_, i_] := 4 (Tr[Cj[oY[\[Alpha][2], \[Alpha][3], \[Alpha][4]][[i]]].Sum[2 Cj[M[l]] M[l] g[l]^2 DMatrixCR[l], {l, totalS}].oY[\[Alpha][1], \[Alpha][4], \[Alpha][3]][[j]]] - Sum[Cj[M[l]] M[l] g[l]^2 cR[i, l], {l, totalS}] Tr[Cj[oY[\[Alpha][2], \[Alpha][3], \[Alpha][4]][[i]]].oY[\[Alpha][1], \[Alpha][4], \[Alpha][3]][[j]]]);


fuct2M2Q18[j_, i_] := -2 KroneckerDelta[\[Alpha][1], \[Alpha][2]] ListContract[(Sum[g[l]^2 fullRepMat[[l, a, j, i]] fullRepMat[[l, a]], {l,  totalS}, {a, dG[l]}].oM2[\[Alpha][3], \[Alpha][4]]).(oY[\[Alpha][4], \[Alpha][5], \[Alpha][6]].Cj[oY[\[Alpha][6], \[Alpha][5], \[Alpha][3]]]), {{1, 4}, {2, 3}}];
fuct2M2Q19[j_, i_] := 8 KroneckerDelta[\[Alpha][1], \[Alpha][2]] Tr[Sum[g[l1]^2 g[l2]^2 fullRepMat[[l1, a, j, i]] fullRepMat[[l1, a]].DMatrixCR[l2], {l1, totalS}, {l2, totalS}, {a, dG[l1]}].oM2[\[Alpha][3], \[Alpha][3]]];
fuct2M2Q20[j_, i_] := KroneckerDelta[i, j] KroneckerDelta[\[Alpha][1], \[Alpha][2]] (24 Sum[ M[l] Cj[M[l]] g[l]^4 cR[j, l] flav[i2] sR[i2, l]/dR[i2, l], {l, totalS}, {i2, totalF}]
     +  Sum[g[l1]^2 g[l2]^2  cR[j, l1] cR[j, l2] (32 M[l1] Cj[M[l1]] + 8 M[l1] Cj[M[l2]] + 8 M[l2] Cj[M[l1]]), {l1, totalS}, {l2, totalS}] - 72 Sum[ M[l] Cj[M[l]] g[l]^4 cG[l] cR[j, l], {l, totalS}]);


fuct2M2Q21[j_, i_] := If[totalSU > 1, fuct2M2Q21NonU1[j, i] + fuct2M2Q21U1[j, i], 8 KroneckerDelta[i, j] KroneckerDelta[\[Alpha][1], \[Alpha][2]] Tr[Sum[g[l]^4 cR[j, l] DMatrixSR[l]/dR[i, l], {l, totalS}].oM2[\[Alpha][3], \[Alpha][3]]]];
fuct2M2Q22[j_, i_] := -8 KroneckerDelta[i, j] KroneckerDelta[\[Alpha][1], \[Alpha][2]] Sum[cG[l] g[l]^4 cR[j, l] M[l] Cj[M[l]], {l, totalS}];

fuct2M2Q21NonU1[j_, i_] := 8 KroneckerDelta[i, j] KroneckerDelta[\[Alpha][1], \[Alpha][2]] Tr[Sum[g[l]^4 cR[j, l] DMatrixSR[l]/dR[i, l], {l,totalSU+1,totalS}].oM2[\[Alpha][3], \[Alpha][3]]];

(* Important if there is more than one U (1) group *)
fuct2M2Q21U1[j_, i_] := Module[{n, aux1, aux2, aux3, aux4},
   n = totalSU;
   If[n == 0, Return[0],
    aux1 = Table[fullRepMat[[ l, 1]], {l, n}];
    aux2 = Table[Tr[aux1[[l1]].aux1[[l2]]], {l1, n}, {l2, n}];
    aux3 = Eigensystem[aux2][[2]];
    aux4 = Table[aux3[[l]]/Norm[aux3[[l]]], {l, n}];
    aux1 = aux4.aux1;
    Return[8 KroneckerDelta[\[Alpha][1], \[Alpha][2]] Sum[g[ l1]^2 g[ l2]^2 aux1[[l1, i, i]] Tr[aux1[[l1]].aux1[[l2]].oM2[\[Alpha][3], \[Alpha][3]]], {l1, n}, {l2, n}]];
    ];
   ];

\[Beta]2M1[i_, j_] := CanonicalForm[fuct2M1Q1[i, j] + fuct2M1Q2[i, j] + fuct2M1Q3[i, j] + fuct2M1Q4[i, j] + fuct2M1Q5[i, j] + fuct2M1Q6[i, j]]/.{\[Alpha][1]->flavVariables[[1]],\[Alpha][2]->flavVariables[[2]]};
\[Beta]2M2[i_, j_] := CanonicalForm[fuct2M2Q1[i, j] + fuct2M2Q2[i, j] + fuct2M2Q3[i, j] + fuct2M2Q4[i, j] + fuct2M2Q5[i, j] + fuct2M2Q6[i, j] + fuct2M2Q7[i, j] + fuct2M2Q8[i, j] + fuct2M2Q9[i, j] + fuct2M2Q10[i, j] + fuct2M2Q11[i, j] + fuct2M2Q12[i, j] + fuct2M2Q13[i, j] + fuct2M2Q14[i, j] + fuct2M2Q15[i, j] + fuct2M2Q16[i, j] + fuct2M2Q17[i, j] + fuct2M2Q18[i, j] + fuct2M2Q19[i, j] + fuct2M2Q20[i, j] + fuct2M2Q21[i, j] + fuct2M2Q22[i, j]]/.{\[Alpha][1]->flavVariables[[1]],\[Alpha][2]->flavVariables[[2]]};



(* XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX \[Beta]S XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX *)
fuctS1Q1[i_]:=1/2 Tr[oY[\[Alpha][1],\[Alpha][2],\[Alpha][3]][[i]].Cj[oY[\[Alpha][3],\[Alpha][2],\[Alpha][4]]].oS[\[Alpha][4]]]
fuctS1Q2[i_]:=Tr[oL[\[Alpha][2]].Cj[oY[\[Alpha][2],\[Alpha][3],\[Alpha][4]]].oH[\[Alpha][1],\[Alpha][4],\[Alpha][3]][[i]]]
fuctS1Q3[i_]:=Tr[o\[Mu][\[Alpha][1],\[Alpha][2]][[i]].Cj[oY[\[Alpha][2],\[Alpha][3],\[Alpha][4]]].oB[\[Alpha][4],\[Alpha][3]]]
fuctS1Q4[i_]:= 2Tr[oY[\[Alpha][1],\[Alpha][2],\[Alpha][3]][[i]].oM2T[\[Alpha][3],\[Alpha][4]].Cj[o\[Mu][\[Alpha][4],\[Alpha][2]]]]
fuctS1Q5[i_]:=Tr[oH[\[Alpha][1],\[Alpha][2],\[Alpha][3]][[i]].Cj[oB[\[Alpha][3],\[Alpha][2]]]];



fuctS2Q1[i_] :=2Tr[oY[\[Alpha][1],\[Alpha][2],\[Alpha][3]][[i]].Sum[ g[l]^2 DMatrixCR[l], {l, totalS}].Cj[oY[\[Alpha][3],\[Alpha][2],\[Alpha][4]]].oS[\[Alpha][4]]]
fuctS2Q2[i_] :=-1/2 ListContract[oY[\[Alpha][1],\[Alpha][2],\[Alpha][3]][[i]].Cj[oY[\[Alpha][3],\[Alpha][4],\[Alpha][5]]].oY[\[Alpha][5],\[Alpha][4],\[Alpha][6]].Cj[oY[\[Alpha][6],\[Alpha][2],\[Alpha][7]].oS[\[Alpha][7]]],{{1,4},{2,3}}] 
fuctS2Q3[i_] :=- 4 Tr[oL[\[Alpha][2]].Cj[oY[\[Alpha][2],\[Alpha][3],\[Alpha][4]]].Sum[(oY[\[Alpha][1], \[Alpha][4],\[Alpha][3]][[i]] M[l]-oH[\[Alpha][1], \[Alpha][4],\[Alpha][3]][[i]]).DMatrixCR[l] g[l]^2, {l, totalS}]];

fuctS2Q4[i_] :=-ListContract[oY[\[Alpha][1],\[Alpha][2],\[Alpha][3]][[i]].Cj[oY[\[Alpha][3],\[Alpha][4],\[Alpha][5]]].oH[\[Alpha][5],\[Alpha][4],\[Alpha][6]].Cj[oY[\[Alpha][6],\[Alpha][2],\[Alpha][7]]].oL[\[Alpha][7]],{{1,4},{2,3}}];
fuctS2Q5[i_] :=-ListContract[oH[\[Alpha][1],\[Alpha][2],\[Alpha][3]][[i]].Cj[oY[\[Alpha][3],\[Alpha][4],\[Alpha][5]]].oY[\[Alpha][5],\[Alpha][4],\[Alpha][6]].Cj[oY[\[Alpha][6],\[Alpha][2],\[Alpha][7]]].oL[\[Alpha][7]],{{1,4},{2,3}}];
fuctS2Q6[i_] :=- 4Tr[ o\[Mu][\[Alpha][1],\[Alpha][2]][[i]].Cj[oY[\[Alpha][2],\[Alpha][3],\[Alpha][4]]] .Sum[DMatrixCR[l].(o\[Mu][\[Alpha][4], \[Alpha][3]] M[l]-oB[\[Alpha][4], \[Alpha][3]]) g[l]^2, {l, totalS}]]

fuctS2Q7[i_]:=-ListContract[o\[Mu][\[Alpha][1],\[Alpha][2]][[i]].Cj[oY[\[Alpha][2],\[Alpha][3],\[Alpha][4]]].oH[\[Alpha][4],\[Alpha][5],\[Alpha][6]].Cj[oY[\[Alpha][6],\[Alpha][5],\[Alpha][7]]].o\[Mu][\[Alpha][7],\[Alpha][3]],{{1,4},{2,3}}]
fuctS2Q8[i_]:=-ListContract[o\[Mu][\[Alpha][1],\[Alpha][2]][[i]].Cj[oY[\[Alpha][2],\[Alpha][3],\[Alpha][4]]].oY[\[Alpha][4],\[Alpha][5],\[Alpha][6]].Cj[oY[\[Alpha][6],\[Alpha][5],\[Alpha][7]]].oB[\[Alpha][7],\[Alpha][3]],{{1,4},{2,3}}]
fuctS2Q9[i_]:=Tr[Sum[4g[l]^2DMatrixCR[l].(2oY[\[Alpha][1],\[Alpha][2],\[Alpha][3]][[i]].Cj[o\[Mu][\[Alpha][3],\[Alpha][2]]]M[l] Cj[M[l]]-oY[\[Alpha][1],\[Alpha][2],\[Alpha][3]][[i]].Cj[oB[\[Alpha][3],\[Alpha][2]]]M[l]-oH[\[Alpha][1],\[Alpha][2],\[Alpha][3]][[i]].Cj[o\[Mu][\[Alpha][3],\[Alpha][2]]]Cj[M[l]] +oH[\[Alpha][1],\[Alpha][2],\[Alpha][3]][[i]].Cj[oB[\[Alpha][3],\[Alpha][2]]]+oY[\[Alpha][1],\[Alpha][2],\[Alpha][3]][[i]].oM2T[\[Alpha][3],\[Alpha][4]].Cj[o\[Mu][\[Alpha][4],\[Alpha][2]]]+Cj[o\[Mu][\[Alpha][2],\[Alpha][3]]].oY[\[Alpha][1],\[Alpha][3],\[Alpha][4]][[i]].oM2T[\[Alpha][4],\[Alpha][2]]), {l, totalS}]];

fuctS2Q10[i_]:=-ListContract[oY[\[Alpha][1],\[Alpha][2],\[Alpha][3]][[i]].Cj[oY[\[Alpha][3],\[Alpha][4],\[Alpha][5]]].oH[\[Alpha][5],\[Alpha][4],\[Alpha][6]].Cj[oB[\[Alpha][6],\[Alpha][2]]],{{1,4},{2,3}}]
fuctS2Q11[i_]:=-ListContract[oH[\[Alpha][1],\[Alpha][2],\[Alpha][3]][[i]].Cj[oY[\[Alpha][3],\[Alpha][4],\[Alpha][5]]].oY[\[Alpha][5],\[Alpha][4],\[Alpha][6]].Cj[oB[\[Alpha][6],\[Alpha][2]]],{{1,4},{2,3}}]
fuctS2Q12[i_]:=-ListContract[oY[\[Alpha][1],\[Alpha][2],\[Alpha][3]][[i]].Cj[oH[\[Alpha][3],\[Alpha][4],\[Alpha][5]]].oH[\[Alpha][5],\[Alpha][4],\[Alpha][6]].Cj[o\[Mu][\[Alpha][6],\[Alpha][2]]],{{1,4},{2,3}}]
fuctS2Q13[i_]:=-ListContract[oH[\[Alpha][1],\[Alpha][2],\[Alpha][3]][[i]].Cj[oH[\[Alpha][3],\[Alpha][4],\[Alpha][5]]].oY[\[Alpha][5],\[Alpha][4],\[Alpha][6]].Cj[o\[Mu][\[Alpha][6],\[Alpha][2]]],{{1,4},{2,3}}]

fuctS2Q14[i_]:=-ListContract[oY[\[Alpha][1],\[Alpha][2],\[Alpha][3]][[i]].oM2T[\[Alpha][3],\[Alpha][4]].Cj[o\[Mu][\[Alpha][4],\[Alpha][5]]].oY[\[Alpha][5],\[Alpha][6],\[Alpha][7]].Cj[oY[\[Alpha][7],\[Alpha][6],\[Alpha][2]]],{{1,4},{2,3}}]
fuctS2Q15[i_]:=-ListContract[oY[\[Alpha][1],\[Alpha][2],\[Alpha][3]][[i]].Cj[oY[\[Alpha][3],\[Alpha][4],\[Alpha][5]]].oY[\[Alpha][5],\[Alpha][4],\[Alpha][6]].oM2T[\[Alpha][6],\[Alpha][7]].Cj[o\[Mu][\[Alpha][7],\[Alpha][2]]],{{1,4},{2,3}}]
fuctS2Q16[i_]:=-ListContract[oY[\[Alpha][1],\[Alpha][2],\[Alpha][3]][[i]].oM2T[\[Alpha][3],\[Alpha][4]].Cj[oY[\[Alpha][4],\[Alpha][5],\[Alpha][6]]].oY[\[Alpha][6],\[Alpha][5],\[Alpha][7]].Cj[o\[Mu][\[Alpha][7],\[Alpha][2]]],{{1,4},{2,3}}]

fuctS2Q17[i_]:=-2ListContract[oY[\[Alpha][1],\[Alpha][2],\[Alpha][3]][[i]].Cj[oY[\[Alpha][3],\[Alpha][4],\[Alpha][5]]].oM2[\[Alpha][5],\[Alpha][6]].oY[\[Alpha][6],\[Alpha][4],\[Alpha][7]].Cj[o\[Mu][\[Alpha][7],\[Alpha][2]]],{{1,4},{2,3}}]





\[Beta]S1[i_]:=CanonicalForm[fuctS1Q1[i]+fuctS1Q2[i]+fuctS1Q3[i]+fuctS1Q4[i]+fuctS1Q5[i]]/.{\[Alpha][1]->flavVariables[[1]]}
\[Beta]S2[i_]:=CanonicalForm[fuctS2Q1[i] + fuctS2Q2[i] +fuctS2Q3[i] +fuctS2Q4[i] + fuctS2Q5[i] +fuctS2Q6[i] + fuctS2Q7[i] +fuctS2Q8[i] +fuctS2Q9[i] +fuctS2Q10[i] +fuctS2Q11[i] +fuctS2Q12[i] +fuctS2Q13[i] +fuctS2Q14[i] +fuctS2Q15[i]+fuctS2Q16[i] +fuctS2Q17[i]  ]/.{\[Alpha][1]->flavVariables[[1]]} 


End[];
EndPackage[];