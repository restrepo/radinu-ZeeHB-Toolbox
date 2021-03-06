
static REAL computer_eps=0.;

static void get_eps(void)
{  
   REAL z;
   for(computer_eps=1.E-8;;computer_eps/=1.5){z=1+computer_eps; if(z==1) return;}
}

int calcFunc_ext(void) 
{ int nsub,err,res;
  if(computer_eps==0.) get_eps();  
  res=calcFunc_stat();
  for(nsub=1;nsub<=nprc_ext;nsub++) sqme_ext(nsub,0,NULL,NULL,&err);
  return res;  
}

#define buffSize 100

double sqme_ext(int nsub, double GG,REAL*momenta,REAL*cb_coeff, int * err)
{
  int i,nperm,shift, ntot=nin_ext+nout_ext,cb_pow=cb_ext[nsub-1].pow;
  REAL result, momenta_[4*maxNp], cb_buf_[buffSize],*cb_buff=NULL;

  if(!momenta){ darr[nsub-1](GG,NULL,NULL,err); return 0;}

  if(nin_ext==2)
  { double dp0=momenta[0]*momenta[4]-momenta[1]*momenta[5] 
    - momenta[2]*momenta[6]- momenta[3]*momenta[7];
    HelicityN[0]=Helicity[0]/dp0;
    HelicityN[1]=Helicity[1]/dp0;
  }

  if(cb_coeff) for(i=0;i<cb_pow;i++) cb_coeff[i]=0;
   
  Fmax=0; 
  result=darr[nsub-1](GG,momenta,cb_coeff,err);
  nperm=permMap[nsub-1][1];
  if(nperm)
  { int n; 
     shift=permMap[nsub-1][0];
     if(cb_coeff && cb_pow)
     { if(cb_pow<=buffSize) cb_buff=cb_buf_; else cb_buff=malloc(sizeof(REAL)*cb_pow); }

     for(n=0;n<nperm;n++)
     { 
       if(cb_buff) for(i=0;i<cb_pow;i++) cb_buff[i]=0;
       for(i=0;i<ntot;i++) memcpy(momenta_+i*4,momenta+ 4*(permP[shift+n][i]-1),sizeof(REAL)*4);
       result+=darr[nsub-1](GG,momenta_,cb_coeff,err);
       if(cb_buff) for(i=0;i<cb_pow;i++) cb_coeff[permC[shift+n][i]-1]+=cb_buff[i];
     }
     result/=(1+nperm);
     if(cb_coeff) for(i=0;i<cb_pow;i++) cb_coeff[i]/=1+nperm;
     if(cb_buff && cb_buff !=cb_buf_) free(cb_buff);
  }
  if(!(*err) && Fmax*computer_eps*100 > (result>0 ? result : -result) )
  { *err=1; result=0;}

   return (double)result;
}
