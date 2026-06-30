within ThermoSysPro.WaterSteam.PressureLosses;

model CheckValve "Check valve"
  parameter ThermoSysPro.Units.SI.PressureDifference dPOuvert = 10 "Pressure difference when the valve opens";
  parameter ThermoSysPro.Units.SI.PressureDifference dPFerme = 0 "Pressure difference when the valve closes";
  parameter ThermoSysPro.Units.xSI.PressureLossCoefficient k = 1000 "Pressure loss coefficient";
  parameter Units.SI.MassFlowRate Qmin = 1.e-6 "Mass flow when the valve is closed";
  parameter Boolean continuous_flow_reversal = false "true: continuous flow reversal - false: discontinuous flow reversal";
  parameter Integer fluid = 1 "1: water/steam - 2: C3H3F5";
  parameter Units.SI.Density p_rho = 0 "If > 0, fixed fluid density";
  parameter Integer mode = 0 "IF97 region. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  Boolean ouvert(start = true, fixed = true) "Valve state";
  discrete Boolean touvert(start = false, fixed = true);
  discrete Boolean tferme(start = false, fixed = true);
  Units.SI.MassFlowRate Q(start = 500) "Mass flow rate";
  ThermoSysPro.Units.SI.PressureDifference deltaP "Singular pressure loss";
  Units.SI.Density rho(start = 998) "Fluid density";
  Units.SI.Temperature T(start = 290) "Fluid temperature";
  Units.SI.AbsolutePressure Pm(start = 1.e5) "Fluid average pressure";
  Units.SI.SpecificEnthalpy h(start = 100000) "Fluid specific enthalpy";
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph pro "Propriétés de l'eau" annotation(
    Placement(transformation(extent = {{-100, 80}, {-80, 100}}, rotation = 0)));
  Connectors.FluidInlet C1 annotation(
    Placement(transformation(extent = {{-120, -10}, {-100, 10}}, rotation = 0)));
  Connectors.FluidOutlet C2 annotation(
    Placement(transformation(extent = {{100, -10}, {120, 10}}, rotation = 0)));
protected
  parameter Real eps = 1.e-3 "Small number for pressure loss equation";
  constant Real pi = Modelica.Constants.pi "pi";
  parameter Units.SI.MassFlowRate Qeps = 1.e-3 "Small mass flow for continuous flow reversal";
equation
  C1.Q = C2.Q;
  C1.h = C2.h;
  h = C1.h;
  Q = C1.Q;
  deltaP = C1.P - C2.P;
/* Flow reversal */
  if continuous_flow_reversal then
    0 = noEvent(if (Q > Qeps) then C1.h - C1.h_vol else if (Q < -Qeps) then C2.h - C2.h_vol else C1.h - 0.5*((C1.h_vol - C2.h_vol)*Modelica.Math.sin(pi*Q/2/Qeps) + C1.h_vol + C2.h_vol));
  else
    0 = if (Q > 0) then C1.h - C1.h_vol else C2.h - C2.h_vol;
  end if;
/* Pressure loss */
  if ouvert then
    deltaP - k*ThermoSysPro.Functions.ThermoSquare(Q, eps)/2/rho = 0;
  else
    Q - Qmin = 0;
  end if;
  touvert = (deltaP > dPOuvert);
  tferme = (deltaP < dPFerme);
  when {pre(tferme), pre(touvert)} then
    ouvert = pre(touvert);
  end when;
/* Fluid thermodynamic properties */
  Pm = (C1.P + C2.P)/2;
  pro = ThermoSysPro.Properties.Fluid.Ph(Pm, h, mode, fluid);
  T = pro.T;
  if (p_rho > 0) then
    rho = p_rho;
  else
    rho = pro.d;
  end if;
  annotation(
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics = {Ellipse(extent = {{-70, 70}, {-50, 50}}, lineColor = {0, 0, 255}, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid), Line(points = {{-60, -60}, {-60, 60}, {60, -60}, {60, 60}}, color = {0, 203, 0}, thickness = 0.5), Line(points = {{-100, 0}, {-60, 0}}), Line(points = {{60, 0}, {100, 0}})}),
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics = {Line(points = {{-60, -60}, {-60, 60}, {60, -60}, {60, 60}}, color = {0, 203, 0}, thickness = 0.5), Line(points = {{-100, 0}, {-60, 0}}), Line(points = {{60, 0}, {100, 0}}), Ellipse(extent = {{-70, 70}, {-50, 50}}, lineColor = {0, 0, 255}, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid)}),
    Window(x = 0.09, y = 0.05, width = 0.91, height = 0.92),
    Documentation(info = "
## Copyright © EDF 2002 - 2026  
## ThermoSysPro Version 4.2  
This component model is documented in Sect. 13.11 of the ThermoSysPro book.   

# Check valve   
   
Check valves are used in pipes to prevent backflow for safety reasons.  
They feature a clapper that opens on direct flow and closes on backflow.  
This component is similar to the [switch valve](modelica://ThermoSysPro.WaterSteam.PressureLosses.SwitchValve).  
The difference lies in the control: the switch valve position is set by an actuator, whereas the check valve is operated by the pressure difference between the inlet and the outlet.  
The check valve thus operates automatically, without external control.  

Following assumptions are made:  
- The movement of the clapper between the open and close positions is instantaneous, so that its inertia is neglected.  



## Modelica component model  

The equations mentioned below are implemented in the component *CheckValve*, located in the *WaterSteam.PressureLosses* sub-library.   
This component has 2 connectors:  
- C1: fluid inlet,  
- C2: fluid outlet.  
   
![modelica://ThermoSysPro/UsersGuide/Documentation/ThermoSysPro.WaterSteam.PressureLosses.CheckValve.svg](modelica://ThermoSysPro/UsersGuide/Documentation/ThermoSysPro.WaterSteam.PressureLosses.CheckValve.svg)  

## Nomenclature  

| Symbol| Description| Unit| Definition| Modelica name |  
| :---------------------------- | :---------------------------------------------------------- | :------------------------------- | :-------------------------------- | :----------- |  
| \\\\(h\\\\)| Fluid specific enthalpy | \\\\(\\mathrm{J} / \\mathrm{kg}\\\\)|| h |  
| \\\\(m\\\\)| Fluid mass flow rate| \\\\(\\mathrm{kg} / \\mathrm{s}\\\\)|| Q |  
| \\\\(P\\_{\\mathrm{i}}\\\\)| Fluid pressure at the inlet| \\\\(\\mathrm{Pa}\\\\)|| C1.P |  
| \\\\(P\\_{\\mathrm{o}}\\\\)| Fluid pressure at the outlet| \\\\(\\mathrm{Pa}\\\\)|| C2.P |  
| \\\\(\\Delta P\\\\)| Pressure loss of the fluid between the inlet and the outlet | \\\\(\\mathrm{Pa}\\\\)| \\\\(P\\_{\\mathrm{i}}-P\\_{\\mathrm{o}}\\\\) | deltaP |  
| \\\\(\\Delta P\\_{\\text {close }}\\\\) | Pressure difference when the valve closes | \\\\(\\mathrm{Pa}\\\\)|| dPFerme |  
| \\\\(\\Delta P\\_{\\text {open }}\\\\)| Pressure difference when the valve opens | \\\\(\\mathrm{Pa}\\\\)|| dPOuvert |  
| \\\\(\\Lambda\\\\)| Friction pressure loss coefficient| \\\\(\\mathrm{m}^{-4}\\\\)|| k |  
| \\\\(\\rho\\\\)| Fluid density| \\\\(\\mathrm{kg} / \\mathrm{m}^{3}\\\\) || rho |  



## Governing equations  

The model is based on a simple pressure loss equation when the valve is open.  
When the valve closes, it dynamically switches to the zero-flow equation.  

   
###  Static momentum balance equation  

- Validity domain:  

 \\\\(\\forall \\dot{m}\\\\)  

- Mathematical formulation:  

$$   \\left\\{\\begin{array}{l}\\dot{m} =0 \\; \\text{ if } \\; \\Delta P<\\Delta P_{\\text{close}}\\\\   \\Delta P=\\Lambda \\cdot \\frac{\\dot{m} \\cdot \\lvert \\dot{m} \\rvert }{2 \\cdot \\rho} \\; \\text{if} \\; \\Delta P > \\Delta P_{\\text{open}} \\end{array} \\right.$$  

- Comments:  

The valve closes when \\\\(\\Delta P\\\\) drops below \\\\(\\Delta P\\_{\\text {close }}\\\\) and opens when \\\\(\\Delta P\\\\) rises  
above \\\\(\\Delta P\\_{\\text {open}}\\\\).  
To avoid chattering, \\\\(\\Delta P\\_{\\text {open }}\\\\) and \\\\(\\Delta P\\_{\\text {close }}\\\\) should be set such that \\\\(\\Delta P\\_{\\text {close }}<\\Delta P\\_{\\text {open }}\\\\).  


## References   
   
El Hefni, Baligh and Bouskela, Daniel (2019). [Modeling and Simulation of Thermal Power Plants with ThermoSysPro](https://link.springer.com/book/10.1007/978-3-030-05105-1), sect. 13.1. Springer Nature Switzerland AG.  
    ", revisions = "
Author  

Daniel Bouskela   

    "));
end CheckValve;