within ThermoSysPro.Functions.Utilities;
function RedGreen_colorMap "Returns the \"RedGreen\" color map"
extends Modelica.Mechanics.MultiBody.Interfaces.partialColorMap;
algorithm
  if n_colors > 1 then
     colorMap := [linspace(162.,254.,integer(ceil(n_colors/2))),linspace(0,254.,integer(ceil(n_colors/2))),linspace(30.,189.,integer(ceil(n_colors/2)));
                     linspace(254.,0,integer(floor(n_colors/2))),linspace(254.,93.,integer(floor(n_colors/2))),linspace(189.,40.,integer(floor(n_colors/2)))];
   else
    colorMap:=255*[1,0,1];
   end if;

  annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
ColorMaps.<strong>RedGreen</strong>();
ColorMaps.<strong>RedGreen</strong>(n_colors=64);
</pre></blockquote>
<h4>Description</h4>
<p>
This function returns the color map \"RedGreen.\" A color map
is a Real[:,3] array where every row represents a color.
With the optional argument \"n_colors\" the number of rows
of the returned array can be defined. The default value is
\"n_colors=64\" (it is usually best if n_colors is a multiple of 4).
Image of the \"RedGreen\" color map:
</p>

<blockquote>
<img src=\"modelica:modelica://ThermoSysPro/InstrumentationAndControl/Blocks/Sources/colorMap_RedGreen.png\">
</blockquote>

<h4>See also</h4>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps\">ColorMaps</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Colors.colorMapToSvg\">colorMapToSvg</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Colors.scalarToColor\">scalarToColor</a>.
</html>"));
end RedGreen_colorMap;
