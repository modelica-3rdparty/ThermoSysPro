within ThermoSysPro.NuclearCore;
model DecayHeat "Calculation of the decay heat given by the decay of the fission
  products in the core of the nuclear reactor"

  parameter Real Kris[:]={0.0251,0.01654,0.02586}
    "Fraction of the power associated to group i";
  parameter Real Tris[:]={15,137,2910}
    "Time constant associated to group i (s)";
  parameter Boolean steady_state=true "Initialize the decay heat at equilibrium" annotation(choices(checkBox=true));

protected
  parameter Integer N=size(Kris, 1) "Number of groups of radio-isotopes";

public
  ThermoSysPro.Units.SI.Power Pneut(start=3560e6) "Total neutronic power (W)";
  ThermoSysPro.Units.SI.Power PresTot "Total decay heat (W)";
  ThermoSysPro.Units.SI.Power Pres[N](start=Kris*3560e6)
    "Residual power associated to the groups of radio-isotopes (W)";
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal Pneutrons
    annotation (extent=[-120,-10; -100,10], Placement(transformation(extent={{-120,
            -10},{-100,10}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal DecayHeat
    annotation (extent=[100,-10; 120,10], Placement(transformation(extent={{100,
            -10},{120,10}}, rotation=0)));
initial equation

  if steady_state then

    for i in 1:N loop

      der(Pres[i]) = 0;

    end for;

  else
    Pres = Kris*3560e6;

  end if;

equation
  Pneut =Pneutrons.signal;
  PresTot =DecayHeat.signal;

  PresTot = sum(Pres);

  for i in 1:N loop

    der(Pres[i]) = (Kris[i]*Pneut - Pres[i])/Tris[i];

  end for;

  annotation (Icon(
      graphics={
        Ellipse(
          extent={{-100,100},{100,-20}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={255,128,0}),
        Ellipse(
          extent={{-100,20},{100,-100}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={255,128,0}),
        Rectangle(
          extent={{-100,40},{100,-42}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={255,128,0}),
        Text(
          extent={{-78,90},{78,-96}},
          textColor={0,0,0},
          textString=
               "%name"),
        Text(
          extent={{-132,28},{-132,16}},
          textColor={0,0,0},
          textString=
               "Pneut"),
        Text(
          extent={{130,26},{130,14}},
          textColor={0,0,0},
          textString=
               "Pres")},
      Ellipse(extent=[-100, 100; 100, -20], style(
          color=3,
          rgbcolor={0,0,255},
          gradient=3,
          fillColor=45,
          rgbfillColor={255,128,0})),
      Ellipse(extent=[-100, 20; 100, -100], style(
          color=3,
          rgbcolor={0,0,255},
          gradient=3,
          fillColor=45,
          rgbfillColor={255,128,0})),
      Rectangle(extent=[-100, 40; 100, -42], style(
          color=3,
          rgbcolor={0,0,255},
          gradient=1,
          fillColor=45,
          rgbfillColor={255,128,0})),
      Text(
        extent=[-78, 90; 78, -96],
        style(
          color=3,
          rgbcolor={0,0,255},
          gradient=1,
          fillColor=45,
          rgbfillColor={255,128,0}),
        string="%name"),
      Text(
        extent=[-132, 28; -132, 16],
        style(
          color=3,
          rgbcolor={0,0,255},
          gradient=1,
          fillColor=45,
          rgbfillColor={255,128,0}),
        string="Pneut"),
      Text(
        extent=[130, 26; 130, 14],
        style(
          color=3,
          rgbcolor={0,0,255},
          gradient=1,
          fillColor=45,
          rgbfillColor={255,128,0}),
        string="Pres")), Diagram(
      graphics={
        Ellipse(
          extent={{-100,100},{100,-20}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={255,128,0}),
        Ellipse(
          extent={{-100,20},{100,-100}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={255,128,0}),
        Rectangle(
          extent={{-100,40},{100,-42}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={255,128,0}),
        Text(
          extent={{-78,74},{78,-74}},
          textColor={0,0,0},
          textString="Decay Heat"),
        Text(
          extent={{116,24},{116,12}},
          textColor={0,0,0},
          textString=
               "Pres"),
        Text(
          extent={{-118,24},{-118,12}},
          textColor={0,0,0},
          textString=
               "Pneut")},
      Ellipse(extent=[-100, 100; 100, -20], style(
          color=3,
          rgbcolor={0,0,255},
          gradient=3,
          fillColor=45,
          rgbfillColor={255,128,0})),
      Ellipse(extent=[-100, 20; 100, -100], style(
          color=3,
          rgbcolor={0,0,255},
          gradient=3,
          fillColor=45,
          rgbfillColor={255,128,0})),
      Rectangle(extent=[-100, 40; 100, -42], style(
          color=3,
          rgbcolor={0,0,255},
          gradient=1,
          fillColor=45,
          rgbfillColor={255,128,0})),
      Text(
        extent=[-76, 74; 80, -74],
        style(
          color=3,
          rgbcolor={0,0,255},
          gradient=1,
          fillColor=45,
          rgbfillColor={255,128,0}),
        string="PuissResiduelle"),
      Text(
        extent=[116, 24; 116, 12],
        style(
          color=3,
          rgbcolor={0,0,255},
          gradient=1,
          fillColor=45,
          rgbfillColor={255,128,0}),
        string="Pres"),
      Text(
        extent=[-118, 24; -118, 12],
        style(
          color=3,
          rgbcolor={0,0,255},
          gradient=1,
          fillColor=45,
          rgbfillColor={255,128,0}),
        string="Pneut")),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2024</b></p>
</HTML>
<html>
<p><b>ThermoSysPro Version 4.1</b></p>
</HTML>
"));
end DecayHeat;
