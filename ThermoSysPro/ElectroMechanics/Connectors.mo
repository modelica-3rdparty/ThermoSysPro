within ThermoSysPro.ElectroMechanics;

package Connectors "Connectors"
  extends ThermoSysPro.UsersGuide.Documentation.ThermoSysProPackageIcon;
  connector MechanichalTorque "Mechanical torque"
    Units.SI.Torque Ctr "Torque";
    Units.SI.AngularVelocity w "Angular velocity";
    annotation(
      Window(x = 0.25, y = 0.14, width = 0.6, height = 0.6),
      Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics),
      Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics = {Polygon(points = {{-100, 60}, {0, 60}, {100, 0}, {0, -60}, {-100, -60}, {-100, 60}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid)}),
      Documentation(info = "
## Copyright © EDF 2002 - 2026  


## ThermoSysPro Version 4.2  

      ", revisions = "
Author  

Daniel Bouskela   

      "));
  end MechanichalTorque;
  annotation(Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

    "));
end Connectors;