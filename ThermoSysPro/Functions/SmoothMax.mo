within ThermoSysPro.Functions;

function SmoothMax "Smooth max function"
  input Real x1;
  input Real x2;
  input Real alpha = 100;
  output Real y;
algorithm
  y := SmoothStep(x1 - x2, alpha)*x1 + SmoothStep(x2 - x1, alpha)*x2;
  annotation(
    smoothOrder = 2,
    Documentation(info = "
## Copyright © EDF 2002 - 2026  
## ThermoSysPro Version 4.2  
    "));
end SmoothMax;