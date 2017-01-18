! -----------------------------------------------------------------------------  
! This file was automatically created by SARAH version 4.9.1 
! SARAH References: arXiv:0806.0538, 0909.2863, 1002.0840, 1207.0906, 1309.7223  
! (c) Florian Staub, 2013  
! ------------------------------------------------------------------------------  
! File created at 15:33 on 18.1.2017   
! ----------------------------------------------------------------------  
 
 
Module RGEs_radinuZeeHB 
 
Use Control 
Use Model_Data_radinuZeeHB 
Use Mathematics 
 
Logical,Private,Save::OnlyDiagonal

Real(dp),Parameter::id3R(3,3)=& 
   & Reshape(Source=(/& 
   & 1,0,0,& 
 &0,1,0,& 
 &0,0,1& 
 &/),shape=(/3,3/)) 
Contains 


Subroutine GToParameters160(g,g1,g2,g3,lam1,lam2,lam4,lam3,lam7,lam5,lam6,            & 
& lam9,lam8,lamh,lam10,epsU,Yu,epsD,epsE,Yd,Ye,Yh,mu,mH2,mEt2,m12,mh)

Implicit None 
Real(dp), Intent(in) :: g(160) 
Real(dp),Intent(out) :: g1,g2,g3,lam5

Complex(dp),Intent(out) :: lam1,lam2,lam4,lam3,lam7,lam6,lam9,lam8,lamh,lam10,epsU(3,3),Yu(3,3),epsD(3,3),       & 
& epsE(3,3),Yd(3,3),Ye(3,3),Yh(3,3),mu,mH2,mEt2,m12,mh

Integer i1, i2, i3, i4, SumI 
 
Iname = Iname +1 
NameOfUnit(Iname) = 'GToParameters160' 
 
g1= g(1) 
g2= g(2) 
g3= g(3) 
lam1= Cmplx(g(4),g(5),dp) 
lam2= Cmplx(g(6),g(7),dp) 
lam4= Cmplx(g(8),g(9),dp) 
lam3= Cmplx(g(10),g(11),dp) 
lam7= Cmplx(g(12),g(13),dp) 
lam5= g(14) 
lam6= Cmplx(g(15),g(16),dp) 
lam9= Cmplx(g(17),g(18),dp) 
lam8= Cmplx(g(19),g(20),dp) 
lamh= Cmplx(g(21),g(22),dp) 
lam10= Cmplx(g(23),g(24),dp) 
Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
epsU(i1,i2) = Cmplx( g(SumI+25), g(SumI+26), dp) 
End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
Yu(i1,i2) = Cmplx( g(SumI+43), g(SumI+44), dp) 
End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
epsD(i1,i2) = Cmplx( g(SumI+61), g(SumI+62), dp) 
End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
epsE(i1,i2) = Cmplx( g(SumI+79), g(SumI+80), dp) 
End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
Yd(i1,i2) = Cmplx( g(SumI+97), g(SumI+98), dp) 
End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
Ye(i1,i2) = Cmplx( g(SumI+115), g(SumI+116), dp) 
End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
Yh(i1,i2) = Cmplx( g(SumI+133), g(SumI+134), dp) 
End Do 
 End Do 
 
mu= Cmplx(g(151),g(152),dp) 
mH2= Cmplx(g(153),g(154),dp) 
mEt2= Cmplx(g(155),g(156),dp) 
m12= Cmplx(g(157),g(158),dp) 
mh= Cmplx(g(159),g(160),dp) 
Do i1=1,160 
If (g(i1).ne.g(i1)) Then 
 Write(*,*) "NaN appearing in ",NameOfUnit(Iname) 
 Write(*,*) "At position ", i1 
 Call TerminateProgram 
End if 
End do 
Iname = Iname - 1 
 
End Subroutine GToParameters160

Subroutine ParametersToG160(g1,g2,g3,lam1,lam2,lam4,lam3,lam7,lam5,lam6,              & 
& lam9,lam8,lamh,lam10,epsU,Yu,epsD,epsE,Yd,Ye,Yh,mu,mH2,mEt2,m12,mh,g)

Implicit None 
Real(dp), Intent(out) :: g(160) 
Real(dp), Intent(in) :: g1,g2,g3,lam5

Complex(dp), Intent(in) :: lam1,lam2,lam4,lam3,lam7,lam6,lam9,lam8,lamh,lam10,epsU(3,3),Yu(3,3),epsD(3,3),       & 
& epsE(3,3),Yd(3,3),Ye(3,3),Yh(3,3),mu,mH2,mEt2,m12,mh

Integer i1, i2, i3, i4, SumI 
 
Iname = Iname +1 
NameOfUnit(Iname) = 'ParametersToG160' 
 
g(1) = g1  
g(2) = g2  
g(3) = g3  
g(4) = Real(lam1,dp)  
g(5) = Aimag(lam1)  
g(6) = Real(lam2,dp)  
g(7) = Aimag(lam2)  
g(8) = Real(lam4,dp)  
g(9) = Aimag(lam4)  
g(10) = Real(lam3,dp)  
g(11) = Aimag(lam3)  
g(12) = Real(lam7,dp)  
g(13) = Aimag(lam7)  
g(14) = lam5  
g(15) = Real(lam6,dp)  
g(16) = Aimag(lam6)  
g(17) = Real(lam9,dp)  
g(18) = Aimag(lam9)  
g(19) = Real(lam8,dp)  
g(20) = Aimag(lam8)  
g(21) = Real(lamh,dp)  
g(22) = Aimag(lamh)  
g(23) = Real(lam10,dp)  
g(24) = Aimag(lam10)  
Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
g(SumI+25) = Real(epsU(i1,i2), dp) 
g(SumI+26) = Aimag(epsU(i1,i2)) 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
g(SumI+43) = Real(Yu(i1,i2), dp) 
g(SumI+44) = Aimag(Yu(i1,i2)) 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
g(SumI+61) = Real(epsD(i1,i2), dp) 
g(SumI+62) = Aimag(epsD(i1,i2)) 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
g(SumI+79) = Real(epsE(i1,i2), dp) 
g(SumI+80) = Aimag(epsE(i1,i2)) 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
g(SumI+97) = Real(Yd(i1,i2), dp) 
g(SumI+98) = Aimag(Yd(i1,i2)) 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
g(SumI+115) = Real(Ye(i1,i2), dp) 
g(SumI+116) = Aimag(Ye(i1,i2)) 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
g(SumI+133) = Real(Yh(i1,i2), dp) 
g(SumI+134) = Aimag(Yh(i1,i2)) 
End Do 
End Do 

g(151) = Real(mu,dp)  
g(152) = Aimag(mu)  
g(153) = Real(mH2,dp)  
g(154) = Aimag(mH2)  
g(155) = Real(mEt2,dp)  
g(156) = Aimag(mEt2)  
g(157) = Real(m12,dp)  
g(158) = Aimag(m12)  
g(159) = Real(mh,dp)  
g(160) = Aimag(mh)  
Iname = Iname - 1 
 
End Subroutine ParametersToG160

Subroutine rge160(len, T, GY, F) 
Implicit None 
Integer, Intent(in) :: len 
Real(dp), Intent(in) :: T, GY(len) 
Real(dp), Intent(out) :: F(len) 
Integer :: i1,i2,i3,i4 
Integer :: j1,j2,j3,j4,j5,j6,j7 
Real(dp) :: q 
Real(dp) :: g1,betag11,betag12,Dg1,g2,betag21,betag22,Dg2,g3,betag31,betag32,         & 
& Dg3,lam5,betalam51,betalam52,Dlam5
Complex(dp) :: lam1,betalam11,betalam12,Dlam1,lam2,betalam21,betalam22,               & 
& Dlam2,lam4,betalam41,betalam42,Dlam4,lam3,betalam31,betalam32,Dlam3,lam7,              & 
& betalam71,betalam72,Dlam7,lam6,betalam61,betalam62,Dlam6,lam9,betalam91,               & 
& betalam92,Dlam9,lam8,betalam81,betalam82,Dlam8,lamh,betalamh1,betalamh2,               & 
& Dlamh,lam10,betalam101,betalam102,Dlam10,epsU(3,3),betaepsU1(3,3),betaepsU2(3,3)       & 
& ,DepsU(3,3),adjepsU(3,3),Yu(3,3),betaYu1(3,3),betaYu2(3,3),DYu(3,3),adjYu(3,3)         & 
& ,epsD(3,3),betaepsD1(3,3),betaepsD2(3,3),DepsD(3,3),adjepsD(3,3),epsE(3,3)             & 
& ,betaepsE1(3,3),betaepsE2(3,3),DepsE(3,3),adjepsE(3,3),Yd(3,3),betaYd1(3,3)            & 
& ,betaYd2(3,3),DYd(3,3),adjYd(3,3),Ye(3,3),betaYe1(3,3),betaYe2(3,3),DYe(3,3)           & 
& ,adjYe(3,3),Yh(3,3),betaYh1(3,3),betaYh2(3,3),DYh(3,3),adjYh(3,3),mu,betamu1,          & 
& betamu2,Dmu,mH2,betamH21,betamH22,DmH2,mEt2,betamEt21,betamEt22,DmEt2,m12,             & 
& betam121,betam122,Dm12,mh,betamh1,betamh2,Dmh
Iname = Iname +1 
NameOfUnit(Iname) = 'rge160' 
 
OnlyDiagonal = .Not.GenerationMixing 
q = t 
 
Call GToParameters160(gy,g1,g2,g3,lam1,lam2,lam4,lam3,lam7,lam5,lam6,lam9,            & 
& lam8,lamh,lam10,epsU,Yu,epsD,epsE,Yd,Ye,Yh,mu,mH2,mEt2,m12,mh)

Call Adjungate(epsU,adjepsU)
Call Adjungate(Yu,adjYu)
Call Adjungate(epsD,adjepsD)
Call Adjungate(epsE,adjepsE)
Call Adjungate(Yd,adjYd)
Call Adjungate(Ye,adjYe)
Call Adjungate(Yh,adjYh)


If (TwoLoopRGE) Then 
End If 
 
 
!-------------------- 
! g1 
!-------------------- 
 
betag11  = 0

 
 
If (TwoLoopRGE) Then 
betag12 = 0

 
Dg1 = oo16pi2*( betag11 + oo16pi2 * betag12 ) 

 
Else 
Dg1 = oo16pi2* betag11 
End If 
 
 
!-------------------- 
! g2 
!-------------------- 
 
betag21  = 0

 
 
If (TwoLoopRGE) Then 
betag22 = 0

 
Dg2 = oo16pi2*( betag21 + oo16pi2 * betag22 ) 

 
Else 
Dg2 = oo16pi2* betag21 
End If 
 
 
!-------------------- 
! g3 
!-------------------- 
 
betag31  = 0

 
 
If (TwoLoopRGE) Then 
betag32 = 0

 
Dg3 = oo16pi2*( betag31 + oo16pi2 * betag32 ) 

 
Else 
Dg3 = oo16pi2* betag31 
End If 
 
 
!-------------------- 
! lam1 
!-------------------- 
 
betalam11  = 0

 
 
If (TwoLoopRGE) Then 
betalam12 = 0

 
Dlam1 = oo16pi2*( betalam11 + oo16pi2 * betalam12 ) 

 
Else 
Dlam1 = oo16pi2* betalam11 
End If 
 
 
Call Chop(Dlam1) 

!-------------------- 
! lam2 
!-------------------- 
 
betalam21  = 0

 
 
If (TwoLoopRGE) Then 
betalam22 = 0

 
Dlam2 = oo16pi2*( betalam21 + oo16pi2 * betalam22 ) 

 
Else 
Dlam2 = oo16pi2* betalam21 
End If 
 
 
Call Chop(Dlam2) 

!-------------------- 
! lam4 
!-------------------- 
 
betalam41  = 0

 
 
If (TwoLoopRGE) Then 
betalam42 = 0

 
Dlam4 = oo16pi2*( betalam41 + oo16pi2 * betalam42 ) 

 
Else 
Dlam4 = oo16pi2* betalam41 
End If 
 
 
Call Chop(Dlam4) 

!-------------------- 
! lam3 
!-------------------- 
 
betalam31  = 0

 
 
If (TwoLoopRGE) Then 
betalam32 = 0

 
Dlam3 = oo16pi2*( betalam31 + oo16pi2 * betalam32 ) 

 
Else 
Dlam3 = oo16pi2* betalam31 
End If 
 
 
Call Chop(Dlam3) 

!-------------------- 
! lam7 
!-------------------- 
 
betalam71  = 0

 
 
If (TwoLoopRGE) Then 
betalam72 = 0

 
Dlam7 = oo16pi2*( betalam71 + oo16pi2 * betalam72 ) 

 
Else 
Dlam7 = oo16pi2* betalam71 
End If 
 
 
Call Chop(Dlam7) 

!-------------------- 
! lam5 
!-------------------- 
 
betalam51  = 0

 
 
If (TwoLoopRGE) Then 
betalam52 = 0

 
Dlam5 = oo16pi2*( betalam51 + oo16pi2 * betalam52 ) 

 
Else 
Dlam5 = oo16pi2* betalam51 
End If 
 
 
!-------------------- 
! lam6 
!-------------------- 
 
betalam61  = 0

 
 
If (TwoLoopRGE) Then 
betalam62 = 0

 
Dlam6 = oo16pi2*( betalam61 + oo16pi2 * betalam62 ) 

 
Else 
Dlam6 = oo16pi2* betalam61 
End If 
 
 
Call Chop(Dlam6) 

!-------------------- 
! lam9 
!-------------------- 
 
betalam91  = 0

 
 
If (TwoLoopRGE) Then 
betalam92 = 0

 
Dlam9 = oo16pi2*( betalam91 + oo16pi2 * betalam92 ) 

 
Else 
Dlam9 = oo16pi2* betalam91 
End If 
 
 
Call Chop(Dlam9) 

!-------------------- 
! lam8 
!-------------------- 
 
betalam81  = 0

 
 
If (TwoLoopRGE) Then 
betalam82 = 0

 
Dlam8 = oo16pi2*( betalam81 + oo16pi2 * betalam82 ) 

 
Else 
Dlam8 = oo16pi2* betalam81 
End If 
 
 
Call Chop(Dlam8) 

!-------------------- 
! lamh 
!-------------------- 
 
betalamh1  = 0

 
 
If (TwoLoopRGE) Then 
betalamh2 = 0

 
Dlamh = oo16pi2*( betalamh1 + oo16pi2 * betalamh2 ) 

 
Else 
Dlamh = oo16pi2* betalamh1 
End If 
 
 
Call Chop(Dlamh) 

!-------------------- 
! lam10 
!-------------------- 
 
betalam101  = 0

 
 
If (TwoLoopRGE) Then 
betalam102 = 0

 
Dlam10 = oo16pi2*( betalam101 + oo16pi2 * betalam102 ) 

 
Else 
Dlam10 = oo16pi2* betalam101 
End If 
 
 
Call Chop(Dlam10) 

!-------------------- 
! epsU 
!-------------------- 
 
betaepsU1  = 0

 
 
If (TwoLoopRGE) Then 
betaepsU2 = 0

 
DepsU = oo16pi2*( betaepsU1 + oo16pi2 * betaepsU2 ) 

 
Else 
DepsU = oo16pi2* betaepsU1 
End If 
 
 
Call Chop(DepsU) 

!-------------------- 
! Yu 
!-------------------- 
 
betaYu1  = 0

 
 
If (TwoLoopRGE) Then 
betaYu2 = 0

 
DYu = oo16pi2*( betaYu1 + oo16pi2 * betaYu2 ) 

 
Else 
DYu = oo16pi2* betaYu1 
End If 
 
 
Call Chop(DYu) 

!-------------------- 
! epsD 
!-------------------- 
 
betaepsD1  = 0

 
 
If (TwoLoopRGE) Then 
betaepsD2 = 0

 
DepsD = oo16pi2*( betaepsD1 + oo16pi2 * betaepsD2 ) 

 
Else 
DepsD = oo16pi2* betaepsD1 
End If 
 
 
Call Chop(DepsD) 

!-------------------- 
! epsE 
!-------------------- 
 
betaepsE1  = 0

 
 
If (TwoLoopRGE) Then 
betaepsE2 = 0

 
DepsE = oo16pi2*( betaepsE1 + oo16pi2 * betaepsE2 ) 

 
Else 
DepsE = oo16pi2* betaepsE1 
End If 
 
 
Call Chop(DepsE) 

!-------------------- 
! Yd 
!-------------------- 
 
betaYd1  = 0

 
 
If (TwoLoopRGE) Then 
betaYd2 = 0

 
DYd = oo16pi2*( betaYd1 + oo16pi2 * betaYd2 ) 

 
Else 
DYd = oo16pi2* betaYd1 
End If 
 
 
Call Chop(DYd) 

!-------------------- 
! Ye 
!-------------------- 
 
betaYe1  = 0

 
 
If (TwoLoopRGE) Then 
betaYe2 = 0

 
DYe = oo16pi2*( betaYe1 + oo16pi2 * betaYe2 ) 

 
Else 
DYe = oo16pi2* betaYe1 
End If 
 
 
Call Chop(DYe) 

!-------------------- 
! Yh 
!-------------------- 
 
betaYh1  = 0

 
 
If (TwoLoopRGE) Then 
betaYh2 = 0

 
DYh = oo16pi2*( betaYh1 + oo16pi2 * betaYh2 ) 

 
Else 
DYh = oo16pi2* betaYh1 
End If 
 
 
Call Chop(DYh) 

!-------------------- 
! mu 
!-------------------- 
 
betamu1  = 0

 
 
If (TwoLoopRGE) Then 
betamu2 = 0

 
Dmu = oo16pi2*( betamu1 + oo16pi2 * betamu2 ) 

 
Else 
Dmu = oo16pi2* betamu1 
End If 
 
 
Call Chop(Dmu) 

!-------------------- 
! mH2 
!-------------------- 
 
betamH21  = 0

 
 
If (TwoLoopRGE) Then 
betamH22 = 0

 
DmH2 = oo16pi2*( betamH21 + oo16pi2 * betamH22 ) 

 
Else 
DmH2 = oo16pi2* betamH21 
End If 
 
 
Call Chop(DmH2) 

!-------------------- 
! mEt2 
!-------------------- 
 
betamEt21  = 0

 
 
If (TwoLoopRGE) Then 
betamEt22 = 0

 
DmEt2 = oo16pi2*( betamEt21 + oo16pi2 * betamEt22 ) 

 
Else 
DmEt2 = oo16pi2* betamEt21 
End If 
 
 
Call Chop(DmEt2) 

!-------------------- 
! m12 
!-------------------- 
 
betam121  = 0

 
 
If (TwoLoopRGE) Then 
betam122 = 0

 
Dm12 = oo16pi2*( betam121 + oo16pi2 * betam122 ) 

 
Else 
Dm12 = oo16pi2* betam121 
End If 
 
 
Call Chop(Dm12) 

!-------------------- 
! mh 
!-------------------- 
 
betamh1  = 0

 
 
If (TwoLoopRGE) Then 
betamh2 = 0

 
Dmh = oo16pi2*( betamh1 + oo16pi2 * betamh2 ) 

 
Else 
Dmh = oo16pi2* betamh1 
End If 
 
 
Call Chop(Dmh) 

Call ParametersToG160(Dg1,Dg2,Dg3,Dlam1,Dlam2,Dlam4,Dlam3,Dlam7,Dlam5,Dlam6,          & 
& Dlam9,Dlam8,Dlamh,Dlam10,DepsU,DYu,DepsD,DepsE,DYd,DYe,DYh,Dmu,DmH2,DmEt2,             & 
& Dm12,Dmh,f)

Iname = Iname - 1 
 
End Subroutine rge160  

Subroutine GToParameters162(g,g1,g2,g3,lam1,lam2,lam4,lam3,lam7,lam5,lam6,            & 
& lam9,lam8,lamh,lam10,epsU,Yu,epsD,epsE,Yd,Ye,Yh,mu,mH2,mEt2,m12,mh,v,vv)

Implicit None 
Real(dp), Intent(in) :: g(162) 
Real(dp),Intent(out) :: g1,g2,g3,lam5,v,vv

Complex(dp),Intent(out) :: lam1,lam2,lam4,lam3,lam7,lam6,lam9,lam8,lamh,lam10,epsU(3,3),Yu(3,3),epsD(3,3),       & 
& epsE(3,3),Yd(3,3),Ye(3,3),Yh(3,3),mu,mH2,mEt2,m12,mh

Integer i1, i2, i3, i4, SumI 
 
Iname = Iname +1 
NameOfUnit(Iname) = 'GToParameters162' 
 
g1= g(1) 
g2= g(2) 
g3= g(3) 
lam1= Cmplx(g(4),g(5),dp) 
lam2= Cmplx(g(6),g(7),dp) 
lam4= Cmplx(g(8),g(9),dp) 
lam3= Cmplx(g(10),g(11),dp) 
lam7= Cmplx(g(12),g(13),dp) 
lam5= g(14) 
lam6= Cmplx(g(15),g(16),dp) 
lam9= Cmplx(g(17),g(18),dp) 
lam8= Cmplx(g(19),g(20),dp) 
lamh= Cmplx(g(21),g(22),dp) 
lam10= Cmplx(g(23),g(24),dp) 
Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
epsU(i1,i2) = Cmplx( g(SumI+25), g(SumI+26), dp) 
End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
Yu(i1,i2) = Cmplx( g(SumI+43), g(SumI+44), dp) 
End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
epsD(i1,i2) = Cmplx( g(SumI+61), g(SumI+62), dp) 
End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
epsE(i1,i2) = Cmplx( g(SumI+79), g(SumI+80), dp) 
End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
Yd(i1,i2) = Cmplx( g(SumI+97), g(SumI+98), dp) 
End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
Ye(i1,i2) = Cmplx( g(SumI+115), g(SumI+116), dp) 
End Do 
 End Do 
 
Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
Yh(i1,i2) = Cmplx( g(SumI+133), g(SumI+134), dp) 
End Do 
 End Do 
 
mu= Cmplx(g(151),g(152),dp) 
mH2= Cmplx(g(153),g(154),dp) 
mEt2= Cmplx(g(155),g(156),dp) 
m12= Cmplx(g(157),g(158),dp) 
mh= Cmplx(g(159),g(160),dp) 
v= g(161) 
vv= g(162) 
Do i1=1,162 
If (g(i1).ne.g(i1)) Then 
 Write(*,*) "NaN appearing in ",NameOfUnit(Iname) 
 Write(*,*) "At position ", i1 
 Call TerminateProgram 
End if 
End do 
Iname = Iname - 1 
 
End Subroutine GToParameters162

Subroutine ParametersToG162(g1,g2,g3,lam1,lam2,lam4,lam3,lam7,lam5,lam6,              & 
& lam9,lam8,lamh,lam10,epsU,Yu,epsD,epsE,Yd,Ye,Yh,mu,mH2,mEt2,m12,mh,v,vv,g)

Implicit None 
Real(dp), Intent(out) :: g(162) 
Real(dp), Intent(in) :: g1,g2,g3,lam5,v,vv

Complex(dp), Intent(in) :: lam1,lam2,lam4,lam3,lam7,lam6,lam9,lam8,lamh,lam10,epsU(3,3),Yu(3,3),epsD(3,3),       & 
& epsE(3,3),Yd(3,3),Ye(3,3),Yh(3,3),mu,mH2,mEt2,m12,mh

Integer i1, i2, i3, i4, SumI 
 
Iname = Iname +1 
NameOfUnit(Iname) = 'ParametersToG162' 
 
g(1) = g1  
g(2) = g2  
g(3) = g3  
g(4) = Real(lam1,dp)  
g(5) = Aimag(lam1)  
g(6) = Real(lam2,dp)  
g(7) = Aimag(lam2)  
g(8) = Real(lam4,dp)  
g(9) = Aimag(lam4)  
g(10) = Real(lam3,dp)  
g(11) = Aimag(lam3)  
g(12) = Real(lam7,dp)  
g(13) = Aimag(lam7)  
g(14) = lam5  
g(15) = Real(lam6,dp)  
g(16) = Aimag(lam6)  
g(17) = Real(lam9,dp)  
g(18) = Aimag(lam9)  
g(19) = Real(lam8,dp)  
g(20) = Aimag(lam8)  
g(21) = Real(lamh,dp)  
g(22) = Aimag(lamh)  
g(23) = Real(lam10,dp)  
g(24) = Aimag(lam10)  
Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
g(SumI+25) = Real(epsU(i1,i2), dp) 
g(SumI+26) = Aimag(epsU(i1,i2)) 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
g(SumI+43) = Real(Yu(i1,i2), dp) 
g(SumI+44) = Aimag(Yu(i1,i2)) 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
g(SumI+61) = Real(epsD(i1,i2), dp) 
g(SumI+62) = Aimag(epsD(i1,i2)) 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
g(SumI+79) = Real(epsE(i1,i2), dp) 
g(SumI+80) = Aimag(epsE(i1,i2)) 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
g(SumI+97) = Real(Yd(i1,i2), dp) 
g(SumI+98) = Aimag(Yd(i1,i2)) 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
g(SumI+115) = Real(Ye(i1,i2), dp) 
g(SumI+116) = Aimag(Ye(i1,i2)) 
End Do 
End Do 

Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
g(SumI+133) = Real(Yh(i1,i2), dp) 
g(SumI+134) = Aimag(Yh(i1,i2)) 
End Do 
End Do 

g(151) = Real(mu,dp)  
g(152) = Aimag(mu)  
g(153) = Real(mH2,dp)  
g(154) = Aimag(mH2)  
g(155) = Real(mEt2,dp)  
g(156) = Aimag(mEt2)  
g(157) = Real(m12,dp)  
g(158) = Aimag(m12)  
g(159) = Real(mh,dp)  
g(160) = Aimag(mh)  
g(161) = v  
g(162) = vv  
Iname = Iname - 1 
 
End Subroutine ParametersToG162

Subroutine rge162(len, T, GY, F) 
Implicit None 
Integer, Intent(in) :: len 
Real(dp), Intent(in) :: T, GY(len) 
Real(dp), Intent(out) :: F(len) 
Integer :: i1,i2,i3,i4 
Integer :: j1,j2,j3,j4,j5,j6,j7 
Real(dp) :: q 
Real(dp) :: g1,betag11,betag12,Dg1,g2,betag21,betag22,Dg2,g3,betag31,betag32,         & 
& Dg3,lam5,betalam51,betalam52,Dlam5,v,betav1,betav2,Dv,vv,betavv1,betavv2,Dvv
Complex(dp) :: lam1,betalam11,betalam12,Dlam1,lam2,betalam21,betalam22,               & 
& Dlam2,lam4,betalam41,betalam42,Dlam4,lam3,betalam31,betalam32,Dlam3,lam7,              & 
& betalam71,betalam72,Dlam7,lam6,betalam61,betalam62,Dlam6,lam9,betalam91,               & 
& betalam92,Dlam9,lam8,betalam81,betalam82,Dlam8,lamh,betalamh1,betalamh2,               & 
& Dlamh,lam10,betalam101,betalam102,Dlam10,epsU(3,3),betaepsU1(3,3),betaepsU2(3,3)       & 
& ,DepsU(3,3),adjepsU(3,3),Yu(3,3),betaYu1(3,3),betaYu2(3,3),DYu(3,3),adjYu(3,3)         & 
& ,epsD(3,3),betaepsD1(3,3),betaepsD2(3,3),DepsD(3,3),adjepsD(3,3),epsE(3,3)             & 
& ,betaepsE1(3,3),betaepsE2(3,3),DepsE(3,3),adjepsE(3,3),Yd(3,3),betaYd1(3,3)            & 
& ,betaYd2(3,3),DYd(3,3),adjYd(3,3),Ye(3,3),betaYe1(3,3),betaYe2(3,3),DYe(3,3)           & 
& ,adjYe(3,3),Yh(3,3),betaYh1(3,3),betaYh2(3,3),DYh(3,3),adjYh(3,3),mu,betamu1,          & 
& betamu2,Dmu,mH2,betamH21,betamH22,DmH2,mEt2,betamEt21,betamEt22,DmEt2,m12,             & 
& betam121,betam122,Dm12,mh,betamh1,betamh2,Dmh
Iname = Iname +1 
NameOfUnit(Iname) = 'rge162' 
 
OnlyDiagonal = .Not.GenerationMixing 
q = t 
 
Call GToParameters162(gy,g1,g2,g3,lam1,lam2,lam4,lam3,lam7,lam5,lam6,lam9,            & 
& lam8,lamh,lam10,epsU,Yu,epsD,epsE,Yd,Ye,Yh,mu,mH2,mEt2,m12,mh,v,vv)

Call Adjungate(epsU,adjepsU)
Call Adjungate(Yu,adjYu)
Call Adjungate(epsD,adjepsD)
Call Adjungate(epsE,adjepsE)
Call Adjungate(Yd,adjYd)
Call Adjungate(Ye,adjYe)
Call Adjungate(Yh,adjYh)


If (TwoLoopRGE) Then 
End If 
 
 
!-------------------- 
! g1 
!-------------------- 
 
betag11  = 0

 
 
If (TwoLoopRGE) Then 
betag12 = 0

 
Dg1 = oo16pi2*( betag11 + oo16pi2 * betag12 ) 

 
Else 
Dg1 = oo16pi2* betag11 
End If 
 
 
!-------------------- 
! g2 
!-------------------- 
 
betag21  = 0

 
 
If (TwoLoopRGE) Then 
betag22 = 0

 
Dg2 = oo16pi2*( betag21 + oo16pi2 * betag22 ) 

 
Else 
Dg2 = oo16pi2* betag21 
End If 
 
 
!-------------------- 
! g3 
!-------------------- 
 
betag31  = 0

 
 
If (TwoLoopRGE) Then 
betag32 = 0

 
Dg3 = oo16pi2*( betag31 + oo16pi2 * betag32 ) 

 
Else 
Dg3 = oo16pi2* betag31 
End If 
 
 
!-------------------- 
! lam1 
!-------------------- 
 
betalam11  = 0

 
 
If (TwoLoopRGE) Then 
betalam12 = 0

 
Dlam1 = oo16pi2*( betalam11 + oo16pi2 * betalam12 ) 

 
Else 
Dlam1 = oo16pi2* betalam11 
End If 
 
 
Call Chop(Dlam1) 

!-------------------- 
! lam2 
!-------------------- 
 
betalam21  = 0

 
 
If (TwoLoopRGE) Then 
betalam22 = 0

 
Dlam2 = oo16pi2*( betalam21 + oo16pi2 * betalam22 ) 

 
Else 
Dlam2 = oo16pi2* betalam21 
End If 
 
 
Call Chop(Dlam2) 

!-------------------- 
! lam4 
!-------------------- 
 
betalam41  = 0

 
 
If (TwoLoopRGE) Then 
betalam42 = 0

 
Dlam4 = oo16pi2*( betalam41 + oo16pi2 * betalam42 ) 

 
Else 
Dlam4 = oo16pi2* betalam41 
End If 
 
 
Call Chop(Dlam4) 

!-------------------- 
! lam3 
!-------------------- 
 
betalam31  = 0

 
 
If (TwoLoopRGE) Then 
betalam32 = 0

 
Dlam3 = oo16pi2*( betalam31 + oo16pi2 * betalam32 ) 

 
Else 
Dlam3 = oo16pi2* betalam31 
End If 
 
 
Call Chop(Dlam3) 

!-------------------- 
! lam7 
!-------------------- 
 
betalam71  = 0

 
 
If (TwoLoopRGE) Then 
betalam72 = 0

 
Dlam7 = oo16pi2*( betalam71 + oo16pi2 * betalam72 ) 

 
Else 
Dlam7 = oo16pi2* betalam71 
End If 
 
 
Call Chop(Dlam7) 

!-------------------- 
! lam5 
!-------------------- 
 
betalam51  = 0

 
 
If (TwoLoopRGE) Then 
betalam52 = 0

 
Dlam5 = oo16pi2*( betalam51 + oo16pi2 * betalam52 ) 

 
Else 
Dlam5 = oo16pi2* betalam51 
End If 
 
 
!-------------------- 
! lam6 
!-------------------- 
 
betalam61  = 0

 
 
If (TwoLoopRGE) Then 
betalam62 = 0

 
Dlam6 = oo16pi2*( betalam61 + oo16pi2 * betalam62 ) 

 
Else 
Dlam6 = oo16pi2* betalam61 
End If 
 
 
Call Chop(Dlam6) 

!-------------------- 
! lam9 
!-------------------- 
 
betalam91  = 0

 
 
If (TwoLoopRGE) Then 
betalam92 = 0

 
Dlam9 = oo16pi2*( betalam91 + oo16pi2 * betalam92 ) 

 
Else 
Dlam9 = oo16pi2* betalam91 
End If 
 
 
Call Chop(Dlam9) 

!-------------------- 
! lam8 
!-------------------- 
 
betalam81  = 0

 
 
If (TwoLoopRGE) Then 
betalam82 = 0

 
Dlam8 = oo16pi2*( betalam81 + oo16pi2 * betalam82 ) 

 
Else 
Dlam8 = oo16pi2* betalam81 
End If 
 
 
Call Chop(Dlam8) 

!-------------------- 
! lamh 
!-------------------- 
 
betalamh1  = 0

 
 
If (TwoLoopRGE) Then 
betalamh2 = 0

 
Dlamh = oo16pi2*( betalamh1 + oo16pi2 * betalamh2 ) 

 
Else 
Dlamh = oo16pi2* betalamh1 
End If 
 
 
Call Chop(Dlamh) 

!-------------------- 
! lam10 
!-------------------- 
 
betalam101  = 0

 
 
If (TwoLoopRGE) Then 
betalam102 = 0

 
Dlam10 = oo16pi2*( betalam101 + oo16pi2 * betalam102 ) 

 
Else 
Dlam10 = oo16pi2* betalam101 
End If 
 
 
Call Chop(Dlam10) 

!-------------------- 
! epsU 
!-------------------- 
 
betaepsU1  = 0

 
 
If (TwoLoopRGE) Then 
betaepsU2 = 0

 
DepsU = oo16pi2*( betaepsU1 + oo16pi2 * betaepsU2 ) 

 
Else 
DepsU = oo16pi2* betaepsU1 
End If 
 
 
Call Chop(DepsU) 

!-------------------- 
! Yu 
!-------------------- 
 
betaYu1  = 0

 
 
If (TwoLoopRGE) Then 
betaYu2 = 0

 
DYu = oo16pi2*( betaYu1 + oo16pi2 * betaYu2 ) 

 
Else 
DYu = oo16pi2* betaYu1 
End If 
 
 
Call Chop(DYu) 

!-------------------- 
! epsD 
!-------------------- 
 
betaepsD1  = 0

 
 
If (TwoLoopRGE) Then 
betaepsD2 = 0

 
DepsD = oo16pi2*( betaepsD1 + oo16pi2 * betaepsD2 ) 

 
Else 
DepsD = oo16pi2* betaepsD1 
End If 
 
 
Call Chop(DepsD) 

!-------------------- 
! epsE 
!-------------------- 
 
betaepsE1  = 0

 
 
If (TwoLoopRGE) Then 
betaepsE2 = 0

 
DepsE = oo16pi2*( betaepsE1 + oo16pi2 * betaepsE2 ) 

 
Else 
DepsE = oo16pi2* betaepsE1 
End If 
 
 
Call Chop(DepsE) 

!-------------------- 
! Yd 
!-------------------- 
 
betaYd1  = 0

 
 
If (TwoLoopRGE) Then 
betaYd2 = 0

 
DYd = oo16pi2*( betaYd1 + oo16pi2 * betaYd2 ) 

 
Else 
DYd = oo16pi2* betaYd1 
End If 
 
 
Call Chop(DYd) 

!-------------------- 
! Ye 
!-------------------- 
 
betaYe1  = 0

 
 
If (TwoLoopRGE) Then 
betaYe2 = 0

 
DYe = oo16pi2*( betaYe1 + oo16pi2 * betaYe2 ) 

 
Else 
DYe = oo16pi2* betaYe1 
End If 
 
 
Call Chop(DYe) 

!-------------------- 
! Yh 
!-------------------- 
 
betaYh1  = 0

 
 
If (TwoLoopRGE) Then 
betaYh2 = 0

 
DYh = oo16pi2*( betaYh1 + oo16pi2 * betaYh2 ) 

 
Else 
DYh = oo16pi2* betaYh1 
End If 
 
 
Call Chop(DYh) 

!-------------------- 
! mu 
!-------------------- 
 
betamu1  = 0

 
 
If (TwoLoopRGE) Then 
betamu2 = 0

 
Dmu = oo16pi2*( betamu1 + oo16pi2 * betamu2 ) 

 
Else 
Dmu = oo16pi2* betamu1 
End If 
 
 
Call Chop(Dmu) 

!-------------------- 
! mH2 
!-------------------- 
 
betamH21  = 0

 
 
If (TwoLoopRGE) Then 
betamH22 = 0

 
DmH2 = oo16pi2*( betamH21 + oo16pi2 * betamH22 ) 

 
Else 
DmH2 = oo16pi2* betamH21 
End If 
 
 
Call Chop(DmH2) 

!-------------------- 
! mEt2 
!-------------------- 
 
betamEt21  = 0

 
 
If (TwoLoopRGE) Then 
betamEt22 = 0

 
DmEt2 = oo16pi2*( betamEt21 + oo16pi2 * betamEt22 ) 

 
Else 
DmEt2 = oo16pi2* betamEt21 
End If 
 
 
Call Chop(DmEt2) 

!-------------------- 
! m12 
!-------------------- 
 
betam121  = 0

 
 
If (TwoLoopRGE) Then 
betam122 = 0

 
Dm12 = oo16pi2*( betam121 + oo16pi2 * betam122 ) 

 
Else 
Dm12 = oo16pi2* betam121 
End If 
 
 
Call Chop(Dm12) 

!-------------------- 
! mh 
!-------------------- 
 
betamh1  = 0

 
 
If (TwoLoopRGE) Then 
betamh2 = 0

 
Dmh = oo16pi2*( betamh1 + oo16pi2 * betamh2 ) 

 
Else 
Dmh = oo16pi2* betamh1 
End If 
 
 
Call Chop(Dmh) 

!-------------------- 
! v 
!-------------------- 
 
betav1  = 0

 
 
If (TwoLoopRGE) Then 
betav2 = 0

 
Dv = oo16pi2*( betav1 + oo16pi2 * betav2 ) 

 
Else 
Dv = oo16pi2* betav1 
End If 
 
 
!-------------------- 
! vv 
!-------------------- 
 
betavv1  = 0

 
 
If (TwoLoopRGE) Then 
betavv2 = 0

 
Dvv = oo16pi2*( betavv1 + oo16pi2 * betavv2 ) 

 
Else 
Dvv = oo16pi2* betavv1 
End If 
 
 
Call ParametersToG162(Dg1,Dg2,Dg3,Dlam1,Dlam2,Dlam4,Dlam3,Dlam7,Dlam5,Dlam6,          & 
& Dlam9,Dlam8,Dlamh,Dlam10,DepsU,DYu,DepsD,DepsE,DYd,DYe,DYh,Dmu,DmH2,DmEt2,             & 
& Dm12,Dmh,Dv,Dvv,f)

Iname = Iname - 1 
 
End Subroutine rge162  

End Module RGEs_radinuZeeHB 
 
