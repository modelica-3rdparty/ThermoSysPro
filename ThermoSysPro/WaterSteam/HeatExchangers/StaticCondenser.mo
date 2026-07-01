within ThermoSysPro.WaterSteam.HeatExchangers;

model StaticCondenser "Static condenser"
  parameter Units.SI.Area SCO = 10000 "Heat exchange surface";
  parameter Real CPCE = 0.02 "Pressure loss coefficient for the water side (Pa.s²/(kg.m**3))";
  parameter Units.SI.Height z = 0.5 "Water level in the condenser";
  parameter Units.SI.CoefficientOfHeatTransfer KCO = 1 "Reference heat exchange coefficient";
  parameter Units.SI.MassFlowRate QC0 = 100 "Reference mass flow rate";
  parameter Units.SI.Temperature Tref = 293 "Reference temperature";
  parameter Real COPR = 1 "Reference fouling coefficient";
  parameter Real COP = 1 "Actual fouling coefficient";
  parameter Boolean continuous_flow_reversal = false "true: continuous flow reversal - false: discontinuous flow reversal";
  parameter Integer mode_ee = 1 "IF97 region at the water inlet. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  parameter Integer mode_se = 1 "IF97 region at the water outlet. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  parameter Integer mode_ex = 0 "IF97 region at the extraction point. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  Units.SI.MassFlowRate Qee(start = 10) "Cooling water mass flow rate at the inlet";
  Units.SI.SpecificEnthalpy Hee(start = 250000) "Cooling water specific anthalpy at the inlet";
  Units.SI.AbsolutePressure Pee(start = 1.e5) "Cooling water pressure at the inlet";
  Units.SI.MassFlowRate Qep(start = 10) "Drain mass flow rate at the inlet";
  Units.SI.SpecificEnthalpy Hep(start = 1000000) "Drain specific enthalpy at the inlet";
  Units.SI.MassFlowRate Qev(start = 10) "Vapor mass flow rate at the inlet";
  Units.SI.SpecificEnthalpy Hev(start = 2500000) "Vapor specific enthalpy at the inlet";
  Units.SI.MassFlowRate Qvt(start = 10) "Vapor mass flow rate leaving the turbine";
  Units.SI.SpecificEnthalpy Hvt(start = 2500000) "Vapor specific enthalpy leaving the turbine";
  Units.SI.MassFlowRate Qse(start = 10) "Cooling water mass flow rate at the outlet";
  Units.SI.SpecificEnthalpy Hse(start = 500000) "Cooling water specific enthalpy at the outlet";
  Units.SI.AbsolutePressure Pse(start = 1.e5) "Cooling water pressure at the outlet";
  Units.SI.MassFlowRate Qex(start = 10) "Drain mass flow rate at the outlet";
  Units.SI.SpecificEnthalpy Hex(start = 500000) "Drain specific enthalpy at the outlet";
  Units.SI.AbsolutePressure Pex(start = 1.e5) "Drain pressure at the outlet";
  Units.SI.SpecificEnthalpy Hsate(start = 200000) "Water specific enthalpy at the saturation point";
  Units.SI.AbsolutePressure Pcond(start = 17000) "Vapor pressure inside the condenser";
  Units.SI.Temperature Tsat(start = 500) "Water temperature at the saturation point";
  Units.SI.Temperature Tee(start = 300) "Cooling water temperature at the inlet";
  Units.SI.Temperature Tse(start = 400) "Cooling water temperature at the outlet";
  Units.SI.Density rho_ee(start = 900) "Cooling water density at the inlet";
  Units.SI.Density rho_ex(start = 900) "Water density at the extraction point";
  Units.SI.CoefficientOfHeatTransfer KT1(start = 50) "First reference value for the exchange coefficient";
  Units.SI.CoefficientOfHeatTransfer KT2(start = 50) "Second reference value for the exchange coefficient";
  Units.SI.CoefficientOfHeatTransfer XKCO(start = 200) "Heat transfer coefficient";
  Units.SI.SpecificEnthalpy Hmv(start = 2500000) "Fluid input average specific enthalpy";
  Units.SI.SpecificEnthalpy Hml(start = 250000) "Extraction water average specific enthalpy";
  Units.SI.Power W "Heat power released to the cold source";
  ThermoSysPro.WaterSteam.Connectors.FluidInlet Cee "Cooling water inlet" annotation(
    Placement(transformation(extent = {{-112, -72}, {-88, -50}}, rotation = 0)));
  ThermoSysPro.WaterSteam.Connectors.FluidOutlet Cse "Cooling water outlet" annotation(
    Placement(transformation(extent = {{90, -72}, {114, -50}}, rotation = 0)));
  ThermoSysPro.WaterSteam.Connectors.FluidOutlet Cex "Extraction water" annotation(
    Placement(transformation(extent = {{-12, -114}, {14, -90}}, rotation = 0)));
  ThermoSysPro.WaterSteam.Connectors.FluidInlet Cvt "Turbine outlet" annotation(
    Placement(transformation(extent = {{-13, 88}, {13, 114}}, rotation = 0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph proex "Propriétés de l'eau" annotation(
    Placement(transformation(extent = {{60, 80}, {80, 100}}, rotation = 0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph proee "Propriétés de l'eau" annotation(
    Placement(transformation(extent = {{20, 80}, {40, 100}}, rotation = 0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph prose "Propriétés de l'eau" annotation(
    Placement(transformation(extent = {{80, -100}, {100, -80}}, rotation = 0)));
  ThermoSysPro.Properties.WaterSteam.Common.PropThermoSat lsat1 annotation(
    Placement(transformation(extent = {{-100, 80}, {-80, 100}}, rotation = 0)));
  ThermoSysPro.Properties.WaterSteam.Common.PropThermoSat vsat1 annotation(
    Placement(transformation(extent = {{-60, 80}, {-40, 100}}, rotation = 0)));
  ThermoSysPro.WaterSteam.Connectors.FluidInlet Cep "Drain inlet" annotation(
    Placement(transformation(extent = {{-112, 8}, {-88, 30}}, rotation = 0)));
  ThermoSysPro.WaterSteam.Connectors.FluidInlet Cev "Vapor inlet" annotation(
    Placement(transformation(extent = {{-112, 50}, {-88, 72}}, rotation = 0)));
protected
  constant Units.SI.Acceleration g = Modelica.Constants.g_n "Gravity constant";
  constant Real pi = Modelica.Constants.pi "pi";
  parameter Real eps = 1.e-0 "Small number for pressure loss equation";
  parameter Units.SI.MassFlowRate Qeps = 1.e-3 "Small mass flow rate for continuous flow reversal";
equation
/* Unconnected connectors */
  if (cardinality(Cev) == 0) then
    Cev.Q = 0;
    Cev.h = 1.e5;
    Cev.b = true;
  end if;
  if (cardinality(Cep) == 0) then
    Cep.Q = 0;
    Cep.h = 1.e5;
    Cep.b = true;
  end if;
  Qep = Cep.Q;
  Hep = Cep.h;
  Qev = Cev.Q;
  Hev = Cev.h;
  Qvt = Cvt.Q;
  Hvt = Cvt.h;
  Qee = Cee.Q;
  Hee = Cee.h;
  Pee = Cee.P;
  Qse = Cse.Q;
  Hse = Cse.h;
  Pse = Cse.P;
  Qex = Cex.Q;
  Pex = Cex.P;
// Cooling pipe
//-------------
/* Flow reversal for the cooling water pipe */
  if continuous_flow_reversal then
    0 = noEvent(if (Qee > Qeps) then Cee.h - Cee.h_vol else if (Qee < -Qeps) then Cse.h - Cse.h_vol else Cee.h - 0.5*((Cee.h_vol - Cse.h_vol)*Modelica.Math.sin(pi*Qee/2/Qeps) + Cee.h_vol + Cse.h_vol));
  else
    0 = if (Qee > 0) then Cee.h - Cee.h_vol else Cse.h - Cse.h_vol;
  end if;
/* Mass balance equation for the water pipe */
  Qee = Qse;
/* Pressure loss equation in the water pipe */
  Pse = noEvent(if (rho_ee > 0) then Pee - (CPCE*ThermoSysPro.Functions.ThermoSquare(Qee, eps)/rho_ee) else Pee);
/* Heating power released to the cooling pipe */
  W = Qee*(Hse - Hee);
// Water/steam cavity
//-------------------
/* Fluid pressure */
  Pcond = Cep.P;
  Pcond = Cev.P;
  Pcond = Cvt.P;
/* Extraction water pressure */
  Pex = Pcond + rho_ex*g*z;
/* Fluid specific enthalpy (singular if all flows = 0) */
  Hmv = Cvt.h_vol;
  Hmv = Cep.h_vol;
  Hmv = Cev.h_vol;
  Hex = Cex.h_vol;
/* Mass balance equation */
  Qex = Qvt + Qep + Qev;
/* Energy balance equations */
/* Input heating power */
  W = Qvt*(Hvt - Hsate) + Qep*(Hep - Hsate) + Qev*(Hev - Hsate);
/* Fluid input average specific enthalpy */
  Hmv = (Hvt*Qvt + Hev*Qev + Hep*Qep)/Qex;
/* Extraction water average specific enthalpy */
  Hml = (Hsate + Hex)/2;
/* Extraction water specific enthalpy */
  Hex = noEvent(if (rho_ex > 0) then Hsate + ((Pex - Pcond)/rho_ex) else Hsate);
/* First reference value for the exchange coefficient */
  KT1 = -0.05*(Tref - 273.16)^2 + 3.3*(Tref - 273.16) + 52;
/* Second reference value for the exchange coefficient */
  KT2 = -0.05*(Tee - 273.16)^2 + 3.3*(Tee - 273.16) + 52;
/* Heat exchange coefficient */
  XKCO = KCO*(COP/COPR)*(KT2/KT1)*ThermoSysPro.Functions.ThermoRoot(Qee/QC0, Modelica.Constants.eps);
/* Fluid saturation teperature */
  0 = Tsat - Tse - (Tsat - Tee)*exp(XKCO*SCO*((Tee - Tse)/W));
/* Fluid thermodynamic properties */
  proee = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Pee, Hee, mode_ee);
  proex = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Pex, Hex, mode_ex);
  prose = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Pse, Hse, mode_se);
  rho_ee = proee.d;
  rho_ex = proex.d;
  Tee = proee.T;
  Tse = prose.T;
/* Vapor pressure inside the condenser */
  Pcond = ThermoSysPro.Properties.WaterSteam.BaseIF97.Basic.psat(Tsat);
/* Fluid thermodynamic properties at the saturation point*/
  (lsat1, vsat1) = ThermoSysPro.Properties.WaterSteam.IF97.Water_sat_P(Pcond);
  Hsate = lsat1.h;
  annotation(
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics = {Polygon(points = {{100, -82}, {100, 80}, {-100, 80}, {-100, -82}, {100, -82}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid), Text(extent = {{-22, 88}, {20, 70}}, lineColor = {0, 0, 0}, lineThickness = 1, fillPattern = FillPattern.Sphere, fillColor = {191, 0, 0}, textString = "Turbine outlet"), Text(extent = {{-82, 24}, {-52, 16}}, lineColor = {0, 0, 0}, lineThickness = 1, fillPattern = FillPattern.Sphere, fillColor = {191, 0, 0}, textString = "Drain inlet"), Text(extent = {{-24, -52}, {26, -72}}, lineColor = {0, 0, 0}, lineThickness = 1, fillPattern = FillPattern.Sphere, fillColor = {191, 0, 0}, textString = "Extraction water"), Text(extent = {{38, -58}, {86, -66}}, lineColor = {0, 0, 0}, lineThickness = 1, fillPattern = FillPattern.Sphere, fillColor = {191, 0, 0}, textString = "Cooling water outlet"), Text(extent = {{-86, -52}, {-32, -74}}, lineColor = {0, 0, 0}, lineThickness = 1, fillPattern = FillPattern.Sphere, fillColor = {191, 0, 0}, textString = "Cooling water inlet"), Text(extent = {{-86, 66}, {-50, 54}}, lineColor = {0, 0, 0}, lineThickness = 1, fillPattern = FillPattern.Sphere, fillColor = {191, 0, 0}, textString = "Vapor inlet"), Line(points = {{0, 8}, {0, -70}}, color = {0, 0, 0}, thickness = 1), Polygon(points = {{0, -90}, {-11, -70}, {11, -70}, {0, -90}}, lineColor = {0, 0, 0}, lineThickness = 0.5, fillPattern = FillPattern.Sphere, fillColor = {191, 0, 0}), Line(points = {{-100, 8}, {100, 8}}, color = {0, 0, 255}, thickness = 0.5), Line(points = {{-100, -14}, {80, -14}, {80, -20}, {-90, -20}, {-90, -26}, {80, -26}, {80, -32}, {-90, -32}, {-90, -38}, {100, -38}}, color = {0, 0, 255}, thickness = 0.5)}),
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics = {Polygon(points = {{100, -86}, {100, 80}, {-100, 80}, {-100, -86}, {100, -86}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid), Line(points = {{-100, -14}, {80, -14}, {80, -20}, {-90, -20}, {-90, -26}, {80, -26}, {80, -32}, {-90, -32}, {-90, -38}, {100, -38}}, color = {0, 0, 255}, thickness = 0.5), Polygon(points = {{0, -90}, {-11, -70}, {11, -70}, {0, -90}}, lineColor = {0, 0, 0}, lineThickness = 0.5, fillPattern = FillPattern.Sphere, fillColor = {191, 0, 0}), Line(points = {{0, 8}, {0, -70}}, color = {0, 0, 0}, thickness = 1), Line(points = {{-100, 8}, {100, 8}}, color = {0, 0, 255}, thickness = 0.5)}),
    Window(x = 0.09, y = 0.08, width = 0.76, height = 0.76),
    Documentation(info = "
## Copyright © EDF 2002 - 2026   
## ThermoSysPro Version 4.2  
This component model is documented in Sect. 9.7.1 of the ThermoSysPro book.   
# Static condenser   

This condenser is a large shell-and-tube heat exchanger. It is composed of a bundle of circular tubes mounted in a cavity. The steam in the cavity condensates due to the cooling water flow in the tube bundle. The condenser is positioned at the outlet of the steam turbine in order to receive a large flow rate of low-pressure steam. The steam condensation heat is evacuated by external cooling water pumped through the condenser tube bundle. The condensate at the outlet is pumped and sent into feed water heaters.  

Following assumptions are made in the model:  
- the efficiency of the condenser is equal to 1 (all the steam is condensed).  
- the energy accumulation in the wall is neglected.  
- the hot fluid is assumed to stay at saturation temperature in the condensation zone (no desuperheating zone and no subcooled zone).  

The latter assumption is valid when the condenser is under normal operating conditions: the steam coming from the turbine and the outgoing condensate are at saturation temperature. When superheated steam is directly sent to the condenser, the [dynamic condenser model](modelica://ThermoSysPro.WaterSteam.HeatExchangers.DynamicCondenser) is more appropriate.  

## Modelica component model  

The equations mentioned below are implemented in the component *StaticCondenser*, located in the *WaterSteam.HeatExchangers* sub-library.   
This component has 6 connectors:  
- Cee: cooling water inlet,  
- Cse: cooling water outlet,  
- Cex: extraction water outlet,  
- Cvt: turbine outlet, employed as inlet,  
- Cep: drain inlet,  
- Cev: vapor outlet.  
   
![modelica://ThermoSysPro/UsersGuide/Documentation/ThermoSysPro.WaterSteam.HeatExchangers.StaticCondenser.svg](modelica://ThermoSysPro/UsersGuide/Documentation/ThermoSysPro.WaterSteam.HeatExchangers.StaticCondenser.svg)  

## Nomenclature  

| Symbol| Description| Unit| Definition| Modelica name |  
| :----------------------------------- | :------------------------------------------------------------------------------------------- | :------------------------------------------- | :---------------------------------------------------------------------- | :----------- |  
| \\\\(A\\\\)| Heat exchange surface| \\\\(\\mathrm{m}^{2}\\\\)|| SCO |  
| \\\\(C\\\\)| Fouling coefficient| \\\\(-\\\\)|| COP |  
| \\\\(C\\_{\\text {ref }}\\\\)| Reference fouling coefficient| \\\\(-\\\\)|| COPR |  
| \\\\(h\\_{\\mathrm{c}, \\mathrm{i}}\\\\)| Cold fluid specific enthalpy at the inlet| \\\\(\\mathrm{J} / \\mathrm{kg}\\\\)|| Cee.h |  
| \\\\(h\\_{\\mathrm{c}, \\mathrm{o}}\\\\)| Cold fluid specific enthalpy at the outlet| \\\\(\\mathrm{J} / \\mathrm{kg}\\\\)|| Cse.h |  
| \\\\(h\\_{\\mathrm{d}, \\mathrm{i}}\\\\)| Specific enthalpy at the inlet \\(from drain\\)| \\\\(\\mathrm{J} / \\mathrm{kg}\\\\)|| Cep.h |  
| \\\\(h^{\\mathrm{h}}\\\\)| Hot fluids mixing specific enthalpy| \\\\(\\mathrm{J} / \\mathrm{kg}\\\\)|| Hmv |  
| \\\\(h\\_{l,0}\\\\)| Liquid specific enthalpy at the outlet of the condenser \\(drain\\)| \\\\(\\mathrm{J} / \\mathrm{kg}\\\\)| \\\\(h\\_{l}^{\\mathrm{sat}}+\\frac{\\left\\(P\\_{\\mathrm{b}}-P\\right\\)}{\\rho\\_{l}}\\\\) | Cex.h |  
| \\\\(h\\_{l}^{\\text {sat }}\\\\)| Hot fluid saturation enthalpy of the liquid| \\\\(\\mathrm{J} / \\mathrm{kg}\\\\)|| lsat1.h |  
| \\\\(h\\_{\\mathrm{t}, \\mathrm{i}}\\\\)| Specific enthalpy of the steam coming from the turbine| \\\\(\\mathrm{J} / \\mathrm{kg}\\\\)|| Cvt.h |  
| \\\\(h\\_{\\mathrm{v}, \\mathrm{i}}\\\\)| Specific enthalpy of the steam coming from the boiler outlet or from the turbine inlet valve | \\\\(\\mathrm{J} / \\mathrm{kg}\\\\)|| Cev.h |  
| \\\\(h\\_{\\text {cond }}\\\\)| Heat exchange coefficient: correlation given by the manufacturers| \\\\(\\mathrm{W} / \\mathrm{m}^{2} / \\mathrm{K}\\\\) || XKCO |  
| \\\\(K\\_{\\text {cond }}\\\\)| Reference heat exchange coefficient| \\\\(\\mathrm{W} / \\mathrm{m}^{2} / \\mathrm{K}\\\\) || KCO |  
| \\\\(m\\_{\\mathrm{c}}\\\\)| Cold fluid \\(water\\) mass flow rate| \\\\(\\mathrm{kg} / \\mathrm{s}\\\\)|| Cee.Q |  
| \\\\(m\\_{\\mathrm{c}, \\mathrm{ref}}\\\\)| Cold fluid \\(water\\) reference mass flow rate| \\\\(\\mathrm{kg} / \\mathrm{s}\\\\)|| QC0 |  
| \\\\(\\dot{m}\\_{\\mathrm{d}, \\mathrm{i}}\\\\) | Water mass flow rate at the inlet \\(drain\\)| \\\\(\\mathrm{kg} / \\mathrm{s}\\\\)|| Cep.Q |  
| \\\\(\\dot{m}\\_{\\mathrm{d}, \\mathrm{o}}\\\\) | Water mass flow rate at the outlet of the condenser| \\\\(\\mathrm{kg} / \\mathrm{s}\\\\)|| Cex.Q |  
| \\\\(m\\_{\\mathrm{t}, \\mathrm{i}}\\\\)| Mass flow rate of the steam coming from the turbine| \\\\(\\mathrm{kg} / \\mathrm{s}\\\\)|| Cvt.Q |  
| \\\\(m\\_{\\mathrm{v}, \\mathrm{i}}\\\\)| Mass flow rate of the steam coming from the boiler outlet or from the turbine inlet valve| \\\\(\\mathrm{kg} / \\mathrm{s}\\\\)|| Cev.Q |  
| \\\\(P\\\\)| Steam pressure inside the condenser \\(cavity pressure\\)| \\\\(\\mathrm{Pa}\\\\)|| Pcond |  
| \\\\(P\\_{\\mathrm{b}}\\\\)| Fluid pressure at the bottom of the cavity \\(drain outlet\\)| \\\\(\\mathrm{Pa}\\\\)| \\\\(P+\\rho\\_{l} \\cdot g \\cdot z\\_{l}\\\\)| Cex.P |  
| \\\\(P\\_{\\mathrm{c}, \\mathrm{i}}\\\\)| Cold fluid pressure at the inlet| \\\\(\\mathrm{Pa}\\\\)|| Cee.P |  
| \\\\(P\\_{\\mathrm{c}, \\mathrm{o}}\\\\)| Cold fluid pressure at the outlet| \\\\(\\mathrm{Pa}\\\\)|| Cse.P |  
| \\\\(T\\_{\\mathrm{c}, \\mathrm{i}}\\\\)| Cold fluid \\(water\\) temperature at the inlet| \\\\(\\mathrm{K}\\\\)|| Tee |  
| \\\\(T\\_{\\mathrm{c}, \\mathrm{o}}\\\\)| Cold fluid \\(water\\) temperature at the outlet| \\\\(\\mathrm{K}\\\\)|| Tse |  
| \\\\(T\\_{\\mathrm{c}, \\text { ref }}\\\\)| Cold fluid \\(water\\) reference temperature| \\\\(\\mathrm{K}\\\\)|| - |  
| \\\\(T^{\\text {sat }}\\\\)| Saturation temperature| \\\\(\\mathrm{K}\\\\)|| lsat1.T, vsat1.T |  
| \\\\(W\\\\)| Heat power released to the cold fluid \\(thermal power exchanged\\)| \\\\(\\mathrm{W}\\\\)|| W |  
| \\\\(z\\_{l}\\\\)| Water level in the condenser| \\\\(\\mathrm{m}\\\\)|| z |  
| \\\\(\\Delta P\\_{\\mathrm{c}}\\\\)| Cold fluid pressure loss between the inlet and the outlet| \\\\(\\mathrm{Pa}\\\\)| \\\\(P\\_{\\mathrm{c}, \\mathrm{i}}-P\\_{\\mathrm{c}, \\mathrm{o}}\\\\)| - |  
| \\\\(\\Lambda\\_{\\mathrm{c}}\\\\)| Cold fluid friction pressure loss coefficient| \\\\(\\mathrm{m}^{-4}\\\\)|| CPCE |  
| \\\\(\\rho\\_{\\mathrm{c}}\\\\)| Cold fluid density| \\\\(\\mathrm{kg} / \\mathrm{m}^{3}\\\\)|| rho_ee |  
| \\\\(\\rho\\_{l}\\\\)| Water density at the extraction point \\(i.e., at the liquid outlet of the condenser\\)| \\\\(\\mathrm{kg} / \\mathrm{m}^{3}\\\\)|| rho_ex |  


## Governing equations  

### Power received by the cold fluid  


    
    

- Validity domain:   
   
 \\\\(\\forall \\dot{m}\\_{\\mathrm{c}}\\\\)  

- Mathematical formulation:   
   
 $$W=\\dot{m}\\_{\\mathrm{c}} \\cdot\\left\\(h\\_{\\mathrm{c}, \\mathrm{o}}-h\\_{\\mathrm{c}, \\mathrm{i}}\\right\\)$$  

- Comments:   
   



### Mass balance equation of the hot fluids  


    
    

- Validity domain:   
   
 \\\\(\\forall \\dot{m}\\_{t, i}, \\forall \\dot{m}\\_{v, i}\\\\) and \\\\(\\forall \\dot{m}\\_{\\mathrm{d}, \\mathrm{i}}\\\\)  

- Mathematical formulation:   
   
 $$\\dot{m}\\_{\\mathrm{d}, \\mathrm{o}}=\\dot{m}\\_{\\mathrm{t}, \\mathrm{i}}+\\dot{m}\\_{\\mathrm{v}, \\mathrm{i}}+\\dot{m}\\_{\\mathrm{d}, \\mathrm{i}}$$   

- Comments:   
   
 There are three sources of hot fluids the turbine, the boiler outlet or turbine inlet valve, and the drain.  


### Specific mixing enthalpy of the hot fluids  


    
    

- Validity domain:   
   
 \\\\(\\dot{m}\\_{\\mathrm{d}, \\mathrm{o}} \\neq 0, \\forall \\dot{m}\\_{\\mathrm{t}, \\mathrm{i}}, \\forall \\dot{m}\\_{\\mathrm{v}, \\mathrm{i}}\\\\) and \\\\(\\forall \\dot{m}\\_{\\mathrm{d}, \\mathrm{i}}\\\\)  

- Mathematical formulation:   
   
 $$\\dot{m}\\_{\\mathrm{d}, \\mathrm{o}} \\cdot h^{\\mathrm{h}}=\\dot{m}\\_{\\mathrm{t}, \\mathrm{i}} \\cdot h\\_{\\mathrm{t}, \\mathrm{i}}+\\dot{m}\\_{\\mathrm{v}, \\mathrm{i}} \\cdot h\\_{\\mathrm{v}, \\mathrm{i}}+\\dot{m}\\_{\\mathrm{d}, \\mathrm{i}} \\cdot h\\_{\\mathrm{d}, \\mathrm{i}}$$  

- Comments:   
   
 The mixing enthalpy is used to compute the properties of the hot fluid inside the condenser  


### Energy released during the condensation of the steam at the inlets  


    
    

- Validity domain:   
   
 \\\\(\\forall \\dot{m}\\_{t, 1}, \\forall \\dot{m}\\_{\\mathrm{v}, \\mathrm{i}},\\\\) and \\\\(\\forall \\dot{m}\\_{\\mathrm{d}, \\mathrm{i}}\\\\)  

- Mathematical formulation:   
   
 $$W=\\dot{m}\\_{\\mathrm{t}, \\mathrm{i}} \\cdot\\left\\(h\\_{\\mathrm{t}, \\mathrm{i}}-h\\_{l}^{\\mathrm{sat}}\\right\\)\\right\\)+\\dot{m}\\_{\\mathrm{v}, \\mathrm{i}} \\cdot\\left\\(h\\_{\\mathrm{v}, \\mathrm{i}}-h\\_{l}^{\\mathrm{sat}}\\right\\) + \\dot{m}\\_{\\mathrm{d}, \\mathrm{i}} \\cdot \\left\\(h\\_{\\mathrm{d}, \\mathrm{i}}-h\\_{l}^{\\mathrm{sat}}\\right\\)$$  

- Comments:   
   
 There are three sources of steam the turbine, the boiler outlet or turbine inlet valve, and the drain \\(outlets of water heaters for instence\\). The steam is assumed completely condensed.  


### Power exchanged between the hot and the cold fluids  


    
    

- Validity domain:   
   
 \\\\(W>0\\\\)  

- Mathematical formulation:   
   
 $$T^{\\mathrm{sat}}-T\\_{\\mathrm{c}, \\mathrm{o}}=\\left\\(T^{\\mathrm{sat}}-T\\_{\\mathrm{c}, \\mathrm{i}}\\right\\) \\cdot e^{\\frac{h\\_{\\mathrm{cond}} \\cdot A \\cdot\\left\\(T\\_{\\mathrm{c}, \\mathrm{i}}-T\\_{\\mathrm{c}, \\mathrm{o}}\\right\\)}{W}}$$  

- Comments:   
   
 The hot fluid is assumed to stay at saturation temperature between inlet and outlet of the condenser \\(no desuperheating zone and no subcooled zone\\).  


### Momentum balance equation \\(cold fluid\\)  


    
    

- Validity domain:   
   
 \\\\(\\forall \\dot{m}\\_{\\mathrm{c}}\\\\)  

- Mathematical formulation:   
   
 $$\\Delta P\\_{\\mathrm{c}}=\\Lambda\\_{\\mathrm{c}} \\cdot \\frac{\\dot{m}\\_{\\mathrm{c}} \\cdot\\lvert \\dot{m}\\_{\\mathrm{c}}\\rvert }{\\rho\\_{\\mathrm{c}}}$$   

- Comments:   
   
 Only friction pressure losses are taken into account.  

## References   
   
El Hefni, Baligh and Bouskela, Daniel (2019). [Modeling and Simulation of Thermal Power Plants with ThermoSysPro](https://link.springer.com/book/10.1007/978-3-030-05105-1), sect. 9.7.1. Springer Nature Switzerland AG.  
    ", revisions = "
Author  

Baligh El Hefni   

    "));
end StaticCondenser;