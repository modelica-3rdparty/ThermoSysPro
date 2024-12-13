within ThermoSysPro.Examples.SimpleExamples;
model TestSteamGenerator_1SG_withClosedPurge4

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
      dpfCorr(fixed=true) = 50,
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
DP_GV.Pm                                		=		7068393.5;
DP_GV_apg.Pm                            		=		7155291.5;
VV_GV.C2.P                              		=		7068393.0;
VV_GV.C2.h_vol                          		=		978133.25;
sinkPrimaire.Q                          		=		4756.0;
sourcePrimaire.P                        		=		15602120.0;
steamGenerator_1SG.CapteurPAlim.C2.h_vol		=		1007554.1;
steamGenerator_1SG.DPnulle_AlimDwnc.pro.d		=		834.9452;
steamGenerator_1SG.DomeGV.Cm.Q          		=		596.8746;
steamGenerator_1SG.DomeGV.Cm.Q          		=		596.8746;
steamGenerator_1SG.DomeGV.Cs.Q          		=		59.97482;
steamGenerator_1SG.DomeGV.P             		=		7068394.0;
steamGenerator_1SG.DomeGV.Pfond         		=		7074872.0;
steamGenerator_1SG.DomeGV.Tp            		=		559.62714;
steamGenerator_1SG.DomeGV.hl            		=		1270932.5;
steamGenerator_1SG.DomeGV.hv            		=		2771676.0;
steamGenerator_1SG.DownComerGV.pro.d    		=		826.39777;
steamGenerator_1SG.MixAlimDomeGV.Cs.Q   		=		596.8748;
steamGenerator_1SG.MixAlimDomeGV.P      		=		7068393.0;
steamGenerator_1SG.MixAlimDomeGV.h      		=		1007554.1;
steamGenerator_1SG.RiserGV.P[2]         		=		7139844.0;
steamGenerator_1SG.RiserGV.P[3]         		=		7131381.0;
steamGenerator_1SG.RiserGV.P[4]         		=		7118790.0;
steamGenerator_1SG.RiserGV.P[5]         		=		7103591.5;
steamGenerator_1SG.RiserGV.P[6]         		=		7086486.0;
steamGenerator_1SG.RiserGV.Q[1]         		=		596.8746;
steamGenerator_1SG.RiserGV.Q[2]         		=		596.8746;
steamGenerator_1SG.RiserGV.Q[3]         		=		596.8746;
steamGenerator_1SG.RiserGV.Q[4]         		=		596.8746;
steamGenerator_1SG.RiserGV.Q[5]         		=		596.8746;
steamGenerator_1SG.RiserGV.Q[6]         		=		596.8746;
steamGenerator_1SG.RiserGV.h[2]         		=		1763458.6;
steamGenerator_1SG.RiserGV.h[3]         		=		2179319.5;
steamGenerator_1SG.RiserGV.h[4]         		=		2415660.8;
steamGenerator_1SG.RiserGV.h[5]         		=		2551510.8;
steamGenerator_1SG.RiserGV.h[6]         		=		2620879.0;
steamGenerator_1SG.UtubeColdtLeg.P[2]   		=		15446754.0;
steamGenerator_1SG.UtubeColdtLeg.P[3]   		=		15447354.0;
steamGenerator_1SG.UtubeColdtLeg.P[4]   		=		15447989.0;
steamGenerator_1SG.UtubeColdtLeg.P[5]   		=		15448645.0;
steamGenerator_1SG.UtubeColdtLeg.P[6]   		=		15449317.0;
steamGenerator_1SG.UtubeColdtLeg.Q[2]   		=		4756.0;
steamGenerator_1SG.UtubeColdtLeg.Q[3]   		=		4756.0;
steamGenerator_1SG.UtubeColdtLeg.Q[4]   		=		4756.0;
steamGenerator_1SG.UtubeColdtLeg.Q[5]   		=		4756.0;
steamGenerator_1SG.UtubeColdtLeg.h[2]   		=		1275097.4;
steamGenerator_1SG.UtubeColdtLeg.h[3]   		=		1272384.6;
steamGenerator_1SG.UtubeColdtLeg.h[4]   		=		1270610.9;
steamGenerator_1SG.UtubeColdtLeg.h[5]   		=		1269303.9;
steamGenerator_1SG.UtubeColdtLeg.h[6]   		=		1268368.9;
steamGenerator_1SG.UtubeHotLeg.P[2]     		=		15576062.0;
steamGenerator_1SG.UtubeHotLeg.P[3]     		=		15550085.0;
steamGenerator_1SG.UtubeHotLeg.P[4]     		=		15524119.0;
steamGenerator_1SG.UtubeHotLeg.P[5]     		=		15498153.0;
steamGenerator_1SG.UtubeHotLeg.P[6]     		=		15472183.0;
steamGenerator_1SG.UtubeHotLeg.P[7]     		=		15446212.0;
steamGenerator_1SG.UtubeHotLeg.Q[2]     		=		4756.0;
steamGenerator_1SG.UtubeHotLeg.Q[3]     		=		4756.0;
steamGenerator_1SG.UtubeHotLeg.Q[4]     		=		4756.0;
steamGenerator_1SG.UtubeHotLeg.Q[5]     		=		4756.0;
steamGenerator_1SG.UtubeHotLeg.Q[6]     		=		4756.0;
steamGenerator_1SG.UtubeHotLeg.h[2]     		=		1380702.2;
steamGenerator_1SG.UtubeHotLeg.h[3]     		=		1331224.9;
steamGenerator_1SG.UtubeHotLeg.h[4]     		=		1303337.9;
steamGenerator_1SG.UtubeHotLeg.h[5]     		=		1287595.9;
steamGenerator_1SG.UtubeHotLeg.h[6]     		=		1279825.1;
steamGenerator_1SG.UtubeHotLeg.h[7]     		=		1279825.1;
steamGenerator_1SG.UtubeHotLeg.h[7]     		=		1279825.1;
steamGenerator_1SG.UtubeHotLeg.pro2[6].T		=		562.3159;
steamGenerator_1SG.UtubeHotLeg.pro2[6].d		=		747.6996;
steamGenerator_1SG.fluidOutletI.h       		=		2771676.0;
steamGenerator_1SG.fluidOutletI2.h      		=		1007554.1;
steamGenerator_1SG.heatExchangerWall1.Tp2[1]		=		560.738;
steamGenerator_1SG.heatExchangerWall1.Tp2[2]		=		560.50226;
steamGenerator_1SG.heatExchangerWall1.Tp2[3]		=		560.2941;
steamGenerator_1SG.heatExchangerWall1.Tp2[4]		=		560.1085;
steamGenerator_1SG.heatExchangerWall1.Tp2[5]		=		559.9811;
steamGenerator_1SG.volumeA.P            		=		7155291.5;
steamGenerator_1SG.volumeA.h            		=		1007554.1;
steamGenerator_1SG.volumeA1.P           		=		7068655.5;
steamGenerator_1SG.volumeA1.h           		=		2620879.0;")}));
end TestSteamGenerator_1SG_withClosedPurge4;
