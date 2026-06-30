within ThermoSysPro.Functions;

function SmoothCond "Smooth conditional function"
  input Real cond;
  input Real x1;
  input Real x2;
  input Real alpha = 100;
  output Real y;
algorithm
  y := SmoothStep(cond, alpha)*x1 + SmoothStep(-cond, alpha)*x2;
  annotation(
    smoothOrder = 2,
    Documentation(info = "
## Copyright © EDF 2002 - 2026   
## ThermoSysPro Version 4.2  
    "));
end SmoothCond;