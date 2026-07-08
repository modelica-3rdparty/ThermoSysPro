within ThermoSysPro.WaterSteam.PressureLosses;

model ThreeWayValve "Three way valve"
  parameter ThermoSysPro.Units.xSI.Cv Cvmax1 = 8005.42 "Valve 1 max CV [USG/min]";
  parameter ThermoSysPro.Units.xSI.Cv Cvmax2 = 8005.42 "Valve 2 max CV [USG/min]";
  parameter Real caract1[:, 2] = [0, 0; 1, Cvmax1] "Valve 1 - Position vs. Cv [USG/min] characteristics (active if mode_caract1=true)";
  parameter Real caract2[:, 2] = [0, 0; 1, Cvmax2] "Valve 2 - Position vs. Cv [USG/min] characteristics (active if mode_caract2=true)";
  parameter Integer mode_caract1 = 0 "Valve 1 - 0:linear characteristics - 1:characteristics is given by caract1[]";
  parameter Integer mode_caract2 = 0 "Valve 2 - 0:linear characteristics - 1:characteristics is given by caract2[]";
  parameter Units.SI.Volume V = 1 "Three way valve volume";
  parameter Boolean continuous_flow_reversal = false "true: continuous flow reversal - false: discontinuous flow reversal";
  parameter Integer fluid = 1 "1: water/steam - 2: C3H3F5";
  parameter Units.SI.Density p_rho = 0 "If > 0, fixed fluid density";
  parameter Integer mode = 0 "IF97 region. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal Ouv annotation(
    Placement(transformation(origin = {0, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  Connectors.FluidInletI C1 annotation(
    layer = "icon",
    Placement(transformation(extent = {{-110, -50}, {-90, -30}}, rotation = 0)));
  Connectors.FluidOutletI C2 annotation(
    layer = "icon",
    Placement(transformation(extent = {{90, -50}, {110, -30}}, rotation = 0)));
  ThermoSysPro.WaterSteam.PressureLosses.ControlValve Valve1(Cvmax = Cvmax1, caract = caract1, mode_caract = mode_caract1, p_rho = p_rho, mode = mode, continuous_flow_reversal = continuous_flow_reversal, fluid = fluid) annotation(
    Placement(transformation(origin = {6, -40}, extent = {{10, 10}, {-10, -10}}, rotation = 90)));
  Connectors.FluidOutletI C3 annotation(
    Placement(transformation(extent = {{-10, -110}, {10, -90}}, rotation = 0)));
  ThermoSysPro.WaterSteam.PressureLosses.ControlValve Valve2(Cvmax = Cvmax2, caract = caract2, mode_caract = mode_caract2, p_rho = p_rho, mode = mode, continuous_flow_reversal = continuous_flow_reversal, fluid = fluid) annotation(
    Placement(transformation(extent = {{40, -4}, {60, 16}}, rotation = 0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante Constante1 annotation(
    Placement(transformation(extent = {{-80, 60}, {-60, 80}}, rotation = 0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Math.Add Add1(k2 = -1) annotation(
    Placement(transformation(extent = {{-40, 40}, {-20, 60}}, rotation = 0)));
  ThermoSysPro.WaterSteam.Volumes.VolumeA VolumeA1(V = V, p_rho = p_rho, mode = mode) annotation(
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoSysPro.WaterSteam.PressureLosses.PipePressureLoss PerteDP1(K = 0, continuous_flow_reversal = continuous_flow_reversal, fluid = fluid) annotation(
    Placement(transformation(extent = {{-60, -10}, {-40, 10}}, rotation = 0)));
equation
  connect(Ouv, Valve2.Ouv) annotation(
    Line(points = {{0, 110}, {0, 60}, {50, 60}, {50, 17}}));
  connect(Constante1.y, Add1.u1) annotation(
    Line(points = {{-59, 70}, {-50, 70}, {-50, 56}, {-41, 56}}, color = {0, 0, 255}));
  connect(Ouv, Add1.u2) annotation(
    Line(points = {{0, 110}, {0, 90}, {-90, 90}, {-90, 44}, {-41, 44}}));
  connect(Add1.y, Valve1.Ouv) annotation(
    Line(points = {{-19, 50}, {20, 50}, {20, -40}, {17, -40}}, color = {0, 0, 255}));
  connect(VolumeA1.Cs1, Valve2.C1) annotation(
    Line(points = {{10, 0}, {40, 0}}, color = {0, 0, 255}));
  connect(VolumeA1.Cs2, Valve1.C1) annotation(
    Line(points = {{0, -10}, {0, -30}, {0, -30}}, color = {0, 0, 255}));
  connect(Valve1.C2, C3) annotation(
    Line(points = {{0, -50}, {0, -78}, {0, -78}, {0, -100}}, color = {0, 0, 255}));
  connect(PerteDP1.C2, VolumeA1.Ce1) annotation(
    Line(points = {{-40, 0}, {-10, 0}}, color = {0, 0, 255}));
  connect(Valve2.C2, C2) annotation(
    Line(points = {{60, 0}, {80, 0}, {80, -40}, {100, -40}}, color = {0, 0, 255}));
  connect(PerteDP1.C1, C1) annotation(
    Line(points = {{-60, 0}, {-80, 0}, {-80, -40}, {-100, -40}}, color = {0, 0, 255}));
  annotation(
    structurallyIncomplete,
    Documentation(info = "
## Copyright © EDF 2002 - 2026  
## ThermoSysPro Version 4.2  
This component model is documented in Sect. 13.9 of the ThermoSysPro book.   

# Three way valve   
   
The three-way valve splits the fluid in two directions. When the valve is fully open, the fluid moves in one direction, and when it is fully closed, it moves in the other direction. When it is partially open, a fraction of the fluid moves in one direction and the rest in the other. For water/steam, the flow regime is single-phase or homogeneous two-phase flow.  


## Modelica component model  

The equations mentioned below are implemented in the component *ThreeWayValve*, located in the *WaterSteam.PressureLosses* sub-library.  

The *ThreeWayValve* is composed of two [control valves](modelica://ThermoSysPro.WaterSteam.PressureLosses.ControlValve), a [pipe pressure loss](modelica://ThermoSysPro.WaterSteam.PressureLosses.PipePressureLoss), a VolumeA, a Constant and an Add block. <!-- TODO -->  
This component has 4 connectors:  
- C1: fluid inlet,  
- C2: fluid outlet,  
- C3: fluid outlet,  
- Ouv: valve opening.  
   
![modelica://ThermoSysPro/UsersGuide/Documentation/ThermoSysPro.WaterSteam.PressureLosses.ThreeWayValve.svg](modelica://ThermoSysPro/UsersGuide/Documentation/ThermoSysPro.WaterSteam.PressureLosses.ThreeWayValve.svg)  

## Nomenclature  

See [control valve](modelica://ThermoSysPro.WaterSteam.PressureLosses.ControlValve) and [pipe pressure loss](modelica://ThermoSysPro.WaterSteam.PressureLosses.PipePressureLoss).  

## Governing equations  

See [control valve](modelica://ThermoSysPro.WaterSteam.PressureLosses.ControlValve) and [pipe pressure loss](modelica://ThermoSysPro.WaterSteam.PressureLosses.PipePressureLoss).  

## References   
   
El Hefni, Baligh and Bouskela, Daniel (2019). [Modeling and Simulation of Thermal Power Plants with ThermoSysPro](https://link.springer.com/book/10.1007/978-3-030-05105-1), sect. 13.9. Springer Nature Switzerland AG.  
    ", revisions = "
Author  

Daniel Bouskela   

    "),
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics = {Text(extent = {{-46, -30}, {-12, -52}}, textString = "Valve 1"), Text(extent = {{36, -6}, {70, -28}}, textString = "Valve 2")}),
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics = {Polygon(points = {{-100, 0}, {-100, -80}, {100, 0}, {100, -80}, {-100, 0}}, lineColor = {0, 0, 255}, fillColor = {127, 255, 0}, fillPattern = FillPattern.Solid), Polygon(points = {{-20, -100}, {0, -40}, {20, -100}, {-20, -100}}, lineColor = {0, 0, 255}, fillColor = {127, 255, 0}, fillPattern = FillPattern.Solid), Polygon(points = {{40, 40}, {-40, 40}, {-40, 56}, {-38, 74}, {-32, 84}, {-20, 94}, {0, 100}, {20, 94}, {32, 84}, {38, 72}, {40, 54}, {40, 40}}, lineColor = {0, 0, 255}, fillColor = {127, 255, 0}, fillPattern = FillPattern.Solid), Polygon(points = {{0, -40}, {40, 40}, {-40, 40}, {0, -40}}, lineColor = {0, 0, 255}, fillColor = {127, 255, 0}, fillPattern = FillPattern.Solid)}),
    Window(x = 0.09, y = 0.11, width = 0.7, height = 0.66));
end ThreeWayValve;
