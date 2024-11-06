within ThermoSysPro.Functions;
function SmoothStep "Smooth step function"
  input Real x;
  input Real alpha=100;

  output Real y;

algorithm
  y := 1/(1 + exp(-alpha*x/2));

  annotation (smoothOrder=2,
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2024</b> </p>
<p><b>ThermoSysPro Version 4.1</h4>
</html>"));
end SmoothStep;
