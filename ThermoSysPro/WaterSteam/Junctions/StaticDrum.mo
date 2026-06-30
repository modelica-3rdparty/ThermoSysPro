within ThermoSysPro.WaterSteam.Junctions;

model StaticDrum "Static drum"
  parameter Real x = 1 "Vapor separation efficiency at the outlet";
  Units.SI.Temperature T "Fluid temperature";
  Units.SI.AbsolutePressure P(start = 10.e5) "Fluid pressure";
  Units.SI.SpecificEnthalpy hl(start = 100000) "Liquid phase specific enthalpy";
  Units.SI.SpecificEnthalpy hv(start = 2800000) "Gas phase specific enthalpy";
  Connectors.FluidInlet Ce_eva annotation(
    Placement(transformation(extent = {{-104, -44}, {-84, -24}}, rotation = 0)));
  Connectors.FluidInlet Ce_eco annotation(
    Placement(transformation(extent = {{-50, -104}, {-30, -84}}, rotation = 0)));
  Connectors.FluidOutlet Cs_sup annotation(
    Placement(transformation(extent = {{84, 24}, {104, 44}}, rotation = 0)));
  Connectors.FluidOutlet Cs_eva annotation(
    Placement(transformation(extent = {{30, -104}, {50, -84}}, rotation = 0)));
  Connectors.FluidOutlet Cs_sur annotation(
    Placement(transformation(extent = {{28, 84}, {48, 104}}, rotation = 0)));
  Connectors.FluidOutlet Cs_purg annotation(
    Placement(transformation(extent = {{84, -44}, {104, -24}}, rotation = 0)));
  Connectors.FluidInlet Ce_steam annotation(
    Placement(transformation(extent = {{-48, 84}, {-28, 104}}, rotation = 0)));
  Connectors.FluidInlet Ce_sup annotation(
    Placement(transformation(extent = {{-104, 26}, {-84, 46}}, rotation = 0)));
  ThermoSysPro.Properties.WaterSteam.Common.PropThermoSat lsat annotation(
    Placement(transformation(extent = {{-104, 66}, {-78, 98}}, rotation = 0)));
  ThermoSysPro.Properties.WaterSteam.Common.PropThermoSat vsat annotation(
    Placement(transformation(extent = {{72, 68}, {100, 100}}, rotation = 0)));
  Thermal.Connectors.ThermalPort Cth annotation(
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
/* Unconnected connectors */
/* Steam input */
  if (cardinality(Ce_steam) == 0) then
    Ce_steam.Q = 0;
    Ce_steam.h = 1.e5;
    Ce_steam.b = true;
  end if;
/* Extra input */
  if (cardinality(Ce_sup) == 0) then
    Ce_sup.Q = 0;
    Ce_sup.h = 1.e5;
    Ce_sup.b = true;
  end if;
/* Input from evaporator */
  if (cardinality(Ce_eva) == 0) then
    Ce_eva.Q = 0;
    Ce_eva.h = 1.e5;
    Ce_eva.b = true;
  end if;
/* Input from the economizer */
  if (cardinality(Ce_eco) == 0) then
    Ce_eco.Q = 0;
    Ce_eco.h = 1.e5;
    Ce_eco.b = true;
  end if;
/* Output to the evaporator */
  if (cardinality(Cs_eva) == 0) then
    Cs_eva.Q = 0;
    Cs_eva.h = 1.e5;
    Cs_eva.a = true;
  end if;
/* Extra output */
  if (cardinality(Cs_purg) == 0) then
    Cs_purg.Q = 0;
    Cs_purg.h = 1.e5;
    Cs_purg.a = true;
  end if;
/* Extra output  */
  if (cardinality(Cs_sup) == 0) then
    Cs_sup.Q = 0;
    Cs_sup.h = 1.e5;
    Cs_sup.a = true;
  end if;
/* Output to reheater */
  if (cardinality(Cs_sur) == 0) then
    Cs_sur.Q = 0;
    Cs_sur.h = 1.e5;
    Cs_sur.a = true;
  end if;
/* Fluid pressure */
  P = Ce_steam.P;
  P = Ce_sup.P;
  P = Ce_eva.P;
  P = Ce_eco.P;
  P = Cs_eva.P;
  P = Cs_purg.P;
  P = Cs_sup.P;
  P = Cs_sur.P;
/* Fluid specific enthalpies at the inlets and outlets */
  Ce_sup.h_vol = hl;
  Ce_eva.h_vol = hl;
  Ce_eco.h_vol = hl;
  Ce_steam.h_vol = hv;
  Cs_purg.h_vol = hl;
  Cs_sup.h_vol = hl;
  Cs_eva.h_vol = hl;
  Cs_sur.h_vol = (1 - x)*hl + x*hv;
/* Mass balance equation */
  Ce_eco.Q + Ce_steam.Q + Ce_sup.Q + Ce_eva.Q - Cs_eva.Q - Cs_sur.Q - Cs_purg.Q - Cs_sup.Q = 0;
/* Energy balance equation */
  Ce_eco.Q*Ce_eco.h + Ce_steam.Q*Ce_steam.h + Ce_sup.Q*Ce_sup.h + Ce_eva.Q*Ce_eva.h - Cs_eva.Q*Cs_eva.h - Cs_sur.Q*Cs_sur.h - Cs_purg.Q*Cs_purg.h - Cs_sup.Q*Cs_sup.h + Cth.W = 0;
/* Fluid thermodynamic properties */
  (lsat, vsat) = ThermoSysPro.Properties.WaterSteam.IF97.Water_sat_P(P);
  hl = lsat.h;
  hv = vsat.h;
  T = lsat.T;
  Cth.T = T;
  annotation(
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics = {Line(points = {{0, 90}, {0, -100}}), Ellipse(extent = {{-98, 96}, {98, -96}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid), Line(points = {{-86, -44}, {86, -44}}, color = {0, 0, 255}, pattern = LinePattern.Dash), Line(points = {{-44, -86}, {44, -86}}, color = {0, 0, 255}, pattern = LinePattern.Dash), Line(points = {{-64, -72}, {64, -72}}, color = {0, 0, 255}, pattern = LinePattern.Dash), Line(points = {{-78, -58}, {76, -58}}, color = {0, 0, 255}, pattern = LinePattern.Dash), Text(extent = {{-56, 94}, {-56, 92}}, textString = "Esteam")}),
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics = {Line(points = {{0, 90}, {0, -100}}), Ellipse(extent = {{-98, 96}, {98, -96}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid), Line(points = {{-86, -44}, {86, -44}}, color = {0, 0, 255}, pattern = LinePattern.Dash), Line(points = {{-44, -86}, {44, -86}}, color = {0, 0, 255}, pattern = LinePattern.Dash), Line(points = {{-64, -72}, {64, -72}}, color = {0, 0, 255}, pattern = LinePattern.Dash), Line(points = {{-78, -58}, {76, -58}}, color = {0, 0, 255}, pattern = LinePattern.Dash)}),
    Window(x = 0.33, y = 0.08, width = 0.66, height = 0.69),
    Documentation(info = "
## Copyright © EDF 2002 - 2026   
## ThermoSysPro Version 4.2  
This component model is documented in Sect. 14.6 of the ThermoSysPro book.   
# Static drum   

The static drum is a reservoir at the top end of the boiler. It separates water from steam in the mixture generated in the boiler and stores them.  
This component can also be used as a simple steam generator.  

The static drum is modeled according to the following assumptions:  
- heat exchanges between the liquid and steam phases, as well as between drum and external medium, are negligible,  
- pressure losses are negligible,  
- water is always saturated.  



## Modelica component model  

The equations mentioned below are implemented in the component *StaticDrum*, located in the *WaterSteam.Junctions* sub-library.   
This component has 9 connectors:  
- Ce_eva: saturated water inlet from the evaporator,  
- Cs_eva: saturated water outlet toward the evaporator,  
- Ce_sup: supplementary water inlet,  
- Cs_sup: supplementary water outlet,  
- Ce_eco:  water inlet from a money saver,  
- Ce_steam: steam inlet,  
- Cs_sur: saturated steam outlet toward the overheater,  
- Cs_purg: saturated water outlet toward the drain,  
- Cth: thermal port.  
   
![modelica://ThermoSysPro/UsersGuide/Documentation/ThermoSysPro.WaterSteam.Junctions.StaticDrum.svg](modelica://ThermoSysPro/UsersGuide/Documentation/ThermoSysPro.WaterSteam.Junctions.StaticDrum.svg)  

## Nomenclature  

| Symbol| Description| Unit| Definition | Modelica name |  
| :--------------------------------------- | :---------------------------------------------------------------------------------------- | :--------------------------- | :---------------------- | :----------- |  
| \\\\(h\\_{\\text {eco, } i}\\\\)| Specific enthalpy of the liquid at the inlet of the drum, coming from the economizer| \\\\(\\mathrm{J} / \\mathrm{kg}\\\\) || Ce_eco.h |  
| \\\\(h\\_{\\text {eva }, \\mathrm{i}}\\\\)| Specific enthalpy of the fluid at the inlet of the drum, coming from the evaporator| \\\\(\\mathrm{J} / \\mathrm{kg}\\\\) || Ce_eva.h |  
| \\\\(h\\_{\\text {steam }, \\mathrm{i}}\\\\)| Specific enthalpy of the steam at the inlet| \\\\(\\mathrm{J} / \\mathrm{kg}\\\\) || Ce_steam.h |  
| \\\\(h\\_{\\text {sup }, \\mathrm{i}}\\\\)| Specific enthalpy of the fluid at the additional inlet| \\\\(\\mathrm{J} / \\mathrm{kg}\\\\) || Ce_sup.h |  
| \\\\(h\\_{\\text {drain,o }}\\\\)| Specific enthalpy of the liquid at the outlet, going to the drain| \\\\(\\mathrm{J} / \\mathrm{kg}\\\\) || Cs_purg.h |  
| \\\\(h\\_{\\mathrm{eva}, \\mathrm{o}}\\\\)| Specific enthalpy of the fluid at the outlet, going to the evaporator| \\\\(\\mathrm{J} / \\mathrm{kg}\\\\) || Cs_eva.h |  
| \\\\(h\\_{\\mathrm{sup}, \\mathrm{o}}\\\\)| Specific enthalpy of the liquid at the additional outlet| \\\\(\\mathrm{J} / \\mathrm{kg}\\\\) || Cs_sup.h |  
| \\\\(h\\_{\\mathrm{sur}, \\mathrm{o}}\\\\)| Specific enthalpy of the steam at the outlet, going to the super-heater| \\\\(\\mathrm{J} / \\mathrm{kg}\\\\) || Cs_sur.h |  
| \\\\(\\dot{m}\\_{\\text {drain }, \\mathrm{o}}\\\\) | Mass flow rate of the liquid at the outlet, going to the drain| \\\\(\\mathrm{kg} / \\mathrm{s}\\\\) || Cs_purg.Q |  
| \\\\(\\dot{m}\\_{\\mathrm{eco}, \\mathrm{i}}\\\\)| Mass flow rate of the fluid at the inlet, coming from the economizer| \\\\(\\mathrm{kg} / \\mathrm{s}\\\\) || Ce_eco.Q |  
| \\\\(\\dot{m}\\_{\\text {eva }, \\mathrm{i}}\\\\)| Mass flow rate of the fluid at the inlet, coming from the evaporator| \\\\(\\mathrm{kg} / \\mathrm{s}\\\\) || Ce_eva.Q |  
| \\\\(\\dot{m}\\_{\\mathrm{eva}, \\mathrm{o}}\\\\)| Mass flow rate of the liquid at the outlet, going to the evaporator| \\\\(\\mathrm{kg} / \\mathrm{s}\\\\) || Cs_eva.Q |  
| \\\\(\\dot{m}\\_{\\text {steam, } \\mathrm{i}}\\\\) | Mass flow rate of the steam at the inlet| \\\\(\\mathrm{kg} / \\mathrm{s}\\\\) || Ce_steam.Q |  
| \\\\(\\dot{m}\\_{\\mathrm{sup}, \\mathrm{i}}\\\\)| Mass flow rate of the fluid at the additional inlet| \\\\(\\mathrm{kg} / \\mathrm{s}\\\\) || Ce_sup.Q |  
| \\\\(\\dot{m}\\_{\\mathrm{sup}, \\mathrm{o}}\\\\)| Mass flow rate of the liquid at the additional outlet| \\\\(\\mathrm{kg} / \\mathrm{s}\\\\) || Cs_sup.Q |  
| \\\\(m\\_{\\mathrm{sur}, \\mathrm{o}}\\\\)| Mass flow rate of the steam at the outlet, going to the super-heater| \\\\(\\mathrm{kg} / \\mathrm{s}\\\\) || Cs_sur.Q |  
| \\\\(W\\\\)| Thermal power exchanged from the heat source to the fluid| \\\\(\\mathrm{W}\\\\)|| Cth.W |  
| \\\\(x\\\\)| Steam mass fraction at the outlet going to the super-heater \\(steam separation efficiency\\) | \\\\(-\\\\)|| x |  


## Governing equations  

### Static mass balance equation  


    
    

- Validity domain:   
   
 \\\\(\\forall \\dot{m}\\\\)  

- Mathematical formulation:   
   
$$ 0 =\\dot{m}\\_{\\mathrm{eco}, \\mathrm{i}}+\\dot{m}\\_{\\mathrm{eva}, \\mathrm{i}} +\\dot{m}\\_{\\mathrm{sup}, \\mathrm{i}}+\\dot{m}\\_{\\text {steam, }} -   
\\dot{m}\\_{\\text {drain }, \\mathrm{o}}-\\dot{m}\\_{\\mathrm{eva}, \\mathrm{o}}-\\dot{m}\\_{\\mathrm{sup}, \\mathrm{o}}-\\dot{m}\\_{\\mathrm{sur}, \\mathrm{o}} $$  

- Comments:   
   



### Static energy balance equation  


    
    

- Validity domain:   
   
 \\\\(\\exists \\dot{m}\\\\) such that \\\\(\\dot{m} \\neq 0\\\\)  

- Mathematical formulation:   

$$   0=\\dot{m}_{\\text{eco }, \\mathrm{i}} \\cdot h_{\\mathrm{eco}, \\mathrm{i}}+\\dot{m}_{\\mathrm{eva}, \\mathrm{i}} \\cdot h_{\\mathrm{eva}, \\mathrm{i}}+\\dot{m}_{\\mathrm{sup}, \\mathrm{i}} \\cdot h_{\\text{sup }, \\mathrm{i}}\\\\    \\quad +\\dot{m}_{\\text{steam,i }} \\cdot h_{\\text{steam,i }}-\\dot{m}_{\\text{drain,o }} \\cdot h_{\\text{drain,o }}-\\dot{m}_{\\mathrm{eva}, \\mathrm{o}} \\cdot h_{\\mathrm{eva}, \\mathrm{o}}\\\\    \\quad -\\dot{m}_{\\mathrm{sup}, \\mathrm{o}} \\cdot h_{\\mathrm{sup}, \\mathrm{o}}-\\dot{m}_{\\mathrm{sur}, \\mathrm{o}} \\cdot h_{\\mathrm{sur}, \\mathrm{o}}+W$$  

- Comments:   
   
 This equation is valid if some mass flow rates are non-zero. Otherwise, the mixing specific enthalpy is undefined.  


### Specific enthalpy at the drum liquid outlets  


    
    

- Validity domain:   
   
 \\\\(\\exists \\dot{m}\\\\) such that \\\\(\\dot{m} \\neq 0\\\\)  

- Mathematical formulation:   
   
 $$h\\_{\\mathrm{eva}, \\mathrm{o}}=h\\_{\\mathrm{sup}, \\mathrm{o}}=h\\_{\\text {drain }, \\mathrm{o}}=h\\_{l}^{\\mathrm{sat}}$$   

- Comments:   
   
 The liquid inside the drum is assumed always at saturation.  


### Specific enthalpy at the drum vapor outlet  


    
    

- Validity domain:   
   
 \\\\(\\exists \\dot{m}\\\\) such that \\\\(\\dot{m} \\neq 0\\\\) and \\\\(x \\approx 1\\\\)  

- Mathematical formulation:   
   
 $$h\\_{\\mathrm{sur}, \\mathrm{o}}=\\(1-x\\) \\cdot h\\_{l}^{\\mathrm{sat}}+x \\cdot h\\_{\\mathrm{v}}^{\\mathrm{sat}}$$  

- Comments:   
   
 The vapor inside the drum is assumed always at saturation with possibly small amounts of water.  

## References   
   
El Hefni, Baligh and Bouskela, Daniel (2019). [Modeling and Simulation of Thermal Power Plants with ThermoSysPro](https://link.springer.com/book/10.1007/978-3-030-05105-1), sect. 14.6. Springer Nature Switzerland AG.  
    ", revisions = "
Authors   

Baligh El Hefni  
Daniel Bouskela   

    "));
end StaticDrum;