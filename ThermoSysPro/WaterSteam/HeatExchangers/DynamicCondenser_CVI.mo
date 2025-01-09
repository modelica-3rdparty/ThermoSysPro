within ThermoSysPro.WaterSteam.HeatExchangers;
model DynamicCondenser_CVI "Dynamic Cavity"
  import ThermoSysPro;
  //parameter Modelica.SIunits.Volume Vc=4510 "Cavity total volume";
  parameter Real Vf0=0.066
    "Fraction of initial liquid volume in the Cavity (0 < Vf0 < 1)";
  parameter ThermoSysPro.Units.SI.Pressure P0c=1e4
    "INitial pressure in the Cavity";
  parameter ThermoSysPro.Units.SI.Radius Rv=1.0
    "Radius of the Cavity cross-sectional area";
  parameter ThermoSysPro.Units.SI.Length Lv=15 "Cavity length";
  parameter ThermoSysPro.Units.SI.Length L2=14 "Pipes length";
  parameter ThermoSysPro.Units.SI.Length Lc=2.5
    "support plate spacing in cooling zone(Chicanes)";
  parameter ThermoSysPro.Units.SI.Diameter Dc=0.016
    "Internal diameter of the cooling pipes";
  parameter ThermoSysPro.Units.SI.Thickness ec=2.e-3
    "Thickness of the cooling pipes";
  parameter Integer Ns=10 "Number of segments for pipes";
  parameter Integer ntubest=10000 "Number of total pipes in Cavity ";
  parameter Integer ntubesV=200 "Numbers of pipes in a vertical plan in Cavity";
  parameter ThermoSysPro.Units.SI.SpecificHeatCapacity cp=460
    "Specific heat capacity of the metal of the cooling pipes";
  parameter ThermoSysPro.Units.SI.Density rho=7900
    "Density of the metal of the cooling pipes";
  parameter ThermoSysPro.Units.SI.ThermalConductivity lambda=26
    "Wall thermal conductivity of the cooling pipes";
  //parameter Modelica.SIunits.CoefficientOfHeatTransfer hcond=25000
  //  "Heat transfer coefficient between the vapor and the cooling pipes";

replaceable model SinkAndSource =
      ThermoSysPro.ConvectedQuantities.Components.SaSnone
constrainedby ThermoSysPro.ConvectedQuantities.Components.partialSaS annotation (
   choicesAllMatching=true, Dialog(tab="Fluid", group="Transported Substances"));

 replaceable package Species =
      ThermoSysPro.ConvectedQuantities.Substances.None   annotation (
      choicesAllMatching=true, Dialog(tab="Fluid", group="Transported Substances"));

  ThermoSysPro.WaterSteam.Volumes.TwoPhaseCavityOnePipe_CVI
    DynamicCondenser(
    redeclare package Species = Species,
    redeclare model SinkAndSource = SinkAndSource,
    Vf0=Vf0,
    P0=P0c,
    Ns=Ns,
    L2=L2,
    NbTubT=ntubest,
    Lc=Lc,
    NbTubV=ntubesV,
    Dext=Dc + 2*ec,
    R=Rv,
    L=Lv,
    Vertical=true) annotation (Placement(transformation(extent={{-98,-86},{80,
            98}}, rotation=0)));
  ThermoSysPro.WaterSteam.HeatExchangers.DynamicOnePhaseFlowPipe pipe_3(
    option_temperature=2,
    advection=true,
    mode=0,
    continuous_flow_reversal=true,
    D=Dc,
    L=L2,
    ntubes=ntubest,
    Ns=Ns) annotation (Placement(transformation(extent={{-58,-22},{54,16}},
          rotation=0)));
  ThermoSysPro.WaterSteam.Connectors.FluidInletI C1vap(redeclare package
      Species = Species) "Vapor inlet" annotation (Placement(transformation(
          extent={{-10,90},{10,110}}, rotation=0)));
  ThermoSysPro.WaterSteam.Connectors.FluidOutletI C2ex(redeclare package
      Species = Species) "Condensed water extraction outlet" annotation (
      Placement(transformation(extent={{-10,-110},{10,-90}}, rotation=0)));
  ThermoSysPro.WaterSteam.Connectors.FluidInletI Ce1
                 "Cooling water inlet" annotation (Placement(transformation(
          extent={{-116,-11},{-96,9}}, rotation=0)));
  ThermoSysPro.WaterSteam.Connectors.FluidOutletI Ce2
                 "Cooling water outlet" annotation (Placement(transformation(
          extent={{95,-11},{115,9}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal sortieReelle
    annotation (Placement(transformation(extent={{96,-64},{116,-44}}, rotation=
            0)));

  ThermoSysPro.WaterSteam.Connectors.FluidInletI C1(redeclare package Species =
        Species) "Extra water inlet" annotation (Placement(transformation(
          extent={{-107,71},{-87,91}}, rotation=0)));
  ThermoSysPro.Thermal.HeatTransfer.HeatExchangerWall Wall_3(
    D=Dc,
    e=ec,
    lambda=lambda,
    cpw=cp,
    rhow=rho,
    L=L2,
    Ns=Ns,
    ntubes=ntubest) annotation (Placement(transformation(extent={{-58,-4},{54,
            40}}, rotation=0)));
  ThermoSysPro.WaterSteam.Connectors.FluidInletI C2vap(redeclare package
      Species = Species) "Vapor inlet" annotation (Placement(transformation(
          extent={{-63,90},{-43,110}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal iNH3_CVI_Cond
    annotation (Placement(transformation(extent={{120,80},{100,100}}),
        iconTransformation(extent={{120,80},{100,100}})));
equation

  if (cardinality(C1) == 1) then
    C1.Q = 0;
    C1.h = 1.e5;
    C1.b = true;
    C1.SubC=fill(0,size(C1.SubC,1));
  end if;

  if (cardinality(iNH3_CVI_Cond) == 1) then
    iNH3_CVI_Cond.signal = 0;
  end if;

  if (cardinality(C2vap) == 1) then
    C2vap.Q = 0;
    C2vap.h = 1.e5;
    C2vap.b = true;
    C2vap.SubC=fill(0,size(C2vap.SubC,1));
  end if;

  connect(DynamicCondenser.Cl, C2ex)
                               annotation (Line(points={{-31.7234,-61.4667},{0,
          -61.4667},{0,-100}},                  color={0,0,255}));
  connect(C1, DynamicCondenser.Ce)
    annotation (Line(points={{-97,81},{-97,54.4533},{-82.4723,54.4533}}));
  connect(DynamicCondenser.yLevel, sortieReelle)
    annotation (Line(points={{33.7957,-22.8267},{106,-22.8267},{106,-54}}));
  connect(DynamicCondenser.Cth3, Wall_3.WT2)
                                      annotation (Line(points={{-32.1021,
          40.3467},{-8,40.3467},{-8,114},{86,114},{86,22.4},{-2,22.4}},
                                       color={191,95,0}));
  connect(Wall_3.WT1, pipe_3.CTh) annotation (Line(points={{-2,13.6},{-2,2.7}},
                                                    color={191,95,0}));
  connect(DynamicCondenser.CvBP, C1vap)
    annotation (Line(points={{-32.1021,73.4667},{0,73.4667},{0,100}}));
  connect(C2vap, DynamicCondenser.CvGCT)
    annotation (Line(points={{-53,100},{-53,-92},{-122,-92},{-122,116},{
          -60.1277,116},{-60.1277,73.4667}}));
  connect(pipe_3.C2, Ce2) annotation (Line(
      points={{54,-3},{80,-3},{80,-1},{105,-1}},
      color={0,0,255},
      thickness=0.5));
  connect(pipe_3.C1, Ce1)
    annotation (Line(points={{-58,-3},{-82,-3},{-82,-1},{-106,-1}},
                                                  thickness=0.5));
  connect(iNH3_CVI_Cond, DynamicCondenser.iNH3_CVI) annotation (Line(points={{110,90},
          {88,90},{88,44},{108,44},{108,9.06667},{33.7957,9.06667}},
                                                                   color={0,0,255}));
  annotation (Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-120,-100},{120,100}},
        initialScale=0.1), graphics={Text(
          extent={{6,114},{32,98}},
          lineColor={0,0,255},
          textString=
               "BP")}),Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-120,-100},{120,100}},
        initialScale=0.1), graphics={
        Rectangle(
          extent={{100,58},{80,-60}},
          lineColor={0,0,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-100,58},{-80,-60}},
          lineColor={0,0,255},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-20,24},{-80,18}},
          lineColor={0,0,255},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-20,-20},{-80,-26}},
          lineColor={0,0,255},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-20,-42},{-80,-48}},
          lineColor={0,0,255},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{80,24},{20,18}},
          lineColor={0,0,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{80,-42},{20,-48}},
          lineColor={0,0,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{80,-20},{20,-26}},
          lineColor={0,0,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{30,-20},{-30,-26}},
          lineColor={0,0,255},
          fillColor={170,170,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{30,-42},{-30,-48}},
          lineColor={0,0,255},
          fillColor={170,170,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{30,24},{-30,18}},
          lineColor={0,0,255},
          fillColor={170,170,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{0,100},{-20,98},{-40,94},{-60,88},{-80,78},{-92,66},{-96,62},
              {-96,62},{-100,58},{100,58},{96,62},{92,66},{86,72},{80,78},{60,
              88},{40,94},{20,98},{0,100}},
          lineColor={0,0,255},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{0,-100},{-20,-98},{-40,-96},{-60,-90},{-80,-80},{-92,-68},{
              -96,-64},{-100,-60},{-100,-60},{98,-60},{100,-60},{96,-64},{92,
              -68},{80,-80},{60,-90},{40,-96},{20,-98},{0,-100}},
          lineColor={0,0,255},
          fillColor={53,117,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{100,-60},{80,-80},{80,-60},{100,-60}},
          lineColor={0,0,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-100,-60},{-80,-60},{-80,-80},{-100,-60}},
          lineColor={0,0,255},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-100,58},{-80,58},{-80,78},{-100,58}},
          lineColor={0,0,255},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{100,58},{80,58},{80,78},{100,58}},
          lineColor={0,0,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-20,-64},{-80,-70}},
          lineColor={0,0,255},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{80,-64},{20,-70}},
          lineColor={0,0,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{30,-64},{-30,-70}},
          lineColor={0,0,255},
          fillColor={170,170,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-20,2},{-80,-4}},
          lineColor={0,0,255},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{80,2},{20,-4}},
          lineColor={0,0,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{30,2},{-30,-4}},
          lineColor={0,0,255},
          fillColor={170,170,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-20,46},{-80,40}},
          lineColor={0,0,255},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{80,46},{20,40}},
          lineColor={0,0,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{30,46},{-30,40}},
          lineColor={0,0,255},
          fillColor={170,170,255},
          fillPattern=FillPattern.Solid),
        Line(points={{90,8},{80,20}}, color={255,0,0}),
        Line(points={{90,-10},{80,-22}}, color={255,0,0}),
        Line(points={{90,-1},{78,-1}}, color={255,0,0}),
        Line(points={{-90,9},{-80,20}}, color={0,0,255}),
        Line(points={{-90,-10},{-80,-24}}, color={0,0,255}),
        Line(points={{-90,-1},{-76,-1}}, color={0,0,255})}),
    Documentation(revisions="<html>
<p><u><b>Author</b></u></p>
<ul>
<li>Baligh El Hefni </li>
</ul>
</html>",
   info="<html>
<p><b>Copyright &copy; EDF 2002 - 2019</b> </p>
<p><b>ThermoSysPro Version 3.2</h4>
<p>This component model is documented in Sect. 9.5.4 of the <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a>. </h4>
</html>"));
end DynamicCondenser_CVI;
