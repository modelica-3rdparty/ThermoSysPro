within ThermoSysPro.WaterSteam.Junctions;

model Splitter3 "Splitter with three outlets"
  parameter Integer fluid = 1 "1: water/steam - 2: C3H3F5";
  parameter Integer mode = 0 "IF97 region. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  Real alpha1 "Extraction coefficient for outlet 1 (<=1)";
  Real alpha2 "Extraction coefficient for outlet 2 (<=1)";
  Units.SI.AbsolutePressure P(start = 10e5) "Fluid pressure";
  Units.SI.SpecificEnthalpy h(start = 10e5) "Fluid specific enthalpy";
  Units.SI.Temperature T "Fluid temperature";
  Connectors.FluidInlet Ce annotation(
    Placement(transformation(extent = {{-108, -10}, {-88, 10}}, rotation = 0)));
  Connectors.FluidOutlet Cs3 annotation(
    Placement(transformation(extent = {{90, -10}, {110, 10}}, rotation = 0)));
  Connectors.FluidOutlet Cs1 annotation(
    Placement(transformation(extent = {{30, 90}, {50, 110}}, rotation = 0)));
  Connectors.FluidOutlet Cs2 annotation(
    Placement(transformation(extent = {{30, -110}, {50, -90}}, rotation = 0)));
  InstrumentationAndControl.Connectors.InputReal Ialpha1 "Extraction coefficient for outlet 1 (<=1)" annotation(
    Placement(transformation(extent = {{0, 50}, {20, 70}}, rotation = 0)));
  InstrumentationAndControl.Connectors.InputReal Ialpha2 "Extraction coefficient for outlet 2 (<=1)" annotation(
    Placement(transformation(extent = {{0, -70}, {20, -50}}, rotation = 0)));
  InstrumentationAndControl.Connectors.OutputReal Oalpha1 annotation(
    Placement(transformation(extent = {{60, 50}, {80, 70}}, rotation = 0)));
  InstrumentationAndControl.Connectors.OutputReal Oalpha2 annotation(
    Placement(transformation(extent = {{60, -70}, {80, -50}}, rotation = 0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph pro "Propriétés de l'eau" annotation(
    Placement(transformation(extent = {{-100, 80}, {-80, 100}}, rotation = 0)));
equation
  if (cardinality(Ialpha1) == 0) then
    Ialpha1.signal = 0.3;
  end if;
  if (cardinality(Ialpha2) == 0) then
    Ialpha2.signal = 0.3;
  end if;
/* Fluid pressure */
  P = Ce.P;
  P = Cs1.P;
  P = Cs2.P;
  P = Cs3.P;
/* Fluid specific enthalpy (singular if all flows = 0) */
  Ce.h_vol = h;
  Cs1.h_vol = h;
  Cs2.h_vol = h;
  Cs3.h_vol = h;
/* Mass balance equation */
  0 = Ce.Q - Cs1.Q - Cs2.Q - Cs3.Q;
/* Energy balance equation */
  0 = Ce.Q*Ce.h - Cs1.Q*Cs1.h - Cs2.Q*Cs2.h - Cs3.Q*Cs3.h;
/* Mass flows at outlets 1 and 2 */
  if (cardinality(Ialpha1) <> 0) then
    Cs1.Q = Ialpha1.signal*Ce.Q;
  end if;
  if (cardinality(Ialpha2) <> 0) then
    Cs2.Q = Ialpha2.signal*Ce.Q;
  end if;
  alpha1 = Cs1.Q/Ce.Q;
  Oalpha1.signal = alpha1;
  alpha2 = Cs2.Q/Ce.Q;
  Oalpha2.signal = alpha2;
/* Fluid thermodynamic properties */
  pro = ThermoSysPro.Properties.Fluid.Ph(P, h, mode, fluid);
  T = pro.T;
  annotation(
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Text(extent = {{10, -60}, {48, -90}}, textString = "3"), Rectangle(extent = {{44, -27}, {50, -65}}, lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid), Polygon(points = {{-100, -20}, {-100, 20}, {20, 20}, {20, 100}, {60, 100}, {60, 20}, {100, 20}, {100, -20}, {60, -20}, {60, -100}, {20, -100}, {20, -20}, {-100, -20}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid), Text(extent = {{20, 80}, {60, 40}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid, textString = "1"), Text(extent = {{20, -40}, {60, -80}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid, textString = "2"), Text(extent = {{60, 20}, {100, -20}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid, textString = "3")}),
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Text(extent = {{10, -60}, {48, -90}}, textString = "3"), Rectangle(extent = {{44, -27}, {50, -65}}, lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid), Polygon(points = {{-100, -20}, {-100, 20}, {20, 20}, {20, 100}, {60, 100}, {60, 20}, {100, 20}, {100, -20}, {60, -20}, {60, -100}, {20, -100}, {20, -20}, {-100, -20}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid), Text(extent = {{20, 80}, {60, 40}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid, textString = "1"), Text(extent = {{20, -40}, {60, -80}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid, textString = "2"), Text(extent = {{60, 20}, {100, -20}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid, textString = "3")}),
    Documentation(info = "
## Copyright © EDF 2002 - 2026   
## ThermoSysPro Version 4.2  
This component model is documented in Sect. 14.8 of the ThermoSysPro book.   
# Splitter3   
   
The static splitter is a cavity splitting an incoming flow into two or more exiting flows of adiabatic single-phase or homogeneous two-phase fluid.  


## Modelica component model  

The equations mentioned below are implemented in the component *Splitter3*, located in the *WaterSteam.Junctions* sub-library.   
This component has 8 connectors:  
- Ce: fluid inlet,  
- Cs1: first fluid outlet,  
- Cs2: second fluid outlet,  
- Cs3: third fluid outlet,  
- Ialpha1: extraction coefficient  imposing the fraction Ce1.Q/Cs.Q,  
- Ialpha2: extraction coefficient imposing the fraction Ce2.Q/Cs.Q,  
- Oalpha1: value of Ce1.Q/Cs.Q,  
- Oalpha2: value of Ce2.Q/Cs.Q.  

If the connector Ialpha.*x* is not connected, then the fraction Ce*x*.Q/Cs.q is not imposed.  
If the connector Ialpha.*x* is connected, then Oalpha*x*=Ialpha*x*.  
   
![modelica://ThermoSysPro/UsersGuide/Documentation/ThermoSysPro.WaterSteam.Junctions.Splitter3.svg](modelica://ThermoSysPro/UsersGuide/Documentation/ThermoSysPro.WaterSteam.Junctions.Splitter3.svg)  

## Nomenclature  

| Symbol| Description| Unit| Definition| Modelica name |  
| :--------------------------- | :---------------------------------------------------------- | :--------------------------- | :-------------------------------------------------------- | :----------- |  
| \\\\(h\\_{\\mathrm{i}}\\\\)| Specific enthalpy of the fluid at the inlet of the splitter | \\\\(\\mathrm{J} / \\mathrm{kg}\\\\) || Ce.h |  
| \\\\(h\\_{\\mathrm{o}\\_{1}}\\\\)| Specific enthalpy of the fluid at outlet 1| \\\\(\\mathrm{J} / \\mathrm{kg}\\\\) || Cs1.h |  
| \\\\(h\\_{\\mathrm{o}\\_{2}}\\\\)| Specific enthalpy of the fluid at outlet 2| \\\\(\\mathrm{J} / \\mathrm{kg}\\\\) || Cs2.h |  
| \\\\(h\\_{\\mathrm{o} 3}\\\\)| Specific enthalpy of the fluid at outlet 3| \\\\(\\mathrm{J} / \\mathrm{kg}\\\\) || Cs3.h |  
| \\\\(\\dot{m}\\_{\\mathrm{i}}\\\\)| Fluid mass flow rate at the inlet| \\\\(\\mathrm{kg} / \\mathrm{s}\\\\) || Ce.Q |  
| \\\\(\\dot{m}\\_{\\mathrm{o}\\_{1}}\\\\) | Fluid mass flow rate at outlet 1| \\\\(\\mathrm{kg} / \\mathrm{s}\\\\) || Cs1.Q |  
| \\\\(\\dot{m}\\_{\\mathrm{o}\\_2}\\\\)| Fluid mass flow rate at outlet 2| \\\\(\\mathrm{kg} / \\mathrm{s}\\\\) || Cs2.Q |  
| \\\\(\\dot{m}\\_{\\mathrm{o}\\_{3}}\\\\) | Fluid mass flow rate at outlet 3| \\\\(\\mathrm{kg} / \\mathrm{s}\\\\) || Cs3.Q |  
| \\\\(\\alpha\\_{1}\\\\)| Extraction coefficient for outlet 1 \\(output of the model\\)| \\\\(-\\\\)| \\\\(\\frac{\\dot{m}\\_{\\mathrm{o}\\_{1}}}{\\dot{m}\\_{\\mathrm{i}}}\\\\) | alpha1 |  
| \\\\(\\alpha\\_{2}\\\\)| Extraction coefficient for outlet 2 \\(output of the model\\)| \\\\(-\\\\)| \\\\(\\frac{\\dot{m}\\_{\\mathrm{o}\\_{2}}}{\\dot{m}\\_{\\mathrm{i}}}\\\\) | alpha2 |  
| \\\\(\\alpha\\_{\\mathrm{o}\\_{1}}\\\\)| Mass fraction coefficient for outlet 1||| Ialpha1.signal |  
| \\\\(\\alpha\\_{\\mathrm{o}\\_{2}}\\\\)| Mass fraction coefficient for outlet 2| \\\\(-\\\\)|| Ialpha2.signal |  


## Governing equations  

### Static mass balance equation  


    
    

- Validity domain:   
   
 \\\\(\\forall \\dot{m}\\\\)  

- Mathematical formulation:   
   
 $$0=\\dot{m}\\_{\\mathrm{i}}-\\dot{m}\\_{\\mathrm{o}\\_{1}}-\\dot{m}\\_{\\mathrm{o}\\_{2}}-\\dot{m}\\_{\\mathrm{o} 3}$$  

- Comments:   
   
 The value of \\\\(\\dot{m}\\_{\\mathrm{o}\\_{1}}\\\\) and \\\\(\\dot{m}\\_{\\mathrm{o}\\_{2}}\\\\) can be defined as a fraction of the input mass flow rate:  
$$   \\dot{m}_{\\mathrm{o}_{1}}  =\\alpha_{\\mathrm{o}_{1}} \\cdot \\dot{m}_{\\mathrm{i}} \\\\   \\dot{m}_{\\mathrm{o}\\_{2}}  =\\alpha_{\\mathrm{o}_{2}} \\cdot \\dot{m}_{\\mathrm{i}}$$  

This option enables to compute the mass flow rates at the outlets knowing the mass flow rate at the inlet.  


### Static energy balance equation  


    
    

- Validity domain:   
   
 \\\\(\\exists \\dot{m}\\\\) such that \\\\(\\dot{m} \\neq 0\\\\)  

- Mathematical formulation:   
   
 $$0=\\dot{m}\\_{\\mathrm{i}} \\cdot h\\_{\\mathrm{i}}-\\dot{m}\\_{\\mathrm{o}\\_{1}} \\cdot h\\_{\\mathrm{o}\\_{1}}-\\dot{m}\\_{\\mathrm{o}\\_{2}} \\cdot h\\_{\\mathrm{o}\\_{2}}-\\dot{m}\\_{\\mathrm{o}\\_{3}} \\cdot h\\_{\\mathrm{o}\\_{3}}$$  

- Comments:   
   
 This equation is valid if at least one mass flow rate is nonzero. Otherwise, the mixing specific enthalpy inside the splitter is undefined.  

## References   
   
El Hefni, Baligh and Bouskela, Daniel (2019). [Modeling and Simulation of Thermal Power Plants with ThermoSysPro](https://link.springer.com/book/10.1007/978-3-030-05105-1), sect. 14.8. Springer Nature Switzerland AG.  
    ", revisions = "
Authors   

Baligh El Hefni  
Daniel Bouskela   

    "));
end Splitter3;