within ThermoSysPro.WaterSteam.Machines;

model StodolaTurbine "Multistage turbine group using Stodola's ellipse"
  parameter Real Cst = 1.e7 "Stodola's ellipse coefficient";
  parameter Real W_fric = 0.0 "Power losses due to hydrodynamic friction (percent)";
  parameter Real eta_stato = 1.0 "Efficiency to account for cinetic losses (<= 1) (s.u.)";
  parameter Units.SI.Area area_nz = 1 "Nozzle area";
  parameter Real eta_nz = 1.0 "Nozzle efficency (eta_nz < 1 - turbine with nozzle - eta_nz = 1 - turbine without nozzle)";
  parameter Units.SI.MassFlowRate Qmax = 1 "Maximum mass flow through the turbine";
  parameter Real eta_is_nom = 0.8 "Nominal isentropic efficiency";
  parameter Real eta_is_min = 0.35 "Minimum isentropic efficiency";
  parameter Real a = -1.3889 "x^2 coefficient of the isentropic efficiency characteristics eta_is=f(Q/Qmax)";
  parameter Real b = 2.6944 "x coefficient of the isentropic efficiency characteristics eta_is=f(Q/Qmax)";
  parameter Real c = -0.5056 "Constant coefficient of the isentropic efficiency characteristics eta_is=f(Q/Qmax)";
  parameter Integer fluid = 1 "1: water/steam - 2: C3H3F5";
  parameter Integer mode_e = 0 "IF97 region before expansion. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  parameter Integer mode_s = 0 "IF97 region after expansion. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  parameter Integer mode_ps = 0 "IF97 region after isentropic expansion. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  Real eta_is(start = 0.85) "Isentropic efficiency";
  Real eta_is_wet(start = 0.83) "Isentropic efficiency for wet steam";
  Units.SI.Power W "Mechanical power produced by the turbine";
  Units.SI.MassFlowRate Q "Mass flow rate";
  Units.SI.SpecificEnthalpy His "Fluid specific enthalpy after isentropic expansion";
  Units.SI.SpecificEnthalpy Hrs "Fluid specific enthalpy after the real expansion";
  Units.SI.AbsolutePressure Pe(start = 10e5, min = 0) "Pressure at the inlet";
  Units.SI.AbsolutePressure Ps(start = 10e5, min = 0) "Pressure at the outlet";
  Units.SI.Temperature Te(min = 0) "Temperature at the inlet";
  Units.SI.Temperature Ts(min = 0) "Temperature at the outlet";
  Units.SI.Velocity Vs "Fluid velocity at the outlet";
  Units.SI.Density rhos(start = 200) "Fluid density at the outlet";
  Real xm(start = 1.0, min = 0) "Average vapor mass fraction";
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph proe annotation(
    Placement(transformation(extent = {{-100, 80}, {-80, 100}}, rotation = 0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph pros annotation(
    Placement(transformation(extent = {{-60, 80}, {-40, 100}}, rotation = 0)));
  Connectors.FluidInlet Ce annotation(
    Placement(transformation(extent = {{-111, -10}, {-91, 10}}, rotation = 0)));
  Connectors.FluidOutlet Cs annotation(
    Placement(transformation(extent = {{91, -10}, {111, 10}}, rotation = 0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ps props annotation(
    Placement(transformation(extent = {{-100, -100}, {-80, -80}}, rotation = 0)));
  ThermoSysPro.ElectroMechanics.Connectors.MechanichalTorque M annotation(
    Placement(transformation(origin = {0, -100}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal MechPower annotation(
    Placement(transformation(origin = {110, -90}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph pros1 annotation(
    Placement(transformation(extent = {{-20, 80}, {0, 100}}, rotation = 0)));
protected
  parameter Units.SI.AbsolutePressure pcrit = ThermoSysPro.Properties.WaterSteam.BaseIF97.data.PCRIT "Critical pressure";
  parameter Units.SI.Temperature Tcrit = ThermoSysPro.Properties.WaterSteam.BaseIF97.data.TCRIT "Critical temperature";
equation
  if (cardinality(M) == 0) then
    M.Ctr = 0;
    M.w = 0;
  else
    M.Ctr*M.w = W;
  end if;
  Pe = Ce.P;
  Ps = Cs.P;
  Ce.Q = Cs.Q;
  Q = Ce.Q;
/* No flow reversal */
  0 = Ce.h - Ce.h_vol;
/* Isentropic efficiency */
  eta_is = if (Q < Qmax) then (max(eta_is_min, (a*(Q/Qmax)^2 + b*(Q/Qmax) + c))) else eta_is_nom;
  eta_is_wet = xm*eta_is;
/* Average vapor mass fraction during the expansion */
  if noEvent((Pe > pcrit) or (Te > Tcrit)) then
    xm = 1;
  else
    xm = (proe.x + pros1.x)/2.0;
  end if;
/* Stodola's ellipse law */
  if noEvent((Pe > pcrit) or (Te > Tcrit)) then
    Q = sqrt((Pe^2 - Ps^2)/(Cst*Te));
  else
    Q = sqrt((Pe^2 - Ps^2)/(Cst*Te*proe.x));
  end if;
/* Fluid specific enthalpy after the expansion */
  Hrs - Ce.h = xm*eta_is*(His - Ce.h);
/* Fluid specific enthalpy at the outlet of the nozzle */
  Vs = Q/rhos/area_nz;
  Cs.h - Hrs = (1 - eta_nz)*Vs^2/2;
/* Mechanical power produced by the turbine */
  W = Q*eta_stato*(Ce.h - Cs.h)*(1 - W_fric/100);
  MechPower.signal = W;
/* Fluid thermodynamic properties before the expansion */
  proe = ThermoSysPro.Properties.Fluid.Ph(Pe, Ce.h, mode_e, fluid);
  Te = proe.T;
/* Fluid thermodynamic properties after the expansion */
  pros1 = ThermoSysPro.Properties.Fluid.Ph(Ps, Hrs, mode_s, fluid);
/* Fluid thermodynamic properties at the outlet of the nozzle */
  pros = ThermoSysPro.Properties.Fluid.Ph(Ps, Cs.h, mode_s, fluid);
  Ts = pros.T;
  rhos = pros.d;
/* Fluid thermodynamic properties after the isentropic expansion */
  props = ThermoSysPro.Properties.Fluid.Ps(Ps, proe.s, mode_ps, fluid);
  His = props.h;
  annotation(
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics = {Polygon(points = {{-100, 40}, {-100, -40}, {100, -100}, {100, 100}, {-100, 40}}, lineColor = {0, 0, 255}, fillColor = {128, 255, 0}, fillPattern = FillPattern.Solid), Line(points = {{0, -70}, {0, -90}}, color = {0, 0, 0}, thickness = 0.5)}),
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics = {Polygon(points = {{-100, 40}, {-100, -40}, {100, -100}, {100, 100}, {-100, 40}}, lineColor = {0, 0, 255}, fillColor = {127, 255, 0}, fillPattern = FillPattern.Solid), Line(points = {{0, -70}, {0, -90}}, color = {0, 0, 0}, thickness = 0.5)}),
    Window(x = 0.17, y = 0.1, width = 0.76, height = 0.76),
    Documentation(info = "
## Copyright © EDF 2002 - 2026   
## ThermoSysPro Version 4.2  
This component model is documented in Sect. 10.2 of the ThermoSysPro book.   
# Stodola turbine   
   
The steam turbine transforms the steam thermal energy into mechanical energy  
following the Rankine cycle. A multistage turbine is composed of a group of  
stages that uses wet or dry steam.  

The Stodola turbine is a quasi-static model, composed of a multistage steam turbine and a nozzle. Stodola's cone law  is used to compute the dependence of extraction pressures with the fluid flow.  

The following assumptions are made:  
- the fluid speed is subsonic.  
- the dynamic response of the turbine is faster than the network queries (inertia is neglected).  
- the flow is supercritical or subcritical at the inlet and outlet.  

## Modelica component model  

The equations mentioned below are implemented in the component *StodolaTurbine*, located in the *WaterSteam.HeatExchangers* sub-library.   
This component has 4 connectors:  
- Ce: fluid inlet,  
- Cs: fluid outlet,  
- M: mechanical torque,  
- P: mechanical power.  
   
![modelica://ThermoSysPro/UsersGuide/Documentation/ThermoSysPro.WaterSteam.Machines.StodolaTurbine.svg](modelica://ThermoSysPro/UsersGuide/Documentation/ThermoSysPro.WaterSteam.Machines.StodolaTurbine.svg)  

## Nomenclature  

| Symbol| Description| Unit| Definition| Modelica name |  
| :------------------------------------ | :------------------------------------------------- | :--------------------------- | :---------------------------------------------------------- | -----------------|  
| \\\\(A\\_{\\mathrm{nz}}\\\\)| Nozzle area| \\\\(\\mathrm{m}^{2}\\\\)|| - |  
| \\\\(C\\_{\\mathrm{s}}\\\\)| Stodola’s ellipse coefficient| \\\\(-\\\\)|| Cst |  
| \\\\(h\\_{\\mathrm{i}}\\\\)| Fluid specific enthalpy at the inlet| \\\\(\\mathrm{J} / \\mathrm{kg}\\\\) || Ce.h |  
| \\\\(h\\_{\\mathrm{is}}\\\\)| Fluid specific enthalpy after isentropic expansion | \\\\(\\mathrm{J} / \\mathrm{kg}\\\\) || His |  
| \\\\(h\\_{\\mathrm{o}}\\\\)| Fluid specific enthalpy at the outlet| \\\\(\\mathrm{J} / \\mathrm{kg}\\\\) || Cs.h |  
| \\\\(m\\\\)| Fluid mass flow rate| \\\\(\\mathrm{kg} / \\mathrm{s}\\\\) || Q |  
| \\\\(P\\_{\\mathrm{i}}\\\\)| Fluid pressure at the inlet| \\\\(\\mathrm{Pa}\\\\)|| Pe |  
| \\\\(P\\_{\\mathrm{o}}\\\\)| Fluid pressure at the outlet| \\\\(\\mathrm{Pa}\\\\)|| Ps |  
| \\\\(T\\_{\\mathrm{i}}\\\\)| Fluid temperature at the inlet| \\\\(\\mathrm{K}\\\\)|| Te |  
| \\\\(v\\_{\\mathrm{o}}\\\\)| Fluid velocity at the outlet| \\\\(\\mathrm{m} / \\mathrm{s}\\\\)| \\\\(\\frac{\\dot{m}}{\\rho\\_{\\mathrm{o}} \\cdot A\\_{\\mathrm{nz}}}\\\\) | Ts |  
| \\\\(W\\\\)| Mechanical power produced by the turbine| \\\\(\\mathrm{W}\\\\)|| W |  
| \\\\(W\\_{\\text {fric }}\\\\)| Power losses due to hydrodynamic friction| \\\\(\\%\\\\)|| W_fric |  
| \\\\(x\\_{\\mathrm{i}}\\\\)| Vapor mass fraction at the inlet| \\\\(-\\\\)|| proe.x |  
| \\\\(x\\_{\\mathrm{o}}\\\\)| Vapor mass fraction at the outlet| \\\\(-\\\\)|| pros.x |  
| \\\\(\\eta\\_{\\mathrm{is}}\\\\)| Isentropic efficiency for the dry steam| \\\\(-\\\\)|| eta_is |  
| \\\\(\\eta\\_{\\mathrm{is}}^{\\mathrm{wet}}\\\\) | Isentropic efficiency for wet steam| \\\\(-\\\\)|| eta_is_wet |  
| \\\\(\\eta\\_{\\mathrm{nz}}\\\\)| Nozzle efficiency| \\\\(-\\\\)|| eta_nz |  
| \\\\(\\eta\\_{\\mathrm{sta}}\\\\)| Efficiency to account for kinetic losses| \\\\(-\\\\)|| eta_stato |  

## Governing equations  

### Stodola’s ellipse law mass flow rate for subcritical flow  


    
    

- Validity domain:   
   
 \\\\(\\forall \\dot{m}\\\\) and \\\\(x\\_{\\mathrm{i}}>0\\\\)  

- Mathematical formulation:   
   
 $$\\dot{m}=C\\_{\\mathrm{s}} \\cdot \\sqrt{\\frac{P\\_{\\mathrm{i}}^{2}-P\\_{\\mathrm{o}}^{2}}{x\\_{\\mathrm{i}} \\cdot T\\_{\\mathrm{i}}}}$$  

- Comments:   
   

### Stodola’s ellipse law mass flow rate for supercritical flow  


    
    

- Validity domain:   
   
 \\\\(\\forall \\dot{m}\\\\)  

- Mathematical formulation:   
   
 $$\\dot{m}=C\\_{\\mathrm{s}} \\cdot \\sqrt{\\frac{P\\_{\\mathrm{i}}^{2}-P\\_{\\mathrm{o}}^{2}}{T\\_{\\mathrm{i}}}}$$  

- Comments:   


### Fluid specific enthalpy at the outlet  

- Validity domain:  

everywhere  

- Mathematical formulation:   
   
 $$h\\_{\\mathrm{o}}=h\\_{\\mathrm{i}}+\\eta\\_{\\mathrm{is}} \\cdot x\\_{\\mathrm{m}} \\cdot\\left\\(h\\_{\\mathrm{is}}-h\\_{\\mathrm{i}}\\right\\)+\\frac{\\left\\(1-\\eta\\_{\\mathrm{nz}}\\right\\) \\cdot v\\_{\\mathrm{o}}^{2}}{2}$$  

- Comments:   
   
The last term of the equation corresponds to the kinetic energy of the steam at the outlet. The nozzle efficiency \\\\(\\eta\\_{\\mathrm{nz}}\\\\) is less than unity for a turbine with nozzle and equal to unity for a turbine without nozzle.   

### Energy balance equation (mechanical power produced by the turbine)  

- Validity domain:   
   
 \\\\(\\forall \\dot{m}\\\\)  

- Mathematical formulation:   
   
 $$W=\\eta\\_{\\text {sta }} \\cdot \\dot{m} \\cdot\\left\\(h\\_{\\mathrm{i}}-h\\_{\\mathrm{o}}\\right\\) \\cdot\\left\\(1-\\frac{W\\_{\\text {fric }}}{100}\\right\\)$$   

## References   
   
El Hefni, Baligh and Bouskela, Daniel (2019). [Modeling and Simulation of Thermal Power Plants with ThermoSysPro](https://link.springer.com/book/10.1007/978-3-030-05105-1), sect. 10.2. Springer Nature Switzerland AG.  
    ", revisions = "
Authors  

Daniel Bouskela  
Baligh El Hefni   

    "));
end StodolaTurbine;