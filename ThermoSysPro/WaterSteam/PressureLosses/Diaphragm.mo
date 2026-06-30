within ThermoSysPro.WaterSteam.PressureLosses;

model Diaphragm "Diaphragm"
  parameter Real Ouv = 0.5 "Diaphragm aperture";
  parameter Units.SI.Diameter D = 0.2 "Diaphragm diameter";
  parameter Boolean continuous_flow_reversal = false "true: continuous flow reversal - false: discontinuous flow reversal";
  parameter Integer fluid = 1 "1: water/steam - 2: C3H3F5";
  parameter Units.SI.Density p_rho = 0 "If > 0, fixed fluid density";
  parameter Integer mode = 0 "IF97 region. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  Real khi "Hydraulic pressure loss coefficient";
  ThermoSysPro.Units.SI.PressureDifference deltaP "Pressure loss";
  Units.SI.MassFlowRate Q "Mass flow rate";
  Units.SI.ReynoldsNumber Re "Reynolds number";
  Units.SI.ReynoldsNumber Relim "Limit Reynolds number";
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
    Placement(transformation(extent = {{-100, 80}, {-80, 100}}, rotation = 0)));
protected
  constant Real pi = Modelica.Constants.pi "pi";
  parameter Real eps = 1.e-3 "Small number for pressure loss equation";
  parameter Units.SI.MassFlowRate Qeps = 1.e-3 "Small mass flow for continuous flow reversal";
equation
  C1.Q = C2.Q;
  C1.h = C2.h;
  C1.P - C2.P = deltaP;
  Q = C1.Q;
  h = C1.h;
/* Flow reversal */
  if continuous_flow_reversal then
    0 = noEvent(if (Q > Qeps) then C1.h - C1.h_vol else if (Q < -Qeps) then C2.h - C2.h_vol else C1.h - 0.5*((C1.h_vol - C2.h_vol)*Modelica.Math.sin(pi*Q/2/Qeps) + C1.h_vol + C2.h_vol));
  else
    0 = if (Q > 0) then C1.h - C1.h_vol else C2.h - C2.h_vol;
  end if;
/* Pressure loss */
  deltaP = 8*khi*ThermoSysPro.Functions.ThermoSquare(Q, eps)/(pi^2*D^4*rho);
/* Diaphragme avec ouvertures à arêtes vives (Idel'cik p. 103). One assumes that Re > 1.e5 (Re > Relim) */
  assert((Ouv > 0) and not (Ouv > 1), "Diaphragm: parameter Ouv should be such as 0 < Ouv <= 1");
  khi = ((1.707 - Ouv)/Ouv)^2;
  Relim = 1.e5;
  Re = 4*abs(Q)/(pi*D*mu*Ouv);
/* Fluid thermodynamic properties */
  Pm = (C1.P + C2.P)/2;
  pro = ThermoSysPro.Properties.Fluid.Ph(Pm, h, mode, fluid);
  T = pro.T;
  if (p_rho > 0) then
    rho = p_rho;
  else
    rho = pro.d;
  end if;
  mu = ThermoSysPro.Properties.WaterSteam.IF97.DynamicViscosity_rhoT(rho, T);
  annotation(
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics = {Line(points = {{-40, 100}, {-40, 20}}, color = {0, 203, 0}, thickness = 0.5), Line(points = {{-40, -20}, {-40, -100}}, color = {0, 203, 0}, thickness = 0.5), Line(points = {{40, 100}, {40, 18}}, color = {0, 203, 0}, thickness = 0.5), Line(points = {{40, -20}, {40, -100}}, color = {0, 203, 0}, thickness = 0.5)}),
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics = {Line(points = {{-40, 100}, {-40, 20}}, color = {0, 203, 0}, thickness = 0.5), Line(points = {{-40, -20}, {-40, -100}}, color = {0, 203, 0}, thickness = 0.5), Line(points = {{40, 100}, {40, 18}}, color = {0, 203, 0}, thickness = 0.5), Line(points = {{40, -20}, {40, -100}}, color = {0, 203, 0}, thickness = 0.5)}),
    Window(x = 0.13, y = 0.05, width = 0.73, height = 0.73),
    Documentation(info = "
## Copyright © EDF 2002 - 2026  
## ThermoSysPro Version 4.2  
This component model is documented in Sect. 13.7 of the ThermoSysPro book.   

# Diaphragm   
   
A diaphragm measures pressure losses to compute mass flow rates.  
For water/steam, the flow regime can be single-phase or homogeneous two-phase flow. This model accounts for friction pressure losses only.  

Following assumptions are made:  
- the diaphragm aperture relies on sharp ridges.  

The friction pressure loss coefficient is calculated using the geometry of the diaphragm. The diaphragm component thus completes the [singular pressure loss](modelica://ThermoSysPro.WaterSteam.PressureLosses.SingularPressureLoss), in which the pressure loss coefficient is a single parameter.  

## Modelica component model  

The equations mentioned below are implemented in the component *Diaphragm*, located in the *WaterSteam.PressureLosses* sub-library.   
This component has 2 connectors:  
- C1: fluid inlet,  
- C2: fluid outlet.  
   
![modelica://ThermoSysPro/UsersGuide/Documentation/ThermoSysPro.WaterSteam.PressureLosses.Diaphragm.svg](modelica://ThermoSysPro/UsersGuide/Documentation/ThermoSysPro.WaterSteam.PressureLosses.Diaphragm.svg)  

## Nomenclature  

| Symbol| Description| Unit| Definition| Modelica name |  
| :----------------- | :----------------------------------- | :------------------------------- | :--------------------------------------------------------------------------- | :----------- |  
| \\\\(D\\\\)| Diaphragm diameter| \\\\(\\mathrm{m}\\\\)|| D |  
| \\\\(h\\\\)| Fluid specific enthalpy | \\\\(\\mathrm{J} / \\mathrm{kg}\\\\)|| h |  
| \\\\(m\\\\)| Fluid mass flow rate| \\\\(\\mathrm{kg} / \\mathrm{s}\\\\)|| Q |  
| \\\\(P\\_{\\mathrm{i}}\\\\) | Fluid pressure at the inlet| \\\\(\\mathrm{Pa}\\\\)|| C1.P |  
| \\\\(P\\_{\\mathrm{o}}\\\\) | Fluid pressure at the outlet| \\\\(\\mathrm{Pa}\\\\)| \\\\(-\\\\)| C2.P |  
| \\\\(Re\\\\)| Reynolds number|| \\\\(\\frac{4 \\cdot \\lvert \\dot{m} \\rvert}{\\pi \\cdot D \\cdot \\mu \\cdot \\Omega}\\\\) | Re |  
| \\\\(Re\\_{\\lim }\\\\)| Limiting Reynolds number| \\\\(-\\\\)| \\\\(10^{5}\\\\)| Relim |  
| \\\\(\\zeta\\_{\\zeta}\\\\)| Fluid pressure loss| \\\\(\\mathrm{Pa}\\\\)| \\\\(P\\_{\\mathrm{i}}-P\\_{\\mathrm{o}}\\\\)| deltaP |  
| \\\\(\\mu\\\\)| Friction pressure loss coefficient| \\\\(-\\\\)|| khi |  
| \\\\(\\rho\\\\)| Fluid dynamic viscosity| \\\\(\\mathrm{Pa} \\mathrm{s}\\\\)|| mu |  
| \\\\(\\Omega\\\\)| Fluid density| \\\\(\\mathrm{kg} / \\mathrm{m}^{3}\\\\) || rho |  



## Governing equations  

### Static momentum balance equation  


    
    

- Validity domain:   
   
 \\\\(\\forall \\dot{m}\\\\)  

- Mathematical formulation:   
   
 $$\\Delta P=8 \\cdot \\zeta\\_{f} \\cdot \\frac{\\dot{m} \\cdot \\lvert \\dot{m} \\rvert}{\\pi^{2} \\cdot D^{4} \\cdot \\rho}$$  

- Comments:   
   



### Friction pressure loss coefficient  


    
    

- Validity domain:   
   
 \\\\(\\forall \\dot{m}\\\\) with \\\\(Re>Re\\_{lim}\\\\) and \\\\(\\Omega>0\\\\)  

- Mathematical formulation:   
   
 $$\\zeta\\_{f}=\\left\\(\\frac{1.707-\\Omega}{\\Omega}\\right\\)^{2}$$   

- Comments:   
   


## References   
   
El Hefni, Baligh and Bouskela, Daniel (2019). [Modeling and Simulation of Thermal Power Plants with ThermoSysPro](https://link.springer.com/book/10.1007/978-3-030-05105-1), sect. 13.7. Springer Nature Switzerland AG.  
    ", revisions = "
Author  

Daniel Bouskela   

    "));
end Diaphragm;