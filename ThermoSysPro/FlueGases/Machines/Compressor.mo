within ThermoSysPro.FlueGases.Machines;

model Compressor "Gas compressor"
  parameter Integer mass_flow_rate_comp = 1 "Ways for computing the mass flow rate - 1: Q = rho*Qv - 2: Q = rho*f(T)";
  parameter Units.SI.Temperature Tmax = 284.16 "Air transition temperature between f1 = a*x + b and f2 = c*x + d for the computation of Q (active if mass_flow_rate_comp == 2)";
  parameter Real coef1_1 = 0.1164 "Coefficient a for f1 = a*x + b";
  parameter Real coef2_1 = 38.643 "Coefficient b for f1 = a*x + b";
  parameter Real coef1_2 = -0.2324 "Coefficient c for f2 = c*x + d";
  parameter Real coef2_2 = 137.49 "Coefficient d for f2 = c*x + d";
  parameter Real A4 = -1.2362 "Coefficient of X^4 for the computation of the isentropic efficiency";
  parameter Real A3 = 3.6721 "Coefficient of X^3 for the computation of the isentropic efficiency";
  parameter Real A2 = -4.2434 "Coefficient of X^2 for the computation of the isentropic efficiency";
  parameter Real A1 = 2.3957 "Coefficient of X^1 for the computation of the isentropic efficiency";
  parameter Real A0 = 0.4118 "Coefficient of X^0 for the computation of the isentropic efficiency";
  parameter Real tau_n = 14.149 "Nominal compression rate";
  parameter Real is_eff_n = 0.84752 "Nominal isentropic efficiency";
  Real tau(start = 15) "Compression rate";
  Real is_eff(start = 0.85) "Isentropic efficiency";
  Units.SI.Power Wcp(start = 1e9) "Compressor power";
  Units.SI.AbsolutePressure Pe(start = 1e5) "Air pressure at the inlet";
  Units.SI.AbsolutePressure Ps(start = 15e5) "Air pressure at the outlet";
  Real Xtau(start = 1) "Normal and nominal compression rates ratio";
  Units.SI.MassFlowRate Q(start = 500) "Air mass flow rate";
  Units.SI.VolumeFlowRate Qv(start = 500) "Air volumetric flow rate";
  Units.SI.Temperature Te(start = 300) "Air temperature at the inlet";
  Units.SI.Temperature Ts(start = 750) "Air temperature at the outlet";
  Units.SI.Temperature Tis(start = 750) "Isentropic air temperature at the outlet";
  Units.SI.SpecificEnthalpy He(start = 80e3) "Air specific enthalpy at the inlet";
  Units.SI.SpecificEnthalpy Hs(start = 500e3) "Air specific enthalpy at the outlet";
  Units.SI.SpecificEnthalpy His(start = 450e3) "Air specific enthalpy after the isentropic compression";
  Units.SI.SpecificEntropy Se "Air specific entropy at the inlet";
  Units.SI.Density rho_e(start = 1) "Air density at the inlet";
  ThermoSysPro.FlueGases.Connectors.FlueGasesInlet Ce annotation(
    Placement(transformation(extent = {{-100, -10}, {-80, 10}}, rotation = 0)));
  ThermoSysPro.FlueGases.Connectors.FlueGasesOutlet Cs annotation(
    Placement(transformation(extent = {{80, -10}, {100, 10}}, rotation = 0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal Power annotation(
    Placement(transformation(extent = {{80, -40}, {100, -20}}, rotation = 0)));
protected
  Units.SI.VolumeFlowRate Qv_cal(start = 500) "Intermediate variable for the computation of Qv";
equation
/* Connector at the inlet */
  Pe = Ce.P;
  Q = Ce.Q;
  Te = Ce.T;
/* Connector at the outlet */
  Ps = Cs.P;
  Q = Cs.Q;
  Ts = Cs.T;
/* Flue gases composition */
  Cs.Xco2 = Ce.Xco2;
  Cs.Xh2o = Ce.Xh2o;
  Cs.Xo2 = Ce.Xo2;
  Cs.Xso2 = Ce.Xso2;
/* Compression rate */
  tau = Ps/Pe;
/* Compression rates ratio */
  Xtau = tau/tau_n;
/* Isentropic efficiency */
  is_eff = (A4*Xtau^4 + A3*Xtau^3 + A2*Xtau^2 + A1*Xtau + A0)*is_eff_n;
/* Compressor power */
  Wcp = Q*(He - Hs);
  Power.signal = Wcp;
/* Volume flow rate at the inlet */
  Qv_cal = if (Te < Tmax) then coef1_1*Te + coef2_1 else coef1_2*Te + coef2_2;
  Q = if (mass_flow_rate_comp == 1) then Qv*rho_e else Qv_cal*rho_e;
/* Specific enthalpy at the inlet */
  He = ThermoSysPro.Properties.FlueGases.FlueGases_h(Pe, Te, Ce.Xco2, Ce.Xh2o, Ce.Xo2, Ce.Xso2);
/* Specific entropy at the inlet */
  Se = ThermoSysPro.Properties.FlueGases.FlueGases_s(Pe, Te, Ce.Xco2, Ce.Xh2o, Ce.Xo2, Ce.Xso2);
/* Specific enthalpy after the isentropic compression */
  Se = ThermoSysPro.Properties.FlueGases.FlueGases_s(Ps, Tis, Ce.Xco2, Ce.Xh2o, Ce.Xo2, Ce.Xso2);
  His = ThermoSysPro.Properties.FlueGases.FlueGases_h(Ps, Tis, Ce.Xco2, Ce.Xh2o, Ce.Xo2, Ce.Xso2);
/* Fluid density at the inlet */
  rho_e = ThermoSysPro.Properties.FlueGases.FlueGases_rho(Pe, Te, Ce.Xco2, Ce.Xh2o, Ce.Xo2, Ce.Xso2);
/* Specific enthalpy at the outlet */
  Hs = (His - He + is_eff*He)/is_eff;
/* Temperature at the outlet */
//Ts = ThermoSysPro.Properties.FlueGases.FlueGases_T(Ps, Hs, Ce.Xco2, Ce.Xh2o, Ce.Xo2, Ce.Xso2);
// call implicitly to avoid function that can not be differentiated.
  Hs = ThermoSysPro.Properties.FlueGases.FlueGases_h(Ps, Ts, Ce.Xco2, Ce.Xh2o, Ce.Xo2, Ce.Xso2);
  annotation(
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-120, -100}, {120, 100}}), graphics = {Polygon(points = {{-80, 80}, {-80, -80}, {80, -40}, {80, 40}, {-80, 80}}, lineColor = {0, 0, 0}, fillColor = {0, 255, 0}, fillPattern = FillPattern.Backward)}),
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-120, -100}, {120, 100}}), graphics = {Polygon(points = {{-80, 80}, {-80, -80}, {80, -40}, {80, 40}, {-80, 80}}, lineColor = {0, 0, 0}, fillColor = {0, 255, 0}, fillPattern = FillPattern.Backward)}),
    Documentation(revisions = "
Author  

Baligh El Hefni   

    ", info = "
## Copyright © EDF 2002 - 2026  
## ThermoSysPro Version 4.2  
This component model is documented in Sect. 11.3 of the ThermoSysPro book.   

# Static compressor   
   
Most modern combustion turbines use multistage axial compressors. The pressure of the atmospheric air flowing through is increased up to 30 times.  
The mass flow rate of inlet air increases when the ambient temperature decreases.  

## Modelica component model  

The equations mentioned below are implemented in the component *Compressor*, located in the *FlueGases.Machines* sub-library.  
The component has 3 connectors:  
- Ce: flue gases at the inlet,  
- Cs: flue gases at the outlet,  
- Power: compressor power output.  
   
![modelica://ThermoSysPro/UsersGuide/Documentation/ThermoSysPro.FlueGases.Machines.Compressor.svg](modelica://ThermoSysPro/UsersGuide/Documentation/ThermoSysPro.FlueGases.Machines.Compressor.svg)  

## Nomenclature  

| Symbol| Description| Unit| Definition| Modelica name|  
| :-------------------- | :------------------------------------------------------- | :------------------------------- | :---------------------------------- |:---------------------------------- |  
| \\\\(h\\_{\\mathrm{i}}\\\\)| Fluid specific enthalpy at the inlet| \\\\(\\mathrm{J} / \\mathrm{kg}\\\\)||He|  
| \\\\(h\\_{\\mathrm{is}}\\\\)| Fluid specific enthalpy after the isentropic compression | \\\\(\\mathrm{J} / \\mathrm{kg}\\\\)||His|  
| \\\\(h\\_{\\mathrm{o}}\\\\)| Fluid specific enthalpy at the outlet| \\\\(\\mathrm{J} / \\mathrm{kg}\\\\)||Hs|  
| \\\\(m\\\\)| Fluid mass flow rate| \\\\(\\mathrm{kg} / \\mathrm{s}\\\\)| \\\\(q \\cdot \\rho\\_{\\mathrm{i}}\\\\)|Q|  
| \\\\(P\\_{\\mathrm{i}}\\\\)| Fluid pressure at the inlet| \\\\(\\mathrm{Pa}\\\\)||Pe|  
| \\\\(P\\_{\\mathrm{o}}\\\\)| Fluid pressure at the outlet| \\\\(\\mathrm{Pa}\\\\)||Ps|  
| \\\\(q\\\\)| Fluid volumetric flow rate| \\\\(\\mathrm{m}^{3} / \\mathrm{s}\\\\)||Qv|  
| \\\\(W\\_{\\mathrm{c}}\\\\)| Compressor power \\(negative value\\)| \\\\(\\mathrm{W}\\\\)||Wcp|  
| \\\\(X\\\\)| Ratio between the actual and nominal compression rate| \\\\(-\\\\)| \\\\(\\pi / \\pi\\_{n}\\\\)|Xtau|  
| \\\\(\\eta\\\\)| Isentropic efficiency| \\\\(-\\\\)||is_eff|  
| \\\\(\\eta\\_{\\mathrm{n}}\\\\) | Nominal isentropic efficiency| \\\\(-\\\\)||is_eff_n|  
| \\\\(\\pi\\\\)| Compression rate| \\\\(-\\\\)| \\\\(P\\_{\\mathrm{o}} / P\\_{\\mathrm{i}}\\\\)|tau|  
| \\\\(\\pi\\_{\\mathrm{n}}\\\\)| Nominal compression rate| \\\\(-\\\\)||tau_n|  
| \\\\(\\rho\\_{\\mathrm{i}}\\\\) | Fluid density at the inlet| \\\\(\\mathrm{kg} / \\mathrm{m}^{3}\\\\) ||rho_e|  

## Governing equations  

The steady-state model is based on a polynomial equation of the isentropic efficiency obtained by experimental data from several combined cycle power plants.  


### Fluid specific enthalpy at the outlet of the compressor  


    
    

- Validity domain:   
   
 \\\\(\\forall h\\_{\\mathrm{i}}\\\\)  

- Mathematical formulation:   
   
 $$h\\_{\\mathrm{o}}=h\\_{\\mathrm{i}}+\\frac{\\left\\(h\\_{\\mathrm{is}}-h\\_{\\mathrm{i}}\\right\\)}{\\eta\\_{\\mathrm{is}}}$$  

- Comments:   
   



### Compressor power  


    
    

- Validity domain:   
   
 \\\\(\\dot{m} \\geq 0\\\\)  

- Mathematical formulation:   
   
 $$W\\_{\\mathrm{c}}=\\dot{m} \\cdot\\left\\(h\\_{\\mathrm{i}}-h\\_{0}\\right\\)$$  

- Comments:   
   



### Isentropic efficiency  


    
    

- Validity domain:   
   
 \\\\(X>0\\\\)  

- Mathematical formulation:   
   
 $$\\eta=f\\_{\\eta}\\(X\\) \\cdot \\eta\\_{n}$$  

- Comments:   
   
 \\\\( f\\_{\\eta}\\(X\\)\\\\) is the compressor map expressed as a polynomial function of \\\\(X\\\\).   

## References   
   
El Hefni, Baligh and Bouskela, Daniel (2019). [Modeling and Simulation of Thermal Power Plants with ThermoSysPro](https://link.springer.com/book/10.1007/978-3-030-05105-1), sect. 11.3. Springer Nature Switzerland AG.  
    "));
end Compressor;