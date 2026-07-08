within ThermoSysPro.FlueGases.BoundaryConditions;

model Sink "Flue gas sink"
  Units.SI.AbsolutePressure P "Fluid pressure";
  Units.SI.MassFlowRate Q "Mass flow";
  Units.SI.Temperature T "Fluid temperature";
  Real Xco2 "CO2 mass fraction";
  Real Xh2o "H2O mass fraction";
  Real Xo2 "O2 mass fraction";
  Real Xso2 "SO2 mass fraction";
  Real Xn2 "N2 mass fraction";
  ThermoSysPro.FlueGases.Connectors.FlueGasesInlet C annotation(
    Placement(transformation(extent = {{-108, -10}, {-88, 10}}, rotation = 0)));
equation
  C.P = P;
  C.Q = Q;
  C.T = T;
/* Flue gas composition */
  C.Xco2 = Xco2;
  C.Xh2o = Xh2o;
  C.Xo2 = Xo2;
  C.Xso2 = Xso2;
  Xn2 = 1 - Xco2 - Xh2o - Xo2 - Xso2;
  annotation(
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics = {Rectangle(extent = {{-40, 40}, {40, -40}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Backward), Line(points = {{-90, 0}, {-40, 0}, {-58, 10}}), Line(points = {{-40, 0}, {-58, -10}})}),
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics = {Rectangle(extent = {{-40, 40}, {40, -40}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Backward), Line(points = {{-90, 0}, {-40, 0}, {-58, 10}}), Line(points = {{-40, 0}, {-58, -10}})}),
    Window(x = 0.09, y = 0.2, width = 0.66, height = 0.69),
    Documentation(info = "
## Copyright © EDF 2002 - 2026  


## ThermoSysPro Version 4.2  

    ", revisions = "
Author  

Baligh El Hefni   

    "));
end Sink;