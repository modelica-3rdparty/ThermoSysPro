within ThermoSysPro.ConvectedQuantities.Components;
block MassBalance_mixedphases
  extends ThermoSysPro.ConvectedQuantities.Components.MassBalance_Biphasic;

  import      ThermoSysPro.Units.SI;
  parameter Integer n_out_mixed = 1 "Number of outlets";
  input SI.MassFlowRate Qout[n_out_mixed];
  output ThermoSysPro.ConvectedQuantities.Components.MixtureConnector
    mix_out_mixed[n_out_mixed](redeclare package Species = Species)
    annotation (Placement(transformation(extent={{50,-10},{70,10}})));

equation
  out_Tflow_gas=sum(x*Qout);
  out_Tflow_liq=sum((1-x)*Qout);

  for i in 1:n_out_mixed loop
    mix_out_mixed[i].SubC = InternalConcentrations;
  end for;

end MassBalance_mixedphases;
