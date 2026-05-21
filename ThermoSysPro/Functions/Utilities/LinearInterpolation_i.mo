within ThermoSysPro.Functions.Utilities;
function LinearInterpolation_i "Linear interpolation (internal function)"
  input Real TabX[:] "References table";
  input Real TabY[:] "Results table";
  input Real X "Reference value";

  output Real Y "Interpolated result";
  output Real DeltaYX "Y step wrt. X";

protected 
  Integer dimX=size(TabX, 1) "TabX dimension";
  Integer dimY=size(TabY, 1) "TabY dimension";
  Integer IndX=0 "Reference index";
  Boolean IndXcal "Computed index";

algorithm 
  if (dimX <> dimY) then
    assert(false, "LinearInterpolation: the dimensions of the tables are different");
  end if;

  IndXcal := false;

  for i in 2:dimX - 1 loop
     if ((X <= TabX[i]) and (not IndXcal)) then
      IndX := i;
      IndXcal := true;
    end if;
  end for;

  if (not IndXcal) then
    IndX := dimX;
  end if;

  DeltaYX := (TabY[IndX] - TabY[IndX - 1])/(TabX[IndX] - TabX[IndX - 1]);

  Y := (TabY[IndX] - TabY[IndX - 1])/(TabX[IndX] - TabX[IndX - 1])*(X - TabX[IndX - 1]) + TabY[IndX - 1];

  annotation (
    smoothOrder=1,
     Icon(graphics),       Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2024</b> </p>
<p><b>ThermoSysPro Version 4.1</b> </p>
</html>" "<html>
</html>", revisions="<html>
</html>"));
end LinearInterpolation_i;
