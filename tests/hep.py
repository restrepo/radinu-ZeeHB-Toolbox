import pyslha #pip install pyslha --upgrade
import numpy as np
import commands
import os
import re
import pandas as pd
import sys
from cmdlike import *
import pdg_series

def _append_ssp(spcfile='SPheno.spc.radinert',sspfile='SPheno.ssp.radinert',):
    try: 
        f=open(spcfile, 'r')
    except : # whatever reader errors you care about
        sys.exit('LesHouches file not found')
    fspc=f.readlines()
    if os.path.exists(sspfile):
        fssp=open(sspfile, 'a')
    else:
        fssp=open(sspfile, 'w')
    fssp.writelines(fspc)
    fssp.write('ENDOFPARAMETERFILE\n')
    fssp.close()
    f.close()
#expanda pyslha
def _init_LHA(blocks=['NAME1','NAME2']):
    dblocks=pyslha._dict('Blocks')
    if type(blocks) is not list:
        blocks=[blocks]
         
    for b in blocks:
        dblocks[b]=pyslha.Block(b)
        
    return pyslha.Doc(dblocks)

pyslha.initSLHA=_init_LHA

def _readSLHAFile_with_comments(spcfile,ignorenomass=False,ignorenobr=True):
    import pyslha
    import os
    import re
    import sys
    
    if os.path.exists(spcfile):
       with open(spcfile, 'r') as f:
           try:
               input_file=f.readlines()
           except : # whatever reader errors you care about
               sys.exit('LesHouches file not found')
                    
    IF=pyslha.readSLHAFile(spcfile,ignorenomass=ignorenomass,ignorenobr=ignorenobr)
    lspaces=15;lspacesmin=3

    for l in input_file:
        l=l.split('\n')[0]
        if re.search('^block',l.lower()):
            if len(l.split())>=2:
                block=l.split()[1].upper()
        else:
            if not re.search('^\s*#',l):
                fline=l.split('#')
                entries=fline[0].split()
                if len(entries)==2:
                    spaces=lspaces-len(entries[1])
                    if spaces<0:
                        spaces=lspacesmin
                
                    IF.blocks[block].entries[int(entries[0])]='%s%s #%s' %(entries[1],' '*spaces,fline[1])
                if len(entries)==3:
                    spaces=lspaces-len(entries[2])
                    if spaces<0:
                        spaces=lspacesmin
                    
                    IF.blocks[block].entries[int(entries[0]),int(entries[1])]='%s%s #%s' %(entries[2],' '*spaces,fline[1])
    return IF

def block_to_series(block,simplify_key=True):
    bs={}
    vk=[ re.sub('\s+','',l).split('#') for l in block.entries.values()]
    for i in vk:
        if len(i)>1:
            key=i[1]
            if simplify_key:
                key=re.sub('[^A-Za-z0-9]','',key)
                key=re.sub('Input$','',key)
                
            bs[key]=eval(i[0])

    return pd.Series(bs)

class model(object):
    pdg=pdg_series.pdg()
    G_F    =1.166370E-05    # G_F,Fermi constant
    alpha_s=1.187000E-01    #(MZ) SM MSbar
    M_Z    =9.118870E+01    # Z-boson pole mass'
    m_b    =4.180000E+00    # m_b(mb) SM MSbar
    m_top  =1.735000E+02    # m_top(pole)
    mtau   =1.776690E+00    # m_tau(pole)
    m_h0   =125. #Higg mass
    vev    =1./np.sqrt(np.sqrt(2)*G_F)
    #FIX pdgs
    pdg['h0']=25;pdg['H0']=35;pdg['A0']=36;pdg['Hp']=37;pdg['Hm']=-37
    def __init__(self,MODEL='SM',ignorenobr=True,ignorenomass=True,updateSMINPUTS=False,\
                 SPHENO_PATH='../SPHENO',low=False,spc_input_file=None):
        if spc_input_file:
            spcfile=spc_input_file
        else:
            spcfile='%s/%s/Input_Files/LesHouches.in.%s' %(SPHENO_PATH,MODEL,MODEL)
        self.MODEL=MODEL
        self.low=''
        if low:
            self.low='_low'
            spcfile=spcfile%s %self.low
        
        self.LHA=_readSLHAFile_with_comments(spcfile,ignorenobr=ignorenobr,ignorenomass=ignorenomass)
        if self.LHA.blocks.has_key('SMINPUTS') and updateSMINPUTS:
            self.LHA.blocks['SMINPUTS'][2]='%.8E    # G_F,Fermi constant'   %self.G_F
            self.LHA.blocks['SMINPUTS'][3]='%.8E    # alpha_s(MZ) SM MSbar' %self.alpha_s
            self.LHA.blocks['SMINPUTS'][4]='%.8E    # Z-boson pole mass'    %self.M_Z 
            self.LHA.blocks['SMINPUTS'][5]='%.8E    # m_b(mb) SM MSbar'     %self.m_b 
            self.LHA.blocks['SMINPUTS'][6]='%.8E    # m_top(pole)'          %self.m_top 
            self.LHA.blocks['SMINPUTS'][7]='%.8E    # m_tau(pole)'          %self.mtau
        if self.LHA.blocks.has_key('SPHENOINPUT'):
            self.LHA.blocks['SPHENOINPUT'][ 13]='1               # 3-Body decays: none (0), fermion (1), scalar (2), both (3)'
            self.LHA.blocks['SPHENOINPUT'][ 12]='1.000E-15       # write only branching ratios larger than this value'
            self.LHA.blocks['SPHENOINPUT'][ 15]='1.000E-40       # write only decay if width larger than this value'
            self.LHA.blocks['SPHENOINPUT'][ 50]='0               # Majorana phases: use only positive masses'
            self.LHA.blocks['SPHENOINPUT'][ 52]='1               # Write spectrum in case of tachyonic states'

    def phys_to_gen(self,v=2.38711864E+02):
        self.lambda_sm=self.m_h0**2/v**2
        perturbativity=True
        if np.abs(self.lambda_sm).max()>8*np.pi:
            perturbativity=False
        return perturbativity

    def to_series(self):
        bs=pd.Series()
        for b in self.LHA.blocks.keys():
            if b not in ['MODSEL','SPHENOINPUT']:
                bs=bs.append(block_to_series(self.LHA.blocks[b]))
                vk=[ re.sub('\s+','',l).split('#') for l in self.LHA.blocks[b].entries.values()]
                for i in vk:
                    if len(i)>1:
                        key=re.sub('[^A-Za-z0-9]','',i[1])
                        key=re.sub('Input$','',key)
                        bs[key]=eval(i[0])

        self.Series=pd.Series(bs)
    
        
    
    
class hep(model):
    '''
    Configure and run specific HEP tools. See self.config for details
    '''
    config={}
    config['SPHENO_PATH']='../SPHENO/bin'
    config['SPHENO_COMMAND']='' #Empty string for default SARAH-Toolbox SPHENO commnand
    config['SPHENO_LHA_INPUT']='' #Empty string for default SARAH-Toolbox SPHENO LHA input
    convert={'USAGE': "(N [A])*1=(N [A])*convert[B/A] -> (N [B])"}
    convert['m/(1/GeV)']=1.973269718E-16 # m/GeV^{-1}
    convert['s/(1/GeV)']=6.58211899E-25 # s/GeV^{-1}
    convert['m^2/pb']=1E-40 #m^2/pb       m^2/b*(1E-12b/pb) 
    convert['pb/(1/GeV^2)']=(convert['m/(1/GeV)']**2)/convert['m^2/pb'] # $1m^2/(GeV^{-2})/(m^2/pb)=pb/GeV^{-2}
    #print "Using: config['SPHENO_PATH']='../SPHENO/bin'"
    def __init__(self, *args, **kwargs):
        "See: http://stackoverflow.com/questions/23027846/def-init-self-args-kwargs-initialization-of-class-in-python"
        super(hep, self).__init__(*args, **kwargs) 
        #self.MODEL='radinert'
        self.Gamma={} #Widths
        self.Br={} #branchings
        

    def runSPheno(self,LHA=None,SSP=False,DEBUG=False):
        """
        Set self.config for PATHS. 
        Using defatull SARAH Toolbox SPHENO command. 
        Return back a pyslha.Doc object for LHA model.
        Designed to change for other MODEL easily
        Set self.config['SPHENO_PATH']. 
        Self self.config['SPHENO_COMMAND'] if not using 
        default SARAH SPHENO executable
        """
        if not LHA:
            LHA=self.LHA
        if self.config['SPHENO_LHA_INPUT']=='':
            inputLHA='LesHouches.in.%s%s' %(self.MODEL,self.low)
        else:
            inputLHA=self.config['SPHENO_LHA_INPUT']
        if self.config['SPHENO_COMMAND']=='':
            SPheno_bin_command='SPheno'+self.MODEL #Default SARAH toolbox command
        else:
            SPheno_bin_command=self.config['SPHENO_COMMAND']
        #writeLHAinFile(xdict,inputLHA)
        pyslha.writeSLHAFile(inputLHA,LHA)
        a=commands.getoutput('%s/%s %s' %(self.config['SPHENO_PATH'],SPheno_bin_command,inputLHA))
        if DEBUG:
            print(a)
        assert os.path.isfile('SPheno.spc.%s' %self.MODEL)
        #print a
        #exceptions
        if a.find('Problem in OneLoop')>-1:
            a=a.replace('Problem','No problem')

        if a.find('Problem')==-1:
            self.LHA_out=pyslha.readSLHAFile('SPheno.spc.%s' %self.MODEL)
            #with comments but without decays
            a=commands.getoutput("cat  SPheno.spc.%s | grep -m 1 -i -B1000 '^decay' | grep -vi '^decay' >  SPheno.spc.%s_nodecays.spc" %(self.MODEL,self.MODEL))
            if os.path.isfile("SPheno.spc.%s_nodecays.spc" %self.MODEL):
                self.LHA_out_with_comments=_readSLHAFile_with_comments("SPheno.spc.%s_nodecays.spc" %self.MODEL)
                #PDG for new particles
                for pid in self.LHA_out_with_comments.blocks['MASS'].entries:
                    if np.abs(pid)>25:
                        pvalues=self.LHA_out_with_comments.blocks['MASS'].entries[pid].split('#')
                        if len(pvalues)==2:
                            self.pdg[pvalues[1].strip()]=pid

            
        else:
            self.LHA_out=False
            self.LHA_out_with_comments=False

        #CREATES SSP file: TODO: add new block in micromegas_output()
        if SSP:
            _append_ssp('SPheno.spc.%s' %self.MODEL,'SPheno.ssp.%s' %self.MODEL)
            
        self.to_series() #Fill to_Series pandas Series    
        return self.LHA_out
        
    def branchings(self,SPCdecays,min_pdg=26):
        "Convert decays blocks into widhts and branchings: Input: SPC.decays"
        for i in SPCdecays.keys():
            self.Br[i]={}
            self.Gamma[i]=SPCdecays[i].totalwidth
            for j in range( len(SPCdecays[i].decays) ):
                self.Br[i][tuple(SPCdecays[i].decays[j].ids)]=SPCdecays[i].decays[j].br
                
        self.Br_names=pd.Series()


        for k in self.Br.keys():
            if np.abs(k)>=min_pdg:
                if k in self.pdg.pdg_id.index:
                    brchm='%s -> ' %self.pdg.pdg_id[k]
                else: 
                    brchm='%unknown -> '
                for kd in self.Br[k].keys():
                    if len(kd)==2:
                        if kd[0] in self.pdg.pdg_id.index and kd[1] in self.pdg.pdg_id.index:
                            brch=brchm+' '+self.pdg.pdg_id[kd[0]]+' '+self.pdg.pdg_id[kd[1]]
                        else:
                            brch=brchm+' unknown'
                
                        self.Br_names[brch]=self.Br[k][kd]
                    if len(kd)==3:
                        if kd[0] in self.pdg.pdg_id.index and kd[1] in self.pdg.pdg_id.index and kd[2] in self.pdg.pdg_id.index:
                            brch=brchm+' '+self.pdg.pdg_id[kd[0]]+' '+self.pdg.pdg_id[kd[1]]+' '+self.pdg.pdg_id[kd[2]]
                        else:
                            brch=brchm+' unknown'
                            
                        self.Br_names[brch]=self.Br[k][kd]
        for k in self.Gamma:
            if k>=min_pdg:
                self.Br_names['Gamma_%s' %self.pdg.pdg_id[k]]=self.Gamma[k] 

        return SPCdecays.keys()
    
    def micromegas_output(self,mo,Omega_h2='Omega_h2'):
        self.micromegas=pd.Series()
        fltchk='^[0-9\.eE\-\+]+$'
        omgf=grep('^Xf=',mo)
        if len(omgf.split('n') )==1:
            omgl=omgf.split('=')
            if len(omgl)==3:
                if re.search(fltchk,omgl[2]):
                    self.micromegas[Omega_h2]=eval(omgl[2])
                else:    
                    self.micromegas[Omega_h2]=omgl[2]
                    
        omgf=grep('^\s*[neuprotn]',mo)
        if len(omgf.split('n') )>1:
            for ddpn in omgf.split('\n')[-2:]: # CDM[antiCDM]-nucleon cross sections[pb]:
                ddpornl=re.sub('^\s*([neuprotn])',r'\1',ddpn) #clean extra spaces ...       
                ddpornl=re.sub('\s*\[[0-9\.eE\-\+]*]','', ddpornl )
                ddpornl=re.sub('\s{2,}',' ',ddpornl)
                ddporn=ddpornl.split(' ') #[ proton|neutron,SI,SI_value,SD,SD_value]
                if len(ddporn)==5:
                    #self.micromegas[ddporn[0]]=pd.Series()
                    for i in [1,3]:
                        if re.search(fltchk,ddporn[i+1]):
                            self.micromegas['%s_%s' %(ddporn[0],ddporn[i])]=eval(ddporn[i+1])
                        else:
                            self.micromegas['%s_%s' %(ddporn[0],ddporn[i])]=ddporn[i+1]

        omgf=grep('annihilation cross section',mo)
        idcs=omgf.split(' ')
        if len(idcs)>1:
            if re.search(fltchk,idcs[-2]):
                self.micromegas['sigmav']=eval(idcs[-2])
         
        idc=grep('^\s+~.*->.*[0-9]$',mo)
        if idc:
            for ch in idc.split('\n'):
                chnl=re.sub('\s{2,}',':',re.sub('^\s+','',ch)).split(':') #values separated by 2 spaces
                if len(chnl)==2:
                    if re.search(fltchk,chnl[1]):
                        self.micromegas[ 'ID_br:%s' %chnl[0] ]=eval(chnl[1])
        
        f='channels.out'
        if os.path.isfile('channels.out'):
            f=open(f,'r').read()
            fvalues=re.sub(r'.*\s+([01]\.[0-9]+)',r'\1', re.sub('#.*','',f)).split('\n')
            if len(fvalues)>0:
                fvalues=map(float,fvalues[:-1])
                fkeys=re.sub('.*#\s+','O_chnl:',f).split('\n')[:-1]
                Omega_channels=pd.Series(data=fvalues,index=fkeys)
                if Omega_channels.shape[0]>0:
                    self.micromegas=self.micromegas.append(Omega_channels)
                    
        return mo
    
    def run_micromegas(self,func,param={},path='../micromegas',
                  var_min=60,var_max=1000,npoints=1,scale='log',CI=False):
        '''DEPRECATED. See runmicromegas scanmicromegas Run micromegas with 
         output in MODEL.csv
         func -> func(x,lha,param={'block_key':'MINPAR',block_key=5}) and returns lha
         path='../micromegas';var_min=60;
         var_max=1000;npoints=2;scale='log';CI=True'''

        df=pd.DataFrame()
        i=0
        if scale=='log':
            xrange=np.logspace(np.log10(var_min),np.log10(var_max),npoints)
        elif scale=='lin':
            xrange=np.linspace(var_min,var_max,npoints)
        
        for x in xrange:
            i=i+1
            if i%10==0: print i
            if param:
                self.LHA=func(x,self.LHA,param=param)
            else:
                self.LHA=func(x,self.LHA)
            if CI: #see defintion of to_Yukawas in class CasasIbarra(hep) below,
                h,U,Mnuin,phases=self.to_yukawas() #test Mnuin/0.9628#/0.968
            spc=self.runSPheno()
            oh=commands.getoutput('%s/%s/CalcOmega SPheno.spc.%s' %(path,self.MODEL,self.MODEL) )
            oh2=-1
            ll=oh.split('Omega h^2=')
            if len(ll)>1:
                oh2=eval(ll[1].split('\n')[0])
        
        
            self.to_series()
            self.Series['Omega_h2']=oh2
            df=df.append(self.Series,ignore_index=True)
            df.to_csv('Scotogenic.csv')
        return df

    def runmicromegas(self,path='../micromegas',Direct_Detection=False,ddcmd='CalcOmega_with_DDetection_MOv4.2'):
        '''
        Run micromegas with output in MODEL.csv
        '''

        spc=self.runSPheno()
        mocmd='CalcOmega'
        if Direct_Detection:
            if os.path.isfile( '%s/%s/%s' %(path,self.MODEL,ddcmd) ):
                mocmd=ddcmd
            else:
                sys.exit( 'ERROR: %s not found' %(ddcmd) )
                
            
        oh=commands.getoutput( '%s/%s/%s SPheno.spc.%s' %(path,self.MODEL,mocmd,self.MODEL) )
        mo=self.micromegas_output(oh)
        self.to_series() #Fill to_Series pandas Series
        self.Series=self.Series.append(self.micromegas)

        return mo

    def scanmicromegas(self,func,param={},path='../micromegas',
                       var_min=60,var_max=1000,npoints=1,scale='log',CI=False,Direct_Detection=False,ddcmd='CalcOmega_with_DDetection_MOv4.2'):
        '''Run micromegas with output in MODEL.csv
         func -> func(x,lha,param={'block_key':'MINPAR',block_key=5}) and returns lha
         path='../micromegas';var_min=60;
         var_max=1000;npoints=2;scale='log';CI=True'''

        df=pd.DataFrame()

        mocmd='CalcOmega'
        if Direct_Detection:
            if os.path.isfile( '%s/%s/%s' %(path,self.MODEL,ddcmd) ):
                mocmd=ddcmd
            else:
                sys.exit( 'ERROR: %s not found' %(ddcmd) )

        
        i=0
        if scale=='log':
            xrange=np.logspace(np.log10(var_min),np.log10(var_max),npoints)
        elif scale=='lin':
            xrange=np.linspace(var_min,var_max,npoints)
        
        for x in xrange:
            i=i+1
            if i%10==0: print i
            if param:
                self.LHA=func(x,self.LHA,param=param)
            else:
                self.LHA=func(x,self.LHA)
            if CI: #see defintion of to_Yukawas in class CasasIbarra(hep) below,
                h,U,Mnuin,phases=self.to_yukawas() #test Mnuin/0.9628#/0.968

            self.to_series()
            mo=series.runmicromegas(path,Direct_Detection=Direct_Detection,ddcmd=ddcmd)
            self.Series['Omega_h2']=mo.Omega_h2
            self.Series['proton_SI']=mo.proton.SI
            self.Series['neutron_SI']=mo.neutron.SI
            df=df.append(self.Series,ignore_index=True)
            df.to_csv('Scotogenic.csv')
        return df

class THDM(model):
    '''
    All parameters in the several basis with functions to get the missing ones
    th=THDM()
    self.general -> dict with general
    '''
    MESSAGE="THDM-III implementation based on https://2hdmc.hepforge.org/"
    import numpy as np
    def __init__(self, *args, **kwargs):
        "See: http://stackoverflow.com/questions/23027846/def-init-self-args-kwargs-initialization-of-class-in-python"
        super(THDM, self).__init__(*args, **kwargs)
        #LHA
        if self.LHA.blocks.has_key('EPSUIN'):
            for bly in ['EPSUIN','EPSDIN','EPSEIN']:
                for i in range(1,4):
                    for j in range(1,4):
                        self.LHA.blocks['%s' %bly][i,j]="%.8E      #%s(%d,%d)" %(0,bly,i,j)
        else:
            print "Use proper blocks !" 

        #general
        self.lambdas=np.zeros(8)
        self.m22_2=0.
        #Physical
        self.m_h0=125.;self.m_H0=300.;self.m_A0=400.;self.m_Hp=500.
        self.tanb=1;self.lambdas[6]=0.1;self.lambdas[7]=0.1;self.m12_2=1E6
        self.sab=0.1
        self.lambdaL=0.01
        
    def __call__(self):
        print lambdas
        print("call")
    def phys_to_gen(self,v=2.38711864E+02):
        '''based on  https://2hdmc.hepforge.org/ src: THDM.cpp:  '''
        #GF = eval(LHA.blocks['SMINPUTS'][2])
        beta=np.arctan(self.tanb);
        sb = np.sin(beta)
        sb2 = sb*sb            
        cb = np.cos(beta);    
        cb2 = cb*cb;            
        tb = np.tan(beta);    
        ctb = 1./tb;                                    
        alpha = -np.arcsin(self.sab)+beta;
        sa  = np.sin(alpha);       
        sa2 = sa*sa;            
        ca  = np.cos(alpha);       
        ca2 = ca*ca;                                    
        cab = np.sqrt(1.-self.sab*self.sab); 
        v2=v**2 #1./(np.sqrt(2.)*GF);

        self.lambdas[1]=( (self.m_H0*self.m_H0*ca2+self.m_h0*self.m_h0*sa2-self.m12_2*tb)/v2/cb2\
              -1.5*self.lambdas[6]*tb+0.5*self.lambdas[7]*tb*tb*tb )/2.
        self.lambdas[2]=( (self.m_H0*self.m_H0*sa2+self.m_h0*self.m_h0*ca2-self.m12_2*ctb)/v2/sb2\
              +0.5*self.lambdas[6]*ctb*ctb*ctb-1.5*self.lambdas[7]*ctb )/2.
        self.lambdas[3]=((self.m_H0*self.m_H0-self.m_h0*self.m_h0)*ca*sa+2.*self.m_Hp*self.m_Hp*sb*cb\
              -self.m12_2)/v2/sb/cb-0.5*self.lambdas[6]*ctb-0.5*self.lambdas[7]*tb
        self.lambdas[4]=((self.m_A0*self.m_A0-2.*self.m_Hp*self.m_Hp)*cb*sb+self.m12_2)/v2/sb/cb\
              -0.5*self.lambdas[6]*ctb-0.5*self.lambdas[7]*tb;
        self.lambdas[5]=(self.m12_2-self.m_A0*self.m_A0*sb*cb)/v2/sb/cb-0.5*self.lambdas[6]*ctb\
              -0.5*self.lambdas[7]*tb;
        m22_2 = -0.5/sb*(self.m_h0**2*ca*self.sab+self.m_H0**2*sa*cab)+self.m12_2*ctb
        sinba = self.sab
        perturbativity=True
        if np.abs(self.lambdas).max()>8*np.pi:
            perturbativity=False
        return perturbativity

    def test_phys_to_gen(self):
        pass    
    
    def higgs_to_phys(self,v=2.38711864E+02):
        v2=v**2
        beta=0;
        self.m22_2=self.m_Hp*self.m_Hp-0.5*v2*self.lambdas[3];
        self.m11_2=-0.5*lambdas[1]*v2
        self.m12_2=0.5*lambdas[6]*v2

        m_A2 = self.m_Hp*self.m_Hp-0.5*v2*(self.lambdas[5]-self.lambdas[4]);
  
        s2ba = -2.*self.lambdas[6]*v2;
        c2ba = -(m_A2+(self.lambdas[5]-self.lambdas[1])*v2);
        #Handle special case with degenerate masses
        #if np.abs(s2ba)>sqrt(DBL_EPSILON))||(abs(c2ba)>sqrt(DBL_EPSILON))) {
        bma  =  0.5*np.atan2(s2ba,c2ba);
        self.sinba = sin(bma);
        if m_A2>0:
            self.m_A0 = np.sqrt(m_A2)
        else:
            self.m_A0=1j*np.sqrt(np.abs(m_A2))
     
        if np.abs(self.lambdas).max()>8*np.pi:
            perturbativity=False
        return perturbativity
    def idm(self,v=246.2):
        #self.m_Hp=2090.99
        #self.m_A0=2100.26
        #self.m_H0=2088.3
        #self.m_h0=125.
        
        self.lambdas[1]=self.m_h0**2/v2
        self.lambdas[3]=2.*(self.m_Hp**2-self.m_H0**2+self.lambdaL*v2)/v2
        self.lambdas[4]=(self.m_H0**2+self.m_A0**2-2.*self.m_Hp**2)/v2
        self.lambdas[5]=(self.m_H0**2-self.m_A0**2)/v2
        self.lambdas[6]=0.
        self.lambdas[7]=0.
        self.m12_2=0.
        self.m22_2=self.m_H0**2 - self.lambdaL*v2
        self.m11_2=-self.m_h0**2/2
        
    def test_higgs_to_phys(self):
        pass    

def neutrino_data(CL=3,IH=False,mnu1in=1E-5*1E-9):
    import numpy as np
    '''From arxiv:1611.01514 (Table 1)
    and asumming a Normal Hierarchy:
    Output:
    mnulin: lightest neutrino mass: l=1 or l=3
    Dm21_2: \Delta m^2_{12}
    Dm3l_2: \Delta m^2_{l3}: l=1 or l=3
    theta12,theta23,theta13: in radians
    '''
    to_rad=np.pi/180.
    Dm21_2_bfp=7.50e-5; Dm3l_2_bfp=2.524e-3; theta12_bfp=33.56
    theta23_bfp=41.6; theta13_bfp=8.46; delta_bfp=261.
    Dm3l_2_bfp_IH=2.514e-3; theta23_bfp_IH=50.
    theta13_bfp_IH=8.49; delta_bfp_IH=277.
    if CL==3:
        Dm21_2=np.array([7.03e-5, Dm21_2_bfp, 8.09e-5])*1e-18 # In GeV
        Dm3l_2=np.array([2.407e-3, Dm3l_2_bfp, 2.643e-3])*1e-18 # In GeV
        if IH:
            Dm3l_2=np.array([2.399e-3,  Dm3l_2_bfp_IH, 2.635e-3])*1e-18 # In GeV
        #input real values:
        #
        theta12 = np.array([31.38,  theta12_bfp,  35.99])*to_rad 
        theta23 = np.array([38.4,  theta23_bfp,  52.8])*to_rad
        if IH:
            theta23 = np.array([38.8,  theta23_bfp_IH,  53.1])*to_rad
        theta13 = np.array([7.99, theta13_bfp, 8.90])*to_rad
        if IH:
            theta13 = np.array([8.03, theta13_bfp_IH, 8.93])*to_rad
            
        delta=np.array([0.,delta_bfp,360.])*to_rad
        if IH:
            delta=np.array([145.,delta_bfp_IH,391.])*to_rad
    elif CL==1:
        Dm21_2=np.array([Dm21_2_bfp-0.17e-5,Dm21_2_bfp,Dm21_2_bfp+0.19e-5 ])*1e-18 # In GeV
        Dm3l_2=np.array([Dm3l_2_bfp-0.040e-3,Dm3l_2_bfp,Dm3l_2_bfp+0.039e-3 ])*1e-18 # In GeV
        if IH:
            Dm3l_2=np.array([Dm3l_2_bfp_IH-0.041e-3,Dm3l_2_bfp_IH, Dm3l_2_bfp_IH+0.038e-3])*1e-18 # In GeV
        #input real values:
        #
        theta12 = np.array([theta12_bfp-0.75,theta12_bfp,theta12_bfp+0.77])*to_rad 
        theta23 = np.array([theta23_bfp-1.2,theta23_bfp,theta23_bfp+1.5])*to_rad
        if IH:
            theta23 = np.array([theta23_bfp_IH-1.4,theta23_bfp_IH,theta23_bfp_IH+1.1])*to_rad
        theta13 = np.array([theta13_bfp-0.15, theta13_bfp, theta13_bfp+0.15])*to_rad
        if IH:
            theta13 = np.array([theta13_bfp_IH-0.15, theta13_bfp_IH, theta13_bfp_IH+0.15])*to_rad
        delta=np.array([delta_bfp-59,delta_bfp,delta_bfp+51])*to_rad
        if IH:
            delta=np.array([delta_bfp_IH-46,delta_bfp_IH,delta_bfp_IH+40])*to_rad
    

    return mnu1in,Dm21_2,Dm3l_2,theta12,theta23,theta13,delta

def UPMNS(t12=33.56*np.pi/180.,t13=8.46*np.pi/180.,t23=41.6*np.pi/180.,delta=0,eta1=0,eta2=0):
    """
    UPMS matrix with default values from normal ordering of 1611.01514
    """
    U12 = np.array([ [np.cos(t12),np.sin(t12),0], [-np.sin(t12),np.cos(t12),0], [0,0,1.0] ])
    U13 = np.array([ [np.cos(t13),0,np.sin(t13)*np.exp(-delta*1j)], [0,1.0,0],\
                         [-np.sin(t13)*np.exp(delta*1j),0,np.cos(t13)] ])
    if delta==0:
        U13=np.real(U13)
    U23 = np.array([ [1.0,0,0], [0,np.cos(t23),np.sin(t23)], [0,-np.sin(t23),np.cos(t23)] ])
    Uphases = np.diag([1.,np.exp(eta1*1j/2.),np.exp(eta2*1j/2.)])
    if eta1==0 and eta2==0:
        Uphases=np.real(Uphases)
    return ((U23.dot(U13)).dot(U12)).dot(Uphases)

class CasasIbarra(hep):
    '''
    Fill SPhenoInput with Yukawas compatible with neutrino pysics
    Define a function: func to calculate the Yukawa independent parameters of the
    analytical neutrino mass matrix with use a pyslha object as input, e.g
       def _Lambda(LHA_out):
       mH0=LHA.blocks['MASS'][1001]
       ...
       #Casas Ibarra inverse high energy input matrix Lambda...
       return np.diag( Casas Ibarra inverse high energy input matrix Lambda  )
       
    Yuk_key: key for Yukawa block for input LesHoches File
    
    '''
    def __init__(self,func,Yuk_key='YNIN',norotate1=False,norotate2=False,norotate3=False,bestfit=False,\
                    nophases=True,massless_nulight=False,min_nulight=1E-9,max_nulight=0.5,\
                    IH=False,R_complex=False,min_angle=0,CL=3, *args, **kwargs):
        "See: http://stackoverflow.com/questions/23027846/def-init-self-args-kwargs-initialization-of-class-in-python"
        super(CasasIbarra, self).__init__(*args, **kwargs)
        self.CI_opt=pd.Series({'norotate1':norotate1,'norotate2':norotate2,'norotate3':norotate3,\
                               'bestfit':bestfit,'nophases':nophases,\
                               'massless_nulight':massless_nulight,'min_nulight':min_nulight,\
                               'max_nulight':max_nulight,'IH':IH,\
                               'R_complex':R_complex,'min_angle':min_angle,'CL':CL})
        #print self.to_Series()
        self.func=func
        self.Yuk_key=Yuk_key
        
    def to_yukawas(self):
        """
        min_nulight=1E-9,
        max_nulight=0.5 in eV: pdg neutrino review
           NH: nu1<nu2<nu3
        We assume mass ordering for Heavy particles but inverse hierarchy (IH) for neutrinos could imply:
           IH: nu3<nu1<nu2
        di.keys()-> ['MH0','MA0','Mtr01','Mtr02','Mtr03',]
        """
        import numpy as np
        import pandas as pd
        norotate1       =self.CI_opt.norotate1
        norotate2       =self.CI_opt.norotate2
        norotate3       =self.CI_opt.norotate3
        bestfit         =self.CI_opt.bestfit
        nophases        =self.CI_opt.nophases
        massless_nulight=self.CI_opt.massless_nulight
        min_nulight     =self.CI_opt.min_nulight
        max_nulight     =self.CI_opt.max_nulight
        IH              =self.CI_opt.IH
        R_complex       =self.CI_opt.R_complex
        min_angle       =self.CI_opt.min_angle
        CL              =self.CI_opt.CL
        
        if massless_nulight:
            norotate2=True #R13=1
            if not IH:
                #cos(t_2)=R_{12}; sin(t_2)=R_{13}
                #sqrt(m_2)cos(t_2)U^*_{i2}+sqrt(m_3)sin(t_2)U^*_{i3}
                #-sqrt(m_2)sin(t_2)U^*_{i2}+sqrt(m_3)cos(t_2)U^*_{i3}
                norotate1=True #R12=1
            else:
                #cos(t_1)=R_{11}; sin(t_1)=R_{12}
                #sqrt(m_1)cos(t_1)U^*_{i1}+sqrt(m_2)sin(t_1)U^*_{i2}
                #-sqrt(m_2)sin(t_1)U^*_{i1}+sqrt(m_2)cos(t_1)U^*_{i2}
                norotate3=True #R23=1
            
            
        
        ignore,Dms2,Dma2,ThetSol,ThetAtm,ThetRec,deltaD=neutrino_data(CL=CL,IH=IH) 
     
        
        #Inverse MR masses. M^R_3 -> infty corresponds to zero entry
        
        spc=self.runSPheno()
        DMR=np.diag(  np.sqrt( np.abs( 1./ self.func(self.LHA_out) ) ) )
        
        if massless_nulight and not IH:
            DMR[0,0]=0. 
        if massless_nulight and IH:
            DMR[2,2]=0. 
        
        #print self.func(self.LHA_out)
        #print DMR
        #phases of the PMNS matrix
        
        delta=1.*(0 if nophases else np.random.uniform(deltaD[0],deltaD[2]))
        eta1 =1.*(0 if nophases else np.random.uniform(0.,np.pi)) 
        eta2 =1.*(0 if nophases else np.random.uniform(0.,np.pi))
        if bestfit:
            delta=deltaD[1]
        
        if not IH:
            mnu1=1.*(0. if massless_nulight else np.exp(np.random.uniform(np.log(min_nulight),np.log(max_nulight)))*1e-9 ) 
            #m_3=m_3^2-m_1^2+m_1^2
            mnu3=1.*(np.sqrt(Dma2[1]+mnu1**2)     if bestfit else  np.sqrt(np.random.uniform(Dma2[0],Dma2[2]) + mnu1**2) )
        else:
            mnu3=1.*(0. if massless_nulight else np.exp(np.random.uniform(np.log(min_nulight),np.log(max_nulight)))*1e-9 )
            #m_1=|m_3^2-m_1^2|+m_3^2=m_1^2-m_3^2+m_3^2=
            mnu1=1.*(np.sqrt(Dma2[1]+mnu3**2)     if bestfit else  np.sqrt(np.random.uniform(Dma2[0],Dma2[2]) + mnu3**2) )
     
        #m_2=m_2^2-m_1^2+m_1^2    
        mnu2=1.*(np.sqrt(Dms2[1]+mnu1**2)     if bestfit else  np.sqrt(np.random.uniform(Dms2[0],Dms2[2]) + mnu1**2) ) 
     
     
        #light neutrino masses only for an estimation 
        #mnu1=0
        #mnu2=sqrt(8.2e-5*1e-18+mnu1**2)
        #mnu3=sqrt(2.74e-3*1e-18+mnu1**2)
        
        #Square root of left-handed nuetrino mass matrix 
        DMnu=np.asarray([ [np.sqrt(mnu1),0,0],[0,np.sqrt(mnu2),0],[0,0,np.sqrt(mnu3)] ])
        
        #mixing angles using 3 sigma data from arxiv:1405.7540 (table I)                        
        #and asumming a Normal Hierarchy'''
     
     
     
        t12 = 1.*( np.arcsin(np.sqrt(ThetSol[1])) if bestfit else np.arcsin(np.sqrt(np.random.uniform(ThetSol[0],ThetSol[2]))))
        t23 = 1.*( np.arcsin(np.sqrt(ThetAtm[1])) if bestfit else np.arcsin(np.sqrt(np.random.uniform(ThetAtm[0],ThetAtm[2]))))
        t13 = 1.*( np.arcsin(np.sqrt(ThetRec[1])) if bestfit else np.arcsin(np.sqrt(np.random.uniform(ThetRec[0],ThetRec[2]))))
        
        
        #Building PMNS matrix: http://pdg.lbl.gov/2014/reviews/rpp2014-rev-neutrino-mixing.pdf
        
        U=UPMNS(t12,t13,t23,delta,eta1,eta2)
        #print U-np.dot(U23,np.dot(U13,np.dot(U12,Uphases)))
        #Building R matrix of the Casas-Ibarra parametrization
        
        
        min_real=min_angle
        max_real=2.*np.pi
        phases2=np.random.uniform(min_real,max_real ,3) 
        if R_complex:
            min_imag=1E-12
            max_imag=20. #2E-1
            phases2=phases2+1j*np.exp(np.random.uniform(\
                                np.log(min_imag),np.log(max_imag) ,3) )*np.random.choice([1,-1])
        
     
        b12 = 1.*(0 if norotate1 else phases2[0])
        b13 = 1.*(0 if norotate2 else phases2[1])
        b23 = 1.*(0 if norotate3 else phases2[2])
        
      
        # R 
        R12 = np.array([ [np.cos(b12),np.sin(b12),0], [-np.sin(b12),np.cos(b12),0], [0,0,1.0] ])
        R13 = np.array([ [np.cos(b13),0,np.sin(b13)], [0,1.0,0], [-np.sin(b13),0,np.cos(b13)] ])
        R23 = np.array([ [1.0,0,0], [0,np.cos(b23),np.sin(b23)], [0,-np.sin(b23),np.cos(b23)] ])
        R=np.dot(R23,np.dot(R13,R12))
        #1assert(np.abs(np.dot(R, R.transpose()))[1,2]<1E-10)
        #Yukawa matrix of the Casas-Ibarra parametrization
        yuk2=np.dot(DMR,np.dot(R,np.dot(DMnu,np.transpose(np.conjugate(U)))))
        for i in range(1,yuk2.shape[0]+1):
            for j in range(1,yuk2.shape[1]+1):
                if R_complex:
                    self.LHA.blocks[self.Yuk_key][i,j]=yuk2[i-1,j-1]
                else:
                    self.LHA.blocks[self.Yuk_key][i,j]='%0.8E       #Yn(%d,%d)' %(yuk2[i-1,j-1].real,i,j)
        return yuk2,U,DMnu.dot(DMnu),phases2
    
    
#    def __call__(self):
#        print lambdas
#        print("call")

    def test(self):
        h,U,Mnuin,phases=self.to_yukawas()
        Lamb = np.diag(self.func(self.LHA_out))
        Mint = np.dot( h.transpose(),np.dot(Lamb,h) )
        
        Mnu,U=np.linalg.eig(Mint) 
        lo=np.argsort(np.abs(Mnu))
        Mnu=np.array([Mnu[lo[0]],Mnu[lo[1]],Mnu[lo[2]]])
        U=np.matrix(U)
        U=np.asarray(np.hstack((U[:,lo[0]],U[:,lo[1]],U[:,lo[2]])))
        print Mnu
        print U    
