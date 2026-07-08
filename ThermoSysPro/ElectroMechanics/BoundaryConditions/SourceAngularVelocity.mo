within ThermoSysPro.ElectroMechanics.BoundaryConditions;

model SourceAngularVelocity "Angular velocity source"
  parameter ThermoSysPro.Units.nonSI.AngularVelocity_rpm N0 = 1400;
  Units.SI.AngularVelocity w "Angular velocity";
  ThermoSysPro.ElectroMechanics.Connectors.MechanichalTorque M annotation(
    Placement(transformation(origin = {110, 0}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal IAngularVelocity annotation(
    Placement(transformation(extent = {{-60, -10}, {-40, 10}}, rotation = 0)));
protected
  constant Real pi = Modelica.Constants.pi "pi";
equation
  if (cardinality(IAngularVelocity) == 0) then
    IAngularVelocity.signal = N0;
  end if;
  w = pi/30*IAngularVelocity.signal;
  M.w = w;
  annotation(
    Diagram(graphics = {Rectangle(extent = {{-40, 40}, {40, -40}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid), Text(extent = {{-20, 20}, {20, -20}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid, textString = "V"), Line(points = {{40, 0}, {100, 0}}, color = {0, 0, 255}), Line(points = {{100, 0}, {80, -20}}, color = {0, 0, 255}), Line(points = {{100, 0}, {80, 20}}, color = {0, 0, 255})}),
    Icon(graphics = {Rectangle(extent = {{-40, 40}, {40, -40}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid), Text(extent = {{-20, 20}, {20, -20}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid, textString = "V"), Line(points = {{40, 0}, {100, 0}}, color = {0, 0, 255}), Line(points = {{100, 0}, {80, -20}}, color = {0, 0, 255}), Line(points = {{100, 0}, {80, 20}}, color = {0, 0, 255})}),
    Documentation(info = "
## Copyright © EDF 2002 - 2026   
## ThermoSysPro Version 4.2  
    ", revisions = "
Authors   

Baligh El Hefni  
Daniel Bouskela   

    "));
end SourceAngularVelocity;