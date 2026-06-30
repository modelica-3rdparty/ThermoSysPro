within ThermoSysPro.WaterSteam.BoundaryConditions;

model PlugB "Plug"
  Units.SI.AbsolutePressure P "Fluid pressure";
  Units.SI.MassFlowRate Q "Mass flow rate";
  Units.SI.SpecificEnthalpy h "Fluid specific enthalpy";
  Connectors.FluidInlet C annotation(
    Placement(transformation(extent = {{-110, -10}, {-90, 10}}, rotation = 0)));
equation
  C.P = P;
  C.Q = Q;
  C.h_vol = h;
  annotation(
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics = {Line(points = {{-90, 0}, {-40, 0}, {-54, 10}}), Line(points = {{-54, -10}, {-40, 0}}), Ellipse(extent = {{-40, 40}, {40, -40}}, lineColor = {0, 0, 255}, fillColor = {128, 255, 0}, fillPattern = FillPattern.Solid)}),
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics = {Line(points = {{-92, 0}, {-40, 0}, {-54, 10}}), Line(points = {{-54, -10}, {-40, 0}}), Ellipse(extent = {{-40, 40}, {40, -40}}, lineColor = {0, 0, 255}, fillColor = {128, 255, 0}, fillPattern = FillPattern.Solid)}),
    Window(x = 0.23, y = 0.15, width = 0.81, height = 0.71),
    Documentation(info = "
## Copyright © EDF 2002 - 2026  


## ThermoSysPro Version 4.2  

    ", revisions = "
Authors  

Baligh El Hefni  
Daniel Bouskela   

    "));
end PlugB;