within ThermoSysPro.InstrumentationAndControl.Blocks;

package Commun
  extends ThermoSysPro.UsersGuide.Documentation.ThermoSysProPackageIcon;
  function rand "rand"
    output Integer y;
  
    external "C" y = rand(0);
    annotation(
      Window(x = 0.45, y = 0.01, width = 0.35, height = 0.49),
      Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics = {Text(extent = {{-84, 18}, {84, -30}}, lineColor = {255, 127, 0}, textString = "fonction"), Text(extent = {{-134, 104}, {142, 44}}, textString = "%name"), Ellipse(extent = {{-100, 40}, {100, -100}}, lineColor = {255, 127, 0}), Text(extent = {{-82, -22}, {86, -70}}, lineColor = {255, 127, 0}, textString = "externe")}),
      Documentation(info = "
Version 1.0  

## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
  end rand;

  function srand "rand"
    input Integer u;
  
    external "C" srand(u);
    annotation(
      Window(x = 0.26, y = 0.28, width = 0.6, height = 0.6),
      Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics = {Text(extent = {{-134, 104}, {142, 44}}, textString = "%name"), Ellipse(extent = {{-100, 40}, {100, -100}}, lineColor = {255, 127, 0}), Text(extent = {{-84, 18}, {84, -30}}, lineColor = {255, 127, 0}, textString = "fonction"), Text(extent = {{-82, -22}, {86, -70}}, lineColor = {255, 127, 0}, textString = "externe")}),
      Documentation(info = "
Version 1.0  

## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
  end srand;

  function fmod "fmod"
    input Real u1;
    input Real u2;
    output Real y;
  
    external "C" y = fmod(u1, u2);
    annotation(
      Icon(graphics = {Text(extent = {{-134, 104}, {142, 44}}, textString = "%name"), Ellipse(extent = {{-100, 40}, {100, -100}}, lineColor = {255, 127, 0}), Text(extent = {{-84, 18}, {84, -30}}, lineColor = {255, 127, 0}, textString = "fonction"), Text(extent = {{-82, -22}, {86, -70}}, lineColor = {255, 127, 0}, textString = "externe")}),
      Documentation(info = "
Version 1.6  

## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
  end fmod;
  annotation(Window(x = 0.05, y = 0.26, width = 0.25, height = 0.25, library = 1, autolayout = 1),
    Documentation(info = "
Version 1.1  

## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

    "));
end Commun;