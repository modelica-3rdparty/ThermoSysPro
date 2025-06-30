within ThermoSysPro.InstrumentationAndControl.Blocks.Sources;
block Step
  parameter Real height=1 "Step height";
  parameter Real offset=0 "Output offset";
  parameter Real startTime=0 "Step start time";

  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal y
                                       annotation (Placement(transformation(
          extent={{100,-10},{120,10}}, rotation=0)));
equation

  y.signal = offset + (if time < startTime then 0 else height);
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Text(extent={{-150,150},{150,110}}, textString=
                                                "%name"),
        Rectangle(
          extent={{-100,-100},{100,100}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,68},{-80,-80}}, color={192,192,192}),
        Polygon(
          points={{-80,90},{-88,68},{-72,68},{-80,90}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-90,-70},{82,-70}}, color={192,192,192}),
        Polygon(
          points={{90,-70},{68,-62},{68,-78},{90,-70}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,-70},{0,-70},{0,50},{80,50}}, color={0,0,0})}),
    Window(
      x=0.18,
      y=0.17,
      width=0.6,
      height=0.6),
    Documentation(info="<html>\n<p><b>Adapted from the Modelica.Blocks.Sources library</b></p>\n</HTML>\n<html>\n<p><b>Version 1.0</b></p>\n</HTML>\n"));
end Step;
