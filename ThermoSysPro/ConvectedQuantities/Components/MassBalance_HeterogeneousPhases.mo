within ThermoSysPro.ConvectedQuantities.Components;
block MassBalance_HeterogeneousPhases
  extends ThermoSysPro.ConvectedQuantities.Components.MassBalance_Biphasic;
  import      ThermoSysPro.Units.SI;

  parameter Integer n_out_gas = 1 "Number of outlets";
  parameter Integer n_out_liq = 1 "Number of outlets";
  input SI.MassFlowRate Qout_gas[n_out_gas];
  input SI.MassFlowRate Qout_liq[n_out_liq];

  output ThermoSysPro.ConvectedQuantities.Components.MixtureConnector
    mix_out_liq[n_out_liq](redeclare package Species = Species) annotation (
      Placement(transformation(extent={{30,-52},{50,-32}}), iconTransformation(
          extent={{30,-52},{50,-32}})));
  output ThermoSysPro.ConvectedQuantities.Components.MixtureConnector
    mix_out_gas[n_out_gas](redeclare package Species = Species) annotation (
      Placement(transformation(extent={{30,32},{50,52}}), iconTransformation(
          extent={{30,32},{50,52}})));

equation
    out_Tflow_gas = sum(Qout_gas);
    out_Tflow_liq = sum(Qout_liq);

    for i in 1:n_out_liq loop
       mix_out_liq[i].SubC = phasesSeparation.Cl;
    end for;
    for i in 1:n_out_gas loop
      mix_out_gas[i].SubC = phasesSeparation.Cg;
    end for;

end MassBalance_HeterogeneousPhases;
