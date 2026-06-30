within ThermoSysPro.Functions;

function ThermoSquare "Thermodynamic square"
  input Real x;
  input Real dx;
  output Real y;
algorithm
  y := if (abs(x) > dx) then x*abs(x) else x*dx;
  annotation(
    smoothOrder = 1,
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics),
    Window(x = 0.11, y = 0.2, width = 0.6, height = 0.6),
    Documentation(info = "
## Copyright © EDF 2002 - 2026  


## ThermoSysPro Version 4.2  

    "));
end ThermoSquare;