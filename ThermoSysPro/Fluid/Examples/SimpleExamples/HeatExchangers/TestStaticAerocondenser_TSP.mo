within ThermoSysPro.Fluid.Examples.SimpleExamples.HeatExchangers;
model TestStaticAerocondenser_TSP
  extends ThermoSysPro.UsersGuide.Icons.Example;

  replaceable package Medium = ThermoSysPro.Properties.Media.WaterSteam;
  replaceable package Medium_Air = ThermoSysPro.Properties.Media.FlueGases;

  model SourceH
    replaceable package Medium = ThermoSysPro.Properties.Media.WaterSteam constrainedby ThermoSysPro.Properties.Media.PartialSubCMedium;
    parameter Units.SI.MassFlowRate Q0=1;
    parameter Units.SI.SpecificEnthalpy h0=1e5;
    parameter Medium.MassFraction X0[Medium.nXi]=Medium.X_default[1:Medium.nXi];
    parameter Medium.ExtraProperty SubC0[Medium.nC]=Medium.C_default;
    parameter Boolean fix_h_vol_2=false;
    ThermoSysPro.Fluid.Interfaces.Connectors.FluidOutlet C(redeclare package Medium = Medium);
  equation
    C.Q = Q0;
    C.h = h0;
    C.h_vol_1 = h0;
    if fix_h_vol_2 then
      C.h_vol_2 = h0;
    end if;
    C.diff_res_1 = 0;
    C.diff_on_1 = false;
    C.Xi = X0;
    C.SubC = SubC0;
  end SourceH;

  model SinkDiff
    replaceable package Medium = ThermoSysPro.Properties.Media.WaterSteam constrainedby ThermoSysPro.Properties.Media.PartialSubCMedium;
    parameter Boolean fix_h_vol_2=false;
    ThermoSysPro.Fluid.Interfaces.Connectors.FluidInlet C(redeclare package Medium = Medium);
  equation
    if fix_h_vol_2 then
      C.h_vol_2 = C.h;
    end if;
    C.diff_res_2 = 0;
    C.diff_on_2 = false;
  end SinkDiff;

  model SinkPOnly
    replaceable package Medium = ThermoSysPro.Properties.Media.WaterSteam constrainedby ThermoSysPro.Properties.Media.PartialSubCMedium;
    parameter Units.SI.AbsolutePressure P0=1e5;
    ThermoSysPro.Fluid.Interfaces.Connectors.FluidInlet C(redeclare package Medium = Medium);
  equation
    C.P = P0;
    C.diff_res_2 = 0;
    C.diff_on_2 = false;
  end SinkPOnly;

  ThermoSysPro.Fluid.HeatExchangers.StaticAerocondenser staticAerocondenser(
    redeclare package Medium = Medium,
    redeclare package Medium_Air = Medium_Air,
    Se=10000,
    z=0.5,
    use_Cw=true,
    Ka=1) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  SourceH airSource(
    redeclare package Medium = Medium_Air,
    fix_h_vol_2=true,
    Q0=1400,
    h0=Medium_Air.specificEnthalpy_pTX(
        p=100000,
        T=293.15,
        X=Medium_Air.X_default)) annotation (Placement(transformation(extent={{60,-10},{40,10}}, rotation=0)));
  ThermoSysPro.Fluid.BoundaryConditions.SourceQ drainSource(
    redeclare package Medium = Medium,
    Q0=1,
    T0=340,
    h0=370000) annotation (Placement(transformation(extent={{-70,-62},{-50,-42}}, rotation=0)));
  ThermoSysPro.Fluid.BoundaryConditions.SourceQ steamSource1(
    redeclare package Medium = Medium,
    Q0=100,
    T0=340,
    h0=2600000) annotation (Placement(transformation(extent={{-44,68},{-24,88}}, rotation=0)));
  SinkDiff condensateSink(redeclare package Medium = Medium) annotation (Placement(transformation(
        extent={{-10,-70},{10,-50}},
        rotation=-90,
        origin={100,-34})));
  SinkPOnly airSink(redeclare package Medium = Medium_Air, P0=100000) annotation (Placement(transformation(
        extent={{40,50},{60,70}},
        rotation=90,
        origin={92,-10})));
equation
  staticAerocondenser.Cws2.h_vol_2 = staticAerocondenser.Cws2.h;

  connect(airSource.C, staticAerocondenser.Cair1) annotation (Line(points={{40,0},{9.16667,-9.08333}}, color={0,0,0}));
  connect(drainSource.C, staticAerocondenser.Cw) annotation (Line(points={{-50,-52},{-16,-52},{-16,-7.5},{-9.16667,-7.5}}, color={0,0,0}));
  connect(staticAerocondenser.Cws1, steamSource1.C) annotation (Line(points={{0,9.16667},{0,78},{-24,78}}, color={0,0,0}));
  connect(staticAerocondenser.Cws2, condensateSink.C) annotation (Line(points={{0,-9.16667},{0,-36},{24,-36},{24,-76}}, color={0,0,0}));
  connect(staticAerocondenser.Cair2, airSink.C) annotation (Line(points={{9.16667,9.16667},{142,40}}, color={0,0,0}));
  annotation (
    experiment(StopTime=1000),
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)));
end TestStaticAerocondenser_TSP;
