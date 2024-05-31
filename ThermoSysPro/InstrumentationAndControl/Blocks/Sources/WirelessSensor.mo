within ThermoSysPro.InstrumentationAndControl.Blocks.Sources;
block WirelessSensor
  "Mesure data with expression, no connection (as MSL RealExpression)"
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal y
    annotation (Placement(transformation(extent={{92,-90},{112,-70}}),
        iconTransformation(extent={{92,-90},{112,-70}})));
  Real m=0.0 "Measure Expression" annotation (Dialog(group="Measured data"));
equation
  y.signal=m;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Ellipse(
          extent={{-60,60},{60,-60}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Ellipse(
          extent={{-80,80},{80,-80}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Ellipse(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Rectangle(
          extent={{-40,102},{40,-100}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-44,42},{46,-44}},
          lineColor={0,0,0},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Text(
          extent={{-38,42},{40,-32}},
          textColor={0,0,0},
          textString="M")}),                                     Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end WirelessSensor;
