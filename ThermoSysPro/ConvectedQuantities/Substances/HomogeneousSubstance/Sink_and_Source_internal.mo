within ThermoSysPro.ConvectedQuantities.Substances.HomogeneousSubstance;
block Sink_and_Source_internal
  import      ThermoSysPro.Units.SI;

  input Real SubC[Concentrations] "Total Species Concentrations";
  input SI.Temperature T "Température";
  output Real C[Concentrations];

equation
  C = SubC;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
      coordinateSystem(preserveAspectRatio=false)));
end Sink_and_Source_internal;
