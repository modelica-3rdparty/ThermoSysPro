within ThermoSysPro.InstrumentationAndControl.Blocks.Math;
block BooleanToReal
  parameter Real realTrue=1.0;
  parameter Real realFalse=0.0;

  Connectors.InputLogical u
    annotation (Placement(transformation(extent={{-120,0},{-100,20}}), iconTransformation(
          extent={{-120,0},{-100,20}})));
  Connectors.OutputReal y annotation (Placement(transformation(extent={{100,2},{120,22}}),
        iconTransformation(extent={{100,2},{120,22}})));
equation
  y.signal= if u.signal then realTrue else realFalse;


  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,-100},{102,100}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(extent={{-80,82},{80,-78}})}),                   Diagram(coordinateSystem(
          preserveAspectRatio=false)));
end BooleanToReal;
