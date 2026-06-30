within ThermoSysPro.Functions;

function TableSplineInterpolation "Table spline interpolation"
  input Real TabP[:] "1st reference table";
  input Real TabX[:] "2nd reference table";
  input Real TabY[:, :] "Results table";
  input Real P "1st reference value";
  input Real X "2nd reference value";
  input Real t = 0.5 "Stiffness parameter";
  output Real Y "Interpolated result";
protected
  Integer dimP = size(TabP, 1) "TabP dimension";
  Integer dimX = size(TabX, 1) "TabX dimension";
  Integer dimY1 = size(TabY, 1) "TabY 1st dimension";
  Integer dimY2 = size(TabY, 2) "TabY 2nd dimension";
  Integer IndP = 0 "Reference index";
  Boolean IndPcal "Computed index";
  Real Y1;
  Real Y0;
  Real Y2;
algorithm
  if ((dimX <> dimY2) or (dimP <> dimY1)) then
    assert(false, "TableLinearInterpolation: the dimensions of the tables are different");
  end if;
  IndPcal := false;
  for i in 2:dimP loop
    if ((P <= TabP[i]) and (not IndPcal)) then
      IndP := i;
      IndPcal := true;
    end if;
  end for;
// If P is not contained in the table:
  if (not IndPcal) then
    IndP := dimP;
    if integer(P) <= 2 then
      IndP := 2;
    end if;
  end if;
// Find corresponding table for IndP (p1, p2)
  Y1 := ThermoSysPro.Functions.SplineInterpolation(TabX = TabX, TabY = TabY[IndP - 1, :], X = X, t = t);
  Y2 := ThermoSysPro.Functions.SplineInterpolation(TabX = TabX, TabY = TabY[IndP, :], X = X, t = t);
// If possible to use three points (p0,p1,p2):
  if ((IndP > 2) and IndPcal) then
    Y0 := ThermoSysPro.Functions.SplineInterpolation(TabX = TabX, TabY = TabY[IndP - 2, :], X = X, t = t);
    Y := ThermoSysPro.Functions.SplineInterpolation(TabX = TabP[IndP - 2:IndP], TabY = {Y0, Y1, Y2}, X = P, t = t);
  else
    Y := ThermoSysPro.Functions.SplineInterpolation(TabX = TabP[IndP - 1:IndP], TabY = {Y1, Y2}, X = P, t = t);
  end if;
  annotation(
    smoothOrder = 2,
    Icon(graphics),
    Documentation(info = "
## Copyright © EDF 2002 - 2026  
## ThermoSysPro Version 4.2  
Computes 2-dimensional spline interpolation based on function SplineInterpolation. The resulting 2-dimensional spline will be continuous and have continuous first derivatives.   
Implementation  
It uses a cardinal spline interpolation algorithm. Cardinal splines are a sub-set of cubic Hermite splines where each piece is a third-degree polynomial specified in Hermite form: i.e specified by its values and the first derivatives at the end points of the reference interval.  
The derivatives are calculated based on the non-uniform cardinal grid approach, see function SplineInterpolation for futher details.  
Inputs  

TabP: vecor containing p-table values  
TabX: Vector containing x-table values  
TabY: Vector containing y-table values  
P: The p-value that the spline should be evaluated at  
X: The x-value that the spline should be evaluated at  
t: Cardinal spline shape parameter. t = 0.5 is default and is generally a good choice. A value close to 1 will yield a stiff spline, t=0 corresponds to a Catmull-Rom spline and  t < 0 corresponds to a more “loose” spline. From testing, t=0.5  seems to be a good choice in general and is therefore chosen as a default value. A value of t = 1 corresponds to that the derivative in all data points is zero, which may result in strange curves . See Examples > TestSplineInterpolation for a demonstration.  

Output  

Y: Interpolated value evaluated at P,X  

Extrapolation  
Linear extrapolation is employed if the reference value is not contained in the reference value table.  
Example  

TabX = {1,2,3,4};  
TabP = {1,2,3,4};  
TabY =  [2,2,2,2;2,2,1,2;2,2,2,2;1,2,1,2];   

TabY respresents the value table, and TabX and TabP represent the reference tables.  
The example was called for X = linspace(0,0.1,5) and P = linspace(0.1,0.1,4)  
The black dots represent the data points, and the red lines represent the interpolation result.  

References  
http://people.cs.clemson.edu/~dhouse/courses/405/notes/splines.pdf  
    ", revisions = "
    "));
end TableSplineInterpolation;