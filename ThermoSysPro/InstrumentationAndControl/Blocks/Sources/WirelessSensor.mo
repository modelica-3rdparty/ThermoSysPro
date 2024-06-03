within ThermoSysPro.InstrumentationAndControl.Blocks.Sources;
block WirelessSensor
  "Mesure data with expression, no connection (as MSL RealExpression)"

  Real m=0.0 "Measure Expression" annotation (Dialog(group="Measured data"));

  parameter Real max_range = 14 "Color Scale Max Value" annotation (Dialog(group="Animation"));
  parameter Real min_range = 0 "Color Scale Min Value" annotation (Dialog(group="Animation"));
  parameter String format = ".2g" "Numeric Value Format" annotation (Dialog(group="Animation"));

  Real measure_col[3](each min=0, each max=255) "pH corrspondig color";
  Real neg_col[3](each min=0, each max=255) "Negative pH color";

  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal y
    annotation (Placement(transformation(extent={{92,-10},{112,10}}),
        iconTransformation(extent={{92,-10},{112,10}})));

equation
  y.signal=m;
  measure_col = Modelica.Mechanics.MultiBody.Visualizers.Colors.scalarToColor(m,min_range,max_range,Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps.jet());
  neg_col = fill(255,3) - measure_col;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Ellipse(
          extent={{20,70},{130,-40}},
          lineColor={0,0,0},
          lineThickness=0.5,
          startAngle=-80,
          endAngle=-10,
          closure=EllipseClosure.None),
        Polygon(
points={{-86,28},{86,28},{92,22},{92,-22},{86,-28},{-86,-28},{-92,-22},{-92,22},
              {-86,28}},
          lineColor={0,0,0},
          fillColor=DynamicSelect({255,255,170},measure_col),
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Text(
          extent={{-92,32},{92,-24}},
          textColor=DynamicSelect({0,0,0},neg_col),
          textString=DynamicSelect("M", String(m,format=format))),
        Text(
          extent={{-140,-92},{140,-134}},
          textColor={95,95,95},
          textString="%m"),
        Ellipse(
          extent={{38,58},{118,-22}},
          lineColor={0,0,0},
          lineThickness=0.5,
          startAngle=-80,
          endAngle=-10,
          closure=EllipseClosure.None),
        Ellipse(
          extent={{56,46},{106,-4}},
          lineColor={0,0,0},
          lineThickness=0.5,
          startAngle=-80,
          endAngle=-10,
          closure=EllipseClosure.None),
        Ellipse(
          extent={{-132,42},{-22,-68}},
          lineColor={0,0,0},
          lineThickness=0.5,
          startAngle=100,
          endAngle=170,
          closure=EllipseClosure.None),
        Ellipse(
          extent={{-120,24},{-40,-56}},
          lineColor={0,0,0},
          lineThickness=0.5,
          startAngle=100,
          endAngle=170,
          closure=EllipseClosure.None),
        Ellipse(
          extent={{-108,6},{-58,-44}},
          lineColor={0,0,0},
          lineThickness=0.5,
          startAngle=100,
          endAngle=170,
          closure=EllipseClosure.None)}),                Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end WirelessSensor;
