within ThermoSysPro.ConvectedQuantities.Components;
partial model partialSaS

  import      ThermoSysPro.Units.SI;

  input Real SubC[:] "Total Species Concentrations";
  input SI.Temperature T "Température";
  input SI.MassFlowRate Q "Débit";
  input Real capa "Capacité totale de la résine";
  input SI.Area S "Surface de la résine";
  input SI.Density rho_liquidPhase "Liquid Phase Density";
  //input Real x "Title";

  parameter Integer choix_resine=1;
  //parameter SI.Length D=1;
  parameter SI.Length L=1;

  output Real SatRes[size(SubC,1)];
  output Real C[size(SubC,1)];



  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end partialSaS;
