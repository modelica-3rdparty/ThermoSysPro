within ThermoSysPro.WaterSteam.Volumes;

model VolumeB "Mixing volume with 2 inlets and 2 outlets"
  parameter Units.SI.Volume V = 1 "Volume";
  parameter Units.SI.AbsolutePressure P0 = 1e5 "Initial fluid pressure (active if dynamic_mass_balance=true and steady_state=false)";
  parameter Units.SI.SpecificEnthalpy h0 = 1e5 "Initial fluid specific enthalpy (active if steady_state=false)";
  parameter Boolean dynamic_mass_balance = false "true: dynamic mass balance equation - false: static mass balance equation";
  parameter Boolean steady_state = true "true: start from steady state - false: start from (P0, h0)";
  parameter Integer fluid = 1 "1: water/steam - 2: C3H3F5";
  parameter Units.SI.Density p_rho = 0 "If > 0, fixed fluid density";
  parameter Integer mode = 0 "IF97 region. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  Units.SI.Temperature T "Fluid temperature";
  Units.SI.AbsolutePressure P(start = 1.e5) "Fluid pressure";
  Units.SI.SpecificEnthalpy h(start = 100000) "Fluid specific enthalpy";
  Units.SI.Density rho(start = 998) "Fluid density";
  Units.SI.MassFlowRate BQ "Right hand side of the mass balance equation";
  Units.SI.Power BH "Right hand side of the energybalance equation";
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph pro "Propriétés de l'eau" annotation(
    Placement(transformation(extent = {{-100, 80}, {-80, 100}}, rotation = 0)));
  Connectors.FluidInlet Ce1 annotation(
    Placement(transformation(extent = {{-110, -10}, {-90, 10}}, rotation = 0)));
  Connectors.FluidInlet Ce2 annotation(
    Placement(transformation(extent = {{90, -10}, {110, 10}}, rotation = 0)));
  Connectors.FluidOutlet Cs1 annotation(
    Placement(transformation(extent = {{-10, 80}, {10, 100}}, rotation = 0)));
  Connectors.FluidOutlet Cs2 annotation(
    Placement(transformation(extent = {{-10, -108}, {10, -88}}, rotation = 0)));
initial equation
  if steady_state then
    if dynamic_mass_balance then
      der(P) = 0;
    end if;
    der(h) = 0;
  else
    if dynamic_mass_balance then
      P = P0;
    end if;
    h = h0;
  end if;
equation
  assert(V > 0, "Volume non-positive");
/* Unconnected connectors */
  if (cardinality(Ce1) == 0) then
    Ce1.Q = 0;
    Ce1.h = 1.e5;
    Ce1.b = true;
  end if;
  if (cardinality(Ce2) == 0) then
    Ce2.Q = 0;
    Ce2.h = 1.e5;
    Ce2.b = true;
  end if;
  if (cardinality(Cs1) == 0) then
    Cs1.Q = 0;
    Cs1.h = 1.e5;
    Cs1.a = true;
  end if;
  if (cardinality(Cs2) == 0) then
    Cs2.Q = 0;
    Cs2.h = 1.e5;
    Cs2.a = true;
  end if;
/* Mass balance equation */
  BQ = Ce1.Q + Ce2.Q - Cs1.Q - Cs2.Q;
  if dynamic_mass_balance then
    V*(pro.ddph*der(P) + pro.ddhp*der(h)) = BQ;
  else
    0 = BQ;
  end if;
  P = Ce1.P;
  P = Ce2.P;
  P = Cs1.P;
  P = Cs2.P;
/* Energy balance equation */
  BH = Ce1.Q*Ce1.h + Ce2.Q*Ce2.h - Cs1.Q*Cs1.h - Cs2.Q*Cs2.h;
  if dynamic_mass_balance then
    V*((h*pro.ddph - 1)*der(P) + (h*pro.ddhp + rho)*der(h)) = BH;
  else
    V*rho*der(h) = BH;
  end if;
  Ce1.h_vol = h;
  Ce2.h_vol = h;
  Cs1.h_vol = h;
  Cs2.h_vol = h;
/* Fluid thermodynamic properties */
  pro = ThermoSysPro.Properties.Fluid.Ph(P, h, mode, fluid);
  T = pro.T;
  if (p_rho > 0) then
    rho = p_rho;
  else
    rho = pro.d;
  end if;
  annotation(
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics = {Line(points = {{-90, 0}, {90, 0}}), Line(points = {{0, 90}, {0, -100}}), Ellipse(extent = {{-60, 60}, {60, -60}}, lineColor = {0, 0, 255}, fillColor = {85, 170, 255}, fillPattern = FillPattern.Solid)}),
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics = {Line(points = {{0, 90}, {0, -100}}), Line(points = {{-90, 0}, {90, 0}}), Ellipse(extent = {{-60, 60}, {60, -60}}, lineColor = {0, 0, 255}, fillColor = {85, 170, 255}, fillPattern = FillPattern.Solid)}),
    Window(x = 0.07, y = 0.22, width = 0.66, height = 0.69),
    Documentation(info = "
## Copyright © EDF 2002 - 2026  
## ThermoSysPro Version 4.2  
This component model is documented in Sect. 14.1 of the ThermoSysPro book.   

# Volume B  
   
This component is a volume with two inputs, two outputs.  
Nomenclature and governing equations can be found on the generic [volume](modelica://ThermoSysPro.WaterSteam.Volumes.VolumeZ) page.  

## Modelica component model  

This component has 5 connectors:  
- Ce1: fluid input,  
- Ce2: fluid input,  
- Cs1: fluid output,  
- Cs2: fluid output,  
- Cth: thermal port.   
   
![modelica://ThermoSysPro/UsersGuide/Documentation/ThermoSysPro.WaterSteam.Volumes.VolumeB.svg](modelica://ThermoSysPro/UsersGuide/Documentation/ThermoSysPro.WaterSteam.Volumes.VolumeB.svg)  

## References   
   
El Hefni, Baligh and Bouskela, Daniel (2019). [Modeling and Simulation of Thermal Power Plants with ThermoSysPro](https://link.springer.com/book/10.1007/978-3-030-05105-1), sect. 14.1. Springer Nature Switzerland AG.  
    ", revisions = "
Author  

Daniel Bouskela   

    "));
end VolumeB;