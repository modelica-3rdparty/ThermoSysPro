within ThermoSysPro.WaterSteam.Volumes;

model DynamicDrum "Dynamic drum"
  parameter Boolean Vertical = true "true: vertical cylinder - false: horizontal cylinder";
  parameter Units.SI.Radius R = 1.05 "Radius of the drum cross-sectional area";
  parameter Units.SI.Length L = 16.27 "Drum length";
  parameter Real Vf0 = 0.5 "Fraction of initial water volume in the drum (active if steady_state=false)";
  parameter Units.SI.AbsolutePressure P0 = 50.e5 "Fluid initial pressure (active if steady_state=false)";
  parameter Real Ccond = 0.01 "Condensation coefficient";
  parameter Real Cevap = 0.09 "Evaporation coefficient";
  parameter Real Xlo = 0.0025 "Vapor mass fraction in the liquid phase from which the liquid starts to evaporate";
  parameter Real Xvo = 0.9975 "Vapor mass fraction in the gas phase from which the liquid starts to condensate";
  parameter Real Kvl = 1000 "Heat exchange coefficient between the liquid and gas phases";
  parameter Units.SI.CoefficientOfHeatTransfer Klp = 400 "Heat exchange coefficient between the liquid phase and the wall";
  parameter Units.SI.CoefficientOfHeatTransfer Kvp = 100 "Heat exchange coefficient between the gas phase and the wall";
  parameter Units.SI.CoefficientOfHeatTransfer Kpa = 25 "Heat exchange coefficient between the wall and the outside";
  parameter Units.SI.Mass Mp = 117e3 "Wall mass";
  parameter Units.SI.SpecificHeatCapacity cpp = 600 "Wall specific heat";
  parameter Boolean steady_state = true "true: start from steady state - false: start from (P0, Vf0)";
  Units.SI.AbsolutePressure P "Fluid average pressure";
  Units.SI.AbsolutePressure Pfond "Fluid pressure at the bottom of the drum";
  Units.SI.SpecificEnthalpy hl "Liquid phase specific enthalpy";
  Units.SI.SpecificEnthalpy hv "Gas phase specific enthalpy";
  Units.SI.Temperature Tl "Liquid phase temperature";
  Units.SI.Temperature Tv "Gas phase temperature";
  Units.SI.Temperature Tp(start = 550) "Wall temperature";
  Units.SI.Temperature Ta "External temperature";
  Units.SI.Volume Vl "Liquid phase volume";
  Units.SI.Volume Vv "Gas phase volume";
  Units.SI.Area Alp "Liquid phase surface on contact with the wall";
  Units.SI.Area Avp "Gas phase surface on contact with the wall";
  Units.SI.Area Ape "Wall surface on contact with the outside";
  Real xl(start = 0.5) "Mass vapor fraction in the liquid phase";
  Real xv(start = 0) "Mass vapor fraction in the vapor phase";
  Real xmv(start = 0.5) "Mass vapor fraction in the ascending tube";
  Units.SI.Density rhol(start = 996) "Liquid phase density";
  Units.SI.Density rhov(start = 1.5) "Gas phase density";
  Units.SI.MassFlowRate BQl "Right hand side of the mass balance equation of the liquid phase";
  Units.SI.MassFlowRate BQv "Right hand side of the mass balance equation of the gas phase";
  Units.SI.Power BHl "Right hand side of the energy balance equation of the liquid phase";
  Units.SI.Power BHv "Right hand side of the energy balance equation of the gas phase";
  Units.SI.MassFlowRate Qcond "Condensation mass flow rate from the vapor phase";
  Units.SI.MassFlowRate Qevap "Evaporation mass flow rate from the liquid phase";
  Units.SI.MassFlowRate Qv "Steam mass flow rate from the riser";
  Units.SI.Power Wlv "Thermal power exchanged from the gas phase to the liquid phase";
  Units.SI.Power Wpl "Thermal power exchanged from the liquid phase to the wall";
  Units.SI.Power Wpv "Thermal power exchanged from the gas phase to the wall";
  Units.SI.Power Wpa "Thermal power exchanged from the outside to the wall";
  Units.SI.Position zl(start = 1.05) "Liquid level in drum";
  Units.SI.Area Al "Cross sectional area of the liquid phase";
  Units.SI.Angle theta "Angle";
  Units.SI.Area Avl(start = 1.0) "Heat exchange surface between the liquid and gas phases";
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph prol "Propriétés de l'eau dans le ballon" annotation(
    Placement(transformation(extent = {{-60, 40}, {-20, 80}}, rotation = 0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph prov "Propriétés de la vapeur dans le ballon" annotation(
    Placement(transformation(extent = {{0, 40}, {40, 80}}, rotation = 0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph prom annotation(
    Placement(transformation(extent = {{-60, -20}, {-20, 20}}, rotation = 0)));
  ThermoSysPro.Properties.WaterSteam.Common.PropThermoSat lsat annotation(
    Placement(transformation(extent = {{-60, -80}, {-20, -40}}, rotation = 0)));
  ThermoSysPro.Properties.WaterSteam.Common.PropThermoSat vsat annotation(
    Placement(transformation(extent = {{0, -80}, {40, -40}}, rotation = 0)));
  Connectors.FluidInlet Ce1 "Feedwater input 1" annotation(
    Placement(transformation(extent = {{-110, 90}, {-90, 110}}, rotation = 0)));
  Connectors.FluidInlet Cm "Evaporation loop outlet" annotation(
    Placement(transformation(extent = {{90, -110}, {110, -90}}, rotation = 0)));
  Connectors.FluidOutlet Cd "Evaporation loop inlet" annotation(
    Placement(transformation(extent = {{-110, -110}, {-90, -90}}, rotation = 0)));
  Connectors.FluidOutlet Cv "Steam outlet" annotation(
    Placement(transformation(extent = {{90, 90}, {110, 110}}, rotation = 0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal yLevel "Water level " annotation(
    layer = "icon",
    Placement(transformation(extent = {{100, -10}, {120, 10}}, rotation = 0)));
  ThermoSysPro.Thermal.Connectors.ThermalPort Cth "Thermal input to the liquid" annotation(
    Placement(transformation(extent = {{-10, -60}, {10, -40}}, rotation = 0)));
  ThermoSysPro.Thermal.Connectors.ThermalPort Cex "Thermal input to the wall" annotation(
    Placement(transformation(extent = {{-10, 90}, {10, 110}}, rotation = 0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph prod annotation(
    Placement(transformation(extent = {{0, -20}, {40, 20}}, rotation = 0)));
  Connectors.FluidInlet Ce2 "Feedwater input 2" annotation(
    Placement(transformation(extent = {{-110, 30}, {-90, 50}}, rotation = 0)));
  Connectors.FluidInlet Ce3 "Feedwater input 3" annotation(
    Placement(transformation(extent = {{-110, -50}, {-90, -30}}, rotation = 0)));
  Connectors.FluidOutlet Cs "Water outlet" annotation(
    Placement(transformation(extent = {{90, -50}, {110, -30}}, rotation = 0)));
protected
  constant Real pi = Modelica.Constants.pi "pi";
  constant Units.SI.Acceleration g = Modelica.Constants.g_n "Gravity constant";
  parameter Units.SI.Volume V = pi*R^2*L "Drum volume";
  parameter Units.SI.Volume Vmin = 1.e-6;
initial equation
  if steady_state then
    der(hl) = 0;
    der(hv) = 0;
    der(P) = 0;
    der(Vl) = 0;
    der(Tp) = 0;
  else
    hl = lsat.h;
    hv = vsat.h;
    P = P0;
    Vl = Vf0*V;
    der(Tp) = 0;
  end if;
equation
/* Unconnected connectors */
  if (cardinality(Ce1) == 0) then
    Ce1.Q = 0;
    Ce1.h = 1.e5;
    Ce1.b = true;
  end if;
  if (cardinality(Ce2) == 0) then
    Ce2.Q = 0;
    Ce2.h = 1.e5;
    Ce2.b = true;
  end if;
  if (cardinality(Ce3) == 0) then
    Ce3.Q = 0;
    Ce3.h = 1.e5;
    Ce3.b = true;
  end if;
  if (cardinality(Cd) == 0) then
    Cd.Q = 0;
    Cd.h = 1.e5;
    Cd.a = true;
  end if;
  if (cardinality(Cs) == 0) then
    Cs.Q = 0;
    Cs.h = 1.e5;
    Cs.a = true;
  end if;
  if (cardinality(Cm) == 0) then
    Cm.Q = 0;
    Cm.h = 1.e5;
    Cm.b = true;
  end if;
  if (cardinality(Cv) == 0) then
    Cv.Q = 0;
    Cv.h = 1.e5;
    Cv.a = true;
  end if;
  Ce1.P = P;
  Ce2.P = P;
  Ce3.P = P;
  Cv.P = P;
  Cd.P = Pfond;
  Cs.P = P;
  Cm.P = P;
/* Liquid volume */
  if Vertical then
    theta = 1;
    Al = pi*R^2;
    Vl = Al*zl;
    Avl = Al;
  else
    theta = Modelica.Math.asin(max(-0.9999, min(0.9999, (R - zl)/R)));
    Al = (pi/2 - theta)*R^2 - R*(R - zl)*Modelica.Math.cos(theta);
    Vl = Al*L;
    Avl = 2*R*Modelica.Math.cos(theta)*L;
  end if;
/* Drum volume */
  Vl + Vv = V;
/* Liquid level */
  yLevel.signal = zl;
/* Liquid surface and vapor surface on contact with wall */
  Alp = if Vertical then 2*pi*R*zl + Al else (pi - 2*theta)*R*L + 2*Al;
  Avp = if Vertical then 2*pi*R*(L - zl) + Al else (pi + 2*theta)*R*L + 2*Al;
/* Wall surface on contact with the outside */
  Ape = Alp + Avp;
/* Pressure at the bottom of the drum */
  Pfond = P + prod.d*g*zl;
/* Liquid phase mass balance equation */
  BQl = Ce1.Q + Ce2.Q + Ce3.Q - Cd.Q - Cs.Q + (1 - xmv)*Cm.Q + Qcond - Qevap;
  rhol*der(Vl) + Vl*(prol.ddph*der(P) + prol.ddhp*der(hl)) = BQl;
/* Gas phase mass balance equation */
  BQv = xmv*Cm.Q - Cv.Q + Qevap - Qcond;
  rhov*der(Vv) + Vv*(prov.ddph*der(P) + prov.ddhp*der(hv)) = BQv;
/* Liquid phase energy balance equation */
  BHl = Ce1.Q*(Ce1.h - (hl - P/rhol)) + Ce2.Q*(Ce2.h - (hl - P/rhol)) + Ce3.Q*(Ce3.h - (hl - P/rhol)) - Cd.Q*(Cd.h - (hl - P/rhol)) - Cs.Q*(Cs.h - (hl - P/rhol)) + (1 - xmv)*Cm.Q*((if (xmv > 0) then lsat.h else Cm.h) - (hl - P/rhol)) + Qcond*(lsat.h - (hl - P/rhol)) - Qevap*(vsat.h - (hl - P/rhol)) + Wlv - Wpl + Cth.W;
  Vl*((P/rhol*prol.ddph - 1)*der(P) + (P/rhol*prol.ddhp + rhol)*der(hl)) = BHl;
  Ce1.h_vol = hl;
  Ce2.h_vol = hl;
  Ce3.h_vol = hl;
  Cd.h_vol = noEvent(min(lsat.h, hl));
  Cs.h_vol = hl;
/* Gas phase energy balance equation */
  BHv = xmv*Cm.Q*((if (xmv < 1) then vsat.h else Cm.h) - (hv - P/rhov)) - Cv.Q*(Cv.h - (hv - P/rhov)) + Qevap*(vsat.h - (hv - P/rhov)) - Qcond*(lsat.h - (hv - P/rhov)) - Wlv - Wpv;
  Vv*((P/rhov*prov.ddph - 1)*der(P) + (P/rhov*prov.ddhp + rhov)*der(hv)) = BHv;
  Cm.h_vol = hl;
  Cv.h_vol = hv;
/* Energy balance equation at the wall */
  Mp*cpp*der(Tp) = Wpl + Wpv + Wpa;
/* Heat exchange between liquid and gas phases */
  Wlv = Kvl*Avl*(Tv - Tl);
/* Heat exchange between the liquid phase and the wall */
  Wpl = Klp*Alp*(Tl - Tp);
/* Heat exchange between the gas phase and the wall */
  Wpv = Kvp*Avp*(Tv - Tp);
/* Heat exchange between the wall and the outside */
  Wpa = Kpa*Ape*(Ta - Tp);
/* Condensation and evaporation mass flow rates */
  Qcond = if noEvent(xv < Xvo) then Ccond*rhov*Vv*(Xvo - xv) else 0;
  Qevap = if noEvent(xl > Xlo) then Cevap*rhol*Vl*(xl - Xlo) else 0;
/* Fluid thermodynamic properties */
  prol = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(P, hl);
  prov = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(P, hv);
  prod = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Pfond, Cd.h);
  prom = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(P, Cm.h);
  (lsat, vsat) = ThermoSysPro.Properties.WaterSteam.IF97.Water_sat_P(P);
  Tl = prol.T;
  rhol = prol.d;
  xl = prol.x;
  Tv = prov.T;
  rhov = prov.d;
  xv = prov.x;
  xmv = if noEvent(Cm.Q > 0) then prom.x else 0;
  Qv = Cm.Q*xmv;
  Cth.T = Tl;
  Cex.T = Ta;
  Cex.W = Wpa;
  annotation(
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics),
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics = {Line(points = {{-90, 100}, {-68, 100}, {-60, 80}}), Line(points = {{-90, -100}, {-68, -100}, {-60, -80}}), Line(points = {{62, 80}, {70, 100}, {90, 100}}), Polygon(points = {{0, 100}, {-20, 98}, {-40, 92}, {-60, 80}, {-80, 60}, {-92, 40}, {-98, 20}, {-100, 0}, {-98, -20}, {98, -20}, {100, 0}, {98, 20}, {92, 40}, {80, 60}, {60, 80}, {40, 92}, {20, 98}, {0, 100}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Ellipse(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 255}, fillColor = {85, 170, 255}, fillPattern = FillPattern.Solid), Line(points = {{60, -80}, {72, -100}, {90, -100}}), Polygon(points = {{0, 100}, {-20, 98}, {-40, 92}, {-60, 80}, {-80, 60}, {-92, 40}, {-98, 20}, {-100, 0}, {-98, -20}, {98, -20}, {100, 0}, {98, 20}, {92, 40}, {80, 60}, {60, 80}, {40, 92}, {20, 98}, {0, 100}}, lineColor = {0, 0, 255}, fillColor = {170, 213, 255}, fillPattern = FillPattern.Solid)}),
    Window(x = 0.16, y = 0.04, width = 0.78, height = 0.88),
    Documentation(info = "
## Copyright © EDF 2002 - 2026   
## ThermoSysPro Version 4.2  
This component model is documented in Sect. 14.2 of the ThermoSysPro book.   
# Dynamic drum   

A drum is a reservoir of steam and water at the top end of the boiler.   
It separates water from steam in the  mixture generated in the boiler and stores them.  
The drum is represented as a dynamic non-adiabatic two-phase volume, with cylindrical geometry.   
The model takes into account the condensation and vaporization flow.  

The [two-phase cavity](modelica://ThermoSysPro.WaterSteam.Volumes.TwoPhaseCavity) has similar equations, but a different role in the plant: the two-phase volume is a condenser, whereas the dynamic drum separates the steam for the evaporator.  

Following assumptions are made:  
- the two phases are always present.  
- pressure losses are not taken into account in the drum.  
- the liquid and vapor phases are not necessarily in thermal equilibrium, but always in pressure equilibrium.  
- the steam may enter the superheated  cavity.  
- the liquid can be subcooled by the incoming drain and the wetted tube bundle.  



## Modelica component model  

The equations mentioned below are implemented in the component *DynamicDrum*, located in the *WaterSteam.Volumes* sub-library.   
This component has 10 connectors:  
- Ce1: feedwater input 1,  
- Ce2: feedwater input 2,  
- Ce3: feedwater input 3,  
- Cth: thermal input to the liquid,  
- Cex: thermal input to the wall,  
- Cd: evaporator inlet coming from the tank,  
- Cm: evaporator outlet toward the tank,  
- Cv: steam outlet,  
- Cs: water outlet,  
- yLevel: water level output,  
   
![modelica://ThermoSysPro/UsersGuide/Documentation/ThermoSysPro.WaterSteam.Volumes.DynamicDrum.svg](modelica://ThermoSysPro/UsersGuide/Documentation/ThermoSysPro.WaterSteam.Volumes.DynamicDrum.svg)  

## Nomenclature  

| Symbol| Description| Unit| Definition| Modelica name |  
| :-------------------------------- | :------------------------------------------------------------------------------------------ | :-------------------------------------------------- | :------------------------------------------------------------------------------------------------------------------------ | :----------- |  
| \\\\(A\\_{l})\\\\)| Cross-sectional area of the \\\\(\\mathrm{m}^{2}\\\\) liquid phase in the cavity|| For a vertical cavity: \\\\(\\pi \\cdot \\mathrm{R}^{2}\\\\)| Al |  
| \\\\(A\\_{\\mathrm{aw}}\\\\)| Contact surface between the ambient and the cavity wall| \\\\(\\mathrm{m}^{2}\\\\)| \\\\(A\\_{\\mathrm{lw}}+A\\_{\\mathrm{vw}}\\\\)| Ape |  
| \\\\(A\\_{l \\mathrm{w}}\\\\)| Contact surface between the liquid phase and the cavity wall| \\\\(\\mathrm{m}^{2}\\\\)| For a vertical cavity: \\\\(2 \\cdot \\pi \\cdot R \\cdot z\\_{l}+A\\_{l}\\\\). </br> For a horizontal cavity: \\\\(\\(\\pi-2 \\cdot \\theta\\) \\cdot R \\cdot L+2 \\cdot A\\_{l}\\\\)| Alp |  
| \\\\(A\\_{\\mathrm{vl}}\\\\)| Contact surface between the vapor phase and the liquid phase| \\\\(\\mathrm{m}^{2}\\\\)| For a vertical cavity: \\\\(A\\_{l}\\\\). </br> For a horizontal cavity: \\\\(2 . R \\cdot L . \\cos \\(\\theta\\)\\\\)| Avl |  
| \\\\(A\\_{\\mathrm{vw}}\\\\)| Contact surface between the vapor phase and the cavity wall| \\\\(\\mathrm{m}^{2}\\\\)| For a vertical cavity: \\\\(2 \\cdot \\pi \\cdot R \\cdot\\left\\(L-z\\_{l}\\right\\)+A\\_{l}\\\\). </br> For a horizontal cavity: \\\\(\\(\\pi+2 \\cdot \\theta\\) \\cdot R \\cdot L \\\\) \\\\(+ 2\\left\\(\\pi \\cdot R^{2}-A\\_{l}\\right\\)\\\\) | Avp |  
| \\\\(c\\_{\\mathrm{p}, \\mathrm{w}}\\\\)| Specific heat capacity of the drum wall| \\\\(\\mathrm{J} / \\mathrm{kg} / \\mathrm{K}\\\\)|| Cpp |  
| \\\\(C\\_{\\text {cond }}\\\\)| Condensation rate| \\\\(\\mathrm{s}^{-1}\\\\)|| Ccond |  
| \\\\(C\\_{\\text {evap }}\\\\)| Evaporation rate| \\\\(\\mathrm{s}^{-1}\\\\)|| Cevap |  
| \\\\(g\\\\)| Acceleration due to gravity| \\\\(\\mathrm{m} / \\mathrm{s}^{2}\\\\)|| g |  
| \\\\(h\\_{\\mathrm{ev}}\\\\)| Specific enthalpy of the water/steam mixture coming from the evaporator| \\\\(\\mathrm{J} / \\mathrm{kg}\\\\)|| Cm.h |  
| \\\\(h\\_{\\mathrm{i}\\_{1}}\\\\)| Specific enthalpy of the liquid phase at inlet \\\\(1\\\\) | \\\\(\\mathrm{J} / \\mathrm{kg}\\\\)|| Ce1.h |  
| \\\\(h\\_{\\mathrm{i}\\_{2}}\\\\)| Specific enthalpy of the liquid phase at inlet \\\\(2\\\\) | \\\\(\\mathrm{J} / \\mathrm{kg}\\\\)|| Ce2.h |  
| \\\\(h\\_{\\mathrm{i}\\_{3}}\\\\)| Specific enthalpy of the liquid phase at inlet \\\\(3\\\\) | \\\\(\\mathrm{J} / \\mathrm{kg}\\\\)|| Ce3.h |  
| \\\\(h\\_{l}\\\\)| Specific enthalpy of the liquid phase in the cavity | \\\\(\\mathrm{J} / \\mathrm{kg}\\\\)|| hl |  
| \\\\(h\\_{l, \\mathrm{ev}}\\\\)| Specific enthalpy of the liquid coming from the evaporator| \\\\(\\mathrm{J} / \\mathrm{kg}\\\\)|| Cm.h |  
| \\\\(h\\_{l, \\mathrm{o}\\_{l}}\\\\)| Specific enthalpy of the liquid phase at outlet 1, going to the evaporator | \\\\(\\mathrm{J} / \\mathrm{kg}\\\\)|| Cd.h |  
| \\\\(h\\_{l, \\mathrm{o} 2}\\\\)| Specific enthalpy of the liquid phase at outlet 2 | \\\\(\\mathrm{J} / \\mathrm{kg}\\\\)|| Cs.h |  
| \\\\(h\\_{l}^{\\mathrm{sat}}\\\\)| Saturation enthalpy of the liquid in the cavity| \\\\(\\mathrm{J} / \\mathrm{kg}\\\\)|| lsat.h |  
| \\\\(h\\_{\\mathrm{v}}\\\\)| Specific enthalpy of the vapor phase in the cavity| \\\\(\\mathrm{J} / \\mathrm{kg}\\\\)|| hv |  
| \\\\(h\\_{\\mathrm{v}, \\mathrm{ev}}\\\\)| Specific enthalpy of the vapor coming from the evaporator| \\\\(\\mathrm{J} / \\mathrm{kg}\\\\)|| vsat.h |  
| \\\\(h\\_{\\mathrm{v}, \\mathrm{o}}\\\\)| Specific enthalpy of the vapor phase at the outlet of the drum, going to the super-heater| \\\\(\\mathrm{J} / \\mathrm{kg}\\\\)|| Cv.h |  
| \\\\(h\\_{\\mathrm{v}}^{\\mathrm{sat}}\\\\) | Saturation enthalpy of the vapor in the cavity| \\\\(\\mathrm{J} / \\mathrm{kg}\\\\)|| vsat.h |  
| \\\\(K\\_{\\mathrm{lw}}\\\\)| Convective heat exchange coefficient between the liquid and the wall| \\\\(\\mathrm{W} / \\mathrm{m}^{2} / \\mathrm{K}\\\\)|| Klp |  
| \\\\(K\\_{\\mathrm{vl}}\\\\)| Convective heat exchange coefficient between the liquid and the vapor in the cavity| \\\\(\\mathrm{W} / \\mathrm{m}^{2} / \\mathrm{K}\\\\)|| Kvl |  
| \\\\(K\\_{\\mathrm{vw}}\\\\)| Convective heat exchange coefficient between the vapor and the wall| \\\\(\\mathrm{W} / \\mathrm{m}^{2} / \\mathrm{K}\\\\)|| Kvp |  
| \\\\(K\\_{\\mathrm{wa}}\\\\)| Convective heat exchange coefficient between the wall and the ambient| \\\\(\\mathrm{W} / \\mathrm{m}^{2} / \\mathrm{K}\\\\)|| Kpa |  
| \\\\(L\\\\)| Cavity length||| L |  
| \\\\(\\dot{m}\\_{\\text {cond }}\\\\)| Condensation mass flow rate inside the cavity| \\\\(\\mathrm{m} / \\mathrm{s}\\\\)|| Qcond |  
| \\\\(\\dot{m}\\_{\\mathrm{ev}}\\\\)| Fluid mass flow rate entering the cavity coming from the evaporator| \\\\(\\mathrm{kg} / \\mathrm{s}\\\\)|| Cm.Q |  
| \\\\(\\dot{m}\\_{\\mathrm{evap}}\\\\)| Evaporation mass flow rate inside the cavity| \\\\(\\mathrm{kg} / \\mathrm{s}\\\\)|| Qevap |  
| \\\\(\\dot{m}\\_{l, \\mathrm{o}_1}\\\\)| Mass flow rate of outgoing condensate 1 \\(going to the evaporator\\)| \\\\(\\mathrm{kg} / \\mathrm{s}\\\\)|| Cd.Q |  
| \\\\(\\dot{m}\\_{l, \\mathrm{o}\\_{2}}\\\\)| Mass flow rate of outgoing condensate 2| \\\\(\\mathrm{kg} / \\mathrm{s}\\\\)|| Cs.Q |  
| \\\\(\\dot{m}\\_{\\mathrm{i}\\_{1}}\\\\)| Mass flow rate of the liquid at inlet \\\\(1\\\\)| \\\\(\\mathrm{kg} / \\mathrm{s}\\\\)|| Ce1.Q |  
| \\\\(\\dot{m}\\_{\\mathrm{i}\\_{2}}\\\\)| Mass flow rate of the liquid at inlet \\\\(2\\\\)| \\\\(\\mathrm{kg} / \\mathrm{s}\\\\)|| Ce2.Q |  
| \\\\(\\dot{m}\\_{\\mathrm{i}\\_{3}}\\\\)| Mass flow rate of the liquid at inlet \\\\(3\\\\)| \\\\(\\mathrm{kg} / \\mathrm{s}\\\\)|| Ce3.Q |  
| \\\\(m\\_{\\mathrm{v}}\\\\)| Mass flow rate of the vapor going to the super-heater| \\\\(\\mathrm{kg} / \\mathrm{s}\\\\)|| Cv.Q |  
| \\\\(M\\_{\\mathrm{w}}\\\\)| Mass of the wall cavity| \\\\(\\mathrm{kg}\\\\)|| Mp |  
| \\\\(P\\\\)| Pressure of the liquid and vapor phases inside the cavity| \\\\(\\mathrm{Pa}\\\\)|| P |  
| \\\\(P\\_{\\mathrm{b}}\\\\)| Pressure of the liquid phase at the bottom of the cavity| \\\\(\\mathrm{Pa}\\\\)| \\\\(\\mathrm{P}+\\rho\\_{l} \\cdot g \\cdot z\\_{l}\\\\)| Pfond |  
| \\\\(R\\\\)| Cavity radius| \\\\(\\mathrm{K}\\\\)|| R |  
| \\\\(T\\_{\\mathrm{a}}\\\\)| Ambient temperature| \\\\(\\mathrm{K}\\\\)|| Ta |  
| \\\\(T\\_{l}\\\\)| Liquid temperature| \\\\(\\mathrm{K}\\\\)|| Tl |  
| \\\\(T\\_{\\text {sat }}\\\\)| Saturation temperature| \\\\(\\mathrm{K}\\\\)|| lsat.T, vsat.T |  
| \\\\(T\\_{\\mathrm{v}}\\\\)| Vapor temperature| \\\\(\\mathrm{K}\\\\)|| Tv |  
| \\\\(T\\_{\\mathrm{w}}\\\\)| Cavity wall temperature| \\\\(\\mathrm{K}\\\\)|| Tp |  
| \\\\(u\\\\)| Fluid specific internal energy| \\\\(\\mathrm{J} / \\mathrm{kg}\\\\)|| - |  
| \\\\(V\\\\)| Volume of the cavity| \\\\(\\mathrm{m}^{3}\\\\)| \\\\(V\\_{l}+V\\_{\\mathrm{v}}\\\\)| V |  
| \\\\(V\\_{l}\\\\)| Volume of the liquid in the cavity| \\\\(\\mathrm{m}^{3}\\\\)| \\\\(A\\_{l} \\cdot z\\_{l}\\\\)| Vl |  
| \\\\(V\\_{\\mathrm{v}}\\\\)| Volume of the vapor in the cavity| \\\\(\\mathrm{m}^{3}\\\\)|| Vv |  
| \\\\(W\\\\)| Power directly provided to the liquid phase| \\\\(\\mathrm{W}\\\\)|| Cth.W |  
| \\\\(\\mathrm{W}\\_{\\mathrm{aw}}\\\\)| Power exchanged from the ambient to the drum wall| \\\\(\\mathrm{W}\\\\)|| Wpa |  
| \\\\(\\mathrm{W}\\_{\\mathrm{lw}}\\\\)| Power exchanged from the liquid to the drum wall| \\\\(\\mathrm{W}\\\\)|| Wpl |  
| \\\\(W\\_{\\mathrm{vl}}\\\\)| Power exchanged from the vapor to the liquid| \\\\(\\mathrm{W}\\\\)|| Wlv |  
| \\\\(\\mathrm{W}\\_{\\mathrm{vw}}\\\\)| Power exchanged from the vapor to the drum wall| \\\\(\\mathrm{W}\\\\)|| Wpv |  
| \\\\(x\\_{\\mathrm{ev}}\\\\)| Vapor mass fraction of the fluid coming from the evaporator| \\\\(-\\\\)|| xmv |  
| \\\\(x\\_{l}\\\\)| Vapor mass fraction in the liquid phase| \\\\(-\\\\)|| xl |  
| \\\\(X\\_{\\mathrm{lo}}\\\\)| Vapor mass fraction in the liquid phase from which the liquid starts to evaporate| \\\\(-\\\\)|| Xlo |  
| \\\\(x\\_{\\mathrm{v}}\\\\)| Vapor mass fraction in the vapor phase| \\\\(-\\\\)|| xv |  
| \\\\(X\\_{\\mathrm{vo}}\\\\)| Vapor mass fraction in the vapor phase from which the liquid starts to condensate| \\\\(-\\\\)|| Xvo |  
| \\\\(z\\_{l}\\\\)| Liquid level in the cavity| \\\\(\\mathrm{m}\\\\)| \\\\(V\\_{l} / A\\_{l}\\\\)| zl |  
| \\\\(\\theta\\\\)| | \\\\(\\mathrm{rad}\\\\)| \\\\(\\arcsin \\left\\(\\frac{R-z\\_{l}}{R}\\right\\)\\\\)| theta |  
| \\\\(\\lambda\\_{l}\\\\)| Liquid thermal conductivity in the cavity| \\\\(\\mathrm{W} / \\mathrm{m} / \\mathrm{K}\\\\)|| - |  
| \\\\(\\rho\\_{l}\\\\)| Liquid density in the cavity| \\\\(\\mathrm{kg} / \\mathrm{m}^{3}\\\\)|| rhol |  
| \\\\(\\rho\\_{\\mathrm{v}}\\\\)| Vapor density in the cavity| \\\\(\\mathrm{kg} / \\mathrm{m}^{3}\\\\)|| rhov |  


## Governing equations  

### Dynamic mass balance equation for the liquid phase  


    
    

- Validity domain:   
   
 \\\\(\\forall \\dot{m}\\\\) and \\\\(0<V\\_{l}<V\\\\)  

- Mathematical formulation:   
   
 $$\\rho\\_{l} \\frac{\\mathrm{d} V\\_{l}}{\\mathrm{d} t}+V\\_{l}\\left[\\left\\(\\frac{\\partial \\rho\\_{l}}{\\partial P}\\right\\)\\_{h} \\cdot \\frac{\\mathrm{d} P}{\\mathrm{d} t}+\\left\\(\\frac{\\partial \\rho\\_{l}}{\\partial h\\_{l}}\\right\\)\\_{P} \\cdot \\frac{\\mathrm{d} h\\_{l}}{\\mathrm{d} t}\\right]=\\dot{m}\\_{\\mathrm{i}\\_{l}}+\\dot{m}\\_{\\mathrm{i}\\_{2}}+\\dot{m}\\_{\\mathrm{i}\\_{3}}-\\dot{m}\\_{l,0\\_{l}}-\\dot{m}\\_{l,0\\_{2}}$$ $$+\\left\\(1-x\\_{\\mathrm{ev}}\\right\\) \\cdot \\dot{m}\\_{\\mathrm{ev}}+\\dot{m}\\_{\\text {cond }}-\\dot{m}\\_{\\text {evap }}$$  

- Comments:   
   
 The liquid fraction of the evaporator outlet condensates directly.  


### Dynamic mass balance equation for the vapor phase   


    
    

- Validity domain:   
   
 \\\\(\\forall \\dot{m}\\\\) and \\\\(0<V\\_{\\mathrm{v}}<V\\\\)  


- Mathematical formulation:  

$$\\rho\\_{\\mathrm{v}} \\cdot \\frac{\\mathrm{d} V\\_{\\mathrm{v}}}{\\mathrm{d} t}+V\\_{\\mathrm{v}} \\cdot\\left[\\left\\(\\frac{\\partial \\rho\\_{\\mathrm{v}}}{\\partial P}\\right\\)\\_{h} \\cdot \\frac{\\mathrm{d} P}{\\mathrm{d} t}+\\left\\(\\frac{\\partial \\rho\\_{\\mathrm{v}}}{\\partial h\\_{\\mathrm{v}}}\\right\\)\\_{P} \\cdot \\frac{\\mathrm{d} h\\_{v}}{\\mathrm{d} t}\\right]=-\\dot{m}\\_{\\mathrm{v}}+x\\_{\\mathrm{ev}} \\cdot \\dot{m}\\_{\\mathrm{ev}}+\\dot{m}\\_{\\mathrm{evap}}-\\dot{m}\\_{\\mathrm{cond}}$$  


### Dynamic energy balance equation for the liquid phase  

- Validity domain:  

 \\\\(\\forall \\dot{m}\\\\) and \\\\(0<V\\_{l}<V\\\\)  

- Mathematical formulation:  

$$V\\_{l} \\cdot\\left[\\left\\(\\frac{P}{\\rho\\_{l}} \\cdot\\left\\(\\frac{\\partial \\rho\\_{l}}{\\partial P}\\right\\)\\_{h}-1\\right\\) \\cdot \\frac{\\mathrm{d} P}{\\mathrm{d} t}+\\left\\(\\frac{P}{\\rho\\_{l}} \\cdot\\left\\(\\frac{\\partial \\rho\\_{l}}{\\partial h\\_{l}}\\right\\)\\_{P}+\\rho\\_{l}\\right\\) \\cdot \\frac{\\mathrm{d} h\\_{l}}{\\mathrm{d} t}\\right] $$ $$=\\dot{m}\\_{\\mathrm{i}\\_{l}} \\cdot\\left\\(h\\_{\\mathrm{i}\\_{l}}-\\left\\(h\\_{l}-\\frac{P}{\\rho\\_{l}}\\right\\)\\right\\)+\\dot{m}\\_{\\mathrm{i}\\_{2}} \\cdot\\left\\(h\\_{\\mathrm{i}\\_{2}}-\\left\\(h\\_{l}-\\frac{P}{\\rho\\_{l}}\\right\\)\\right\\) + \\dot{m}\\_{\\mathrm{i}\\_{3}} \\cdot\\left\\(h\\_{\\mathrm{i}\\_{3}}-\\left\\(h\\_{l}-\\frac{P}{\\rho\\_{l}}\\right\\)\\right\\) $$ $$-\\dot{m}\\_{l, \\mathrm{o}\\_{l}} \\cdot\\left\\(h\\_{l, \\mathrm{o}\\_{2}}-\\left\\(h\\_{l}-\\frac{P}{\\rho\\_{l}}\\right\\)\\right\\) -\\dot{m}\\_{l, \\mathrm{o}\\_{2}} \\cdot\\left\\(h\\_{l, \\mathrm{o}\\_{2}}-\\left\\(h\\_{l}-\\frac{P}{\\rho\\_{l}}\\right\\)\\right\\)+\\dot{m}\\_{\\mathrm{cond}} \\cdot\\left\\(h\\_{l}^{\\mathrm{sat}}-\\left\\(h\\_{l}-\\frac{P}{\\rho\\_{l}}\\right\\)\\right\\) $$ $$-\\dot{m}\\_{\\mathrm{evap}} \\cdot\\left\\(h\\_{\\mathrm{v}}^{\\mathrm{sat}}-\\left\\(h\\_{l}-\\frac{P}{\\rho\\_{l}}\\right\\)\\right\\) +\\left\\(1-x\\_{\\mathrm{ev}}\\right\\) \\cdot \\dot{m}\\_{\\mathrm{ev}} \\cdot\\left\\(h\\_{l, \\mathrm{ev}}-\\left\\(h\\_{l}-\\frac{P}{\\rho\\_{l}}\\right\\)\\right\\)  
+W\\_{\\mathrm{vl}}-W\\_{\\mathrm{lw}}+W$$  

- Comments:  

The value of \\\\(h\\_{l, \\mathrm{ev}}\\\\) is given by:  
$$   h_{l, \\mathrm{ev}}=\\left\\{\\begin{array}{ll}   h_{\\mathrm{ev}}  \\text{ for } x_{\\mathrm{ev}}=0 \\\\   h_{l}^{\\mathrm{sat}}  \\text{ for } x_{\\mathrm{ev}}>0   \\end{array}\\right.$$  

### Dynamic energy balance equation for the vapor phase  

- Validity domain:  

 \\\\(\\forall \\dot{m}\\\\) and \\\\(0<V\\_{\\mathrm{v}}<V\\\\)  

- Mathematical formulation:  

$$V\\_{\\mathrm{v}} \\cdot\\left[\\left\\(\\frac{P}{\\rho\\_{\\mathrm{v}}} \\cdot\\left\\(\\frac{\\partial \\rho\\_{\\mathrm{v}}}{\\partial P}\\right\\)\\_{h}-1\\right\\) \\cdot \\frac{\\mathrm{d} P}{\\mathrm{d} t}+\\left\\(\\frac{P}{\\rho\\_{\\mathrm{v}}} \\cdot\\left\\(\\frac{\\partial \\rho\\_{\\mathrm{v}}}{\\partial h\\_{\\mathrm{v}}}\\right\\)\\_{P}+\\rho\\_{\\mathrm{v}}\\right\\) \\cdot \\frac{\\mathrm{d} h\\_{v}}{\\mathrm{d} t}\\right]$$ $$=-\\dot{m}\\_{\\mathrm{v}} \\cdot\\left\\(h\\_{\\mathrm{v}, \\mathrm{o}}-\\left\\(h\\_{\\mathrm{v}}-\\frac{P}{\\rho\\_{\\mathrm{v}}}\\right\\)\\right\\)-\\dot{m}\\_{\\mathrm{cond}} \\cdot\\left\\(h\\_{\\mathrm{v}}^{\\mathrm{sat}}-\\left\\(h\\_{\\mathrm{v}}-\\frac{P}{\\rho\\_{\\mathrm{v}}}\\right\\)\\right\\) $$ $$ +\\dot{m}\\_{\\mathrm{evap}} \\cdot\\left\\(h\\_{\\mathrm{v}}^{\\mathrm{sat}}-\\left\\(h\\_{\\mathrm{v}}-\\frac{P}{\\rho\\_{\\mathrm{v}}}\\right\\)\\right\\) +x\\_{\\mathrm{ev}} \\cdot \\dot{m}\\_{\\mathrm{ev}} \\cdot\\left\\(h\\_{\\mathrm{v}, \\mathrm{ev}}-\\left\\(h\\_{\\mathrm{v}}-\\frac{P}{\\rho\\_{\\mathrm{v}}}\\right\\)\\right\\)-W\\_{\\mathrm{vl}}-W\\_{\\mathrm{vw}}$$  

- Comments:  

The value of \\\\(h\\_{v, \\mathrm{ev}}\\\\) is given by:  

$$   h_{v, \\mathrm{ev}}=\\left\\{\\begin{array}{ll}   h_{\\mathrm{ev}} \\text{ for } x_{\\mathrm{ev}}=1 \\\\    h_{v}^{\\mathrm{sat}} \\text{ for } x_{\\mathrm{ev}}<1\\end{array}\\right.$$  

### Energy accumulation in the wall  


- Validity domain:   
   
 \\\\(\\forall T\\_{\\mathrm{w}}\\\\)  

- Mathematical formulation:   
   
 $$M\\_{\\mathrm{w}} \\cdot c\\_{\\mathrm{p}, \\mathrm{w}} \\cdot \\frac{\\mathrm{d} T\\_{\\mathrm{w}}}{\\mathrm{d} t}=W\\_{\\mathrm{lw}}+W\\_{\\mathrm{vw}}+W\\_{\\mathrm{aw}}$$  


### Power exchanged between the vapor and liquid phases  


    
    

- Validity domain:   
   
 \\\\(\\forall T\\_{\\mathrm{v}}\\\\) and \\\\(\\forall T\\_{l}\\\\)  

- Mathematical formulation:   
   
 $$W\\_{\\mathrm{vl}}=K\\_{\\mathrm{vl}} \\cdot A\\_{\\mathrm{vl}} \\cdot\\left\\(T\\_{\\mathrm{v}}-T\\_{l}\\right\\)$$  


### Power exchanged between the liquid and the drum wall  


    
    

- Validity domain:   
   
 \\\\(\\forall T\\_{l}\\\\) and \\\\(\\forall T\\_{\\mathrm{w}}\\\\)  

- Mathematical formulation:   
   
 $$W\\_{\\mathrm{lw}}=K\\_{\\mathrm{lw}} \\cdot A\\_{\\mathrm{lw}} \\cdot\\left\\(T\\_{l}-T\\_{\\mathrm{w}}\\right\\)$$  


### Power exchanged between the vapor and the drum wall  


    
    

- Validity domain:   
   
 \\\\(\\forall T\\_{\\mathrm{v}}\\\\) and \\\\(\\forall T\\_{\\mathrm{w}}\\\\)  

- Mathematical formulation:   
   
 $$W\\_{\\mathrm{vw}}=K\\_{\\mathrm{vw}} \\cdot A\\_{\\mathrm{vw}} \\cdot\\left\\(T\\_{\\mathrm{v}}-T\\_{\\mathrm{w}}\\right\\)$$  


### Power exchanged between the ambient and the drum wall  


    
    

- Validity domain:   
   
 \\\\(\\forall T\\_{\\mathrm{a}}\\\\) and \\\\(\\forall T\\_{\\mathrm{w}}\\\\)  

- Mathematical formulation:   
   
 $$W\\_{\\mathrm{aw}}=K\\_{\\mathrm{aw}} \\cdot A\\_{\\mathrm{aw}} \\cdot\\left\\(T\\_{\\mathrm{a}}-T\\_{\\mathrm{w}}\\right\\)$$  


### Condensation mass flow rate  


    
    

- Validity domain:   
   
 \\\\(\\forall x\\_{\\mathrm{v}}\\\\) close to \\\\(X\\_{\\mathrm{vo}}\\\\)  

- Mathematical formulation:   
   
 $$\\dot{m}\\_{\\text {cond }}=\\max \\left\\(C\\_{\\text {cond }} \\cdot \\rho\\_{\\mathrm{v}} \\cdot V\\_{\\mathrm{v}} \\cdot\\left\\(X\\_{\\mathrm{vo}}-x\\_{\\mathrm{v}}\\right\\), 0\\right\\)$$  


### Condensation mass flow rate  


    
    

- Validity domain:   
   
 \\\\(\\forall x\\_{\\mathrm{v}}\\\\) close to \\\\(X\\_{\\mathrm{vo}}\\\\)  

- Mathematical formulation:   
   
 $$\\dot{m}\\_{\\text {cond }}=\\max \\left\\(C\\_{\\text {cond }} \\cdot \\rho\\_{\\mathrm{v}} \\cdot V\\_{\\mathrm{v}} \\cdot\\left\\(X\\_{\\mathrm{vo}}-x\\_{\\mathrm{v}}\\right\\), 0\\right\\)$$  


### Evaporation mass flow rate  


    
    

- Validity domain:   
   
 \\\\(\\forall x\\_{l}\\\\) close to \\\\(X\\_{\\mathrm{lo}}\\\\)  

- Mathematical formulation:   
   
 $$\\dot{m}\\_{\\mathrm{evap}}=\\max \\left\\(C\\_{\\text {evap }} \\cdot \\rho\\_{l} \\cdot V\\_{l} \\cdot\\left\\(x\\_{l}-X\\_{\\mathrm{lo}}\\right\\), 0\\right\\)$$  

## References   
   
El Hefni, Baligh and Bouskela, Daniel (2019). [Modeling and Simulation of Thermal Power Plants with ThermoSysPro](https://link.springer.com/book/10.1007/978-3-030-05105-1), sect. 14.2. Springer Nature Switzerland AG.  
    ", revisions = "
Authors  

Daniel Bouskela  
Baligh El Hefni   

    "));
end DynamicDrum;