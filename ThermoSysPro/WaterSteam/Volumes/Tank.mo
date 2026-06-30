within ThermoSysPro.WaterSteam.Volumes;

model Tank "Open tank"
  parameter Units.SI.AbsolutePressure Patm = 1.013e5 "Pressure above the fluid level";
  parameter Units.SI.Area A = 1 "Tank cross sectional area";
  parameter Units.SI.Position ze1 = 40 "Altitude of inlet 1";
  parameter Units.SI.Position ze2 = de2/2 "Altitude of inlet 2";
  parameter Units.SI.Position zs1 = 40 "Altitude of outlet 1";
  parameter Units.SI.Position zs2 = ds2/2 "Altitude of outlet 2";
  parameter Units.SI.Diameter de1 = 0.20 "Diameter of inlet 1";
  parameter Units.SI.Diameter de2 = 0.20 "Diameter of inlet 2";
  parameter Units.SI.Diameter ds1 = 0.20 "Diameter of outlet 1";
  parameter Units.SI.Diameter ds2 = 0.20 "Diameter of outlet 2";
  parameter Units.SI.Position z0 = 30 "Initial fluid level (active if steady_state=false)";
  parameter Units.SI.SpecificEnthalpy h0 = 1.e5 "Initial fluid specific enthalpy (active if steady_state=false)";
  parameter Real ke1 = 1 "Pressure loss coefficient for inlet e1";
  parameter Real ke2 = 1 "Pressure loss coefficient for inlet e2";
  parameter Real ks1 = 1 "Pressure loss coefficient for outlet s1";
  parameter Real ks2 = 1 "Pressure loss coefficient for outlet s2";
  parameter Boolean dynamic_mass_balance = false "true: dynamic mass balance equation - false: static mass balance equation";
  parameter Boolean steady_state = false "true: start from steady state - false: start from h0";
  parameter Boolean steady_state_mech = false "true: start from steady state - false: start from z0";
  parameter Integer fluid = 1 "1: water/steam - 2: C3H3F5";
  parameter Units.SI.Density p_rho = 0 "If > 0, fixed fluid density";
  parameter Integer mode = 0 "IF97 region. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  Units.SI.Position z "Fluid level";
  Units.SI.Temperature T "Fluid temperature";
  Units.SI.AbsolutePressure P(start = 1.e5) "Fluid average pressure";
  Units.SI.SpecificEnthalpy h(start = 100000) "Fluid average specific enthalpy";
  Units.SI.Density rho(start = 998) "Fluid density";
  Units.SI.MassFlowRate BQ "Right hand side of the mass balance equation";
  Units.SI.Power BH "Right hand side of the energy balance equation";
  ThermoSysPro.Units.SI.PressureDifference deltaP_e1 "Presure loss for e1";
  ThermoSysPro.Units.SI.PressureDifference deltaP_e2 "Presure loss for e2";
  ThermoSysPro.Units.SI.PressureDifference deltaP_s1 "Presure loss for s1";
  ThermoSysPro.Units.SI.PressureDifference deltaP_s2 "Presure loss for s2";
  Real omega_e1;
  Real omega_e2;
  Real omega_s1;
  Real omega_s2;
  Units.SI.Angle theta_e1;
  Units.SI.Angle theta_e2;
  Units.SI.Angle theta_s1;
  Units.SI.Angle theta_s2;
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph pro "Water properties" annotation(
    Placement(transformation(extent = {{-100, 80}, {-80, 100}}, rotation = 0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal yLevel "Water level" annotation(
    Placement(transformation(extent = {{100, 10}, {120, 30}}, rotation = 0)));
  Connectors.FluidInlet Ce1 annotation(
    Placement(transformation(extent = {{-110, 50}, {-90, 70}}, rotation = 0)));
  Connectors.FluidOutlet Cs2 annotation(
    Placement(transformation(extent = {{90, -70}, {110, -50}}, rotation = 0)));
  ThermoSysPro.Thermal.Connectors.ThermalPort Cth annotation(
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Connectors.FluidInlet Ce2 annotation(
    Placement(transformation(extent = {{-110, -70}, {-90, -50}}, rotation = 0)));
  Connectors.FluidOutlet Cs1 annotation(
    Placement(transformation(extent = {{92, 50}, {112, 70}}, rotation = 0)));
protected
  parameter Units.SI.Acceleration g = Modelica.Constants.g_n "Gravity constant";
  parameter Real eps = 1.e-0 "Small number for ths square function";
  parameter Units.SI.Position zmin = 1.e-6 "Minimum fluid level";
  parameter Real pi = Modelica.Constants.pi;
initial equation
  if steady_state then
    der(h) = 0;
  else
    h = h0;
  end if;
  if steady_state_mech then
    der(z) = 0;
  else
    z = z0;
  end if;
equation
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
  if (cardinality(Cs1) == 0) then
    Cs1.Q = 0;
    Cs1.h = 1.e5;
    Cs1.a = true;
  end if;
  if (cardinality(Cs2) == 0) then
    Cs2.Q = 0;
    Cs2.h = 1.e5;
    Cs2.a = true;
  end if;
/* Mass balance equation */
  BQ = Ce1.Q + Ce2.Q - Cs1.Q - Cs2.Q;
  if dynamic_mass_balance then
    A*(pro.ddph*der(P) + pro.ddhp*der(h))*z + A*rho*der(z) = BQ;
  else
    A*rho*der(z) = BQ;
  end if;
/* Momentum balance equations */
  theta_e1 = if (z > ze1 + de1/2) then pi/2 else if (z < ze1 - de1/2) then -pi/2 else asin((z - ze1)/de1/2);
  theta_e2 = if (z > ze2 + de2/2) then pi/2 else if (z < ze2 - de2/2) then -pi/2 else asin((z - ze2)/de2/2);
  theta_s1 = if (z > zs1 + ds1/2) then pi/2 else if (z < zs1 - ds1/2) then -pi/2 else asin((z - zs1)/ds1/2);
  theta_s2 = if (z > zs2 + ds2/2) then pi/2 else if (z < zs2 - ds2/2) then -pi/2 else asin((z - zs2)/ds2/2);
  omega_e1 = if (Ce1.Q >= 0) then 1 else (pi + 2*theta_e1 + sin(2*theta_e1))/2/pi;
  omega_e2 = if (Ce2.Q >= 0) then 1 else (pi + 2*theta_e2 + sin(2*theta_e2))/2/pi;
  omega_s1 = if (Cs1.Q <= 0) then 1 else (pi + 2*theta_s1 + sin(2*theta_s1))/2/pi;
  omega_s2 = if (Cs2.Q <= 0) then 1 else (pi + 2*theta_s2 + sin(2*theta_s2))/2/pi;
  deltaP_e1 = Ce1.P - (Patm + rho*g*max(z - ze1, 0));
  deltaP_e2 = Ce2.P - (Patm + rho*g*max(z - ze2, 0));
  deltaP_s1 = Patm + rho*g*max(z - zs1, 0) - Cs1.P;
  deltaP_s2 = Patm + rho*g*max(z - zs2, 0) - Cs2.P;
  deltaP_e1*omega_e1^2 = ke1*ThermoSysPro.Functions.ThermoSquare(Ce1.Q, eps)/2/rho;
  deltaP_e2*omega_e2^2 = ke2*ThermoSysPro.Functions.ThermoSquare(Ce2.Q, eps)/2/rho;
  deltaP_s1*omega_s1^2 = ks1*ThermoSysPro.Functions.ThermoSquare(Cs1.Q, eps)/2/rho;
  deltaP_s2*omega_s2^2 = ks2*ThermoSysPro.Functions.ThermoSquare(Cs2.Q, eps)/2/rho;
/* Energy balance equation */
  BH = Ce1.Q*(Ce1.h - h) + Ce2.Q*(Ce2.h - h) - Cs1.Q*(Cs1.h - h) - Cs2.Q*(Cs2.h - h) + Cth.W;
  if (z > zmin) then
    A*rho*z*der(h) = BH;
  else
    der(h) = 0;
  end if;
  Ce1.h_vol = h;
  Ce2.h_vol = h;
  Cs1.h_vol = h;
  Cs2.h_vol = h;
  Cth.T = T;
/* Fluid level sensor */
  yLevel.signal = z;
/* Fluid thermodynamic properties */
  P = Patm + rho*g*z/2;
  pro = ThermoSysPro.Properties.Fluid.Ph(P, h, mode, fluid);
  T = pro.T;
  if (p_rho > 0) then
    rho = p_rho;
  else
    rho = pro.d;
  end if;
  annotation(
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics = {Rectangle(extent = {{-100, 20}, {100, -100}}, lineColor = {28, 108, 200}, fillColor = {85, 170, 255}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-100, 100}, {100, 20}})}),
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics = {Rectangle(extent = {{-100, 20}, {100, -100}}, lineColor = {28, 108, 200}, fillColor = {85, 170, 255}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-100, 100}, {100, 20}}, lineColor = {28, 108, 200})}),
    Window(x = 0.16, y = 0.03, width = 0.81, height = 0.9),
    Documentation(info = "
## Copyright © EDF 2002 - 2026  
## ThermoSysPro Version 4.2  
This component model is documented in Sect. 14.5 of the ThermoSysPro book.   
# Tank   

The tank is a reservoir containing water. It is modeled as an open volume with a constant sky pressure.   
The reservoir is assumed to be a vertical cylinder.   
The tank component models the mass and energy  of the input flows and a possible thermal exchange with the environment.  
The junctions between the tube and the tank are called *orifices*.  
Overflow through the orifices is taken into account.  


## Modelica component model  

The equations mentioned below are implemented in the component *Tank*, located in the *WaterSteam.Volumes* sub-library.   
This component has 6 connectors:  
- Ce1: fluid inlet,  
- Ce2: fluid inlet,  
- Cs1: fluid outlet,  
- Cs2: fluid outlet,  
- CTh: thermal port,  
- yLevel: water level output.  
   
![modelica://ThermoSysPro/UsersGuide/Documentation/ThermoSysPro.WaterSteam.Volumes.Tank.svg](modelica://ThermoSysPro/UsersGuide/Documentation/ThermoSysPro.WaterSteam.Volumes.Tank.svg)  

## Nomenclature  

| Symbol| Description| Unit| Definition| Modelica name |  
| :-------------------------------- | :--------------------------------------------------------------------------------------- | :------------------------------------------- | :----------------------------------------------------------------------------------------------------------- | :----------- |  
|\\\\(a\\_{\\mathrm{i}}\\\\) | Cross-sectional area of inlet i | \\\\(\\mathrm{m}\\\\)| | dei |  
|\\\\(a\\_{\\mathrm{o}}\\\\) | Cross-sectional area of outlet o | \\\\(\\mathrm{m}\\\\)|| dso |  
|\\\\(A\\\\) | Cross-sectional area of the liquid in the tank |\\\\(\\mathrm{m}^{2}\\\\) || A |  
|\\\\(h\\\\) | Specific enthalpy of the liquid in the tank |\\\\(\\mathrm{J} / \\mathrm{kg}\\\\) | | h |  
|\\\\(h\\_{\\mathrm{i}}\\\\) | Specific enthalpy of the liquid at inlet i | \\\\(\\mathrm{J} / \\mathrm{kg}\\\\) | | Cei.h |  
|\\\\(h\\_{\\mathrm{o}}\\\\) | Specific enthalpy of the liquid at outlet o | \\\\(\\mathrm{J} / \\mathrm{kg}\\\\) | | Cso.h |  
|\\\\(m\\_{\\mathrm{i}}\\\\) | Mass flow rate of the liquid at inlet i |\\\\(\\mathrm{kg} / \\mathrm{s}\\\\) || Cei.Q |  
|\\\\(\\dot{m}\\_{\\mathrm{o}}\\\\) | Mass flow rate of the liquid at outlet o |\\\\(\\mathrm{kg} / \\mathrm{s}\\\\) | | Cso.Q |  
|\\\\(P\\\\) | Liquid average pressure in the tank | \\\\(\\mathrm{Pa}\\\\)|\\\\(P\\_{\\text {atm}}+\\rho . \\mathrm{g} \\cdot z / 2\\\\)| P |  
|\\\\(P\\_{\\text {atm }}\\\\) | Pressure above the fluid level \\(sky pressure\\) | \\\\(\\mathrm{Pa}\\\\) || Patm |  
|\\\\(P\\_{\\mathrm{i}}\\\\) | Pressure of the liquid at inlet i | \\\\(\\mathrm{Pa}\\\\) | | Cei.P |  
|\\\\(P\\_{\\mathrm{o}}\\\\) | Pressure of the liquid at outlet o |\\\\(\\mathrm{Pa}\\\\) | | Cso.P |  
|\\\\(W\\\\) | Thermal power exchanged between the fluid and the heat source | \\\\(\\mathrm{W}\\\\) || Cth.W |  
|\\\\(z\\\\) | Liquid level in the tank | \\\\(\\mathrm{m}\\\\) | | z |  
|\\\\(z\\_{i}\\\\) | Altitude of inlet \\\\(i\\\\) | \\\\(\\mathrm{m}\\\\) || zei |  
|\\\\(z\\_{0}\\\\) | Altitude of outlet o | \\\\(\\mathrm{m}\\\\) | | zso |  
|\\\\(\\xi\\_{\\mathrm{i}}\\\\) | Pressure loss coefficient for inlet i | \\\\(-\\\\) | | kei |  
|\\\\(\\xi\\_{\\mathrm{o}}\\\\) | Pressure loss coefficient for outlet o | \\\\(-\\\\) | | kso |  
|\\\\(\\rho\\\\) | Liquid density in the tank | \\\\(\\mathrm{kg} / \\mathrm{m}^{3}\\\\) || rhp |  


## Governing equations  
    
    

### Dynamic mass balance equation  

- Validity domain:   
   
 \\\\(\\forall \\dot{m}\\\\) and \\\\(z>0\\\\)  

- Mathematical formulation:   
   
 $$\\rho \\cdot A \\cdot \\frac{\\mathrm{d} z}{\\mathrm{d} t}=\\sum\\_{\\mathrm{i}} \\dot{m}\\_{\\mathrm{i}}-\\sum\\_{\\mathrm{o}} \\dot{m}\\_{\\mathrm{o}}$$  

- Comments:   
   
 The fluid is incompressible \\(i.e., the partial derivatives of the density are zero\\).  


### Dynamic energy balance equation  


    
    

- Validity domain:   
   
 \\\\(\\forall \\dot{m}\\\\) and \\\\(z>0\\\\)  

- Mathematical formulation:   
   
 $$\\rho \\cdot A \\cdot z \\cdot \\frac{\\mathrm{d} h}{\\mathrm{d} t}=\\sum\\_{\\mathrm{i}} \\dot{m}\\_{\\mathrm{i}} \\cdot\\left\\(h\\_{\\mathrm{i}}-h\\right\\)+\\sum\\_{\\mathrm{o}} \\dot{m}\\_{\\mathrm{o}} \\cdot\\left\\(h\\_{\\mathrm{o}}-h\\right\\)+W$$  

- Comments:   
   
 The fluid is incompressible \\(i.e., the partial derivatives of the density are zero\\).  


### Pressure losses at the inlets  


    
    

- Validity domain:   
   
 \\\\(\\forall \\dot{m}\\_{i}\\\\)  

- Mathematical formulation:   
   
 $$\\Delta P\\_{\\mathrm{i}} \\cdot \\Omega\\_{\\mathrm{i}}^{2}=\\frac{1}{2} \\cdot \\xi\\_{i} \\cdot \\frac{\\dot{m}\\_{\\mathrm{i}} \\cdot\\lvert \\dot{m}\\_{\\mathrm{i}}\\rvert }{\\rho \\cdot a\\_{i}^{2}} \\quad \\text{with} \\quad \\Delta P\\_{\\mathrm{i}}=P\\_{\\mathrm{i}}-\\left\\(P\\_{\\mathrm{atm}}+\\rho \\cdot g \\cdot \\max \\left\\(z-z\\_{\\mathrm{i}}, 0\\right\\)\\right\\)$$  

- Comments:   
   
The orifice is modeled as a singular pressure loss that varies with the level of water:  
$$\\Delta P\\_{\\mathrm{i}}=\\frac{1}{2} \\cdot \\xi\\_{\\mathrm{i}} \\cdot \\frac{\\dot{m}\\_{\\mathrm{i}} \\cdot\\lvert \\dot{m}\\_{\\mathrm{i}}\\rvert }{\\rho \\cdot\\left\\(\\Omega\\_{\\mathrm{i}} \\cdot a\\_{\\mathrm{i}}\\right\\)^{2}}$$ where \\\\(\\Omega\\_{\\mathrm{i}}\\\\) is the ratio between the cross-sectional area of the flow through the orifice and the cross-sectional area of the tube to or from the orifice. When the orifice is empty, \\\\(\\Omega\\_{\\mathrm{i}}=0\\\\). When the orifice is full, \\\\(\\Omega\\_{\\mathrm{i}}=1\\\\).  

When \\\\(\\dot{m}\\_{\\mathrm{i}} \\geq 0\\\\) \\(direct flow\\), then \\\\(\\Omega\\_{\\mathrm{i}}=1 .\\\\) This means that the tube is always full when the fluid is entering the tank. Assuming uniform distribution of the flow velocity at the inlet, the pressure loss coefficient can be taken equal to unity \\\\(\\xi\\_{\\mathrm{i}}=1\\\\) When \\\\(\\dot{m}\\_{\\mathrm{i}}<0\\\\) \\(backflow\\), i.e., when the overflowing fluid is leaving the tank, \\\\(\\Omega\\_{\\mathrm{i}}\\\\) depends on the level of water w.r.t. the orifice.   

For a circular orifice of diameter \\\\(d\\_{\\mathrm{i}}\\\\):  
$$   \\Omega_{\\mathrm{i}}=\\left\\{\\begin{array}{l}   0 \\text{ for } z \\leq z_{i}-\\frac{d_{i}}{2} \\\\   1 \\text{ for } z \\geq z_{\\mathrm{i}}+\\frac{d_{\\mathrm{i}}}{2} \\\\   \\frac{\\pi+2 \\cdot \\theta_{i}+\\sin \\left(2 \\cdot \\theta_{i}\\right)}{2 \\cdot \\pi} \\text{ for } z_{i}-\\frac{d_{i}}{2} \\leq z \\leq z_{i}+\\frac{d_{i}}{2} \\\\   \\text{ with } \\theta_{\\mathrm{i}}=\\arcsin \\left(\\left(z-z_{\\mathrm{i}}\\right) / d_{\\mathrm{i}} / 2\\right)   \\end{array}\\right.$$  

For a square orifice of side \\\\(d\\_{\\mathrm{i}}\\\\):  
$$   \\Omega_{\\mathrm{i}}=\\left\\{\\begin{array}{l}   0 \\text{ for } z \\leq z_{i}-\\frac{d_{i}}{2} \\\\   1 \\text{ for } z \\geq z_{\\mathrm{i}}+\\frac{d_{\\mathrm{i}}}{2} \\\\   \\frac{z-z_{i}+d_{i} / 2}{d_{i}} \\text{ for } z_{i}-\\frac{d_{i}}{2} \\leq z \\leq z_{i}+\\frac{d_{i}}{2}   \\end{array}\\right.$$  
The value of \\\\(\\xi\\_{\\mathrm{i}}\\\\) depends on the geometry of the junction. If the junction is not protruding inside the tank, then one can take \\\\(\\xi\\_{\\mathrm{i}}=0.5\\\\).   


### Pressure losses at the outlets  


    
    

- Validity domain:   
   
 \\\\(\\forall \\dot{m}\\_{o}\\\\)  

- Mathematical formulation:   
   
 $$\\Delta P\\_{\\mathrm{o}} \\cdot \\Omega\\_{\\mathrm{o}}^{2}=\\frac{1}{2} \\cdot \\xi\\_{\\mathrm{o}} \\cdot \\frac{\\dot{m}\\_{\\mathrm{o}} \\cdot\\lvert \\dot{m}\\_{\\mathrm{o}}\\rvert }{\\rho \\cdot a\\_{\\mathrm{o}}^{2}} \\quad \\text{with} \\quad \\Delta P\\_{\\mathrm{o}}=P\\_{\\text {atm}}+\\rho \\cdot g \\cdot \\max \\left\\(z-z\\_{\\mathrm{o}}, 0\\right\\)-P\\_{\\mathrm{o}}$$  

- Comments:   
   
The phenomenon is similar to pressure losses at the inlet, except that the flow is leaving the tank when \\\\(\\dot{m}\\_{\\mathrm{o}}>0\\\\).  

## References   
   
El Hefni, Baligh and Bouskela, Daniel (2019). [Modeling and Simulation of Thermal Power Plants with ThermoSysPro](https://link.springer.com/book/10.1007/978-3-030-05105-1), sect. 14.5. Springer Nature Switzerland AG.  
    ", revisions = "
Author  

Daniel Bouskela   

    "));
end Tank;