within ;
model PP4_PosteEau_RE1_2_testXh2O
  ThermoSysPro.Fluid.BoundaryConditions.SourceP sourceSGV(
    ftype=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType.WaterSteam,
    P0=6880000,
    h0=2770.90e3,
    option_temperature=false,
    region=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions)
    annotation (Placement(transformation(extent={{-220,-10},{-200,10}})));

  ThermoSysPro.Fluid.PressureLosses.PipePressureLoss pipePressureLoss(
    K(fixed=false) = 1.81107,
    region=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions,
                      C2(P(fixed=true, start=6643000)))
    annotation (Placement(transformation(extent={{-180,-10},{-160,10}})));
  ThermoSysPro.Fluid.PressureLosses.ControlValve controlValve(
    Cvmax(fixed=false) = 8005.42,
                           region=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions,
    Q(fixed=true, start=1957.3))
    annotation (Placement(transformation(extent={{-24,-24},{-8,-8}})));
  ThermoSysPro.Fluid.PressureLosses.PipePressureLoss pipePressureLoss1(K(fixed=
          false) = 213.926,
    region=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions,
                           C2(P(fixed=true, start=6415000)))
    annotation (Placement(transformation(extent={{-28,30},{-8,50}})));
  ThermoSysPro.Fluid.Volumes.VolumeA volumeA(ftype=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType.WaterSteam)
    annotation (Placement(transformation(extent={{-120,-10},{-100,10}})));
  ThermoSysPro.Fluid.Machines.StodolaTurbine stodolaTurbine(
    Cst(fixed=false) = 14566.4314660273,
    eta_is_nom=0.97,
    region_e=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions,
    region_s=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions,
    region_ps=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions,
              Ce(P(fixed=true, start=6189000)))
    annotation (Placement(transformation(extent={{32,-30},{52,-10}})));

  ThermoSysPro.Fluid.BoundaryConditions.SinkQ sinkQ1(
    Q0=102.96,
    h0=2577e3,
    region=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions,
    Xco2(start=0),
    Xh2o(start=0),
    Xo2(start=0),
    Xso2(start=0))
    annotation (Placement(transformation(extent={{102,-90},{122,-70}})));
  ThermoSysPro.Fluid.PressureLosses.PipePressureLoss pipePressureLoss2(K=1e-5, region=
        ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions)
    annotation (Placement(transformation(
        extent={{-9,8},{9,-8}},
        rotation=270,
        origin={101,-60})));
  ThermoSysPro.Fluid.PressureLosses.PipePressureLoss pipePressureLoss3(K=1e-5, region=
        ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions)
    annotation (Placement(transformation(extent={{276,-30},{294,-14}})));
  ThermoSysPro.Fluid.Junctions.SteamExtractionSplitter
    steamExtractionSplitter(
    wsftype=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.WaterSteamFluidType.WaterSteam,
    alpha(fixed=false) = 0.965387049578459,
    region_e=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions,
    Cex(h(fixed=true, start=2577e3)))
    annotation (Placement(transformation(extent={{82,-30},{102,-10}})));

  ThermoSysPro.Fluid.Machines.StodolaTurbine stodolaTurbine1(
    Cst(fixed=false) = 3064.57188340534,
    eta_is_nom=0.97,
    region_e=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions,
    region_s=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions,
    region_ps=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions,
    Ce(P(fixed=true, start=2792000)))
    annotation (Placement(transformation(extent={{128,-30},{148,-10}})));

  ThermoSysPro.Fluid.Junctions.SteamExtractionSplitter
    steamExtractionSplitter1(
    wsftype=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.WaterSteamFluidType.WaterSteam,
    alpha(fixed=false) = 0.986824445626561,
    region_e=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions,
    Cex(h(fixed=true, start=2540.70e3)))
    annotation (Placement(transformation(extent={{166,-30},{186,-10}})));

  ThermoSysPro.Fluid.PressureLosses.PipePressureLoss pipePressureLoss4(K=1e-5, region=
        ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions)
    annotation (Placement(transformation(
        extent={{-9,8},{9,-8}},
        rotation=270,
        origin={183,-54})));
  ThermoSysPro.Fluid.BoundaryConditions.SinkQ sinkQ2(
    Q0=116.83,
    h0=2540.70e3,
    region=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions,
    Xco2(start=0),
    Xh2o(start=0),
    Xo2(start=0),
    Xso2(start=0))
    annotation (Placement(transformation(extent={{190,-90},{210,-70}})));
  ThermoSysPro.Fluid.Junctions.SteamExtractionSplitter
    steamExtractionSplitter2(
    wsftype=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.WaterSteamFluidType.WaterSteam,
    alpha(fixed=false) = 0.761656888272063,
    region_e=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions,
    Cex(h(fixed=true, start=2067.3e3)),
    Cs(h(fixed=true, start=2530.7e3)))
    annotation (Placement(transformation(extent={{242,-32},{262,-12}})));

  ThermoSysPro.Fluid.Machines.StodolaTurbine stodolaTurbine2(
    Cst(fixed=false) = 1661.24780934428,
    eta_is_nom(fixed=false) = 0.973786,
    region_e=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions,
    region_s=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions,
    region_ps=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions,
    Ce(P(fixed=true, start=1726000)))
    annotation (Placement(transformation(extent={{206,-30},{226,-10}})));

  ThermoSysPro.Fluid.PressureLosses.PipePressureLoss pipePressureLoss5(K=1e-5, region=
        ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions)
    annotation (Placement(transformation(
        extent={{-9,8},{9,-8}},
        rotation=270,
        origin={257,-50})));
  ThermoSysPro.Fluid.BoundaryConditions.SinkQ sinkQ3(
    Q0=191.07,
    h0=2067.3e3,
    region=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions,
    Xco2(start=0),
    Xh2o(start=0),
    Xo2(start=0),
    Xso2(start=0))
    annotation (Placement(transformation(extent={{274,-90},{294,-70}})));
  ThermoSysPro.Fluid.Junctions.SteamDryer steamDryer(wsftype=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.WaterSteamFluidType.WaterSteam,
    eta=1,
    region_e=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions)
    annotation (Placement(transformation(extent={{320,-32},{340,-12}})));
  ThermoSysPro.Fluid.PressureLosses.PipePressureLoss pipePressureLoss6(K=1e-5, region=
        ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions)
    annotation (Placement(transformation(extent={{364,-28},{382,-12}})));
  ThermoSysPro.Fluid.BoundaryConditions.Sink  sinkQ4(h0=750.22e3, region=
        ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions,
    Xco2(start=0),
    Xh2o(start=0),
    Xo2(start=0),
    Xso2(start=0))
    annotation (Placement(transformation(extent={{338,-84},{364,-54}})));
  ThermoSysPro.Fluid.PressureLosses.PipePressureLoss pipePressureLoss7(K=1e-5,
      region=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions)
    annotation (Placement(transformation(extent={{490,-28},{508,-12}})));
  ThermoSysPro.Fluid.PressureLosses.PipePressureLoss pipePressureLoss8(
    K(fixed=false) = 1e-5,
    region=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions,
    C2(P(fixed=true, start=6323000)))
    annotation (Placement(transformation(
        extent={{-9,8},{9,-8}},
        rotation=270,
        origin={451,-48})));

  ThermoSysPro.Fluid.HeatExchangers.NTUWaterHeater nTUWaterHeater(
    wsftype=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.WaterSteamFluidType.WaterSteam,
    lambdaE(fixed=false) = 1,
    SCondDes(fixed=true) = 3000,
    KCond(fixed=false) = 297.647,
    KPurge(fixed=true) = 1,
    region_eeF=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions,
    region_seF=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions,
    region_evC=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions,
    region_mF=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions,
    region_epC=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions,
    region_spC=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions,
    region_flash=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions,
    Se(
      P(fixed=false, start=899700),
      Q(fixed=false, start=1359.95),
      h(fixed=false, start=2979.50e3),
      Xco2(start=0),
      Xh2o(start=0),
      Xo2(start=0),
      Xso2(start=0)),
    Sp(
      Q(fixed=true, start=190.26),
      h(fixed=false, start=1231.6e3),
      Xco2(start=0),
      Xh2o(start=0),
      Xo2(start=0),
      Xso2(start=0)),
    Ee(
      P(fixed=true, start=932000),
      Xco2(start=0),
      Xh2o(start=0),
      Xo2(start=0),
      Xso2(start=0)),
    Ev(
      Xco2(start=0),
      Xh2o(start=0),
      Xo2(start=0),
      Xso2(start=0)))
    annotation (Placement(transformation(extent={{420,-34},{448,0}})));

  ThermoSysPro.Fluid.BoundaryConditions.Sink  sinkQ5(h0=1231.6e3, region=
        ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions,
    Xco2(start=0),
    Xh2o(start=0),
    Xo2(start=0),
    Xso2(start=0))
    annotation (Placement(transformation(extent={{488,-146},{514,-116}})));
  ThermoSysPro.Fluid.PressureLosses.PipePressureLoss pipePressureLoss9(K=1e-5,
      region=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions)
    annotation (Placement(transformation(
        extent={{-9,8},{9,-8}},
        rotation=270,
        origin={327,-54})));
  ThermoSysPro.Fluid.Volumes.VolumeA volumeA1(ftype=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType.WaterSteam)
    annotation (Placement(transformation(extent={{440,-94},{460,-74}})));
  ThermoSysPro.Fluid.BoundaryConditions.SinkQ sinkQ6(
    Q0=8.23,
    h0=1231.6e3,
    region=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions,
    Xco2(start=0),
    Xh2o(start=0),
    Xo2(start=0),
    Xso2(start=0))
    annotation (Placement(transformation(extent={{422,-142},{396,-116}})));
  ThermoSysPro.Fluid.PressureLosses.PipePressureLoss pipePressureLoss10(K=1e-5,
      region=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions)
    annotation (Placement(transformation(
        extent={{-9,8},{9,-8}},
        rotation=270,
        origin={437,-116})));
  ThermoSysPro.Fluid.PressureLosses.PipePressureLoss pipePressureLoss11(K=1e-5,
      region=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions)
    annotation (Placement(transformation(
        extent={{-9,8},{9,-8}},
        rotation=270,
        origin={471,-112})));
  ThermoSysPro.Fluid.Volumes.VolumeA volumeA2(ftype=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType.WaterSteam)
    annotation (Placement(transformation(extent={{522,-30},{542,-10}})));
  ThermoSysPro.Fluid.PressureLosses.PipePressureLoss pipePressureLoss13(K=1e-5,
      region=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions)
    annotation (Placement(transformation(
        extent={{-9,8},{9,-8}},
        rotation=270,
        origin={533,-52})));
  ThermoSysPro.Fluid.Machines.StodolaTurbine stodolaTurbine3(
    Cst(fixed=false) = 769.062306283798,
    eta_is_nom(fixed=false) = 0.97,
    region_e=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions,
    region_s=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions,
    region_ps=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions,
    Ce(P(fixed=true, start=900000)),
    Cs(h(fixed=false, start=2756.7e3)))
    annotation (Placement(transformation(extent={{598,-30},{618,-10}})));

  ThermoSysPro.Fluid.Junctions.SteamExtractionSplitter
    steamExtractionSplitter3(
    wsftype=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.WaterSteamFluidType.WaterSteam,
    alpha(fixed=true) = 1,
    region_e=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions,
    Cex(h(fixed=false, start=2756.7e3)),
    Cs(h(fixed=true, start=2756.7e3)))
    annotation (Placement(transformation(extent={{642,-30},{662,-10}})));

  ThermoSysPro.Fluid.PressureLosses.PipePressureLoss pipePressureLoss12(K=1e-5,
      region=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions)
    annotation (Placement(transformation(
        extent={{-9,8},{9,-8}},
        rotation=270,
        origin={659,-52})));
  ThermoSysPro.Fluid.BoundaryConditions.SinkQ sinkQ8(
    Q0=99.68,
    h0=2756.7e3,
    region=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions,
    Xco2(start=0),
    Xh2o(start=0),
    Xo2(start=0),
    Xso2(start=0))
    annotation (Placement(transformation(extent={{660,-86},{680,-66}})));
  ThermoSysPro.Fluid.Machines.StodolaTurbine stodolaTurbine4(
    Cst(fixed=false) = 112.152765289806,
    eta_is_nom(fixed=true) = 0.9,
    region_e=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions,
    region_s=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions,
    region_ps=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions,
    Ce(P(fixed=true, start=274000)),
    Cs(h(fixed=false, start=2756.7e3)))
    annotation (Placement(transformation(extent={{690,-30},{710,-10}})));

  ThermoSysPro.Fluid.Junctions.SteamExtractionSplitter
    steamExtractionSplitter4(
    wsftype=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.WaterSteamFluidType.WaterSteam,
    alpha(fixed=false) = 0.994467797324633,
    region_e=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions,
    Cex(h(fixed=true, start=2529.3e3)),
    Cs(h(fixed=false, start=2756.7e3)))
    annotation (Placement(transformation(extent={{728,-30},{748,-10}})));

  ThermoSysPro.Fluid.PressureLosses.PipePressureLoss pipePressureLoss14(K=1e-5,
      region=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions)
    annotation (Placement(transformation(
        extent={{-9,8},{9,-8}},
        rotation=270,
        origin={743,-52})));
  ThermoSysPro.Fluid.BoundaryConditions.SinkQ sinkQ9(
    Q0=77.85,
    h0=2529.3e3,
    region=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions,
    Xco2(start=0),
    Xh2o(start=0),
    Xo2(start=0),
    Xso2(start=0))
    annotation (Placement(transformation(extent={{754,-84},{774,-64}})));
  ThermoSysPro.Fluid.Machines.StodolaTurbine stodolaTurbine5(
    Cst(fixed=false) = 8.5431618926049,
    eta_is_nom(fixed=true) = 0.85,
    region_e=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions,
    region_s=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions,
    region_ps=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions,
    Ce(P(fixed=true, start=64000)),
    Cs(h(fixed=false, start=2756.7e3)))
    annotation (Placement(transformation(extent={{758,-32},{778,-12}})));

  ThermoSysPro.Fluid.Junctions.SteamExtractionSplitter
    steamExtractionSplitter5(
    wsftype=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.WaterSteamFluidType.WaterSteam,
    alpha(fixed=false) = 0.996170004876222,
    region_e=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions,
    Cex(h(fixed=true, start=2368.5e3)),
    Cs(h(fixed=false, start=2756.7e3)))
    annotation (Placement(transformation(extent={{796,-30},{816,-10}})));

  ThermoSysPro.Fluid.PressureLosses.PipePressureLoss pipePressureLoss15(K=1e-5,
      region=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions)
    annotation (Placement(transformation(
        extent={{-9,8},{9,-8}},
        rotation=270,
        origin={813,-50})));
  ThermoSysPro.Fluid.Machines.StodolaTurbine stodolaTurbine6(
    Cst(fixed=false) = 0.470101954300286,
    eta_is_nom(fixed=false) = 0.85,
    region_e=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions,
    region_s=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions,
    region_ps=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions,
    Ce(P(fixed=true, start=15000)),
    Cs(h(fixed=true, start=2310.10e3)))
    annotation (Placement(transformation(extent={{840,-30},{860,-10}})));

  ThermoSysPro.Fluid.PressureLosses.ControlValve controlValve1(
    Cvmax(fixed=false) = 8005.42,
    region=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions,
    Q(fixed=true, start=33.25))
    annotation (Placement(transformation(extent={{586,-174},{610,-150}})));

  ThermoSysPro.Fluid.Machines.StodolaTurbine stodolaTurbine7(
    Cst(fixed=false) = 1349365.05229003,
    eta_is_nom(fixed=true) = 0.9,
    region_e=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions,
    region_s=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions,
    region_ps=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions,
    Ce(P(fixed=true, start=899700)),
    Cs(h(fixed=false, start=2756.7e3)))
    annotation (Placement(transformation(extent={{640,-180},{660,-160}})));

  ThermoSysPro.Fluid.BoundaryConditions.SinkP sinkP1(
    P0(fixed=true) = 100000,
    h0=136.28e3,
    option_temperature=false,
    region=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions,
    Xco2(start=0),
    Xh2o(start=0),
    Xo2(start=0),
    Xso2(start=0))
    annotation (Placement(transformation(extent={{1054,-188},{1098,-132}})));
  ThermoSysPro.Fluid.PressureLosses.PipePressureLoss pipePressureLoss16(K=1e-5,
      region=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions)
    annotation (Placement(transformation(extent={{1006,-168},{1024,-152}})));
  ThermoSysPro.Fluid.PressureLosses.PipePressureLoss pipePressureLoss17(K=1e-5,
      region=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions)
    annotation (Placement(transformation(extent={{834,-152},{852,-136}})));
  ThermoSysPro.Fluid.BoundaryConditions.SourceQ  sourceQ(
    ftype=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType.WaterSteam,
    Q0=61500,
    h0=96.07e3,
    region=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions)
    annotation (Placement(transformation(extent={{748,-168},{804,-114}})));

  ThermoSysPro.Fluid.PressureLosses.PipePressureLoss pipePressureLoss19(K=1e-5,
      region=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions)
    annotation (Placement(transformation(extent={{904,-226},{922,-210}})));

  ThermoSysPro.Fluid.Volumes.VolumeC volumeC(ftype=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType.WaterSteam)
    annotation (Placement(transformation(extent={{794,-212},{826,-180}})));
  ThermoSysPro.Fluid.PressureLosses.PipePressureLoss pipePressureLoss18(K=1e-5,
      region=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions)
    annotation (Placement(transformation(extent={{842,-204},{860,-188}})));

  ThermoSysPro.Fluid.PressureLosses.PipePressureLoss pipePressureLoss20(
    K(fixed=true) = 1e-5,
      region=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions,
    C1(P(fixed=false, start=7000)))
    annotation (Placement(transformation(extent={{764,-244},{782,-228}})));
  ThermoSysPro.Fluid.PressureLosses.PipePressureLoss pipePressureLoss21(K=1e-5,
      region=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions)
    annotation (Placement(transformation(extent={{760,-288},{778,-272}})));
  ThermoSysPro.Fluid.HeatExchangers.SimpleDynamicCondenser
    simpleDynamicCondenser(
    wsftype=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.WaterSteamFluidType.WaterSteam,
    V=500,
    A=1.0017196042689887,
    Ccond=0.005457306704762332,
    Kvl=1.1534290274614438,
    L=14.412,
    D=0.018,
    e=0.0005,
    ntubes=82680,
    dynamic_energy_balance=true,
    steady_state=true,
    Vf0=0.562496,
    P0=7000,
    Cv(
      Xco2(start=0),
      Xh2o(start=0),
      Xo2(start=0),
      Xso2(start=0)),
    Cl(
      Xco2(start=0),
      Xh2o(start=0),
      Xo2(start=0),
      Xso2(start=0)),
    Cee(
      Xco2(start=0),
      Xh2o(start=0),
      Xo2(start=0),
      Xso2(start=0)),
    Cse(
      Xco2(start=0),
      Xh2o(start=0),
      Xo2(start=0),
      Xso2(start=0)))
    annotation (Placement(transformation(extent={{908,-150},{994,-68}})));

  ThermoSysPro.Fluid.PressureLosses.ControlValve controlValve2(
    Cvmax(fixed=false) = 1747.96,
    mode_caract=0,
    region=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions,
    Q(fixed=true, start=1182.4),
    Pm(fixed=false, start=2198500),
    C2(P(fixed=false, start=1368000), Q(start=1182.4, fixed=false)))
    annotation (Placement(transformation(extent={{698,-498},{674,-476}})));

  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante constante
    annotation (Placement(transformation(extent={{642,-452},{662,-432}})));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante constante1
    annotation (Placement(transformation(extent={{-106,-74},{-86,-54}})));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante constante2
    annotation (Placement(transformation(extent={{560,-122},{580,-102}})));

  ThermoSysPro.Fluid.BoundaryConditions.SourceQ  sourceQ1(
    ftype=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType.WaterSteam,
    Q0=32.67,
    h0=227.08e3,
    region=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions)
    annotation (Placement(transformation(extent={{574,-302},{650,-224}})));

  ThermoSysPro.Fluid.BoundaryConditions.SinkP sinkP2(
    Xh2o(start=0),
    C(h_vol_1(start=223749.163427251)),
    P0=1303000,
    h0=225.58e3,
    option_temperature=false,
    region=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions,
    Xco2(start=0),
    Xo2(start=0),
    Xso2(start=0))
    annotation (Placement(transformation(extent={{528,-620},{568,-584}})));

  ThermoSysPro.Fluid.PressureLosses.SingularPressureLoss
                                                     singularPressureLoss2(
    C1(h_vol_2(start=166410.0)),
    Pm(start=1367999.99294436),
    K=1e-5)
    annotation (Placement(transformation(extent={{322,-618},{340,-602}})));
  ThermoSysPro.Fluid.PressureLosses.SingularPressureLoss
                                                     singularPressureLoss1(Pm(start=
          1303000.00709775), K=1e-5)
    annotation (Placement(transformation(extent={{434,-616},{452,-600}})));
  ThermoSysPro.Fluid.PressureLosses.SingularPressureLoss
                                                     singularPressureLoss3(
    C1(P(start=19835.3917598873), h_vol_1(start=225930.04042412)),
    Pm(start=19835.391754799),
    K=1e-5)
    annotation (Placement(transformation(
        extent={{-9,8},{9,-8}},
        rotation=270,
        origin={397,-656})));
  ThermoSysPro.Fluid.PressureLosses.SingularPressureLoss
                                                     singularPressureLoss(
    C1(h_vol_2(start=229299.995912136)),
    Pm(start=14999.9545885609),
    K=1e-5)
    annotation (Placement(transformation(
        extent={{-9,8},{9,-8}},
        rotation=270,
        origin={395,-536})));

  ThermoSysPro.Fluid.BoundaryConditions.SinkP sinkP(
    P0=15000,
    h0=227.08e3,
    option_temperature=false,
    region=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions,
    Xco2(start=0),
    Xh2o(start=0),
    Xo2(start=0),
    Xso2(start=0))
    annotation (Placement(transformation(extent={{492,-702},{512,-682}})));

  ThermoSysPro.Fluid.PressureLosses.ControlValve controlValve3(
    Cvmax(fixed=true) = 626.84,
    mode_caract=0,
    region=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.All_regions,
    Q(fixed=false, start=32.67),
    C2(P(fixed=false, start=1368000), Q(start=32.67, fixed=false)))
    annotation (Placement(transformation(extent={{442,-692},{462,-672}})));

  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante constante3
    annotation (Placement(transformation(extent={{418,-666},{438,-646}})));
  ThermoSysPro.Fluid.HeatExchangers.DynamicWaterHeaterOnePipe dynamicWaterHeaterOnePipe(
    DpfCorr(fixed=false) = 1,
    dynamic_energy_balance=true,
    dynamic_mass_balance=false,
    Wall_3(Tp(start={325.162637147581,325.404913060733,325.620880040272,
            325.812389543964,325.981214499324,326.12977062757,326.26008756377,
            326.374105786402,326.473642500539,326.560373135103,
            326.635823880922,326.701371806578,326.758249975297,
            326.807555678473,326.850260432635,326.887220788214,
            326.919189297718,326.946825211033,326.970704625127,
            326.991329929456})),
    WaterHeating(
      Tp(start=327.10272937949),
      Tp3(start={327.10644047305,327.10864880206,327.11053271381,
            327.1121230144,327.11315815907,327.1140690261,327.11486806012,
            327.11556715912,327.11617746521,327.11670925125,327.11717187503,
            327.11757377998,327.11792252661,327.11822484291,327.11848668571,
            327.11871330692,327.11890932079,327.11907876948,327.11922518533,
            327.11935164871}),
      zl(fixed=false, start=0.5)),
    pipe_3(
      P(start={1368000.0,1364909.69931965,1361818.7817508,1358727.18782833,
            1355634.91224763,1352541.97559644,1349448.41429897,
            1346354.27366473,1343259.60310382,1340164.45291173,
            1337068.87217426,1333972.90746525,1330876.60209952,
            1327779.99576845,1324683.12443426,1321586.0203942,
            1318488.71245131,1315391.22614777,1312293.58403002,
            1309195.80592491,1306097.90921314,1303000.0}),
      Q(start={1183.73570626648,1182.459228515625,1182.459228515625,
            1182.459228515625,1182.459228515625,1182.459228515625,
            1182.459228515625,1182.459228515625,1182.459228515625,
            1182.459228515625,1182.459228515625,1182.459228515625,
            1182.459228515625,1182.459228515625,1182.459228515625,
            1182.459228515625,1182.459228515625,1182.459228515625,
            1182.459228515625,1182.459228515625,1182.459228515625}),
      Tp(start={322.989649905037,323.500298544404,323.955590032271,
            324.359411141801,324.715809146997,325.02941863473,
            325.304524267107,325.545222492174,325.755349521599,
            325.938442270429,326.097722604567,326.23609758532,
            326.356170271421,326.460257100404,326.550408992721,
            326.628434169576,326.695921307318,326.754262115738,
            326.804672764627,326.848213823493}),
      h(start={166410.0,174334.689625003,181280.647982084,187353.811317166,
            192652.69326343,197267.513116335,201280.398167285,
            204765.251826267,207788.114875576,210407.664961502,
            212675.791057346,214638.198161465,216335.011525938,
            217801.360152082,219067.926924546,220161.458238678,
            221105.229831834,221919.468172713,222621.728514405,
            223227.231821817,223749.163427251,225575.125})),
    wsftype=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.WaterSteamFluidType.WaterSteam,
    L3=15,
    ntubes3=4146,
    lambda=80,
    COP0v(fixed=true) = 200,
    steady_state=true,
    Vf0=0,
    P0c=6400000,
    diffusion=false,
    C2ex(h(fixed=false, start=227.08e3)),
    Ce1(P(fixed=true, start=1368000)),
    Ce2(h(fixed=false, start=225.58e3)))      annotation (Placement(
        transformation(
        extent={{-25,-22},{25,22}},
        rotation=0,
        origin={393,-598})));

  ThermoSysPro.Fluid.Machines.CentrifugalPump centrifugalPump1(
    N=10000,
    dynamic_mech_equation=true,
    dynamic_energy_balance=true,
    mode_car=1,
    mode_car_hn=1,
    mode_car_Cr=1,
    hn_nom_p(fixed=true) = 3.4976573,
    rh_nom_p(fixed=true) = 1.1041888,
    C2(
      P(fixed=false, start=2198500),
      Q(fixed=false, start=1182.84),
      h(fixed=false, start=166.41e3),
      Xco2(start=0),
      Xh2o(start=0),
      Xo2(start=0),
      Xso2(start=0)))
    annotation (Placement(transformation(extent={{864,-500},{806,-444}})));
equation
  connect(sourceSGV.C, pipePressureLoss.C1)
    annotation (Line(points={{-200,0},{-180,0}}, color={0,0,0}));
  connect(pipePressureLoss.C2, volumeA.Ce1)
    annotation (Line(points={{-160,0},{-120,0}}, color={0,0,0}));
  connect(volumeA.Cs1, pipePressureLoss1.C1)
    annotation (Line(points={{-100,0},{-100,40},{-28,40}}, color={0,0,0}));
  connect(volumeA.Cs2, controlValve.C1) annotation (Line(points={{-110,-10},{
          -110,-20.8},{-24,-20.8}}, color={0,0,0}));
  connect(controlValve.C2, stodolaTurbine.Ce) annotation (Line(points={{-8,
          -20.8},{11.95,-20.8},{11.95,-20},{31.9,-20}}, color={0,0,0}));
  connect(pipePressureLoss2.C2, sinkQ1.C) annotation (Line(points={{101,-69},
          {101,-74.5},{102,-74.5},{102,-80}}, color={0,0,0}));
  connect(stodolaTurbine.Cs, steamExtractionSplitter.Ce)
    annotation (Line(points={{52.1,-20},{81.7,-20}}, color={0,0,0}));
  connect(steamExtractionSplitter.Cex, pipePressureLoss2.C1) annotation (Line(
        points={{96,-30},{96,-44},{101,-44},{101,-51}}, color={0,0,0}));
  connect(steamExtractionSplitter.Cs, stodolaTurbine1.Ce)
    annotation (Line(points={{102.3,-20},{127.9,-20}}, color={0,0,0}));
  connect(stodolaTurbine1.Cs, steamExtractionSplitter1.Ce)
    annotation (Line(points={{148.1,-20},{165.7,-20}}, color={0,0,0}));
  connect(steamExtractionSplitter1.Cex, pipePressureLoss4.C1)
    annotation (Line(points={{180,-30},{180,-45},{183,-45}}, color={0,0,0}));
  connect(pipePressureLoss4.C2, sinkQ2.C)
    annotation (Line(points={{183,-63},{183,-80},{190,-80}}, color={0,0,0}));
  connect(steamExtractionSplitter1.Cs, stodolaTurbine2.Ce)
    annotation (Line(points={{186.3,-20},{205.9,-20}}, color={0,0,0}));
  connect(stodolaTurbine2.Cs, steamExtractionSplitter2.Ce) annotation (Line(
        points={{226.1,-20},{226.1,-22},{241.7,-22}}, color={0,0,0}));
  connect(steamExtractionSplitter2.Cs, pipePressureLoss3.C1)
    annotation (Line(points={{262.3,-22},{276,-22}}, color={0,0,0}));
  connect(steamExtractionSplitter2.Cex, pipePressureLoss5.C1)
    annotation (Line(points={{256,-32},{256,-41},{257,-41}}, color={0,0,0}));
  connect(pipePressureLoss5.C2, sinkQ3.C)
    annotation (Line(points={{257,-59},{257,-80},{274,-80}}, color={0,0,0}));
  connect(steamDryer.Csv, pipePressureLoss6.C1) annotation (Line(points={{
          339.9,-18},{339.9,-20},{364,-20}}, color={0,0,0}));
  connect(pipePressureLoss3.C2, steamDryer.Cev) annotation (Line(points={{294,
          -22},{312,-22},{312,-18},{320.1,-18}}, color={0,0,0}));
  connect(pipePressureLoss6.C2, nTUWaterHeater.Ee) annotation (Line(points={{382,-20},
          {384,-20},{384,-17},{420,-17}},          color={0,0,0}));
  connect(pipePressureLoss1.C2, nTUWaterHeater.Ev) annotation (Line(points={{-8,40},
          {218,40},{218,52},{442.4,52},{442.4,-11.22}},        color={0,0,0}));
  connect(nTUWaterHeater.Sp, pipePressureLoss8.C1) annotation (Line(points={{425.6,
          -22.61},{412,-22.61},{412,-62},{464,-62},{464,-39},{451,-39}},
        color={0,0,0}));
  connect(nTUWaterHeater.Se, pipePressureLoss7.C1) annotation (Line(points={{448,-17},
          {448,-20},{490,-20}},                    color={0,0,0}));
  connect(steamDryer.Csl, pipePressureLoss9.C1) annotation (Line(points={{
          330.1,-32},{330.1,-38},{327,-38},{327,-45}}, color={0,0,0}));
  connect(pipePressureLoss9.C2, sinkQ4.C) annotation (Line(points={{327,-63},
          {332,-63},{332,-69},{338,-69}}, color={0,0,0}));
  connect(pipePressureLoss8.C2, volumeA1.Ce2)
    annotation (Line(points={{451,-57},{450,-57},{450,-74}}, color={0,0,0}));
  connect(volumeA1.Cs1, pipePressureLoss11.C1) annotation (Line(points={{460,
          -84},{471,-84},{471,-103}}, color={0,0,0}));
  connect(pipePressureLoss11.C2, sinkQ5.C) annotation (Line(points={{471,-121},
          {471,-131},{488,-131}}, color={0,0,0}));
  connect(volumeA1.Cs2, pipePressureLoss10.C1) annotation (Line(points={{450,
          -94},{442,-94},{442,-96},{437,-96},{437,-107}}, color={0,0,0}));
  connect(pipePressureLoss10.C2, sinkQ6.C) annotation (Line(points={{437,-125},
          {437,-129},{422,-129}}, color={0,0,0}));
  connect(pipePressureLoss7.C2, volumeA2.Ce1)
    annotation (Line(points={{508,-20},{522,-20}}, color={0,0,0}));
  connect(volumeA2.Cs2, pipePressureLoss13.C1) annotation (Line(points={{532,
          -30},{532,-38},{533,-38},{533,-43}}, color={0,0,0}));
  connect(stodolaTurbine3.Cs, steamExtractionSplitter3.Ce)
    annotation (Line(points={{618.1,-20},{641.7,-20}}, color={0,0,0}));
  connect(steamExtractionSplitter3.Cex, pipePressureLoss12.C1)
    annotation (Line(points={{656,-30},{656,-43},{659,-43}}, color={0,0,0}));
  connect(pipePressureLoss12.C2, sinkQ8.C) annotation (Line(points={{659,-61},
          {659,-68.5},{660,-68.5},{660,-76}}, color={0,0,0}));
  connect(volumeA2.Cs1, stodolaTurbine3.Ce)
    annotation (Line(points={{542,-20},{597.9,-20}}, color={0,0,0}));
  connect(steamExtractionSplitter3.Cs, stodolaTurbine4.Ce)
    annotation (Line(points={{662.3,-20},{689.9,-20}}, color={0,0,0}));
  connect(stodolaTurbine4.Cs, steamExtractionSplitter4.Ce)
    annotation (Line(points={{710.1,-20},{727.7,-20}}, color={0,0,0}));
  connect(steamExtractionSplitter4.Cex, pipePressureLoss14.C1) annotation (
      Line(points={{742,-30},{742,-36.5},{743,-36.5},{743,-43}}, color={0,0,0}));
  connect(pipePressureLoss14.C2, sinkQ9.C)
    annotation (Line(points={{743,-61},{743,-74},{754,-74}}, color={0,0,0}));
  connect(steamExtractionSplitter4.Cs, stodolaTurbine5.Ce) annotation (Line(
        points={{748.3,-20},{753.1,-20},{753.1,-22},{757.9,-22}}, color={0,0,
          0}));
  connect(stodolaTurbine5.Cs, steamExtractionSplitter5.Ce) annotation (Line(
        points={{778.1,-22},{786.9,-22},{786.9,-20},{795.7,-20}}, color={0,0,
          0}));
  connect(steamExtractionSplitter5.Cex, pipePressureLoss15.C1) annotation (
      Line(points={{810,-30},{810,-35.5},{813,-35.5},{813,-41}}, color={0,0,0}));
  connect(steamExtractionSplitter5.Cs, stodolaTurbine6.Ce)
    annotation (Line(points={{816.3,-20},{839.9,-20}}, color={0,0,0}));
  connect(pipePressureLoss13.C2, controlValve1.C1) annotation (Line(points={{
          533,-61},{533,-169.2},{586,-169.2}}, color={0,0,0}));
  connect(controlValve1.C2, stodolaTurbine7.Ce) annotation (Line(points={{610,
          -169.2},{624.95,-169.2},{624.95,-170},{639.9,-170}}, color={0,0,0}));
  connect(pipePressureLoss16.C2, sinkP1.C)
    annotation (Line(points={{1024,-160},{1054,-160}}, color={0,0,0}));
  connect(sourceQ.C, pipePressureLoss17.C1) annotation (Line(points={{804,
          -141},{819,-141},{819,-144},{834,-144}}, color={0,0,0}));
  connect(volumeC.Cs, pipePressureLoss18.C1)
    annotation (Line(points={{826,-196},{842,-196}}, color={0,0,0}));
  connect(stodolaTurbine6.Cs, volumeC.Ce2) annotation (Line(points={{860.1,
          -20},{878,-20},{878,-178},{810,-178},{810,-180}}, color={0,0,0}));
  connect(pipePressureLoss20.C2, volumeC.Ce1) annotation (Line(points={{782,
          -236},{784,-236},{784,-196},{794,-196}}, color={0,0,0}));
  connect(pipePressureLoss21.C2, volumeC.Ce3) annotation (Line(points={{778,
          -280},{810,-280},{810,-212}}, color={0,0,0}));
  connect(pipePressureLoss18.C2, simpleDynamicCondenser.Cv) annotation (Line(
        points={{860,-196},{882,-196},{882,-184},{898,-184},{898,-40},{951,-40},
          {951,-68}},      color={0,0,0}));
  connect(pipePressureLoss17.C2, simpleDynamicCondenser.Cee) annotation (Line(
        points={{852,-144},{888,-144},{888,-118.02},{908,-118.02}}, color={0,
          0,0}));
  connect(simpleDynamicCondenser.Cse, pipePressureLoss16.C1) annotation (Line(
        points={{994,-117.2},{1008,-117.2},{1008,-116},{1006,-116},{1006,-160}},
        color={0,0,0}));
  connect(pipePressureLoss19.C1, simpleDynamicCondenser.Cl) annotation (Line(
        points={{904,-218},{912,-218},{912,-174},{951.86,-174},{951.86,-150}},
        color={0,0,0}));
  connect(constante.y, controlValve2.Ouv) annotation (Line(points={{663,-442},
          {686,-442},{686,-474.9}}, color={0,0,255}));
  connect(constante1.y, controlValve.Ouv) annotation (Line(points={{-85,-64},
          {-66,-64},{-66,-70},{-54,-70},{-54,12},{-16,12},{-16,-7.2}}, color=
          {0,0,255}));
  connect(constante2.y, controlValve1.Ouv) annotation (Line(points={{581,-112},
          {598,-112},{598,-148.8}}, color={0,0,255}));
  connect(stodolaTurbine7.Cs, pipePressureLoss21.C1) annotation (Line(points=
          {{660.1,-170},{676,-170},{676,-280},{760,-280}}, color={0,0,0}));
  connect(sourceQ1.C, pipePressureLoss20.C1) annotation (Line(points={{650,
          -263},{764,-263},{764,-236}}, color={0,0,0}));
  connect(singularPressureLoss3.C2, controlValve3.C1) annotation (Line(points=
         {{397,-665},{397,-688},{442,-688}}, color={0,0,0}));
  connect(controlValve3.C2, sinkP.C) annotation (Line(points={{462,-688},{484,
          -688},{484,-692},{492,-692}}, color={0,0,0}));
  connect(constante3.y, controlValve3.Ouv) annotation (Line(points={{439,-656},
          {452,-656},{452,-671}}, color={0,0,255}));
  connect(dynamicWaterHeaterOnePipe.C2ex,singularPressureLoss3. C1)
    annotation (Line(points={{393,-620},{390,-620},{390,-640},{397,-640},{397,
          -647}},
        color={0,0,0}));
  connect(singularPressureLoss2.C2,dynamicWaterHeaterOnePipe. Ce1)
    annotation (Line(points={{340,-610},{358,-610},{358,-607.9},{368,-607.9}},
                                                                 color={0,0,0}));
  connect(dynamicWaterHeaterOnePipe.Ce2,singularPressureLoss1. C1)
    annotation (Line(points={{368,-588.32},{342,-588.32},{342,-560},{434,-560},
          {434,-608}},
        color={0,0,0}));
  connect(singularPressureLoss.C2,dynamicWaterHeaterOnePipe. C1vap)
    annotation (Line(points={{395,-545},{394,-545},{394,-570},{393,-570},{393,
          -576}},
        color={0,0,0}));
  connect(singularPressureLoss1.C2,sinkP2. C) annotation (Line(points={{452,
          -608},{516,-608},{516,-602},{528,-602}},
                                      color={0,0,0}));
  connect(pipePressureLoss15.C2, singularPressureLoss.C1) annotation (Line(
        points={{813,-59},{813,-234},{395,-234},{395,-527}}, color={0,0,0}));
  connect(controlValve2.C2, singularPressureLoss2.C1) annotation (Line(points=
         {{674,-493.6},{460,-493.6},{460,-488},{262,-488},{262,-610},{322,
          -610}}, color={0,0,0}));
  connect(pipePressureLoss19.C2, centrifugalPump1.C1) annotation (Line(points=
         {{922,-218},{928,-218},{928,-442},{864,-442},{864,-472}}, color={0,0,
          0}));
  connect(controlValve2.C1, centrifugalPump1.C2) annotation (Line(points={{
          698,-493.6},{788,-493.6},{788,-472},{806,-472}}, color={0,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-220,
            -720},{1120,100}})),                                 Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-220,-720},{1120,
            100}})),
    experiment(StopTime=2000, __Dymola_Algorithm="Dassl"),
    __Dymola_Commands(file=
          "Resulats_PP4_THP_GSS_TBP_CEX_RE1_RE2_CteVV_avec PEdyn_BonneCausalite.mos"
        "Resulats_PP4_THP_GSS_TBP_CEX_RE1_RE2_CteVV_avec PEdyn_BonneCausalite", file=
          "SCRIPTS/PP4_PosteEau_RE1_1_results.mos"
        "PP4_PosteEau_RE1_1_results"),
    uses(ThermoSysPro(version="4.0")));
end PP4_PosteEau_RE1_2_testXh2O;
