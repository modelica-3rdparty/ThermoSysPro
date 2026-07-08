within ThermoSysPro.WaterSteam.PressureLosses;

model DynamicReliefValve "Dynamic relief valve"
  parameter Units.SI.AbsolutePressure Popen = 3e5 "Pressure that opens the valve";
  parameter Units.SI.AbsolutePressure Pout = 1e5 "Pressure at the valve outlet (for sizing)";
  parameter ThermoSysPro.Units.xSI.Cv Cvmax = 8005.42 "Maximum Cv [USG/min]";
  parameter Real caract[:, 2] = [0, 0; 1, Cvmax] "Position vs. Cv [USG/min] characteristics (active if mode_caract=1)";
  parameter Units.SI.Area A1 = 0.1 "Hydraulic area upstream the clapper";
  parameter Units.SI.Area A2 = 0.125 "Hydraulic area downstream the clapper";
  parameter Units.SI.Area clapper_area[:, 2] = [0, A1; 0.01, A2; 1, A2] "Clapper area as a function of the clapper elevation";
  parameter Real D = 1 "Damping";
  parameter Units.SI.Mass m = 1 "Valve mass";
  parameter Units.SI.Length z_max = 0.1 "Maximum clapper elevation";
  parameter Units.SI.Length z0 = 0 "Initial clapper elevation, between 0 and z_max. 0:valve closed - z_max: valve fully open (active if permanent_meca = false)";
  parameter Real Ke = 62500 "Valve spring stiffness";
  parameter Real Cd = 0 "Drag coefficient of the clapper";
  parameter Integer mode_caract = 0 "0:linear characteristics - 1:characteristics is given by caract[] - 2:characteristics for conic clapper";
  parameter Integer option_interpolation = 1 "1: linear interpolation - 2: spline interpolation (active if mode_caract=1)";
  parameter Boolean mech_steady_state = true "true: start from mechanical steady state - false: start from 0";
  parameter Boolean continuous_flow_reversal = false "true: continuous flow reversal - false: discontinuous flow reversal";
  parameter Units.SI.Density p_rho = 0 "If > 0, fixed fluid density";
  parameter Integer mode = 0 "IF97 region. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  Boolean clapper_is_free(start = true) "true if clapper is free to move in both directions, false otherwise";
  Units.SI.Force Fp "Gravity force";
  Units.SI.Force Fr "Spring force";
  Units.SI.Force Fd "Damping force";
  Units.SI.Force Fh "Hydraulic force";
  Units.SI.Force Fdyn "Dynamic pressure force";
  Units.SI.Force Ft "Total force";
  Units.SI.Length z(start = z_min) "Clapper elevation";
  Units.SI.Velocity v = der(z) "Clapper velocity";
  Units.SI.Acceleration a = der(v) "Clapper acceleration";
  Real Ouv "Valve position";
  Units.SI.Area A "Hydraulic area upstream the clapper";
  Units.SI.Force Fr_min "Spring force when valve is closed";
  ThermoSysPro.Units.xSI.Cv Cv "Cv [USG/min]";
  Units.SI.MassFlowRate Q(start = 500) "Mass flow rate";
  ThermoSysPro.Units.SI.PressureDifference deltaP "Singular pressure loss";
  Units.SI.Density rho(start = 998) "Fluid density";
  Units.SI.Temperature T(start = 290) "Fluid temperature";
  Units.SI.AbsolutePressure Pm(start = 1.e5) "Fluid average pressure";
  Units.SI.SpecificEnthalpy h(start = 100000) "Fluid specific enthalpy";
  Units.SI.AbsolutePressure Pdyn "Dynamic pressure on the clapper";
  Units.SI.Velocity vh "Fluid velocity through the valve";
  Units.SI.Energy Wdyn "Dissipated fluid kinetic energy";
  Real Re = rho*(vh - v)*sqrt(4*A/pi)/ThermoSysPro.Properties.WaterSteam.IF97.DynamicViscosity_rhoT(rho, T) "Clapper Reynolds";
  Connectors.FluidInlet C1 annotation(
    Placement(transformation(extent = {{-10, -108}, {10, -88}}, rotation = 0)));
  Connectors.FluidOutlet C2 annotation(
    Placement(transformation(extent = {{90, -10}, {110, 10}}, rotation = 0), iconTransformation(extent = {{90, -10}, {110, 10}})));
protected
  constant Units.SI.Acceleration g = Modelica.Constants.g_n "Gravity constant";
  constant Real pi = Modelica.Constants.pi "pi";
  constant Units.SI.Density rho60F = 998.98 "Water density at 60°F";
  constant Real K = 1.733e12 "Valve constant";
  parameter Real eps = 1.e-0 "Small number for pressure loss equation";
  parameter Units.SI.Length z_min = 0 "Minimum clapper elevation";
  parameter Units.SI.MassFlowRate Qeps = 1.e-3 "Small mass flow for continuous flow reversal";
protected
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph pro "Propriétés de l'eau" annotation(
    Placement(transformation(extent = {{-100, 80}, {-80, 100}}, rotation = 0)));
initial equation
  if mech_steady_state then
    der(z) = 0;
    der(v) = 0;
  else
    z = z0;
    der(z) = 0;
  end if;
  Wdyn = 0;
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
/* Hydraulic area upstream the clapper. It varies as a function of the valve elevation
  between A1 (valve closed) and A2 (valve open) with a hysteresis */
  A = ThermoSysPro.Functions.SplineInterpolation(clapper_area[:, 1], clapper_area[:, 2], z - z_min);
/* Dynamic pressure on the valve */
  Pdyn = Cd*rho/2*(vh - v)^2;
/* Dissipated kinetic energy */
  der(Wdyn) = Fdyn*v;
/* Fluid velocity through the valve */
  rho*vh*A = Q;
/* Force balance */
  Fp = -m*g;
  Fr = -Ke*(z - z_min) + Fr_min;
  Fd = -D*v;
  Fh = C1.P*A - C2.P*A2;
  Fdyn = sign(vh - v)*Pdyn*A;
  Ft = Fp + Fr + Fd + Fh + Fdyn;
/* Newton's law */
  clapper_is_free = ((z > z_min) and (z < z_max)) or ((z <= z_min) and (Ft > 0)) or ((z >= z_max) and (Ft < 0));
  if clapper_is_free then
    m*a = Ft;
  else
    a = 0;
  end if;
  when {z <= z_min, z >= z_max} then
    reinit(v, 0);
  end when;
/* Pressure that opens the valve */
  m*g - Fr_min = Popen*A1 - Pout*A2;
/* Valve position */
  Ouv = (z - z_min)/(z_max - z_min);
/* Pressure loss */
  deltaP*Cv*abs(Cv) = K*ThermoSysPro.Functions.ThermoSquare(Q, eps)/(rho*rho60F);
/* Cv as a function of the valve position */
  if (mode_caract == 0) then
    Cv = Ouv*Cvmax;
  elseif (mode_caract == 1) then
    if (option_interpolation == 1) then
      Cv = ThermoSysPro.Functions.LinearInterpolation(caract[:, 1], caract[:, 2], Ouv);
    elseif (option_interpolation == 2) then
      Cv = ThermoSysPro.Functions.SplineInterpolation(caract[:, 1], caract[:, 2], Ouv);
    else
      assert(false, "DynamicReliefValve: incorrect interpolation option");
    end if;
  elseif (mode_caract == 2) then
    Cv = sqrt(pi*A1*K/(0.3*rho60F))*(z - z_min)/sqrt(1 + pi/A1*(z - z_min)^2);
  else
    assert(false, "DynamicReliefValve : incorrect Cv computation mode");
  end if;
/* Fluid thermodynamic properties */
  Pm = (C1.P + C2.P)/2;
  pro = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Pm, h, mode);
  T = pro.T;
  if (p_rho > 0) then
    rho = p_rho;
  else
    rho = pro.d;
  end if;
  annotation(
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics = {Polygon(points = {{0, 0}, {-30, -60}, {30, -60}, {0, 0}}, lineColor = {28, 108, 200}, fillColor = {170, 85, 255}, fillPattern = FillPattern.Solid), Polygon(points = {{0, 0}, {60, -30}, {60, 30}, {0, 0}}, lineColor = {28, 108, 200}, fillColor = {170, 85, 255}, fillPattern = FillPattern.Solid), Line(points = {{0, -60}, {0, -98}}), Line(points = {{60, 0}, {90, 0}}), Line(points = {{0, 0}, {10, 10}, {-10, 20}, {10, 28}, {-10, 40}, {10, 50}, {-10, 60}, {10, 70}}, color = {170, 85, 255})}),
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics = {Polygon(points = {{0, 0}, {-30, -60}, {30, -60}, {0, 0}}, lineColor = {28, 108, 200}, fillColor = {170, 85, 255}, fillPattern = FillPattern.Solid), Polygon(points = {{0, 0}, {60, -30}, {60, 30}, {0, 0}}, lineColor = {28, 108, 200}, fillColor = {170, 85, 255}, fillPattern = FillPattern.Solid), Line(points = {{0, -60}, {0, -98}}), Line(points = {{60, 0}, {90, 0}}), Line(points = {{0, 0}, {10, 10}, {-10, 20}, {10, 28}, {-10, 40}, {10, 50}, {-10, 60}, {10, 70}})}),
    Window(x = 0.12, y = 0.05, width = 0.8, height = 0.77),
    Documentation(info = "
## Copyright © EDF 2002 - 2026  
## ThermoSysPro Version 4.2  
This component model is documented in Sect. 13.13 of the ThermoSysPro book.   
# Dynamic relief valve   
   
Relief valves are used to limit the pressure in a system.  
When the set pressure level is exceeded, the relief valve opens.  
It closes again once the system pressure reaches the valve reseting pressure.s  

Following assumptions are made:  
- the fluid is subsonic and incompressible.  
- the volume inside the valve is negligible, so that inertia is neglected.  


## Modelica component model  

The equations mentioned below are implemented in the component *DynamicReliefValve*, located in the *WaterSteam.PressureLosses* sub-library.   
This component has 2 connectors:  
- C1: fluid inlet,  
- C2: fluid outlet.  
   
![modelica://ThermoSysPro/UsersGuide/Documentation/ThermoSysPro.WaterSteam.PressureLosses.DynamicReliefValve.svg](modelica://ThermoSysPro/UsersGuide/Documentation/ThermoSysPro.WaterSteam.PressureLosses.DynamicReliefValve.svg)  

## Nomenclature  

| Symbol| Description| Unit| Definition| Modelica name |  
| :----------------------------------------------- | :--------------------------------------------------------------------------------------- | :------------------------------- | :------------------------------------- | :----------- |  
| \\\\(A\\_{\\mathrm{i}}\\\\)| Clapper section at the inlet| \\\\(\\mathrm{m}^{2}\\\\)|| A |  
| \\\\(A\\_{\\mathrm{o}}\\\\)| Clapper section at the outlet| \\\\(\\mathrm{m}^{2}\\\\)|| A2 |  
| \\\\(C\\_{\\mathrm{v}}\\\\)| Flow coefficient of the valve| U.S. [USG/min]|| Cvmax |  
| \\\\(D\\\\)| Valve damping| \\\\(-\\\\)|| D |  
| \\\\(f\\_{\\mathrm{d}}\\\\)| Force acting on the clapper due to damping| \\\\(\\mathrm{N}\\\\)|| Fd |  
| \\\\(f\\_{\\mathrm{h}}\\\\)| Hydraulic force acting on the clapper| \\\\(\\mathrm{N}\\\\)|| Fh |  
| \\\\(f\\_{\\mathrm{s}}\\\\)| Force acting on the clapper due to the spring| \\\\(\\mathrm{N}\\\\)|| Fr |  
| \\\\(f\\_{\\mathrm{t}}\\\\)| Total force acting on the clapper| \\\\(\\mathrm{N}\\\\)|| Ft |  
| \\\\(f\\_{\\mathrm{w}}\\\\)| Force acting on the clapper due to the weight of the clapper| \\\\(\\mathrm{N}\\\\)|| Fp |  
| \\\\(h\\\\)| Fluid specific enthalpy | \\\\(\\mathrm{J} / \\mathrm{kg}\\\\)|| h |  
| \\\\(h\\_{\\mathrm{c}}\\\\)| Valve height | \\\\(\\mathrm{m}\\\\)| \\\\(h\\_{\\mathrm{c}}=z\\_{\\max }-z\\_{\\min }\\\\) | - |  
| \\\\(K\\_{\\mathrm{e}}\\\\)| Valve spring stiffness| \\\\(\\mathrm{N} / \\mathrm{m}\\\\)|| Ke |  
| \\\\(\\dot{m}\\\\)| Fluid mass flow rate| \\\\(\\mathrm{kg} / \\mathrm{s}\\\\)|| Q |  
| \\\\(M\\\\)| Valve mass| \\\\(\\mathrm{kg}\\\\)|| m |  
| \\\\(P\\_{\\mathrm{i}}\\\\)| Fluid pressure at the inlet| \\\\(\\mathrm{Pa}\\\\)|| C1.P |  
| \\\\(P\\_{\\mathrm{o}}\\\\)| Fluid pressure at the outlet| \\\\(\\mathrm{Pa}\\\\)|| C2.P |  
| \\\\(v\\\\)| Clapper velocity| \\\\(\\mathrm{m} / \\mathrm{s}\\\\)|| v |  
| \\\\(z\\\\)| Clapper position| \\\\(\\mathrm{m}\\\\)|| z |  
| \\\\(z\\_{\\min }\\\\)| Clapper minimum position \\(valve fully closed\\)| \\\\(\\mathrm{m}\\\\)|| z_min |  
| \\\\(z\\_{\\max }\\\\)| Clapper maximum position \\(valve fully open\\)| \\\\(\\mathrm{m}\\\\)|| z_max |  
| \\\\(\\delta\\\\)| Difference between the free spring length and the spring length when the valve is closed | \\\\(\\mathrm{m}\\\\)|| - |  
| \\\\(\\Delta P\\\\)| Pressure loss of the fluid between the valve inlet and outlet| \\\\(\\mathrm{Pa}\\\\)| \\\\(P\\_{\\mathrm{i}}-P\\_{\\mathrm{o}}\\\\)| deltaP |  
| \\\\(\\rho\\\\)| Fluid density| \\\\(\\mathrm{kg} / \\mathrm{m}^{3}\\\\) ||rho |  
| \\\\(\\rho\\_{\\text {water, } 60^{\\circ} \\mathrm{F}}\\\\) | Density of water at \\\\(60^{\\circ} \\mathrm{F}\\left\\(15.5556^{\\circ} \\mathrm{C}\\right\\) .\\\\)| \\\\(\\mathrm{kg} / \\mathrm{m}^{3}\\\\) || rho60F |  
| \\\\(\\Omega\\\\)| Valve position| \\\\(-\\\\)|| Ouv |  



## Governing equations  

### Static momentum balance equation  


    
    

- Validity domain:   
   
 \\\\(\\forall \\dot{m}\\\\) and \\\\(C\\_{\\mathrm{v}} \\geq 0\\\\). For \\\\(C\\_{\\mathrm{v}}=0, \\Delta P\\\\) must be defined.  

- Mathematical formulation:   
   
 $$\\Delta P \\cdot C\\_{\\mathrm{v}} \\cdot\\lvert C\\_{\\mathrm{v}}\\rvert =1.732189 \\times 10^{12} \\cdot \\frac{\\dot{m} \\cdot \\lvert \\dot{m} \\rvert }{\\rho \\cdot \\rho\\_{\\text {water, } 60^{\\circ} F}}$$  

- Comments:   
   
 This equation is the same as the control valve \\\\(C\\_{\\mathrm{v}}=f\\_{v}\\(\\Omega\\)\\\\) where \\\\(f\\_{v}\\\\) is the valve characteristic. It is assumed that \\\\(\\Omega=\\frac{z-z\\_{\\min }}{z\\_{\\max }-z\\_{\\min }}\\\\).  


### Clapper equation  

- Validity domain:  

\\\\( z\\_{\\min} \\leq z \\leq z\\_{\\max} \\\\)  

- Mathematical formulation:   

$$   M \\cdot \\frac{\\mathrm{d} \\nu}{\\mathrm{d}t}=\\left\\{\\begin{array}{l} f_{\\mathrm{t}} \\text{ if } z_{\\min }<z<z_{\\max } \\\\   f_{\\mathrm{t}} \\text{ if } z \\leq z_{\\min } \\text{ and } f_{\\mathrm{t}}>0 \\\\   f_{\\mathrm{t}} \\text{ if } z \\geq z_{\\max } \\text{ and } f_{\\mathrm{t}}<0 \\\\   0  \\text{ else }\\end{array}\\right.$$  

$$   \\nu =\\left\\{\\begin{array}{l}\\frac{\\mathrm{d} z}{\\mathrm{d} t}    \\text{ when } z_{\\min }<z<z_{\\max } \\\\   0 \\text{ when } z \\leq z_{\\min } \\text{ or } z \\geq z_{\\max }\\end{array}\\right.$$  

$$   f_{\\mathrm{t}} = f_{\\mathrm{w}}+f_{\\mathrm{s}} +f_{\\mathrm{d}}+ f_{\\mathrm{h}} \\\\   f_{\\mathrm{w}} = -M \\cdot g \\\\   f_{\\mathrm{d}} = -D \\cdot \\frac{\\mathrm{d} z}{\\mathrm{d} t} \\\\   f_{\\mathrm{s}} = -K_{\\mathrm{e}} \\cdot (z - z_{\\min} + \\delta) \\\\   f_{\\mathrm{h}} = P_{\\mathrm{i}} \\cdot A_{\\mathrm{i}} - P_{\\mathrm{o}} \\cdot A_{\\mathrm{o}}$$  

- Comments:  

The velocity  and acceleration are set to zero when the clapper hits the mechanical stops. The equal sign is replaced by \\\\(\\leq\\\\) or \\\\(\\geq\\\\) in the transition conditions \\\\(z=z_{\\min }\\\\) and \\\\(z=z_{\\max }\\\\) because equal signs are not recognized by solvers to compare real values.  

## References   
   
El Hefni, Baligh and Bouskela, Daniel (2019). [Modeling and Simulation of Thermal Power Plants with ThermoSysPro](https://link.springer.com/book/10.1007/978-3-030-05105-1), sect. 13.1. Springer Nature Switzerland AG.  
    ", revisions = "
Author  

Daniel Bouskela   

    "));
end DynamicReliefValve;
