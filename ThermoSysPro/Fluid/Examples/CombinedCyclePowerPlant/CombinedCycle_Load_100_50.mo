within ThermoSysPro.Fluid.Examples.CombinedCyclePowerPlant;
model CombinedCycle_Load_100_50 "CCPP model to simulate a load variation from 100% to 50%"
  parameter Real CstHP(fixed=false,start=8316103.829776841)
    "Stodola's ellipse coefficient HP";
  parameter Real CstMP(fixed=false,start=254110.8564593821)
    "Stodola's ellipse coefficient MP";
  parameter Real CstBP(fixed=false,start=10713.964292543395)
    "Stodola's ellipse coefficient BP";
  parameter ThermoSysPro.Units.xSI.Cv CvmaxValveAHP(fixed=false, start=135)
    "Maximum CV: alim. valve HP Drum  ";
  parameter ThermoSysPro.Units.xSI.Cv CvmaxValveAMP(fixed=false, start=70)
    "Maximum CV: alim. valve MP Drum ";
  parameter ThermoSysPro.Units.xSI.Cv CvmaxValveVBP(fixed=false, start=32000)
    "Maximum CV: steam valve BP Drum ";
  parameter Real Encras_SHP1(fixed=false,start=1)
    "Sur HP1: heat exchange fouling coefficient";
  parameter Real Encras_SHP2(fixed=false,start=1)
    "Sur HP2: heat exchange fouling coefficient";
  parameter Real Encras_SHP3(fixed=false,start=1)
    "Sur HP3: heat exchange fouling coefficient";
  parameter Real Encras_EHP1(fixed=false,start=1)
    "Eco HP1: heat exchange fouling coefficient";
  parameter Real Encras_EHP2(fixed=false,start=1)
    "Eco HP2: heat exchange fouling coefficient";
  parameter Real Encras_EHP3(fixed=false,start=1)
    "Eco HP3: heat exchange fouling coefficient";
  parameter Real Encras_EHP4(fixed=false,start=1)
    "Eco HP4: heat exchange fouling coefficient";

  parameter Real Encras_SMP1(fixed=false,start=1)
    "Sur MP1: heat exchange fouling coefficient";
  parameter Real Encras_SMP2(fixed=false,start=1)
    "Sur MP2: heat exchange fouling coefficient";
  parameter Real Encras_SMP3(fixed=false,start=1)
    "Sur MP3: heat exchange fouling coefficient";
  parameter Real Encras_EMP(fixed=false,start=1)
    "Eco MP: heat exchange fouling coefficient";

  parameter Real Encras_EvHP(fixed=false,start=1)
    "Evapo HP: heat exchange fouling coefficient";
  parameter Real Encras_EvMP(fixed=false,start=1)
    "Evapo MP: heat exchange fouling coefficient";
  parameter Real Encras_EvBP(fixed=false,start=1)
    "Evapo BP: heat exchange fouling coefficient";

  parameter Real Encras_SBP(fixed=false,start=1)
    "Sur BP: heat exchange fouling coefficient";
  parameter Real Encras_EBP(fixed=false,start=1)
    "Eco BP: heat exchange fouling coefficient";

  parameter Real KgainChargeHP(fixed=false,start=720.183)
    "HP: Friction pressure loss coefficient";
  parameter Real KgainChargeMP(fixed=false,start=1090.9)
    "MP: Friction pressure loss coefficient";
  parameter Real Kin_SMP2(fixed=false,start=10.)
    "SMPin: Friction pressure loss coefficient";
  parameter Real K_PerteChargeZero2(fixed=false,start=1e-4)
    "TurbineMP out: Friction pressure loss coefficient";

  parameter ThermoSysPro.Units.xSI.Cv Cvmax_THP(fixed=false, start=8000)
    "Maximum CV input Turbine HP ";
  parameter ThermoSysPro.Units.xSI.Cv Cvmax_TMP(fixed=false, start=1500)
    "Maximum CV input Turbine MP ";

  ThermoSysPro.Fluid.Volumes.DynamicDrum BallonHP(
    L=16.27,
    Vertical=false,
    hl(fixed=false, start=1490815.1478051024),
    hv(fixed=false, start=2666681.973890458),
    Vv(fixed=false),
    R=1.05,
    xmv(fixed=false),
    P(fixed=false, start=12723768.606734423),
    zl(start=1.05, fixed=true),
    Mp=5000,
    Kpa=5,
    Kvl=1000,
    Pfond(start=12730534.85594967),
    Tp(start=593.1308910047013))
                     annotation (Placement(transformation(extent={{38,10},{-2,
            50}}, rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.ControlValve vanne_alimentationHP(
      Cvmax=CvmaxValveAHP,
    C1(P(start=13463260.282381449),
                            h_vol_2(start=1398250.7267619045)),
    h(start=1398000),
    Cv(start=178),
    Pm(start=13050700))   annotation (Placement(transformation(extent={{78,46},{58,66}},
          rotation=0)));
   ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante
    constante_vanne_vapeurHP(                                                              k=0.5)
    annotation (Placement(transformation(extent={{-18,70},{-28,78}}, rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.ControlValve vanne_vapeurHP(
    Cvmax=47829.4,
    C2(h_vol_1(start=2664756.9335524077)),
    h(start=2674000),
    Cv(start=23914.7),
    Pm(start=12722334.038901985))   annotation (Placement(transformation(extent={{-22,46},{-42,66}},
          rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.PipePressureLoss GainChargeHP(
    z2=0,
    Q(start=150, fixed=true),
    z1=10.83,
    K=KgainChargeHP,
    C2(P(start=12755543.553810954)),
    h(start=1474422.14552527),
    Pm(start=12704000))
            annotation (Placement(transformation(
        origin={28,-90},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  ThermoSysPro.Fluid.Volumes.VolumeC VolumeEvapHP(V=5,
    h(start=1490815.1478051024),
    P(start=12704000))                         annotation (Placement(transformation(
          extent={{8,-100},{-12,-80}}, rotation=0)));
  ThermoSysPro.Fluid.HeatExchangers.DynamicFlueGasesMultiFluidHeatExchanger
    EvaporateurHP(
    Dint=32.8e-3,
    Ntubes=1476,
    L=20.7,
    ExchangerWall(e=0.0026, lambda=47,
      dW1(start={-5.74e7,-2.67e7,-1.24e7}),
      Tp(start={607.0686256839474,605.4340763016401,604.369250336098}),
      Tp1(start={605.8809866549195,604.7482278053628,603.9735475960298})),
    Ns=3,
    ExchangerFlueGasesMetal(
      Dext=0.038,
      step_L=0.092,
      step_T=0.0869,
      St=1,
      Fa=1,
      K(fixed=true, start=37.69),
      CSailettes=11.86442072,
      p_rho=1.05,
      Encras=Encras_EvHP,
      deltaT(start={106,49,23}),
      T2(start={755.54833984375,674.4067359457392,636.0812177546504,
            618.193603515625}),
      T1(start={714.9775457406769,655.2439768501948,627.1374112677474}),
      Tp(start={608.1720536506299,606.0712938344541,604.7368952679157}),
      h(start={733599.3125,656358.4375,611752.6709052362,586017.25,579857.8125})),
    TwoPhaseFlowPipe(
      advection=false,
      rugosrel=5e-6,
      z2=10.83,
      option_temperature(start=false)=
                         false,
      continuous_flow_reversal=true,
      inertia=true,
      dW1(start={5.74e7,2.67e7,1.24e7}),
      h(start={1490815.125,1802974.8785231041,1983243.6948464876,
            2087250.43237827,1490815.125}),
      hb(start={1459929.875,1760591.32331318,1893494.15765019,1954976.19646134}),
      P(start={12755544.0,12738060.440301126,12731944.445232479,
            12727558.331339812,12723769.0}),
      T0(start={290.0,290.0,290.0})),
    Cfg1(
      Xo2(start=0.1115701174007655),
      h_vol_1(start=733599.3042437045),
      h_vol_2(start=656358.4284245522)),
    Cfg2(h_vol_1(start=586017.2197643318), h_vol_2(start=579857.8163754256)))
                          annotation (Placement(transformation(
        origin={-14,-50},
        extent={{-20,-20},{20,20}},
        rotation=90)));

  ThermoSysPro.Fluid.HeatExchangers.DynamicFlueGasesMultiFluidHeatExchanger
    EconomiseurHP4(
    Ns=3,
    L=20.726,
    Dint=0.0266,
    Ntubes=246,
    ExchangerWall(e=0.0026, lambda=47,
      dW1(start={-3.5e6,-2.63e6,-2e6}),
      Tp(start={586.8045312098105,592.233932288974,596.2487558411457}),
      Tp1(start={586.1107280703657,591.70094527162,595.8370299676952})),
    Cws1(P(start=13392085.206996098),
       h_vol_2(start=1291418.4097512758)),
    Cws2(h_vol_1(start=1398250.726761905)),
    ExchangerFlueGasesMetal(
      Dext=0.0318,
      step_L=0.111,
      step_T=0.0869,
      St=1,
      Fa=1,
      CSailettes=11.39069779,
      K(fixed=true, start=47.53),
      p_rho=1.06,
      Encras=Encras_EHP4,
      deltaT(start={38,29,22}),
      T2(start={618.193603515625,613.1248964422501,609.3035158562986,
            606.41162109375}),
      T1(start={615.6592506115472,611.2142061492743,607.857569142044}),
      Tp(start={587.4391153803123,592.7214266588746,596.6253392075643}),
      h(start={586017.25,579857.8125,575126.0965916426,571470.875,568995.125})),
    TwoPhaseFlowPipe(
      advection=false,
      rugosrel=5e-6,
      z1=10.83,
      z2=0,
      option_temperature(start=false)=
                         false,
      inertia=true,
      dW1(start={3.5e6,2.63e6,2e6}),
      h(start={1340827.875,1391283.256558695,1430043.6648856928,
            1459985.6005320582,1490815.125}),
      hb(start={1291418.875,1336078.18827954,1370718.78680301,1396865.59043578}),
      P(start={13392085.0,13410597.999476302,13428564.988335809,
            13446090.481250245,13463260.0}),
      T0(start={290.0,290.0,290.0})),
    Cfg2(h_vol_1(start=571470.9016291047), h_vol_2(start=568995.1352316155)))
                          annotation (Placement(transformation(
        origin={86,-50},
        extent={{20,20},{-20,-20}},
        rotation=270)));

  ThermoSysPro.Fluid.HeatExchangers.DynamicFlueGasesMultiFluidHeatExchanger
    SurchauffeurHP1(
    Ns=3,
    L=20.4,
    Dint=0.0324,
    Ntubes=246,
    ExchangerWall(e=0.0028, lambda=37.61,
    dW1(start={-9.8e6,-7.7e6,-5.9e6}),
      Tp(start={642.2528493064303,660.2252788975977,676.0185839771161}),
      Tp1(start={640.2457872857126,658.6370135480385,674.7830152370668})),
    Cws1(h_vol_2(start=2664756.9335524077)),
    Cws2(P(start=12717986.08142511),
      h_vol_1(start=2973076.465167672)),
    ExchangerFlueGasesMetal(
      Dext=0.038,
      step_L=0.111,
      step_T=0.0869,
      St=1,
      Fa=1,
      CSailettes=10.25056,
      K(fixed=true, start=34.71),
      p_rho=1.04,
      Encras=Encras_SHP1,
      deltaT(start={138,108,84}),
      T2(start={788.2433471679688,774.636330839027,763.888258455914,
            755.54833984375}),
      T1(start={781.4398445109163,769.2622946474705,759.7183069957642}),
      Tp(start={644.10620941112,661.6919140110865,677.1595321818904}),
      h(start={771604.625,755814.75,743319.68570567,733599.3125,656358.4375})),
    TwoPhaseFlowPipe(
      advection=false,
      rugosrel=5e-6,
      z1=10.83,
      option_temperature(start=false)=
                         false,
      inertia=true,
      dW1(start={9.8e6,7.7e6,5.9e6}),
      h(start={2666682.0,2796026.041774324,2898380.976036657,2978006.560766205,
            3093060.25}),
      hb(start={2664757.0,2808108.09290342,2916825.81170239,2998229.34382983}),
      P(start={12720899.0,12720947.316355772,12720381.982283436,
            12719355.693542536,12717986.0}),
      T0(start={290.0,290.0,290.0})),
    Cfg1(h_vol_1(start=771604.5980597589), h_vol_2(start=755814.7776905377)))
                          annotation (Placement(transformation(
        origin={-54,-50},
        extent={{-20,20},{20,-20}},
        rotation=270)));

  ThermoSysPro.Fluid.HeatExchangers.DynamicFlueGasesMultiFluidHeatExchanger
    EconomiseurHP3(
    Dint=26.6e-3,
    Ntubes=1476,
    Ns=3,
    ExchangerWall(e=2.6e-3, lambda=47,
          dW1(start={-1.6e7,-5.6e6,-2.1e6}),
      Tp(start={561.796823652815,571.4588678419677,575.4628803966649}),
      Tp1(start={561.3366476058077,571.262479097038,575.3781133321203})),
    L=20.726,
    ExchangerFlueGasesMetal(
      Dext=31.8e-3,
      step_L=74e-3,
      step_T=86.9e-3,
      Fa=1,
      CSailettes=12.451,
      K(fixed=true, start=36.0300000000857),
      p_rho=1.08,
      Encras=Encras_EHP3,
      St=5, deltaT(start={34,12,4.4}),
      T2(start={602.6719360351563,579.980900946576,571.7829862725544,
            568.8102416992188}),
      T1(start={591.3264094805266,575.8819436095652,570.2965996068247}),
      Tp(start={562.2177217699727,571.63849399485,575.5404122414816}),
      h(start={566350.125,541838.1875,531377.2730086804,526862.0625,524994.875})),
    TwoPhaseFlowPipe(
      rugosrel=5e-6,
      z2=0,
      advection=false,
      z1=10.767,
      inertia=true,
      dW1(start={1.6e7,5.6e6,2.1e6}),
      h(start={1017356.625,1218148.8764511738,1303840.734184985,
            1340827.8193574403,1391283.25}),
      hb(start={986348.9375,1189594.8774342,1263384.6284551,1290000.70037855}),
      P(start={13311571.0,13333449.940013096,13353656.79078459,
            13373055.807696301,13392085.0}),
      T0(start={290.0,290.0,290.0})),
    Cfg1(h_vol_1(start=566350.1392976114), h_vol_2(start=541838.2014676201)),
    Cfg2(h_vol_1(start=526862.0336133951), h_vol_2(start=524994.8479453246)))
                  annotation (Placement(transformation(
        origin={206,-50},
        extent={{20,-20},{-20,20}},
        rotation=90)));

  ThermoSysPro.Fluid.HeatExchangers.DynamicFlueGasesMultiFluidHeatExchanger
    EconomiseurHP2(
    Dint=26.6e-3,
    Ns=3,
    ExchangerWall(e=2.6e-3, lambda=47,
              dW1(start={-5e6,-3e6,-2.e6}),
      Tp(start={497.4826387258949,505.30719485126787,510.35203444054224}),
      Tp1(start={497.280376159525,505.1760138457019,510.2668260105936})),
    L=20.767,
    Ntubes=1107,
    ExchangerFlueGasesMetal(
      Dext=31.8e-3,
      step_T=86.9e-3,
      Fa=1,
      step_L=111e-3,
      CSailettes=2.76134577,
      K(fixed=true, start=65.5300000000393),
      p_rho=1.11,
      Encras=Encras_EHP2,
      St=5, deltaT(start={36,23,14}),
      T2(start={531.16064453125,523.8360138077611,519.2214124321695,
            516.3124389648438}),
      T1(start={527.4983362936189,521.5287131199652,517.7669224567446}),
      Tp(start={497.66763734525006,505.42717901517375,510.4299699783979}),
      h(start={480418.125,472321.78125,467070.7664465268,463659.96875,
            459024.375})),
    TwoPhaseFlowPipe(
      rugosrel=5e-6,
      z2=0,
      advection=false,
      z1=10.767,
      inertia=true,
      dW1(start={5e6,3e6,2.e6}),
      h(start={880080.3125,946402.3420877852,989416.7007043775,
            1017356.6143159299,1017356.625}),
      hb(start={854494.5625,915007.018247822,957243.396653824,983786.364226731}),
      P(start={13222388.0,13245245.535219172,13267635.410096379,
            13289708.936642656,13311571.0}),
      T0(start={290.0,290.0,290.0})),
    Cfg1(h_vol_1(start=480418.1309072992), h_vol_2(start=472321.79192425753)),
    Cfg2(h_vol_1(start=463659.97054164804), h_vol_2(start=459024.3888915999)))
                  annotation (Placement(transformation(
        origin={406,-50},
        extent={{-20,-20},{20,20}},
        rotation=90)));

  ThermoSysPro.Fluid.HeatExchangers.DynamicFlueGasesMultiFluidHeatExchanger
    EconomiseurHP1(
    Dint=26.6e-3,
    Ns=3,
    ExchangerWall(e=2.6e-3, lambda=47,
              dW1(start={-9.9999e6,-5e6,-2.4e6}),
      Tp(start={463.9321072661506,474.9929739228467,480.7691364010327}),
      Tp1(start={463.5249231636951,474.78082392813104,480.65874049533926})),
    L=20.726,
    Ntubes=1107,
    Cws1(h_vol_2(start=618649.6677733721)),
    ExchangerFlueGasesMetal(
      Dext=31.8e-3,
      step_L=74e-3,
      step_T=86.9e-3,
      Fa=1,
      CSailettes=8.30057632,
      K(fixed=true, start=40.24),
      p_rho=1.13,
      Encras=Encras_EHP1,
      St=5,   deltaT(start={41,20,10}),
      T2(start={509.31475830078125,493.76452187742854,486.23046610566547,
            482.5950622558594}),
      T1(start={501.5396335543568,489.997493991547,484.4127676365523}),
      Tp(start={464.30453652050693,475.18701603762264,480.87010955935017}),
      h(start={454937.0,438670.0625,430194.70910967304,425784.40625,
            406989.71875})),
    TwoPhaseFlowPipe(
      rugosrel=5e-6,
      z2=0,
      z1=10.767,
      inertia=true,
      dW1(start={9.9999e6,5e6,2.4e6}),
      h(start={571589.625,774526.0247459969,843952.8413327619,880080.2817637667,
            880080.3125}),
      hb(start={618651.9375,752176.893518976,816707.727773953,847728.424287614}),
      advection=true,
      dynamic_mass_balance=true,
      P(start={13128535.0,13152879.589094872,13176430.551414272,
            13199531.42642672,13222388.0}),
      T0(start={290.0,290.0,290.0})),
    Cfg1(h_vol_1(start=454936.9990189345), h_vol_2(start=438670.0646527905)),
    Cfg2(h_vol_1(start=425784.41179849324), h_vol_2(start=406989.7250411841)))
                  annotation (Placement(transformation(
        origin={526,-50},
        extent={{20,-20},{-20,20}},
        rotation=90)));

  ThermoSysPro.Fluid.HeatExchangers.DynamicFlueGasesMultiFluidHeatExchanger
    SurchauffeurHP2(
    Ns=3,
    L=20.4,
    Dint=32e-3,
    Ntubes=246,
    ExchangerWall(e=3e-3, lambda=27,
          dW1(start={-8.8e6,-6.6e6,-4.9e6}),
      Tp(start={718.9678163326367,740.0767692096435,756.604413623004}),
      Tp1(start={716.2791829167277,738.0462739865401,755.0829558745072})),
    Cws2(P(start=12709302.607974846),
      h_vol_1(start=3240813.8516343245)),
    ExchangerFlueGasesMetal(
      step_T=86.9e-3,
      Fa=1,
      Dext=38e-3,
      step_L=111e-3,
      K(fixed=true, start=34.74),
      CSailettes=10.2505424803872,
      p_rho=1.02,
      Encras=Encras_SHP2,
      St=5,
      deltaT(start={124,93,70}),
      T2(start={850.646484375,838.5707346201303,829.4749488031354,
            822.6819458007813}),
      T1(start={844.6086089059804,834.0228417116329,826.0784372242802}),
      Tp(start={721.435205827699,741.940177792463,758.000672720138}),
      h(start={844515.9375,830470.625,819863.3783947699,811915.375,793532.125})),
    TwoPhaseFlowPipe(
      rugosrel=5e-6,
      z2=0,
      advection=false,
      z1=10.83,
      inertia=true,
      dW1(start={8.8e6,6.6e6,4.9e6}),
      h(start={2978006.5,3093060.285806892,3179950.539313758,3245057.7348208814,
            3327367.0}),
      hb(start={2973076.25,3118965.9792171,3205920.08101435,3268474.17308722}),
      P(start={12717986.0,12716434.741873961,12714386.551930543,
            12711976.726767521,12709303.0}),
      T0(start={290.0,290.0,290.0})),
    Cfg1(h_vol_1(start=844515.913281604), h_vol_2(start=830470.6023452462)),
    Cfg2(h_vol_1(start=811915.3453800348), h_vol_2(start=793532.1532110969)))
                  annotation (Placement(transformation(
        origin={-174,-50},
        extent={{-20,-20},{20,20}},
        rotation=90)));

  ThermoSysPro.Fluid.HeatExchangers.DynamicFlueGasesMultiFluidHeatExchanger
    SurchauffeurHP3(
    Ns=3,
    L=20.4,
    Ntubes=246,
    ExchangerWall(lambda=27, e=5e-3,
    dW1(start={-6.3e6,-4.7e6,-3.6e6}),
      Tp(start={790.194354484117,807.7071433884553,821.1209947971915}),
      Tp1(start={786.6677403770077,805.0457823271269,819.1194288821613})),
    Dint=28e-3,
    Cws2(h_vol_1(start=3433271.775819776), h_vol_2(start=3436197.0248581353)),
    ExchangerFlueGasesMetal(
      step_T=86.9e-3,
      Fa=1,
      Dext=38e-3,
      step_L=111e-3,
      K(fixed=true, start=49.33),
      CSailettes=6.59672842597229,
      p_rho=1,
      Encras=Encras_SHP3,
      St=5,
      deltaT(start={97,73,55}),
      T2(start={894.2188110351563,885.636025090525,879.1746662824661,
            874.3292236328125}),
      T1(start={889.9274067093704,882.4053456864956,876.7519418617093}),
      Tp(start={793.2224770352475,809.9923175531776,822.8396367298765}),
      h(start={1667213.25,885985.75,878403.0483138687,872700.1875,859769.0})),
    TwoPhaseFlowPipe(
      rugosrel=5e-6,
      z2=0,
      advection=false,
      z1=10.726,
      inertia=true,
      dW1(start={6.3e6,4.7e6,3.6e6}),
      h(start={3245057.75,3327366.927704592,3389481.600384113,
            3436197.0248581353,3436197.0}),
      hb(start={3240813.5,3348361.34780186,3407279.82422176,3450835.48993987}),
      P(start={12709303.0,12702950.046102656,12696025.294905605,
            12688672.774977181,12681000.0}),
      T0(start={290.0,290.0,290.0})),
    Cfg1(h_vol_2(start=885985.7657894278)),
    Cfg2(h_vol_1(start=872700.2111216835), h_vol_2(start=859769.0004719263)))
                  annotation (Placement(transformation(
        origin={-294,-50},
        extent={{20,-20},{-20,20}},
        rotation=90)));

  ThermoSysPro.Fluid.Volumes.DynamicDrum BallonMP(
    L=16.27,
    Vertical=false,
    P0=27.29e5,
    hl(fixed=false, start=982393.5767040529),
    hv(fixed=false, start=2799922.9214887),
    Vv(fixed=false),
    R=1.05,
    P(fixed=false, start=2735928.760015618),
    zl(start=1.05, fixed=true),
    Kpa=5,
    Mp=5000,
    Kvl=1000,
    Pfond(start=2744469.1253284975),
    Tp(start=497.67337438326825))
                     annotation (Placement(transformation(extent={{358,10},{320,
            50}}, rotation=0)));
   ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante
    constante_vanne_vapeurMP(                                                              k=0.5)
    annotation (Placement(transformation(extent={{304,70},{292,80}}, rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.ControlValve vanne_alimentationMP(
      Cvmax=CvmaxValveAMP,
    C1(P(start=3167631.503685111),
    h_vol_2(start=944504.749093579)),
    h(start=944000),
    Cv(start=28),
    Pm(start=2975000))   annotation (Placement(transformation(extent={{398,46},{378,66}},
          rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.ControlValve vanne_vapeurMP(
    Cvmax=47829.4,
    C2(h_vol_1(start=2798574.7604119307)),
    h(fixed=false, start=2798000),
    Cv(start=23914.7),
    Pm(fixed=false, start=2734363.102702573))    annotation (Placement(transformation(extent={{298,46},{278,66}},
          rotation=0)));
  ThermoSysPro.Fluid.HeatExchangers.DynamicFlueGasesMultiFluidHeatExchanger
    EvaporateurMP(
    Dint=32.8e-3,
    L=20.767,
    Ntubes=738,
    ExchangerWall(e=2.6e-3, lambda=47,
    dW1(start={-9.7e7,-7.6e6,-5.8e6}),
      Tp(start={505.16819175410103,504.47653316985316,503.9096834697299}),
      Tp1(start={504.6351775530387,504.05161319744064,503.5710085659467})),
    Ns=3,
    TwoPhaseFlowPipe(
      advection=false,
      rugosrel=5e-6,
      z1=0,
      z2=10.83,
      continuous_flow_reversal=true,
      inertia=true,
          dW1(start={9.7e7,7.6e6,5.8e6}),
      P(start={2774374.0,2752246.9598328522,2744979.3658251367,
            2740042.865359723,2735928.75}),
      h(start={982393.5625,1052669.185607329,1108693.0397347796,
            1153345.8558491606,982393.5625}),
      hb(start={980708.125,1028103.09460604,1066178.43156513,1095633.31556464}),
      T0(start={290.0,290.0,290.0})),
    Cws1(P(start=2774374.0890979404)),
    ExchangerFlueGasesMetal(
      K(fixed=true, start=30.22),
      Dext=38e-3,
      step_L=111e-3,
      step_T=86.9e-3,
      Fa=1,
      CSailettes=10.0676093,
      p_rho=1.1,
      Encras=Encras_EvMP,
      St=5,
      deltaT(start={53,41,32}),
      T2(start={565.2481689453125,550.9126306026692,539.787269523939,
            531.16064453125}),
      T1(start={558.0803978580261,545.349950063304,535.4739641517078}),
      Tp(start={505.6634119015416,504.8713236488558,504.224344196615}),
      h(start={522718.59375,505329.59375,491467.03403307416,480418.125,
            472321.78125})),
    Cfg1(h_vol_1(start=522718.6023168775), h_vol_2(start=505329.58942935336)))
                          annotation (Placement(transformation(
        origin={306,-50},
        extent={{-20,-20},{20,20}},
        rotation=90)));

  ThermoSysPro.Fluid.PressureLosses.PipePressureLoss GainChargeMP(
    z2=0,
    z1=10.83,
    Q(start=150, fixed=true),
    K=KgainChargeMP,
    Pm(start=2734000),
    h(start=978914.570821827))
            annotation (Placement(transformation(
        origin={348,-90},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  ThermoSysPro.Fluid.Volumes.VolumeC VolumeEvapMP(V=5,
    h(start=982393.5767040529),
    P(start=2734000))                         annotation (Placement(transformation(
          extent={{328,-100},{308,-80}}, rotation=0)));
  ThermoSysPro.Fluid.HeatExchangers.DynamicFlueGasesMultiFluidHeatExchanger
    EconomiseurMP(
    ExchangerWall(e=2.6e-3, lambda=47,
        dW1(start={-3e6,-1.4e6,-740379}),
      Tp(start={472.3628584074194,491.3438906316966,502.0012847992062}),
      Tp1(start={471.840700513395,491.0496555837365,501.83511098176496})),
    L=20.726,
    Ns=3,
    Dint=26.6e-3,
    Ntubes=246,
    Cws1(h_vol_2(start=565106.2802015315), P(start=3075398.079286396)),
    Cws2(h_vol_1(start=944504.7490935794)),
    ExchangerFlueGasesMetal(
      step_L=111e-3,
      step_T=86.9e-3,
      Fa=1,
      Dext=31.8e-3,
      K(fixed=true, start=47.78),
      CSailettes=7.16188651,
      p_rho=1.12,
      Encras=Encras_EMP,
      St=5,
      deltaT(start={45,24,13}),
      T2(start={516.3124389648438,512.4675048876576,510.41305969109146,
            509.31475830078125}),
      T1(start={514.3899686844887,511.4402822893745,509.8639024611882}),
      Tp(start={472.8404479644676,491.6130115007493,502.15327499369164}),
      h(start={463659.96875,459024.375,456412.24684658495,454937.0,438670.0625})),
    TwoPhaseFlowPipe(
      advection=false,
      rugosrel=5e-6,
      z1=10.767,
      z2=0,
      inertia=true,
      dW1(start={3e6,1.4e6,740379}),
      h(start={571589.625,787918.9315405625,901666.2028313989,965906.7425802368,
            982393.5625}),
      hb(start={565108.5,727745.440528479,829820.124314816,892414.570867187}),
      P(start={3075398.0,3099880.3604684034,3123147.6507597235,
            3145628.859295243,3167631.5}),
      T0(start={290.0,290.0,290.0})))
                          annotation (Placement(transformation(
        origin={466,-50},
        extent={{-20,-20},{20,20}},
        rotation=90)));

  ThermoSysPro.Fluid.HeatExchangers.DynamicFlueGasesMultiFluidHeatExchanger
    SurchauffeurMP1(
    ExchangerWall(e=2.6e-3, lambda=47,
    dW1(start={-1.3e6,-0.80263e6,
                                -501864}),
      Tp(start={562.8136365409941,580.9270260501409,592.9171328387902}),
      Tp1(start={562.3574073875994,580.630547779683,592.7261966839885})),
    L=20.726,
    Ns=3,
    Dint=32.8e-3,
    Ntubes=123,
    Cws1(h_vol_2(start=2798574.7604119307)),
    ExchangerFlueGasesMetal(
      step_L=111e-3,
      step_T=86.9e-3,
      Fa=1,
      Dext=31.8e-3,
      K(fixed=true, start=22.09),
      CSailettes=14.46509765,
      p_rho=1.07,
      Encras=Encras_SMP1,
      St=5,
      deltaT(start={45,30,19}),
      T2(start={606.41162109375,604.5654891969185,603.4004814494892,
            602.6719360351563}),
      T1(start={605.488555812354,603.9829853232038,603.0361997319833}),
      Tp(start={563.2375161835078,581.202482150127,593.0945304216444}),
      h(start={571470.875,568995.125,567386.2706202245,566350.125,541838.1875})),
    TwoPhaseFlowPipe(
      advection=false,
      rugosrel=5e-6,
      z2=0,
      z1=10.77,
      inertia=true,
      dW1(start={1.3e6,0.80263e6,501864}),
      h(start={2799923.0,2907731.6344967457,2977790.5961721865,
            3022909.547827688,3044385.0}),
      hb(start={2798574.75,2904836.50693844,2969862.15109307,3009575.30461156}),
      P(start={2732797.5,2731565.0172964707,2730091.858748362,
            2728450.5104684294,2726700.0}),
      T0(start={290.0,290.0,290.0})))
                          annotation (Placement(transformation(
        origin={146,-50},
        extent={{20,-20},{-20,20}},
        rotation=90)));

  ThermoSysPro.Fluid.Volumes.VolumeB MelangeurHPMP(
    Ce1(h(start=3046256.0341363903), h_vol_1(start=3048424.856388378)),
    h(start=3044384.9881097865),
    P(start=2726000))
    annotation (Placement(transformation(
        origin={148,-110},
        extent={{-10,10},{10,-10}},
        rotation=90)));
  ThermoSysPro.Fluid.HeatExchangers.DynamicFlueGasesMultiFluidHeatExchanger
    SurchauffeurMP2(
    Ns=3,
    L=20.4,
    Dint=39.3e-3,
    Ntubes=369,
    ExchangerWall(e=2.6e-3, lambda=36.86,
    dW1(start={-1.15e7,-7.9e6,-5.5e6}),
      Tp(start={688.4468686536222,714.033199611363,732.1920347309398}),
      Tp1(start={687.218391177629,713.1710194015468,731.5888814252561})),
    Cws1(P(start=2575212.183613983),
      h_vol_2(start=3040562.6721177064)),
    Cws2(P(start=2558092.5174766793),
      h_vol_1(start=3321940.994604838)),
    ExchangerFlueGasesMetal(
      step_T=86.9e-3,
      Fa=1,
      Dext=44.5e-3,
      step_L=92e-3,
      K(fixed=true, start=45.22),
      CSailettes=5.814209831,
      p_rho=1.03,
      Encras=Encras_SMP2,
      St=5,
      deltaT(start={125,86,60}),
      T2(start={822.6819458007813,806.8523532375756,795.852828640494,
            788.2433471679688}),
      T1(start={814.7671394415003,801.3525909390348,792.0480934116497}),
      Tp(start={689.6013638823948,714.8434569893178,732.7588645078285}),
      h(start={811915.375,793532.125,780630.3094320802,771604.625,755814.75})),
    TwoPhaseFlowPipe(
      advection=false,
      z2=0,
      z1=10.83,
      rugosrel=1e-5,
      inertia=true,
      dW1(start={1.15e7,7.9e6,5.5e6}),
      h(start={3044385.0,3171130.1833912637,3260083.5432993243,
            3322312.4282463193,3411468.25}),
      hb(start={3040562.25,3176242.27636476,3267406.25678814,3329559.35651389}),
      P(start={2575212.25,2571568.1301815873,2567405.441864329,
            2562877.7123048743,2558092.5}),
      T0(start={290.0,290.0,290.0})))
                          annotation (Placement(transformation(
        origin={-114,-50},
        extent={{-20,-20},{20,20}},
        rotation=90)));

  ThermoSysPro.Fluid.HeatExchangers.DynamicFlueGasesMultiFluidHeatExchanger
    SurchauffeurMP3(
    Ns=3,
    L=20.4,
    Ntubes=369,
    Dint=45.6e-3,
    ExchangerWall(e=2.6e-3, lambda=27,
    dW1(start={-8e6,-5.5e6,-3.8e6}),
      Tp(start={784.9199768014527,801.9559375893245,813.881408346332}),
      Tp1(start={783.8988186940742,801.245223096765,813.3876096599773})),
    Cws2(h_vol_1(start=3517975.7051807973), h_vol_2(start=3516632.5605054162)),
    ExchangerFlueGasesMetal(
      step_T=86.9e-3,
      Fa=1,
      step_L=92e-3,
      Dext=50.8e-3,
      K(fixed=true, start=43.23),
      CSailettes=5.695842178,
      p_rho=1.01,
      Encras=Encras_SMP3,
      St=5,
      deltaT(start={82,56,38}),
      T2(start={874.3292236328125,863.3655435931397,855.822658205448,
            850.646484375}),
      T1(start={868.8473805170461,859.5941008992938,853.2345706986391}),
      Tp(start={785.8874729590412,802.6293039717932,814.3492578675946}),
      h(start={872700.1875,859769.0,850769.0241228014,844515.9375,830470.625})),
    TwoPhaseFlowPipe(
      advection=false,
      z2=0,
      z1=10.83,
      rugosrel=1e-5,
      inertia=true,
      dW1(start={8e6,5.5e6,3.8e6}),
      h(start={3322312.5,3411468.261681972,3473519.713324085,3516632.5605054167,
            3516632.5}),
      hb(start={3321940.75,3420707.89900972,3482716.02631475,3524890.37222916}),
      P(start={2558092.5,2555937.2008945565,2553603.1383043886,
            2551144.9258610248,2548600.0}),
      T0(start={290.0,290.0,290.0})))
                          annotation (Placement(transformation(
        origin={-234,-50},
        extent={{20,-20},{-20,20}},
        rotation=90)));

  ThermoSysPro.Fluid.Volumes.DynamicDrum BallonBP(
    Vertical=false,
    P0=5e5,
    Vv(fixed=false),
    L=8,
    hl(fixed=false, start=571589.6558240334),
    hv(fixed=false, start=2689372.23552223),
    R=2,
    P(fixed=false, start=555006.6148534557),
    zl(start=1.75, fixed=true),
    Kpa=5,
    Mp=5000,
    Kvl=1000,
    Pfond(start=570965.3592810449),
    Tp(start=411.19945476835005))
                     annotation (Placement(transformation(extent={{618,10},{578,
            50}}, rotation=0)));
   ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante
    constante_vanne_vapeurBP(                                                              k=0.5)
    annotation (Placement(transformation(extent={{666,76},{654,86}}, rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.ControlValve vanne_vapeurBP(
    p_rho=3, Cvmax=CvmaxValveVBP,
    C2(P(start=510158.3929231321),
    h_vol_1(start=2684673.580149807)),
    h(start=2685000),
    Cv(start=1),
    Pm(start=498000))   annotation (Placement(transformation(extent={{558,46},{538,66}},
          rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.ControlValve vanne_alimentationBP(
    Cvmax=285,
    C1(h_vol_2(start=509236.1596958067)),
    h(fixed=false, start=509000),
    Cv(start=142.5),
    Pm(fixed=false, start=1021309.6581195585))  annotation (Placement(transformation(extent={{650,44},{630,64}},
          rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.PipePressureLoss GainChargeBP(
    z2=0,
    z1=10.767,
    Q(start=50, fixed=false),
    K=32766,
    rho(start=929.9117790585748),
    Pm(start=564000),
    h(start=549249.519022482))
            annotation (Placement(transformation(
        origin={610,-90},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  ThermoSysPro.Fluid.Volumes.VolumeC VolumeEvapBP(h(start=571589.6558240334),
    V=5,
    P(start=564000))                         annotation (Placement(transformation(
          extent={{592,-100},{572,-80}}, rotation=0)));
  ThermoSysPro.Fluid.HeatExchangers.DynamicFlueGasesMultiFluidHeatExchanger
    EvaporateurBP(
    Dint=32.8e-3,
    ExchangerWall(e=2.6e-3, lambda=47,
    dW1(start={-1.24e7,-8.5e6,-5.8e6}),
      Tp(start={432.59535605574797,431.6255977090002,430.8591280369125}),
      Tp1(start={432.16242526836834,431.3108320909342,430.62996395048594})),
    L=20.726,
    Ntubes=984,
    Ns=3,
    ExchangerFlueGasesMetal(
      Dext=38e-3,
      step_T=86.9e-3,
      Fa=1,
      step_L=138e-3,
      K(fixed=true, start=30.62),
      CSailettes=11.07985,
      p_rho=1.14,
      Encras=Encras_EvBP,
      St=5,
      deltaT(start={45,31,21}),
      T2(start={482.5950622558594,464.01748118772224,451.30051770870455,
            442.58880615234375}),
      T1(start={473.3062751775807,457.6589994482134,446.94466391603106}),
      Tp(start={432.9975893355074,431.918044468841,431.07204294951407}),
      h(start={425784.40625,406989.71875,393324.9053433096,383376.28125,
            345485.03125})),
    TwoPhaseFlowPipe(
      advection=false,
      rugosrel=5e-6,
      z1=0,
      z2=10.767,
      continuous_flow_reversal=true,
      inertia=true,
      dW1(start={1.24e7,8.5e6,5.8e6}),
      h(start={571589.625,800925.2190091099,967665.3813576263,
            1089060.0143937408,571589.625}),
      hb(start={550075.0,765243.011613326,912673.256542569,1013555.73710231}),
      Q(start={49.68034838099436,49.68034838099436,49.68034838099436,
            49.68034838099436}),
      P(start={582186.75,557630.6861652867,556428.158876046,555687.7128874982,
            555006.625}),
      T0(start={290.0,290.0,290.0})),
    Cfg2(h_vol_1(start=383376.2777938952), h_vol_2(start=345485.01719053386)))
                          annotation (Placement(transformation(
        origin={566,-50},
        extent={{-20,-20},{20,20}},
        rotation=90)));

   ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante
    constante_ballonBP(k=1)
    annotation (Placement(transformation(extent={{742,6},{728,18}}, rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.ControlValve Vanne_alimentationMPHP(
    Cvmax=308.931,
    C1(h_vol_2(start=550072.7232069891)),
    h(start=550000),
    Cv(start=308.931),
    Pm(start=473826.9860082782))
                 annotation (Placement(transformation(extent={{710,-14},{730,6}},
          rotation=0)));
  ThermoSysPro.Fluid.HeatExchangers.DynamicFlueGasesMultiFluidHeatExchanger
    SurchauffeurBP(
    Ns=3,
    L=20.726,
    Dint=39.3e-3,
    Ntubes=123,
    ExchangerWall(e=2.6e-3, lambda=47,
    dW1(start={-1.1e6,-782901,-559798}),
      Tp(start={483.5879234710947,510.03490701889103,529.1506909427684}),
      Tp1(start={483.29897049125907,509.8288453180465,529.0044963209424})),
    Cws1(h_vol_2(start=2684673.580149807)),
    Cws2(h_vol_1(start=2914519.282601244), h_vol_2(start=2935965.8606590154)),
    ExchangerFlueGasesMetal(
      step_T=86.9e-3,
      Fa=1,
      Dext=44.5e-3,
      step_L=222.1e-3,
      K(fixed=true, start=30.46),
      CSailettes=3.25763059984175,
      p_rho=1.09,
      Encras=Encras_SBP,
      St=5,
      deltaT(start={92,66,47}),
      T2(start={568.8102416992188,567.2151210721856,566.0683353396659,
            565.2481689453125}),
      T1(start={568.0126670066404,566.6417282059258,565.6582502265244}),
      Tp(start={483.8594749183778,510.2285591249387,529.2880813277524}),
      h(start={526862.0625,524994.875,523663.2975499146,522718.59375,
            505329.59375})),
    TwoPhaseFlowPipe(
      advection=false,
      z2=0,
      rugosrel=1e-5,
      z1=10.767,
      inertia=true,
      dW1(start={1.1e6,782901,559798}),
      h(start={2689372.25,2800496.5790294725,2879742.9368326054,
            2935965.8606590154,2935965.75}),
      hb(start={2684673.5,2819292.38908571,2893584.12921908,2943776.05560762}),
      P(start={510158.40625,508396.8288525169,506425.5320020969,
            504223.40958995325,501850.0}),
      T0(start={290.0,290.0,290.0})))
                          annotation (Placement(transformation(
        origin={266,-50},
        extent={{20,-20},{-20,20}},
        rotation=90)));

  ThermoSysPro.Fluid.BoundaryConditions.SinkP PuitsFumees(P0=1.013e5, C(h_vol_1
        (start=329093.3007791504)))
    annotation (Placement(transformation(
        origin={722,-50},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  ThermoSysPro.Fluid.HeatExchangers.DynamicFlueGasesMultiFluidHeatExchanger
    EconomiseurBP(
    Ns=3,
    Dint=32.8e-3,
    ExchangerWall(e=2.6e-3, lambda=47,
    dW1(start={-2.45e7,-5.5e6,-1.17e6}),
      Tp(start={396.2481159869425,399.78388129181906,401.13111161783405}),
      Tp1(start={395.99874013762894,399.70202906319594,401.105084136553})),
    Ntubes=3444,
    L=20.726,
    Cws1(h_vol_2(start=194584.50261459063)),
    Cws2(h_vol_1(start=509236.15969580685)),
    ExchangerFlueGasesMetal(
      step_T=86.9e-3,
      Fa=1,
      Dext=38e-3,
      step_L=92e-3,
      K(fixed=true, start=31.53),
      CSailettes=11.673758598919,
      p_rho=1.15,
      Encras=Encras_EBP,
      St=5,
      deltaT(start={23.5,5.3,1.1}),
      T2(start={442.58880615234375,405.54898708865323,397.2418326138536,
            395.4642028808594}),
      T1(start={424.0688986060054,401.3954098512534,396.353024695102}),
      Tp(start={396.4798095231228,399.8599296836186,401.15529358730896}),
      h(start={383376.28125,345485.03125,333048.03047244134,329093.3125,
            206282.203125})),
    TwoPhaseFlowPipe(
      advection=false,
      rugosrel=5e-6,
      z1=0,
      z2=10.767,
      inertia=true,
      dW1(start={2.45e7,5.5e6,1.17e6}),
      h(start={194692.265625,428815.5293291671,505661.4245378703,
            530096.9852149182,571589.625}),
      hb(start={194584.515625,462556.370989432,494648.45288738,501287.069880104}),
      P(start={1588738.375,1562590.7775307859,1537310.419233922,
            1512399.026918416,1487612.75}),
      T0(start={290.0,290.0,290.0})))
                          annotation (Placement(transformation(
        origin={680,-50},
        extent={{-20,-20},{20,20}},
        rotation=90)));

  ThermoSysPro.Fluid.Machines.StodolaTurbine TurbineHP(
    W_fric=1,
    eta_stato=1,
    eta_is(start=0.88057),
    Qmax=140,
    eta_is_nom=0.88057,
    eta_is_min=0.75,
    Cst(start=8182844.56002535)=
        CstHP,
    pros(d(start=10.64336641432295)),
    Hrs(start=3048424.856388379),
    Pe(fixed=true, start=12431000),
    Ps(fixed=false, start=2726700))
              annotation (Placement(transformation(extent={{-2,-250},{38,-210}},
          rotation=0)));
  ThermoSysPro.Fluid.Machines.StodolaTurbine TurbineMP(
    W_fric=1,
    eta_stato=1,
    eta_is(start=0.9625),
    Qmax=150,
    eta_is_nom=0.9625,
    eta_is_min=0.75,
    Cst(start=256335.364995961)=
        CstMP,
    pros(d(start=1.884386603984167)),
    Hrs(start=3028846.077881056),
    Pe(fixed=true, start=2548500),
    Ps(fixed=false, start=476800))
                annotation (Placement(transformation(extent={{318,-250},{358,
            -210}}, rotation=0)));
  ThermoSysPro.Fluid.Volumes.VolumeC MelangeurPostTMP1(
    h(start=3019203.192090637),
    P(start=476799.99999954),
    Ce1(h(start=3029780)))                 annotation (Placement(transformation(
        origin={418,-230},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  ThermoSysPro.Fluid.Machines.StodolaTurbine TurbineBP(
    W_fric=1,
    eta_stato=1,
    eta_is(start=0.9538),
    Qmax=150,
    eta_is_nom=0.9538,
    eta_is_min=0.75,
    Cst(start=11944.9445735985)=
        CstBP,
    Cs(h(start=2401954.6559323)),
    Hrs(start=2401030),
    Pe(fixed=true, start=476799.99999954),
    Ps(start=10053))
                annotation (Placement(transformation(extent={{576,-250},{616,
            -210}}, rotation=0)));
  ThermoSysPro.Fluid.Junctions.MassFlowMultiplier DoubleDebitHP(
                                                    alpha=2)
    annotation (Placement(transformation(
        origin={-292,-100},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  ThermoSysPro.Fluid.Junctions.MassFlowMultiplier DoubleDebitMP(
                                                    alpha=2)
    annotation (Placement(transformation(
        origin={-232,-100},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  ThermoSysPro.Fluid.Junctions.MassFlowMultiplier MoitieDebitHP(
                                                    alpha=0.5,
    Ce(h(start=3046260)),
    P(start=2726700))
    annotation (Placement(transformation(extent={{114,-180},{134,-160}},
          rotation=0)));
  ThermoSysPro.Fluid.HeatExchangers.SimpleDynamicCondenser Condenseur(
    D=0.018,
    V=1000,
    A=100,
    lambda=0.01,
    ntubes=28700,
    continuous_flow_reversal=true,
    Vf0=0.15,
    steady_state=false,
    yNiveau(signal(start=1.5)),
    Cse(h(start=128076)),
    P(fixed=false, start=6136),
    Pfond(start=10000.0),
    Cl(h(start=191812.29519356362),
      Q(start=196.22097932320875),
      h_vol_2(start=194692.2720118419)),
    proe(d(start=996.0237398943773)))
    annotation (Placement(transformation(extent={{637,-384},{717,-304}},
          rotation=0)));
  ThermoSysPro.Fluid.BoundaryConditions.SourceQ SourceCaloporteur(
    h0=113.38e3, Q0=29804.5)     annotation (Placement(transformation(extent={{
            572,-377},{620,-329}}, rotation=0)));
  ThermoSysPro.Fluid.BoundaryConditions.SinkP PuitsCaloporteur
    annotation (Placement(transformation(extent={{736,-374},{780,-330}},
          rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.PipePressureLoss perteChargeK1(    K=1e-4,
    h(start=2400000),
    C1(h_vol_2(start=2400000), h(start=2400000)),
    Pm(start=10026.029972250988))
    annotation (Placement(transformation(extent={{640,-240},{660,-220}},
          rotation=0)));
  ThermoSysPro.Fluid.Volumes.VolumeC VolumeCond1(
    Ce3(h(start=194584.50261452305)),
    h(start=194692.2720118418),
    P(start=1540500))
    annotation (Placement(transformation(
        origin={902,-318},
        extent={{10,-10},{-10,10}},
        rotation=270)));
  ThermoSysPro.Fluid.PressureLosses.PipePressureLoss perteChargeKCond1(K=1e-4,
    rho(start=990.3728941875843),
    Pm(start=1540000))
    annotation (Placement(transformation(
        origin={902,-270},
        extent={{12,-12},{-12,12}},
        rotation=270)));
  ThermoSysPro.Fluid.Volumes.VolumeA VolumeAlimMPHP(
    h(start=571589.6558240333),
    P(start=322430))                         annotation (Placement(transformation(
          extent={{742,-20},{762,0}}, rotation=0)));
  ThermoSysPro.Fluid.Machines.StaticCentrifugalPump PompeAlimMP(
    a3=350,
    b1(fixed=true) = -3.7751,
    a1=-244551,
    Q(fixed=false),
    C1(h_vol_2(start=550072.7232069891)),
    C2(h_vol_1(start=565106.2802015315)),
    Qv(start=0.014981930996429617),
    rho(start=929.199477777818),
    Pm(start=1725850))
            annotation (Placement(transformation(extent={{804,-20},{824,0}},
          rotation=0)));
  ThermoSysPro.Fluid.Machines.StaticCentrifugalPump PompeAlimHP(
    a3=1600,
    a1=-28056.2,
    b1=-12.7952660447433,
    Q(fixed=false),
    C1(h_vol_2(start=550072.7232069891)),
    C2(h_vol_1(start=618649.6677733721)),
    Qv(start=0.079840086308535),
    rho(start=926.8951785877663),
    Pm(start=6851620.819939703))
             annotation (Placement(transformation(extent={{804,-60},{824,-40}},
          rotation=0)));
  ThermoSysPro.Fluid.Junctions.MassFlowMultiplier MoitieDebitBP(alpha=0.5,
    h(start=194585),
    P(start=1540500),
    Cs(h(start=194585)))
    annotation (Placement(transformation(extent={{872,-328},{886,-308}},
          rotation=0)));
  ThermoSysPro.Fluid.Junctions.MassFlowMultiplier DoubleDebitBP(alpha=2)
    annotation (Placement(transformation(
        origin={268,-100},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  ThermoSysPro.Fluid.PressureLosses.PipePressureLoss PerteChargeZero2(
    z2=0,
    z1=0,
    K=K_PerteChargeZero2,
    h(start=3000000),
    C1(
      h_vol_2(start=3000000),
      h(start=3000000),
      P(fixed=true, start=501850)),
    Pm(start=490000))
            annotation (Placement(transformation(
        origin={344,-278},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  ThermoSysPro.Fluid.PressureLosses.PipePressureLoss perteChargeK3(K=1e-4,
    Pm(start=392647.35686859826))
    annotation (Placement(transformation(
        origin={780,-50},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  ThermoSysPro.Fluid.PressureLosses.PipePressureLoss perteChargeK8(K=1e-4,
    Pm(start=392647.3571526791))
    annotation (Placement(transformation(
        origin={780,-10},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  ThermoSysPro.ElectroMechanics.Machines.Generator Alternateur
    annotation (Placement(transformation(extent={{402,-448},{522,-348}},
          rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.PipePressureLoss perteChargeK(K=1e-4,
    C1(h_vol_2(start=191812.29519356362)),
    C2(h_vol_1(start=191812.29519356362)),
    rho(start=989.7481065917054),
    Pm(start=6200))
    annotation (Placement(transformation(extent={{702,-446},{722,-426}},
          rotation=0)));
  ThermoSysPro.Fluid.Machines.StaticCentrifugalPump PompeAlimBP(
    Qv(start=0.19818087844720814),
    a3=400,
    a1(fixed=true) = -6000,
    Q(start=194.502, fixed=false),
    C2(h_vol_1(start=194584.50261452305)),
    Pm(start=807872.6942171099))
            annotation (Placement(transformation(extent={{742,-446},{762,-426}},
          rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.PipePressureLoss perteChargeK2(
    K=1e-4,
    rho(start=990.3728941888568),
    C1(h_vol_2(start=194584.50261452305),
                            h(start=194585)),
    Pm(start=1546000))
    annotation (Placement(transformation(extent={{840,-446},{860,-426}},
          rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.ControlValve vanne_extraction(Cvmax=
        2000,
    h(start=194500),
    Cv(start=2000),
    Pm(start=1597241.885640957))
                 annotation (Placement(transformation(extent={{802,-440},{822,
            -420}}, rotation=0)));
  ThermoSysPro.Fluid.Sensors.SensorQ CapteurDebitVapHP(C1(h_vol_2(start=2674000),
        h(start=2674000)))
    annotation (Placement(transformation(
        origin={-58,8},
        extent={{-6,6},{6,-6}},
        rotation=270)));
  ThermoSysPro.Fluid.Sensors.SensorQ CapteurDebitEauHP(C2(h_vol_1(start=1398000),
        h(start=1398000))) " "
    annotation (Placement(transformation(
        origin={91.5,32},
        extent={{6,-6.5},{-6,6.5}},
        rotation=270)));
  ThermoSysPro.Fluid.Sensors.SensorQ CapteurDebitEauMP(C2(h_vol_1(start=944000),
        h(start=944000)))
    annotation (Placement(transformation(extent={{424,49},{409,63}}, rotation=0)));
  ThermoSysPro.Fluid.Sensors.SensorQ CapteurDebitVapMP(C1(h_vol_2(start=2798000),
        h(start=2798000)))
    annotation (Placement(transformation(
        origin={236,56},
        extent={{-8,8},{8,-8}},
        rotation=180)));
  ThermoSysPro.Fluid.Sensors.SensorQ CapteurDebitVapBP(C2(h_vol_1(start=2685000),
        h(start=2685000)))
    annotation (Placement(transformation(
        origin={514,56},
        extent={{-8,8},{8,-8}},
        rotation=180)));
  ThermoSysPro.Fluid.Sensors.SensorQ CapteurDebitEauBP(C2(h_vol_1(start=550000),
        h(start=550000)))
    annotation (Placement(transformation(
        origin={663.5,34},
        extent={{6,-6.5},{-6,6.5}},
        rotation=270)));
  ThermoSysPro.Fluid.Sensors.SensorQ CapteurDebitEauBPsortie(C2(h_vol_1(
          start=550000), h(start=550000)))
    annotation (Placement(transformation(extent={{687,-11},{700,1}}, rotation=0)));
  ThermoSysPro.Fluid.Sensors.SensorQ CapteurDebitEauCondenseur(C2(h_vol_1(
          start=194585), h(start=194585)))
    annotation (Placement(transformation(
        origin={685.5,-412},
        extent={{-10,-6.5},{10,6.5}},
        rotation=270)));
  ThermoSysPro.Fluid.Sensors.SensorQ CapteurDebitVapCondenseur(C2(h_vol_1(
          start=2401000), h(start=2401000)))
    annotation (Placement(transformation(
        origin={684.5,-264},
        extent={{-10,-6.5},{10,6.5}},
        rotation=270)));
  ThermoSysPro.Fluid.PressureLosses.PipePressureLoss lumpedStraightPipeK2(
                                                          K=Kin_SMP2,
    Pm(start=2651000),
    C1(
      P(fixed=true, start=2726700),
      h_vol_2(start=3046000),
      h(start=3046000)))
    annotation (Placement(transformation(extent={{114,-120},{94,-100}},
          rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.ControlValve vanne_entree_TurbineHP(
    C1(P(fixed=true, start=12680999.9999969)),
    Cvmax=Cvmax_THP,
    h(fixed=false, start=3433000),
    Cv(start=10875),
    Pm(fixed=false, start=12550000))   annotation (Placement(transformation(extent={{-124,-234},{-104,
            -214}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante
    ConsigneNiveauEauHP(                                                              k=1.05)
    annotation (Placement(transformation(extent={{-158,113},{-124,131}},
          rotation=0)));
  ThermoSysPro.Examples.Control.Drum_LevelControl
    regulation_Niveau_HP(
    pIsat(Ti=500, Limiteur1(u(signal(start=0.8)))),
    add(k1=-1, k2=+1),
    Ti=500)
    annotation (Placement(transformation(extent={{-40,106},{-20,126}}, rotation=
           0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante
    ConsigneNiveauEauMP(                                                              k=1.05)
    annotation (Placement(transformation(extent={{173,113},{207,131}}, rotation=
           0)));
  ThermoSysPro.Examples.Control.Drum_LevelControl
    regulation_Niveau_MP(
    pIsat(Ti=500, Limiteur1(u(signal(start=0.8)))),
    add(k1=-1, k2=+1),
    Ti=500)
    annotation (Placement(transformation(extent={{262,106},{282,126}}, rotation=
           0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante
    ConsigneNiveauEauBP(                                                              k=1.75)
    annotation (Placement(transformation(extent={{470,126},{504,144}}, rotation=
           0)));
  ThermoSysPro.Examples.Control.Drum_LevelControl regulation_Niveau_BP(
    add(k1=-1, k2=+1),
    pIsat(Ti=500, Limiteur1(u(signal(start=0.8)))),
    Ti=10) annotation (Placement(transformation(extent={{568,108},{588,128}},
          rotation=0)));
   ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante
    ConsigneNiveauCondenseur1(                                 k=1.5)
    annotation (Placement(transformation(extent={{716,-246},{740,-230}},
          rotation=0)));
  ThermoSysPro.Examples.Control.Condenser_LevelControl
    regulation_Niveau_Condenseur(pIsat(Ti=500, Limiteur1(u(signal(start=0.8)))),
                                                add(k1=+1, k2=-1),
    edge(uL(signal(start=true))))
                                 annotation (Placement(transformation(extent={{
            758,-282},{778,-262}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Tables.Table1DTemps
    ConstantVanneTurbineHP(Table=[0,0.8; 10,0.8; 600,0.8; 650,0.8; 3000,0.8;
        3100,0.8]) annotation (Placement(transformation(extent={{-208,-216},{
            -138,-142}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Rampe arretPomesMp(
    Initialvalue=1400,
    Finalvalue=1000,
    Duration=1000,
    Starttime=200000)
                   annotation (Placement(transformation(extent={{944,-42},{906,
            -10}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Rampe arretPomesHP(
    Initialvalue=1400,
    Finalvalue=1000,
    Duration=1000,
    Starttime=200000)
                   annotation (Placement(transformation(extent={{945,-96},{907,
            -64}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Rampe arretPomesBP(
    Initialvalue=1400,
    Finalvalue=1000,
    Duration=1000,
    Starttime=200000)
                   annotation (Placement(transformation(extent={{945,-458},{907,
            -426}}, rotation=0)));
  ThermoSysPro.Fluid.Volumes.VolumeC VolumeECO_HP1_2(
    V=1,
    h0=988332,
    h(start=880080.2817637667),
    dynamic_mass_balance=true,
    P0=7010000,
    P(start=13222388.265425779))                       annotation (Placement(transformation(
          extent={{456,-98},{436,-78}}, rotation=0)));
  ThermoSysPro.Fluid.Volumes.VolumeC VolumeECO_HP2_3(
    V=1,
    h0=983786,
    h(start=1017356.6143159299),
    dynamic_mass_balance=true,
    P0=7000000,
    P(start=13311571.308698103))                        annotation (Placement(transformation(
          extent={{252,-20},{232,0}}, rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.ControlValve Vanne_alimentationMPHP1(
    Cvmax=308.931,
    h(start=618600),
    Cv(start=308.931),
    Pm(start=13219564.708897255))
                 annotation (Placement(transformation(extent={{754,-98},{730,
            -122}}, rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.ControlValve Vanne_alimentationMPHP2(
    Cvmax=308.931,
    h(start=565000),
    Cv(start=308.931),
    Pm(start=3078586.376751058))
                 annotation (Placement(transformation(extent={{804,-138},{780,
            -162}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Rampe arretPomesMp1(
    Initialvalue=0.8,
    Finalvalue=0.01,
    Duration=1000,
    Starttime=200000)
                     annotation (Placement(transformation(extent={{946,-150},{
            908,-118}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Rampe arretPomesHP1(
    Initialvalue=0.8,
    Finalvalue=0.01,
    Duration=1000,
    Starttime=200000)
                     annotation (Placement(transformation(extent={{946,-194},{
            908,-162}}, rotation=0)));
  ThermoSysPro.Fluid.Volumes.VolumeD VolumePreTHP(
    h0=3e6,
    h(start=3436197.0248581353),
    dynamic_mass_balance=true,
    P0=12700000,
    P(start=12700000))                annotation (Placement(transformation(
        origin={-52,-230},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  ThermoSysPro.Fluid.Volumes.VolumeC MelangeurPreTMP(
    h0=3523910,
    h(start=3516632.5605054167),
    dynamic_mass_balance=true,
    P0=2400000,
    P(start=2400000))                     annotation (Placement(transformation(
        origin={-50,-314},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  ThermoSysPro.Fluid.PressureLosses.ControlValve vanne_entree_TurbineMP(
    C1(P(fixed=true, start=25.486e5)),
    Cvmax=Cvmax_TMP,
    h(fixed=false, start=3518000),
    Cv(start=3.312e6),
    Pm(fixed=false, start=2547000))   annotation (Placement(transformation(extent={{-124,-318},{-104,
            -298}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Tables.Table1DTemps
    ConstantVanneTurbineMP(Table=[0,0.8; 10,0.8; 600,0.8; 2000,0.8; 3000,0.8;
        3100,0.8]) annotation (Placement(transformation(extent={{-208,-300},{
            -138,-226}}, rotation=0)));
  ThermoSysPro.Thermal.BoundaryConditions.HeatSource heatSource(T0={303.16})
    annotation (Placement(transformation(extent={{5,68},{31,98}}, rotation=0)));
  ThermoSysPro.Thermal.BoundaryConditions.HeatSource heatSource1(T0={303.16})
    annotation (Placement(transformation(extent={{326,68},{352,98}}, rotation=0)));
  ThermoSysPro.Thermal.BoundaryConditions.HeatSource heatSource2(T0={303.16})
    annotation (Placement(transformation(extent={{585,64},{611,94}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Math.Gain Gain_2GasTurbine(Gain=
       2) annotation (Placement(transformation(extent={{-18,-448},{2,-428}},
          rotation=0)));
  ThermoSysPro.Fluid.Combustion.BoundaryConditions.FuelSourcePQ sourceCombustible(
    Hum=0,
    Xo=0,
    Xn=0,
    Xs=0,
    rho=0.838,
    Q0=13.4368286133,
    T0=185 + 273.16,
    Xc=0.755,
    Xh=0.245,
    Cp=2255,
    LHV=46989e3) annotation (Placement(transformation(extent={{-421,24},{-385,60}},
          rotation=0)));
  ThermoSysPro.Fluid.BoundaryConditions.SourcePQ sourceEau(             Q0=0.0)
          annotation (Placement(transformation(extent={{-473,27},{-445,57}},
          rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante Humidite(k=0.93)
    annotation (Placement(transformation(extent={{-539,23},{-518,43}}, rotation=
           0)));
  ThermoSysPro.Fluid.BoundaryConditions.SourcePQ SourceFumees(
    Xso2=0,
    Xco2=0,
    Xh2o=0,
    Xo2=0.20994,
    Q0=600,
    T0=29.4 + 273.16,
    P0=1.013e5,
    ftype=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType.FlueGases)
    annotation (Placement(transformation(extent={{-539,-74},{-495,-28}},
          rotation=0)));
  ThermoSysPro.Fluid.Machines.GasTurbine GasTurbine(
    comp_tau_n=14.0178,
    comp_eff_n=0.87004,
    exp_tau_n=0.06458,
    exp_eff_n=0.89045,
    TurbQred=0.0175634,
    Kcham=2.02088,
    chambreCombustionTAC(Pea(fixed=false, start=14.0e5),
      Psf(start=1334276.752202393),
      Tsf(start=1494.4009297392777),
      Hrfg(start=188188.8402613545),
      Tea(start=681.5380510358129)),
    Wpth=1e6,
    Compresseur(
      is_eff(fixed=false, start=0.88),
      Xtau(fixed=false, start=1.00),
      Ps(start=1420538.874033405),
      Ts(start=681.538051035813),
      Tis(start=634.0826153738103),
      Te(start=304.3515709150396)),
    TurbineAgaz(
      Ps(fixed=false),
      is_eff(fixed=false, start=0.87),
      Pe(fixed=false, start=1333900),
      Te(start=1493.59),
      Ts(fixed=false, start=893.16),
      Tis(start=815.7265261633758)),
    xAIR(rho_air(start=1.0865538789495581),
      ppvap0(start=4235.17632590997),
      rho_vap(start=0.030206053717024672)))
    annotation (Placement(transformation(extent={{-471,-115},{-341,13}},
          rotation=0)));

  InstrumentationAndControl.Blocks.Sources.Rampe rampeQfuel(
    Starttime=200,
    Duration=800,
    Initialvalue=13.507,
    Finalvalue=8.756)
                     annotation (Placement(transformation(extent={{-539,64},{
            -519,84}}, rotation=0)));
  InstrumentationAndControl.Blocks.Sources.Rampe rampeIQair(
    Starttime=200,
    Duration=800,
    Finalvalue=415.70,
    Initialvalue=592.7)
                   annotation (Placement(transformation(extent={{-541,-20},{
            -521,0}}, rotation=0)));
equation
  connect(SurchauffeurHP3.Cws1, SurchauffeurHP2.Cws2)
    annotation (Line(points={{-294,-30},{-294,-10},{-174,-10},{-174,-30}},
        color={255,0,0}));
  connect(SurchauffeurHP2.Cws1, SurchauffeurHP1.Cws2)
    annotation (Line(points={{-174,-70},{-174,-90},{-54,-90},{-54,-70}}, color=
          {255,0,0}));
  connect(constante_vanne_vapeurHP.y, vanne_vapeurHP.Ouv)
    annotation (Line(points={{-28.5,74},{-32,74},{-32,67}}));
  connect(vanne_vapeurHP.C1, BallonHP.Cv)
    annotation (Line(points={{-22,50},{-2,50}}, color={255,0,0}));
  connect(GainChargeHP.C1, BallonHP.Cd)
    annotation (Line(points={{38,-90},{48,-90},{48,10},{38,10}}, color={255,128,
          0}));
  connect(BallonHP.Cm, EvaporateurHP.Cws2)
    annotation (Line(points={{-2,10},{-14,10},{-14,-30}}));
  connect(VolumeEvapHP.Cs, EvaporateurHP.Cws1)
    annotation (Line(points={{-12,-90},{-12,-70},{-14,-70}}, color={255,128,0}));
  connect(VolumeEvapHP.Ce1, GainChargeHP.C2)
                                      annotation (Line(points={{8,-90},{18,-90}},
        color={255,128,0}));
  connect(EconomiseurHP4.Cws1, EconomiseurHP3.Cws2)
    annotation (Line(points={{86,-70},{86,-82},{206,-82},{206,-70}}));
  connect(BallonMP.Cm, EvaporateurMP.Cws2)
    annotation (Line(points={{320,10},{306,10},{306,-30}}));
  connect(EvaporateurMP.Cws1, VolumeEvapMP.Cs)
    annotation (Line(points={{306,-70},{306,-80},{308,-80},{308,-90}}, color={
          255,128,0}));
  connect(VolumeEvapMP.Ce1, GainChargeMP.C2)
    annotation (Line(points={{328,-90},{338,-90}}, color={255,128,0}));
  connect(constante_vanne_vapeurMP.y, vanne_vapeurMP.Ouv)
    annotation (Line(points={{291.4,75},{288,75},{288,67}}));
  connect(SurchauffeurHP1.Cfg2, EvaporateurHP.Cfg1)        annotation (Line(
      points={{-44,-50},{-24,-50}},
      color={0,0,0},
      thickness=1));
  connect(EvaporateurHP.Cfg2, EconomiseurHP4.Cfg1)        annotation (Line(
      points={{-4,-50},{76,-50}},
      color={0,0,0},
      thickness=1));
  connect(EconomiseurHP4.Cfg2, SurchauffeurMP1.Cfg1)          annotation (Line(
      points={{96,-50},{136,-50}},
      color={0,0,0},
      thickness=1));
  connect(SurchauffeurMP1.Cfg2, EconomiseurHP3.Cfg1)           annotation (Line(
      points={{156,-50},{196,-50}},
      color={0,0,0},
      thickness=1));
  connect(EvaporateurMP.Cfg2, EconomiseurHP2.Cfg1)           annotation (Line(
      points={{316,-50},{396,-50}},
      color={0,0,0},
      thickness=1));
  connect(EconomiseurHP2.Cfg2, EconomiseurMP.Cfg1)           annotation (Line(
      points={{416,-50},{456,-50}},
      color={0,0,0},
      thickness=1));
  connect(EconomiseurMP.Cfg2, EconomiseurHP1.Cfg1)           annotation (Line(
      points={{476,-50},{516,-50}},
      color={0,0,0},
      thickness=1));
  connect(GainChargeMP.C1, BallonMP.Cd)
    annotation (Line(points={{358,-90},{368,-90},{368,10},{358,10}}, color={255,
          128,0}));
  connect(SurchauffeurMP2.Cfg2, SurchauffeurHP1.Cfg1)          annotation (Line(
      points={{-104,-50},{-64,-50}},
      color={0,0,0},
      thickness=1));
  connect(SurchauffeurMP2.Cfg1, SurchauffeurHP2.Cfg2)           annotation (Line(
      points={{-124,-50},{-164,-50}},
      color={0,0,0},
      thickness=1));
  connect(SurchauffeurMP3.Cfg2, SurchauffeurHP2.Cfg1)           annotation (Line(
      points={{-224,-50},{-184,-50}},
      color={0,0,0},
      thickness=1));
  connect(SurchauffeurHP3.Cfg2, SurchauffeurMP3.Cfg1)           annotation (Line(
      points={{-284,-50},{-244,-50}},
      color={0,0,0},
      thickness=1));
  connect(SurchauffeurMP3.Cws1,SurchauffeurMP2. Cws2)
    annotation (Line(points={{-234,-30},{-234,10},{-114,10},{-114,-30}}, color=
          {255,0,0}));
  connect(SurchauffeurMP1.Cws2, MelangeurHPMP.Ce2) annotation (Line(
      points={{146,-70},{146,-85},{148,-85},{148,-100}},
      color={255,0,0},
      pattern=LinePattern.None));
  connect(vanne_vapeurBP.C1, BallonBP.Cv)
    annotation (Line(points={{558,50},{578,50}}, color={255,0,0}));
  connect(EvaporateurBP.Cws1, VolumeEvapBP.Cs)  annotation (Line(points={{566,
          -70},{566,-90},{572,-90}}, color={255,128,0}));
  connect(VolumeEvapBP.Ce1, GainChargeBP.C2)
                                        annotation (Line(points={{592,-90},{600,
          -90}}, color={255,128,0}));
  connect(BallonBP.Cd, GainChargeBP.C1)
                                       annotation (Line(points={{618,10},{628,
          10},{628,-90},{620,-90}}, color={255,128,0}));
  connect(EconomiseurBP.Cfg2, PuitsFumees.C)     annotation (Line(
      points={{690,-50},{712,-50}},
      color={0,0,0},
      thickness=1));
  connect(EconomiseurHP3.Cfg2, SurchauffeurBP.Cfg1)  annotation (Line(
      points={{216,-50},{256,-50}},
      color={0,0,0},
      thickness=1));
  connect(SurchauffeurBP.Cfg2, EvaporateurMP.Cfg1)  annotation (Line(
      points={{276,-50},{296,-50}},
      color={0,0,0},
      thickness=1));
  connect(EconomiseurHP1.Cfg2, EvaporateurBP.Cfg1) annotation (Line(
      points={{536,-50},{556,-50}},
      color={0,0,0},
      thickness=1));
  connect(EvaporateurBP.Cfg2, EconomiseurBP.Cfg1) annotation (Line(
      points={{576,-50},{670,-50}},
      color={0,0,0},
      thickness=1));
  connect(BallonBP.Cm, EvaporateurBP.Cws2)
    annotation (Line(points={{578,10},{566,10},{566,-30}}));
  connect(vanne_vapeurMP.C1, BallonMP.Cv)   annotation (Line(points={{298,50},{
          320,50}}, color={255,0,0}));
  connect(Vanne_alimentationMPHP.Ouv, constante_ballonBP.y)
    annotation (Line(points={{720,7},{720,12},{727.3,12}}));
  connect(SurchauffeurHP3.Cws2, DoubleDebitHP.Ce)
    annotation (Line(points={{-294,-70},{-294,-80},{-292,-80},{-292,-90}},
        color={255,0,0}));
  connect(SurchauffeurMP3.Cws2, DoubleDebitMP.Ce)
    annotation (Line(points={{-234,-70},{-234,-80},{-232,-80},{-232,-90}},
        color={255,0,0}));
  connect(VolumeCond1.Cs, perteChargeKCond1.C1) annotation (Line(points={{902,
          -308},{902,-282}}, color={0,0,255}));
  connect(Vanne_alimentationMPHP.C2, VolumeAlimMPHP.Ce1)
                                               annotation (Line(points={{730,
          -10},{742,-10}}, color={0,0,255}));
  connect(SurchauffeurBP.Cws2, DoubleDebitBP.Ce)
    annotation (Line(points={{266,-70},{266,-80},{268,-80},{268,-90}}, color={
          255,0,0}));
  connect(perteChargeK8.C2, PompeAlimMP.C1)
    annotation (Line(points={{790,-10},{797,-10},{804,-10}},           color={0,
          0,255}));
  connect(VolumeAlimMPHP.Cs1, perteChargeK8.C1)
    annotation (Line(points={{762,-10},{766,-10},{770,-10}},           color={0,
          0,255}));
  connect(VolumeAlimMPHP.Cs2, perteChargeK3.C1)
                                         annotation (Line(points={{752,-20},{
          752,-50},{770,-50}}, color={0,0,255}));
  connect(perteChargeK3.C2, PompeAlimHP.C1)
    annotation (Line(points={{790,-50},{804,-50}}, color={0,0,255}));
  connect(MelangeurPostTMP1.Ce2, PerteChargeZero2.C2) annotation (Line(points={{418,
          -240},{418,-278},{354,-278}},      color={255,0,0}));
  connect(perteChargeK.C2,PompeAlimBP. C1)
                                         annotation (Line(points={{722,-436},{
          742,-436}}, color={0,0,255}));
  connect(vanne_extraction.C2, perteChargeK2.C1) annotation (Line(points={{822,
          -436},{840,-436}}, color={0,0,255}));
  connect(vanne_alimentationHP.C1, CapteurDebitEauHP.C2)
    annotation (Line(points={{78,50},{86.3,50},{86.3,38.12}}));
  connect(vanne_vapeurHP.C2, CapteurDebitVapHP.C1) annotation (Line(points={{
          -42,50},{-53.2,50},{-53.2,14}}, color={255,0,0}));
  connect(CapteurDebitVapHP.C2, SurchauffeurHP1.Cws1) annotation (Line(points={
          {-53.2,1.88},{-53.2,-3.06},{-54,-3.06},{-54,-30}}, color={255,0,0}));
  connect(vanne_alimentationMP.C1, CapteurDebitEauMP.C2)
    annotation (Line(points={{398,50},{403.425,50},{403.425,50.4},{408.85,50.4}}));
  connect(CapteurDebitVapMP.C1, vanne_vapeurMP.C2) annotation (Line(points={{
          244,49.6},{260,49.6},{260,50},{278,50}}, color={255,0,0}));
  connect(CapteurDebitVapMP.C2, SurchauffeurMP1.Cws1) annotation (Line(points={
          {227.84,49.6},{146,49.6},{146,-30}}, color={255,0,0}));
  connect(CapteurDebitVapBP.C2, SurchauffeurBP.Cws1) annotation (Line(points={{
          505.84,49.6},{490,49.6},{490,-2},{266,-2},{266,-30}}, color={255,0,0}));
  connect(CapteurDebitVapBP.C1, vanne_vapeurBP.C2) annotation (Line(points={{
          522,49.6},{530,49.6},{530,50},{538,50}}, color={255,0,0}));
  connect(CapteurDebitEauBP.C2, vanne_alimentationBP.C1) annotation (Line(
        points={{658.3,40.12},{658.3,48},{650,48}}, color={0,0,255}));
  connect(CapteurDebitEauBPsortie.C2, Vanne_alimentationMPHP.C1) annotation (Line(
        points={{700.13,-9.8},{705.065,-9.8},{705.065,-10},{710,-10}}, color={0,
          0,255}));
  connect(CapteurDebitEauCondenseur.C2, perteChargeK.C1) annotation (Line(
        points={{680.3,-422.2},{680.3,-436},{702,-436}}, color={0,0,255}));
  connect(perteChargeK1.C2, CapteurDebitVapCondenseur.C1) annotation (Line(
        points={{660,-230},{679.3,-230},{679.3,-254}}, color={255,0,0}));
  connect(MelangeurHPMP.Ce1, MoitieDebitHP.Cs)
    annotation (Line(points={{148,-120},{148,-170},{134,-170}}, color={255,0,0}));
  connect(perteChargeK2.C2, MoitieDebitBP.Ce) annotation (Line(points={{860,
          -436},{862,-436},{862,-318},{872,-318}}, color={0,0,255}));
  connect(MoitieDebitBP.Cs, VolumeCond1.Ce3) annotation (Line(points={{886,-318},
          {892,-318}}, color={0,0,255}));
  connect(SurchauffeurMP2.Cws1, lumpedStraightPipeK2.C2)
    annotation (Line(points={{-114,-70},{-114,-110},{94,-110}}, color={255,0,0}));
  connect(lumpedStraightPipeK2.C1, MelangeurHPMP.Cs2)
    annotation (Line(points={{114,-110},{138,-110}},   color={255,0,0}));
  connect(DoubleDebitHP.Cs, vanne_entree_TurbineHP.C1) annotation (Line(points=
          {{-292,-110},{-292,-230},{-124,-230}}, color={255,0,0}));
  connect(DoubleDebitBP.Cs, PerteChargeZero2.C1) annotation (Line(points={{268,
          -110},{268,-278},{334,-278}}, color={255,0,0}));
  connect(PompeAlimBP.C2, vanne_extraction.C1) annotation (Line(points={{762,
          -436},{802,-436}}, color={0,0,255}));
  connect(BallonHP.yLevel,regulation_Niveau_HP. MesureNiveauEau)
    annotation (Line(points={{-4,30},{-68,30},{-68,125},{-40.5,125}}));
  connect(regulation_Niveau_HP.SortieReelle1, vanne_alimentationHP.Ouv)
    annotation (Line(points={{-19.5,107},{68,107},{68,67}}));
  connect(ConsigneNiveauEauMP.y,regulation_Niveau_MP. ConsigneNiveauEau)
    annotation (Line(points={{208.7,122},{234,122},{234,110},{261.5,110}}));
  connect(BallonMP.yLevel,regulation_Niveau_MP. MesureNiveauEau)
    annotation (Line(points={{318.1,30},{252,30},{252,125},{261.5,125}}));
  connect(regulation_Niveau_MP.SortieReelle1, vanne_alimentationMP.Ouv)
    annotation (Line(points={{282.5,107},{377.25,107},{377.25,67},{388,67}}));
  connect(ConsigneNiveauEauBP.y,regulation_Niveau_BP. ConsigneNiveauEau)
    annotation (Line(points={{505.7,135},{529.85,135},{529.85,112},{567.5,112}}));
  connect(BallonBP.yLevel,regulation_Niveau_BP. MesureNiveauEau)
    annotation (Line(points={{576,30},{518,30},{518,127},{567.5,127}}));
  connect(ConsigneNiveauCondenseur1.y, regulation_Niveau_Condenseur.ConsigneNiveauEau)
    annotation (Line(points={{741.2,-238},{752,-238},{752,-269},{757.5,-269}}));
  connect(regulation_Niveau_Condenseur.SortieReelle1, vanne_extraction.Ouv)
    annotation (Line(points={{778.5,-281},{812,-281},{812,-419}}));
  connect(CapteurDebitEauBP.C1, EconomiseurBP.Cws2)
    annotation (Line(points={{658.3,28},{660,28},{660,6},{680,6},{680,-30}}));
  connect(EconomiseurBP.Cws1, perteChargeKCond1.C2) annotation (Line(points={{
          680,-70},{680,-186},{902,-186},{902,-258}}));
  connect(CapteurDebitVapCondenseur.Measure, regulation_Niveau_Condenseur.MesureDebitVapeur)
    annotation (Line(points={{691.13,-264},{704,-264},{704,-280.9},{757.6,
          -280.9}}));
  connect(regulation_Niveau_Condenseur.MesureDebitEau,
    CapteurDebitEauCondenseur.Measure) annotation (Line(points={{757.45,-274.95},
          {750,-274.95},{750,-310},{792,-310},{792,-412},{692.13,-412}}));
  connect(ConstantVanneTurbineHP.y, vanne_entree_TurbineHP.Ouv)
    annotation (Line(points={{-134.5,-179},{-114,-179},{-114,-213}}));
  connect(regulation_Niveau_BP.SortieReelle1, vanne_vapeurBP.Ouv)
    annotation (Line(points={{588.5,109},{600,109},{600,90},{548,90},{548,67}}));
  connect(vanne_alimentationBP.Ouv, constante_vanne_vapeurBP.y)
    annotation (Line(points={{640,65},{640,81},{653.4,81}}));
  connect(EconomiseurHP1.Cws2, VolumeECO_HP1_2.Ce1) annotation (Line(points={{
          526,-70},{526,-88},{456,-88}}, color={0,0,255}));
  connect(VolumeECO_HP1_2.Cs, EconomiseurHP2.Cws1) annotation (Line(points={{
          436,-88},{406,-88},{406,-70}}, color={0,0,255}));
  connect(EconomiseurHP2.Cws2, VolumeECO_HP2_3.Ce1) annotation (Line(points={{
          406,-30},{406,-10},{252,-10}}, color={0,0,255}));
  connect(VolumeECO_HP2_3.Cs, EconomiseurHP3.Cws1) annotation (Line(points={{
          232,-10},{206,-10},{206,-30}}, color={0,0,255}));
  connect(Vanne_alimentationMPHP1.C1, PompeAlimHP.C2)
    annotation (Line(points={{754,-102.8},{842,-102.8},{842,-50},{824,-50}}));
  connect(PompeAlimMP.C2, Vanne_alimentationMPHP2.C1) annotation (Line(points={
          {824,-10},{870,-10},{870,-142.8},{804,-142.8}}, color={0,0,255}));
  connect(arretPomesMp1.y, Vanne_alimentationMPHP1.Ouv)
    annotation (Line(points={{906.1,-134},{856,-134},{856,-122},{742,-122},{742,
          -123.2}}));
  connect(arretPomesHP1.y, Vanne_alimentationMPHP2.Ouv)
    annotation (Line(points={{906.1,-178},{883.05,-178},{883.05,-163.2},{792,
          -163.2}}));
  connect(Vanne_alimentationMPHP1.C2, EconomiseurHP1.Cws1) annotation (Line(
        points={{730,-102.8},{636,-102.8},{636,-106},{548,-106},{548,-6},{526,
          -6},{526,-30}}, color={0,0,255}));
  connect(EconomiseurMP.Cws1, Vanne_alimentationMPHP2.C2)
    annotation (Line(points={{466,-70},{466,-142.8},{780,-142.8}}));
  connect(ConstantVanneTurbineMP.y, vanne_entree_TurbineMP.Ouv)
    annotation (Line(points={{-134.5,-263},{-114,-263},{-114,-297}}));
  connect(vanne_entree_TurbineHP.C2, VolumePreTHP.Ce) annotation (Line(points={
          {-104,-230},{-62,-230}}, color={255,0,0}));
  connect(DoubleDebitMP.Cs, vanne_entree_TurbineMP.C1) annotation (Line(points=
          {{-232,-110},{-232,-314},{-124,-314}}, color={255,0,0}));
  connect(vanne_entree_TurbineMP.C2, MelangeurPreTMP.Ce1) annotation (Line(
        points={{-104,-314},{-60,-314}}, color={255,0,0}));
  connect(SourceCaloporteur.C, Condenseur.Cee) annotation (Line(points={{620,-353},
          {638,-353},{638,-352.8},{637,-352.8}},     color={0,0,255}));
  connect(Condenseur.Cse, PuitsCaloporteur.C) annotation (Line(points={{717,-352},
          {736,-352}},       color={0,0,255}));
  connect(CapteurDebitVapCondenseur.C2, Condenseur.Cv) annotation (Line(points={{679.3,
          -274.2},{679.3,-288.1},{677,-288.1},{677,-304}},         color={0,0,
          255}));
  connect(CapteurDebitEauCondenseur.C1, Condenseur.Cl)
    annotation (Line(points={{680.3,-402},{677.8,-402},{677.8,-384}}));
  connect(ConsigneNiveauEauHP.y, regulation_Niveau_HP.ConsigneNiveauEau)
    annotation (Line(points={{-122.3,122},{-100,122},{-100,110},{-40.5,110}}));
  connect(Condenseur.yNiveau, regulation_Niveau_Condenseur.MesureNiveauEau)
    annotation (Line(points={{721,-372.8},{780,-372.8},{780,-326},{732,-326},{732,
          -263},{757.5,-263}}));
  connect(BallonBP.Cs, CapteurDebitEauBPsortie.C1) annotation (Line(points={{
          578,22},{564,22},{564,16},{642,16},{642,-9.8},{687,-9.8}}, color={0,0,
          255}));
  connect(BallonBP.Ce1, vanne_alimentationBP.C2)
    annotation (Line(points={{618,50},{624,50},{624,48},{630,48}}));
  connect(BallonMP.Ce1, vanne_alimentationMP.C2)
    annotation (Line(points={{358,50},{378,50}}));
  connect(BallonHP.Ce1, vanne_alimentationHP.C2)
    annotation (Line(points={{38,50},{58,50}}));
  connect(TurbineHP.Cs, MoitieDebitHP.Ce) annotation (Line(points={{38.2,-230},
          {74,-230},{74,-170},{114,-170}}, color={255,0,0}));
  connect(VolumePreTHP.Cs3, TurbineHP.Ce) annotation (Line(points={{-42,-230},{
          -2.2,-230}}, color={255,0,0}));
  connect(MelangeurPreTMP.Cs, TurbineMP.Ce) annotation (Line(points={{-40,-314},
          {106,-314},{106,-230},{317.8,-230}}, color={255,0,0}));
  connect(TurbineMP.Cs, MelangeurPostTMP1.Ce1) annotation (Line(points={{358.2,
          -230},{408,-230}}, color={255,0,0}));
  connect(MelangeurPostTMP1.Cs, TurbineBP.Ce) annotation (Line(points={{428,
          -230},{575.8,-230}}, color={255,0,0}));
  connect(TurbineBP.Cs, perteChargeK1.C1) annotation (Line(points={{616.2,-230},
          {640,-230}}, color={255,0,0}));
  connect(EconomiseurMP.Cws2, CapteurDebitEauMP.C1) annotation (Line(points={{
          466,-30},{470,-30},{470,50.4},{424,50.4}}, color={0,0,255}));
  connect(TurbineMP.MechPower, Alternateur.Wmec2)
    annotation (Line(points={{360,-248},{368,-248},{368,-378},{402,-378}}));
  connect(TurbineBP.MechPower, Alternateur.Wmec1) annotation (Line(points={{618,
          -248},{628,-248},{628,-290},{388,-290},{388,-358},{402,-358}}));
  connect(TurbineHP.MechPower, Alternateur.Wmec3)
    annotation (Line(points={{40,-248},{48,-248},{48,-398},{402,-398}}));
  connect(heatSource.C[1], BallonHP.Cex) annotation (Line(points={{18,68.3},{18,
          50}}, color={191,95,0}));
  connect(heatSource1.C[1], BallonMP.Cex) annotation (Line(points={{339,68.3},{
          339,50}}, color={191,95,0}));
  connect(heatSource2.C[1], BallonBP.Cex) annotation (Line(points={{598,64.3},{
          598,50}}, color={191,95,0}));
  connect(Gain_2GasTurbine.y, Alternateur.Wmec5)
    annotation (Line(points={{3,-438},{402,-438}}));
  connect(CapteurDebitEauHP.C1, EconomiseurHP4.Cws2)
    annotation (Line(points={{86.3,26},{86,26},{86,-30}}, smooth=Smooth.None));
  connect(PompeAlimMP.rpm_or_mpower, arretPomesMp.y)
    annotation (Line(points={{814,-21},{814,-26},{904.1,-26}}, smooth=Smooth.None));
  connect(PompeAlimHP.rpm_or_mpower, arretPomesHP.y)
    annotation (Line(points={{814,-61},{814,-80},{905.1,-80}}, smooth=Smooth.None));
  connect(PompeAlimBP.rpm_or_mpower, arretPomesBP.y) annotation (Line(points={{
          752,-447},{754,-447},{754,-460},{878,-460},{878,-442},{905.1,-442}},
        smooth=Smooth.None));
  connect(SourceFumees.C,GasTurbine. Entree_air)
                                                annotation (Line(
      points={{-495,-51},{-471,-51}},
      color={0,0,0},
      thickness=1));
  connect(sourceCombustible.C,GasTurbine. Entree_combustible) annotation (Line(
        points={{-385,42},{-367,42},{-367,13}}, color={0,0,0}));
  connect(sourceEau.C,GasTurbine. Entree_eau_combustion)
    annotation (Line(points={{-445,42},{-445,13}}, color={0,0,255}));
  connect(sourceCombustible.IMassFlow,rampeQfuel. y)
    annotation (Line(points={{-403,51},{-403,74},{-518,74}}));
  connect(rampeIQair.y,SourceFumees. IMassFlow)
    annotation (Line(points={{-520,-10},{-520,-36},{-517,-36},{-517,-39.5}}));
  connect(Humidite.y, GasTurbine.Huminide)
    annotation (Line(points={{-516.95,33},{-487,33},{-487,-12.6},{-473.6,-12.6}}));
  connect(GasTurbine.Sortie_fumees, SurchauffeurHP3.Cfg1) annotation (Line(
      points={{-341,-51},{-290,-50},{-304,-50}},
      color={0,0,0},
      thickness=1));
  connect(GasTurbine.PuissanceMeca, Gain_2GasTurbine.u)
    annotation (Line(points={{-338.4,-76.6},{-326,-76.6},{-326,-438},{-19,-438}}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-550,
            -460},{950,150}},
        initialScale=0.1)),
    experiment(StopTime=2500, Tolerance=0.001),
    experimentSetupOutput,
    Icon(graphics={
        Rectangle(
          lineColor={200,200,200},
          fillColor={248,248,248},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{-100.0,-100.0},{100.0,100.0}},
          radius=25.0),
        Rectangle(
          lineColor={128,128,128},
          extent={{-100.0,-100.0},{100.0,100.0}},
          radius=25.0),
        Polygon(
          origin={8.0,14.0},
          lineColor={78,138,73},
          fillColor={78,138,73},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          points={{-58.0,46.0},{42.0,-14.0},{-58.0,-74.0},{-58.0,46.0}})}),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2021 </p>
<p><b>ThermoSysPro Version 4.0 </h4>
</html>"));
end CombinedCycle_Load_100_50;
