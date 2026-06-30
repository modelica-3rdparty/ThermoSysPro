within ThermoSysPro.Combustion;

package Connectors "Connectors"
  extends ThermoSysPro.UsersGuide.Documentation.ThermoSysProPackageIcon;
  connector FuelInlet "Fuel inlet connector"
    Units.SI.MassFlowRate Q "Fuel mass flow rate";
    Units.SI.Temperature T "Fuel temperature";
    Units.SI.AbsolutePressure P "Fuel pressure";
    Units.SI.SpecificEnergy LHV "Lower heating value";
    Units.SI.SpecificHeatCapacity cp "Fuel specific heat capacity at 273.15 K";
    Real hum "Fuel humidity (%)";
    Real Xc "C mass fraction";
    Real Xh "H mass fraction";
    Real Xo "O mass fraction";
    Real Xn "N mass fraction";
    Real Xs "S mass fraction";
    Real Xashes "Ashes mass fraction";
    Real VolM "Percentage of volatile matter";
    Units.SI.Density rho "Fuel density";
    input Boolean a = true "Pseudo-variable for the verification of the connection orientation";
    output Boolean b "Pseudo-variable for the verification of the connection orientation";
    annotation(
      Icon(graphics = {Rectangle(extent = {{-100, -100}, {100, 100}}, lineColor = {0, 0, 0}, fillPattern = FillPattern.VerticalCylinder, fillColor = {0, 0, 0}), Ellipse(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 0}, fillPattern = FillPattern.Sphere, fillColor = {0, 128, 255})}),
      Documentation(info = "
## Copyright © EDF 2002 - 2026  


## ThermoSysPro Version 4.2  

      "));
  end FuelInlet;

  connector FuelOutlet "Fuel outlet connector"
    Units.SI.MassFlowRate Q "Fuel mass flow rate";
    Units.SI.Temperature T "Fuel temperature";
    Units.SI.AbsolutePressure P "Fuel pressure";
    Units.SI.SpecificEnergy LHV "Lower heating value";
    Units.SI.SpecificHeatCapacity cp "Fuel specific heat capacity at 273.15 K";
    Real hum "Fuel humidity (%)";
    Real Xc "C mass fraction";
    Real Xh "H mass fraction";
    Real Xo "O mass fraction";
    Real Xn "N mass fraction";
    Real Xs "S mass fraction";
    Real Xashes "Ashes mass fraction";
    Real VolM "Percentage of volatile matter";
    Units.SI.Density rho "Fuel density";
    output Boolean a "Pseudo-variable for the verification of the connection orientation";
    input Boolean b = true "Pseudo-variable for the verification of the connection orientation";
    annotation(
      Icon(graphics = {Rectangle(extent = {{-100, -100}, {100, 100}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0}, fillPattern = FillPattern.Forward), Ellipse(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 0}, fillPattern = FillPattern.Sphere, fillColor = {255, 0, 0})}),
      Documentation(info = "
## Copyright © EDF 2002 - 2026  


## ThermoSysPro Version 4.2  

      "));
  end FuelOutlet;

  connector FuelInletI "Internal fuel inlet connector"
    Units.SI.MassFlowRate Q "Fuel mass flow rate";
    Units.SI.Temperature T "Fuel temperature";
    Units.SI.AbsolutePressure P "Fuel pressure";
    Units.SI.SpecificEnergy LHV "Lower heating value";
    Units.SI.SpecificHeatCapacity cp "Fuel specific heat capacity at 273.15 K";
    Real hum "Fuel humidity (%)";
    Real Xc "C mass fraction";
    Real Xh "H mass fraction";
    Real Xo "O mass fraction";
    Real Xn "N mass fraction";
    Real Xs "S mass fraction";
    Real Xashes "Ashes mass fraction";
    Real VolM "Percentage of volatile matter";
    Units.SI.Density rho "Fuel density";
    input Boolean a "Pseudo-variable for the verification of the connection orientation";
    output Boolean b "Pseudo-variable for the verification of the connection orientation";
    annotation(
      Icon(graphics = {Rectangle(extent = {{-100, -100}, {100, 100}}, lineColor = {0, 0, 0}, fillPattern = FillPattern.VerticalCylinder, fillColor = {0, 0, 0}), Ellipse(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 255}, fillColor = {0, 128, 255}, fillPattern = FillPattern.Backward)}),
      Documentation(info = "
## Copyright © EDF 2002 - 2026  


## ThermoSysPro Version 4.2  

      "));
  end FuelInletI;

  connector FuelOutletI "Internal fuel outlet connector"
    Units.SI.MassFlowRate Q "Fuel mass flow rate";
    Units.SI.Temperature T "Fuel temperature";
    Units.SI.AbsolutePressure P "Fuel pressure";
    Units.SI.SpecificEnergy LHV "Lower heating value";
    Units.SI.SpecificHeatCapacity cp "Fuel specific heat capacity at 273.15 K";
    Real hum "Fuel humidity (%)";
    Real Xc "C mass fraction";
    Real Xh "H mass fraction";
    Real Xo "O mass fraction";
    Real Xn "N mass fraction";
    Real Xs "S mass fraction";
    Real Xashes "Ashes mass fraction";
    Real VolM "Percentage of volatile matter";
    Units.SI.Density rho "Fuel density";
    output Boolean a "Pseudo-variable for the verification of the connection orientation";
    input Boolean b "Pseudo-variable for the verification of the connection orientation";
    annotation(
      Icon(graphics = {Rectangle(extent = {{-100, -100}, {100, 100}}, lineColor = {0, 0, 0}, fillPattern = FillPattern.VerticalCylinder, fillColor = {0, 0, 0}), Ellipse(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 255}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Backward)}),
      Documentation(info = "
## Copyright © EDF 2002 - 2026  


## ThermoSysPro Version 4.2  

      "));
  end FuelOutletI;
  annotation(Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

    "));
end Connectors;