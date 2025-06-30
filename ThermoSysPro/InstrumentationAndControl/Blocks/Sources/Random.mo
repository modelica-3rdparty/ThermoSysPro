within ThermoSysPro.InstrumentationAndControl.Blocks.Sources;
block Random
  parameter Integer seed=1 "Random generator seed";
  parameter Real sampleOffset=0 "Sampling start time (s)";
  parameter Real sampleInterval=0.01 "Sampling period (s)";
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal y
                                       annotation (Placement(transformation(
          extent={{100,-10},{120,10}}, rotation=0)));
equation

  when initial() then
    Common.srand(seed);
  end when;

  when sample(sampleOffset, sampleInterval) then
    y.signal = Common.fmod(Common.rand()/32768*10, 1);
  end when;
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(points={{-80,68},{-80,-80}}, color={192,192,192}),
        Line(points={{-90,-70},{82,-70}}, color={192,192,192}),
        Polygon(
          points={{-80,90},{-88,68},{-72,68},{-80,90}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{90,-70},{68,-62},{68,-78},{90,-70}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-89,90},{-36,72}},
          lineColor={160,160,164},
          textString="y"),
        Text(
          extent={{70,-80},{94,-100}},
          lineColor={160,160,164},
          textString="time"),
        Line(points={{-60,-20},{-40,20},{-20,-40},{0,-60},{20,0},{40,40},{60,0}},
            color={0,0,0})}),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(points={{50,0},{100,0}}),
        Line(points={{50,0},{100,0}}),
        Rectangle(
          extent={{-100,-100},{100,100}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-80,90},{-88,68},{-72,68},{-80,90}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,68},{-80,-80}}, color={192,192,192}),
        Line(points={{-90,-70},{82,-70}}, color={192,192,192}),
        Text(extent={{-150,150},{150,110}}, textString=
                                                "%name"),
        Line(points={{-60,-20},{-40,20},{-20,-40},{0,-60},{20,0},{40,40},{60,0}},
            color={0,0,0})}),
    Window(
      x=0.32,
      y=0.33,
      width=0.6,
      height=0.6),
    Documentation(info="<html>
<p><b>Version 1.6</b></p>
</HTML>
"));
end Random;
