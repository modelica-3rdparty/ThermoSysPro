within ThermoSysPro.Fluid.Examples.SimpleExamples.HeatExchangers;
model TestFixedPowerHeatExchanger
  extends ThermoSysPro.UsersGuide.Icons.Example;

  replaceable package Medium = Properties.Media.WaterSteam;

  ThermoSysPro.Fluid.HeatExchangers.FixedPowerHeatExchanger fixedPowerHeatExchanger(
    redeclare package Medium_c = Medium,
    redeclare package Medium_f = Medium,
    DW=1e5,
    DPc=1,
    DPf=1) annotation (Placement(transformation(extent={{-20,44},{0,64}}, rotation=0)));
  ThermoSysPro.Fluid.BoundaryConditions.SourceP sourcePc(
    redeclare package Medium = Medium,
    T0=340) annotation (Placement(transformation(extent={{-80,44},{-60,64}}, rotation=0)));
  ThermoSysPro.Fluid.BoundaryConditions.SourceP sourcePf(
    redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-60,24},{-40,44}}, rotation=0)));
  ThermoSysPro.Fluid.BoundaryConditions.SinkP sinkPc(
    redeclare package Medium = Medium) annotation (Placement(transformation(extent={{40,44},{60,64}}, rotation=0)));
  ThermoSysPro.Fluid.BoundaryConditions.SinkP sinkPf(
    redeclare package Medium = Medium) annotation (Placement(transformation(extent={{20,24},{40,44}}, rotation=0)));
  ThermoSysPro.Fluid.Volumes.VolumeD volumePc(
    redeclare package Medium = Medium,
    V=1,
    steady_state=false,
    h0=2.8e5) annotation (Placement(transformation(extent={{10,44},{30,64}}, rotation=0)));
  ThermoSysPro.Fluid.Volumes.VolumeD volumePf(
    redeclare package Medium = Medium,
    V=1,
    steady_state=false,
    h0=7e4) annotation (Placement(transformation(extent={{-10,24},{10,44}}, rotation=0)));
equation
  connect(sourcePc.C, fixedPowerHeatExchanger.Ec) annotation (Line(points={{-60,54},{-20,54},{-20,48}}, color={0,0,255}));
  connect(sourcePf.C, fixedPowerHeatExchanger.Ef) annotation (Line(points={{-40,34},{-20,34},{-20,57}}, color={0,0,255}));
  connect(fixedPowerHeatExchanger.Sc, volumePc.Ce) annotation (Line(points={{0,48},{8,48},{8,54},{10,54}}, color={0,0,255}));
  connect(volumePc.Cs3, sinkPc.C) annotation (Line(points={{30,54},{40,54}}, color={0,0,255}));
  connect(fixedPowerHeatExchanger.Sf, volumePf.Ce) annotation (Line(points={{0,57},{6,57},{6,34},{-10,34}}, color={0,0,255}));
  connect(volumePf.Cs3, sinkPf.C) annotation (Line(points={{10,34},{20,34}}, color={0,0,255}));
  annotation (experiment(StopTime=1000), Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end TestFixedPowerHeatExchanger;
