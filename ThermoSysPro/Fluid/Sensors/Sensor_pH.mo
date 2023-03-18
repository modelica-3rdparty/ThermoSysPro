within ThermoSysPro.Fluid.Sensors;
model Sensor_pH "Temperature sensor"
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType;
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region;

  replaceable package Species =
      ThermoSysPro.ConvectedQuantities.Substances.None   annotation (
      choicesAllMatching=true, Dialog(tab="Fluid", group="Transported Substances"));

  //parameter Integer output_unit=1 "Sensor outpu unit - 1: m3/h, other: m3/s";
  parameter IF97Region region=IF97Region.All_regions "IF97 region (active for IF97 water/steam only)" annotation(Evaluate=true, Dialog(enable=(ftype==FluidType.WaterSteam), tab="Fluid", group="Fluid properties"));

protected
  constant Real pi=Modelica.Constants.pi "pi";
  parameter Integer mode=Integer(region) - 1 "IF97 region. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  parameter Units.SI.MassFlowRate Qeps=1.e-3
    "Minimum mass flow rate for continuous flow reversal";

public
  Units.SI.MassFlowRate Q(start=500) "Mass flow rate";
  Units.SI.Temperature T "Fluid temperature";
  Units.SI.AbsolutePressure P "Fluid average pressure";
  Units.SI.SpecificEnthalpy h "Fluid specific enthalpy";
  FluidType ftype "Fluid type";
  Integer fluid=Integer(ftype) "Fluid number";

//Units.SI.Density rho;
  Units.SI.Density rho_liquidPhase;
  Real x "Title";
  //Real InternalConcentrations[Species.Concentrations];
    Properties.WaterSteam.Common.ThermoProperties_ph              pro
    "Propriétés de l'eau";

  parameter Real pH_scale_max = 14;
  parameter Real pH_scale_min = 0;

  Real measure_col[3](each min=0, each max=255) "pH corrspondig color";
  Real neg_col[3](each min=0, each max=255) "Negative pH color";

public
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal Measure
    annotation (Placement(transformation(
        origin={0,102},
        extent={{-10,-10},{10,10}},
        rotation=90), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,102})));
  ChimiScope.Fluid.Interfaces.Connectors.FluidInlet C1(redeclare package
      Species = Species) annotation (Placement(transformation(extent={{-110,-90},
            {-90,-70}}, rotation=0)));
  ChimiScope.Fluid.Interfaces.Connectors.FluidOutlet C2(redeclare package
      Species = Species) annotation (Placement(transformation(extent={{92,-90},
            {112,-70}}, rotation=0)));
  Species.pH pH(T=T, rho_liquidPhase=rho_liquidPhase, x=x, SubC=C1.SubC)
    annotation (Placement(transformation(extent={{-90,70},{-70,90}})));
equation

  C1.P = C2.P;
  C1.Q = C2.Q;
  C1.h = C2.h;

  C1.h_vol_1 = C2.h_vol_1;
  C1.h_vol_2 = C2.h_vol_2;

  C2.diff_on_1 = C1.diff_on_1;
  C1.diff_on_2 = C2.diff_on_2;

  C2.diff_res_1 = C1.diff_res_1;
  C1.diff_res_2 = C2.diff_res_2;

  C1.ftype = C2.ftype;

  C1.Xco2 = C2.Xco2;
  C1.Xh2o = C2.Xh2o;
  C1.Xo2  = C2.Xo2;
  C1.Xso2 = C2.Xso2;

  Q = C1.Q;

  ftype = C1.ftype;

  C1.SubC = C2.SubC;

  /* Sensor signal */
  Measure.signal = pH.pH;

  /* Fluid thermodynamic properties */
  P = (C1.P + C2.P)/2;
  h = (C1.h + C2.h)/2;
 rho_liquidPhase = ThermoSysPro.Properties.Fluid.Density_Ph(P, h, fluid, mode, C1.Xco2, C1.Xh2o, C1.Xo2, C1.Xso2);
  //rho avec pro?//
  pro = ThermoSysPro.Properties.Fluid.Ph(P, h, mode, fluid);
  x = pro.x;
  T = pro.T;

  measure_col = Modelica.Mechanics.MultiBody.Visualizers.Colors.scalarToColor(14-pH.pH,14-pH_scale_max,14-pH_scale_min,Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps.jet());
  neg_col = fill(255,3) - measure_col;

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
