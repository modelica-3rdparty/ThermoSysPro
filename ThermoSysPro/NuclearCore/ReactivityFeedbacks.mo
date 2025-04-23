within ThermoSysPro.NuclearCore;
model ReactivityFeedbacks "This module calculates the neutronic feedback due to control rods, Doppler effect, moderator temperature, 
  boron and xenon concentration"

  parameter Real alfa_dop=-3 "Doppler coefficient (pcm/K)" annotation(Dialog(group="Reactivity Coefficients"));

  parameter Boolean steady_state = true annotation(Dialog(group="Reference State"),choices(checkBox=true));


  parameter Real alfa_mod = -30 "Moderator Coefficient (pcm/K)" annotation(Dialog(group="Reactivity Coefficients"));
  parameter ThermoSysPro.Units.SI.Temperature Tref_mod = 585.45 "Moderator Reference Temperature" annotation(Dialog(group="Reference State"));
  parameter Real kxe=-3.e-20 "Xenon Coefficient" annotation(Dialog(group="Reactivity Coefficients"));
  parameter Real kB = -10 "Soluble Poison (Boron) Coefficient (pcm/ppm)" annotation(Dialog(group="Reactivity Coefficients"));
  parameter ThermoSysPro.Units.SI.Temperature Tref_fuel(start=973.15, fixed=false)
    "fuel effective reference temperature (K)" annotation(Dialog(group="Reference State"));


  parameter Integer n_rods = 2 "Number of Control Rods" annotation(Dialog(group="Control Rods Parameters"));
  parameter Real rod_stroke = 100 "Rod Stroke in the core (in steps, cm...)" annotation(Dialog(group="Control Rods Parameters"));
  parameter Real RodsPos0[n_rods]={10,0} "Control rods initial position (0 -> completely extracted from the core)" annotation(Dialog(group="Control Rods Parameters"));

  parameter Boolean constant_rodWorth = true "Whether to use constant rod worths or tables" annotation(Dialog(group="Control Rods Parameters"),choices(checkBox=true));
  parameter Real rodWorth[n_rods] = {-10, -4} "Rod worth (pcm/step)" annotation(Dialog(enable=constant_rodWorth, group="Control Rods Parameters"));
  parameter Integer rod_nodes = 10 "Number of sections in the rod worth tables" annotation(Dialog(group="Control Rods Parameters",enable=not
                                                                                                                                            (constant_rodWorth)));

  parameter Real Z_rodNodes[rod_nodes+3] = {i*rod_stroke/rod_nodes for i in -1:rod_nodes+1} "Z of rodworth sections" annotation(Dialog(group="Control Rods Parameters",enable=not
                                                                                                                                                                                 (constant_rodWorth)));

  parameter Real rodWorth_tab[n_rods, rod_nodes+3] = {
    {0, 0, 5, 9, 12, 14, 15, 14, 12, 9, 5, 0, 0},
    {0, 0, 3, 6, 8, 9, 9.5, 9, 8, 6, 3, 0, 0}} "Rod Worth of as a function of Z (see Z_rodNodes)" annotation(Dialog(enable=not
                                                                                                                              (constant_rodWorth),group="Control Rods Parameters"));

  parameter Real cumRodWorth[n_rods, rod_nodes+3] = {ThermoSysPro.Functions.CumulativeIntegral(rod_nodes+3, Z_rodNodes, rodWorth_tab[i]) for i in 1:n_rods}
    "Rod Worth of as a function of Z (see Z_rodNodes)" annotation(Dialog(enable=false,group="Control Rods Parameters"));

  parameter Real ReacFuel(start=1000,fixed=false) "Reference Reactivity of Fuel" annotation(Dialog(group="Reference State"));
  Real RodsPos[n_rods] "Position of groups (steps)";
  Real RodsSpeedsValue[n_rods] "Velocity of rods groups (insertion in step/min)";
  Real T_fuel "Fuel effective temperature (K)";
  Real T_CoreAv "Average temperature of the moderator in the core (K)";
  Real Cbore "Concentration of the boron";
  Real Cxenon "Concentration of the xénon";

  Real Reac "Total reactivity (pcm)";

  Real ReacP "Reactivity given by soluble poison, i.e. Boron (pcm)";
  Real ReacB "Reactivity given by the control bars (pcm)";
   Real ReacBi[n_rods] "Reactivity given by the control bars (pcm)";
 Real ReacD "Reactivity given by the Doppler effect (fuel temperature) (pcm)";
 Real ReacM "Reactivity given by the moderator effect (pcm)";
 Real ReacX "Reactivity given by the Xenon (pcm)";

  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal SortieReac
    annotation (extent=[100, 70; 120, 90], Placement(transformation(extent={{100,-16},{120,
            4}},               rotation=0), iconTransformation(extent={{100,-16},{120,4}})));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal EntreeCbore
    annotation (extent=[-120, -70; -100, -50], Placement(transformation(extent={{-120,
            -50},{-100,-30}},        rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal EntreeT_CoreAv
    annotation (extent=[-120, -30; -100, -10], Placement(transformation(extent={{-120,
            -10},{-100,10}},         rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal EntreeT_fuel
    annotation (extent=[-120, 10; -100, 30], Placement(transformation(extent={{-120,30},
            {-100,50}},          rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal RodsSpeeds[n_rods]
    annotation (extent=[-120,90; -100,110], Placement(transformation(extent={{-120,
            70},{-100,90}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal EntreeCxenon
    annotation (extent=[-120, -110; -100, -90], Placement(transformation(extent={{-120,
            -90},{-100,-70}},        rotation=0)));
initial equation
  RodsPos = RodsPos0;

  Tref_fuel=T_fuel;

 if steady_state then
    Reac=0;
 end if;

equation
  Reac = SortieReac.signal;
  der(RodsPos) = RodsSpeedsValue/60;
  RodsSpeedsValue = RodsSpeeds.signal;
  T_fuel = EntreeT_fuel.signal;
  T_CoreAv = EntreeT_CoreAv.signal;
  Cbore = EntreeCbore.signal;
  Cxenon = EntreeCxenon.signal;

  /* Total reactivity given by the control bars */
  ReacB = sum(ReacBi);

  for i in 1:n_rods loop
    ReacBi[i] = if constant_rodWorth then min(rod_stroke, max(RodsPos[i],0))*rodWorth[i] else ThermoSysPro.Functions.LinearInterpolation(Z_rodNodes, cumRodWorth[i], RodsPos[i]);
  end for;

  /* Reactivity given by the soluble poison (boron) */
  ReacP = kB * Cbore;

  /* Reactivity given by the Doppler effect */
  ReacD = alfa_dop*(T_fuel-Tref_fuel);

  /* Reactivity given by the moderator effect */
  ReacM = alfa_mod*(T_CoreAv-Tref_mod);

  /* Reactivity given by the Xenon*/
  ReacX = kxe*Cxenon;

  /* Total reactivity*/
  Reac = ReacFuel + ReacB + ReacD + ReacM + ReacX + ReacP;

  annotation (Icon(
      graphics={
        Text(
          extent={{-136,-78},{-136,-90}},
          textColor={0,0,255},
          textString=
               "Cxenon"),
        Text(
          extent={{-136,-38},{-136,-50}},
          textColor={0,0,255},
          textString=
               "Cbore"),
        Text(
          extent={{-136,2},{-136,-10}},
          textColor={0,0,255},
          textString=
               "T_CoreAv"),
        Text(
          extent={{-136,42},{-136,30}},
          textColor={0,0,255},
          textString=
               "T_fuel"),
        Text(
          extent={{-136,82},{-136,70}},
          textColor={0,0,255},
          textString=
               "PosG"),
        Text(
          extent={{124,18},{124,6}},
          textColor={0,0,255},
          textString=
               "Reac"),
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
          extent={{-82,102},{82,-98}},
          textColor={0,0,255},
          textString=
               "%name")},
      Text(
        extent=[-136, -78; -136, -90],
        style(color=3, rgbcolor={0,0,255}),
        string="Cxenon"),
      Text(
        extent=[-136, -38; -136, -50],
        style(color=3, rgbcolor={0,0,255}),
        string="Cbore"),
      Text(
        extent=[-136, 2; -136, -10],
        style(color=3, rgbcolor={0,0,255}),
        string="T_CoreAv"),
      Text(
        extent=[-136, 42; -136, 30],
        style(color=3, rgbcolor={0,0,255}),
        string="T_fuel"),
      Text(
        extent=[-136, 82; -136, 70],
        style(color=3, rgbcolor={0,0,255}),
        string="PosG"),
      Text(
        extent=[136, 102; 136, 90],
        style(color=3, rgbcolor={0,0,255}),
        string="Reac"),
      Text(
        extent=[136, -60; 136, -72],
        style(color=3, rgbcolor={0,0,255}),
        string="ReacX"),
      Text(
        extent=[136, -20; 136, -32],
        style(color=3, rgbcolor={0,0,255}),
        string="ReacM"),
      Text(
        extent=[136, 20; 136, 8],
        style(color=3, rgbcolor={0,0,255}),
        string="ReacD"),
      Text(
        extent=[136, 60; 136, 48],
        style(color=3, rgbcolor={0,0,255}),
        string="ReacB"),
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
        extent=[-82, 102; 82, -98],
        style(color=3, rgbcolor={0,0,255}),
        string="%name")), Diagram(
      graphics={
        Ellipse(
          extent={{-100,102},{100,-18}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={255,128,0}),
        Ellipse(
          extent={{-100,22},{100,-98}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={255,128,0}),
        Rectangle(
          extent={{-100,42},{100,-40}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={255,128,0}),
        Text(
          extent={{-76,102},{82,-98}},
          textColor={0,0,255},
          textString="Reactivity Feedback"),
        Text(
          extent={{-112,104},{-112,92}},
          textColor={0,0,255},
          textString="RodsSpeeds"),
        Text(
          extent={{-116,64},{-116,52}},
          textColor={0,0,255},
          textString=
               "T_fuel"),
        Text(
          extent={{-114,24},{-114,12}},
          textColor={0,0,255},
          textString=
               "T_CoreAv"),
        Text(
          extent={{-114,-16},{-114,-28}},
          textColor={0,0,255},
          textString=
               "Cbore"),
        Text(
          extent={{-114,-56},{-114,-68}},
          textColor={0,0,255},
          textString=
               "Cxenon"),
        Text(
          extent={{114,20},{114,8}},
          textColor={0,0,255},
          textString=
               "Reac")},
      Ellipse(extent=[-100, 102; 100, -18], style(
          color=3,
          rgbcolor={0,0,255},
          gradient=3,
          fillColor=45,
          rgbfillColor={255,128,0})),
      Ellipse(extent=[-100, 22; 100, -98], style(
          color=3,
          rgbcolor={0,0,255},
          gradient=3,
          fillColor=45,
          rgbfillColor={255,128,0})),
      Rectangle(extent=[-100, 42; 100, -40], style(
          color=3,
          rgbcolor={0,0,255},
          gradient=1,
          fillColor=45,
          rgbfillColor={255,128,0})),
      Text(
        extent=[-76, 104; 82, -96],
        style(color=3, rgbcolor={0,0,255}),
        string="AntiReac"),
      Text(
        extent=[-112, 124; -112, 112],
        style(color=3, rgbcolor={0,0,255}),
        string="PosR"),
      Text(
        extent=[-114, 84; -114, 72],
        style(color=3, rgbcolor={0,0,255}),
        string="PosG"),
      Text(
        extent=[-116, 44; -116, 32],
        style(color=3, rgbcolor={0,0,255}),
        string="T_fuel"),
      Text(
        extent=[-114, 4; -114, -8],
        style(color=3, rgbcolor={0,0,255}),
        string="T_CoreAv"),
      Text(
        extent=[-114, -36; -114, -48],
        style(color=3, rgbcolor={0,0,255}),
        string="Cbore"),
      Text(
        extent=[-114, -76; -114, -88],
        style(color=3, rgbcolor={0,0,255}),
        string="Cxenon"),
      Text(
        extent=[116, 104; 116, 92],
        style(color=3, rgbcolor={0,0,255}),
        string="Reac"),
      Text(
        extent=[116, -58; 116, -70],
        style(color=3, rgbcolor={0,0,255}),
        string="ReacX"),
      Text(
        extent=[116, -18; 116, -30],
        style(color=3, rgbcolor={0,0,255}),
        string="ReacM"),
      Text(
        extent=[116, 22; 116, 10],
        style(color=3, rgbcolor={0,0,255}),
        string="ReacD"),
      Text(
        extent=[116, 62; 116, 50],
        style(color=3, rgbcolor={0,0,255}),
        string="ReacB")),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2024</b></p>
</HTML>
<html>
<p><b>ThermoSysPro Version 4.1</b></p>
</HTML>
"));
end ReactivityFeedbacks;
