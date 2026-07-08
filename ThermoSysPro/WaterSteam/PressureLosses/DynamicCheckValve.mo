within ThermoSysPro.WaterSteam.PressureLosses;

model DynamicCheckValve "Dynamic check valve"
  parameter ThermoSysPro.Units.xSI.Cv Cvmax = 8005.42 "Maximum CV [USG/min]";
  parameter Real caract[:, 2] = [0, 0; 1, Cvmax] "Position vs. Cv [USG/min] characteristics (active if mode_caract=1)";
  parameter Units.SI.MomentOfInertia J = 1 "Flap moment of inertia";
  parameter Real Kf1 = 0 "Flap friction law coefficient #1";
  parameter Real Kf2 = 100 "Flap friction law coefficient #2";
  parameter Real n = 5 "Flap friction law exponent";
  parameter Units.SI.Mass m = 1 "Flap mass";
  parameter Units.SI.Area A = 1 "Flap hydraulic area";
  parameter Real Ouv0 = 0 "Initial valve position, between 0 and 1. 0:valve closed - 1: valve open (active if permanent_meca = false)";
  parameter Integer mode_caract = 0 "0:linear characteristics - 1:characteristics is given by caract[]";
  parameter Integer option_interpolation = 1 "1: linear interpolation - 2: spline interpolation (active if mode_caract=1)";
  parameter Boolean mech_steady_state = true "true: start from mechanical steady state - false: start from 0";
  parameter Boolean continuous_flow_reversal = false "true: continuous flow reversal - false: discontinuous flow reversal";
  parameter Integer fluid = 1 "1: water/steam - 2: C3H3F5";
  parameter Units.SI.Density p_rho = 0 "If > 0, fixed fluid density";
  parameter Integer mode = 0 "IF97 region. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  Boolean libre(start = true) "Indicator whether the flap is free to move in both directions";
  Units.SI.Torque Cp "Gravity torque";
  Units.SI.Torque Cf "Friction torque";
  Units.SI.Torque Ch "Hydraulic torque";
  Units.SI.Torque Ct "Total torque";
  Units.SI.Angle theta(start = theta_m) "Flap aperture angle";
  Units.SI.AngularVelocity omega "Flap angular speed";
  Units.SI.AngularAcceleration a "Flap angular acceleration";
  Real Ouv "Valve position";
  ThermoSysPro.Units.xSI.Cv Cv(start = Cvmax) "Cv [USG/min]";
  Units.SI.MassFlowRate Q(start = 500) "Mass flow rate";
  ThermoSysPro.Units.SI.PressureDifference deltaP "Singular pressure loss";
  Units.SI.Density rho(start = 998) "Fluid density";
  Units.SI.Temperature T(start = 290) "Fluid temperature";
  Units.SI.AbsolutePressure Pm(start = 1.e5) "Fluid average pressrue";
  Units.SI.SpecificEnthalpy h(start = 100000) "Fluid specific enthalpy";
  Connectors.FluidInlet C1 annotation(
    Placement(transformation(extent = {{-110, -10}, {-90, 10}}, rotation = 0)));
  Connectors.FluidOutlet C2 annotation(
    Placement(transformation(extent = {{90, -10}, {110, 10}}, rotation = 0)));
protected
  constant Real pi = Modelica.Constants.pi "pi";
  parameter Units.SI.Acceleration g = Modelica.Constants.g_n "Gravity constant";
  parameter Real eps = 1.e-3 "Small number for pressure loss equation";
  parameter Units.SI.Radius r = sqrt(A/pi) "Flap radius";
  parameter Units.SI.Angle theta_min = 0 "Minimum flap aperture angle";
  parameter Units.SI.Angle theta_max = pi/2 "Maximum flap aperture angle";
  parameter Units.SI.Angle theta_m = (theta_min + theta_max)/2;
  parameter Units.SI.MassFlowRate Qeps = 1.e-3 "Small mass flow for continuous flow reversal";
protected
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph pro "Propriétés de l'eau" annotation(
    Placement(transformation(extent = {{-100, 80}, {-80, 100}}, rotation = 0)));
initial equation
  if mech_steady_state then
    der(theta) = 0;
    der(omega) = 0;
  else
    assert((0 <= Ouv0) and (Ouv0 <= 1), "DynamickCheckValve: Ouv0 should be between 0 and 1");
    theta = acos(1 - Ouv0);
    omega = 0;
  end if;
equation
  C1.h = C2.h;
  C1.Q = C2.Q;
  h = C1.h;
  Q = C1.Q;
  deltaP = C1.P - C2.P;
/* Flow reversal */
  if continuous_flow_reversal then
    0 = noEvent(if (Q > Qeps) then C1.h - C1.h_vol else if (Q < -Qeps) then C2.h - C2.h_vol else C1.h - 0.5*((C1.h_vol - C2.h_vol)*Modelica.Math.sin(pi*Q/2/Qeps) + C1.h_vol + C2.h_vol));
  else
    0 = if (Q > 0) then C1.h - C1.h_vol else C2.h - C2.h_vol;
  end if;
/* Flap angle */
  Ouv = 1 - cos(theta);
  omega = der(theta);
  a = der(omega);
  Cp = -m*g*r*sin(theta);
  Cf = -sign(omega)*(Kf1 + Kf2*abs(omega)^n);
  Ch = deltaP*r*A*cos(theta);
  Ct = Cp + Cf + Ch;
  libre = ((theta > theta_min) and (theta < theta_max)) or ((theta <= theta_min) and (Ct > 0)) or ((theta >= theta_max) and (Ct < 0));
  if libre then
    J*a = Ct;
  else
    a = 0;
  end if;
  when {theta <= theta_min, theta >= theta_max} then
    reinit(omega, 0);
  end when;
/* Pressure loss */
  deltaP*Cv*abs(Cv) = 1.733e12*ThermoSysPro.Functions.ThermoSquare(Q, eps)/rho^2;
/* Cv as a function of the valve position */
  if (mode_caract == 0) then
    Cv = Ouv*Cvmax;
  elseif (mode_caract == 1) then
    if (option_interpolation == 1) then
      Cv = ThermoSysPro.Functions.LinearInterpolation(caract[:, 1], caract[:, 2], Ouv);
    elseif (option_interpolation == 2) then
      Cv = ThermoSysPro.Functions.SplineInterpolation(caract[:, 1], caract[:, 2], Ouv);
    else
      assert(false, "DynamicCheckValve: incorrect interpolation option");
    end if;
  else
    assert(false, "ClapetDyn : mode de calcul du Cv incorrect");
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
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics = {Ellipse(extent = {{-70, 70}, {-50, 50}}, lineColor = {170, 85, 255}, fillColor = {170, 85, 255}, fillPattern = FillPattern.Solid), Line(points = {{-60, -60}, {-60, 60}, {60, -60}, {60, 60}}, color = {170, 85, 255}, thickness = 0.5), Line(points = {{-100, 0}, {-60, 0}}), Line(points = {{60, 0}, {100, 0}}), Text(extent = {{-28, 80}, {32, 20}}, textString = "D")}),
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics = {Ellipse(extent = {{-70, 70}, {-50, 50}}, lineColor = {170, 85, 255}, fillColor = {170, 85, 255}, fillPattern = FillPattern.Solid), Line(points = {{-60, -60}, {-60, 60}, {60, -60}, {60, 60}}, color = {170, 85, 255}, thickness = 0.5), Line(points = {{-100, 0}, {-60, 0}}), Line(points = {{60, 0}, {100, 0}}), Text(extent = {{-28, 80}, {32, 20}}, textString = "D")}),
    Window(x = 0.08, y = 0.01, width = 0.81, height = 0.87),
    Documentation(info = "
## Copyright © EDF 2002 - 2026   
## ThermoSysPro Version 4.2  
This component model is documented in Sect. 13.12 of the ThermoSysPro book.   
# Dynamic check valve   

The dynamic check valve is modeled as a control valve which position is controlled by the flow through the clapper aperture.  
The inertia of the movement of the clapper is taken into account, contrary to the [check valve](modelica://ThermoSysPro.WaterSteam.PressureLosses.CheckValve).  
The model presented here only accounts for clapper check valves.  


## Modelica component model  

The equations mentioned below are implemented in the component *DynamicCheckValve*, located in the *WaterSteam.PressureLosses* sub-library.   
This component has 2 connectors:  
- C1: fluid inlet,  
- C2: fluid outlet.  
   
![modelica://ThermoSysPro/UsersGuide/Documentation/ThermoSysPro.WaterSteam.PressureLosses.DynamicCheckValve.svg](modelica://ThermoSysPro/UsersGuide/Documentation/ThermoSysPro.WaterSteam.PressureLosses.DynamicCheckValve.svg)  

## Nomenclature  

| Symbol| Description| Unit| Definition| Modelica name |  
| :----------------------------------------------- | :------------------------------------------------------------------------------------- | :------------------------------- | :-------------------------------- | :----------- |  
| \\\\(A\\\\)| Clapper hydraulic area| \\\\(\\mathrm{m}^{2}\\\\)|| A |  
| \\\\(C\\_{\\mathrm{f}}\\\\)| Friction torque acting on the clapper| \\\\(\\mathrm{N} \\mathrm{m}\\\\)|| Cf |  
| \\\\(C\\_{\\mathrm{h}}\\\\)| Hydraulic torque acting on the clapper| \\\\(\\mathrm{N} \\mathrm{m}\\\\)|| Ch |  
| \\\\(C\\_{\\mathrm{s}}\\\\)| Spring torque acting on the clapper| \\\\(\\mathrm{N} \\mathrm{m}\\\\)|| - |  
| \\\\(C\\_{\\mathrm{t}}\\\\)| Total torque acting on the clapper| \\\\(\\mathrm{N} \\mathrm{m}\\\\)|| Ct |  
| \\\\(C\\_{\\mathrm{v}}\\\\)| Flow coefficient of the valve| U.S. [USG/min]|| Cv |  
| \\\\(C\\_{\\mathrm{w}}\\\\)| Weight torque acting on the clapper| \\\\(\\mathrm{N} \\mathrm{m}\\\\)|| Cp |  
| \\\\(g\\\\)| Gravity constant| \\\\(\\mathrm{m} / \\mathrm{s}^{2}\\\\)|| g_n |  
| \\\\(h\\\\)| Fluid specific enthalpy | \\\\(\\mathrm{J} / \\mathrm{kg}\\\\)|| h |  
| \\\\(J\\\\)| Clapper moment of inertia| \\\\(\\mathrm{kg} \\mathrm{m}^{2}\\\\)|| J |  
| \\\\(K\\_{1}\\\\)| Clapper friction law coefficient| \\\\(-\\\\)|| Kf1 |  
| \\\\(K\\_{2}\\\\)| Clapper friction law coefficient| \\\\(-\\\\)|| Kf2 |  
| \\\\(m\\\\)| Fluid mass flow rate through the valve| \\\\(\\mathrm{kg} / \\mathrm{s}\\\\)|| Q |  
| \\\\(M\\\\)| Clapper mass| \\\\(\\mathrm{kg}\\\\)|| m |  
| \\\\(n\\\\)| Clapper friction law exponent| \\\\(-\\\\)|| n |  
| \\\\(P\\_{\\mathrm{i}}\\\\)| Fluid pressure at the valve inlet| \\\\(\\mathrm{Pa}\\\\)|| C1.P |  
| \\\\(P\\_{\\mathrm{o}}\\\\)| Fluid pressure at the valve outlet| \\\\(\\mathrm{Pa}\\\\)|| C2.P |  
| \\\\(r\\\\)| Clapper radius| \\\\(\\mathrm{m}\\\\)| \\\\(\\frac{A}{\\pi}\\\\)| r |  
| \\\\(\\Delta P\\\\)| Fluid pressure loss between the inlet and the outlet| \\\\(\\mathrm{Pa}\\\\)| \\\\(P\\_{\\mathrm{i}}-P\\_{\\mathrm{o}}\\\\) | deltaP |  
| \\\\(\\theta\\\\)| Clapper aperture angle| \\\\(\\mathrm{rad}\\\\)|| theta |  
| \\\\(\\theta\\_{\\min }\\\\)| Minimum clapper aperture angle \\(valve fully closed\\)| \\\\(\\mathrm{rad}\\\\)|| theta_min |  
| \\\\(\\theta\\_{\\max }\\\\)| Maximum clapper aperture angle \\(valve fully open\\)| \\\\(\\mathrm{rad}\\\\)|| theta_max |  
| \\\\(\\rho\\\\)| Fluid density| \\\\(\\mathrm{kg} / \\mathrm{m}^{3}\\\\) || rho |  
| \\\\(\\rho\\_{\\text {water, } 60^{\\circ} \\mathrm{F}}\\\\) | Density of water at \\\\(60^{\\circ} \\mathrm{F}\\left\\(15.5556^{\\circ} \\mathrm{C}\\right\\) .\\\\) | \\\\(\\mathrm{kg} / \\mathrm{m}^{3}\\\\) || - |  
| \\\\(\\omega\\\\)| Clapper angular velocity| \\\\(\\mathrm{rad} / \\mathrm{s}\\\\)|| omega |  
| \\\\(\\Omega\\\\)| Valve position| \\\\(-\\\\)| \\\\(1-\\cos \\(\\theta\\)\\\\)| Ouv |  



## Governing equations  

### Static momentum balance equation  


- Validity domain:   
   
 \\\\(\\forall \\dot{m}\\\\) and \\\\(C\\_{\\mathrm{v}} \\geq 0\\\\). For \\\\(C\\_{\\mathrm{v}}=0, \\Delta P\\\\) must be defined.  

- Mathematical formulation:   
   
 $$\\Delta P \\cdot C\\_{\\mathrm{v}} \\cdot \\lvert C\\_{\\mathrm{v}} \\rvert  
=1.732189 \\times 10^{12} \\cdot \\frac{\\dot{m} \\cdot \\lvert \\dot{m} \\rvert  
}{\\rho \\cdot \\rho\\_{\\text {water,60 }^{\\circ} F}}$$  

- Comments:   
   
 This equation is the same as the control valve’s  \\\\(C\\_{\\mathrm{v}}=f\\_{v}\\(\\Omega\\)\\\\) where \\\\(f\\_{v}\\\\) is the valve characteristic.  


###  Clapper equation  

- Validity domain:  

\\\\( \\theta\\_{\\min} \\leq \\theta \\leq \\theta\\_{\\max} \\\\)  

- Mathematical formulation:   

$$   J \\cdot \\frac{\\mathrm{d} \\omega}{\\mathrm{d}t}=\\left\\{\\begin{array}{l} C_{\\mathrm{t}} \\text{ if } \\theta_{\\min }<\\theta<\\theta_{\\max } \\\\   C_{\\mathrm{t}} \\text{ if } \\theta \\leq \\theta_{\\min } \\text{ and } C_{\\mathrm{t}}>0 \\\\   C_{\\mathrm{t}} \\text{ if } \\theta \\geq \\theta_{\\max } \\text{ and } C_{\\mathrm{t}}<0 \\\\   0  \\text{ else }\\end{array}\\right.$$  

$$   \\omega=\\left\\{\\begin{array}{l}\\frac{\\mathrm{d} \\theta}{\\mathrm{d} t}    \\text{ when } \\theta_{\\min }<\\theta<\\theta_{\\max } \\\\   0 \\text{ when } \\theta \\leq \\theta_{\\min } \\text{ or } \\theta \\geq \\theta_{\\max }\\end{array}\\right.$$  

$$   C_{\\mathrm{t}} = C_{\\mathrm{w}}+C_{\\mathrm{s}} +C_{\\mathrm{f}}+ C_{\\mathrm{h}} \\\\   C_{\\mathrm{w}} = -M \\cdot g \\cdot r \\cdot \\sin(\\theta) \\\\   C_{\\mathrm{f}} = -\\operatorname{sign}(\\omega) \\cdot \\left(K_{1}+K_{2} \\cdot \\lvert\\omega \\rvert^{n}\\right) \\\\   C_{\\mathrm{h}} = \\Delta P \\cdot A \\cdot r \\cdot \\cos(\\theta)$$  

- Comments:  

The angular velocity and acceleration are set to zero when the clapper hits  
the mechanical stops. The equal sign is replaced by \\\\(\\leq\\\\) or \\\\(\\geq\\\\) in the transition conditions \\\\(\\theta=\\theta\\_{\\min }\\\\) and \\\\(\\theta=\\theta\\_{\\max }\\\\) because equal signs are not recognized by solvers to compare real values.  

## References   
   
El Hefni, Baligh and Bouskela, Daniel (2019). [Modeling and Simulation of Thermal Power Plants with ThermoSysPro](https://link.springer.com/book/10.1007/978-3-030-05105-1), sect. 13.1. Springer Nature Switzerland AG.  
    ", revisions = "
Author  

Daniel Bouskela   

    "));
end DynamicCheckValve;
