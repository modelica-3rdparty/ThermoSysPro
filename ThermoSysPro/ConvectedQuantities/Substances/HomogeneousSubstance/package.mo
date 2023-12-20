within ThermoSysPro.ConvectedQuantities.Substances;
package HomogeneousSubstance "Substance with homogeneous distribution in gas and liquid phases"
  extends ChimiScope.None(redeclare type Concentrations = enumeration(
      substance                                                      "Gas/Liquid homogeneous substance"),
        redeclare block PhasesSeparation = PhasesSeparation_internal,
        redeclare block pH = pH_internal,
        redeclare block Sink_and_Source=Sink_and_Source_internal);

end HomogeneousSubstance;
