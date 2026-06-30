within ThermoSysPro.WaterSteam.BoundaryConditions;

model Source "Water/steam source"
  parameter Units.SI.SpecificEnthalpy h0 = 100000 "Fluid specific enthalpy (active if IEnthalpy connector is not connected)";
  Units.SI.AbsolutePressure P "Fluid pressure";
  Units.SI.MassFlowRate Q "Mass flow rate";
  Units.SI.SpecificEnthalpy h "Fluid specific enthalpy";
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal ISpecificEnthalpy annotation(
    Placement(transformation(origin = {0, -50}, extent = {{10, -10}, {-10, 10}}, rotation = 270)));
  Connectors.FluidOutlet C annotation(
    Placement(transformation(extent = {{90, -10}, {110, 10}}, rotation = 0)));
equation
  C.P = P;
  C.Q = Q;
  C.h_vol = h;
/* Specific enthalpy */
  if (cardinality(ISpecificEnthalpy) == 0) then
    ISpecificEnthalpy.signal = h0;
  end if;
  h = ISpecificEnthalpy.signal;
  annotation(
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics = {Line(points = {{40, 0}, {90, 0}, {72, 10}}), Line(points = {{90, 0}, {72, -10}}), Text(extent = {{-30, -40}, {-12, -60}}, textString = "h"), Rectangle(extent = {{-40, 40}, {40, -40}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid)}),
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics = {Line(points = {{40, 0}, {90, 0}, {72, 10}}), Rectangle(extent = {{-40, 40}, {40, -40}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid), Line(points = {{90, 0}, {72, -10}}), Text(extent = {{-32, -40}, {-12, -60}}, textString = "h")}),
    Window(x = 0.23, y = 0.15, width = 0.81, height = 0.71),
    Documentation(info = "
## Copyright © EDF 2002 - 2026  


## ThermoSysPro Version 4.2  

    ", revisions = "
Authors  

Baligh El Hefni  
Daniel Bouskela   

    "));
end Source;