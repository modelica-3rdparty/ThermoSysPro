within ThermoSysPro.Examples.SimpleExamples;
model TestSteamGenerator_1SG_withClosedPurge

  ThermoSysPro.WaterSteam.BoundaryConditions.SinkP sinkPrimaire(
    option_temperature=2,
    P0(fixed=true) = 15450000,
    h0=1.27187e6)
    annotation (Placement(transformation(extent={{68,-64},{88,-44}})));
  ThermoSysPro.WaterSteam.BoundaryConditions.SourceQ sourcePrimaire(h0=
        1.47084e6, Q0=19024/4)
    annotation (Placement(transformation(extent={{-74,-62},{-56,-44}})));
  ThermoSysPro.WaterSteam.BoundaryConditions.SourceP sourceGV(
    P0=7370400,
    h0=978133.25,
    option_temperature=2)
    annotation (Placement(transformation(extent={{98,24},{74,48}})));
  ThermoSysPro.WaterSteam.BoundaryConditions.SinkQ sinkGV(Q0=(2147.6 -
        0.00093930797)/4,
    h0=2.77090e6)
    annotation (Placement(transformation(extent={{74,56},{94,76}})));

  ThermoSysPro.WaterSteam.PressureLosses.ControlValve VV_GV(
    Cvmax(fixed=false) = 8791.226,
    Q(fixed=false),
    Pm(fixed=false),
    C2(P(fixed=false, start=6880000)))
    annotation (Placement(transformation(extent={{66,32},{44,52}})));
  ThermoSysPro.WaterSteam.PressureLosses.SingularPressureLoss DP_GV(K(fixed=
          true) = 1e-5)
    annotation (Placement(transformation(extent={{24,62},{44,82}})));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante constante(k=0.7)
            annotation (Placement(transformation(extent={{26,-12},{46,8}})));
  ThermoSysPro.WaterSteam.HeatExchangers.SteamGenerator_1SG_purges
    steamGenerator_1SG(
    DomeGV(
      R=2.2,
      L=5,
      zl(start=0.66, fixed=true)),
    MixAlimDomeGV,
    DPnulle_DomeDwnc,
    CapteurPAlim,
    RiserGV(
      L=10.8,
      z2=10.8,
      dpfCorr(fixed=true) = 5.7,
      C1(P(fixed=false, start=7070000)),
      C2(P(fixed=false, start=6880000))),
    DownComerGV(lambda=0.01))
    annotation (Placement(transformation(extent={{-46,-26},{10,36}})));

  ThermoSysPro.WaterSteam.BoundaryConditions.SinkQ sinkGV_apg(Q0=0.00093930797/
        4,
    h0=1199.465e3)
    annotation (Placement(transformation(extent={{58,-40},{78,-20}})));
  ThermoSysPro.WaterSteam.PressureLosses.SingularPressureLoss DP_GV_apg(K(fixed=
          true) = 1e-5)
    annotation (Placement(transformation(extent={{8,-34},{28,-14}})));
equation
  connect(VV_GV.C1, sourceGV.C)
    annotation (Line(points={{66,36},{74,36}},   color={0,0,255}));
  connect(DP_GV.C2, sinkGV.C) annotation (Line(points={{44,72},{68,72},{68,66},
          {74,66}}, color={238,46,47}));
  connect(constante.y, VV_GV.Ouv) annotation (Line(points={{47,-2},{62,-2},{
          62,53},{55,53}},     color={0,0,255}));
  connect(sourcePrimaire.C, steamGenerator_1SG.fluidInlet1) annotation (Line(
        points={{-56,-53},{-26.5867,-53},{-26.5867,-20.2133}}, color={0,0,255}));
  connect(steamGenerator_1SG.fluidOutletI1, sinkPrimaire.C) annotation (Line(
        points={{-9.41333,-20.2133},{-9.41333,-54},{68,-54}}, color={28,108,
          200}));
  connect(VV_GV.C2, steamGenerator_1SG.fluidInlet) annotation (Line(points={{44,36},
          {-8.29333,36},{-8.29333,28.1467}},        color={0,0,255}));
  connect(DP_GV.C1, steamGenerator_1SG.fluidOutletI) annotation (Line(points={{24,72},
          {8,72},{8,70},{-18,70},{-18,35.7933}},          color={238,46,47}));
  connect(DP_GV_apg.C2, sinkGV_apg.C) annotation (Line(points={{28,-24},{52,-24},
          {52,-30},{58,-30}}, color={238,46,47}));
  connect(DP_GV_apg.C1, steamGenerator_1SG.fluidOutletI2) annotation (Line(
        points={{8,-24},{8,-14},{-10.3467,-14},{-10.3467,-14.22}}, color={0,0,
          255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false), graphics={Text(
          extent={{-184,104},{-100,-100}},
          lineColor={28,108,200},
          textString="// Iteration variables values:
DP_GV.Pm                                		=		6606527.5;
DP_GV_apg.Pm                            		=		6684628.0;
VV_GV.C2.P                              		=		6605371.5;
VV_GV.C2.h_vol                          		=		978133.25;
sinkPrimaire.Q                          		=		4756.0;
sourcePrimaire.P                        		=		15603434.0;
steamGenerator_1SG.CapteurPAlim.C2.h_vol		=		1194875.2;
steamGenerator_1SG.DPnulle_AlimDwnc.pro.d		=		834.49225;
steamGenerator_1SG.DPnulle_DomeDwnc.Pm  		=		6605949.5;
steamGenerator_1SG.DomeGV.Cm.Q          		=		2775.5164;
steamGenerator_1SG.DomeGV.Cm.Q          		=		2775.5164;
steamGenerator_1SG.DomeGV.Cs.Q          		=		2238.6167;
steamGenerator_1SG.DomeGV.Cs.Q          		=		2238.6167;
steamGenerator_1SG.DomeGV.Pfond         		=		6613003.5;
steamGenerator_1SG.DomeGV.Tp            		=		555.0794;
steamGenerator_1SG.DomeGV.hl            		=		1246857.8;
steamGenerator_1SG.DomeGV.hv            		=		2777538.2;
steamGenerator_1SG.DownComerGV.pro.d    		=		765.5975;
steamGenerator_1SG.MixAlimDomeGV.Cs.Q   		=		2775.5166;
steamGenerator_1SG.MixAlimDomeGV.P      		=		6605371.5;
steamGenerator_1SG.MixAlimDomeGV.h      		=		1194875.2;
steamGenerator_1SG.RiserGV.P[2]         		=		6669056.5;
steamGenerator_1SG.RiserGV.P[3]         		=		6657418.5;
steamGenerator_1SG.RiserGV.P[4]         		=		6646543.0;
steamGenerator_1SG.RiserGV.P[5]         		=		6634788.5;
steamGenerator_1SG.RiserGV.P[6]         		=		6621947.0;
steamGenerator_1SG.RiserGV.Q[1]         		=		2775.5164;
steamGenerator_1SG.RiserGV.Q[2]         		=		2775.5164;
steamGenerator_1SG.RiserGV.Q[3]         		=		2775.5164;
steamGenerator_1SG.RiserGV.Q[4]         		=		2775.5164;
steamGenerator_1SG.RiserGV.Q[5]         		=		2775.5164;
steamGenerator_1SG.RiserGV.Q[6]         		=		2775.5164;
steamGenerator_1SG.RiserGV.h[2]         		=		1296133.1;
steamGenerator_1SG.RiserGV.h[3]         		=		1378483.9;
steamGenerator_1SG.RiserGV.h[4]         		=		1445231.9;
steamGenerator_1SG.RiserGV.h[5]         		=		1499247.2;
steamGenerator_1SG.RiserGV.h[6]         		=		1542954.6;
steamGenerator_1SG.UtubeColdtLeg.P[2]   		=		15447537.0;
steamGenerator_1SG.UtubeColdtLeg.P[3]   		=		15447781.0;
steamGenerator_1SG.UtubeColdtLeg.P[4]   		=		15448178.0;
steamGenerator_1SG.UtubeColdtLeg.P[5]   		=		15448695.0;
steamGenerator_1SG.UtubeColdtLeg.P[6]   		=		15449308.0;
steamGenerator_1SG.UtubeColdtLeg.Q[2]   		=		4756.0;
steamGenerator_1SG.UtubeColdtLeg.Q[3]   		=		4756.0;
steamGenerator_1SG.UtubeColdtLeg.Q[4]   		=		4756.0;
steamGenerator_1SG.UtubeColdtLeg.Q[5]   		=		4756.0;
steamGenerator_1SG.UtubeColdtLeg.h[2]   		=		1303392.5;
steamGenerator_1SG.UtubeColdtLeg.h[3]   		=		1291469.1;
steamGenerator_1SG.UtubeColdtLeg.h[4]   		=		1281842.6;
steamGenerator_1SG.UtubeColdtLeg.h[5]   		=		1274047.8;
steamGenerator_1SG.UtubeColdtLeg.h[6]   		=		1267707.1;
steamGenerator_1SG.UtubeHotLeg.P[2]     		=		15577376.0;
steamGenerator_1SG.UtubeHotLeg.P[3]     		=		15551369.0;
steamGenerator_1SG.UtubeHotLeg.P[4]     		=		15525387.0;
steamGenerator_1SG.UtubeHotLeg.P[5]     		=		15499416.0;
steamGenerator_1SG.UtubeHotLeg.P[6]     		=		15473450.0;
steamGenerator_1SG.UtubeHotLeg.P[7]     		=		15447485.0;
steamGenerator_1SG.UtubeHotLeg.Q[2]     		=		4756.0;
steamGenerator_1SG.UtubeHotLeg.Q[3]     		=		4756.0;
steamGenerator_1SG.UtubeHotLeg.Q[4]     		=		4756.0;
steamGenerator_1SG.UtubeHotLeg.Q[5]     		=		4756.0;
steamGenerator_1SG.UtubeHotLeg.Q[6]     		=		4756.0;
steamGenerator_1SG.UtubeHotLeg.h[2]     		=		1426528.4;
steamGenerator_1SG.UtubeHotLeg.h[3]     		=		1390393.4;
steamGenerator_1SG.UtubeHotLeg.h[4]     		=		1361066.9;
steamGenerator_1SG.UtubeHotLeg.h[5]     		=		1337339.4;
steamGenerator_1SG.UtubeHotLeg.h[6]     		=		1318173.1;
steamGenerator_1SG.UtubeHotLeg.h[7]     		=		1318173.1;
steamGenerator_1SG.UtubeHotLeg.h[7]     		=		1318173.1;
steamGenerator_1SG.UtubeHotLeg.pro2[6].T		=		569.5575;
steamGenerator_1SG.UtubeHotLeg.pro2[6].d		=		733.7242;
steamGenerator_1SG.heatExchangerWall1.Tp2[1]		=		556.5059;
steamGenerator_1SG.heatExchangerWall1.Tp2[2]		=		556.2378;
steamGenerator_1SG.heatExchangerWall1.Tp2[3]		=		556.00116;
steamGenerator_1SG.heatExchangerWall1.Tp2[4]		=		555.7813;
steamGenerator_1SG.heatExchangerWall1.Tp2[5]		=		555.5722;
steamGenerator_1SG.volumeA.P            		=		6684628.0;
steamGenerator_1SG.volumeA.h            		=		1194875.2;
steamGenerator_1SG.volumeA1.P           		=		6608082.0;
steamGenerator_1SG.volumeA1.h           		=		1542954.6;")}));
end TestSteamGenerator_1SG_withClosedPurge;
