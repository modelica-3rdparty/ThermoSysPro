within ThermoSysPro.NuclearCore;
model ReactivityFeedbacks "This module calculates the neutronic feedback due to control rods, Doppler effect, moderator temperature, 
  boron and xenon concentration"

  parameter Boolean steady_state = true annotation(Dialog(group="Reference State"),choices(checkBox=true));

  parameter ThermoSysPro.Units.SI.Temperature Tref_mod = 585.45 "Moderator Reference Temperature" annotation(Dialog(group="Reference State"));
  parameter Integer Np =1  "Number of poisons" annotation(Dialog(group="Reactivity Contributions"));
  parameter Real kp[Np] "Poisons Coefficient" annotation(Dialog(group="Reactivity Contributions"));
  parameter Real kB = -10 "Soluble Poison (Boron) Coefficient (pcm/ppm)" annotation(Dialog(group="Reactivity Contributions"));
  parameter ThermoSysPro.Units.SI.Temperature Tref_fuel(start=973.15, fixed=false)
    "fuel effective reference temperature (K)" annotation(Dialog(group="Reference State"));

  parameter Integer n_rods = 2 "Number of Control Rods" annotation(Dialog(group="Control Rods Parameters"));
  parameter Real rod_stroke[n_rods] = {100,100} "Rod Stroke in the core (in steps, cm...)" annotation(Dialog(group="Control Rods Parameters"));

  parameter Real RodsPos0[n_rods]={10,0} "Control rods initial position (0 -> completely extracted from the core)" annotation(Dialog(group="Control Rods Parameters"));

  parameter Boolean continuosInsertion = true "Whether to use constant rod worths or tables" annotation(Dialog(group="Control Rods Parameters"),choices(checkBox=true));

  parameter Boolean constant_rodWorth = true "Whether to use constant rod worths or tables" annotation(Dialog(group="Control Rods Parameters"),choices(checkBox=true));
  parameter Integer rod_nodes = 10 "Number of sections in the rod worth tables" annotation(Dialog(group="Control Rods Parameters",enable=not
                                                                                                                                            (constant_rodWorth)));

  //parameter Real Z_rodNodes[n_rods,rod_nodes + 3]={{i*rodWorth[j]/rod_nodes for i in -1:rod_nodes + 1} for j in 1:n_rods} "Z of rodworth sections" annotation (Dialog(group="Control Rods Parameters", enable=not (constant_rodWorth)));

  //parameter Real rodWorth_tab[n_rods, rod_nodes+3] = fill({0, 0, 5, 9, 12, 14, 15, 14, 12, 9, 5, 0, 0},n_rods) "Rod Worth of as a function of Z (see Z_rodNodes)" annotation(Dialog(enable=not(constant_rodWorth),tab = "Neutronics",group="Control Rods Parameters"));

 // parameter Real cumRodWorth[n_rods, rod_nodes+3] = {ThermoSysPro.Functions.CumulativeIntegral(rod_nodes+3, Z_rodNodes[i], rodWorth_tab[i]) for i in 1:n_rods} "Rod Worth of as a function of Z (see Z_rodNodes)" annotation(Dialog(enable=false,group="Control Rods Parameters"));

  //parameter Real Z_rodNodes[rod_nodes+3] = {i*rod_stroke/rod_nodes for i in -1:rod_nodes+1} "Z of rodworth sections" annotation(Dialog(group="Control Rods Parameters",enable=not (constant_rodWorth)));

  //parameter Real rodWorth_tab[n_rods, rod_nodes+3] = {
  //  {0, 0, 5, 9, 12, 14, 15, 14, 12, 9, 5, 0, 0},
  //  {0, 0, 3, 6, 8, 9, 9.5, 9, 8, 6, 3, 0, 0}} "Rod Worth of as a function of Z (see Z_rodNodes)" annotation(Dialog(enable=not(constant_rodWorth),group="Control Rods Parameters"));

 // parameter Real cumRodWorth[n_rods, rod_nodes+3] = {ThermoSysPro.Functions.CumulativeIntegral(rod_nodes+3, Z_rodNodes, rodWorth_tab[i]) for i in 1:n_rods}
 //   "Rod Worth of as a function of Z (see Z_rodNodes)" annotation(Dialog(enable=false,group="Control Rods Parameters"));


  parameter Real ReacFuel(start=1000,fixed=false) "Reference Reactivity of Fuel" annotation(Dialog(group="Reference State"));

  Real RodsPos[n_rods] "Position of groups (steps)";
  Real RodsSpeedsValue[n_rods] "Velocity of rods groups (insertion in step/min)";
  Real k[n_rods]  "Integer position of groups (steps)";
  Real T_fuel "Fuel effective temperature (K)";
  Real T_CoreAv "Average temperature of the moderator in the core (K)";
  Real Cbore "Concentration of the boron";
  Real Cpois[Np] "Concentration of the xénon";

  Real Reac "Total reactivity (pcm)";

  Real ReacSP "Reactivity given by soluble poison, i.e. Boron (pcm)";
  Real ReacB "Reactivity given by the control bars (pcm)";
   Real ReacBi[n_rods] "Reactivity given by the control bars (pcm)";
 Real ReacD "Reactivity given by the Doppler effect (fuel temperature) (pcm)";
 Real ReacM "Reactivity given by the moderator effect (pcm)";
  Real ReacP "Reactivity given by the poisons (pcm)";
  Real ReacPi[Np] "Reactivity given by the poisons (pcm)";

  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal SortieReac
    annotation (extent=[100, 70; 120, 90], Placement(transformation(extent={{134,-10},
            {154,10}},         rotation=0), iconTransformation(extent={{134,-10},
            {154,10}})));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal EntreeCbore
    annotation (extent=[-120, -70; -100, -50], Placement(transformation(extent={{-152,12},
            {-132,32}},              rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal EntreeT_CoreAv
    annotation (extent=[-120, -30; -100, -10], Placement(transformation(extent={{-152,52},
            {-132,72}},              rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal EntreeT_fuel
    annotation (extent=[-120, 10; -100, 30], Placement(transformation(extent={{-152,92},
            {-132,112}},         rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal RodsSpeeds[n_rods]
    annotation (extent=[-120,90; -100,110], Placement(transformation(extent={{-152,
            132},{-132,152}},
                            rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal EntreeCpois[Np]
    annotation (extent=[-120,-110; -100,-90], Placement(transformation(extent={{-152,
            -28},{-132,-8}},       rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal alfa_mod
    annotation (extent=[-120,-110; -100,-90], Placement(transformation(extent={{-152,
            -64},{-132,-44}},      rotation=0), iconTransformation(extent={{-152,
            -64},{-132,-44}})));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal alfa_dop
    annotation (extent=[-120,-110; -100,-90], Placement(transformation(extent={{-152,
            -98},{-132,-80}},       rotation=0), iconTransformation(extent={{-152,
            -98},{-132,-80}})));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal ReacGd
    annotation (extent=[-120,-110; -100,-90], Placement(transformation(extent={{
            -154,-122},{-134,-104}}, rotation=0), iconTransformation(extent={{-152,
            -126},{-132,-108}})));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal rodWorth[n_rods] annotation (extent=[-120,-110; -100,-90], Placement(
        transformation(extent={{-154,-150},{-134,-132}}, rotation=0),
        iconTransformation(extent={{-152,-154},{-132,-136}})));
initial equation
  RodsPos = RodsPos0;

  Tref_fuel=T_fuel;

 if steady_state then
    Reac=0;
 end if;

equation
  Reac = SortieReac.signal;
  for i in 1:n_rods loop
    der(RodsPos[i]) =if ((RodsPos[i] >= rod_stroke[i]) and (RodsSpeedsValue[i] > 0))
       then 0 else RodsSpeedsValue[i]/60;
  end for;
  RodsSpeedsValue = RodsSpeeds.signal;
  T_fuel = EntreeT_fuel.signal;
  T_CoreAv = EntreeT_CoreAv.signal;
  Cbore = EntreeCbore.signal;
  Cpois =EntreeCpois.signal;

  /* Total reactivity given by the control bars */
  ReacB = sum(ReacBi);

  for i in 1:n_rods loop
    if continuosInsertion then
      k[i] =min(rod_stroke[i], max(RodsPos[i], 0));
    else
      k[i] =min(rod_stroke[i], integer(max(floor(RodsPos[i] + 0.5), 0)));
    end if;

    ReacBi[i] = if constant_rodWorth then k[i]*rodWorth[i].signal else 0; //ThermoSysPro.Functions.LinearInterpolation(Z_rodNodes[i], cumRodWorth[i], RodsPos[i]);
  end for;

  assert(constant_rodWorth, "Only constant worth supported");

  /* Reactivity given by the soluble poison (boron) */
  ReacSP = kB * Cbore;

  /* Reactivity given by the Doppler effect */
  ReacD = alfa_dop.signal*(T_fuel-Tref_fuel);

  /* Reactivity given by the moderator effect */
  ReacM = alfa_mod.signal*(T_CoreAv-Tref_mod);

  /* Reactivity given by the Xenon*/
  ReacP = sum(ReacPi);
  ReacPi =kp.*Cpois;

  /* Total reactivity*/
  Reac = ReacFuel + ReacB + ReacD + ReacM + ReacP + ReacSP + ReacGd.signal;

  annotation (Icon(
      coordinateSystem(extent={{-140,-160},{140,160}}),
      graphics={
        Text(
          extent={{-170,28},{-170,16}},
          textColor={0,0,255},
          textString=
               "Cbore"),
        Text(
          extent={{-178,68},{-178,56}},
          textColor={0,0,255},
          textString=
               "T_CoreAv"),
        Text(
          extent={{-170,106},{-170,94}},
          textColor={0,0,255},
          textString=
               "T_fuel"),
        Text(
          extent={{-184,148},{-184,136}},
          textColor={0,0,255},
          textString="RodSpeed"),
        Text(
          extent={{124,18},{124,6}},
          textColor={0,0,255},
          textString=
               "Reac"),
        Ellipse(
          extent={{-140,-42},{140,-160}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={255,128,0}),
        Ellipse(
          extent={{-140,160},{140,42}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={255,128,0}),
        Rectangle(
          extent={{-140,102},{140,-106}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={255,128,0}),
        Text(
          extent={{-84,100},{80,-100}},
          textColor={0,0,255},
          textString=
               "%name"),
        Text(
          extent={{-170,-12},{-170,-24}},
          textColor={0,0,255},
          textString="Cpois"),
        Text(
          extent={{-176,-48},{-176,-60}},
          textColor={0,0,255},
          textString="alfa_mod"),
        Text(
          extent={{-176,-82},{-176,-94}},
          textColor={0,0,255},
          textString="alfa_dop"),
        Text(
          extent={{-176,-110},{-176,-122}},
          textColor={0,0,255},
          textString="ReacGd"),
        Text(
          extent={{-176,-140},{-176,-152}},
          textColor={0,0,255},
          textString="RodWorth")},
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
      coordinateSystem(extent={{-140,-160},{140,160}}),
      graphics={
        Ellipse(
          extent={{-140,160},{140,-6}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={255,128,0}),
        Ellipse(
          extent={{-140,-10},{140,-160}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={255,128,0}),
        Rectangle(
          extent={{-140,80},{140,-80}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={255,128,0}),
        Text(
          extent={{-72,92},{86,-108}},
          textColor={0,0,255},
          textString="Reactivity Feedback"),
        Text(
          extent={{-184,158},{-184,146}},
          textColor={0,0,255},
          textString="RodsSpeeds"),
        Text(
          extent={{-174,118},{-174,106}},
          textColor={0,0,255},
          textString=
               "T_fuel"),
        Text(
          extent={{-170,86},{-170,74}},
          textColor={0,0,255},
          textString=
               "T_CoreAv"),
        Text(
          extent={{-166,46},{-166,34}},
          textColor={0,0,255},
          textString=
               "Cbore"),
        Text(
          extent={{-162,6},{-162,-6}},
          textColor={0,0,255},
          textString="Cpois"),
        Text(
          extent={{160,22},{160,10}},
          textColor={0,0,255},
          textString=
               "Reac"),
        Text(
          extent={{-176,-66},{-176,-78}},
          textColor={0,0,255},
          textString="alfa_dop"),
        Text(
          extent={{-176,-30},{-176,-42}},
          textColor={0,0,255},
          textString="alfa_mod"),
        Text(
          extent={{-176,-98},{-176,-110}},
          textColor={0,0,255},
          textString="ReacGd"),
        Text(
          extent={{-180,-128},{-180,-140}},
          textColor={0,0,255},
          textString="RodWorth")},
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
