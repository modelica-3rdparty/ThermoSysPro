within ThermoSysPro.Functions;
function LinearInterpolation "Linear interpolation"
  input Real TabX[:] "References table";
  input Real TabY[:] "Results table";
  input Real X "Reference value";

  output Real Y "Interpolated result";

protected
  Real deltaYX "Step in Y w.r.t. X";

algorithm
  (Y,deltaYX) := ThermoSysPro.Functions.Utilities.LinearInterpolation_i(
    TabX,
    TabY,
    X);

  annotation (
    smoothOrder=1,
     Icon(graphics),       Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2024</b> </p>
<p><b>ThermoSysPro Version 4.1</h4></p>
</html><html>
</html>", revisions="<html>
</html>"));
end LinearInterpolation;
