within ThermoSysPro.InstrumentationAndControl.Blocks.Discret;
block ConvDA
  parameter Real maxval=1 "Maximum input value";
  parameter Real minval=-maxval "Minimum input value";
  parameter Real bits=12 "Number of bits of the DA converter";
  parameter Real SampleOffset=0 "Sampling start time (s)";
  parameter Real SampleInterval=0.01 "Sampling period (s)";

protected
  Real qInterval(start=((maxval - minval)/2^bits)) "quantization interval";
  Real uBound "bounded input";
public
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal u
                                      annotation (Placement(transformation(
          extent={{-120,-10},{-100,10}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal y
                                       annotation (Placement(transformation(
          extent={{100,-10},{120,10}}, rotation=0)));
algorithm

  qInterval := ((maxval - minval)/2^bits);

  when sample(SampleOffset, SampleInterval) then
    uBound := if u.signal > maxval then maxval else if u.signal < minval then
      minval else u.signal;
    y.signal := qInterval*floor(abs(uBound/qInterval) + 0.5)*sign(uBound);
  end when;
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,255},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,-30},{-46,-30},{-46,0},{-20,0},{-20,22},{-8,22},{-8,
              44},{12,44},{12,20},{30,20},{30,0},{62,0},{62,-22},{88,-22}}),
        Text(extent={{-150,150},{150,110}}, textString=
                                                "%name")}),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Line(points={{-80,-30},{-46,-30},{-46,0},{-20,0},
              {-20,22},{-8,22},{-8,44},{12,44},{12,20},{30,20},{30,0},{62,0},{
              62,-22},{88,-22}})}),
    Window(
      x=0.15,
      y=0.24,
      width=0.6,
      height=0.6),
    Documentation(info="<html>
<p><b>Version 1.0</b></p>
</HTML>
"));
end ConvDA;
