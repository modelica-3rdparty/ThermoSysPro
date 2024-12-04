within ThermoSysPro.Functions;
function SmoothAbs "Smooth abs function"
  input Real x;
  input Real alpha=100;

  output Real y;

algorithm
  y := SmoothSign(x, alpha)*x;

  annotation (smoothOrder=2, Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2024</b> </p>
<p><b>ThermoSysPro Version 4.1</h4>
</html>"));
end SmoothAbs;
