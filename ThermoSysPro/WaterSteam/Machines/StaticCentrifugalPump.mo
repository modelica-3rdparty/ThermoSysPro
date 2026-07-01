within ThermoSysPro.WaterSteam.Machines;

model StaticCentrifugalPump "Static centrifugal pump"
  parameter ThermoSysPro.Units.nonSI.AngularVelocity_rpm VRot = 1400 "Fixed rotational speed (active if fixed_rot_or_power=1 and rpm_or_mpower connector not connected)";
  parameter Units.SI.Power MPower = 0.1e6 "Fixed mechanical power (active if fixed_rot_or_power=2 and rpm_or_mpower connector not connected)";
  parameter ThermoSysPro.Units.nonSI.AngularVelocity_rpm VRotn = 1400 "Nominal rotational speed";
  parameter Real rm = 0.85 "Product of the pump mechanical and electrical efficiencies";
  parameter Integer fixed_rot_or_power = 1 "1: fixed rotational speed - 2: fixed mechanical power";
  parameter Boolean adiabatic_compression = false "true: compression at constant enthalpy - false: compression with varying enthalpy";
  parameter Boolean continuous_flow_reversal = false "true: continuous flow reversal - false: discontinuous flow reversal";
  parameter Integer fluid = 1 "1: water/steam - 2: C3H3F5";
  parameter Units.SI.Density p_rho = 0 "If > 0, fixed fluid density";
  parameter Integer mode = 1 "IF97 region. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  parameter Real a1 = -88.67 "x^2 coef. of the pump characteristics hn = f(vol_flow) (s2/m5)";
  parameter Real a2 = 0 "x coef. of the pump characteristics hn = f(vol_flow) (s/m2)";
  parameter Real a3 = 43.15 "Constant coef. of the pump characteristics hn = f(vol_flow) (m)";
  parameter Real b1 = -3.7751 "x^2 coef. of the pump efficiency characteristics rh = f(vol_flow) (s2/m6)";
  parameter Real b2 = 3.61 "x coef. of the pump efficiency characteristics rh = f(vol_flow) (s/m3)";
  parameter Real b3 = -0.0075464 "Constant coef. of the pump efficiency characteristics rh = f(vol_flow) (s.u.)";
  Real rh "Hydraulic efficiency";
  Units.SI.Height hn(start = 10) "Pump head";
  Real R(start = VRot/VRotn) "Reduced rotational speed";
  Units.SI.MassFlowRate Q(start = 500) "Mass flow rate";
  Units.SI.VolumeFlowRate Qv(start = 0.5) "Volume flow rate";
  Units.SI.Power Wh "Hydraulic power";
  Units.SI.Power Wm "Mechanical power";
  ThermoSysPro.Units.nonSI.AngularVelocity_rpm Vr "Rotational speed";
  Units.SI.Density rho(start = 998) "Fluid density";
  ThermoSysPro.Units.SI.PressureDifference deltaP "Pressure variation between the outlet and the inlet";
  Units.SI.SpecificEnthalpy deltaH "Specific enthalpy variation between the outlet and the inlet";
  Units.SI.AbsolutePressure Pm(start = 1.e5) "Fluid average pressure";
  Units.SI.SpecificEnthalpy h(start = 100000) "Fluid average specific enthalpy";
  Connectors.FluidInlet C1 annotation(
    Placement(transformation(extent = {{-110, -10}, {-90, 10}}, rotation = 0)));
  Connectors.FluidOutlet C2 annotation(
    Placement(transformation(extent = {{90, -10}, {110, 10}}, rotation = 0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph pro annotation(
    Placement(transformation(extent = {{-100, 80}, {-80, 100}}, rotation = 0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal rpm_or_mpower annotation(
    Placement(transformation(origin = {0, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
protected
  constant Units.SI.Acceleration g = Modelica.Constants.g_n "Gravity constant";
  constant Real pi = Modelica.Constants.pi "pi";
  parameter Real eps = 1.e-6 "Small number";
  parameter Real rhmin = 0.20 "Minimum efficiency to avoid zero crossings";
  parameter Units.SI.MassFlowRate Qeps = 1.e-3 "Small mass flow for continuous flow reversal";
equation
  if (cardinality(rpm_or_mpower) == 0) then
    if (fixed_rot_or_power == 1) then
      rpm_or_mpower.signal = VRot;
    elseif (fixed_rot_or_power == 2) then
      rpm_or_mpower.signal = MPower;
    else
      assert(false, "StaticCentrifugalPump: incorrect option");
    end if;
  end if;
  deltaP = C2.P - C1.P;
  deltaH = C2.h - C1.h;
  deltaP = rho*g*hn;
  C1.Q = C2.Q;
  Q = C1.Q;
  Q = Qv*rho;
/* Flow reversal */
  if continuous_flow_reversal then
    0 = noEvent(if (Q > Qeps) then C1.h - C1.h_vol else if (Q < -Qeps) then C2.h - C2.h_vol else C1.h - 0.5*((C1.h_vol - C2.h_vol)*Modelica.Math.sin(pi*Q/2/Qeps) + C1.h_vol + C2.h_vol));
  else
    0 = if (Q > 0) then C1.h - C1.h_vol else C2.h - C2.h_vol;
  end if;
/* Fixed rotational speed or fixed mechanical power */
  if (fixed_rot_or_power == 1) then
    Vr = rpm_or_mpower.signal;
  elseif (fixed_rot_or_power == 2) then
    Wm = rpm_or_mpower.signal;
  else
    assert(false, "StaticCentrifugalPump: incorrect option");
  end if;
/* Energy balance equation */
  if adiabatic_compression then
    deltaH = 0;
  else
    deltaH = g*hn/rh;
  end if;
/* Reduced rotational speed */
  R = Vr/VRotn;
/* Pump characteristics */
  hn = noEvent(a1*Qv*abs(Qv) + a2*Qv*R + a3*R^2);
  rh = noEvent(max(if (abs(R) > eps) then b1*Qv*abs(Qv)/R^2 + b2*Qv/R + b3 else b3, rhmin));
/* Mechanical power */
  Wm = Q*deltaH/rm;
/* Hydraulic power */
  Wh = Qv*deltaP/rh;
/* Fluid thermodynamic properties */
  Pm = (C1.P + C2.P)/2;
  h = (C1.h + C2.h)/2;
  pro = ThermoSysPro.Properties.Fluid.Ph(Pm, h, mode, fluid);
  if (p_rho > 0) then
    rho = p_rho;
  else
    rho = pro.d;
  end if;
  annotation(
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics = {Ellipse(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 0}, fillColor = {127, 255, 0}, fillPattern = FillPattern.Solid), Line(points = {{-80, 0}, {80, 0}}), Line(points = {{80, 0}, {2, 60}}), Line(points = {{80, 0}, {0, -60}})}),
    Window(x = 0.03, y = 0.02, width = 0.95, height = 0.95),
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics = {Ellipse(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 0}, fillColor = {127, 255, 0}, fillPattern = FillPattern.Solid), Line(points = {{-80, 0}, {80, 0}}), Line(points = {{80, 0}, {2, 60}}), Line(points = {{80, 0}, {0, -60}})}),
    Documentation(info = "
## Copyright © EDF 2002 - 2026   
## ThermoSysPro Version 4.2  
This component model is documented in Sect. 12.2 of the ThermoSysPro book.   

# Static centrifugal pump  

Centrifugal pumps are used to generate flow or to increase the pressure of a liquid by conversion of mechanical energy into kinetic energy.   
For the static centrifugal pump, either the rotational speed of the pump is a fixed input, or the mechanical power is provided as a fixed input and the rotational speed is calculated.  

Because energy losses cannot be neglected, the Bernoulli equation cannot be used to describe them. Instead, the momentum balance equation is replaced by a more general homologous relation called *pump characteristic*.  
The model depends on the available characteristics from the manufacturer.   

Usually, characteristics are only provided for the operating domain limited to:  
- positive pump rotational velocity: \\\\(\\bar{\\omega} > 0 \\\\),  
- positive flow rate through the pump: \\\\(q > 0 \\\\),  
- positive pump head: \\\\(h_n > 0\\\\).  

Such characteristics are sufficient if the simulation occurs near the nominal operating.  
If not, see [Centrifugal pump](modelica://ThermoSysPro.WaterSteam.Machines.CentrifugalPump).  

## Modelica component model  

The equations mentioned below are implemented in the component *StaticCentrifugalPump*, located in the *WaterSteam.Machines* sub-library.  
The component has 3 connectors:  
- C1: fluid inlet,  
- C2: fluid outlet,  
- rpm_or_mpower: rotational speed or mechanical power.  

![modelica://ThermoSysPro/UsersGuide/Documentation/ThermoSysPro.WaterSteam.Machines.StaticCentrifugalPump.svg](modelica://ThermoSysPro/UsersGuide/Documentation/ThermoSysPro.WaterSteam.Machines.StaticCentrifugalPump.svg)  

## Nomenclature  

| Symbol | Description | Unit | Definition | Modelica name |  
|---------------- |------------------------------------------------------------------ |----------------------------- |--------------------------------- | -----------------|  
| \\\\( a_i \\\\) | Coefficient of degree \\\\( i \\\\) of the parabolic pump characteristic \\\\(h_n=f_h(\\frac{q}{\\omega}) \\\\) | \\\\( \\mathrm{s^i/m^{2i + 1}} \\\\) | |a1 (x^2), a2 (x), a3 (-) |  
| \\\\( b_i \\\\) | Coefficient of degree \\\\( i \\\\) of the parabolic pump characteristic \\\\(\\eta_h=f\\_{\\eta}(\\frac{q}{\\omega}) \\\\) | \\\\( \\mathrm{s^i/m^{3i}} \\\\) | | b1 (x^2), b2 (x), b3 (-) |  
| \\\\( F(\\theta) \\\\)  | Pump head full characteristic | | | - |  
| \\\\( g \\\\) | Gravity constant | \\\\( \\mathrm{m/s^2} \\\\) | | g |  
| \\\\( h_i \\\\) | Fluid specific enthalpy at the inlet| \\\\( \\mathrm{J/kg} \\\\) | | C1.h |  
| \\\\( h_o \\\\) | Fluid specific enthalpy at the outlet| \\\\( \\mathrm{J/kg} \\\\) | |C2.h |  
| \\\\( h_n \\\\) | Pump head | \\\\( \\mathrm{m} \\\\) | \\\\( h_n = \\frac{P_o − P_i}{\\rho \\cdot g}  \\\\) | hn |  
| \\\\( \\dot{m} \\\\) | Fluid mass flow rate through the pump | \\\\( \\mathrm{kg/s} \\\\) | | Q |  
| \\\\( N \\\\) | Rotational speed of the pump | \\\\( \\mathrm{rev/min} \\\\) | \\\\( \\frac{30}{\\pi} \\cdot \\omega\\\\) | Vr |  
| \\\\( N_{nom} \\\\) | Nominal rotational speed of the pump | \\\\( \\mathrm{rev/min} \\\\) | \\\\( \\frac{30}{\\pi} \\cdot \\omega\\_{nom}\\\\) | VRotn |  
| \\\\( P_i \\\\)  | Fluid pressure at the inlet | \\\\( \\mathrm{Pa} \\\\) | | C1.P |  
| \\\\( P_o \\\\)  | Fluid pressure at the outlet | \\\\( \\mathrm{Pa} \\\\) | | C2.P |  
| \\\\( q \\\\) | Volumetric flow rate through the pump | \\\\( \\mathrm{m^3/s} \\\\) | \\\\( \\frac{\\dot{m}}{\\\\rho} \\\\) | Qv |  
| \\\\( q_{nom} \\\\) | Nominal volumetric flow rate through the pump | \\\\( \\mathrm{m^3/s} \\\\) | | - |  
| \\\\( \\bar{q} \\\\) | Reduced volumetric flow rate through the pump | | \\\\( \\frac{q}{q\\_{nom}} \\\\) | - |  
| \\\\( W_h \\\\) | Hydraulic power | \\\\( \\mathrm{W} \\\\) | | Wh |  
| \\\\( W_m \\\\) | Mechanical power | \\\\( \\mathrm{W} \\\\) | | Wm |  
| \\\\( \\eta_h \\\\) | Hydraulic efficiency | - | | rh |  
| \\\\( \\eta_m \\\\) | Product of the pump mechanical and electrical efficiencies | - | | rm |  
| \\\\( \\theta \\\\) | Angle beween coordinates \\\\( (\\omega, q) \\\\) | \\\\( \\mathrm{rad} \\\\) | \\\\( \\\\arctan \\left( \\frac{\\bar{q}}{\\bar{\\omega}} \\right) \\\\) | - |  
| \\\\( \\\\rho \\\\) | Average fluid density between the inlet and the outlet | \\\\( \\mathrm{kg/m3} \\\\) | | rho |  
| \\\\(\\omega\\\\) | Pump angular velocity | \\\\( \\mathrm{rad/s} \\\\) | | - |  
| \\\\(\\omega\\_{nom}\\\\) | Nominal pump angular velocity | \\\\( \\mathrm{rad/s} \\\\) | |  - |  
| \\\\(\\bar{\\omega}\\\\) | Reduced pump  rotational velocity | - | \\\\( \\frac{\\omega}{\\omega_{nom}}  = \\frac{N}{N_{nom}} \\\\) | R |  


## Governing equations  


### Energy balance equation  

- Validity domain:  
   
 \\\\( \\forall \\bar{\\omega}, \\forall q \\\\neq 0 \\\\; \\text{such that} \\\\; \\eta_h \\\\in ]0,1] \\\\)  

- Mathematical formulation:   

$$ g \\cdot h_n = \\eta_h \\cdot (h_o - h_i) $$  


### Energy balance equation: mechanical power  

- Validity domain:  
   
 \\\\( \\forall \\bar{\\omega}, q \\\\; \\text{such that} \\\\; \\eta_h \\\\in ]0,1] \\\\)  

- Mathematical formulation:  
      
    $$ W_m = \\frac{\\rho  \\cdot q \\cdot  (h_o - h_i)}{\\eta_m} $$  


### Energy balance equation: hydraulic power  

- Validity domain:  
   
 \\\\( \\forall \\bar{\\omega}, q \\\\; \\text{such that} \\\\; \\eta_h \\\\in ]0,1] \\\\)  

- Mathematical formulation:  
      
$$ W_m = \\frac{q  \\cdot (P_o - P_i)}{\\eta_h} $$  


### Pump full characteristic  

- Validity domain:  
   
 \\\\( \\forall \\bar{\\omega} \\\\; \\text{and} \\\\; \\forall q \\\\; \\text{such that} \\\\; \\bar{\\omega} \\\\; q \\\\neq 0 \\\\)  

- Mathematical formulation:  
      
$$ \\frac{\\bar{h}\\_n}{\\bar{q}^2 + \\bar{\\omega}^2} = F(\\\\theta) $$  

- Comments:  

The characteristic \\\\( F(\\\\theta) \\\\) depends on the specific speed.  


### Hydraulic parabolic efficiency  

- Validity domain:  
   
 \\\\( \\forall \\bar{\\omega} > 0 \\\\; \\text{and} \\\\; \\forall q > 0 \\\\; \\text{such that} \\\\; \\eta_h \\\\in ]0,1] \\\\)  

- Mathematical formulation:  
      
$$ \\eta_h = b_2  \\cdot \\frac{q \\cdot |q|}{\\bar{\\omega}^2} + b_1 \\cdot \\frac{q}{\\bar{\\omega}} + b_0 $$  


### Fluid average density  

- Validity domain:  
   
 \\\\( \\forall P \\\\; \\text{and} \\\\; \\forall h \\\\; \\text{inside the domain of valifity of } f_p, \\\\) the state equation for the density.  

- Mathematical formulation:  
      
$$ \\rho = f_p \\cdot  \\left( \\frac{P_i + P_o}{2}, \\frac{h_i + h_o}{2} \\right)$$  

- Comments:  
      
The pump does not follow the upwind scheme: the average density is calculated at the mid-point of the compression.  

## References  

El Hefni, Baligh and Bouskela, Daniel (2019). [Modeling and Simulation of Thermal Power Plants with ThermoSysPro](https://link.springer.com/book/10.1007/978-3-030-05105-1), sect. 12.2. Springer Nature Switzerland AG.  
    ", revisions = "
Author  

Daniel Bouskela   

    "),
    DymolaStoredErrors);
end StaticCentrifugalPump;