within ThermoSysPro.WaterSteam.Volumes;

model Pressurizer "Pressurizer"
  parameter Units.SI.Volume V = 61.1 "Pressurizer volume";
  parameter Units.SI.Radius Rp = 1.265 "Pressurizer cross-sectional radius";
  parameter Units.SI.Area Ae = 1 "Wall surface";
  parameter Units.SI.Position Zm = 10.15 "Hauteur de la gamme de mesure niveau";
  parameter Real Yw0 = 50 "Initial water level - percent of the measure scale level (active if steady_state=false)";
  parameter Units.SI.AbsolutePressure P0 = 155e5 "Initial fluid pressure (active if steady_state=false)";
  parameter Real Ccond = 0.1 "Condensation coefficient";
  parameter Real Cevap = 0.1 "Evaporation coefficient";
  parameter Units.SI.CoefficientOfHeatTransfer Klv = 0.5e6 "Heat exchange coefficient between the liquid and gas phases";
  parameter Units.SI.CoefficientOfHeatTransfer Klp = 50000 "Heat exchange coefficient between the liquid phase and the wall";
  parameter Units.SI.CoefficientOfHeatTransfer Kvp = 25 "Heat exchange coefficient between the gas phase and the wall";
  parameter Units.SI.CoefficientOfHeatTransfer Kpa = 542 "Heat exchange coefficient between the wall and the outside";
  parameter Units.SI.Mass Mp = 117e3 "Wall mass";
  parameter Units.SI.SpecificHeatCapacity cpp = 600 "Wall specific heat";
  parameter Boolean steady_state = true "true: start from steady state - false: start from (P0, Yw0)";
  Units.SI.Area Slpin "Exchange surface between the liquid and the wall";
  Units.SI.Area Svpin "Exchange surface between the vapor and the wall";
  Real Yw(start = 50) "Liquid level as a percent of the measure scale";
  Real y(start = 0.5) "Liquid level as a proportion of the measure scale";
  Units.SI.Position Zl(start = 20) "Liquid level in the pressurizer";
  Units.SI.Volume Vl "Liquid phase volume";
  Units.SI.Volume Vv "Gas phase volume";
  Units.SI.AbsolutePressure P(start = 155.0e5) "Average fluid pressure";
  Units.SI.AbsolutePressure Pfond "Fluid pressure at the bottom of the drum";
  Units.SI.SpecificEnthalpy hl "Liquid phase specific enthalpy";
  Units.SI.SpecificEnthalpy hv "Gas phase specific enthalpy";
  Units.SI.SpecificEnthalpy hls "Liquid phase saturation specific enthalpy";
  Units.SI.SpecificEnthalpy hvs "Gas phase saturation specific enthalpy";
  Units.SI.Temperature Tl "Liquid phase temperature";
  Units.SI.Temperature Tv "Gas phase temperature";
  Units.SI.Temperature Tp(start = 617.24) "Wall temperature";
  Units.SI.Temperature Ta "External temperature";
  Units.SI.Power Wlv "Thermal power exchanged from the gas phase to the liquid phase";
  Units.SI.Power Wpl "Thermal power exchanged from the liquid phase to the wall";
  Units.SI.Power Wpv "Thermal power exchanged from the gas phase to the wall";
  Units.SI.Power Wpa "Thermal power exchanged from the outside to the wall";
  Units.SI.Power Wch "Power released by the electrical heaters";
  Units.SI.MassFlowRate Qcond "Condensation mass flow rate from the vapor phase";
  Units.SI.MassFlowRate Qevap "Evaporation mass flow rate from the liquid phase";
  Units.SI.Density rhol(start = 996) "Liquid phase density";
  Units.SI.Density rhov(start = 1.5) "Vapor phase density";
  Connectors.FluidInlet Cas "Water input" annotation(
    Placement(transformation(extent = {{-8, 92}, {8, 108}}, rotation = 0)));
  Connectors.FluidOutlet Cs "Steam output" annotation(
    Placement(transformation(extent = {{92, 90}, {108, 106}}, rotation = 0)));
  ThermoSysPro.Thermal.Connectors.ThermalPort Ca "Thermal input to the wall" annotation(
    Placement(transformation(extent = {{-100, -8}, {-80, 12}}, rotation = 0)));
  ThermoSysPro.Thermal.Connectors.ThermalPort Cc "Thermal input to the liquid" annotation(
    Placement(transformation(extent = {{-10, -42}, {10, -22}}, rotation = 0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal yLevel "Water level" annotation(
    Placement(transformation(extent = {{80, -10}, {100, 10}}, rotation = 0)));
  Connectors.FluidOutlet Cex "Water output" annotation(
    Placement(transformation(extent = {{-8, -108}, {8, -92}}, rotation = 0)));
  InstrumentationAndControl.Connectors.OutputReal Pressure "Measured pressure in the volume" annotation(
    Placement(transformation(extent = {{80, 20}, {100, 40}})));
protected
  constant Real pi = Modelica.Constants.pi "Pi";
  constant Units.SI.Acceleration g = Modelica.Constants.g_n "Gravity constant";
  parameter Units.SI.Area Ap = pi*Rp*Rp "Pressurizer cross-sectional area";
protected
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph prol;
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph prov;
  ThermoSysPro.Properties.WaterSteam.Common.PropThermoSat lsat;
  ThermoSysPro.Properties.WaterSteam.Common.PropThermoSat vsat;
initial equation
  if steady_state then
    der(P) = 0;
    der(hl) = 0;
    der(hv) = 0;
    der(y) = 0;
    der(Tp) = 0;
  else
    P = P0;
    hl = hls;
    hv = hvs;
    Yw = Yw0;
    der(Tp) = 0;
  end if;
equation
/* Unconnected connectors */
  if (cardinality(Cas) == 0) then
    Cas.Q = 0;
    Cas.h = 1.e5;
    Cas.b = true;
  end if;
  if (cardinality(Cex) == 0) then
    Cex.Q = 0;
    Cex.h = 1.e5;
    Cex.a = true;
  end if;
  if (cardinality(Cs) == 0) then
    Cs.Q = 0;
    Cs.h = 1.e5;
    Cs.a = true;
  end if;
  Cas.P = P;
  Cs.P = P;
  Cex.P = Pfond;
  Cas.h_vol = hl;
  Cs.h_vol = hv;
  Cex.h_vol = hl;
  Ca.W = Wpa;
  Ca.T = Ta;
  Cc.W = Wch;
  Cc.T = Tl;
  yLevel.signal = Yw;
  Pressure.signal = P;
/* Computation of the geometrical variables */
  Yw = 100*y;
  Zl = Zm*y + 0.5*(V/Ap - Zm);
  Vl = Ap*Zl;
  Vv = V - Vl;
  Slpin = Zl*2*pi*Rp;
  Svpin = (V/Ap - Zl)*2*pi*Rp;
/* Liquid phase mass balance equation */
  rhol*Ap*Zm*der(y) + Vl*prol.ddph*der(P) + Vl*prol.ddhp*der(hl) = Cas.Q - Cex.Q + Qcond - Qevap;
/* Gas phase mass balance equation */
  -rhov*Ap*Zm*der(y) + Vv*prov.ddph*der(P) + Vv*prov.ddhp*der(hv) = Qevap - Cs.Q - Qcond;
/* Liquid phase energy balance equation */
  rhol*Vl*der(hl) - Vl*der(P) = (Qcond + Cas.Q)*(hls - hl) - Qevap*(hvs - hl) - Cex.Q*(Cex.h - hl) - Wpl + Wlv + Wch;
/* Gas phase energy balance equation */
  rhov*Vv*der(hv) - Vv*der(P) = Qevap*(hvs - hv) - Qcond*(hls - hv) - Cas.Q*(hls - Cas.h) - Wpv - Wlv - Cs.Q*(Cs.h - hv);
/* Energy balance equation at the wall */
  Mp*cpp*der(Tp) = Wpl + Wpv + Wpa;
/* Heat exchange between liquid and gas phases */
  Wlv = Klv*Ap*(Tv - Tl);
/* Heat exchange between the liquid phase and the wall */
  Wpl = Klp*Slpin*(Tl - Tp);
/* Heat exchange between the gas phase and the wall */
  Wpv = Kvp*Svpin*(Tv - Tp);
/* Heat exchange between the wall and the outside */
  Wpa = Kpa*Ae*(Ta - Tp);
/* Pressure in the expansion line */
  Pfond = P + g*(Vl*rhol + Vv*rhov)/Ap;
/* Condensation and evaporation mass flows */
  Qevap = Cevap*rhol*Vl*(hl - hls)/(hvs - hls);
//Qcond = noEvent(Ccond*rhov*Vv*(hvs - hv)/(hvs - hls) + (Cas.Q*(hls - Cas.h)
//   + 0.5*(Wpv + abs(Wpv)) + Wlv)/(hv - hls));
  Qcond = Ccond*rhov*Vv*(hvs - hv)/(hvs - hls);
/* Fluid thermodynamic properties */
  prol = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(P, hl, 0);
  prov = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(P, hv, 0);
  (lsat, vsat) = ThermoSysPro.Properties.WaterSteam.IF97.Water_sat_P(P);
  Tl = prol.T;
  Tv = prov.T;
  rhol = prol.d;
  rhov = prov.d;
  hls = lsat.h;
  hvs = vsat.h;
  annotation(
    Icon(graphics = {Line(points = {{100, 90}, {100, 60}, {80, 60}, {80, 60}}, color = {0, 0, 255}, thickness = 1), Ellipse(extent = {{-80, -92}, {80, -42}}, lineColor = {0, 0, 255}, fillColor = {85, 170, 255}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-80, -14}, {80, -68}}, lineColor = {85, 170, 255}, fillColor = {85, 170, 255}, fillPattern = FillPattern.Solid), Ellipse(extent = {{-80, 42}, {80, 92}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Line(points = {{0, 40}, {0, 92}}, color = {0, 0, 255}, thickness = 1), Line(points = {{0, 38}, {0, 92}}, color = {255, 255, 255}), Rectangle(extent = {{-80, -14}, {80, 68}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Line(points = {{-79, 68}, {80, 68}}, color = {255, 255, 255}), Line(points = {{80, 60}, {100, 60}, {100, 90}}, color = {255, 255, 255})}),
    Diagram(graphics = {Ellipse(extent = {{-80, -92}, {80, -42}}, lineColor = {0, 0, 255}, fillColor = {85, 170, 255}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-80, -14}, {80, -68}}, lineColor = {85, 170, 255}, fillColor = {85, 170, 255}, fillPattern = FillPattern.Solid), Ellipse(extent = {{-80, 42}, {80, 92}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Line(points = {{0, 40}, {0, 92}}, color = {0, 0, 255}, thickness = 1), Line(points = {{0, 38}, {0, 92}}, color = {255, 255, 255}), Rectangle(extent = {{-80, -14}, {80, 68}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Line(points = {{-79, 68}, {80, 68}}, color = {255, 255, 255}), Text(extent = {{122, 8}, {122, -6}}, lineColor = {0, 0, 255}, textString = "Level"), Line(points = {{100, 90}, {100, 60}, {80, 60}, {80, 60}}, color = {0, 0, 255}, thickness = 1), Line(points = {{80, 60}, {100, 60}, {100, 90}}, color = {255, 255, 255}), Text(extent = {{106, 42}, {148, 20}}, textColor = {0, 0, 255}, textString = "Pressure")}),
    Documentation(info = "
## Copyright © EDF 2002 - 2026   
## ThermoSysPro Version 4.2  
This component model is documented in Sect. 14.3 of the ThermoSysPro book.   
# Pressurizer   
   
The pressurizer is used in water reactors to control the pressure inside the primary system, so that the reactor coolant remains always liquid.  
The pressure of the two-phase fluid inside the pressurizer is controlled by the temperature.  
To that end, the pressurizer is equipped with electric heating rods at the bottom, and cooling spray tubes at the top .  
It is also equipped with several safety valves.  

Following assumptions are made:  
- the pressurizer is always operating in two-phase conditions.  
- pressure losses are neglected.  
- the liquid and steam phases are not necessarily in thermal equilibrium, but always in pressure equilibrium.  


## Modelica component model  

The equations mentioned below are implemented in the component *Pressurizer*, located in the *WaterSteam.Volumes* sub-library.   
This component has 6 connectors:  
- Cas: water inlet,  
- Cs: steam outlet,  
- Ca: thermal input to the wall,  
- Cc: thermal input to the liquid,  
- Cex: water outlet,  
- yLevel: water level output.  
   
![modelica://ThermoSysPro/UsersGuide/Documentation/ThermoSysPro.WaterSteam.Volumes.Pressurizer.svg](modelica://ThermoSysPro/UsersGuide/Documentation/ThermoSysPro.WaterSteam.Volumes.Pressurizer.svg)  

## Nomenclature  

| Symbol| Description| Unit| Definition| Modelica name |  
| :-------------------------------- | :--------------------------------------------------------------------------------------- | :------------------------------------------- | :----------------------------------------------------------------------------------------------------------- | :----------- |  
| \\\\(A\\_{\\mathrm{e}}\\\\)| External pressurizer surface| \\\\(\\mathrm{m}^{2}\\\\)|| Ae |  
| \\\\(A\\_{\\mathrm{lw}}\\\\)| Heat exchange surface between the liquid phase and the wall| \\\\(\\mathrm{m}^{2}\\\\)| \\\\(2 \\cdot \\pi \\cdot R \\cdot z\\_{l}\\\\)| Slpin |  
| \\\\(A\\_{\\mathrm{p}}\\\\)| Pressurizer cross-sectional area| \\\\(\\mathrm{m}^{2}\\\\)| \\\\(\\pi \\cdot \\mathrm{R}^{2}\\\\)| Ap |  
| \\\\(A\\_{\\mathrm{vw}}\\\\)| Heat exchange surface between the steam phase and the wall| \\\\(\\mathrm{m}^{2}\\\\)| \\\\(2 \\cdot \\pi \\cdot R \\cdot\\left\\(\\frac{\\mathrm{V}}{\\mathrm{A}\\_{\\mathrm{p}}}-\\mathrm{z}\\_{l}\\right\\)\\\\)| Svpin |  
| \\\\(c\\_{\\mathrm{p}, \\mathrm{w}}\\\\)| Specific heat capacity of the wall| \\\\(\\mathrm{J} / \\mathrm{kg} / \\mathrm{K}\\\\)|| cpp |  
| \\\\(C\\_{\\text {cond }}\\\\)| Condensation rate| \\\\(\\mathrm{s}^{-1}\\\\)|| Ccond |  
| \\\\(C\\_{\\text {evap }}\\\\)| Evaporation rate| \\\\(\\mathrm{s}^{-1}\\\\)|| Cevap |  
| \\\\(g\\\\)| Acceleration due to gravity| \\\\(\\mathrm{m} / \\mathrm{s}^{2}\\\\)|| g |  
| \\\\(h\\_{l}\\\\)| Specific enthalpy of the liquid phase in the pressurizer| \\\\(\\mathrm{J} / \\mathrm{kg}\\\\)|| hl |  
| \\\\(h\\_{l, \\mathrm{i}}\\\\)| Specific enthalpy of the liquid at the inlet of the pressurizer| \\\\(\\mathrm{J} / \\mathrm{kg}\\\\)|| Cas.h |  
| \\\\(h\\_{l,0}\\\\)| Specific enthalpy of the liquid at the outlet of the pressurizer| \\\\(\\mathrm{J} / \\mathrm{kg}\\\\)|| Cex.h |  
| \\\\(h\\_{l}^{\\text {sat }}\\\\)| Saturation enthalpy of the liquid in the pressurizer| \\\\(\\mathrm{J} / \\mathrm{kg}\\\\)|| hls |  
| \\\\(h\\_{\\mathrm{v}}\\\\)| Specific enthalpy of the steam phase in the pressurizer| \\\\(\\mathrm{J} / \\mathrm{kg}\\\\)|| hv |  
| \\\\(h\\_{\\mathrm{v}, \\mathrm{o}}\\\\)| Specific enthalpy of the steam at the outlet of the pressurizer| \\\\(\\mathrm{J} / \\mathrm{kg}\\\\)|| Cs.h |  
| \\\\(h\\_{\\mathrm{v}}^{\\mathrm{sat}}\\\\) | Saturation enthalpy of the steam in the pressurizer| \\\\(\\mathrm{J} / \\mathrm{kg}\\\\)|| hvs |  
| \\\\(K\\_{\\mathrm{lw}}\\\\)| Convective heat exchange coefficient between the liquid and the wall of the pressurizer| \\\\(\\mathrm{W} / \\mathrm{m}^{2} / \\mathrm{K}\\\\) || Klp |  
| \\\\(K\\_{\\mathrm{vl}}\\\\)| Convective heat exchange coefficient between the liquid and the steam in the pressurizer | \\\\(\\mathrm{W} / \\mathrm{m}^{2} / \\mathrm{K}\\\\) || Klv |  
| \\\\(K\\_{\\mathrm{vw}}\\\\)| Convective heat exchange coefficient between the steam and the wall of the pressurizer| \\\\(\\mathrm{W} / \\mathrm{m}^{2} / \\mathrm{K}\\\\) || Kvp |  
| \\\\(K\\_{\\mathrm{wa}}\\\\)| Convective heat exchange coefficient between the wall of the pressurizer and the ambient | \\\\(\\mathrm{W} / \\mathrm{m}^{2} / \\mathrm{K}\\\\) || Kpa |  
| \\\\(\\dot{m}\\_{\\text {evap }}\\\\)| Evaporation mass flow rate inside the pressurizer| \\\\(\\mathrm{kg} / \\mathrm{s}\\\\)|| Qevap |  
| \\\\(\\dot{m}\\_{l, \\mathrm{i}}\\\\)| Mass flow rate of the liquid at the inlet of the pressurizer| \\\\(\\mathrm{kg} / \\mathrm{s}\\\\)|| Cas.Q |  
| \\\\(\\dot{m}\\_{l, \\mathrm{o}}\\\\)| Mass flow rate of the liquid at the outlet of the pressurizer| \\\\(\\mathrm{kg} / \\mathrm{s}\\\\)|| Cex.Q |  
| \\\\(\\dot{m}\\_{\\mathrm{v}}\\\\)| Mass flow rate of the steam at the outlet of the pressurizer| \\\\(\\mathrm{kg} / \\mathrm{s}\\\\)|| Cs.Q |  
| \\\\(M\\_{\\mathrm{w}}\\\\)| Mass of the wall of the pressurizer| \\\\(\\mathrm{kg}\\\\)|| Mp |  
| \\\\(P\\\\)| Pressure inside the pressurizer| \\\\(\\mathrm{Pa}\\\\)|| P |  
| \\\\(P\\_{\\mathrm{b}}\\\\)| Fluid pressure at the bottom of the pressurizer| \\\\(\\mathrm{Pa}\\\\)| \\\\(P+\\frac{g}{A\\_{\\mathrm{p}}} \\cdot\\left\\(\\rho\\_{l} \\cdot V\\_{l}+\\rho\\_{\\mathrm{v}} \\cdot V\\_{\\mathrm{v}}\\right\\)\\\\) | Pfond |  
| \\\\(R\\\\)| Pressurizer cross-sectional radius| \\\\(\\mathrm{m}\\\\)|| Rp |  
| \\\\(T\\_{\\mathrm{a}}\\\\)| Ambient temperature| \\\\(\\mathrm{K}\\\\)|| Ta |  
| \\\\(T\\_{l}\\\\)| Liquid temperature in the pressurizer| \\\\(\\mathrm{K}\\\\)|| Tl |  
| \\\\(T\\_{\\mathrm{v}}\\\\)| Steam temperature in the pressurizer| \\\\(\\mathrm{K}\\\\)|| Tv |  
| \\\\(T\\_{\\mathrm{w}}\\\\)| Wall temperature of the pressurizer| \\\\(\\mathrm{K}\\\\)|| Tp |  
| \\\\(V\\\\)| Pressurizer volume| \\\\(\\mathrm{m}^{3}\\\\)|| V |  
| \\\\(V\\_{l}\\\\)| Volume of the liquid in the pressurizer| \\\\(\\mathrm{m}^{3}\\\\)| \\\\(A\\_{p} \\cdot z\\_{l}\\\\)| Vl |  
| \\\\(V\\_{\\mathrm{v}}\\\\)| Volume of the steam in the pressurizer| \\\\(\\mathrm{m}^{3}\\\\)| \\\\(V-V\\_{l}\\\\)| Vv |  
| \\\\(W\\_{\\text {eh }}\\\\)| Power released by the electrical heaters| \\\\(\\mathrm{W}\\\\)|| Wch |  
| \\\\(W\\_{\\mathrm{lw}}\\\\)| Power exchanged from the liquid to the pressurizer wall| \\\\(\\mathrm{W}\\\\)|| Wpl |  
| \\\\(W\\_{\\mathrm{vl}}\\\\)| Power exchanged from the steam to the liquid| \\\\(\\mathrm{W}\\\\)|| Wlv |  
| \\\\(W\\_{\\mathrm{vw}}\\\\)| Power exchanged from the steam to the pressurizer wall| \\\\(\\mathrm{W}\\\\)|| Wpv |  
| \\\\(W\\_{\\mathrm{wa}}\\\\)| Power exchanged from the pressurizer wall to the ambient| \\\\(\\mathrm{W}\\\\)|| Wpa |  
| \\\\(y\\\\)| Liquid level expressed as a percent of the scale of level measure| \\\\(\\%\\\\)| \\\\(0 \\leq y \\leq 1\\\\)| y |  
| \\\\(z\\_{l}\\\\)| Liquid level inside the pressurizer for the controller: water level + margin| \\\\(\\mathrm{m}\\\\)| \\\\(z\\_{\\mathrm{m}} \\cdot y+\\frac{\\frac{V}{A\\_{\\mathrm{p}}}-z\\_{\\mathrm{m}}}{2}\\\\)| Zl |  
| \\\\(z\\_{\\mathrm{m}}\\\\)| Scale of level measure| \\\\(\\mathrm{m}\\\\)|| Zm |  
| \\\\(\\rho\\_{l}\\\\)| Density of the liquid inside the pressurizer| \\\\(\\mathrm{kg} / \\mathrm{m}^{3}\\\\)|| rhol |  
| \\\\(\\rho\\_{\\mathrm{v}}\\\\)| Density of the steam inside the pressurizer| \\\\(\\mathrm{kg} / \\mathrm{m}^{3}\\\\)|| rhov |  


## Governing equations  

### Dynamic mass balance equation for the liquid phase  


    
    

- Validity domain:   
   
 \\\\(\\forall \\dot{m}\\\\) and \\\\(0<V\\_{l}<V\\\\)  

- Mathematical formulation:   
   
 $$\\rho\\_{l} \\cdot \\frac{\\mathrm{d} V\\_{l}}{\\mathrm{d} t}+V\\_{l}\\left[\\left\\(\\frac{\\partial \\rho\\_{l}}{\\partial P}\\right\\)\\_{h} \\cdot \\frac{\\mathrm{d} P}{\\mathrm{d} t}+\\left\\(\\frac{\\partial \\rho\\_{l}}{\\partial h}\\right\\)\\_{P} \\cdot \\frac{\\mathrm{d} h\\_{l}}{\\mathrm{d} t}\\right]=\\dot{m}\\_{l, \\mathrm{i}}-\\dot{m}\\_{l, \\mathrm{o}}+\\dot{m}\\_{\\mathrm{cond}}-\\dot{m}\\_{\\mathrm{evap}}$$  




### Dynamic mass balance equation for the steam phase   


    
    

- Validity domain:   
   
 \\\\(\\forall \\dot{m}\\\\) and \\\\(0<V\\_{v}<V\\\\)  


- Mathematical formulation:  

$$\\rho\\_{v} \\cdot \\frac{d V\\_{v}}{d t}+V\\_{v} \\cdot\\left[\\left\\(\\frac{\\partial \\rho\\_{v}}{\\partial P}\\right\\)\\_{h} \\cdot \\frac{d P}{d t}+\\left\\(\\frac{\\partial \\rho\\_{v}}{\\partial h}\\right\\)\\_{P} \\cdot \\frac{d h\\_{v}}{d t}\\right] =\\dot{m}\\_{\\text {evap}}-\\dot{m}\\_{v}-\\dot{m}\\_{\\text {cond}}$$  

### Dynamic energy balance equation for the liquid phase  


    
    

- Validity domain:   
   
 \\\\(\\forall \\dot{m}\\\\) and \\\\(0<V\\_{l}<V\\\\)  

- Mathematical formulation:   
   
 ```eval_rst  
 .. math::  
   V_{l} \\cdot\\left(\\rho_{l} \\cdot \\frac{\\mathrm{d} h_{l}}{\\mathrm{d} t}-\\frac{\\mathrm{d} P}{\\mathrm{d} t}\\right)   
   & =\\left(\\dot{m}_{l, \\mathrm{i}}+\\dot{m}_{\\mathrm{cond}}\\right) \\cdot\\left(h_{l}^{\\mathrm{sat}}-h_{l}\\right) \\\\ &  
   -\\dot{m}_{\\mathrm{evap}} \\cdot\\left(h_{\\mathrm{v}}^{\\mathrm{sat}}-h_{l}\\right) \\\\  
   & -\\dot{m}_{l, \\mathrm{o}} \\cdot\\left(h_{l, \\mathrm{o}}-h_{l}\\right) \\\\ & +W_{\\mathrm{vl}}-W_{\\mathrm{lw}}+W_{\\mathrm{eh}}  
```  
- Comments:   
   
 The term \\\\(\\dot{m}\\_{l \\mathrm{i}, \\mathrm{i}} \\cdot\\left\\(h\\_{l}^{\\text {sat }}-h\\_{l}\\right\\)\\\\) accounts for the fact that the spray is first heated to saturated liquid by contact with the steam inside the pressurizer. The saturated liquid is then mixed with the liquid inside the pressurizer.  


### Dynamic energy balance equation for the steam phase  


    
    

- Validity domain:   
   
 \\\\(\\forall \\dot{m}\\\\) and \\\\(0<V\\_{\\mathrm{v}}<V\\\\)  

- Mathematical formulation:   
   
$$   V_{\\mathrm{v}} \\cdot\\left(\\rho_{\\mathrm{v}} \\cdot \\frac{\\mathrm{d} h_{\\mathrm{v}}}{\\mathrm{d} t}-\\frac{\\mathrm{d} P}{\\mathrm{d} t}\\right)  =\\dot{m}_{\\text{evap }} \\cdot\\left(h_{\\mathrm{v}}^{\\text{sat }}-h_{\\mathrm{v}}\\right) \\\\    -\\dot{m}_{\\text{cond }} \\cdot\\left(h_{l}^{\\text{sat }}-h_{\\mathrm{v}}\\right) \\\\    -\\dot{m}_{l, \\mathrm{i}} \\cdot\\left(h_{l}^{\\text{sat }}-h_{l, \\mathrm{i}}\\right) \\\\    -\\dot{m}_{\\mathrm{v}} \\cdot\\left(h_{\\mathrm{v}, \\mathrm{o}}-h_{\\mathrm{v}}\\right)-W_{\\mathrm{v} }-W_{\\mathrm{vw}}$$  

- Comments:   
   
 The term \\\\(\\dot{m}\\_{l, \\mathrm{i}} \\cdot\\left\\(h\\_{l}^{\\text {sat }}-h\\_{l, \\mathrm{i}}\\right\\)\\\\) accounts for the fact that the spray extracts heat from the steam inside the pressurizer and turns to saturated liquid.  


### Energy accumulation in the wall  


    
    

- Validity domain:   
   
 \\\\(\\forall T\\_{\\mathrm{w}}\\\\)  

- Mathematical formulation:   
   
 $$M\\_{\\mathrm{w}} \\cdot c\\_{\\mathrm{p}, \\mathrm{w}} \\cdot \\frac{\\mathrm{d} T\\_{\\mathrm{w}}}{\\mathrm{d} t}=W\\_{\\mathrm{lw}}+W\\_{\\mathrm{vw}}+W\\_{\\mathrm{aw}}$$  


### Power exchange between the steam phase and the liquid phase  


    
    

- Validity domain:   
   
 \\\\(\\forall T\\_{\\mathrm{v}}\\\\) and \\\\(\\forall T\\_{l}\\\\)  

- Mathematical formulation:   
   
 $$W\\_{\\mathrm{vl}}=K\\_{\\mathrm{vl}} \\cdot A\\_{\\mathrm{p}} \\cdot\\left\\(T\\_{\\mathrm{v}}-T\\_{l}\\right\\)$$  


### Power exchange between the liquid and the pressurizer wall  


    
    

- Validity domain:   
   
 \\\\(\\forall T\\_{l}\\\\) and \\\\(\\forall T\\_{\\mathrm{w}}\\\\)  

- Mathematical formulation:   
   
 $$W\\_{\\mathrm{lw}}=K\\_{\\mathrm{lw}} \\cdot A\\_{l} \\cdot\\left\\(T\\_{l}-T\\_{\\mathrm{w}}\\right\\)$$   


### Power exchange between the steam and the pressurizer wall  


    
    

- Validity domain:   
   
 \\\\(\\forall T\\_{\\mathrm{v}}\\\\) and \\\\(\\forall T\\_{\\mathrm{w}}\\\\)  

- Mathematical formulation:   
   
 $$W\\_{\\mathrm{vw}}=K\\_{\\mathrm{vw}} \\cdot A\\_{\\mathrm{v}} \\cdot\\left\\(T\\_{\\mathrm{v}}-T\\_{\\mathrm{w}}\\right\\)$$  


### Power exchange between the pressurizer wall and the ambient  


    
    

- Validity domain:   
   
 \\\\(\\forall T\\_{\\mathrm{w}}\\\\) and \\\\(\\forall T\\_{\\mathrm{a}}\\\\)  

- Mathematical formulation:   
   
$$W\\_{\\mathrm{wa}}=K\\_{\\mathrm{wa}} \\cdot A\\_{\\mathrm{e}} \\cdot\\left\\(T\\_{\\mathrm{w}}-T\\_{\\mathrm{a}}\\right\\)$$  


### Condensation mass flow rate  


    
    

- Mathematical formulation:   
   
 $$\\dot{m}\\_{\\text {cond }}=C\\_{\\text {cond }} \\cdot \\rho\\_{\\mathrm{v}} \\cdot V\\_{\\mathrm{v}} \\cdot \\frac{h\\_{\\mathrm{v}}^{\\mathrm{sat}}-h\\_{\\mathrm{v}}}{h\\_{\\mathrm{v}}^{\\mathrm{sat}}-h\\_{l}^{\\mathrm{sat}}}$$  


### Evaporation mass flow rate  


    
    

- Mathematical formulation:   
   
 $$\\dot{m}\\_{\\text {evap }}=C\\_{\\text {evap }} \\cdot \\rho\\_{l} \\cdot V\\_{l} \\cdot \\frac{h\\_{l}-h\\_{l}^{\\text {sat }}}{h\\_{v}^{\\text {sat }}-h\\_{l}^{\\text {sat }}}$$   

## References   
   
El Hefni, Baligh and Bouskela, Daniel (2019). [Modeling and Simulation of Thermal Power Plants with ThermoSysPro](https://link.springer.com/book/10.1007/978-3-030-05105-1), sect. 14.3. Springer Nature Switzerland AG.  
    ", revisions = "
Authors  

Daniel Bouskela  
Baligh El Hefni   

    "));
end Pressurizer;