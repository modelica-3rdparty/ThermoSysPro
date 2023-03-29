within ThermoSysPro.ConvectedQuantities.Components;
connector MixtureConnector

  replaceable package Species =
      Substances.None;

  Real SubC[Species.Concentrations];
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end MixtureConnector;
