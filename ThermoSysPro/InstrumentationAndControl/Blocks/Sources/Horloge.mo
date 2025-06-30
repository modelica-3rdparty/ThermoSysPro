within ThermoSysPro.InstrumentationAndControl.Blocks.Sources;
block Horloge
  parameter Real offset=0 "Output offset";
  parameter Real startTime=0 "Clock start time";
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal y
                                       annotation (Placement(transformation(
          extent={{100,-10},{120,10}}, rotation=0)));
equation

  y.signal = offset + (if (time < startTime) then 0 else time - startTime);

  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Rectangle(
          extent={{-100,-100},{100,100}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(extent={{-150,150},{150,110}}, textString=
                                                "%name"),
        Rectangle(
          extent={{-100,-100},{100,100}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(extent={{-80,80},{80,-80}}, lineColor={160,160,164}),
        Line(points={{0,80},{0,60}}, color={160,160,164}),
        Line(points={{80,0},{60,0}}, color={160,160,164}),
        Line(points={{0,-80},{0,-60}}, color={160,160,164}),
        Line(points={{-80,0},{-60,0}}, color={160,160,164}),
        Line(points={{37,70},{26,50}}, color={160,160,164}),
        Line(points={{70,38},{49,26}}, color={160,160,164}),
        Line(points={{71,-37},{52,-27}}, color={160,160,164}),
        Line(points={{39,-70},{29,-51}}, color={160,160,164}),
        Line(points={{-39,-70},{-29,-52}}, color={160,160,164}),
        Line(points={{-71,-37},{-50,-26}}, color={160,160,164}),
        Line(points={{-71,37},{-54,28}}, color={160,160,164}),
        Line(points={{-37,70},{-26,50}}, color={160,160,164}),
        Line(points={{-70,38},{-49,26}}, color={160,160,164}),
        Line(points={{-70,-38},{-49,-26}}, color={160,160,164}),
        Line(points={{-37,-70},{-26,-50}}, color={160,160,164}),
        Line(points={{0,0},{0,0}}, color={160,160,164})}),
    Window(
      x=0.18,
      y=0.17,
      width=0.6,
      height=0.6),
    Documentation(info="<html>\n<p><b>Adapted from the Modelica.Blocks.Sources library</b></p>\n</HTML>\n<html>\n<p><b>Version 1.0</b></p>\n</HTML>\n"));
end Horloge;
