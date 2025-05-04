within ThermoSysPro.NuclearCore;
model NeutronKinetics "This module contains a model of the neutronic flux with six groups of
  delayed neutrons. Starting from the total reactivity, which is an input in the module and it is given
  by the sum of all the possible feedback effects (Doppler, moderator, control bars, boron and xenon),
  this module calculates the evolution of the fission power of the reactor. The total power is the sum of the neutronic power
  and the residual power (which is an input of the module)."

  parameter ThermoSysPro.Units.SI.Time Tlife=23.27e-6
    "Average lifetime of the prompt neutrons in the core (s)";
  parameter Real Kfuel=1
    "Ratio between the power produced in the fuel and the total power";
  parameter Real Lambda[6]={0.0125,0.0308,0.1143,0.3103,1.2331,3.289}
    "Radioactivity constants of the groups of the delayed neutrons (1/s)";
  parameter Real Beta[6]={0.00021,0.00142,0.00131,0.00274,0.000932,0.000313}
    "Fraction of delayed neutrons in each group with respect to the total number of neutrons emitted per fission";

  parameter Real Ptot0=524e6 "Initial power of the core";

protected
  Real SumBeta=sum(Beta);

public
  ThermoSysPro.Units.SI.Power Pneut(start=Ptot0) "Neutronic power (W)";
  ThermoSysPro.Units.SI.Power Pndelay[6](start=fill(Ptot0*1e-3,6))
    "Power given by the 6 groups of delayed neutrons (W)";
  ThermoSysPro.Units.SI.Power Ptot "Total power of the reactor (W)";
  ThermoSysPro.Units.SI.Power Pfuel "Power produced in the fuel (W)";
  ThermoSysPro.Units.SI.Power Ph2o "Power directly received by the moderator (W)";
  Real Reac "Total reactivity (pcm)";
  ThermoSysPro.Units.SI.Power Pres "Residual power (W)";

  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal Reactivity
    annotation (extent=[-120, 30; -100, 50], Placement(transformation(extent={{
            -120,30},{-100,50}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal DecayHeat
    annotation (extent=[-120,-50; -100,-30], Placement(transformation(extent={{
            -120,-50},{-100,-30}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal Pneutrons
    annotation (extent=[100,40; 120,60], Placement(transformation(extent={{100,
            40},{120,60}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal TotalPower
    annotation (extent=[100, 6; 120, 26], Placement(transformation(extent={{100,
            6},{120,26}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal PowerInFuel
    annotation (extent=[100,-26; 120,-6], Placement(transformation(extent={{100,
            -26},{120,-6}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal PowerOutFuel
    annotation (extent=[100,-60; 120,-40], Placement(transformation(extent={{100,
            -60},{120,-40}}, rotation=0)));

initial equation

  Ptot = Ptot0; //Start from a predefined level of power

  for i in 1:6 loop
    der(Pndelay[i]) = 0; //Initialize at equilibrium
  end for;

equation
  Reac =Reactivity.signal;
  Pres =DecayHeat.signal;
  Pneut =Pneutrons.signal;
  Ptot =TotalPower.signal;
  Pfuel =PowerInFuel.signal;
  Ph2o =PowerOutFuel.signal;

  Ptot - (Pneut + Pres) = 0;
  Pfuel - Kfuel*Ptot = 0;
  Ph2o - (1 - Kfuel)*Ptot = 0;

  // Point reactor kinetics equations
  der(Pneut) = (Reac*1e-5 - SumBeta)*Pneut/Tlife + sum(Lambda .* Pndelay);

  for i in 1:6 loop

    der(Pndelay[i]) = Beta[i]*Pneut/Tlife - Lambda[i]*Pndelay[i];

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
          extent={{-78,92},{78,-84}},
          textColor={0,0,0},
          textString=
               "%name"),
        Text(
          extent={{-130,68},{-130,56}},
          textColor={0,0,0},
          textString=
               "Reac"),
        Text(
          extent={{-134,-14},{-134,-26}},
          textColor={0,0,0},
          textString=
               "Pres"),
        Text(
          extent={{140,38},{140,26}},
          textColor={0,0,0},
          textString=
               "Ptot"),
        Text(
          extent={{142,74},{142,62}},
          textColor={0,0,0},
          textString=
               "Pneut"),
        Text(
          extent={{142,6},{142,-6}},
          textColor={0,0,0},
          textString=
               "Pfuel"),
        Text(
          extent={{142,-28},{142,-40}},
          textColor={0,0,0},
          textString=
               "Ph2o")},
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
        extent=[-78, 92; 78, -84],
        style(
          color=3,
          rgbcolor={0,0,255},
          gradient=1,
          fillColor=45,
          rgbfillColor={255,128,0}),
        string="%name"),
      Text(
        extent=[-130, 68; -130, 56],
        style(
          color=3,
          rgbcolor={0,0,255},
          gradient=1,
          fillColor=45,
          rgbfillColor={255,128,0}),
        string="Reac"),
      Text(
        extent=[-134, -14; -134, -26],
        style(
          color=3,
          rgbcolor={0,0,255},
          gradient=1,
          fillColor=45,
          rgbfillColor={255,128,0}),
        string="Pres"),
      Text(
        extent=[140, 38; 140, 26],
        style(
          color=3,
          rgbcolor={0,0,255},
          gradient=1,
          fillColor=45,
          rgbfillColor={255,128,0}),
        string="Ptot"),
      Text(
        extent=[142, 74; 142, 62],
        style(
          color=3,
          rgbcolor={0,0,255},
          gradient=1,
          fillColor=45,
          rgbfillColor={255,128,0}),
        string="Pneut"),
      Text(
        extent=[142, 6; 142, -6],
        style(
          color=3,
          rgbcolor={0,0,255},
          gradient=1,
          fillColor=45,
          rgbfillColor={255,128,0}),
        string="Pfuel"),
      Text(
        extent=[142, -28; 142, -40],
        style(
          color=3,
          rgbcolor={0,0,255},
          gradient=1,
          fillColor=45,
          rgbfillColor={255,128,0}),
        string="Ph2o")), Diagram(
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
          extent={{-110,62},{-110,50}},
          textColor={0,0,0},
          textString=
               "Reac"),
        Text(
          extent={{-110,-18},{-110,-30}},
          textColor={0,0,0},
          textString=
               "Pres"),
        Text(
          extent={{-88,60},{92,-56}},
          textColor={0,0,255},
          textString="Neutron Kinetics"),
        Text(
          extent={{112,72},{112,60}},
          textColor={0,0,0},
          textString=
               "Pneut"),
        Text(
          extent={{110,36},{110,24}},
          textColor={0,0,0},
          textString=
               "Ptot"),
        Text(
          extent={{112,4},{112,-8}},
          textColor={0,0,0},
          textString=
               "Pfuel"),
        Text(
          extent={{112,-30},{112,-42}},
          textColor={0,0,0},
          textString=
               "Ph2o")},
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
        extent=[-110, 62; -110, 50],
        style(
          color=3,
          rgbcolor={0,0,255},
          gradient=1,
          fillColor=45,
          rgbfillColor={255,128,0}),
        string="Reac"),
      Text(
        extent=[-110, -18; -110, -30],
        style(
          color=3,
          rgbcolor={0,0,255},
          gradient=1,
          fillColor=45,
          rgbfillColor={255,128,0}),
        string="Pres"),
      Text(
        extent=[-88, 60; 92, -56],
        style(color=3, rgbcolor={0,0,255}),
        string="CinetiqueNeutronique"),
      Text(
        extent=[112, 72; 112, 60],
        style(
          color=3,
          rgbcolor={0,0,255},
          gradient=1,
          fillColor=45,
          rgbfillColor={255,128,0}),
        string="Pneut"),
      Text(
        extent=[110, 36; 110, 24],
        style(
          color=3,
          rgbcolor={0,0,255},
          gradient=1,
          fillColor=45,
          rgbfillColor={255,128,0}),
        string="Ptot"),
      Text(
        extent=[112, 4; 112, -8],
        style(
          color=3,
          rgbcolor={0,0,255},
          gradient=1,
          fillColor=45,
          rgbfillColor={255,128,0}),
        string="Pfuel"),
      Text(
        extent=[112, -30; 112, -42],
        style(
          color=3,
          rgbcolor={0,0,255},
          gradient=1,
          fillColor=45,
          rgbfillColor={255,128,0}),
        string="Ph2o")),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2024</b></p>
</HTML>
<html>
<p><b>ThermoSysPro Version 4.1</b></p>
</HTML>
"));
end NeutronKinetics;
