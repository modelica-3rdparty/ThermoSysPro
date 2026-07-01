within ThermoSysPro.WaterSteam.Junctions;

model Mixer3 "Mixer with three inlets"
  parameter Integer fluid = 1 "1: water/steam - 2: C3H3F5";
  parameter Integer mode = 0 "IF97 region. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  Real alpha1 "Extraction coefficient for inlet 1 (<=1)";
  Real alpha2 "Extraction coefficient for inlet 2 (<=1)";
  Units.SI.AbsolutePressure P(start = 10e5) "Fluid pressure";
  Units.SI.SpecificEnthalpy h(start = 10e5) "Fluid specific enthalpy";
  Units.SI.Temperature T "Fluid temperature";
  Connectors.FluidInlet Ce2 annotation(
    Placement(transformation(extent = {{-50, -110}, {-30, -90}}, rotation = 0)));
  Connectors.FluidOutlet Cs annotation(
    Placement(transformation(extent = {{90, -10}, {110, 10}}, rotation = 0)));
  Connectors.FluidInlet Ce1 annotation(
    Placement(transformation(extent = {{-50, 90}, {-30, 110}}, rotation = 0)));
  InstrumentationAndControl.Connectors.InputReal Ialpha1 "Extraction coefficient for inlet 1 (<=1)" annotation(
    Placement(transformation(extent = {{-80, 50}, {-60, 70}}, rotation = 0)));
  InstrumentationAndControl.Connectors.OutputReal Oalpha1 annotation(
    Placement(transformation(extent = {{-20, 50}, {0, 70}}, rotation = 0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph pro "Propriétés de l'eau" annotation(
    Placement(transformation(extent = {{-100, 80}, {-80, 100}}, rotation = 0)));
  Connectors.FluidInlet Ce3 annotation(
    Placement(transformation(extent = {{-110, -10}, {-90, 10}}, rotation = 0)));
  InstrumentationAndControl.Connectors.InputReal Ialpha2 "Extraction coefficient for inlet 2 (<=1)" annotation(
    Placement(transformation(extent = {{-80, -70}, {-60, -50}}, rotation = 0)));
  InstrumentationAndControl.Connectors.OutputReal Oalpha2 annotation(
    Placement(transformation(extent = {{-20, -70}, {0, -50}}, rotation = 0)));
equation
  if (cardinality(Ialpha1) == 0) then
    Ialpha1.signal = 0.3;
  end if;
  if (cardinality(Ialpha2) == 0) then
    Ialpha2.signal = 0.3;
  end if;
/* Fluid pressure */
  P = Ce1.P;
  P = Ce2.P;
  P = Ce3.P;
  P = Cs.P;
/* Fluid specific enthalpy (singular if all flows = 0) */
  Ce1.h_vol = h;
  Ce2.h_vol = h;
  Ce3.h_vol = h;
  Cs.h_vol = h;
/* Mass balance equation */
  0 = Ce1.Q + Ce2.Q + Ce3.Q - Cs.Q;
/* Energy balance equation */
  0 = Ce1.Q*Ce1.h + Ce2.Q*Ce2.h + Ce3.Q*Ce3.h - Cs.Q*Cs.h;
/* Mass flow at outlet 1 */
  if (cardinality(Ialpha1) <> 0) then
    Ce1.Q = Ialpha1.signal*Cs.Q;
  end if;
  if (cardinality(Ialpha2) <> 0) then
    Ce2.Q = Ialpha2.signal*Cs.Q;
  end if;
  alpha1 = Ce1.Q/Cs.Q;
  Oalpha1.signal = alpha1;
  alpha2 = Ce2.Q/Cs.Q;
  Oalpha2.signal = alpha2;
/* Fluid thermodynamic properties */
  pro = ThermoSysPro.Properties.Fluid.Ph(P, h, mode, fluid);
  T = pro.T;
  annotation(
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics = {Polygon(points = {{-60, 100}, {-20, 100}, {-20, 20}, {100, 20}, {100, -20}, {-20, -20}, {-20, -100}, {-60, -100}, {-60, -20}, {-100, -20}, {-100, 20}, {-60, 20}, {-60, 100}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid), Text(extent = {{-60, 80}, {-20, 40}}, textString = "1"), Text(extent = {{-60, -40}, {-20, -80}}, textString = "2")}),
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics = {Polygon(points = {{-60, 100}, {-20, 100}, {-20, 20}, {100, 20}, {100, -20}, {-20, -20}, {-20, -100}, {-60, -100}, {-60, -20}, {-100, -20}, {-100, 20}, {-60, 20}, {-60, 100}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid), Text(extent = {{-60, 80}, {-20, 40}}, textString = "1"), Text(extent = {{-60, -40}, {-20, -80}}, textString = "2")}),
    Window(x = 0.33, y = 0.09, width = 0.71, height = 0.88),
    Documentation(info = "
## Copyright © EDF 2002 - 2026   
## ThermoSysPro Version 4.2  
This component model is documented in Sect. 14.7 of the ThermoSysPro book.   
# Mixer3   
   
This static model describes the mixing of an adiabatic single-phase fluid or two-phase fluid with homogeneous flow in the mixer volume.  

## Modelica component model  

The equations mentioned below are implemented in the component *Mixer3*, located in the *WaterSteam.Junctions* sub-library.   
This component has 8 connectors:  
- Ce1: first fluid inlet,  
- Ce2: second fluid inlet,  
- Ce3: third fluid inlet,  
- Cs: fluid outlet,  
- Ialpha1: extraction coefficient  imposing the fraction Ce1.Q/Cs.Q,  
- Ialpha2: extraction coefficient imposing the fraction Ce2.Q/Cs.Q,  
- Oalpha1: value of Ce1.Q/Cs.Q,  
- Oalpha2: value of Ce2.Q/Cs.Q.  

If the connector Ialpha.*x* is not connected, then the fraction Ce*x*.Q/Cs.q is not imposed.  
If the connector Ialpha.*x* is connected, then Oalpha*x*=Ialpha*x*.  
   
![modelica://ThermoSysPro/UsersGuide/Documentation/ThermoSysPro.WaterSteam.Junctions.Mixer3.svg](modelica://ThermoSysPro/UsersGuide/Documentation/ThermoSysPro.WaterSteam.Junctions.Mixer3.svg)  

## Nomenclature  

|Symbol | Description | Unit | Definition | Modelica name |  
| :--------------------------------------- | :---------------------------------------------------------------------------------------- | :--------------------------- | :---------------------- | :----------- |  
|\\\\(h\\_{\\mathrm{i}\\_{1}}\\\\) | Specific enthalpy of the fluid at inlet 1 | \\\\(\\mathrm{J} / \\mathrm{kg}\\\\) || Ce1.h |  
|\\\\(h\\_{\\mathrm{i}\\_{2}}\\\\) | Specific enthalpy of the fluid at inlet 2 | \\\\(\\mathrm{J} / \\mathrm{kg}\\\\) || Ce2.h |  
|\\\\(h\\_{\\mathrm{i}\\_{3}}\\\\) | Specific enthalpy of the fluid at inlet 3 | \\\\(\\mathrm{J} / \\mathrm{kg}\\\\) || Ce3.h |  
|\\\\(h\\_{\\mathrm{o}}\\\\) | Specific enthalpy of the fluid at the outlet of the mixer | \\\\(\\mathrm{J} / \\mathrm{kg}\\\\) || Cs.h |  
|\\\\(m\\_{\\mathrm{i}\\_{1}}\\\\) | Mass flow rate of the fluid at inlet 1 | \\\\(\\mathrm{kg} / \\mathrm{s}\\\\) || Ce1.Q |  
|\\\\(\\dot{m}\\_{\\mathrm{i}\\_{2}}\\\\) | Mass flow rate of the fluid at inlet 2 | \\\\(\\mathrm{kg} / \\mathrm{s}\\\\) || Ce2.Q |  
|\\\\(\\dot{m}\\_{\\mathrm{i}\\_{3}}\\\\) | Mass flow rate of the fluid at inlet 3 | \\\\(\\mathrm{kg} / \\mathrm{s}\\\\) || Ce3.Q |  
|\\\\(\\dot{m}\\_{\\mathrm{o}}\\\\) | Mass flow rate of the fluid at the outlet | \\\\(\\mathrm{kg} / \\mathrm{s}\\\\) || Cs.Q |  
| \\\\(\\alpha\\_{1}\\\\) | Extraction coefficient for inlet 1 \\(output of the model\\) | \\\\(-\\\\) |\\\\(\\frac{\\dot{m}\\_{\\mathrm{i}\\_{l}}}{\\dot{m}\\_{\\mathrm{o}}}\\\\) || alpha1 |  
|\\\\(\\alpha\\_{2}\\\\) | Extraction coefficient for inlet 2 \\(output of the model\\) | \\\\(-\\\\) | \\\\(\\frac{\\dot{m}\\_{\\mathrm{i}\\_{2}}}{\\dot{m}\\_{\\mathrm{o}}}\\\\)|| alpha2 |  
|\\\\(\\alpha\\_{\\mathrm{i}\\_{1}}\\\\) | Mass fraction coefficient for inlet 1 | \\\\(-\\\\) || Ialpha1.signal |  
|\\\\(\\alpha\\_{\\mathrm{i}\\_{2}}\\\\) | Mass fraction coefficient for inlet 2 | \\\\(-\\\\) || Ialpha2.signal |  


## Governing equations  

### Static mass balance equation  


    
    

- Validity domain:   
   
 \\\\(\\forall \\dot{m}\\\\)  

- Mathematical formulation:   
   
 $$0=\\dot{m}\\_{\\mathrm{i}\\_{l}}+\\dot{m}\\_{\\mathrm{i}\\_{2}}+\\dot{m}\\_{\\mathrm{i}\\_{3}}-\\dot{m}\\_{\\mathrm{o}}$$  

- Comments:   
   
\\\\(\\dot{m}\\_{\\mathrm{i}\\_{l}}\\\\) and \\\\(\\dot{m}\\_{\\mathrm{i} 2}\\\\) can be defined as a fraction of the output mass flow rate:  
$$\\dot{m}\\_{\\mathrm{i}\\_{l}}=\\alpha\\_{\\mathrm{i}\\_{l}} \\cdot \\dot{m}\\_{\\mathrm{o}} \\quad \\text{and} \\quad \\dot{m}\\_{\\mathrm{i}\\_{2}}=\\alpha\\_{\\mathrm{i}\\_{2}} \\cdot \\dot{m}\\_{\\mathrm{o}}$$  
This enables the computation of the mass flow rates at the inlets from the outlet mass flow rate.   


### Static energy balance equation  


    
    

- Validity domain:   
   
 \\\\(\\exists \\dot{m}\\\\) such that \\\\(\\dot{m} \\neq 0\\\\)  

- Mathematical formulation:   
   
 $$0=\\dot{m}\\_{\\mathrm{i}\\_{l}} \\cdot h\\_{\\mathrm{i}\\_{l}}+\\dot{m}\\_{\\mathrm{i}\\_{2}} \\cdot h\\_{\\mathrm{i}\\_{2}}+\\dot{m}\\_{\\mathrm{i}\\_{3}} \\cdot h\\_{\\mathrm{i}\\_{3}}-\\dot{m}\\_{\\mathrm{o}} \\cdot h\\_{\\mathrm{o}}$$  

- Comments:   
   
 This equation is valid if some mass flow rates are non-zero. Otherwise, the mixing specific enthalpy is undefined.  

## References   
   
El Hefni, Baligh and Bouskela, Daniel (2019). [Modeling and Simulation of Thermal Power Plants with ThermoSysPro](https://link.springer.com/book/10.1007/978-3-030-05105-1), sect. 14.7. Springer Nature Switzerland AG.  
    ", revisions = "
Authors  

Baligh El Hefni  
Daniel Bouskela   

    "));
end Mixer3;