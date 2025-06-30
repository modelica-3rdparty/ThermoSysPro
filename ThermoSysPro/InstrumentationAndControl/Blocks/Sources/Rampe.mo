within ThermoSysPro.InstrumentationAndControl.Blocks.Sources;
block Ramp
  parameter Real startTime=1 "Ramp start time (s)";
  parameter Real duration=2 "Ramp duration (s)";
  parameter Real initialValue=0 "Initial output value";
  parameter Real finalValue=1 "Final output value";
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal y
                                       annotation (Placement(transformation(
          extent={{100,-10},{120,10}}, rotation=0)));
equation

  y.signal = if time < startTime then (initialValue) else if time > (startTime
     + duration) then (finalValue) else (initialValue + (finalValue -
    initialValue)*(time - startTime)/duration);
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Polygon(
          points={{-80,90},{-88,68},{-72,68},{-80,90}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,68},{-80,-80}}, color={192,192,192}),
        Line(
          points={{-80,-20},{-20,-20},{50,50}},
          color={0,0,0},
          thickness=0.5),
        Line(points={{-90,-70},{82,-70}}, color={192,192,192}),
        Polygon(
          points={{90,-70},{68,-62},{68,-78},{90,-70}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-30,-20},{-32,-30},{-27,-30},{-30,-20}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-30,-20},{-30,-70}},
          color={192,192,192},
          pattern=LinePattern.Solid,
          thickness=0.25,
          arrow={Arrow.None,Arrow.None}),
        Polygon(
          points={{-30,-70},{-33,-60},{-28,-60},{-30,-70},{-30,-70}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-80,-33},{-30,-50}},
          lineColor={160,160,164},
          textString=
               "initialValue"),
        Text(
          extent={{-40,-70},{6,-88}},
          lineColor={160,160,164},
          textString="time"),
        Text(
          extent={{50,50},{100,30}},
          lineColor={160,160,164},
          textString="finalValue"),
        Text(
          extent={{-100,110},{100,90}},
          lineColor={0,0,0},
          textString="Ramp"),
        Text(
          extent={{-150,150},{150,110}},
          textString="%name")
    }),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Rectangle(
          extent={{-100,-100},{100,100}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-90,-70},{82,-70}}, color={192,192,192}),
        Polygon(
          points={{90,-70},{68,-62},{68,-78},{90,-70}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,-70},{-80,68}}, color={192,192,192}),
        Polygon(
          points={{-80,90},{-88,68},{-72,68},{-80,90}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-80,-70},{-30,-70},{-30,-20},{50,50}},
          color={0,0,0},
          thickness=0.5),
        Text(
          extent={{-100,110},{100,90}},
          lineColor={0,0,0},
          textString="Ramp")
    })
  );
end Ramp;
