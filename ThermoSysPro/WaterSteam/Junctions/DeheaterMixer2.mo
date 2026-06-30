within ThermoSysPro.WaterSteam.Junctions;

model DeheaterMixer2
  parameter Units.SI.Temperature Tmax = 700 "Maximum fluid temperature";
  parameter Integer mode = 0 "IF97 region. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  Units.SI.AbsolutePressure P(start = 50e5) "Fluid pressure";
  Units.SI.SpecificEnthalpy h(start = 10e5) "Fluid specific enthalpy";
  Units.SI.Temperature T(start = 600) "Fluid temperature";
  Units.SI.SpecificEnthalpy hmax(start = 10e5) "Maximum fluid specific enthalpy";
  Connectors.FluidInlet Ce_mix annotation(
    Placement(transformation(extent = {{-9, -110}, {11, -90}}, rotation = 0)));
  Connectors.FluidOutlet Cs annotation(
    Placement(transformation(extent = {{90, 50}, {110, 70}}, rotation = 0)));
  Connectors.FluidInlet Ce annotation(
    Placement(transformation(extent = {{-110, 50}, {-90, 70}}, rotation = 0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph pro annotation(
    Placement(transformation(extent = {{-100, 82}, {-80, 102}}, rotation = 0)));
equation
/* Fluid pressure */
  P = Ce.P;
  P = Ce_mix.P;
  P = Cs.P;
/* Fluid specific enthalpy (singular if all flows = 0) */
  Ce.h_vol = h;
  Cs.h_vol = h;
  Ce_mix.h_vol = h;
/* Mass balance equation */
  0 = Ce.Q + Ce_mix.Q - Cs.Q;
/* Energy balance equation */
  0 = Ce.Q*Ce.h + Ce_mix.Q*Ce_mix.h - Cs.Q*Cs.h;
/* The flow at the mixing inlet is such as to ensure T <= Tmax */
  if T <= Tmax then
    Ce_mix.Q = 0;
  else
    h = hmax;
  end if;
/* Fluid thermodynamic properties */
  pro = ThermoSysPro.Properties.Fluid.Ph(P, h, mode, 1);
  T = pro.T;
  hmax = ThermoSysPro.Properties.WaterSteam.IF97.SpecificEnthalpy_PT(P, Tmax, mode);
  annotation(
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics = {Polygon(points = {{-100, 80}, {-100, 40}, {-20, 40}, {-20, -100}, {20, -100}, {20, 40}, {100, 40}, {100, 80}, {-100, 80}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid), Text(extent = {{-16, 72}, {24, 32}}, lineColor = {0, 0, 255}, textString = "D")}),
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics = {Polygon(points = {{-100, 80}, {-100, 40}, {-20, 40}, {-20, -100}, {20, -100}, {20, 40}, {100, 40}, {100, 80}, {-100, 80}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid), Text(extent = {{-16, 72}, {24, 32}}, lineColor = {0, 0, 255}, textString = "D")}),
    Window(x = 0.33, y = 0.09, width = 0.71, height = 0.88),
    Documentation(info = "
## Copyright © EDF 2002 - 2026  


## ThermoSysPro Version 4.2  

    ", revisions = "
Authors  

Baligh El Hefni  
Daniel Bouskela   

    "));
end DeheaterMixer2;