within ThermoSysPro.NuclearCore;
model ReactivityFeedbacks "This module calculates the neutronic feedback reactions due to the control rods, the Doppler effect, the moderator, 
  the boron and the xenon for a punctual neutronic flux. The emergency shutdown (SCRAM) of the reactor is not considered 
  in this module."

  parameter Real alfa_dop=-2 "Doppler coefficient (pcm/K)";
  parameter ThermoSysPro.Units.SI.Temperature t0_doppler=944
    "Doppler Temperature associated (K)";
  parameter Real L=200 "Length of the control rods (cm)";
//  parameter Real step_size= L/25;
  // parameter Real Reac_worth_G=1250;
 //  parameter Real Reac_worth_R=30;
 // Ediffg0 = Reac_worth_G/L (pcm/cm);
 // Ediffr0 = Reac_worth_R/L (pcm/cm);
 // parameter Integer g_rods_number = 10 "Total number of control rods assemblies of the group G";
 // parameter Integer r_rods_number = 20 "Total number of control rods assemblies of the group R";
 parameter Boolean steady_state = true;

  parameter Real PosR0=0 "Control rods initial position is assumed to be 0, the control
  rods are completely extracted from the core";

  parameter Real alfa_mod = -60 "Moderator Coefficient (pcm/K)";
  parameter ThermoSysPro.Units.SI.Temperature Tref_core = 585.45;
  parameter Real kxe=-1;
  parameter Real Cxenon0=0 "Xenon reference concentration (ppm)";
  parameter ThermoSysPro.Units.SI.Temperature Tref_fuel(start=973.15, fixed=false)
    "fuel effective reference temperature (K)";

  parameter Real XPosgYEdiffg[27, 2]=[25*8, -62.5; 24*8, -62.5; 23*8, -62.5; 22*8, -62.5; 21*8, -62.5; 20*8, -62.5; 19*8, -62.5;
   18*8, -62.5; 17*8, -62.5; 16*8, -62.5; 15*8, -62.5; 14*8, -62.5; 13*8, -62.5; 12*8, -62.5; 11*8, -62.5; 10*8, -62.5;
   9*8, -62.5; 8*8, -62.5; 7*8, -62.5; 6*8, -62.5; 5*8, -62.5; 4*8, -62.5; 3*8, -62.5; 2*8, -62.5; 8, -62.5; 0, -62.5; 0, 0]
    "XPosgYEdiffg (input = first column, output = second column)";
  parameter Real XPosrYEdiffr[27, 2]=[25*8, -3; 24*8, -3; 23*8, -3; 22*8, -3; 21*8, -3; 20*8, -3; 19*8, -3;
   18*8, -3; 17*8, -3; 16*8, -3; 15*8, -3; 14*8, -3; 13*8, -3; 12*8, -3; 11*8, -3; 10*8, -3;
   9*8, -3; 8*8, -3; 7*8, -3; 6*8, -3; 5*8, -3; 4*8, -3; 3*8, -3; 2*8, -3; 8, -3; 0, -3; 0, 0]
    "XPosrYEdiffr (input = first column, output = second column)";

protected
  parameter Real XPosg[1, :]=transpose(matrix(XPosgYEdiffg[:, 1]))
    "Inputs of the table";
  parameter Real YEdiffg[1, :]=transpose(matrix(XPosgYEdiffg[:, 2]))
    "Outputs of the table";
  parameter Integer ng[1, 1]=[size(XPosg, 2)] "Size of the table";
  parameter Real XPosr[1, :]=transpose(matrix(XPosrYEdiffr[:, 1]))
    "Inputs of the table";
  parameter Real YEdiffr[1, :]=transpose(matrix(XPosrYEdiffr[:, 2]))
    "Outputs of the table";
  parameter Integer nr[1, 1]=[size(XPosr, 2)] "Size of the table";

public
  Real PosR(start=0, fixed=true) "Position of group R (cm)";
  Real VelR "Velocity of group R (cm/min)";
  Real PosG "Position of the grey group (cm)";
  Real T_fuel "Fuel effective temperature (K)";
  Real T_CoreAv "Average temperature of the moderator in the core (K)";
  Real Cbore "Concentration of the boron";
  Real Cxenon "Concentration of the xénon";

  Real Reac "Total reactivity (pcm)";
  Real ReacB "Reactivity given by the control bars (pcm)";
 Real ReacBG
    "Reactivity given by the control bars of group G (pcm)";
 Real ReacBR
    "Reactivity given by the control bars of group R (pcm)";
 Real ReacD
    "Reactivity given by the Doppler effect (fuel temperature) (pcm)";
 Real ReacM "Reactivity given by the moderator effect (pcm)";
 Real ReacX "Reactivity given by the Xenon (pcm)";

  Real Ediffg "Differential efficiency of the grey group (pcm/cm)";
  Real Ediffr "Differential efficiency of group R (pcm/cm)";

  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal SortieReac
    annotation (extent=[100, 70; 120, 90], Placement(transformation(extent={{100,-16},{120,
            4}},               rotation=0), iconTransformation(extent={{100,-16},{120,4}})));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal EntreeCbore
    annotation (extent=[-120, -70; -100, -50], Placement(transformation(extent=
            {{-120,-70},{-100,-50}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal EntreeT_CoreAv
    annotation (extent=[-120, -30; -100, -10], Placement(transformation(extent=
            {{-120,-30},{-100,-10}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal EntreeT_fuel
    annotation (extent=[-120, 10; -100, 30], Placement(transformation(extent={{
            -120,10},{-100,30}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal EntreePosG
    annotation (extent=[-120, 50; -100, 70], Placement(transformation(extent={{
            -120,50},{-100,70}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal EntreeVelR
    annotation (extent=[-120, 90; -100, 110], Placement(transformation(extent={
            {-120,90},{-100,110}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal EntreeCxenon
    annotation (extent=[-120, -110; -100, -90], Placement(transformation(extent=
           {{-120,-110},{-100,-90}}, rotation=0)));
initial equation
  ReacBG = 0;
  ReacBR = Ediffr*(PosR - PosR0);
  Tref_fuel=T_fuel;

 if steady_state then
   Reac=0;
   //Tref_fuel=T_fuel;
 end if;

equation
  Reac = SortieReac.signal;
  der(PosR) = VelR/60;
  VelR = EntreeVelR.signal;
  PosG = EntreePosG.signal;
  T_fuel = EntreeT_fuel.signal;
  T_CoreAv = EntreeT_CoreAv.signal;
  Cbore = EntreeCbore.signal;
  Cxenon = EntreeCxenon.signal;

  /* Total reactivity given by the control bars */
  ReacB = ReacBR + ReacBG;

  Ediffg = ThermoSysPro.Functions.LinearInterpolation(XPosgYEdiffg[:, 1], XPosgYEdiffg[:, 2], PosG);
  der(ReacBG) = Ediffg*der(PosG);

  Ediffr = ThermoSysPro.Functions.LinearInterpolation(XPosrYEdiffr[:, 1], XPosrYEdiffr[:, 2], PosR);
  der(ReacBR) = Ediffr*der(PosR);

  ReacD = alfa_dop*(T_fuel-Tref_fuel);

  /* Reactivity given by the moderator effect */

  ReacM = alfa_mod*(T_CoreAv-Tref_core);

  /* Reactivity given by the Xenon*/
  ReacX = kxe*(Cxenon - Cxenon0);

  /* Total reactivity*/
  Reac = ReacB + ReacD + ReacM + ReacX;

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
          extent={{-112,124},{-112,112}},
          textColor={0,0,255},
          textString=
               "PosR"),
        Text(
          extent={{-114,84},{-114,72}},
          textColor={0,0,255},
          textString=
               "PosG"),
        Text(
          extent={{-116,44},{-116,32}},
          textColor={0,0,255},
          textString=
               "T_fuel"),
        Text(
          extent={{-114,4},{-114,-8}},
          textColor={0,0,255},
          textString=
               "T_CoreAv"),
        Text(
          extent={{-114,-36},{-114,-48}},
          textColor={0,0,255},
          textString=
               "Cbore"),
        Text(
          extent={{-114,-76},{-114,-88}},
          textColor={0,0,255},
          textString=
               "Cxenon"),
        Text(
          extent={{106,82},{106,70}},
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
<p><b>Copyright &copy; EDF 2002 - 2010</b></p>
</HTML>
<html>
<p><b>ThermoSysPro Version 2.0</b></p>
</HTML>
"));
end ReactivityFeedbacks;
