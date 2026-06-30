within ThermoSysPro.WaterSteam.PressureLosses;

model SwitchValve "Switch valve"
  parameter ThermoSysPro.Units.xSI.PressureLossCoefficient k = 1000 "Pressure loss coefficient";
  parameter Units.SI.MassFlowRate Qmin = 1.e-6 "Mass flow when the valve is closed";
  parameter Boolean continuous_flow_reversal = false "true: continuous flow reversal - false: discontinuous flow reversal";
  parameter Integer fluid = 1 "1: water/steam - 2: C3H3F5";
  parameter Units.SI.Density p_rho = 0 "If > 0, fixed fluid density";
  parameter Integer mode = 0 "IF97 region. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  Units.SI.MassFlowRate Q(start = 500) "Mass flow rate";
  ThermoSysPro.Units.SI.PressureDifference deltaP "Singular pressure loss";
  Units.SI.Density rho(start = 998) "Fluid density";
  Units.SI.Temperature T(start = 290) "Fluid temperature";
  Units.SI.AbsolutePressure Pm(start = 1.e5) "Fluid average pressure";
  Units.SI.SpecificEnthalpy h(start = 100000) "Fluid specific enthalpy";
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph pro "Propriétés de l'eau" annotation(
    Placement(transformation(extent = {{-100, 80}, {-80, 100}}, rotation = 0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputLogical Ouv annotation(
    Placement(transformation(origin = {0, 72}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  Connectors.FluidInlet C1 annotation(
    Placement(transformation(extent = {{-110, -70}, {-90, -50}}, rotation = 0)));
  Connectors.FluidOutlet C2 annotation(
    Placement(transformation(extent = {{90, -68}, {110, -48}}, rotation = 0)));
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
  if Ouv.signal then
    deltaP - k*ThermoSysPro.Functions.ThermoSquare(Q, eps)/2/rho = 0;
  else
    Q - Qmin = 0;
  end if;
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
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics = {Polygon(points = {{-100, -100}, {0, -60}, {-100, -20}, {-100, -100}, {-100, -100}}, lineColor = {0, 0, 255}, fillColor = {127, 255, 0}, fillPattern = FillPattern.Solid), Polygon(points = {{0, -60}, {100, -20}, {100, -100}, {0, -60}, {0, -60}}, lineColor = {0, 0, 255}, fillColor = {127, 255, 0}, fillPattern = FillPattern.Solid), Line(points = {{-40, 60}, {40, 60}}, color = {0, 0, 255}, thickness = 1), Line(points = {{0, 60}, {0, -60}})}),
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics = {Polygon(points = {{-100, -100}, {0, -60}, {-100, -20}, {-100, -100}, {-100, -100}}, lineColor = {0, 0, 255}, fillColor = {127, 255, 0}, fillPattern = FillPattern.Solid), Polygon(points = {{0, -60}, {100, -20}, {100, -100}, {0, -60}, {0, -60}}, lineColor = {0, 0, 255}, fillColor = {127, 255, 0}, fillPattern = FillPattern.Solid), Line(points = {{-40, 60}, {40, 60}}, color = {0, 0, 255}, thickness = 1), Line(points = {{0, 60}, {0, -60}})}),
    Window(x = 0.1, y = 0.04, width = 0.79, height = 0.84),
    Documentation(info = "
## Copyright © EDF 2002 - 2026  
## ThermoSysPro Version 4.2  
This component model is documented in Sect. 13.10 of the ThermoSysPro book.   

# Switch valve   

A switch valve has only two stable positions: fully open or fully closed.  
When it is open, the fluid flows with a pressure loss. For ideal valves, this pressure loss is zero. When it is closed, the mass flow rate is zero (unless the valve is leaking).  

Switch valves are usually controlled by a binary signal, like [control valves](modelica://ThermoSysPro.WaterSteam.PressureLosses.ControlValve). But only 0 and 1 are stable positions for the switch valve.  

Following assumptions are made:  
- the fluid is subsonic and incompressible.  
- the volume inside the valve is negligible, and so is its inertia.  
- the valve is assumed to switch positions instantly.  

If the latter assumption is not valid, the [control valve](modelica://ThermoSysPro.WaterSteam.PressureLosses.ControlValve) should be used with an actuator modeling the continuous position switch.  



## Modelica component model  

The equations mentioned below are implemented in the component *SwitchValve*, located in the *WaterSteam.PressureLosses* sub-library.   
This component has 3 connectors:  
- C1: fluid inlet,  
- C2: fluid outlet,  
- Ouv: valve opening.  
   
![modelica://ThermoSysPro/UsersGuide/Documentation/ThermoSysPro.WaterSteam.PressureLosses.SwitchValve.svg](modelica://ThermoSysPro/UsersGuide/Documentation/ThermoSysPro.WaterSteam.PressureLosses.SwitchValve.svg)  

## Nomenclature  

| Symbol| Description| Unit| Definition| Modelica name |  
| :----------------- | :---------------------------------------------------------- | :--------------------------- | :-------------------------------- | :----------- |  
| \\\\(h\\\\)| Fluid specific enthalpy | \\\\(\\mathrm{J} / \\mathrm{kg}\\\\) || h |  
| \\\\(P\\_{\\mathrm{i}}\\\\) | Fluid pressure at the valve inlet| \\\\(\\mathrm{Pa}\\\\)|| C1.P |  
| \\\\(P\\_{\\mathrm{o}}\\\\) | Fluid pressure at the valve outlet| \\\\(\\mathrm{Pa}\\\\)|| C2.P |  
| \\\\(\\dot{m}\\\\)| Fluid mass flow rate| \\\\(\\mathrm{kg} / \\mathrm{s}\\\\) || Q |  
| \\\\(\\Delta P\\\\)| Pressure loss of the fluid between the inlet and the outlet | \\\\(\\mathrm{Pa}\\\\)| \\\\(P\\_{\\mathrm{i}}-P\\_{\\mathrm{o}}\\\\) | deltaP |  
| \\\\(\\Lambda\\\\)| Friction pressure loss coefficient| \\\\(\\mathrm{m}^{-4}\\\\)|| k |  
| \\\\(\\rho\\\\)| Fluid density| \\\\(\\mathrm{kg} /^{3}\\\\)|| rho |  
| \\\\(\\Omega\\\\)| Valve position \\(0 or 1\\)| \\\\(-\\\\)|| Ouv.signal |  


## Governing equations  

### Static momentum balance equation  

- Validity domain:  

 \\\\(\\forall \\dot{m}\\\\). For \\\\(\\dot{m}=0, \\Delta P\\\\) must be defined.  

- Mathematical formulation:  

$$   \\left\\{\\begin{array}{l} \\dot{m}=0 \\; \\text{if} \\; \\Omega=0 \\\\   \\Delta P=\\Lambda \\cdot \\frac{\\dot{m} \\cdot \\lvert \\dot{m}\\rvert}{\\rho} \\;   \\text{if} \\; \\Omega=1 \\end{array} \\right.$$  

- Comments:   

This formulation switches dynamically when \\\\(\\Omega\\\\) switches between 0 and 1. When \\\\(\\Omega=0\\\\), the valve is fully closed, so the proper definition of \\\\(P_i\\\\) and \\\\(P_o\\\\) in the components adjacent to the valve should be checked.  

## References   
   
El Hefni, Baligh and Bouskela, Daniel (2019). [Modeling and Simulation of Thermal Power Plants with ThermoSysPro](https://link.springer.com/book/10.1007/978-3-030-05105-1), sect. 13.1. Springer Nature Switzerland AG.  
    ", revisions = "
Author  

Daniel Bouskela   

    "));
end SwitchValve;