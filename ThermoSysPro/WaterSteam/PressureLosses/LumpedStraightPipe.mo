within ThermoSysPro.WaterSteam.PressureLosses;

model LumpedStraightPipe "Lumped straight pipe (circular duct)"
  parameter Units.SI.Length L = 10. "Pipe length";
  parameter Units.SI.Diameter D = 0.2 "Pipe internal diameter";
  parameter Real ntubes = 1 "Number of pipes in parallel";
  parameter Real lambda = 0.03 "Friction pressure loss coefficient (active if lambda_fixed=true)";
  parameter Real rugosrel = 0.0001 "Pipe roughness (active if lambda_fixed=false)";
  parameter Units.SI.Position z1 = 0 "Inlet altitude";
  parameter Units.SI.Position z2 = 0 "Outlet altitude";
  parameter Boolean lambda_fixed = true "true: lambda given by parameter - false: lambde computed using Idel'Cik correlation";
  parameter Boolean inertia = false "true: momentum balance equation with inertia - false: without inertia";
  parameter Boolean continuous_flow_reversal = false "true: continuous flow reversal - false: discontinuous flow reversal";
  parameter Integer fluid = 1 "1: water/steam - 2: C3H3F5";
  parameter Units.SI.Density p_rho = 0 "If > 0, fixed fluid density";
  parameter Integer mode = 0 "IF97 region. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  Real khi "Hydraulic pressure loss coefficient";
  ThermoSysPro.Units.SI.PressureDifference deltaPf "Friction pressure loss";
  ThermoSysPro.Units.SI.PressureDifference deltaP "Total pressure loss";
  Units.SI.MassFlowRate Q(start = 100) "Mass flow rate";
  Units.SI.ReynoldsNumber Re "Reynolds number";
  Units.SI.ReynoldsNumber Relim "Limit Reynolds number";
  Real lam "Friction pressure loss coefficient";
  Units.SI.Density rho "Fluid density";
  Units.SI.DynamicViscosity mu "Fluid dynamic viscosity";
  Units.SI.Temperature T "Fluid temperature";
  Units.SI.AbsolutePressure Pm "Fluid average pressure";
  Units.SI.SpecificEnthalpy h "Fluid specific enthalpy";
  Connectors.FluidInlet C1 annotation(
    Placement(transformation(extent = {{-110, -10}, {-90, 10}}, rotation = 0)));
  Connectors.FluidOutlet C2 annotation(
    Placement(transformation(extent = {{90, -10}, {110, 10}}, rotation = 0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph pro annotation(
    Placement(transformation(extent = {{-100, 78}, {-80, 98}}, rotation = 0)));
protected
  constant Units.SI.Acceleration g = Modelica.Constants.g_n "Gravity constant";
  constant Real pi = Modelica.Constants.pi "pi";
  parameter Real eps = 1.e-3 "Small number for pressure loss equation";
  parameter Units.SI.MassFlowRate Qeps = 1.e-3 "Small mass flow for continuous flow reversal";
  parameter Units.SI.Area A = ntubes*pi*D^2/4 "Pipes cross-sectional area (circular duct is assumed)";
  parameter Units.SI.Area Pw = ntubes*pi*D "Pipes wetted perimeter (circular duct is assumed)";
initial equation
  if inertia then
    der(Q) = 0;
  end if;
equation
  C1.h = C2.h;
  C1.Q = C2.Q;
  C1.P - C2.P = deltaP;
  h = C1.h;
  Q = C1.Q;
/* Flow reversal */
  if continuous_flow_reversal then
    0 = noEvent(if (Q > Qeps) then C1.h - C1.h_vol else if (Q < -Qeps) then C2.h - C2.h_vol else C1.h - 0.5*((C1.h_vol - C2.h_vol)*Modelica.Math.sin(pi*Q/2/Qeps) + C1.h_vol + C2.h_vol));
  else
    0 = if (Q > 0) then C1.h - C1.h_vol else C2.h - C2.h_vol;
  end if;
/* Pressure loss */
  if inertia then
    deltaP = deltaPf + rho*g*(z2 - z1) + L/A*der(Q);
  else
    deltaP = deltaPf + rho*g*(z2 - z1);
  end if;
  deltaPf = khi*ThermoSysPro.Functions.ThermoSquare(Q, eps)/(2*A^2*rho);
/* Darcy-Weisbach formula (Idel'cik p. 55). Quadratic flow regime is assumed and Re > 4000 (Re > Relim). */
  khi = lam*L/D;
  if lambda_fixed then
    lam = lambda;
  else
    if (rugosrel > 0.00005) then
      lam = 1/(2*Modelica.Math.log10(3.7/rugosrel))^2;
    else
      lam = if noEvent(Re > 0) then 1/(1.8*Modelica.Math.log10(Re) - 1.64)^2 else 0;
    end if;
  end if;
  Relim = if (rugosrel > 0.00005) then max(560/rugosrel, 2.e5) else 4000;
  Re = 4*abs(Q)/(Pw*mu);
/* Fluid thermodynamic properties */
  Pm = (C1.P + C2.P)/2;
  pro = ThermoSysPro.Properties.Fluid.Ph(Pm, h, mode, fluid);
  T = pro.T;
  if (p_rho > 0) then
    rho = p_rho;
  else
    rho = pro.d;
  end if;
  mu = ThermoSysPro.Properties.Fluid.DynamicViscosity_Ph(Pm, h, fluid, mode, 0.1, 0.1, 0.1, 0);
  annotation(
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics = {Rectangle(extent = {{-100, 20}, {100, -20}}, lineColor = {28, 108, 200}, fillColor = {85, 170, 255}, fillPattern = FillPattern.Solid)}),
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics = {Rectangle(extent = {{-100, 20}, {100, -20}}, lineColor = {28, 108, 200}, fillColor = {85, 170, 255}, fillPattern = FillPattern.Solid)}),
    Window(x = 0.06, y = 0.08, width = 0.82, height = 0.65),
    Documentation(info = "
## Copyright © EDF 2002 - 2026   
## ThermoSysPro Version 4.2  
This component model is documented in Sect. 13.5 of the ThermoSysPro book.   
# Lumped straight pipe   

The lumped straight pipe models the pressure loss of a fluid circulating inside a pipe. It must be connected to volumes in order to have a complete model featuring mass, energy, and momentum balance equations.  

Following assumptions are made:  
- The flow inside pressure losses is adiabatic. Non-adiabatic pipes must be  
modeled by connecting pressure losses to volumes.  
- The specific enthalpy inside the components is equal to the specific enthalpy at the inlet.  
- The properties of the fluid are computed for the average pressure..  
- Inertia due to momentum inside pipes is neglected.  
- The fluid density \\\\(\\rho\\\\) is assumed constant along the pipe.  


## Modelica component model  

The equations mentioned below are implemented in the component *LumpedStraightPipe*, located in the *WaterSteam.PressureLosses* sub-library.   
This component has 2 connectors:  
- C1: fluid inlet,  
- C2: fluid outlet.  
   
![modelica://ThermoSysPro/UsersGuide/Documentation/ThermoSysPro.WaterSteam.PressureLosses.LumpedStraightPipe.svg](modelica://ThermoSysPro/UsersGuide/Documentation/ThermoSysPro.WaterSteam.PressureLosses.LumpedStraightPipe.svg)  

## Nomenclature  

| Symbol| Description| Unit| Definition| Modelica name |  
| :------------------------ | :----------------------------------------------------------- | :------------------------------ | :------------------------------------------------------------------------ | :----------- |  
| \\\\(A\\\\)| Internal cross section of the pipe| \\\\(\\mathrm{m}^{2}\\\\)| \\\\(\\pi \\cdot D^{2} / 4\\\\)| A |  
| \\\\(D\\\\)| Internal diameter of the pipe| \\\\(\\mathrm{m}\\\\)|| D |  
| \\\\(g\\\\)| Gravity constant| \\\\(\\mathrm{m} / \\mathrm{s}^{2}\\\\) || g |  
| \\\\(h\\\\)| Fluid specific enthalpy| \\\\(\\mathrm{J} / \\mathrm{kg}\\\\)|| h |  
| \\\\(L\\\\)| Length of the pipe| \\\\(\\mathrm{m}\\\\)|| L |  
| \\\\(\\dot{m}\\\\)| Fluid mass flow rate| \\\\(\\mathrm{kg} / \\mathrm{s}\\\\)|| Q |  
| \\\\(P\\_{\\mathrm{i}}\\\\)| Fluid pressure at the pipe inlet| \\\\(\\mathrm{Pa}\\\\)|| C1.P |  
| \\\\(P\\_{\\mathrm{o}}\\\\)| Fluid pressure at the pipe outlet| \\\\(\\mathrm{Pa}\\\\)|| C2.P |  
| \\\\(R e\\\\)| Fluid Reynolds number| \\\\(-\\\\)| \\\\(\\frac{4 \\cdot \\lvert \\dot{m} \\rvert}{\\pi \\cdot D \\cdot \\mu}\\\\)| Re |  
| \\\\(z\\_{\\mathrm{i}}\\\\)| Inlet altitude of the pipe| \\\\(\\mathrm{m}\\\\)|| z1 |  
| \\\\(z\\_{0}\\\\)| Outlet altitude of the pipe| \\\\(\\mathrm{m}\\\\)|| z2 |  
| \\\\(\\Delta P\\\\)| Pressure loss of the fluid between the pipe inlet and outlet | \\\\(\\mathrm{Pa}\\\\)| \\\\(P\\_{\\mathrm{i}}-P\\_{\\mathrm{o}}\\\\)| deltaP |  
| \\\\(\\Delta P\\_{\\mathrm{f}}\\\\) | Friction pressure loss between the pipe inlet and outlet| \\\\(\\mathrm{Pa}\\\\)|| deltaPf |  
| \\\\(\\Delta P\\_{\\mathrm{g}}\\\\) | Gravity pressure loss| \\\\(\\mathrm{Pa}\\\\)| \\\\(\\rho \\cdot \\mathrm{g} \\cdot\\left\\(z\\_{\\mathrm{o}}-z\\_{\\mathrm{i}}\\right\\)\\\\) | - |  
| \\\\(\\varepsilon\\\\)| Pipe roughness| \\\\(\\mathrm{m}\\\\)|| rugosrel |  
| \\\\(\\Lambda\\_{\\mathrm{f}}\\\\)| Friction pressure loss coefficient| \\\\(\\mathrm{Pa} . \\mathrm{s}\\\\)|| lam |  
| \\\\(\\mu\\\\)| Fluid dynamic viscosity| \\\\(\\mathrm{kg} /\\\\)|| mu |  
| \\\\(\\rho\\\\)| Fluid density| \\\\(\\mathrm{m}^{3}\\\\)|| rho |  



## Governing equations  

### Dynamic momentum balance equation  


    
    

- Validity domain:   
   
 \\\\(\\forall \\dot{m}\\\\)  

- Mathematical formulation:   
   
 $$\\Delta P=\\Delta P\\_{\\mathrm{f}}+\\Delta P\\_{\\mathrm{g}}+\\frac{L}{A} \\cdot \\frac{\\mathrm{d} \\dot{m}}{\\mathrm{d} t}$$  

- Comments:   
   
 This is valid only if the mass flow rate wavelength is large as compared to the pipe length \\\\(L\\\\), i.e. if there is no water hammer effect inside the pipe. It can for instance be used to model water level oscillations in tanks communicating through a pipe.  


### Static momentum balance equation  

- Validity domain:   
   
 \\\\(\\forall \\dot{m}\\\\)  


    
    

- Mathematical formulation:   
   
 $$\\Delta P=\\Delta P\\_{\\mathrm{f}}+\\Delta P\\_{\\mathrm{g}}$$  

- Comments:    


### Friction pressure losses  


    
    

- Validity domain:   
   
 \\\\(\\forall \\dot{m}\\\\)  

- Mathematical formulation:   
   
 $$\\Delta P\\_{\\mathrm{f}}=\\frac{\\Lambda\\_{\\mathrm{f}} \\cdot L}{D} \\cdot \\frac{\\dot{m} \\cdot \\lvert \\dot{m} \\rvert }{2 \\cdot A^{2} \\cdot \\rho}$$  

- Comments:   
   


## References   
   
El Hefni, Baligh and Bouskela, Daniel (2019). [Modeling and Simulation of Thermal Power Plants with ThermoSysPro](https://link.springer.com/book/10.1007/978-3-030-05105-1), sect. 13.5. Springer Nature Switzerland AG.  
    ", revisions = "
Authors  

Daniel Bouskela  
Baligh El Hefni   

    "));
end LumpedStraightPipe;