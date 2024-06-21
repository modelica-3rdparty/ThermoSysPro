within ThermoSysPro.Examples.SimpleExamples;
model TestWirelessSensor
  ThermoSysPro.WaterSteam.PressureLosses.LumpedStraightPipe PerteDP1
    annotation (Placement(transformation(extent={{30,-50},{50,-30}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.ControlValve VanneReglante1(Cvmax=1000)
    annotation (Placement(transformation(extent={{-50,2},{-30,22}},  rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SourceP SourceP1(P0=120000)
                                            annotation (Placement(
        transformation(extent={{-88,-4},{-68,16}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SinkP PuitsP1
                                          annotation (Placement(transformation(
          extent={{70,-50},{90,-30}}, rotation=0)));
  ThermoSysPro.WaterSteam.Volumes.Tank Tank1(z(fixed=false, start=5))
    annotation (Placement(transformation(extent={{-10,-8},{10,12}},
                                                                  rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Rampe Rampe annotation (
     Placement(transformation(extent={{-90,30},{-70,50}}, rotation=0)));
  InstrumentationAndControl.Blocks.Sources.WirelessSensor wirelessSensor_ramp(
    m=PerteDP1.C1.Q,
    min_range=0,
    max_range=1000,
    significantDigits=5)
    annotation (Placement(transformation(extent={{-14,64},{22,94}})));
  InstrumentationAndControl.Blocks.Sources.WirelessSensor wirelessSensor_tank(
    m=Tank1.yLevel.signal,
    ValidityRange=true,
    min_range=Tank1.zs2,
    max_range=40,
    m_nominal=5)
    annotation (Placement(transformation(origin = {2, -2}, extent = {{-16, 32}, {20, 62}})));
equation
  connect(PerteDP1.C2, PuitsP1.C)
    annotation (Line(points={{50,-40},{70,-40}}, color={0,0,255}));
  connect(SourceP1.C, VanneReglante1.C1)
    annotation (Line(points={{-68,6},{-50,6}},   color={0,0,255}));
  connect(Tank1.Cs2, PerteDP1.C1)  annotation (Line(points={{10,-4},{20,-4},{20,
          -40},{30,-40}}, color={0,0,255}));
  connect(Rampe.y, VanneReglante1.Ouv)
    annotation (Line(points={{-69,40},{-40,40},{-40,23}}));
  connect(VanneReglante1.C2, Tank1.Ce1) annotation (Line(points={{-30,6},{-10,6},
          {-10,8}},               color={0,0,255}));
  annotation (experiment(StopTime=400, __Dymola_Algorithm="Dassl"),
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
<p><b>Copyright &copy; EDF 2002 - 2019 </p>
<p><b>ThermoSysPro Version 4.0 </h4>
</html>"));
end TestWirelessSensor;