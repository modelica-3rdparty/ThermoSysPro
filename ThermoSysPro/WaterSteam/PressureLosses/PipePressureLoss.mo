within ThermoSysPro.WaterSteam.PressureLosses;

model PipePressureLoss "Pipe generic pressure loss"
  parameter Real K = 10 "Friction pressure loss coefficient";
  parameter Units.SI.Position z1 = 0 "Inlet altitude";
  parameter Units.SI.Position z2 = 0 "Outlet altitude";
  parameter Boolean continuous_flow_reversal = false "true: continuous flow reversal - false: discontinuous flow reversal";
  parameter Integer fluid = 1 "1: water/steam - 2: C3H3F5";
  parameter Units.SI.Density p_rho = 0 "If > 0, fixed fluid density";
  parameter Integer mode = 0 "IF97 region. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  ThermoSysPro.Units.SI.PressureDifference deltaPf "Friction pressure loss";
  ThermoSysPro.Units.SI.PressureDifference deltaPg "Gravity pressure loss";
  ThermoSysPro.Units.SI.PressureDifference deltaP "Total pressure loss";
  Units.SI.MassFlowRate Q(start = 100) "Mass flow rate";
  Units.SI.Density rho(start = 998) "Fluid density";
  Units.SI.Temperature T(start = 290) "Fluid temperature";
  Units.SI.AbsolutePressure Pm(start = 1.e5) "Average fluid pressure";
  Units.SI.SpecificEnthalpy h(start = 100000) "Fluid specific enthalpy";
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph pro "Propriétés de l'eau" annotation(
    Placement(transformation(extent = {{-100, 80}, {-80, 102}}, rotation = 0)));
  Connectors.FluidInlet C1 annotation(
    Placement(transformation(extent = {{-110, -10}, {-90, 10}}, rotation = 0)));
  Connectors.FluidOutlet C2 annotation(
    Placement(transformation(extent = {{90, -10}, {110, 10}}, rotation = 0)));
protected
  constant Units.SI.Acceleration g = Modelica.Constants.g_n "Gravity constant";
  constant Real pi = Modelica.Constants.pi "pi";
  parameter Real eps = 1.e-3 "Small number for pressure loss equation";
  parameter Units.SI.MassFlowRate Qeps = 1.e-3 "Small mass flow for continuous flow reversal";
equation
  C1.P - C2.P = deltaP;
  C2.Q = C1.Q;
  C2.h = C1.h;
  h = C1.h;
  Q = C1.Q;
/* Flow reversal */
  if continuous_flow_reversal then
    0 = noEvent(if (Q > Qeps) then C1.h - C1.h_vol else if (Q < -Qeps) then C2.h - C2.h_vol else C1.h - 0.5*((C1.h_vol - C2.h_vol)*Modelica.Math.sin(pi*Q/2/Qeps) + C1.h_vol + C2.h_vol));
  else
    0 = if (Q > 0) then C1.h - C1.h_vol else C2.h - C2.h_vol;
  end if;
/* Pressure loss */
  deltaPf = K*ThermoSysPro.Functions.ThermoSquare(Q, eps)/rho;
  deltaPg = rho*g*(z2 - z1);
  deltaP = deltaPf + deltaPg;
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
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics = {Rectangle(extent = {{-100, 20}, {100, -20}}, lineColor = {0, 0, 255}, fillColor = {85, 255, 85}, fillPattern = FillPattern.Solid), Text(extent = {{-12, 14}, {16, -14}}, lineColor = {0, 0, 255}, fillColor = {85, 255, 85}, fillPattern = FillPattern.Solid, textString = "K")}),
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics = {Rectangle(extent = {{-100, 20}, {100, -20}}, lineColor = {0, 0, 255}, fillColor = {85, 255, 85}, fillPattern = FillPattern.Solid), Text(extent = {{-12, 14}, {16, -14}}, lineColor = {0, 0, 255}, fillColor = {85, 255, 85}, fillPattern = FillPattern.Solid, textString = "K")}),
    Window(x = 0.11, y = 0.04, width = 0.71, height = 0.88),
    Documentation(info = "
## Copyright © EDF 2002 - 2026  
## ThermoSysPro Version 4.2  
This component model is documented in Sect. 13.4 of the ThermoSysPro book.   

# Pipe pressure loss   

This component represents generic pressure losses in a pipe or a singularity using a single-friction pressure loss coefficient. It can also represent the pressure losses inside a circuit of connected pipes and singularities with a pressure loss coefficient equivalent to the whole circuit. The [lumped straight pipe](modelica://ThermoSysPro.WaterSteam.PressureLosses.LumpedStraightPipe) should be used instead to take that effect into account. For water/steam, the flow regime can be single-phase or homogeneous two-phase flow.  

Following assumptions are made:  
- The flow inside pressure losses is adiabatic. Non-adiabatic pipes must be  
modeled by connecting pressure losses to volumes.  
- The specific enthalpy inside the components is equal to the specific enthalpy at the inlet.  
- The properties of the fluid are computed for the average pressure..  
- Inertia due to momentum inside pipes is neglected.  

The pipe pressure loss component is similar to the [singular pressure loss](modelica://ThermoSysPro.WaterSteam.PressureLosses.SingularPressureLoss), except that it enables the setting of inlet and outlet altitudes of the pipe.  

## Modelica component model  

The equations mentioned below are implemented in the component *PipePressureLoss*, located in the *WaterSteam.PressureLosses* sub-library.   
This component has 2 connectors:  
- C1: fluid inlet,  
- C2: fluid outlet.  
   
![modelica://ThermoSysPro/UsersGuide/Documentation/ThermoSysPro.WaterSteam.PressureLosses.PipePressureLoss.svg](modelica://ThermoSysPro/UsersGuide/Documentation/ThermoSysPro.WaterSteam.PressureLosses.PipePressureLoss.svg)  

## Nomenclature  

| Symbol| Description| Unit| Definition| Modelica name |  
| :------------------------ | :---------------------------------------------------------- | :------------------------------- | :--------------------------------------------------------------- | :----------- |  
| \\\\(g\\\\)| Gravity constant| \\\\(\\mathrm{m} / \\mathrm{s}^{2}\\\\)|| g |  
| \\\\(h\\\\)| Fluid specific enthalpy | \\\\(\\mathrm{J} / \\mathrm{kg}\\\\)|| h |  
| \\\\(m\\\\)| Fluid mass flow rate| \\\\(\\mathrm{kg} / \\mathrm{s}\\\\)|| Q  |  
| \\\\(P\\_{\\mathrm{i}}\\\\)| Fluid pressure at the inlet| \\\\(\\mathrm{Pa}\\\\)|| C1.P |  
| \\\\(P\\_{\\mathrm{o}}\\\\)| Fluid pressure at the outlet| \\\\(\\mathrm{Pa}\\\\)|| C2.P |  
| \\\\(z\\_{\\mathrm{i}}\\\\)| Inlet altitude| \\\\(\\mathrm{m}\\\\)|| z1 |  
| \\\\(z\\_{0}\\\\)| Outlet altitude| \\\\(\\mathrm{m}\\\\)|| z2 |  
| \\\\(\\Delta P\\\\)| Pressure loss of the fluid between the inlet and the outlet | \\\\(\\mathrm{Pa}\\\\)| \\\\(P\\_{\\mathrm{i}}-P\\_{\\mathrm{o}}\\\\)| deltaP |  
| \\\\(\\Delta P\\_{\\mathrm{f}}\\\\) | Friction pressure loss between the inlet and the outlet| \\\\(\\mathrm{Pa}\\\\)|| deltaPf |  
| \\\\(\\Delta P\\_{\\mathrm{g}}\\\\) | Gravity pressure loss between the inlet and the outlet| \\\\(\\mathrm{Pa}\\\\)| \\\\(\\rho \\cdot g \\cdot\\left\\(z\\_{\\mathrm{o}}-z\\_{\\mathrm{i}}\\right\\)\\\\) | deltaPg |  
| \\\\(\\Lambda\\\\)| Friction pressure loss coefficient| \\\\(\\mathrm{m}^{-4}\\\\)|| K |  
| \\\\(\\rho\\\\)| Fluid density| \\\\(\\mathrm{kg} / \\mathrm{m}^{3}\\\\) || rho |  


## Governing equations  

### Static momentum balance equation  


    
    

- Validity domain:   
   
 \\\\(\\forall \\dot{m}\\\\)  

- Mathematical formulation:   
   
 $$\\Delta P=\\Delta P\\_{\\mathrm{f}}+\\Delta P\\_{\\mathrm{g}}$$  

- Comments:   
   
 In case of a singularity, \\\\(z\\_{\\mathrm{o}}=z\\_{\\mathrm{i}}\\\\) and consequently \\\\(\\Delta P\\_{\\mathrm{g}}=0\\\\).  


### Friction pressure losses  


    
    

- Validity domain:   
   
 \\\\(\\forall \\dot{m}\\\\)  

- Mathematical formulation:   
   
 $$\\Delta P\\_{\\mathrm{f}}=\\Lambda \\cdot \\frac{\\dot{m} \\cdot \\lvert \\dot{m} \\rvert }{\\rho}$$  

- Comments:   
   
The pressure loss coefficient \\\\(\\Lambda\\\\) is provided by the user or can be obtained by inverse calculation from the mass flow rate.  

## References   
   
El Hefni, Baligh and Bouskela, Daniel (2019). [Modeling and Simulation of Thermal Power Plants with ThermoSysPro](https://link.springer.com/book/10.1007/978-3-030-05105-1), sect. 13.4. Springer Nature Switzerland AG.  
    ", revisions = "
Author  

Daniel Bouskela   

    "));
end PipePressureLoss;