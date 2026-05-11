within ThermoSysPro.Fluid.Examples.SimpleExamples.HeatExchangers;
model TestSimpleDynamicCondenser_Traces
  extends ThermoSysPro.UsersGuide.Icons.Example;

  replaceable package Medium = ThermoSysPro.Fluid.Examples.SimpleExamples.Media.WaterSteam_FullyVolatileTrace;

  ThermoSysPro.Fluid.BoundaryConditions.SinkP puitsPCaloporteur(
    redeclare package Medium = Medium,
    P0=1e5,
    option_temperature=false) annotation (Placement(transformation(extent={{48,30},{88,70}}, rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.SingularPressureLoss PerteChargeCondPompe(
    redeclare package Medium = Medium,
    K=1e-6,
    Q(start=0.598447)) annotation (Placement(transformation(origin={-90,-38}, extent={{-10,-10},{10,10}}, rotation=180)));
  ThermoSysPro.Fluid.BoundaryConditions.SourceP SourceRechauffeurEau(
    redeclare package Medium = Medium,
    option_temperature=false,
    h0=2401e3,
    P0=15050,
    SubC0={10}) annotation (Placement(transformation(extent={{-207,148},{-183,170}}, rotation=0)));
  ThermoSysPro.Fluid.BoundaryConditions.SinkQ PuitsRechauffeurEau(
    redeclare package Medium = Medium,
    h0=191812,
    Q0=192) annotation (Placement(transformation(extent={{-184,-52},{-208,-24}}, rotation=0)));
  ThermoSysPro.Fluid.BoundaryConditions.SourceQ sourcePCaloporteur(
    redeclare package Medium = Medium,
    Q0=29804.5,
    h0=113e3,
    SubC0={10}) annotation (Placement(transformation(extent={{-212,30},{-172,68}}, rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.SingularPressureLoss PerteChargeCondPompe1(
    redeclare package Medium = Medium,
    K=1e-6) annotation (Placement(transformation(origin={36,50}, extent={{6,-10},{-6,10}}, rotation=180)));
  ThermoSysPro.Fluid.PressureLosses.SingularPressureLoss PerteChargeCondPompe2(
    redeclare package Medium = Medium,
    K=1e-6) annotation (Placement(transformation(origin={-154,49}, extent={{6,-10},{-6,10}}, rotation=180)));
  ThermoSysPro.Fluid.PressureLosses.SingularPressureLoss PerteChargeCondPompe3(
    redeclare package Medium = Medium,
    K(fixed=false)=1e-3,
    Q(fixed=true,start=192))
                      annotation (Placement(transformation(origin={-120,159}, extent={{10,-10},{-10,10}}, rotation=180)));
  ThermoSysPro.Fluid.HeatExchangers.SimpleDynamicCondenser Condenseur(
    redeclare package Medium = Medium,
    redeclare package Medium_Cooling = Medium,
    redeclare function PhasesSeparationFunction = Medium.PhasesSeparation(x=Condenseur.xv),
    D=0.018,
    V=1000,
    A=100,
    lambda=0.01,
    ntubes=28700,
    continuous_flow_reversal=true,
    yNiveau(signal(fixed=false, start=1.5)),
    Vf0=0.15,
    steady_state=false,
    P(fixed=false, start=10000)) annotation (Placement(transformation(extent={{-118,6},{1,116}}, rotation=0)));
equation
  connect(sourcePCaloporteur.C, PerteChargeCondPompe2.C1) annotation (Line(points={{-172,49},{-160,49}}, color={0,0,255}));
  connect(PerteChargeCondPompe1.C2, puitsPCaloporteur.C) annotation (Line(points={{42,50},{48,50}}, color={0,0,255}));
  connect(SourceRechauffeurEau.C, PerteChargeCondPompe3.C1) annotation (Line(points={{-183,159},{-130,159}}, color={0,0,255}));
  connect(PuitsRechauffeurEau.C, PerteChargeCondPompe.C2) annotation (Line(points={{-184,-38},{-100,-38}}));
  connect(PerteChargeCondPompe2.C2, Condenseur.Cee) annotation (Line(points={{-148,49},{-133,49},{-133,48.9},{-118,48.9}}, color={0,0,255}));
  connect(PerteChargeCondPompe.C1, Condenseur.Cl) annotation (Line(points={{-80,-38},{-57.31,-38},{-57.31,6}}));
  connect(PerteChargeCondPompe3.C2, Condenseur.Cv) annotation (Line(points={{-110,159},{-58.5,159},{-58.5,116}}, color={0,0,255}));
  connect(PerteChargeCondPompe1.C1, Condenseur.Cse) annotation (Line(points={{30,50},{15.5,50},{15.5,50},{1,50}}));
  annotation (
    experiment(StopTime=1000),
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-250,-60},{130,180}})));
end TestSimpleDynamicCondenser_Traces;
