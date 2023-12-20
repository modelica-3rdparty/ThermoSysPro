within ThermoSysPro.WaterSteam.Sensors;
model Sensor_pH "pH sensor"
  parameter Boolean continuous_flow_reversal=false
    "true : continuous flow reversal - false : discontinuous flow reversal";
  parameter Integer mode=0
    "IF97 region. 1:liquid - 2:steam - 4:saturation line - 0:automatic";

    replaceable package Species =
      ChimiScope.None          annotation (
      choicesAllMatching=true, Dialog(tab="Fluid", group="Transported Substances"));

      //Units.SI.Density rho;
  ThermoSysPro.Units.SI.Density rho_liquidPhase;
  Real x "Title";

  parameter Real pH_scale_max = 14;
  parameter Real pH_scale_min = 0;

  parameter ThermoSysPro.Units.SI.Temperature ImposedT=25 + 273.15;
  parameter Boolean TChoice=true;

  Real measure_col[3](each min=0, each max=255) "pH corrspondig color";
  Real neg_col[3](each min=0, each max=255) "Negative pH color";

protected
  constant Real pi=Modelica.Constants.pi "pi";
  parameter ThermoSysPro.Units.SI.MassFlowRate Qeps=1.e-3
    "Minimum mass flow rate for continuous flow reversal";

public
  ThermoSysPro.Units.SI.MassFlowRate Q(start=500) "Mass flow rate";
  ThermoSysPro.Units.SI.Temperature T "Fluid temperature";
  ThermoSysPro.Units.SI.AbsolutePressure P "Fluid average pressure";
  ThermoSysPro.Units.SI.SpecificEnthalpy h(start=110000)
    "Fluid specific enthalpy";
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph pro
    "Propriétés de l'eau"
    annotation (Placement(transformation(extent={{-100,80},{-80,100}}, rotation=
           0)));
public
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal Measure
    annotation (Placement(transformation(
        origin={0,100},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  ThermoSysPro.WaterSteam.Connectors.FluidInlet C1(redeclare package Species =
        Species) annotation (Placement(transformation(extent={{-110,-90},{-90,-70}},
          rotation=0)));
  ThermoSysPro.WaterSteam.Connectors.FluidOutlet C2(redeclare package Species =
        Species) annotation (Placement(transformation(extent={{92,-90},{112,-70}},
          rotation=0)));
  Species.pH pH(T=T, rho_liquidPhase=rho_liquidPhase, x=x, SubC=C1.SubC)
    annotation (Placement(transformation(extent={{-90,70},{-70,90}})));

equation

  C1.P = C2.P;
  C1.h = C2.h;
  C1.Q = C2.Q;
  C1.SubC = C2.SubC;

  Q = C1.Q;

  /* Flow reversal */
  if continuous_flow_reversal then
    0 = noEvent(if (Q > Qeps) then C1.h - C1.h_vol else if (Q < -Qeps) then
      C2.h - C2.h_vol else C1.h - 0.5*((C1.h_vol - C2.h_vol)*Modelica.Math.sin(pi
      *Q/2/Qeps) + C1.h_vol + C2.h_vol));
  else
    0 = if (Q > 0) then C1.h - C1.h_vol else C2.h - C2.h_vol;
  end if;

  /* Sensor signal */
  Measure.signal = pH.pH;

  /* Fluid thermodynamic properties */

  if TChoice then
    T=ImposedT;
    P=1.013e5;
   else
  h = (C1.h + C2.h)/2;
  P = (C1.P + C2.P)/2;
  end if;

  rho_liquidPhase = pro.d;

  x = pro.x;

  measure_col = Modelica.Mechanics.MultiBody.Visualizers.Colors.scalarToColor(14-pH.pH,14-pH_scale_max,14-pH_scale_min,Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps.jet());
  neg_col = fill(255,3) - measure_col;

  pro = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(
                                                P, h, mode);

  T = pro.T;

  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Ellipse(
          extent={{-60,92},{60,-28}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={127,255,0}),
        Line(points={{0,-30},{0,-80}}),
        Line(points={{-98,-80},{102,-80}}),
        Text(
          extent={{-34,84},{30,-16}},
          lineColor={28,108,200},
          textString="pH")}),
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Ellipse(
          extent={{-60,92},{60,-28}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor=DynamicSelect({127,255,0}, measure_col)),
        Line(points={{0,-30},{0,-80}}),
        Line(points={{-98,-80},{102,-80}}),
        Text(
          extent={{-48,70},{48,4}},
          lineColor=DynamicSelect({0,0,255},neg_col),
          fillColor={0,0,0},
          textString=DynamicSelect("pH", String(pH.pH, significantDigits=3)))}),
    Window(
      x=0.22,
      y=0.21,
      width=0.6,
      height=0.6),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2021</b> </p>
<p><b>ThermoSysPro Version 4.0</b> </p>
</html>",
   revisions="<html>
<p><u><b>Authors</b></u></p>
<ul>
<li>Daniel Bouskela</li>
<li>Baligh El Hefni</li>
</ul>
</html>"));
end Sensor_pH;
