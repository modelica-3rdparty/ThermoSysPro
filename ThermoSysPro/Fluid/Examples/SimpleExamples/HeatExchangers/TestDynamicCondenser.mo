within ThermoSysPro.Fluid.Examples.SimpleExamples.HeatExchangers;
model TestDynamicCondenser
  extends ThermoSysPro.UsersGuide.Icons.Example;

  replaceable package Medium = Properties.Media.WaterSteam;
  replaceable package Medium_Cooling = Properties.Media.WaterSteam;

  ThermoSysPro.Fluid.HeatExchangers.DynamicCondenser condenser(
    redeclare package Medium = Medium,
    redeclare package Medium_Cooling = Medium_Cooling,
    Ns=3,
    ntubest=1000,
    ntubesV=50,
    dynamic_energy_balance=false,
    dynamic_mass_balance=false,
    inertia=false) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  ThermoSysPro.Fluid.BoundaryConditions.SourceQ vaporSource(redeclare package Medium = Medium, Q0=10, h0=2.7e6, option_temperature=false) annotation (Placement(transformation(extent={{-10,50},{10,70}})));
  ThermoSysPro.Fluid.BoundaryConditions.SourceQ extraVaporSource(redeclare package Medium = Medium, Q0=1e-4, h0=2.7e6, option_temperature=false) annotation (Placement(transformation(extent={{-70,50},{-50,70}})));
  ThermoSysPro.Fluid.BoundaryConditions.SourceQ extraWaterSource(redeclare package Medium = Medium, Q0=1e-4, h0=1e5, option_temperature=false) annotation (Placement(transformation(extent={{-70,20},{-50,40}})));
  ThermoSysPro.Fluid.BoundaryConditions.SinkQ condensateSink(redeclare package Medium = Medium, Q0=10.0002, h0=1e5, option_temperature=false) annotation (Placement(transformation(extent={{-10,-70},{10,-50}})));
  ThermoSysPro.Fluid.BoundaryConditions.SourceQ coolingSource(redeclare package Medium = Medium_Cooling, Q0=100, h0=1e5, option_temperature=false) annotation (Placement(transformation(extent={{-70,-20},{-50,0}})));
  ThermoSysPro.Fluid.BoundaryConditions.SinkP coolingSink(redeclare package Medium = Medium_Cooling, P0=100000, h0=1e5, option_temperature=false) annotation (Placement(transformation(extent={{50,-20},{70,0}})));
equation
  connect(vaporSource.C, condenser.C1vap) annotation (Line(points={{10,60},{0,60},{0,10}}, color={0,0,255}));
  connect(extraVaporSource.C, condenser.C2vap) annotation (Line(points={{-50,60},{-3.9,60},{-3.9,9.2}}, color={0,0,255}));
  connect(extraWaterSource.C, condenser.C1) annotation (Line(points={{-50,30},{-8.1,30},{-8.1,7.5}}, color={0,0,255}));
  connect(condenser.C2ex, condensateSink.C) annotation (Line(points={{0,-10},{0,-50}}, color={0,0,255}));
  connect(coolingSource.C, condenser.Ce1) annotation (Line(points={{-50,-10},{-10,-10},{-10,-0.1}}, color={0,0,255}));
  connect(condenser.Ce2, coolingSink.C) annotation (Line(points={{9.9,-0.1},{30,-0.1},{30,-10},{50,-10}}, color={0,0,255}));
  annotation (experiment(StopTime=1), Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end TestDynamicCondenser;
