within ThermoSysPro.InstrumentationAndControl;

package Connectors "Connectors"
  extends ThermoSysPro.UsersGuide.Documentation.ThermoSysProPackageIcon;
  connector InputDateAndTime
    input ThermoSysPro.InstrumentationAndControl.Common.DateEtHeure signal;
    annotation(
      Window(x = 0.37, y = 0.02, width = 0.49, height = 0.65),
      Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-1, -1}, {1, 1}}, grid = {2, 2}), graphics = {Polygon(points = {{-1, 1}, {1, 0}, {-1, -1}, {-1, 1}}, lineColor = {0, 0, 255}, fillColor = {0, 0, 0}, fillPattern = FillPattern.Solid)}),
      Documentation(info = "
Version 1.0  

## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
  end InputDateAndTime;

  connector OutputDateAndTime
    output ThermoSysPro.InstrumentationAndControl.Common.DateEtHeure signal;
    annotation(
      Window(x = 0.29, y = 0.11, width = 0.6, height = 0.6),
      Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-1, -1}, {1, 1}}, grid = {2, 2}), graphics = {Polygon(points = {{-1, 1}, {1, 0}, {-1, -1}, {-1, 1}}, lineColor = {0, 0, 255}, fillColor = {192, 192, 192}, fillPattern = FillPattern.Solid)}),
      Documentation(info = "
Version 1.0  

## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
  end OutputDateAndTime;

  connector InputReal
    input Real signal;
    annotation(
      Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics),
      Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics = {Polygon(points = {{-100, 100}, {-100, -100}, {100, 0}, {-100, 100}}, lineColor = {0, 0, 255}, fillColor = {0, 127, 255}, fillPattern = FillPattern.Solid)}),
      Window(x = 0.34, y = 0.2, width = 0.6, height = 0.6),
      Documentation(info = "
Version 1.0  

## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
  end InputReal;

  connector InputLogical
    input Boolean signal;
    annotation(
      Window(x = 0.37, y = 0.02, width = 0.49, height = 0.65),
      Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics = {Polygon(points = {{-100, 100}, {-100, -100}, {100, 0}, {-100, 100}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid)}),
      Documentation(info = "
Version 1.0  

## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
  end InputLogical;

  connector InputInteger
    input Integer signal;
    annotation(
      Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics),
      Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics = {Polygon(points = {{-100, 100}, {-100, -100}, {100, 0}, {-100, 100}}, lineColor = {0, 0, 255}, fillColor = {255, 0, 255}, fillPattern = FillPattern.Solid)}),
      Window(x = 0.34, y = 0.2, width = 0.6, height = 0.6),
      Documentation(info = "
Version 1.6  

## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
  end InputInteger;

  connector OutputInteger
    output Integer signal;
    annotation(
      Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics = {Polygon(points = {{-100, 100}, {-100, -100}, {100, 0}, {-100, 100}}, lineColor = {0, 0, 255}, fillColor = {255, 0, 128}, fillPattern = FillPattern.Solid)}),
      Window(x = 0.34, y = 0.18, width = 0.6, height = 0.6),
      Documentation(info = "
Version 1.6  

## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
  end OutputInteger;

  connector OutputLogical
    output Boolean signal;
    annotation(
      Window(x = 0.29, y = 0.11, width = 0.6, height = 0.6),
      Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics = {Polygon(points = {{-100, 100}, {-100, -100}, {100, 0}, {-100, 100}}, lineColor = {0, 0, 255}, fillColor = {127, 255, 0}, fillPattern = FillPattern.Solid)}),
      Documentation(info = "
Version 1.0  

## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
  end OutputLogical;

  connector OutputReal
    output Real signal;
    annotation(
      Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics = {Polygon(points = {{-100, 100}, {-100, -100}, {100, 0}, {-100, 100}}, lineColor = {0, 0, 255}, fillColor = {0, 255, 255}, fillPattern = FillPattern.Solid)}),
      Window(x = 0.34, y = 0.18, width = 0.6, height = 0.6),
      Documentation(info = "
Version 1.0  

## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

      "));
  end OutputReal;
  annotation(Window(x = 0.05, y = 0.26, width = 0.25, height = 0.25, library = 1, autolayout = 1), Documentation(info = "
Version 1.0  

## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

    "));
end Connectors;