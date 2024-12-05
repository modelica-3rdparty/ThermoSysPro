within ThermoSysPro.Examples.SimpleExamples;
model TestSteamGenerator_1SG_withClosedPurge2

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
  ThermoSysPro.WaterSteam.BoundaryConditions.SinkQ sinkGV(Q0=2147.6 -
        0.00093930797,
    h0=2.77090e6)
    annotation (Placement(transformation(extent={{74,60},{94,80}})));

  ThermoSysPro.WaterSteam.PressureLosses.ControlValve VV_GV(
    Cvmax(fixed=false) = 8791.226,
    Q(fixed=false),
    Pm(fixed=false),
    C2(P(fixed=false, start=6880000)))
    annotation (Placement(transformation(extent={{28,32},{6,52}})));
  ThermoSysPro.WaterSteam.PressureLosses.SingularPressureLoss DP_GV(K(fixed=
          true) = 1e-5)
    annotation (Placement(transformation(extent={{24,60},{44,80}})));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante constante(k=0.7)
            annotation (Placement(transformation(extent={{2,0},{22,20}})));
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

  ThermoSysPro.WaterSteam.BoundaryConditions.SinkQ sinkGV_apg(Q0=0.00093930797,
    h0=1199.465e3)
    annotation (Placement(transformation(extent={{58,-40},{78,-20}})));
  ThermoSysPro.WaterSteam.PressureLosses.SingularPressureLoss DP_GV_apg(K(fixed=
          true) = 1e-5)
    annotation (Placement(transformation(extent={{28,-24},{48,-4}})));
  WaterSteam.Junctions.MassFlowMultiplier massFlowMultiplier(alpha=4)
    annotation (Placement(transformation(extent={{-16,60},{4,80}})));
  WaterSteam.Junctions.MassFlowMultiplier massFlowMultiplier1(alpha=0.25)
    annotation (Placement(transformation(extent={{64,26},{44,46}})));
  WaterSteam.Junctions.MassFlowMultiplier massFlowMultiplier2(alpha=4)
    annotation (Placement(transformation(extent={{0,-24},{20,-4}})));
equation
  connect(DP_GV.C2, sinkGV.C) annotation (Line(points={{44,70},{74,70}},
                    color={238,46,47}));
  connect(constante.y, VV_GV.Ouv) annotation (Line(points={{23,10},{36,10},{36,
          58},{17,58},{17,53}},color={0,0,255}));
  connect(sourcePrimaire.C, steamGenerator_1SG.fluidInlet1) annotation (Line(
        points={{-56,-53},{-26.5867,-53},{-26.5867,-20.2133}}, color={0,0,255}));
  connect(steamGenerator_1SG.fluidOutletI1, sinkPrimaire.C) annotation (Line(
        points={{-9.41333,-20.2133},{-9.41333,-54},{68,-54}}, color={28,108,
          200}));
  connect(VV_GV.C2, steamGenerator_1SG.fluidInlet) annotation (Line(points={{6,36},{
          -8.29333,36},{-8.29333,28.1467}},         color={0,0,255}));
  connect(DP_GV_apg.C2, sinkGV_apg.C) annotation (Line(points={{48,-14},{54,-14},
          {54,-24},{52,-24},{52,-30},{58,-30}},
                              color={238,46,47}));
  connect(DP_GV.C1, massFlowMultiplier.Cs)
    annotation (Line(points={{24,70},{4,70}}, color={0,0,255}));
  connect(massFlowMultiplier.Ce, steamGenerator_1SG.fluidOutletI) annotation (
      Line(points={{-16,70},{-18,70},{-18,35.7933}}, color={0,0,255}));
  connect(VV_GV.C1, massFlowMultiplier1.Cs)
    annotation (Line(points={{28,36},{44,36}}, color={0,0,255}));
  connect(massFlowMultiplier1.Ce, sourceGV.C)
    annotation (Line(points={{64,36},{74,36}}, color={0,0,255}));
  connect(DP_GV_apg.C1, massFlowMultiplier2.Cs)
    annotation (Line(points={{28,-14},{20,-14}}, color={0,0,255}));
  connect(massFlowMultiplier2.Ce, steamGenerator_1SG.fluidOutletI2) annotation
    (Line(points={{0,-14},{-10.3467,-14},{-10.3467,-14.22}}, color={0,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false), graphics={Text(
          extent={{-184,104},{-100,-100}},
          lineColor={28,108,200},
          textString="// Iteration variables values:
DP_GV.Pm                                		=		6606527.5;
DP_GV_apg.Pm                            		=		6684629.0;
VV_GV.C2.P                              		=		6605373.0;
VV_GV.C2.h_vol                          		=		978133.25;
sinkPrimaire.Q                          		=		4756.0;
sourcePrimaire.P                        		=		15603434.0;
steamGenerator_1SG.CapteurPAlim.C2.h_vol		=		1194875.4;
steamGenerator_1SG.DPnulle_AlimDwnc.pro.d		=		834.49225;
steamGenerator_1SG.DomeGV.Cm.Q          		=		2775.5164;
steamGenerator_1SG.DomeGV.Cm.Q          		=		2775.5164;
steamGenerator_1SG.DomeGV.Cs.Q          		=		2238.6167;
steamGenerator_1SG.DomeGV.P             		=		6606528.5;
steamGenerator_1SG.DomeGV.Pfond         		=		6613005.0;
steamGenerator_1SG.DomeGV.Tp            		=		555.09186;
steamGenerator_1SG.DomeGV.hl            		=		1246857.9;
steamGenerator_1SG.DomeGV.hv            		=		2777537.8;
steamGenerator_1SG.DownComerGV.pro.d    		=		765.5974;
steamGenerator_1SG.MixAlimDomeGV.Cs.Q   		=		2775.5166;
steamGenerator_1SG.MixAlimDomeGV.P      		=		6605373.0;
steamGenerator_1SG.MixAlimDomeGV.h      		=		1194875.4;
steamGenerator_1SG.RiserGV.P[2]         		=		6669057.5;
steamGenerator_1SG.RiserGV.P[3]         		=		6657419.5;
steamGenerator_1SG.RiserGV.P[4]         		=		6646544.5;
steamGenerator_1SG.RiserGV.P[5]         		=		6634789.5;
steamGenerator_1SG.RiserGV.P[6]         		=		6621948.0;
steamGenerator_1SG.RiserGV.Q[1]         		=		2775.5164;
steamGenerator_1SG.RiserGV.Q[2]         		=		2775.5164;
steamGenerator_1SG.RiserGV.Q[3]         		=		2775.5164;
steamGenerator_1SG.RiserGV.Q[4]         		=		2775.5164;
steamGenerator_1SG.RiserGV.Q[5]         		=		2775.5164;
steamGenerator_1SG.RiserGV.Q[6]         		=		2775.5164;
steamGenerator_1SG.RiserGV.h[2]         		=		1296133.2;
steamGenerator_1SG.RiserGV.h[3]         		=		1378483.9;
steamGenerator_1SG.RiserGV.h[4]         		=		1445231.9;
steamGenerator_1SG.RiserGV.h[5]         		=		1499247.4;
steamGenerator_1SG.RiserGV.h[6]         		=		1542954.8;
steamGenerator_1SG.UtubeColdtLeg.P[2]   		=		15447537.0;
steamGenerator_1SG.UtubeColdtLeg.P[3]   		=		15447781.0;
steamGenerator_1SG.UtubeColdtLeg.P[4]   		=		15448178.0;
steamGenerator_1SG.UtubeColdtLeg.P[5]   		=		15448695.0;
steamGenerator_1SG.UtubeColdtLeg.P[6]   		=		15449308.0;
steamGenerator_1SG.UtubeColdtLeg.Q[2]   		=		4756.0;
steamGenerator_1SG.UtubeColdtLeg.Q[3]   		=		4756.0;
steamGenerator_1SG.UtubeColdtLeg.Q[4]   		=		4756.0;
steamGenerator_1SG.UtubeColdtLeg.Q[5]   		=		4756.0;
steamGenerator_1SG.UtubeColdtLeg.h[2]   		=		1303392.6;
steamGenerator_1SG.UtubeColdtLeg.h[3]   		=		1291469.2;
steamGenerator_1SG.UtubeColdtLeg.h[4]   		=		1281842.8;
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
steamGenerator_1SG.UtubeHotLeg.h[6]     		=		1318173.2;
steamGenerator_1SG.UtubeHotLeg.h[7]     		=		1318173.2;
steamGenerator_1SG.UtubeHotLeg.h[7]     		=		1318173.2;
steamGenerator_1SG.UtubeHotLeg.pro2[6].T		=		569.5575;
steamGenerator_1SG.UtubeHotLeg.pro2[6].d		=		733.7242;
steamGenerator_1SG.fluidOutletI.h       		=		2777537.8;
steamGenerator_1SG.fluidOutletI2.h      		=		1194875.4;
steamGenerator_1SG.heatExchangerWall1.Tp2[1]		=		556.5059;
steamGenerator_1SG.heatExchangerWall1.Tp2[2]		=		556.2378;
steamGenerator_1SG.heatExchangerWall1.Tp2[3]		=		556.00116;
steamGenerator_1SG.heatExchangerWall1.Tp2[4]		=		555.7813;
steamGenerator_1SG.heatExchangerWall1.Tp2[5]		=		555.5722;
steamGenerator_1SG.volumeA.P            		=		6684629.0;
steamGenerator_1SG.volumeA.h            		=		1194875.4;
steamGenerator_1SG.volumeA1.P           		=		6608083.0;
steamGenerator_1SG.volumeA1.h           		=		1542954.8;")}));
end TestSteamGenerator_1SG_withClosedPurge2;
