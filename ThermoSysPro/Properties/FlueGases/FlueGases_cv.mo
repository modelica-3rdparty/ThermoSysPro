within ThermoSysPro.Properties.FlueGases;

function FlueGases_cv "Specific heat capacity at constant volume"
  input Units.SI.AbsolutePressure PMF "Flue gases average pressure";
  input Units.SI.Temperature TMF "Flue gases average temperature";
  input Real Xco2 "CO2 mass fraction";
  input Real Xh2o "H2O mass fraction";
  input Real Xo2 "O2 mass fraction";
  input Real Xso2 "SO2 mass fraction";
  output Units.SI.SpecificHeatCapacity cv "Specific heat capacity at constant volume";
protected
  ThermoSysPro.Properties.ModelicaMediaFlueGases.ThermodynamicState state;
algorithm
  state := ThermoSysPro.Properties.ModelicaMediaFlueGases.setState_pTX(PMF, TMF, {1 - (Xo2 + Xh2o + Xco2 + Xso2), Xo2, Xh2o, Xco2, Xso2});
  cv := ThermoSysPro.Properties.ModelicaMediaFlueGases.specificHeatCapacityCv(state);
  annotation(
    smoothOrder = 2,
    Icon(graphics = {Text(extent = {{-136, 102}, {140, 42}}, textString = "%name"), Ellipse(extent = {{-100, 40}, {100, -100}}, lineColor = {255, 127, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Text(extent = {{-84, -4}, {84, -52}}, lineColor = {255, 127, 0}, textString = "function")}),
    Documentation(info = "
## Copyright © EDF 2002 - 2026  


## ThermoSysPro Version 4.2  

    "));
end FlueGases_cv;