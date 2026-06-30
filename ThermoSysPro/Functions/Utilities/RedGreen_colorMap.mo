within ThermoSysPro.Functions.Utilities;

function RedGreen_colorMap "Returns the \"RedGreen\" color map"
  extends Modelica.Mechanics.MultiBody.Interfaces.partialColorMap;
algorithm
  if n_colors > 1 then
    colorMap := [linspace(162., 254., integer(ceil(n_colors/2))), linspace(0, 254., integer(ceil(n_colors/2))), linspace(30., 189., integer(ceil(n_colors/2))); linspace(254., 0, integer(floor(n_colors/2))), linspace(254., 93., integer(floor(n_colors/2))), linspace(189., 40., integer(floor(n_colors/2)))];
  else
    colorMap := 255*[1, 0, 1];
  end if;
  annotation(
    Documentation(info = "
Syntax  

ColorMaps.RedGreen();  
ColorMaps.RedGreen(n_colors=64);  

Description  

This function returns the color map \"RedGreen.\" A color map  
is a Real[:,3] array where every row represents a color.  
With the optional argument \"n_colors\" the number of rows  
of the returned array can be defined. The default value is  
\"n_colors=64\" (it is usually best if n_colors is a multiple of 4).  
Image of the \"RedGreen\" color map:  




See also  
ColorMaps,  
colorMapToSvg,  
scalarToColor.  
## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

    "));
end RedGreen_colorMap;