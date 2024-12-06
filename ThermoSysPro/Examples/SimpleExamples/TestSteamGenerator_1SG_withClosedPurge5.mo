within ThermoSysPro.Examples.SimpleExamples;
model TestSteamGenerator_1SG_withClosedPurge5

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
    annotation (Placement(transformation(extent={{74,56},{94,76}})));

  ThermoSysPro.WaterSteam.PressureLosses.ControlValve VV_GV(
    Cvmax(fixed=false) = 2200,
    Q(fixed=false),
    Pm(fixed=false),
    C2(P(fixed=false, start=7068393)))
    annotation (Placement(transformation(extent={{28,32},{6,52}})));
  ThermoSysPro.WaterSteam.PressureLosses.SingularPressureLoss DP_GV(K(fixed=
          true) = 1e-5)
    annotation (Placement(transformation(extent={{24,62},{44,82}})));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante constante(k=0.7)
            annotation (Placement(transformation(extent={{4,-6},{24,14}})));

  ThermoSysPro.WaterSteam.BoundaryConditions.SinkQ sinkGV_apg(Q0=0.00093930797,
    h0=1199.465e3)
    annotation (Placement(transformation(extent={{58,-40},{78,-20}})));
  ThermoSysPro.WaterSteam.PressureLosses.SingularPressureLoss DP_GV_apg(K(fixed=
          true) = 1e-5)
    annotation (Placement(transformation(extent={{26,-34},{46,-14}})));
  ThermoSysPro.WaterSteam.HeatExchangers.SteamGenerator_1SG_purges
    steamGenerator_1SG(
    UtubeHotLeg(hcCorr=5.19),
    UtubeColdtLeg(hcCorr=5.19),
    DomeGV(zl(start=0.66, fixed=true)),
    MixAlimDomeGV,
    DPnulle_DomeDwnc,
    CapteurPAlim,
    heatExchangerWall(lambda=150),
    heatExchangerWall1(lambda=150),
    RiserGV(
      dpfCorr(fixed=true) = 5.7,
      hcCorr=5.19,
      C1(P(fixed=false, start=7070000)),
      C2(P(fixed=false, start=6880000)))) annotation (Placement(
        transformation(extent={{-50,-6},{2,42}})));
  WaterSteam.Junctions.MassFlowMultiplier massFlowMultiplier(alpha=4)
    annotation (Placement(transformation(extent={{-14,62},{6,82}})));
  WaterSteam.Junctions.MassFlowMultiplier massFlowMultiplier1(alpha=0.25)
    annotation (Placement(transformation(extent={{62,26},{42,46}})));
  WaterSteam.Junctions.MassFlowMultiplier massFlowMultiplier2(alpha=4)
    annotation (Placement(transformation(extent={{-2,-34},{18,-14}})));
equation
  connect(DP_GV.C2, sinkGV.C) annotation (Line(points={{44,72},{68,72},{68,66},
          {74,66}}, color={238,46,47}));
  connect(constante.y, VV_GV.Ouv) annotation (Line(points={{25,4},{34,4},{34,56},
          {22,56},{22,58},{17,58},{17,53}},
                               color={0,0,255}));
  connect(DP_GV_apg.C2, sinkGV_apg.C) annotation (Line(points={{46,-24},{50,-24},
          {50,-30},{58,-30}}, color={238,46,47}));
  connect(steamGenerator_1SG.fluidOutletI1, sinkPrimaire.C) annotation (Line(
        points={{-16.0267,-1.52},{-16.0267,-54},{68,-54}}, color={255,0,0}));
  connect(steamGenerator_1SG.fluidInlet1, sourcePrimaire.C) annotation (Line(
        points={{-31.9733,-1.52},{-31.9733,-53},{-56,-53}}, color={0,0,255}));
  connect(DP_GV.C1, massFlowMultiplier.Cs)
    annotation (Line(points={{24,72},{6,72}}, color={0,0,255}));
  connect(massFlowMultiplier.Ce, steamGenerator_1SG.fluidOutletI)
    annotation (Line(points={{-14,72},{-24,72},{-24,41.84}}, color={0,0,255}));
  connect(DP_GV_apg.C1, massFlowMultiplier2.Cs)
    annotation (Line(points={{26,-24},{18,-24}}, color={0,0,255}));
  connect(massFlowMultiplier2.Ce, steamGenerator_1SG.fluidOutletI2) annotation
    (Line(points={{-2,-24},{-10,-24},{-10,3.12},{-16.8933,3.12}}, color={0,0,
          255}));
  connect(VV_GV.C2, steamGenerator_1SG.fluidInlet) annotation (Line(points={{6,
          36},{-4.49333,36},{-4.49333,35.92},{-14.9867,35.92}}, color={0,0,255}));
  connect(VV_GV.C1, massFlowMultiplier1.Cs)
    annotation (Line(points={{28,36},{42,36}}, color={0,0,255}));
  connect(massFlowMultiplier1.Ce, sourceGV.C)
    annotation (Line(points={{62,36},{74,36}}, color={0,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false), graphics={Text(
          extent={{-182,104},{-98,-100}},
          lineColor={28,108,200},
          textString="// Iteration variables values:
DP_GV.Pm                                		=		7091364.5;
DP_GV_apg.Pm                            		=		7160126.5;
VV_GV.C2.P                              		=		7090542.5;
VV_GV.C2.h_vol                          		=		978133.25;
sinkPrimaire.Q                          		=		4756.0;
sourcePrimaire.P                        		=		15602015.0;
steamGenerator_1SG.CapteurPAlim.C2.h_vol		=		1206752.1;
steamGenerator_1SG.DPnulle_AlimDwnc.pro.d		=		834.9668;
steamGenerator_1SG.DomeGV.Cm.Q          		=		2414.568;
steamGenerator_1SG.DomeGV.Cm.Q          		=		2414.568;
steamGenerator_1SG.DomeGV.Cs.Q          		=		1877.6683;
steamGenerator_1SG.DomeGV.P             		=		7091365.0;
steamGenerator_1SG.DomeGV.Pfond         		=		7097843.0;
steamGenerator_1SG.DomeGV.Tp            		=		559.849;
steamGenerator_1SG.DomeGV.hl            		=		1272123.2;
steamGenerator_1SG.DomeGV.hv            		=		2771373.8;
steamGenerator_1SG.DownComerGV.pro.d    		=		762.06726;
steamGenerator_1SG.MixAlimDomeGV.Cs.Q   		=		2414.5684;
steamGenerator_1SG.MixAlimDomeGV.P      		=		7090542.5;
steamGenerator_1SG.MixAlimDomeGV.h      		=		1206752.1;
steamGenerator_1SG.RiserGV.P[2]         		=		7145042.5;
steamGenerator_1SG.RiserGV.P[3]         		=		7135627.5;
steamGenerator_1SG.RiserGV.P[4]         		=		7125689.0;
steamGenerator_1SG.RiserGV.P[5]         		=		7115047.5;
steamGenerator_1SG.RiserGV.P[6]         		=		7103958.0;
steamGenerator_1SG.RiserGV.Q[1]         		=		2414.568;
steamGenerator_1SG.RiserGV.Q[2]         		=		2414.568;
steamGenerator_1SG.RiserGV.Q[3]         		=		2414.568;
steamGenerator_1SG.RiserGV.Q[4]         		=		2414.568;
steamGenerator_1SG.RiserGV.Q[5]         		=		2414.568;
steamGenerator_1SG.RiserGV.Q[6]         		=		2414.568;
steamGenerator_1SG.RiserGV.h[2]         		=		1398408.5;
steamGenerator_1SG.RiserGV.h[3]         		=		1503102.4;
steamGenerator_1SG.RiserGV.h[4]         		=		1559065.9;
steamGenerator_1SG.RiserGV.h[5]         		=		1589044.2;
steamGenerator_1SG.RiserGV.h[6]         		=		1605494.4;
steamGenerator_1SG.UtubeColdtLeg.P[2]   		=		15446699.0;
steamGenerator_1SG.UtubeColdtLeg.P[3]   		=		15447328.0;
steamGenerator_1SG.UtubeColdtLeg.P[4]   		=		15447978.0;
steamGenerator_1SG.UtubeColdtLeg.P[5]   		=		15448642.0;
steamGenerator_1SG.UtubeColdtLeg.P[6]   		=		15449317.0;
steamGenerator_1SG.UtubeColdtLeg.Q[2]   		=		4756.0;
steamGenerator_1SG.UtubeColdtLeg.Q[3]   		=		4756.0;
steamGenerator_1SG.UtubeColdtLeg.Q[4]   		=		4756.0;
steamGenerator_1SG.UtubeColdtLeg.Q[5]   		=		4756.0;
steamGenerator_1SG.UtubeColdtLeg.h[2]   		=		1272811.5;
steamGenerator_1SG.UtubeColdtLeg.h[3]   		=		1271084.5;
steamGenerator_1SG.UtubeColdtLeg.h[4]   		=		1269947.2;
steamGenerator_1SG.UtubeColdtLeg.h[5]   		=		1269104.1;
steamGenerator_1SG.UtubeColdtLeg.h[6]   		=		1268403.0;
steamGenerator_1SG.UtubeHotLeg.P[2]     		=		15575957.0;
steamGenerator_1SG.UtubeHotLeg.P[3]     		=		15549982.0;
steamGenerator_1SG.UtubeHotLeg.P[4]     		=		15524016.0;
steamGenerator_1SG.UtubeHotLeg.P[5]     		=		15498049.0;
steamGenerator_1SG.UtubeHotLeg.P[6]     		=		15472078.0;
steamGenerator_1SG.UtubeHotLeg.P[7]     		=		15446106.0;
steamGenerator_1SG.UtubeHotLeg.Q[2]     		=		4756.0;
steamGenerator_1SG.UtubeHotLeg.Q[3]     		=		4756.0;
steamGenerator_1SG.UtubeHotLeg.Q[4]     		=		4756.0;
steamGenerator_1SG.UtubeHotLeg.Q[5]     		=		4756.0;
steamGenerator_1SG.UtubeHotLeg.Q[6]     		=		4756.0;
steamGenerator_1SG.UtubeHotLeg.h[2]     		=		1376375.5;
steamGenerator_1SG.UtubeHotLeg.h[3]     		=		1324950.6;
steamGenerator_1SG.UtubeHotLeg.h[4]     		=		1297675.8;
steamGenerator_1SG.UtubeHotLeg.h[5]     		=		1283299.2;
steamGenerator_1SG.UtubeHotLeg.h[6]     		=		1275648.9;
steamGenerator_1SG.UtubeHotLeg.h[7]     		=		1275648.9;
steamGenerator_1SG.UtubeHotLeg.h[7]     		=		1275648.9;
steamGenerator_1SG.UtubeHotLeg.pro2[6].T		=		561.5154;
steamGenerator_1SG.UtubeHotLeg.pro2[6].d		=		749.1915;
steamGenerator_1SG.fluidOutletI.h       		=		2771373.8;
steamGenerator_1SG.fluidOutletI2.h      		=		1206752.1;
steamGenerator_1SG.heatExchangerWall1.Tp2[1]		=		560.56665;
steamGenerator_1SG.heatExchangerWall1.Tp2[2]		=		560.39185;
steamGenerator_1SG.heatExchangerWall1.Tp2[3]		=		560.25653;
steamGenerator_1SG.heatExchangerWall1.Tp2[4]		=		560.1358;
steamGenerator_1SG.heatExchangerWall1.Tp2[5]		=		560.0208;
steamGenerator_1SG.volumeA.P            		=		7160126.5;
steamGenerator_1SG.volumeA.h            		=		1206752.1;
steamGenerator_1SG.volumeA1.P           		=		7092599.0;
steamGenerator_1SG.volumeA1.h           		=		1605494.4;")}));
end TestSteamGenerator_1SG_withClosedPurge5;
