within ThermoSysPro.InstrumentationAndControl.Blocks.Sources;
block WirelessSensor
  "Mesure data with expression, no connection (as MSL RealExpression)"

  Real m=0.0 "Measure Expression" annotation (Dialog(group="Measured data"));

  parameter Boolean ValidityRange=false "Intensity colorscale by default (jet colormap); ValidityRange: green if close to nominal value"
                                                                                                                                        annotation(Dialog(group="Animation"),choices(checkBox=true));
  parameter Real min_range = 0 "Color Scale Min Value" annotation (Dialog(group="Animation"));
  parameter Real max_range = 14 "Color Scale Max Value" annotation (Dialog(group="Animation"));
  parameter Real m_nominal = 10 "Color Scale nominal Value" annotation (Dialog(enable=ValidityRange,group="Animation",groupImage = ("modelica://ThermoSysPro/InstrumentationAndControl/Blocks/Sources/colorMap_WirelessSensor.png")));
  parameter String format = ".2g" "Numeric Value Format" annotation (Dialog(group="Animation"));


  Real measure_col[3](each min=0, each max=255) "pH corrspondig color";
  Real neg_col[3](each min=0, each max=255) "Negative pH color";

  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal y
    annotation (Placement(transformation(extent={{100,-10},{120,10}}),
        iconTransformation(extent={{100,-10},{120,10}})));

equation
  y.signal=m;
  if ValidityRange then
  measure_col =ThermoSysPro.Functions.Utilities.scalarToColor_validityRange(
    T=m,
    T_nominal=m_nominal,
    T_min=min_range,
    T_max=max_range,
    colorMap=ThermoSysPro.Functions.Utilities.RedGreen_colorMap());
  else
    measure_col = Modelica.Mechanics.MultiBody.Visualizers.Colors.scalarToColor(m,min_range,max_range,Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps.jet());
  end if;

  neg_col = fill(255,3) - measure_col;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Ellipse(
          extent={{30,70},{140,-40}},
          lineColor={0,0,0},
          lineThickness=0.5,
          startAngle=-80,
          endAngle=-10,
          closure=EllipseClosure.None),
        Polygon(
          points={{-94,28},{94,28},{100,24},{100,-24},{94,-28},{-94,-28},{-100,-22},
              {-100,22},{-94,28}},
          lineColor={0,0,0},
          fillColor=DynamicSelect({255,255,170}, measure_col),
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Text(
          extent={{-100,28},{100,-24}},
          textColor=DynamicSelect({0,0,0},neg_col),
          textString=DynamicSelect("M", String(m,format=format))),
        Text(
          extent={{-140,-92},{140,-134}},
          textColor={95,95,95},
          textString="%m"),
        Ellipse(
          extent={{48,58},{128,-22}},
          lineColor={0,0,0},
          lineThickness=0.5,
          startAngle=-80,
          endAngle=-10,
          closure=EllipseClosure.None),
        Ellipse(
          extent={{66,46},{116,-4}},
          lineColor={0,0,0},
          lineThickness=0.5,
          startAngle=-80,
          endAngle=-10,
          closure=EllipseClosure.None),
        Ellipse(
          extent={{-140,42},{-30,-68}},
          lineColor={0,0,0},
          lineThickness=0.5,
          startAngle=100,
          endAngle=170,
          closure=EllipseClosure.None),
        Ellipse(
          extent={{-128,26},{-48,-56}},
          lineColor={0,0,0},
          lineThickness=0.5,
          startAngle=100,
          endAngle=170,
          closure=EllipseClosure.None),
        Ellipse(
          extent={{-116,6},{-66,-44}},
          lineColor={0,0,0},
          lineThickness=0.5,
          startAngle=100,
          endAngle=170,
          closure=EllipseClosure.None)}),                Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    uses(ThermoSysPro(version="4.0"), Modelica(version="4.0.0")));
end WirelessSensor;
