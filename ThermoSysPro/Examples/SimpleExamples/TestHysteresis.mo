within ThermoSysPro.Examples.SimpleExamples;
model TestHysteresis
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Trapezoide trapezoide(
    amplitude=2,
    rising=0.2,
    largeur=0.2,
    falling=0.2,
    n=1,
    offset=-0.5)
    annotation (Placement(transformation(extent={{-64,-10},{-44,10}})));
  ThermoSysPro.InstrumentationAndControl.Blocks.NonLineaire.Hysteresis hysteresis
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
equation
  connect(trapezoide.y, hysteresis.u)
    annotation (Line(points={{-43,0},{19,0}}, color={0,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          lineColor={200,200,200},
          fillColor={248,248,248},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{-100,-100},{100,100}},
          radius=25.0),
        Rectangle(
          lineColor={128,128,128},
          extent={{-100,-100},{100,100}},
          radius=25.0),
        Polygon(
          origin={8,14},
          lineColor={78,138,73},
          fillColor={78,138,73},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          points={{-58.0,46.0},{42.0,-14.0},{-58.0,-74.0},{-58.0,46.0}})}),
                                                                 Diagram(coordinateSystem(
          preserveAspectRatio=false)));
end TestHysteresis;
