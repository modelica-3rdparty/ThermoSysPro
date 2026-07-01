within ThermoSysPro.WaterSteam.PressureLosses;

model Bend "Bend"
  parameter Units.SI.Diameter D = 0.2 "Pipe diameter";
  parameter Units.SI.Radius R0 = 0.2 "Pipe radius";
  parameter ThermoSysPro.Units.nonSI.Angle_deg delta = 90 "Pipe angle";
  parameter Real rugosrel = 0 "Pipe roughness";
  parameter Boolean K_A1_Tabule = true "true: A1 is computed using linear interpolation - false: A1 is computed using correlation formula";
  parameter Boolean K_B1_Tabule = true "true: B1 is computed using linear interpolation - false: B1 is computed using correlation formula";
  parameter Boolean continuous_flow_reversal = false "true: continuous flow reversal - false: discontinuous flow reversal";
  parameter Integer fluid = 1 "1: water/steam - 2: C3H3F5";
  parameter Units.SI.Density p_rho = 0 "If > 0, fixed fluid density";
  parameter Integer mode = 0 "IF97 region. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  Real khi "Hydraulic pressure loss coefficient";
  Real khim "Singular pressure loss coefficient";
  Real khif "Friction pressure loss coefficient";
  Real kdelta "Roughness factor for the singular pressure loss";
  ThermoSysPro.Units.SI.PressureDifference deltaP "Presure loss";
  Units.SI.MassFlowRate Q "Mass flow rate";
  Units.SI.ReynoldsNumber Re "Reynolds number";
  Units.SI.ReynoldsNumber Relim "Limit Reynolds number";
  Real yA1 "Output of table A1";
  Real yB1 "Output of table B1";
  Real yC1 "Output of table C1";
  Real lambda "Friction pressure loss coefficient";
  Units.SI.Density rho "Fluid density";
  Units.SI.DynamicViscosity mu "Fluid dynamic viscosity";
  Units.SI.Temperature T "Fluid temperature";
  Units.SI.AbsolutePressure Pm "Fluid average pressure";
  Units.SI.SpecificEnthalpy h "Fluid specific enthalpy";
  ThermoSysPro.InstrumentationAndControl.Blocks.Tables.Table1D TA1(Table = [0, 0; 20, 0.31; 30, 0.45; 45, 0.60; 60, 0.78; 75, 0.90; 90, 1; 110, 1.13; 130, 1.20; 150, 1.28; 180, 1.40]) annotation(
    Placement(transformation(extent = {{-20, 80}, {0, 100}}, rotation = 0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Tables.Table1D TB1(Table = [0.5, 1.18; 0.6, 0.77; 0.7, 0.51; 0.8, 0.37; 0.9, 0.28; 1, 0.21; 1.25, 0.19; 1.50, 0.17; 2, 0.15; 4, 0.11; 6, 0.09; 8, 0.07; 10, 0.07; 15, 0.06; 20, 0.05; 25, 0.05; 30, 0.04; 35, 0.04; 40, 0.03; 45, 0.03; 50, 0.03]) annotation(
    Placement(transformation(extent = {{20, 80}, {40, 100}}, rotation = 0)));
  Connectors.FluidInlet C1 annotation(
    Placement(transformation(extent = {{-110, -10}, {-90, 10}}, rotation = 0)));
  Connectors.FluidOutlet C2 annotation(
    Placement(transformation(extent = {{-10, -110}, {10, -90}}, rotation = 0)));
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
  h = C1.h;
  Q = C1.Q;
/* Flow reversal */
  if continuous_flow_reversal then
    0 = noEvent(if (Q > Qeps) then C1.h - C1.h_vol else if (Q < -Qeps) then C2.h - C2.h_vol else C1.h - 0.5*((C1.h_vol - C2.h_vol)*Modelica.Math.sin(pi*Q/2/Qeps) + C1.h_vol + C2.h_vol));
  else
    0 = if (Q > 0) then C1.h - C1.h_vol else C2.h - C2.h_vol;
  end if;
/* Pressure loss */
  deltaP = 8*khi*ThermoSysPro.Functions.ThermoSquare(Q, eps)/(pi^2*D^4*rho);
/* Coude à parois concentriques (Idel'cik p. 192). Quadratic flow regime is assumed and Re > 2e5 (Re > Relim). */
  assert(R0/D > 0.5, "Coude: on doit avoir R0/D > 0.5");
  assert((delta > 0) and not (delta > 180), "Bend: parameter delta should be such as 0° < delta <= 180°");
  khi = kdelta*khim + khif;
  khim = yA1*yB1*yC1;
  TA1.u.signal = delta;
  if (K_A1_Tabule) then
    yA1 = TA1.y.signal;
  else
    yA1 = if (delta < 70) then 0.9*sin(delta) else if (delta > 100) then 0.7 + 0.35*delta/90 else 1.0;
  end if;
  TB1.u.signal = R0/D;
  if (K_B1_Tabule) then
    yB1 = TB1.y.signal;
  else
    yB1 = if (R0/D < 1) then 0.21/(R0/D)^2.5 else 0.21/(R0/D)^0.5;
  end if;
  yC1 = 1;
  kdelta = if ((rugosrel < 0.001)) and (R0/D < 1.5) then 1.0 + 1.e3*rugosrel else if (rugosrel < 0.001) then 1.0 + 1.e6*rugosrel^2 else 2.0;
  khif = 0.0175*lambda*R0*delta/D;
  if (rugosrel > 0.00005) then
    lambda = 1/(2*Modelica.Math.log10(3.7/rugosrel))^2;
  else
    lambda = if noEvent(Re > 0) then 1/(1.8*Modelica.Math.log10(Re) - 1.64)^2 else 0;
  end if;
  Relim = if (rugosrel > 0.00005) then max(560/rugosrel, 2.e5) else 2.e5;
  Re = 4*abs(Q)/(pi*D*mu);
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
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics = {Rectangle(extent = {{-100, 20}, {-20, -20}}, lineColor = {0, 0, 255}, fillColor = {127, 255, 0}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-20, -18}, {20, -100}}, lineColor = {0, 0, 255}, fillColor = {127, 255, 0}, fillPattern = FillPattern.Solid), Polygon(points = {{-20, 20}, {-12, 20}, {-2, 18}, {6, 14}, {12, 10}, {18, 2}, {20, -6}, {20, -18}, {-20, 20}}, lineColor = {0, 0, 255}, fillColor = {127, 255, 0}, fillPattern = FillPattern.Solid), Polygon(points = {{-20, 20}, {-20, -20}, {20, -18}, {-20, 20}}, lineColor = {127, 255, 0}, fillColor = {127, 255, 0}, fillPattern = FillPattern.Solid), Polygon(points = {{-30, -20}, {-24, -22}, {-22, -24}, {-20, -28}, {-20, -20}, {-30, -20}}, lineColor = {192, 192, 192}, fillColor = {127, 255, 0}, fillPattern = FillPattern.Solid), Line(points = {{-30, -20}, {-24, -22}, {-22, -24}, {-20, -28}}, color = {0, 0, 255})}),
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics = {Rectangle(extent = {{-100, 20}, {-20, -20}}, lineColor = {0, 0, 255}, fillColor = {127, 255, 0}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-20, -18}, {20, -100}}, lineColor = {0, 0, 255}, fillColor = {127, 255, 0}, fillPattern = FillPattern.Solid), Polygon(points = {{-20, 20}, {-12, 20}, {-2, 18}, {6, 14}, {12, 10}, {18, 2}, {20, -6}, {20, -18}, {-20, 20}}, lineColor = {0, 0, 255}, fillColor = {127, 255, 0}, fillPattern = FillPattern.Solid), Polygon(points = {{-20, 20}, {-20, -20}, {20, -18}, {-20, 20}}, lineColor = {127, 255, 0}, fillColor = {127, 255, 0}, fillPattern = FillPattern.Solid), Polygon(points = {{-30, -20}, {-24, -22}, {-22, -24}, {-20, -28}, {-20, -20}, {-30, -20}}, lineColor = {192, 192, 192}, fillColor = {127, 255, 0}, fillPattern = FillPattern.Solid), Line(points = {{-30, -20}, {-24, -22}, {-22, -24}, {-20, -28}})}),
    Window(x = 0.04, y = 0.1, width = 0.84, height = 0.67),
    Documentation(info = "
## Copyright © EDF 2002 - 2026  
## ThermoSysPro Version 4.2  
This component model is documented in Sect. 13.6 of the ThermoSysPro book.   

# Bend   
   
The bend models the singular pressure loss of a fluid circulating inside a bend pipe. For water/steam, the flow regime can be single-phase or homogeneous two-phase flow.   

Following assumptions are made:  
- The flow inside pressure losses is adiabatic. Non-adiabatic pipes must be  
modeled by connecting pressure losses to volumes.  
- The specific enthalpy inside the components is equal to the specific enthalpy at the inlet.  
- The properties of the fluid are computed for the average pressure..  
- Inertia due to momentum inside pipes is neglected.  

The friction pressure loss coefficient is calculated using the geometry of the bend. The bend thus completes the [singular pressure loss component](modelica://ThermoSysPro.WaterSteam.PressureLosses.SingularPressureLoss), in which the pressure loss coefficient is a single parameter.  

## Modelica component model  

The equations mentioned below are implemented in the component *Bend*, located in the *WaterSteam.PressureLosses* sub-library.   
This component has 2 connectors:  
- C1: fluid inlet,  
- C2: fluid outlet.  
   
![modelica://ThermoSysPro/UsersGuide/Documentation/ThermoSysPro.WaterSteam.PressureLosses.Bend.svg](modelica://ThermoSysPro/UsersGuide/Documentation/ThermoSysPro.WaterSteam.PressureLosses.Bend.svg)  

## Nomenclature  

| Symbol| Description| Unit| Definition| Modelica name |  
| :------------------ | :------------------------------------------------ | :------------------------------- | :-------------------------------------------------------------- | :----------- |  
| \\\\(A\\_{1}\\\\)| Factor for the singular pressure loss coefficient | \\\\(-\\\\)|| yA1 |  
| \\\\(B\\_{1}\\\\)| Factor for the singular pressure loss coefficient | \\\\(-\\\\)|| yB1 |  
| \\\\(C\\_{1}\\\\)| Factor for the singular pressure loss coefficient | \\\\(-\\\\)|| yC1 |  
| \\\\(D\\\\)| Internal diameter of the bend| \\\\(\\mathrm{m}\\\\)|| D |  
| \\\\(h\\\\)| Fluid specific enthalpy at the inlet| \\\\(\\mathrm{J} / \\mathrm{kg}\\\\)|| h |  
| \\\\(K\\_{\\varepsilon}\\\\) | Roughness factor| \\\\(-\\\\)|| kdelta |  
| \\\\(\\dot{m}\\\\)| Fluid mass flow rate| \\\\(\\mathrm{kg} / \\mathrm{s}\\\\)|| Q |  
| \\\\(P\\_{\\mathrm{i}}\\\\)| Fluid pressure at the inlet| \\\\(\\mathrm{Pa}\\\\)|| C1.P |  
| \\\\(P\\_{\\mathrm{o}}\\\\)| Fluid pressure at the outlet| \\\\(\\mathrm{Pa}\\\\)|| C2.P |  
| \\\\(R\\\\)| Bend radius| \\\\(\\mathrm{m}\\\\)|| R0 |  
| \\\\(Re\\\\)| Reynolds number| \\\\(-\\\\)| \\\\(\\frac{4 \\cdot \\lvert \\dot{m} \\rvert}{\\pi \\cdot D \\cdot \\mu}\\\\) | Re |  
| \\\\(Re\\_{\\lim }\\\\)| limiting Reynolds number| \\\\(-\\\\)|| Relim |  
| \\\\(\\delta\\\\)| Bend angle| \\\\(\\circ\\\\)|| delta |  
| \\\\(\\Delta P\\\\)| Pressure loss between the inlet and the outlet| \\\\(\\mathrm{Pa}\\\\)| \\\\(P\\_{\\mathrm{i}}-P\\_{\\mathrm{o}}\\\\)| deltaP |  
| \\\\(\\varepsilon\\\\)| Pipe roughness| \\\\(\\mathrm{m}\\\\)|| rugosrel |  
| \\\\(\\zeta\\\\)| Hydraulic pressure loss coefficient| \\\\(-\\\\)|| khi |  
| \\\\(\\zeta\\_{m}\\\\)| singular pressure loss coefficient| \\\\(-\\\\)|| khim |  
| \\\\(\\zeta\\_{f}\\\\)| Friction pressure loss coefficient| \\\\(-\\\\)|| khif |  
| \\\\(\\lambda\\\\)| Friction pressure loss coefficient| \\\\(-\\\\)|| lambda |  
| \\\\(\\mu\\\\)| Fluid dynamic viscosity| \\\\(\\mathrm{Pa} \\mathrm{s}\\\\)|| mu |  
| \\\\(\\rho\\\\)| Fluid density| \\\\(\\mathrm{kg} / \\mathrm{m}^{3}\\\\) || rho |  



## Governing equations  

### Static momentum balance equation  


    
    

- Validity domain:   
   
 \\\\(\\forall \\dot{m}\\\\)  

- Mathematical formulation:   
   
 $$\\Delta P=8 \\cdot \\zeta \\cdot \\frac{\\dot{m} \\cdot \\lvert \\dot{m} \\rvert}{\\pi^{2} \\cdot D^{4} \\cdot \\rho}$$  

- Comments:   
   

### Hydraulic pressure loss coefficient  

- Validity domain:  

\\\\(\\forall \\dot{m}\\\\) with \\\\(Re>Re\\_{\\lim }\\\\)  

- Mathematical formulation:   

$$\\zeta=K\\_{\\varepsilon} \\cdot \\zeta\\_{m}+\\zeta\\_{f}$$  

$$   K_{\\varepsilon} = \\left\\{ \\begin{array}{l}   2 \\; \\text{if} \\; \\varepsilon \\geq 10^{-3} \\\\   1 + 10^3 \\cdot \\varepsilon \\; \\text{if} \\; \\varepsilon<10^{-3} \\; \\text{and} \\; \\frac{R}{D}<1.5 \\\\   1 + 10^6 \\cdot \\varepsilon^2 \\; \\text{if} \\; \\varepsilon<10^{-3} \\; \\text{and} \\; \\frac{R}{D} \\geq 1.5   \\end{array} \\right.$$  

$$\\zeta\\_{f}=0.0175 \\cdot \\lambda \\cdot \\frac{R}{D} \\cdot \\delta$$  
$$\\zeta\\_{m}=A\\_{1} \\cdot B\\_{1} \\cdot C\\_{1}$$  

- Comments:  

The limiting Reynolds number is given by:  

$$   Re_{\\lim } = \\left\\{ \\begin{array}{l}   2 \\times 10^{5} \\; \\text{if} \\; \\varepsilon<5 \\times 10^{-5} \\\\   \\max \\left(\\frac{560}{\\varepsilon}, 2 \\times 10^{5}\\right) \\; \\text{if} \\; \\varepsilon \\geq 5 \\times 10^{-5}   \\end{array} \\right.$$  

## References   
   
El Hefni, Baligh and Bouskela, Daniel (2019). [Modeling and Simulation of Thermal Power Plants with ThermoSysPro](https://link.springer.com/book/10.1007/978-3-030-05105-1), sect. 13.6. Springer Nature Switzerland AG.  
    ", revisions = "
Author  

Daniel Bouskela   

    "));
end Bend;