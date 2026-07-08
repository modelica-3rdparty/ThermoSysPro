within ThermoSysPro.WaterSteam.Junctions;

model SteamDryer "Steam dryer"
  parameter Real eta = 1 "Vapor mass fraction at outlet (0 < eta <= 1 and eta > Vapor mass fraction at the inlet)";
  parameter Integer mode_e = 0 "IF97 region at the inlet. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  Units.SI.AbsolutePressure P(start = 10e5) "Fluid pressure";
  Units.SI.SpecificEnthalpy h(start = 10e5) "Fluid specific enthalpy";
  Real xe(start = 1.0) "Vapor mass fraction at the inlet";
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph proe annotation(
    Placement(transformation(extent = {{-100, 80}, {-80, 100}}, rotation = 0)));
  Connectors.FluidInlet Cev annotation(
    Placement(transformation(extent = {{-109, 30}, {-89, 50}}, rotation = 0)));
  Connectors.FluidOutlet Csv annotation(
    Placement(transformation(extent = {{89, 30}, {109, 50}}, rotation = 0)));
  ThermoSysPro.Properties.WaterSteam.Common.PropThermoSat lsat1 annotation(
    Placement(transformation(extent = {{-100, -98}, {-80, -78}}, rotation = 0)));
  ThermoSysPro.Properties.WaterSteam.Common.PropThermoSat vsat1 annotation(
    Placement(transformation(extent = {{-76, -98}, {-56, -78}}, rotation = 0)));
  Connectors.FluidOutlet Csl annotation(
    Placement(transformation(extent = {{-9, -110}, {11, -90}}, rotation = 0)));
equation
  assert((eta > 0) and (eta <= 1), "SteamDryer - Parameter eta should be > 0 and <= 1");
/* Fluid pressure */
  P = Cev.P;
  P = Csv.P;
  P = Csl.P;
/* Fluid specific enthalpy (singular if all flows = 0) */
  Cev.h_vol = h;
  Csv.h_vol = h;
  Csl.h_vol = noEvent(if (xe > 0) then lsat1.h else Cev.h);
/* Mass flow at the vapor outlet*/
  Csv.Q = noEvent(if (xe > 0) then Cev.Q*(1 - eta*(1 - xe)) else 0);
/* Mass balance equation */
  0 = Cev.Q - Csv.Q - Csl.Q;
/* Energy balance equation */
  0 = Cev.Q*Cev.h - Csv.Q*Csv.h - Csl.Q*Csl.h;
/* Fluid thermodynamic properties */
  proe = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Cev.P, Cev.h, mode_e);
/* Vapor mass fraction at the inlet */
  xe = proe.x;
/* Fluid thermodynamic properties at the saturation point */
  (lsat1, vsat1) = ThermoSysPro.Properties.WaterSteam.IF97.Water_sat_P(Cev.P);
  annotation(
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics = {Polygon(points = {{-98, 40}, {-18, -100}, {22, -100}, {102, 40}, {-98, 40}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid)}),
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics = {Polygon(points = {{-100, 40}, {-20, -100}, {20, -100}, {100, 40}, {-100, 40}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid)}),
    Window(x = 0.17, y = 0.1, width = 0.76, height = 0.76),
    Documentation(info = "
## Copyright © EDF 2002 - 2026  
## ThermoSysPro Version 4.2   
This component model is documented in Sect. 14.9 of the ThermoSysPro book.   
# Steam dryer   

The steam dryer is a reservoir of steam and water used to separate water from the steam generated in the boiler.  
Indeed, wet steam (steam containing some liquid) can reduce the  
plant efficiency and cause damage to most items and equipment of the plant.  

Following assumptions are made:  
- heat exchange between the liquid and steam phases is neglected.  
- heat exchange between the steam dryer and the external medium is neglected.  
- pressure losses are neglected.  


## Modelica component model  

The equations mentioned below are implemented in the component *SteamDryer*, located in the *WaterSteam.Junctions* sub-library.   
This component has 3 connectors:  
- Cev: vapor inlet,  
- Csl: liquid outlet,  
- Csv: vapor outlet.  

![modelica://ThermoSysPro/UsersGuide/Documentation/ThermoSysPro.WaterSteam.Junctions.SteamDryer.svg](modelica://ThermoSysPro/UsersGuide/Documentation/ThermoSysPro.WaterSteam.Junctions.SteamDryer.svg)  

## Nomenclature  

| Symbol| Description| Unit| Definition | Modelica name |  
| :----------------------------- | :------------------------------------------------------- | :--------------------------- | :---------------------- | :----------- |  
| \\\\(h\\_{\\mathrm{i}}\\\\)| Specific enthalpy of the fluid at the inlet of the dryer | \\\\(\\mathrm{J} / \\mathrm{kg}\\\\) || Cev.h |  
| \\\\(h\\_{l, \\mathrm{o}}\\\\)| Specific enthalpy of the liquid at the outlet| \\\\(\\mathrm{J} / \\mathrm{kg}\\\\) || Cs1.h |  
| \\\\(h\\_{l}^{\\mathrm{sat}}\\\\)| Saturation enthalpy of the liquid| \\\\(\\mathrm{J} / \\mathrm{kg}\\\\) || lsat1.h |  
| \\\\(h\\_{\\mathrm{v}, \\mathrm{o}}\\\\) | Specific enthalpy of the steam at the outlet| \\\\(\\mathrm{J} / \\mathrm{kg}\\\\) || Csv.h |  
| \\\\(\\dot{m}\\_{\\mathrm{i}}\\\\)| Fluid mass flow rate at the inlet| \\\\(\\mathrm{kg} / \\mathrm{s}\\\\) || Cev.Q |  
| \\\\(\\dot{m}\\_{l, \\mathrm{o}}\\\\)| Liquid mass flow rate at the outlet| \\\\(\\mathrm{kg} / \\mathrm{s}\\\\) || Cs1.Q |  
| \\\\(m\\_{\\mathrm{v}, \\mathrm{o}}\\\\) | Steam mass flow rate at the outlet| \\\\(\\mathrm{kg} / \\mathrm{s}\\\\) || Csv.Q |  
| \\\\(P\\\\)| Fluid pressure in the dryer| \\\\(\\mathrm{Pa}\\\\)|| P |  
| \\\\(x\\_{\\mathrm{i}}\\\\)| Steam mass fraction at the inlet| \\\\(-\\\\)|| xe |  
| \\\\(\\eta\\\\)| Steam dryer efficiency| \\\\(-\\\\)| \\\\(0 \\leq \\eta \\leq 1\\\\)| eta |  



## Governing equations  

### Static mass balance equation  

- Validity domain:  

\\\\(\\forall \\dot{m}\\\\)  

- Mathematical formulation:  

$$0=\\dot{m}\\_{\\mathrm{i}}-\\dot{m}\\_{l, \\mathrm{o}}-\\dot{m}\\_{\\mathrm{v}, \\mathrm{o}}$$  

- Comments :  

 The value of the steam mass flow rate at the outlet  
\\\\(\\left\\(\\dot{m}\\_{\\mathrm{v}, \\mathrm{o}}\\right\\)\\\\) is given by  
$$   \\dot{m}_{\\mathrm{v}, \\mathrm{o}}=\\left\\{\\begin{array}{ll}   0  \\text{ for } x_{\\mathrm{i}}=0 \\\\   \\dot{m}_{\\mathrm{i}} \\cdot\\left(1-\\eta \\cdot\\left(1-x_{\\mathrm{i}}\\right)\\right)  \\text{ for } x_{\\mathrm{i}}>0   \\end{array}\\right.$$  

In a real steam separator, small quantities of liquid remain in the steam.  
The efficiency gives the discrepancy between ideal and real steam separator.  


### Static energy balance equation  

- Validity domain:  

\\\\(\\exists \\dot{m}\\\\) such that \\\\(\\dot{m} \\neq 0\\\\)  

- Mathematical formulation:  

$$0=\\dot{m}\\_{\\mathrm{i}} \\cdot h\\_{\\mathrm{i}}-\\dot{m}\\_{l, \\mathrm{o}} \\cdot h\\_{l, \\mathrm{o}}-\\dot{m}\\_{\\mathrm{v}, \\mathrm{o}} \\cdot h\\_{\\mathrm{v}, \\mathrm{o}}$$  

- Comments:  

This equation is valid if not all mass flow rates are equal to zero. Otherwise, the mixing specific enthalpy inside the steam dryer is undefined. The value of the specific enthalpy of the liquid at the outlet \\\\(h\\_{l,0}\\\\) is given by:  

$$   h_{1, \\mathrm{o}}=\\left\\{\\begin{array}{ll}h_{1}^{\\mathrm{sat}}  \\text{ for } x_{\\mathrm{i}}>0 \\\\ h_{\\mathrm{i}}  \\text{ for } x_{\\mathrm{i}}=0\\end{array}\\right.$$  
## References   
   
El Hefni, Baligh and Bouskela, Daniel (2019). [Modeling and Simulation of Thermal Power Plants with ThermoSysPro](https://link.springer.com/book/10.1007/978-3-030-05105-1), sect. 14.9. Springer Nature Switzerland AG.  
    ", revisions = "
Authors  

Baligh El Hefni  
Daniel Bouskela   

    "));
end SteamDryer;