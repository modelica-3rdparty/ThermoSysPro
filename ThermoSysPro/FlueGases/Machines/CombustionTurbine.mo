within ThermoSysPro.FlueGases.Machines;

model CombustionTurbine "Combustion turbine"
  parameter Real A3 = 0 "X^3 coefficient of the efficiency curve";
  parameter Real A2 = -0.04778 "X^2 coefficient of the efficiency curve";
  parameter Real A1 = 0.09555 "X^1 coefficient of the efficiency curve";
  parameter Real A0 = 0.95223 "X^0 coefficient of the efficiency curve";
  parameter Real tau_n = 0.07 "Nominal expansion rate";
  parameter Real is_eff_n = 0.8600 "Nominal isentropic efficiency";
  parameter Real Qred = 0.01 "Reduced mass flow rate";
  Real tau(start = 0.07) "Expansion rate";
  Real is_eff(start = 0.85) "Isentropic efficiency";
  Units.SI.Power Wcp(start = 1e9) "Compressor power";
  Units.SI.Power Wturb(start = 2e9) "Turbine power";
  Units.SI.Power Wmech(start = 1e9) "Mechanical power";
  Units.SI.AbsolutePressure Pe(start = 1e5) "Flue gases pressure at the inlet";
  Units.SI.AbsolutePressure Ps(start = 1e5) "Flue gases pressure at the outlet";
  Real Xtau(start = 1) "Ratio between the actual and nominal expansion rate";
  Units.SI.MassFlowRate Q(start = 500) "Flue gases mass flow rate";
  Units.SI.Temperature Te(start = 1.4e3) "Flue gases temperature at the inlet";
  Units.SI.Temperature Ts(start = 900) "Flue gases temperature at the outlet";
  Units.SI.Temperature Tis(start = 750) "Isentropic air temperature at the outlet";
  Units.SI.SpecificEnthalpy He(start = 1.2e6) "Flue gases specific enthalpy at the inlet";
  Units.SI.SpecificEnthalpy Hs(start = 6e5) "Flue gases specific enthalpy at the outlet";
  Units.SI.SpecificEnthalpy His(start = 6e5) "Flue gases specific enthalpy after the isentropic expansion";
  Units.SI.SpecificEntropy Se "Flue gases specific entropy at the inlet";
  ThermoSysPro.FlueGases.Connectors.FlueGasesInlet Ce annotation(
    Placement(transformation(extent = {{-110, -10}, {-90, 10}}, rotation = 0)));
  ThermoSysPro.FlueGases.Connectors.FlueGasesOutlet Cs annotation(
    Placement(transformation(extent = {{90, -10}, {110, 10}}, rotation = 0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal CompressorPower annotation(
    Placement(transformation(extent = {{-120, -50}, {-100, -30}}, rotation = 0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal MechPower annotation(
    Placement(transformation(extent = {{100, -100}, {120, -80}}, rotation = 0)));
equation
/* Connector at the inlet */
  Pe = Ce.P;
  Q = Ce.Q;
  Te = Ce.T;
/* Connector at the outlet */
  Ps = Cs.P;
  Q = Cs.Q;
  Ts = Cs.T;
/* Input compressor power (negative value) */
  Wcp = CompressorPower.signal;
/* Flue gases composition */
  Cs.Xco2 = Ce.Xco2;
  Cs.Xh2o = Ce.Xh2o;
  Cs.Xo2 = Ce.Xo2;
  Cs.Xso2 = Ce.Xso2;
/* Expansion rate */
  tau = Ps/Pe;
/* Expansion rates ratio */
  Xtau = tau/tau_n;
/* Isentropic efficiency */
  is_eff = (A3*Xtau^3 + A2*Xtau^2 + A1*Xtau + A0)*is_eff_n;
/* Reduced mass flow rate */
  Qred = (Q*sqrt(Te))/Pe;
/* Turbine power */
  Wturb = Q*(He - Hs);
/* Mechanical power */
  Wmech = Wturb + Wcp;
  MechPower.signal = Wmech;
/* Specific enthalpy at the inlet */
  He = ThermoSysPro.Properties.FlueGases.FlueGases_h(Pe, Te, Ce.Xco2, Ce.Xh2o, Ce.Xo2, Ce.Xso2);
/* Specific entropy at the inlet */
  Se = ThermoSysPro.Properties.FlueGases.FlueGases_s(Pe, Te, Ce.Xco2, Ce.Xh2o, Ce.Xo2, Ce.Xso2);
/* Specific enthalpy after the isentropic expansion */
  Se = ThermoSysPro.Properties.FlueGases.FlueGases_s(Ps, Tis, Ce.Xco2, Ce.Xh2o, Ce.Xo2, Ce.Xso2);
  His = ThermoSysPro.Properties.FlueGases.FlueGases_h(Ps, Tis, Ce.Xco2, Ce.Xh2o, Ce.Xo2, Ce.Xso2);
/* Specific enthalpy at the outlet */
  Hs = is_eff*(His - He) + He;
/* Temperature at the outlet */
//  Ts = ThermoSysPro.Properties.FlueGases.FlueGases_T(Ps, Hs, Ce.Xco2, Ce.Xh2o, Ce.Xo2, Ce.Xso2);
// replace by a function that can be differentiated and call with unknown variable on right-hand side
  Hs = ThermoSysPro.Properties.FlueGases.FlueGases_h(Ps, Ts, Ce.Xco2, Ce.Xh2o, Ce.Xo2, Ce.Xso2);
  annotation(
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, initialScale = 0.1), graphics = {Polygon(points = {{-100, 40}, {-100, -40}, {100, -100}, {100, 100}, {-100, 40}}, lineColor = {0, 0, 255}, fillColor = {128, 255, 0}, fillPattern = FillPattern.Backward)}),
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, initialScale = 0.1), graphics = {Polygon(points = {{-100, 40}, {-100, -40}, {100, -100}, {100, 100}, {-100, 40}}, lineColor = {0, 0, 255}, fillColor = {128, 255, 0}, fillPattern = FillPattern.Backward)}),
    Documentation(revisions = "
Author  

Baligh El Hefni   

    ", info = "
## Copyright © EDF 2002 - 2026  
## ThermoSysPro Version 4.2  
This component model is documented in Sect. 11.4 of the ThermoSysPro book.   

# Combustion turbine   

A combustion turbine, also called gas turbine, is a type of internal combustion engine. The main elements common to all gas turbines are an upstream rotating gas compressor, a combustor and a downstream turbine on the same shaft as the compressor.  
In this model, the hot fluid flow is assumed steady-state and supersonic.  

## Modelica component model  

The equations mentioned below are implemented in the component *CombustionTurbine*, located in the *FlueGases.Machines* sub-library.  
The component has 4 connectors:  
- Ce: flue gases at the inlet,  
- Cs: flue gases at the outlet,  
- CompressorPower: compressor power input,  
- MechPower: mechanical power output.  
   
![modelica://ThermoSysPro/UsersGuide/Documentation/ThermoSysPro.FlueGases.Machines.CombustionTurbine.svg](modelica://ThermoSysPro/UsersGuide/Documentation/ThermoSysPro.FlueGases.Machines.CombustionTurbine.svg)  

## Nomenclature  

| Symbol| Description| Unit| Definition| Modelica name|  
| :------------------------- | :----------------------------------------------------- | :--------------------------- | :---------------------------------- | :-------------------------------|  
| \\\\(h\\_{\\mathrm{i}}\\\\)| Fluid specific enthalpy at the inlet| \\\\(\\mathrm{J} / \\mathrm{kg}\\\\) ||He|  
| \\\\(h\\_{\\mathrm{is}}\\\\)| Fluid specific enthalpy after the isentropic expansion | \\\\(\\mathrm{J} / \\mathrm{kg}\\\\) ||His|  
| \\\\(h\\_{\\mathrm{o}}\\\\)| Fluid specific enthalpy at the outlet| \\\\(\\mathrm{J} / \\mathrm{kg}\\\\) ||Hs|  
| \\\\(\\dot{m}\\\\)| Fluid mass flow rate| \\\\(\\mathrm{kg} / \\mathrm{s}\\\\) ||Q|  
| \\\\(\\dot{m}\\_{\\mathrm{cor}}\\\\) | Corrected mass flow rate \\(mass flow rate parameter\\)| \\\\(-\\\\)||Qred|  
| \\\\(P\\_{\\mathrm{i}}\\\\)| Fluid pressure at the inlet| \\\\(\\mathrm{Pa}\\\\)||Pe|  
| \\\\(P\\_{\\mathrm{o}}\\\\)| Fluid pressure at the outlet| \\\\(\\mathrm{Pa}\\\\)||Ps|  
| \\\\(W\\_{\\mathrm{c}}\\\\)| Compressor power \\(negative value\\)| \\\\(\\mathrm{W}\\\\)||Wcp|  
| \\\\(W\\_{\\mathrm{m}}\\\\)| Mechanical power| \\\\(\\mathrm{W}\\\\)||Wmech|  
| \\\\(W\\_{\\mathrm{t}}\\\\)| Turbine power \\(total power\\)| \\\\(\\mathrm{W}\\\\)||Wturb|  
| \\\\(X\\\\)| Ratio between the actual and nominal expansion rate| \\\\(-\\\\)| \\\\(\\pi / \\pi\\_{n}\\\\)|Xtau|  
| \\\\(\\eta\\_{\\mathrm{is}}\\\\)| Isentropic efficiency| \\\\(-\\\\)||is_eff|  
| \\\\(\\eta\\_{\\mathrm{n}}\\\\)| Nominal isentropic efficiency| \\\\(-\\\\)||is_eff_n|  
| \\\\(\\pi\\\\)| Expansion rate| \\\\(-\\\\)| \\\\(P\\_{\\mathrm{o}} / P\\_{\\mathrm{i}}\\\\)|tau|  
| \\\\(\\pi\\_{\\mathrm{n}}\\\\)| Nominal expansion rate| \\\\(-\\\\)||tau_n|  

## Governing equations  

### Fluid specific enthalpy at the outlet  


    
    

- Validity domain:   
   
 \\\\(\\forall h\\_{\\mathrm{i}}\\\\)  

- Mathematical formulation:   
   
 $$h\\_{\\mathrm{o}}=h\\_{\\mathrm{i}}+\\eta\\_{\\mathrm{is}} \\cdot\\left\\(h\\_{\\mathrm{is}}-h\\_{\\mathrm{i}}\\right\\)$$  

- Comments:   
   



### Isentropic efficiency  


    
    

- Validity domain:   
   
 \\\\(X>0\\\\)  

- Mathematical formulation:   
   
 $$\\eta\\_{\\mathrm{is}}=f\\_{\\eta\\_{\\mathrm{is}}}\\(X\\) \\cdot \\eta\\_{n}$$  

- Comments:   
   
 \\\\(f\\_{\\eta\\_{\\mathrm{is}}}\\(X\\)\\\\) is the turbine map expressed as a polynomial function of \\\\(X\\\\).   


### Total turbine power  


    
    

- Validity domain:   
   
 \\\\(\\forall \\dot{m}\\\\)  

- Mathematical formulation:   
   
 $$W\\_{\\mathrm{t}}=\\dot{m} \\cdot\\left\\(h\\_{\\mathrm{i}}-h\\_{\\mathrm{o}}\\right\\)$$  

- Comments:   
   



### Mechanical power  


    
    

- Validity domain:   
   
 \\\\(\\forall \\dot{m}\\\\)  

- Mathematical formulation:   
   
 $$W\\_{\\mathrm{m}}=W\\_{\\mathrm{t}}+W\\_{\\mathrm{c}}$$  

- Comments:   
   
 The mechanical power produced by the shaft of the electricity generator is the total turbine power minus the power used by the compressor (counted negatively).   


### Mass flow rate  


    
    

- Validity domain:   
   
 \\\\(\\forall P\\_{i}\\\\) and \\\\(\\forall T\\_{\\mathrm{i}}\\\\)  

- Mathematical formulation:   
   
 $$\\dot{m}\\_{\\mathrm{cor}}=\\frac{\\dot{m} \\cdot \\sqrt{T\\_{\\mathrm{i}}}}{P\\_{\\mathrm{i}}}$$  

- Comments:   
   
 This equation calculates the mass flow rate from the corrected mass flow rate provided by the user.   

## References   
   
El Hefni, Baligh and Bouskela, Daniel (2019). [Modeling and Simulation of Thermal Power Plants with ThermoSysPro](https://link.springer.com/book/10.1007/978-3-030-05105-1), sect. 11.4. Springer Nature Switzerland AG.  
    "));
end CombustionTurbine;