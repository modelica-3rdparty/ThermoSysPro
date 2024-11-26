within ThermoSysPro.Functions.Utilities;
function scalarToColor_validityRange
  "Map a scalar to a color using a color map. colorMap used between T_min and T_nominal. Reversed colorMap is used between T_nominal and T_max"
  extends Modelica.Icons.Function;

input Real T "Scalar value" annotation(Dialog);
input Real T_nominal "Nominal value, if T<Tnominal is mapped with colorMap, T>T_nominal is mapped with reversed colorMap" annotation(Dialog);
input Real T_min "T <= T_min is mapped to colorMap[1,:]" annotation(Dialog);
input Real T_max "T >= T_max is mapped to colorMap[end,:]" annotation(Dialog);
input Real colorMap[:,3] "Color map" annotation(Dialog);
output Real color[3] "Color of scalar value T";

protected
Real eps=max(abs(T_min),abs(T_max));

algorithm
  /*Had to add 1e-7 and not Modelica.Constants.eps because otherwise a pulse would appear at the time where T=T_min or T_max (in the case where a ramp for T finishes at T_min or T_max*/
  color := noEvent(
  if (T < T_min-eps*1e-10 or T > T_max+eps*1e-10) then
      {138, 43, 226}
    elseif T_nominal == T_max then
      colorMap[1 + integer((size(colorMap, 1) - 1) * (max(T_min, min(T, T_nominal)) - T_min) / (T_nominal - T_min)), :]
    elseif T_nominal == T_min then
      colorMap[1 + integer((size(colorMap, 1) - 1) * (1 - (max(T_nominal, min(T, T_max)) - T_nominal) / (T_max - T_nominal))), :]
    elseif T < T_nominal then
      colorMap[1 + integer((size(colorMap, 1) - 1) * (max(T_min, min(T, T_nominal)) - T_min) / (T_nominal - T_min)), :]
    elseif T >= T_nominal then
      colorMap[1 + integer((size(colorMap, 1) - 1) * (1 - (max(T_nominal, min(T, T_max)) - T_nominal) / (T_max - T_nominal))), :]
    else
      {100, 100, 100});
  //     if (T < T_min-1e-8 or T > T_max+1e-8) then

  annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
//Real T, T_min, T_max, colorMap[:,3];
Colors.<strong>scalarToColor</strong>(T, T_min, T_max, colorMap);
</pre></blockquote>
<h4>Description</h4>
<p>
This function returns an rgb color Real[3] that corresponds to the value of \"T\".
The color is selected from the colorMap by interpolation so that
\"T_min\" corresponds to \"colorMap[1,:]\" and
\"T_max\" corresponds to \"colorMap[end,:]\".
</p>

<h4>See also</h4>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps\">ColorMaps</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Colors.colorMapToSvg\">colorMapToSvg</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.PipeWithScalarField\">PipeWithScalarField</a>.

</html>"));
end scalarToColor_validityRange;
